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
        filestr = re.sub(r'section\{(Exercise|Problem|Project)(\s+\d+):( +[^}])',
                         r'section*{\g<1>\g<2>:\g<3>', filestr)

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
    caption = m.group('caption').strip()

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
        # Drop default_movie, embed in PDF instead using various techniques
        if caption:
            text = r"""
\begin{figure}[ht]
\begin{center}
"""
        text += r"""
%% #if MOVIE == "media9"
\includemedia[
label=%(filename)s,
activate=pageopen,
width=0.9\linewidth,
addresource=%(filename)s,
flashvars={
source=%(filename)s,
&autoPlay=true}]{VPlayer.swf}

%% #elif MOVIE == "movie15"
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
]{0.9\linewidth}{0.9\linewidth}{%(filename)s}
%% #ifndef EXTERNAL_MOVIE_VIEWER
\movieref[rate=0.5]{%(filename)s}{Slower}
\movieref[rate=2]{%(filename)s}{Faster}
\movieref[default]{%(filename)s}{Normal}
\movieref[pause]{%(filename)s}{Play/Pause}
\movieref[stop]{%(filename)s}{Stop}
%% #else
\href{run:%(filename)s}{%(filename)s}
%% #endif

%% #elif MOVIE == "multimedia"
%% Beamer-style \movie command
\movie[
label=%(filename)s,
width=0.9\linewidth,
autostart]{%(filename)s}{%(filename)s}
%% #else
\href{run:%(filename)s}{%(filename)s}
%% #endif
""" % {'filename': filename}
        if caption:
            # Note: caption may contain a label
            text += r"""
\end{center}
\caption{%s}
\end{figure}
""" % caption
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

%% #elif LATEX_HEADING == "beamer"
\title{%s}
%% #else
\begin{center}
{\LARGE\bf
\begin{spacing}{1.25}
%s
\end{spacing}
}
\end{center}
%% #endif
""" % (title, title, title, title, title)
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
% #elif LATEX_HEADING == "beamer"
\author{"""
    author_command = []
    for a, i, e in authors_and_institutions:
        a_text = a
        inst = r'\inst{' + ','.join([str(i) for i in auth2index[a]]) + '}'
        a_text += inst
        author_command.append(a_text)
    text += '\n\\and\n'.join(author_command) + '}\n'
    inst_command = []
    institutions = [index2inst[i] for i in index2inst]
    text += r'\institute{' + '\n\\and\n'.join(
        [inst + r'\inst{%d}' % (i+1)
         for i, inst in enumerate(institutions)]) + '}'

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
    chars = {'�': r'{\ae}', '�': r'{\o}', '�': r'{\aa}',
             '�': r'{\AE}', '�': r'{\O}', '�': r'{\AA}',
             }
    # Not implemented
    #for c in chars:
    #    filestr, n = re.subn(c, chars[c], filestr)
    #    print '%d subst of %s' % (n, c)
    #    #filestr = filestr.replace(c, chars[c])

    # Handle "50%" and similar (with initial space, does not work
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
             r'Exer\.', r'Sec\.', r'Ch\.', r'App\.', r'et al\.', 'no\.'
    # avoid r'assist\.' - matches too much
    for p in prefix:
        filestr = re.sub(r'(%s) +([\\A-Za-z0-9$])' % p, r'\g<1>~\g<2>',
                         filestr)
    # Allow C# and F# languages
    # (filestr is here without code so side effects for
    # notes/chords/music notation should not be relevant)
    filestr = filestr.replace('C#', 'C\\#')
    filestr = filestr.replace('F#', 'F\\#')

    return filestr

def latex_index_bib(filestr, index, citations, pubfile, pubdata):
    # About latex technologies for bib:
    # http://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib
    # May consider moving to biblatex if it is compatible enough.

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

def latex_quote(block, format, text_size='normal'):
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
        #print 'copying admon figures from %s to subdirectory %s' % \
        #      (doconce_datafile, latexfigdir)
        shutil.copy(doconce_datafile, os.curdir)
        import zipfile
        zipfile.ZipFile(datafile).extractall()
        os.remove(datafile)
        os.chdir(os.pardir)

admons = 'notice', 'summary', 'warning', 'question', 'block'
for _admon in admons:
    _Admon = _admon.capitalize()
    text = r"""
def latex_%(_admon)s(block, format, title='%(_Admon)s', text_size='normal'):
    if title.lower().strip() == 'none':
        title = ''
    if title == 'Block':  # block admon has no default title
        title = ''

    latex_admon = option('latex_admon=', 'graybox1')
    if text_size == 'small':
        # When a font size changing command is used, incl a \par at the end
        block = r'{\footnotesize ' + block + r' \par}'
        # Add reduced initial vertical space?
        if latex_admon in ("yellowbox", "graybox3", "colors2"):
            block = r'\vspace{-2.5mm}\par\noindent' + '\n' + block
        elif latex_admon == "colors1":
            # Add reduced initial vertical space
            block = r'\vspace{-3.5mm}\par\noindent' + '\n' + block
        elif latex_admon in ("graybox1", "graybox2"):
            block = r'\vspace{0.5mm}\par\noindent' + '\n' + block
    elif text_size == 'large':
        block = r'{\large ' + block + r' \par}'
        title = r'{\large ' + title + ' }'

    title_graybox1 = title.replace(',', '')  # title in graybox1 cannot handle ,
    if title_graybox1 and title_graybox1[-1] not in ('.', ':', '!', '?'):
        title_graybox1 += '.'

    title_para = title
    if title_para and title_para[-1] not in ('.', ':', '!', '?'):
        title_para += '.'

    # For graybox2 we use graybox2admon except for summary without verbatim code,
    # then \grayboxhrules is used (which can be wrapped in a small box of 50 percent
    # with in the text for A4 format)
    grayboxhrules = False
    block_graybox2 = block
    title_graybox2 = title
    if '%(_admon)s' == 'summary':
        if title != 'Summary':
            if title_graybox2 and title_graybox2[-1] not in ('.', '!', '?', ';', ':'):
                title_graybox2 += ':'
            block_graybox2 = r'\textbf{%%s} ' %% title_graybox2 + block_graybox2
        # else: no title if title == 'Summary' for graybox2
        # Any code in block_graybox2?
        m1 = re.search(r'^\\(b|e).*(cod|pro)', block_graybox2, flags=re.MULTILINE)
        m2 = '\\code{' in block_graybox2
        if m1 or m2:
            grayboxhrules = False
        else:
            grayboxhrules = True

    if grayboxhrules:
        envir_graybox2 = r'''\grayboxhrules{
%%s
}''' %% block_graybox2
    else:
        # same mdframed package as for graybox1 admon, use title_graybox1
        envir_graybox2 = r'''
\begin{graybox2admon}[%%s]
%%s
\end{graybox2admon}

''' %% (title_graybox1, block_graybox2)

    if latex_admon in ('colors1', 'colors2', 'graybox3', 'yellowbox'):
        text = r'''
\begin{%(_admon)s_%%(latex_admon)sadmon}[%%(title)s]
%%(block)s
\end{%(_admon)s_%%(latex_admon)sadmon}

''' %% vars()

    elif latex_admon == 'paragraph':
        text = r'''
\begin{paragraphadmon}[%%(title_para)s]
%%(block)s
\end{paragraphadmon}

''' %% vars()

    elif latex_admon == 'graybox2':
        text = r'''
%%(envir_graybox2)s
''' %% vars()

    else:
        text = r'''
\begin{graybox1admon}[%%(title_graybox1)s]
%%(block)s
\end{graybox1admon}

''' %% vars()
    return text
    """ % vars()
    exec(text)



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

# Dropped this since it cannot work with verbatim computer code
#for _admon in ['warning', 'question', 'notice', 'summary']:
#    exec(_latex_admonition(_admon, _admon.upper()[0] + _admon[1:],
#                           _admon, _admon2rgb[_admon]))


def latex_inline_comment(m):
    name = m.group('name')
    comment = m.group('comment')
    #import textwrap
    #caption_comment = textwrap.wrap(comment, width=60,
    #                                break_long_words=False)[0]
    caption_comment = ' '.join(comment.split()[:4])  # for toc for todonotes

    if '_' in comment:
        # todonotes are bad at handling verbatim code with comments...
        # inlinecomment is treated before verbatim
        verbatims = re.findall(r'`.+?`', comment)
        for verbatim in verbatims:
            if '_' in verbatim:
                verbatim_fixed = verbatim.replace('_', '\\_')
                comment = comment.replace(verbatim, verbatim_fixed)

    if len(comment) <= 100:
        # Have some extra space inside the braces in the arguments to ensure
        # correct handling of \code{} commands
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

% #if LATEX_HEADING == "traditional"
\date{\g<subst>}
\maketitle
% #elif LATEX_HEADING == "beamer"
\date{\g<subst>
% <titlepage figure>
}
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
        'summary':       latex_summary,
        'block':         latex_block,
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
% #define LATEX_HEADING "doconce_heading"
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
    # Add packages for movies
    m = re.search(r'^MOVIE:\s*\[', filestr, flags=re.MULTILINE)
    if m:
        INTRO['latex'] += r"""
% #ifndef MOVIE
% #define MOVIE "media9"
% #endif

% #if MOVIE == "media9"
\usepackage{media9}
% #elif MOVIE == "movie15"
\usepackage{movie15}
% #elif MOVIE == "multimedia"
\usepackage{multimedia}
% #elif MOVIE == "href-run"
% #endif
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
%\usepackage[latin1]{inputenc}
\usepackage[utf8]{inputenc}
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
\definecolor{linkcolor}{rgb}{0,0,0.4}
\usepackage[%
    colorlinks=true,
    linkcolor=linkcolor,
    urlcolor=linkcolor,
    citecolor=black,
    filecolor=black,
    %filecolor=blue,
    pdfmenubar=true,
    pdftoolbar=true,
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
\newcommand{\shortinlinecomment}[3]{}
\newcommand{\longinlinecomment}[3]{}"""
        else:
            INTRO['latex'] += r"""
\newcommand{\shortinlinecomment}[3]{{\bf #1}: \emph{#2}}
\newcommand{\longinlinecomment}[3]{{\bf #1}: \emph{#2}}"""
        INTRO['latex'] += r"""
% #endif
"""
        INTRO['latex'] += r"""
% #ifdef LINENUMBERS
\usepackage[mathlines]{lineno}  % show line numbers
\linenumbers
% #endif
"""
    # Admonitions
    if re.search(r'^!b(%s)' % '|'.join(admons), filestr, flags=re.MULTILINE):
        latex_admon = option('latex_admon=', 'graybox1')
        if latex_admon in ('colors1',):
            packages = r'\usepackage{framed}'
        elif latex_admon in ('colors2', 'graybox3', 'yellowbox'):
            packages = r'\usepackage{framed,wrapfig}'
        elif latex_admon in ('graybox2',):
            packages = r"""\usepackage{wrapfig,calc}
\usepackage[framemethod=TikZ]{mdframed}"""
        else: # graybox1
            packages = r'\usepackage[framemethod=TikZ]{mdframed}'
        INTRO['latex'] += '\n' + packages + '\n'
        if latex_admon == 'graybox2':
            INTRO['latex'] += r"""
% gray box with horizontal rules (cannot handle verbatim text)
\definecolor{lightgray}{rgb}{0.94,0.94,0.94}
% #ifdef A4PAPER
\newdimen\barheight
\def\barthickness{0.5pt}

% small box to the right for A4 paper
\newcommand{\grayboxhrules}[1]{\begin{wrapfigure}{r}{0.5\textwidth}
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
\newcommand{\grayboxhrules}[1]{\begin{center}
\colorbox{lightgray}{\rule{6pt}{0pt}
\begin{minipage}{0.8\linewidth}
\parbox[t]{0mm}{\rule[0pt]{0mm}{0.5\baselineskip}}\hrule
\vspace*{0.5\baselineskip}\noindent #1
\parbox[t]{0mm}{\rule[-0.5\baselineskip]{0mm}%
{\baselineskip}}\hrule\vspace*{0.5\baselineskip}\end{minipage}
\rule{6pt}{0pt}}\end{center}}
% #endif

% Fallback for verbatim content in \grayboxhrules
\newmdenv[
  backgroundcolor=lightgray,
  skipabove=\topsep,
  skipbelow=\topsep,
  leftmargin=23,
  rightmargin=23,
]{graybox2mdframed}

\newenvironment{graybox2admon}[1][]{
\begin{graybox2mdframed}[frametitle=#1]
}
{
\end{graybox2mdframed}
}
"""
        elif latex_admon == 'paragraph':
            INTRO['latex'] += r"""
% Admonition is just a paragraph
\newenvironment{paragraphadmon}[1][]{\paragraph{#1}}{}
"""
        elif latex_admon in ('colors1', 'colors2', 'graybox3', 'yellowbox'):
            pass
        else:
            INTRO['latex'] += r"""
% Admonition is an oval gray box
\newmdenv[
  backgroundcolor=gray!5,  %% white with 5%% gray
  skipabove=\topsep,
  skipbelow=\topsep,
  outerlinewidth=0.5,
  leftmargin=0,
  rightmargin=0,
  roundcorner=5,
]{graybox1mdframed}

\newenvironment{graybox1admon}[1][]{
\begin{graybox1mdframed}[frametitle=#1]
}
{
\end{graybox1mdframed}
}
"""
        _light_blue = (0.87843, 0.95686, 1.0)
        _light_yellow1 = (0.988235, 0.964706, 0.862745)
        _pink = (1.0, 0.8235294, 0.8235294)
        _gray1 = (0.86, 0.86, 0.86)
        _gray2 = (0.91, 0.91, 0.91)  # lighter gray
        _gray3 = (0.97, 0.97, 0.97)  # even lighter gray
        _light_yellow2 = (0.97, 0.88, 0.62)

        _admon2colors = dict(
            warning=_pink,
            question=_light_yellow1,
            notice=_light_yellow1,
            summary=_light_yellow1,
            #block=_gray2,
            block=_light_yellow1,
            )
        graybox3_figs = dict(
            warning='small_gray_warning',
            question='small_gray_question2',  # 'small_gray_question3'
            notice='small_gray_notice',
            summary='small_gray_summary',
            )
        yellowbox_figs = dict(
            warning='small_yellow_warning',
            question='small_yellow_question',
            notice='small_yellow_notice',
            summary='small_yellow_summary',
            )

        for admon in admons:
            Admon = admon.upper()[0] + admon[1:]

            if admon != 'block':
                # Copy figure file if necessary
                # Note: .eps changed to .pdf in pdflatex.py
                figname_colors = admon + '.eps'
                _get_admon_figs(figname_colors)
                figname_graybox3 = graybox3_figs[admon] + '.eps'
                _get_admon_figs(figname_graybox3)
                figname_yellowbox = yellowbox_figs[admon] + '.eps'
                _get_admon_figs(figname_yellowbox)

            color_colors = str(_admon2colors[admon])[1:-1]
            graphics_colors1 = r'\includegraphics[height=0.3in]{latex_figs/%s}\ \ \ ' % admon
            graphics_colors2 = r"""\begin{wrapfigure}{l}{0.07\textwidth}
\vspace{-13pt}
\includegraphics[width=0.07\textwidth]{latex_figs/%s}
\end{wrapfigure}""" % admon
            # Old typesetting of title (for latex_admon==colors1): {\large\sc #1}

            #color_graybox3 = str(_gray3)[1:-1]
            color_graybox3 = str(_gray2)[1:-1]
            graphics_graybox3 = r"""\begin{wrapfigure}{l}{0.07\textwidth}
\vspace{-13pt}
\includegraphics[width=0.07\textwidth]{latex_figs/%s}
\end{wrapfigure}"""% figname_graybox3

            #color_yellowbox = str(_light_yellow2)[1:-1]
            color_yellowbox = str(_light_yellow1)[1:-1]
            graphics_yellowbox = r"""\begin{wrapfigure}{l}{0.07\textwidth}
\vspace{-13pt}
\includegraphics[width=0.07\textwidth]{latex_figs/%s}
\end{wrapfigure}""" % figname_yellowbox

            if admon == 'block':
                # No figures for block admon
                graphics_colors1 = ''
                graphics_colors2 = ''
                graphics_graybox3 = ''
                graphics_yellowbox = ''

            if latex_admon == 'colors1':
                INTRO['latex'] += r"""
%% Admonition environment for "%(admon)s"
%% Style from NumPy User Guide
\definecolor{%(admon)sbackground}{rgb}{%(color_colors)s}
%% \fboxsep sets the space between the text and the box
\newenvironment{%(admon)sshaded}
{\def\FrameCommand{\fboxsep=3mm\colorbox{%(admon)sbackground}}
 \MakeFramed {\advance\hsize-\width \FrameRestore}}{\endMakeFramed}

\newenvironment{%(admon)s_colors1admon}[1][%(Admon)s]{
\begin{%(admon)sshaded}
\noindent
%(graphics_colors1)s  \textbf{#1}\\ \par
\vspace{-3mm}\nobreak\noindent\ignorespaces
}
{
\end{%(admon)sshaded}
}
""" % vars()
            elif latex_admon == 'colors2':
                INTRO['latex'] += r"""
%% Admonition environment for "%(admon)s"
\definecolor{%(admon)sbackground}{rgb}{%(color_colors)s}
%% \fboxsep sets the space between the text and the box
\newenvironment{%(admon)sshaded}
{\def\FrameCommand{\fboxsep=3mm\colorbox{%(admon)sbackground}}
 \MakeFramed {\advance\hsize-\width \FrameRestore}}{\endMakeFramed}

\newenvironment{%(admon)s_colors2admon}[1][%(Admon)s]{
\begin{%(admon)sshaded}
\noindent
%(graphics_colors2)s \textbf{#1}\par
\nobreak\noindent\ignorespaces
}
{
\end{%(admon)sshaded}
}
""" % vars()
            elif latex_admon == 'graybox3':
                INTRO['latex'] += r"""
%% Admonition environment for "%(admon)s"
\definecolor{%(admon)sbackground}{rgb}{%(color_graybox3)s}
%% \fboxsep sets the space between the text and the box
\newenvironment{%(admon)sshaded}
{\def\FrameCommand{\fboxsep=3mm\colorbox{%(admon)sbackground}}
 \MakeFramed {\advance\hsize-\width \FrameRestore}}{\endMakeFramed}

\newenvironment{%(admon)s_graybox3admon}[1][%(Admon)s]{
\begin{%(admon)sshaded}
\noindent
%(graphics_graybox3)s \textbf{#1}\par
\nobreak\noindent\ignorespaces
}
{
\end{%(admon)sshaded}
}
""" % vars()
            elif latex_admon == 'yellowbox':
                INTRO['latex'] += r"""
%% Admonition environment for "%(admon)s"
\definecolor{%(admon)sbackground}{rgb}{%(color_yellowbox)s}
%% \fboxsep sets the space between the text and the box
\newenvironment{%(admon)sshaded}
{\def\FrameCommand{\fboxsep=3mm\colorbox{%(admon)sbackground}}
 \MakeFramed {\advance\hsize-\width \FrameRestore}}{\endMakeFramed}

\newenvironment{%(admon)s_yellowboxadmon}[1][%(Admon)s]{
\begin{%(admon)sshaded}
\noindent
%(graphics_yellowbox)s \textbf{#1}\par
\nobreak\noindent\ignorespaces
}
{
\end{%(admon)sshaded}
}
""" % vars()

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

% --- end of standard preamble for documents ---
"""
    # Note: the line above is key for extracting the correct part
    # of the preamble for beamer slides in misc.slides_beamer

    exer_envirs = ['Exercise', 'Problem', 'Project']
    exer_envirs = exer_envirs + ['{%s}' % e for e in exer_envirs]
    for exer_envir in exer_envirs:
        if exer_envir + ':' in filestr:
            INTRO['latex'] += r"""
\newenvironment{exercise}{}{}
\newcounter{exerno}
"""
            break

    INTRO['latex'] += r"""
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
