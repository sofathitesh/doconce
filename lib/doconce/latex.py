# -*- coding: iso-8859-15 -*-

import os, commands, re, sys, glob
from common import plain_exercise, table_analysis, \
     _CODE_BLOCK, _MATH_BLOCK, doconce_exercise_output, indent_lines, \
     python_online_tutor, envir_delimiter_lines, safe_join, \
     insert_code_and_tex
from misc import option
additional_packages = ''  # comma-sep. list of packages for \usepackage{}

include_numbering_of_exercises = True

def underscore_in_code(m):
    """For pattern r'\\code\{(.*?)\}', insert \_ for _ in group 1."""
    text = m.group(1)
    text = text.replace('_', r'\_')
    return r'\code{%s}' % text

def latex_code(filestr, code_blocks, code_block_types,
               tex_blocks, format):

    if option('latex_double_hyphen'):
        print '*** warning: --latex_double_hyphen may lead to unwanted edits.'
        print '             search for all -- in the .p.tex file and check.'
        # Replace - by -- in some cases for nicer LaTeX look of hyphens:
        # Note: really dangerous for inline mathematics: $kx-wt$.
        from_to = [
            # equation refs
            (r'(\(ref\{.+?\}\))-(\(ref\{.+?\}\))', r'\g<1>--\g<2>'),
            # like Navier-Stokes, but not `Q-1`
            (r'([^$`\\/{!][A-Za-z]{2,})-([^\\/{][A-Za-z]{2,}[^`$/}])', r'\g<1>--\g<2>'),
            # single - at end of line
            (r' +-$', ' --'),
            # single - at beginning of line
            (r'^ *- +', ' -- '),
                   ]
        for pattern, replacement in from_to:
            filestr = re.sub(pattern, replacement, filestr, flags=re.MULTILINE)


    # References to external documents (done before !bc blocks in
    # case such blocks explain the syntax of the external doc. feature)
    pattern = r'^%\s*[Ee]xternaldocuments?:\s*(.+)$'
    m = re.search(pattern, filestr, re.MULTILINE)
    #filestr = re.sub(pattern, '', filestr, flags=re.MULTILINE)
    if m:
        commands = [r'\externaldocument{%s}' % name.strip()
                    for name in m.group(1).split(',')]
        new_text = r"""

%% References to labels in external documents:
\usepackage{xr}
%s

%% insert custom LaTeX commands...
""" % ('\n'.join(commands))
        filestr = filestr.replace('% insert custom LaTeX commands...', new_text)

    # labels inside tex envirs must have backslash \label:
    for i in range(len(tex_blocks)):
        tex_blocks[i] = re.sub(r'([^\\])label', r'\g<1>\\label',
                               tex_blocks[i])

    lines = filestr.splitlines()
    # Add Python Online Tutor URL before code blocks with pyoptpro code
    for i in range(len(lines)):
        if _CODE_BLOCK in lines[i]:
            words = lines[i].split()
            n = int(words[0])
            if len(words) >= 3 and words[2] == 'pyoptpro' and \
                       not option('device=', '') == 'paper':
                # Insert an Online Python Tutorial link and add to lines[i]
                post = '\n\\noindent\n(\\href{{%s}}{Visualize execution}) ' % \
                       python_online_tutor(code_blocks[n], return_tp='url')
                lines[i] = lines[i].replace(' pyoptpro', ' pypro') + post + '\n'

    filestr = safe_join(lines, '\n')
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)

    lines = filestr.splitlines()
    current_code_envir = None
    for i in range(len(lines)):
        if lines[i].startswith('!bc'):
            words = lines[i].split()
            if len(words) == 1:
                current_code_envir = 'ccq'
            else:
                if words[1] == 'pyoptpro':
                    current_code_envir = 'pypro'
                else:
                    current_code_envir = words[1]
            if current_code_envir is None:
                # There should have been checks for this in doconce.py
                print '*** errror: mismatch between !bc and !ec, line', i
                sys.exit(1)
            lines[i] = '\\b' + current_code_envir
        if lines[i].startswith('!ec'):
            lines[i] = '\\e' + current_code_envir
            current_code_envir = None
    filestr = safe_join(lines, '\n')

    filestr = re.sub(r'^!bt\n', '', filestr, flags=re.MULTILINE)
    filestr = re.sub(r'!et\n', '', filestr)

    # Check for misspellings
    envirs = 'pro pypro cypro cpppro cpro fpro plpro shpro mpro cod pycod cycod cppcod ccod fcod plcod shcod mcod htmlcod htmlpro rstcod rstpro xmlcod xmlpro cppans pyans fans bashans swigans uflans sni dat dsni sys slin ipy rpy plin ver warn rule summ ccq cc ccl py pyoptpro'.split()
    for envir in code_block_types:
        if envir and envir not in envirs:
            print 'Warning: found "!bc %s", but %s is not a standard predefined ptex2tex environment' % (envir, envir)

    # --- Final fixes for latex format ---

    appendix_pattern = r'\\(chapter|section\*?)\{Appendix:\s+'
    filestr = re.sub(appendix_pattern,
                     '\n\n\\\\appendix\n\n' + r'\\\g<1>{', filestr,  # the first
                     count=1)
    filestr = re.sub(appendix_pattern, r'\\\g<1>{', filestr) # all others

    # Make sure exercises are surrounded by \begin{exercise} and
    # \end{exercise} with some exercise counter
    #comment_pattern = INLINE_TAGS_SUBST[format]['comment'] # only in doconce.py
    comment_pattern = '%% %s'
    pattern = comment_pattern % envir_delimiter_lines['exercise'][0] + '\n'
    replacement = pattern + r"""\begin{exercise}
\refstepcounter{exerno}
"""
    filestr = filestr.replace(pattern, replacement)
    pattern = comment_pattern % envir_delimiter_lines['exercise'][1] + '\n'
    replacement = r'\end{exercise}' + '\n' + pattern
    filestr = filestr.replace(pattern, replacement)

    if include_numbering_of_exercises:
        # Remove section numbers of exercise sections
        filestr = re.sub(r'section\{(Exercise|Problem|Project)( +[^}])',
                         r'section*{\g<1>\g<2>', filestr)

    # Fix % and # in link texts (-> \%, \# - % is otherwise a comment...)
    pattern = r'\\href\{\{(.+?)\}\}\{(.+?)\}'
    def subst(m):  # m is match object
        url = m.group(1).strip()
        text = m.group(2).strip()
        # fix % without backslash
        text = re.sub(r'([^\\])\%', r'\g<1>\\%', text)
        text = re.sub(r'([^\\])\#', r'\g<1>\\#', text)
        return '\\href{{%s}}{%s}' % (url, text)
    filestr = re.sub(pattern, subst, filestr)

    if option('device=', '') == 'paper':
        # Make adjustments for printed versions of the PDF document.
        # Fix links so that the complete URL is in a footnote
        def subst(m):  # m is match object
            url = m.group(1).strip()
            text = m.group(2).strip()
            #print 'url:', url, 'text:', text
            #if not ('ftp:' in text or 'http' in text or '\\nolinkurl{' in text):
            if not ('ftp:' in text or 'http' in text):
                # The link text does not display the URL so we include it
                # in a footnote (\nolinkurl{} indicates URL: "...")
                texttt_url = url.replace('_', '\\_').replace('#', '\\#').replace('%', '\\%')
                return '\\href{{%s}}{%s}' % (url, text) + \
                       '\\footnote{\\texttt{%s}}' % texttt_url
            else: # no substitution, URL is in the link text
                return '\\href{{%s}}{%s}' % (url, text)
        filestr = re.sub(pattern, subst, filestr)

    # Add movie15 package if the file has a movie
    if r'\includemovie[' in filestr:
        filestr = filestr.replace('usepackage{ptex2tex}', """\
usepackage{ptex2tex}
% #ifdef MOVIE15
\usepackage{movie15}
% #endif
""")
    # \code{} in section headings and paragraph needs a \protect
    cpattern = re.compile(r'^\s*(\\.*section\*?|\\paragraph)\{(.*)\}\s*$',
                         re.MULTILINE)
    headings = cpattern.findall(filestr)

    for tp, heading in headings:
        if '\\code{' in heading:
            new_heading = re.sub(r'\\code\{(.*?)\}', underscore_in_code,
                                 heading)
            new_heading = new_heading.replace(r'\code{', r'\protect\code{')
            # Fix double }} for code ending (\section{...\code{...}})
            new_heading = re.sub(r'code\{(.*?)\}$', r'code{\g<1>} ',
                                 new_heading)
            filestr = filestr.replace(r'%s{%s}' % (tp, heading),
                                      r'%s{%s}' % (tp, new_heading))

    return filestr

def latex_figure(m, includegraphics=True):
    filename = m.group('filename')
    basename  = os.path.basename(filename)
    stem, ext = os.path.splitext(basename)

    # Figure on the web?
    if filename.startswith('http'):
        this_dir = os.getcwd()
        figdir = 'downloaded_figures'
        if not os.path.isdir(figdir):
            os.mkdir(figdir)
        os.chdir(figdir)
        import urllib
        try:
            f = urllib.urlopen(filename)
            print 'downloading', filename, '.......'
        except IOError, e:
            print 'tried to download %s, but failure:' % filename, e
            print '*** error: cannot treat latex figure on the net (no connection or invalid URL)'
            sys.exit(1)
        file_content = f.read()
        f.close()
        if 'DOCTYPE html' in file_content:
            print '*** error: could not download', filename
            sys.exit(1)
        f = open(basename, 'w')
        f.write(file_content)
        f.close()
        filename = os.path.join(figdir, basename)
        os.chdir(this_dir)

    #root, ext = os.path.splitext(filename)
    # doconce.py ensures that images are transformed to .ps or .eps

    # note that label{...} are substituted by \label{...} (inline
    # label tag) so we write just label and not \label below:

    # fraction is 0.9/linewidth by default, but can be adjusted with
    # the fraction keyword
    frac = 0.9
    opts = m.group('options')
    if opts:
        info = [s.split('=') for s in opts.split()]
        for option, value in info:
            if option == 'frac':
                frac = float(value)
    if includegraphics:
        includeline = r'\centerline{\includegraphics[width=%s\linewidth]{%s}}' % (frac, filename)
    else:
        includeline = r'\centerline{\psfig{figure=%s,width=%s\linewidth}}' % (filename, frac)

    caption = m.group('caption').strip()
    m = re.search(r'label\{(.+?)\}', caption)
    if m:
        label = m.group(1).strip()
    else:
        label = ''

    # `verbatim_text` in backquotes is translated to \code{verbatim\_text}
    # which then becomes \Verb!verbatim\_text! when running ptex2tex or
    # doconce ptex2tex, but this command also needs a \protect inside a caption
    # (besides the escaped underscore).
    # (\Verb requires the fancyvrb package.)
    # Alternative: translate `verbatim_text` to {\rm\texttt{verbatim\_text}}.
    verbatim_handler = 'Verb'  # alternative: 'texttt'
    verbatim_text = re.findall(r'(`[^`]+?`)', caption)
    verbatim_text_new = []
    for words in verbatim_text:
        new_words = words
        if '_' in new_words:
            new_words = new_words.replace('_', r'\_')
        if verbatim_handler == 'Verb':
            new_words = '\\protect ' + new_words
        elif verbatim_handler == 'texttt':
            # Replace backquotes by {\rm\texttt{}}
            new_words = r'{\rm\texttt{' + new_words[1:-1] + '}}'
        # else: do nothing
        verbatim_text_new.append(new_words)
    for from_, to_ in zip(verbatim_text, verbatim_text_new):
        caption = caption.replace(from_, to_)
    if caption:
        result = r"""
\begin{figure}[ht]
  %s
  \caption{
  %s
  }
\end{figure}
%%\clearpage %% flush figures %s
""" % (includeline, caption, label)
    else:
        # drop caption and place figure inline
        result = r"""
\begin{center}  %% inline figure
  %s
\end{center}
""" % (includeline)
    return result

def latex_movie(m):
    from common import default_movie
    text = default_movie(m)
    filename = m.group('filename')
    caption = m.group('caption')

    # URL to HTML viewer file must have absolute path in \href
    html_viewer_file_pattern = r'Movie of files `.+` in URL:"(.+)"'
    m2 = re.search(html_viewer_file_pattern, text)
    if m2:
        html_viewer_file = m2.group(1)
        if os.path.isfile(html_viewer_file):
            html_viewer_file_abs = os.path.abspath(html_viewer_file)
            text = text.replace('URL:"%s"' % html_viewer_file,
                                'URL:"file://%s"' % html_viewer_file_abs)


    if ': play URL:' in text:
        # Drop default_movie, embed in PDF instead using the movie15 package
        text = r"""
\begin{figure}[ht]
\begin{center}

%% #ifdef MOVIE15
\includemovie[poster,
label=%(filename)s,
autoplay,
%%controls,
%%toolbar,
%% #ifdef EXTERNAL_MOVIE_VIEWER
externalviewer,
%% #endif
text={\small (Loading %(filename)s)},
repeat,
]{0.9\linewidth}{0.9\linewidth}{%(filename)s}    %% requires \usepackage{movie15}
%% #ifndef EXTERNAL_MOVIE_VIEWER
\movieref[rate=0.5]{%(filename)s}{Slower}
\movieref[rate=2]{%(filename)s}{Faster}
\movieref[default]{%(filename)s}{Normal}
\movieref[pause]{%(filename)s}{Play/Pause}
\movieref[stop]{%(filename)s}{Stop}
%% #else
\href{run:%(filename)s}{%(filename)s}
%% #endif

%% #else
\href{run:%(filename)s}{%(filename)s}

%% alternative: \movie command that comes with beamer
%% \movie[options]{%(filename)s}{%(filename)s}
%% #endif
\end{center}
\caption{%(caption)s}
\end{figure}
""" % {'filename': filename, 'caption': caption}
    return text

def latex_table(table):
    column_width = table_analysis(table['rows'])

    #ncolumns = max(len(row) for row in table['rows'])
    ncolumns = len(column_width)
    #import pprint; pprint.pprint(table)
    column_spec = table.get('columns_align', 'c'*ncolumns)
    column_spec = column_spec.replace('|', '')
    if len(column_spec) != ncolumns:  # (allow | separators)
        print 'Table has column alignment specification: %s, but %d columns' \
              % (column_spec, ncolumns)
        print 'Table with rows', table['rows']
        sys.exit(1)

    # we do not support | in headings alignments (could be fixed,
    # by making column_spec not a string but a list so the
    # right elements are picked in the zip-based loop)
    heading_spec = table.get('headings_align', 'c'*ncolumns)#.replace('|', '')
    if len(heading_spec) != ncolumns:
        print 'Table has headings alignment specification: %s, '\
              'but %d columns' % (heading_spec, ncolumns)
        print 'Table with rows', table['rows']
        sys.exit(1)

    s = '\n' + r'\begin{quote}\begin{tabular}{%s}' % column_spec + '\n'
    for i, row in enumerate(table['rows']):
        if row == ['horizontal rule']:
            s += r'\hline' + '\n'
        else:
            # check if this is a headline between two horizontal rules:
            if i == 1 and \
               table['rows'][i-1] == ['horizontal rule'] and \
               table['rows'][i+1] == ['horizontal rule']:
                headline = True
            else:
                headline = False

            if headline:
                # First fix verbatim inside multicolumn
                # (recall that doconce.py table preparations
                # translates `...` to \code{...})
                verbatim_pattern = r'code\{(.+?)\}'
                for i in range(len(row)):
                    m = re.search(verbatim_pattern, row[i])
                    if m:
                        #row[i] = re.sub(verbatim_pattern,
                        #                r'texttt{%s}' % m.group(1),
                        #                row[i])
                        # (\code translates to \Verb, which is allowed here)

                        row[i] = re.sub(r'\\code\{(.*?)\}', underscore_in_code,
                                        row[i])

                row = [r'\multicolumn{1}{%s}{ %s }' % (a, r) \
                       for r, a in zip(row, heading_spec)]
            else:
                row = [r.ljust(w) for r, w in zip(row, column_width)]

            s += ' & '.join(row) + ' \\\\\n'

    s += r'\end{tabular}\end{quote}' + '\n\n' + r'\noindent' + '\n'
    return s

def latex_title(m):
    title = m.group('subst')
    text = r"""

%% ----------------- title -------------------------
%% #if LATEX_HEADING == "traditional"

\title{%s}

%% #elif LATEX_HEADING == "titlepage"

\thispagestyle{empty}
\hbox{\ \ }
\vfill
\begin{center}
{\huge{\bfseries{
\begin{spacing}{1.25}
%s
\end{spacing}
}}}

%% #elif LATEX_HEADING == "Springer_collection"

\title*{%s}
%% Short version of title:
%%\titlerunning{...}

%% #else

\begin{center}
{\LARGE\bf
\begin{spacing}{1.25}
%s
\end{spacing}
}
\end{center}

%% #endif
""" % (title, title, title, title)
    return text

def latex_author(authors_and_institutions, auth2index,
                 inst2index, index2inst, auth2email):
    def email(author, prefix='', parenthesis=True):
        address = auth2email[author]
        if address is None:
            email_text = ''
        else:
            if parenthesis:
                lp, rp = '(', ')'
            else:
                lp, rp = '', ''
            address = address.replace('_', r'\_')
            name, place = address.split('@')
            #email_text = r'%s %s\texttt{%s} at \texttt{%s}%s' % (prefix, lp, name, place, rp)
            email_text = r'%s %s\texttt{%s@%s}%s' % \
                         (prefix, lp, name, place, rp)
        return email_text

    one_author_at_one_institution = False
    if len(auth2index) == 1:
        author = list(auth2index.keys())[0]
        if len(auth2index[author]) == 1:
            one_author_at_one_institution = True

    text = r"""

% ----------------- author(s) -------------------------
% #if LATEX_HEADING == "traditional"
\author{"""

    # Traditional latex heading
    author_command = []
    for a, i, e in authors_and_institutions:
        a_text = a
        e_text = email(a, prefix='Email:', parenthesis=False)
        if i is not None:
            a_text += r'\footnote{'
            if len(i) == 1:
                i_text = i[0]
            elif len(i) == 2:
                i_text = ' and '.join(i)
            else:
                i[-1] = 'and ' + i[-1]
                i_text = '; '.join(i)
            if e_text:
                a_text += e_text + '. ' + i_text
            else:
                a_text += i_text
            if not a_text.endswith('.'):
                a_text += '.'
            a_text += '}'
        else: # Just email
            if e_text:
                a_text += r'\footnote{%s.}' % e_text
        author_command.append(a_text)
    author_command = '\n\\and '.join(author_command)

    text += author_command + '}\n'

    text += r"""
% #elif LATEX_HEADING == "titlepage"
\vspace{1.3cm}
"""
    if one_author_at_one_institution:
        author = list(auth2index.keys())[0]
        email_text = email(author)
        text += r"""
{\Large\textsf{%s%s}}\\ [3mm]
""" % (author, email_text)
    else:
        for author in auth2index: # correct order of authors
            email_text = email(author)
            text += r"""
    {\Large\textsf{%s${}^{%s}$%s}}\\ [3mm]
    """ % (author, str(auth2index[author])[1:-1], email_text)
    text += r"""
\ \\ [2mm]
"""
    if one_author_at_one_institution:
        text += r"""
{\large\textsf{%s} \\ [1.5mm]}""" % (index2inst[1])
    else:
        for index in index2inst:
            text += r"""
{\large\textsf{${}^%d$%s} \\ [1.5mm]}""" % (index, index2inst[index])

    text += r"""
% #elif LATEX_HEADING == "Springer_collection"
"""
    text += r"""
\author{%s}
%% Short version of authors:
%%\authorrunning{...}
""" % (' and ' .join([author for author in auth2index]))

    text += r"\institute{"
    a_list = []
    for a, i, e in authors_and_institutions:
        s = a
        if i is not None:
            s += r'\at ' + ' and '.join(i)
        if e is not None:
            s += r'\email{%s}' % e
        a_list.append(s)
    text += r' \and '.join(a_list) + '}\n'

    text += r"""
% #else
"""
    if one_author_at_one_institution:
        author = list(auth2index.keys())[0]
        email_text = email(author)
        text += r"""
\begin{center}
{\bf %s%s}
\end{center}

""" % (author, email_text)
    else:
        for author in auth2index: # correct order of authors
            email_text = email(author)
            text += r"""
\begin{center}
{\bf %s${}^{%s}$%s} \\ [0mm]
\end{center}

""" % (author, str(auth2index[author])[1:-1], email_text)

    text += r'\begin{center}' + '\n' + '% List of all institutions:\n'
    if one_author_at_one_institution:
        text += r"""\centerline{{\small %s}}""" % \
                (index2inst[1]) + '\n'
    else:
        for index in index2inst:
            text += r"""\centerline{{\small ${}^%d$%s}}""" % \
                    (index, index2inst[index]) + '\n'

    text += r"""\end{center}
% #endif
% ----------------- end author(s) -------------------------

"""
    return text

def latex_ref_and_label(section_label2title, format, filestr):
    filestr = filestr.replace('label{', r'\label{')
    # add ~\ between chapter/section and the reference
    pattern = r'([Ss]ection|[Cc]hapter)(s?)\s+ref\{'  # no \[A-Za-z] pattern => no fix
    # recall \r is special character so it needs \\r
    # (could call fix_latex_command_regex for the replacement)
    replacement = r'\g<1>\g<2>~\\ref{'
    #filestr = re.sub(pattern, replacement, filestr, flags=re.IGNORECASE)
    cpattern = re.compile(pattern, flags=re.IGNORECASE)
    filestr = cpattern.sub(replacement, filestr)
    # range ref:
    filestr = re.sub(r'-ref\{', r'-\\ref{', filestr)
    # the rest of the ' ref{}' (single refs should have ~ in front):
    filestr = re.sub(r'\sref\{', r'~\\ref{', filestr)
    filestr = re.sub(r'\(ref\{', r'(\\ref{', filestr)

    # equations are ok in the doconce markup

    # perform a substitution of "LaTeX" (and ensure \LaTeX is not there):
    filestr = re.sub(fix_latex_command_regex(r'\LaTeX({})?',
                               application='match'), 'LaTeX', filestr)
    #filestr = re.sub('''([^"'`*_A-Za-z0-9-])LaTeX([^"'`*_A-Za-z0-9-])''',
    #                 r'\g<1>{\LaTeX}\g<2>', filestr)
    filestr = re.sub(r'''([^"'`*-])\bLaTeX\b([^"'`*-])''',
                     r'\g<1>{\LaTeX}\g<2>', filestr)
    filestr = re.sub(r'''([^"'`*-])\bpdfLaTeX\b([^"'`*-])''',
                     fix_latex_command_regex(
                     r'\g<1>\textsc{pdf}{\LaTeX}\g<2>',
                     application='replacement'), filestr)
    filestr = re.sub(r'''([^"'`*-])\bBibTeX\b([^"'`*-])''',
                     fix_latex_command_regex(
                     r'\g<1>\textsc{Bib}\negthinspace{\TeX}\g<2>',
                     application='replacement'), filestr)
    # This one is not good enough for verbatim `LaTeX`:
    #filestr = re.sub(r'\bLaTeX\b', r'{\LaTeX}', filestr)

    # handle & (Texas A&M -> Texas A{\&}M):
    # (NOTE: destroys URLs with & - and potentially align math envirs)
    #filestr = re.sub(r'([A-Za-z])\s*&\s*([A-Za-z])', r'\g<1>{\&}\g<2>', filestr)

    # handle non-English characters:
    chars = {'æ': r'{\ae}', 'ø': r'{\o}', 'å': r'{\aa}',
             'Æ': r'{\AE}', 'Ø': r'{\O}', 'Å': r'{\AA}',
             }
    # Not implemented
    #for c in chars:
    #    filestr, n = re.subn(c, chars[c], filestr)
    #    print '%d subst of %s' % (n, c)
    #    #filestr = filestr.replace(c, chars[c])

    # Handle 50% and similar (with initial space, does not work
    # for 50% as first word on a line, so we add a fix for that
    filestr = re.sub(r'( [0-9]{1,3})%', r'\g<1>\%', filestr)
    filestr = re.sub(r'(^[0-9]{1,3})%', r'\g<1>\%', filestr, flags=re.MULTILINE)

    # Fix errors such as et. al. cite{ (et. -> et)
    filestr = re.sub(r'et\. +al +cite\{', 'et al. cite{', filestr)

    # fix periods followed by too long space:
    prefix = r'Prof\.', r'Profs\.', r'prof\.', r'profs\.', r'Dr\.', \
             r'assoc\.', r'Assoc.', r'Assist.', r'Mr\.', r'Ms\.', 'Mss\.', \
             r'Fig\.', r'Tab\.', r'Univ\.', r'Dept\.', r'abbr\.', r'cf\.', \
             r'e\.g\.', r'E\.g\.', r'i\.e\.', r'Approx\.', r'approx\.', \
             r'Exer\.', r'et al\.'
    # avoid r'assist\.' - matches too much
    for p in prefix:
        filestr = re.sub(r'(%s) +([\\A-Za-z0-9])' % p, r'\g<1>~\g<2>',
                         filestr)
    # Allow C# and F# languages
    # (filestr is here without code so side effects for
    # notes/chords/music notation should not be relevant)
    filestr = filestr.replace('C#', 'C\\#')
    filestr = filestr.replace('F#', 'F\\#')

    return filestr

def latex_index_bib(filestr, index, citations, pubfile, pubdata):
    #print 'index:', index
    #print 'citations:', citations
    filestr = filestr.replace('cite{', r'\cite{')
    for word in index:
        pattern = 'idx{%s}' % word
        if '`' in word:
            # Verbatim typesetting (cannot use \Verb!...! in index)
            # Replace first `...` with texttt and ensure right sorting
            word = re.sub(r'^(.*?)`([^`]+?)`(.*)$',  # subst first `...`
            fix_latex_command_regex(r'\g<1>\g<2>@\g<1>{\rm\texttt{\g<2>}}\g<3>',
                                    application='replacement'), word)
            # Subst remaining `...`
            word = re.sub(r'`(.+?)`',  # subst first `...`
            fix_latex_command_regex(r'{\rm\texttt{\g<1>}}',
                                    application='replacement'), word)
            # fix underscores:
            word = word.replace('_', r'\_')
        replacement = r'\index{%s}' % word
        filestr = filestr.replace(pattern, replacement)

    if pubfile is not None:
        # Always produce a new bibtex file
        bibtexfile = pubfile[:-3] + 'bib'
        print '\nexporting publish database %s to %s:' % (pubfile, bibtexfile)
        failure = os.system('publish export %s' % bibtexfile)

        # Remove heading right before BIBFILE
        pattern = '={5,9} .+? ={5,9}\s+^BIBFILE'
        filestr = re.sub(pattern, 'BIBFILE', filestr, flags=re.MULTILINE)

        bibtext = fix_latex_command_regex(r"""

\bibliographystyle{plain}
\bibliography{%s}
""" % bibtexfile, application='replacement')
        filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr,
                         flags=re.MULTILINE)
        cpattern = re.compile(r'^BIBFILE:.+$', re.MULTILINE)
        filestr = cpattern.sub(bibtext, filestr)
    return filestr


def latex_exercise(exer):
    # if include_numbering_of_exercises, we could generate a toc for
    # the exercises, based in the exer list of dicts, and store this
    # in a file for later use in latex_code, for instance.
    # This can also be done by a doconce latex_exercise_toc feature
    # that reads the .filename.exerinfo file.

    return doconce_exercise_output(
           exer,
           include_numbering=include_numbering_of_exercises,
           include_type=include_numbering_of_exercises)

def latex_exercise_old(exer):
    # NOTE: this is the old exercise handler!!
    s = ''  # result string

    # Reuse plain_exercise (std doconce formatting) where possible
    # and just make a few adjustments

    s += exer['heading'] + ' ' + exer['title'] + ' ' + exer['heading'] + '\n'
    if 'label' in exer:
        s += 'label{%s}' % exer['label'] + '\n'
    s += '\n' + exer['text'] + '\n'
    for hint_no in sorted(exer['hint']):
        s += exer['hint'][hint_no] + '\n'
        #s += '\n' + exer['hint'][hint_no] + '\n'
    if 'file' in exer:
        #s += '\n' + r'\noindent' + '\nFilename: ' + r'\code{%s}' % exer['file'] + '\n'
        s += 'Filename: ' + r'\code{%s}' % exer['file'] + '.\n'
    if 'comments' in exer:
        s += '\n' + exer['comments']
    if 'solution' in exer:
        pass
    return s

def latex_quote(block, format):
    return r"""
\begin{quote}
%s
\end{quote}
""" % (indent_lines(block, format, ' '*4, trailing_newline=False))

latexfigdir = 'latex_figs'

def _get_admon_figs(filename):
    # Extract graphics file from latex_styles.zip, when needed
    datafile = 'latex_styles.zip'
    if not os.path.isdir(latexfigdir):
        os.mkdir(latexfigdir)
    if not os.path.isfile(os.path.join(latexfigdir, filename)):
        os.chdir(latexfigdir)
        import doconce, shutil
        doconce_dir = os.path.dirname(doconce.__file__)
        doconce_datafile = os.path.join(doconce_dir, datafile)
        print 'copying %s from %s to subdirectory %s' % \
              (filename, doconce_datafile, latexfigdir)
        shutil.copy(doconce_datafile, os.curdir)
        import zipfile
        zipfile.ZipFile(datafile).extract(filename)
        os.remove(datafile)
        os.chdir(os.pardir)


def _latex_admonition_old_does_not_work_with_verbatim(
    admon, admon_name, figname, rgb):
    if isinstance(rgb[0], (float,int)):
        rgb = [str(v) for v in rgb]
    text = '''
def latex_%s(block, format, title='%s'):
    ext = '.eps' if format == 'latex' else '.pdf'
    _get_admon_figs('%s' + ext)
    return r"""

\definecolor{%sbackground}{rgb}{%s}
\setlength{\\fboxrule}{2pt}
\\begin{center}
\\fcolorbox{black}{%sbackground}{
\\begin{minipage}{0.8\\textwidth}
\includegraphics[height=0.3in]{%s/%s%%s}
\ \ \ {\large\sc %%s}\\\\ [3mm]
%%s
\end{minipage}}
\end{center}
\setlength{\\fboxrule}{0.4pt} %%%% Back to default

""" %% (ext, title, block)
''' % (admon, admon_name, admon, admon, ', '.join(rgb), admon, latexfigdir, figname)
    return text

_light_blue = (0.87843, 0.95686, 1.0)
_light_yellow = (0.988235, 0.964706, 0.862745)
_pink = (1.0, 0.8235294, 0.8235294)

_admon2rgb = dict(warning=_pink,
                  question=_light_blue,
                  notice=_light_yellow,
                  summary=_light_yellow,
                  hint=_light_blue,
                  )
# Dropped this since it cannot work with verbatim computer code
#for _admon in ['warning', 'question', 'hint', 'notice', 'summary']:
#    exec(_latex_admonition(_admon, _admon.upper()[0] + _admon[1:],
#                           _admon, _admon2rgb[_admon]))

for _admon in ['warning', 'question', 'hint', 'notice', 'summary']:
    text = r"""
def latex_%s(block, format, title='%s'):
    text = r'''
\begin{%sadmon}
\ \ \ {\large\sc %%s}\\ \par
\nobreak\noindent\ignorespaces
%%s
\end{%sadmon}
''' %% (title, block)
    return text
    """ % (_admon, _admon[0].upper() + _admon[1:], _admon, _admon)
    exec(text)


# Redefine summary (no admon, \summarybox instead, which gives
# a gray box with horizontal rules and that can be small and surrounded
# by text for a4 format)
def latex_summary(block, format, title='Summary'):
    if title != 'Summary':
        if title[-1] not in ('.', '!', '?', ';', ':'):
            title += ':'
        block = r'\textbf{%s} ' % title + block
    return '\\summarybox{\n' + block + '}\n'

def latex_inline_comment(m):
    name = m.group('name')
    comment = m.group('comment')
    #import textwrap
    #caption_comment = textwrap.wrap(comment, width=60,
    #                                break_long_words=False)[0]
    caption_comment = ' '.join(comment.split()[:4])

    if '_' in comment:
        # todonotes are bad at handling verbatim code with comments...
        comment = comment.replace('_', '\\_')

    if len(comment) <= 100:
        # Have some extra space for \code{} commands inside the comment,
        return r'\shortinlinecomment{%s}{ %s }{ %s }' % \
               (name, comment, caption_comment)
    else:
        return r'\longinlinecomment{%s}{ %s }{ %s }' % \
               (name, comment, caption_comment)


def define(FILENAME_EXTENSION,
           BLANKLINE,
           INLINE_TAGS_SUBST,
           CODE,
           LIST,
           ARGLIST,
           TABLE,
           EXERCISE,
           FIGURE_EXT,
           CROSS_REFS,
           INDEX_BIB,
           TOC,
           ENVIRS,
           INTRO,
           OUTRO,
           filestr):
    # all arguments are dicts and accept in-place modifications (extensions)
    from common import INLINE_TAGS
    m = re.search(INLINE_TAGS['inlinecomment'], filestr, flags=re.DOTALL)
    has_inline_comments = True if m else False

    FILENAME_EXTENSION['latex'] = '.p.tex'
    BLANKLINE['latex'] = '\n'

    INLINE_TAGS_SUBST['latex'] = {
        # Note: re.sub "eats" backslashes: \t and \b will not survive to
        # latex if text goes through re.sub. Then we must write
        # \\b and \\t etc. See the fix_latex_command_regex function below
        # for the complete story.

        'math':          None,  # indicates no substitution, leave as is
        'math2':         r'\g<begin>$\g<latexmath>$\g<end>',
        'emphasize':     r'\g<begin>\emph{\g<subst>}\g<end>',
        'bold':          r'\g<begin>\\textbf{\g<subst>}\g<end>',  # (re.sub swallows a \)
        'verbatim':      r'\g<begin>\code{\g<subst>}\g<end>',
        # The following verbatim is better if fixed fontsize is ok, since
        # \code{\latexcommand{arg1}} style formatting does not work well
        # with ptex2tex (the regex will not include the proper second }
        #'verbatim':      r'\g<begin>{\footnotesize{10pt}{10pt}\Verb!\g<subst>!\g<end>',
        'colortext':     r'\\textcolor{\g<color>}{\g<text>}',
        #'linkURL':       r'\g<begin>\href{\g<url>}{\g<link>}\g<end>',
        'linkURL2':      r'\href{{\g<url>}}{\g<link>}',
        'linkURL3':      r'\href{{\g<url>}}{\g<link>}',
        'linkURL2v':     r'\href{{\g<url>}}{\\nolinkurl{\g<link>}}',
        'linkURL3v':     r'\href{{\g<url>}}{\\nolinkurl{\g<link>}}',
        'plainURL':      r'\href{{\g<url>}}{\\nolinkurl{\g<url>}}',  # cannot use \code inside \href, use \nolinkurl to handle _ and # etc. (implies verbatim font)
        'inlinecomment': latex_inline_comment,
        'chapter':       r'\chapter{\g<subst>}',
        'section':       r'\section{\g<subst>}',
        'subsection':    r'\subsection{\g<subst>}',
        #'subsubsection': '\n' + r'\subsubsection{\g<subst>}' + '\n',
        'subsubsection': r'\paragraph{\g<subst>.}',
        'paragraph':     r'\paragraph{\g<subst>}\n',
        #'abstract':      '\n\n' + r'\\begin{abstract}' + '\n' + r'\g<text>' + '\n' + r'\end{abstract}' + '\n\n' + r'\g<rest>', # not necessary with separate \n
        #'abstract':      r'\n\n\\begin{abstract}\n\g<text>\n\end{abstract}\n\n\g<rest>',
        'abstract':      r"""

% #if LATEX_HEADING == "Springer_collection"
\\abstract{
% #else
\\begin{abstract}
% #endif
\g<text>
% #if LATEX_HEADING == "Springer_collection"
}
% #else
\end{abstract}
% #endif

\g<rest>""",
        # recall that this is regex so latex commands must be treated carefully:
        #'title':         r'\\title{\g<subst>}' + '\n', # we don'e use maketitle
        'title':         latex_title,
        'author':        latex_author,
        #'date':          r'\\date{\g<subst>}' ' \n\\maketitle\n\n',
        'date':          fix_latex_command_regex(pattern=r"""

% ----------------- date -------------------------

% #if LATEX_HEADING == "traditional"

\date{\g<subst>}
\maketitle

% #elif LATEX_HEADING == "titlepage"

\ \\\\ [10mm]
{\large\textsf{\g<subst>}}

\end{center}
\vfill
\clearpage

% #else

\begin{center}
\g<subst>
\end{center}

\vspace{1cm}

% #endif

""", application='replacement'),
        'figure':        latex_figure,
        'movie':         latex_movie,
        'comment':       '%% %s',
        }

    ENVIRS['latex'] = {
        'quote':         latex_quote,
        'warning':       latex_warning,
        'question':      latex_question,
        'notice':        latex_notice,
        'hint':          latex_hint,
        'summary':       latex_summary,
       }

    ending = '\n'
    ending = '\n\n\\noindent\n'
    LIST['latex'] = {
        'itemize':
        {'begin': r'\begin{itemize}' + '\n',
         'item': r'\item', 'end': r'\end{itemize}' + ending},

        'enumerate':
        {'begin': r'\begin{enumerate}' + '\n', 'item': r'\item',
         'end': r'\end{enumerate}' + ending},

        'description':
        {'begin': r'\begin{description}' + '\n', 'item': r'\item[%s]',
         'end': r'\end{description}' + ending},

        'separator': '\n',
        }

    CODE['latex'] = latex_code
    ARGLIST['latex'] = {
    #    'parameter': r'\textbf{argument}',
    #    'keyword': r'\textbf{keyword argument}',
    #    'return': r'\textbf{return value(s)}',
    #    'instance variable': r'\textbf{instance variable}',
    #    'class variable': r'\textbf{class variable}',
    #    'module variable': r'\textbf{module variable}',
        'parameter': r'argument',
        'keyword': r'keyword argument',
        'return': r'return value(s)',
        'instance variable': r'instance variable',
        'class variable': r'class variable',
        'module variable': r'module variable',
        }

    FIGURE_EXT['latex'] = ('.eps', '.ps')

    CROSS_REFS['latex'] = latex_ref_and_label

    TABLE['latex'] = latex_table
    EXERCISE['latex'] = latex_exercise
    INDEX_BIB['latex'] = latex_index_bib
    if option('skip_inline_comments') or not has_inline_comments:
        TOC['latex'] = lambda s: r'\tableofcontents' + '\n\n' + r'\vspace{1cm} % after toc' + '\n\n'
    else:
        TOC['latex'] = lambda s: r"""\tableofcontents
% #ifdef TODONOTES
\listoftodos[List of inline comments]
% #endif

\vspace{1cm} % after toc

"""

    preamble = ''
    preamble_complete = False
    filename = option('latex_preamble=', None)
    if filename is not None:
        f = open(filename, "r")
        preamble = f.read()
        f.close()
        if r'\documentclass' in preamble:
            preamble_complete = True

    INTRO['latex'] = r"""%%
%% Automatically generated file from Doconce source
%% (http://code.google.com/p/doconce/)
%%
% #ifdef PTEX2TEX_EXPLANATION
%%
%% The file follows the ptex2tex extended LaTeX format, see
%% ptex2tex: http://code.google.com/p/ptex2tex/
%%
%% Run
%%      ptex2tex myfile
%% or
%%      doconce ptex2tex myfile
%%
%% to turn myfile.p.tex into an ordinary LaTeX file myfile.tex.
%% (The ptex2tex program: http://code.google.com/p/ptex2tex)
%% Many preprocess options can be added to ptex2tex or doconce ptex2tex
%%
%%      ptex2tex -DMINTED -DPALATINO -DA6PAPER -DLATEX_HEADING=traditional myfile
%%      doconce ptex2tex myfile -DMINTED -DLATEX_HEADING=titlepage
%%
%% ptex2tex will typeset code environments according to a global or local
%% .ptex2tex.cfg configure file. doconce ptex2tex will typeset code
%% according to options on the command line (just type doconce ptex2tex to
%% see examples).
% #endif

% #ifndef LATEX_HEADING
% #define LATEX_HEADING
% #endif

% #ifndef PREAMBLE
% #if LATEX_HEADING == "Springer_collection"
% #undef PREAMBLE
% #else
% #define PREAMBLE
% #endif
% #endif


% #ifdef PREAMBLE
%-------------------- begin preamble ----------------------
"""

    m = re.search(r'^\s*=========\s*.+?=========', filestr, flags=re.MULTILINE)
    if m:  # We have chapters, use book style
        INTRO['latex'] += r"""
\documentclass[%
oneside,                 % oneside: electronic viewing, twoside: printing
final,                   % or draft (marks overfull hboxes)
chapterprefix=true,      % "Chapter" word at beginning of each chapter
open=right               % start new chapters on odd-numbered pages
10pt]{book}
"""
    else:  # Only sections, use article style
        INTRO['latex'] += r"""
\documentclass[%
oneside,                 % oneside: electronic viewing, twoside: printing
final,                   % or draft (marks overfull hboxes)
10pt]{article}
"""

    INTRO['latex'] += r"""
\listfiles               % print all files needed to compile this document

% #ifdef A4PAPER
\usepackage[a4paper]{geometry}
% #endif
% #ifdef A6PAPER
% a6paper is suitable for mobile devices
\usepackage[%
  a6paper,
  text={90mm,130mm},
  inner={5mm},           % inner margin (two sided documents)
  top=5mm,
  headsep=4mm
  ]{geometry}
% #endif

\usepackage{relsize,epsfig,makeidx,color,setspace,amsmath,amsfonts}
\usepackage[table]{xcolor}
\usepackage{bm,microtype}
\usepackage{ptex2tex}
"""
    m = re.search('^(!bc|@@@CODE|@@@CMD)', filestr, flags=re.MULTILINE)
    if m:
        INTRO['latex'] += r"""
% #ifdef MINTED
\usepackage{minted}
\usemintedstyle{default}
% #endif
"""
    INTRO['latex'] += r"""
% #ifdef XELATEX
% xelatex settings
\usepackage{fontspec}
\usepackage{xunicode}
\defaultfontfeatures{Mapping=tex-text} % To support LaTeX quoting style
\defaultfontfeatures{Ligatures=TeX}
\setromanfont{Kinnari}
% Examples of font types (Ubuntu): Gentium Book Basic (Palatino-like),
% Liberation Sans (Helvetica-like), Norasi, Purisa (handwriting), UnDoum
% #else
\usepackage[latin1]{inputenc}
% #ifdef HELVETICA
% Set helvetica as the default font family:
\RequirePackage{helvet}
\renewcommand\familydefault{phv}
% #endif
% #ifdef PALATINO
% Set palatino as the default font family:
\usepackage[sc]{mathpazo}    % Palatino fonts
\linespread{1.05}            % Palatino needs extra line spread to look nice
% #endif
% #endif

% Hyperlinks in PDF:
\usepackage[%
    colorlinks=true,
    linkcolor=black,
    %linkcolor=blue,
    citecolor=black,
    filecolor=black,
    %filecolor=blue,
    urlcolor=black,
    pdfmenubar=true,
    pdftoolbar=true,
    urlcolor=black,
    %urlcolor=blue,
    bookmarksdepth=3   % Uncomment (and tweak) for PDF bookmarks with more levels than the TOC
            ]{hyperref}
%\hyperbaseurl{}   % hyperlinks are relative to this root

\setcounter{tocdepth}{2}  % number chapter, section, subsection
"""
    if 'FIGURE:' in filestr:
        INTRO['latex'] += r"""
% Tricks for having figures close to where they are defined:
% 1. define less restrictive rules for where to put figures
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.85}
\renewcommand{\textfraction}{0.15}
\renewcommand{\floatpagefraction}{0.7}
% 2. ensure all figures are flushed before next section
\usepackage[section]{placeins}
% 3. enable begin{figure}[H] (often leads to ugly pagebreaks)
%\usepackage{float}\restylefloat{figure}
"""

    exer_envirs = ['Exercise', 'Problem', 'Project']
    exer_envirs = exer_envirs + ['{%s}' % e for e in exer_envirs]
    for exer_envir in exer_envirs:
        if exer_envir + ':' in filestr:
            INTRO['latex'] += r"""
\newenvironment{exercise}{}{}
\newcounter{exerno}
"""
            break

    if '!bsummary' in filestr and '!esummary' in filestr:
        INTRO['latex'] += r"""
% gray summary box
\definecolor{lightgray}{rgb}{0.94,0.94,0.94}
% #ifdef A4PAPER
\usepackage{wrapfig,calc}
\newdimen\barheight
\def\barthickness{0.5pt}

% small box to the right
\newcommand{\summarybox}[1]{\begin{wrapfigure}{r}{0.5\textwidth}
\vspace*{-\baselineskip}\colorbox{lightgray}{\rule{3pt}{0pt}
\begin{minipage}{0.5\textwidth-6pt-\columnsep}
\hspace*{3mm}
\setbox2=\hbox{\parbox[t]{55mm}{
#1 \rule[-8pt]{0pt}{10pt}}}%
\barheight=\ht2 \advance\barheight by \dp2
\parbox[t]{3mm}{\rule[0pt]{0mm}{22pt}%\hspace*{-2pt}%
\hspace*{-1mm}\rule[-\barheight+16pt]{\barthickness}{\barheight-8pt}%}
}\box2\end{minipage}\rule{3pt}{0pt}}\vspace*{-\baselineskip}
\end{wrapfigure}}
% #else
% gray box of 80% width
\newcommand{\summarybox}[1]{\begin{center}
\colorbox{lightgray}{\rule{6pt}{0pt}
\begin{minipage}{0.8\linewidth}
\parbox[t]{0mm}{\rule[0pt]{0mm}{0.5\baselineskip}}\hrule
\vspace*{0.5\baselineskip}\noindent #1
\parbox[t]{0mm}{\rule[-0.5\baselineskip]{0mm}%
{\baselineskip}}\hrule\vspace*{0.5\baselineskip}\end{minipage}
\rule{6pt}{0pt}}\end{center}}
% #endif
"""
    if has_inline_comments:
        INTRO['latex'] += r"""

% #ifdef TODONOTES
\usepackage{ifthen,xkeyval,tikz,calc,graphicx}"""
        if option('skip_inline_comments'):
            INTRO['latex'] += r"""
\usepackage[shadow,disable]{todonotes}"""
        else:
            INTRO['latex'] += r"""
\usepackage[shadow]{todonotes}"""
        INTRO['latex'] += r"""
\newcommand{\shortinlinecomment}[3]{%
\todo[size=\normalsize,fancyline,color=orange!40,caption={#3}]{%
 \begin{spacing}{0.75}{\bf #1}: #2\end{spacing}}}
\newcommand{\longinlinecomment}[3]{%
\todo[inline,color=orange!40,caption={#3}]{{\bf #1}: #2}}
% #else"""
        if option('skip_inline_comments'):
            INTRO['latex'] += r"""
\newcommand{\shortinlinecomment}[3]{{\bf #1}: \emph{#2}}
\newcommand{\longinlinecomment}[3]{{\bf #1}: \emph{#2}}"""
        else:
            INTRO['latex'] += r"""
\newcommand{\shortinlinecomment}[3]{}
\newcommand{\longinlinecomment}[3]{}"""
        INTRO['latex'] += r"""
% #endif
"""
        if not option('skip_inline_comments'):
            INTRO['latex'] += r"""
\usepackage[mathlines]{lineno}  % show line numbers
\linenumbers
"""
    admons = ['warning', 'question', 'hint', 'notice', 'summary']
    if re.search(r'^!b(%s)' % '|'.join(admons), filestr, flags=re.MULTILINE):
        INTRO['latex'] += r"""
\usepackage{framed}"""
        for admon in admons:
            Admon = admon.upper()[0] + admon[1:]
            figname = admon + '.eps'  # must be changed to .pdf in pdflatex.py
            _get_admon_figs(figname)
            color = str(_admon2rgb[admon])[1:-1]
            INTRO['latex'] += r"""
%% Admonition environment for "%s"
\definecolor{%sbackground}{rgb}{%s}
%% \fboxsep sets the space between the text and the box
\newenvironment{%sshaded}
{\def\FrameCommand{\fboxsep=3mm\colorbox{%sbackground}}
 \MakeFramed {\advance\hsize-\width \FrameRestore}}{\endMakeFramed}

\newenvironment{%sadmon}{
\begin{%sshaded}
\noindent
\includegraphics[height=0.3in]{latex_figs/%s}
}
{
\end{%sshaded}
}
""" % (admon, admon, color, admon, admon, admon, admon, figname, admon)

    INTRO['latex'] += r"""
% #ifdef COLORED_TABLE_ROWS
% color every two table rows
\let\oldtabular\tabular
\let\endoldtabular\endtabular
% #if COLORED_TABLE_ROWS not in ("gray", "blue")
% #define COLORED_TABLE_ROWS gray
% #endif
% #else
% #define COLORED_TABLE_ROWS no
% #endif
% #if COLORED_TABLE_ROWS == "gray"
\definecolor{rowgray}{gray}{0.9}
\renewenvironment{tabular}{\rowcolors{2}{white}{rowgray}%
\oldtabular}{\endoldtabular}
% #elif COLORED_TABLE_ROWS == "blue"
\definecolor{appleblue}{rgb}{0.93,0.95,1.0}  % Apple blue
\renewenvironment{tabular}{\rowcolors{2}{white}{appleblue}%
\oldtabular}{\endoldtabular}
% #endif

% prevent orhpans and widows
\clubpenalty = 10000
\widowpenalty = 10000

% http://www.ctex.org/documents/packages/layout/titlesec.pdf
\usepackage[compact]{titlesec}  % narrower section headings
% #ifdef BLUE_SECTION_HEADINGS
\definecolor{seccolor}{rgb}{0.2,0.2,0.8}
\titleformat{\section}
{\color{seccolor}\normalfont\Large\bfseries}
{\color{seccolor}\thesection}{1em}{}
\titleformat{\subsection}
{\color{seccolor}\normalfont\large\bfseries}
{\color{seccolor}\thesubsection}{1em}{}
% #endif

% USER PREAMBLE
% insert custom LaTeX commands...

\makeindex

%-------------------- end preamble ----------------------

\begin{document}

% #endif

"""
    if preamble_complete:
        INTRO['latex'] = preamble + r"""
\begin{document}

"""
    elif preamble:
        # Insert user-provided part of the preamble
        INTRO['latex'] = INTRO['latex'].replace('% USER PREAMBLE', preamble)
    else:
        INTRO['latex'] = INTRO['latex'].replace('% USER PREAMBLE', '')

    if option('device=', '') == 'paper':
        INTRO['latex'] = INTRO['latex'].replace('oneside,', 'twoside,')

    # (We do replacement rather than parameter in the preamble since
    # that will imply double %% in a lot of places)
    pygm_style = option('minted_latex_style=', default='default')
    if not pygm_style == 'default':
        INTRO['latex'] = INTRO['latex'].replace('usemintedstyle{default}',
                                       'usemintedstyle{%s}' % pygm_style)

    newcommands_files = list(sorted([name
                                     for name in glob.glob('newcommands*.tex')
                                     if not name.endswith('.p.tex')]))
    for filename in newcommands_files:
        if os.path.isfile(filename):
            INTRO['latex'] += r"""\input{%s}
""" % (filename[:-4])
            #print '... found', filename
        #elif os.path.isfile(pfilename):
        #    print '%s exists, but not %s - run ptex2tex first' % \
        #    (pfilename, filename)
        else:
            #print '... did not find', filename
            pass


    OUTRO['latex'] = r"""

% #ifdef PREAMBLE
\printindex

\end{document}
% #endif
"""


def fix_latex_command_regex(pattern, application='match'):
    """
    Given a pattern for a regular expression match or substitution,
    the function checks for problematic patterns commonly
    encountered when working with LaTeX texts, namely commands
    starting with a backslash.

    For a pattern to be matched or substituted, and extra backslash is
    always needed (either a special regex construction like ``\w`` leads
    to wrong match, or ``\c`` leads to wrong substitution since ``\`` just
    escapes ``c`` so only the ``c`` is replaced, leaving an undesired
    backslash). For the replacement pattern in a substitutions, specified
    by the ``application='replacement'`` argument, a backslash
    before any of the characters ``abfgnrtv`` must be preceeded by an
    additional backslash.

    The application variable equals 'match' if `pattern` is used for
    a match and 'replacement' if `pattern` defines a replacement
    regex in a ``re.sub`` command.

    Caveats: let `pattern` just contain LaTeX commands, not combination
    of commands and other regular expressions (``\s``, ``\d``, etc.) as the
    latter will end up with an extra undesired backslash.

    Here are examples on failures.

    >>> re.sub(r'\begin\{equation\}', r'\[', r'\begin{equation}')
    '\\begin{equation}'
    >>> # match of mbox, not \mbox, and wrong output
    >>> re.sub(r'\mbox\{(.+?)\}', r'\fbox{\g<1>}', r'\mbox{not}')
    '\\\x0cbox{not}'

    Here are examples on using this function.

    >>> from doconce.latex import fix_latex_command_regex as fix
    >>> pattern = fix(r'\begin\{equation\}', application='match')
    >>> re.sub(pattern, r'\[', r'\begin{equation}')
    '\\['
    >>> pattern = fix(r'\mbox\{(.+?)\}', application='match')
    >>> replacement = fix(r'\fbox{\g<1>}', application='replacement')
    >>> re.sub(pattern, replacement, r'\mbox{not}')
    '\\fbox{not}'

    Avoid mixing LaTeX commands and ordinary regular expression
    commands, e.g.,

    >>> pattern = fix(r'\mbox\{(\d+)\}', application='match')
    >>> pattern
    '\\\\mbox\\{(\\\\d+)\\}'
    >>> re.sub(pattern, replacement, r'\mbox{987}')
    '\\mbox{987}'  # no substitution, no match

    """
    import string
    problematic_letters = string.ascii_letters if application == 'match' \
                          else 'abfgnrtv'

    for letter in problematic_letters:
        problematic_pattern = '\\' + letter

        if letter == 'g' and application == 'replacement':
            # no extra \ for \g<...> in pattern
            if r'\g<' in pattern:
                continue

        ok_pattern = '\\\\' + letter
        if problematic_pattern in pattern and not ok_pattern in pattern:
            pattern = pattern.replace(problematic_pattern, ok_pattern)
    return pattern
