# -*- coding: iso-8859-15 -*-

import os, commands, re, sys, glob
from common import plain_exercise, table_analysis, \
     _CODE_BLOCK, _MATH_BLOCK, doconce_exercise_output, indent_lines
additional_packages = ''  # comma-sep. list of packages for \usepackage{}

include_numbering_of_exercises = True

def underscore_in_code(m):
    """For pattern r'\\code\{(.*?)\}', insert \_ for _ in group 1."""
    text = m.group(1)
    text = text.replace('_', r'\_')
    return r'\code{%s}' % text

def latex_code(filestr, code_blocks, code_block_types,
               tex_blocks, format):

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
    for code in code_blocks:
        for i in range(len(lines)):
            if _CODE_BLOCK in lines[i]:
                words = lines[i].split()
                if len(words) == 2:
                    envir = words[1]
                else:
                    envir = 'ccq'
                lines[i] = '\\' + 'b' + envir + '\n' + code + '\\' + 'e' + envir
                break

    for tex in tex_blocks:
        # Also here problems with this: (\nabla becomes \n (newline) and abla)
        # which means that
        # filestr = re.sub(_MATH_BLOCK, '!bt\n%s!et' % tex, filestr, 1)
        # does not work properly. Instead, we use str.replace

        for i in range(len(lines)):
            if _MATH_BLOCK in lines[i]:
                lines[i] = lines[i].replace(_MATH_BLOCK,
                                            '!bt\n%s!et' % tex)
                break
    filestr = '\n'.join(lines)

    c = re.compile(r'^!bt\n', re.MULTILINE)
    #filestr = c.sub('\n', filestr)  # why an extra \n?
    filestr = c.sub('', filestr)
    filestr = re.sub(r'!et\n', '', filestr)

    # Check for misspellings
    envirs = 'pro pypro cypro cpppro cpro fpro plpro shpro mpro cod pycod cycod cppcod ccod fcod plcod shcod mcod rst cppans pyans fans bashans swigans uflans sni dat dsni sys slin ipy rpy plin ver warn rule summ ccq cc ccl py'.split()
    for envir in code_block_types:
        if envir and envir not in envirs:
            print 'Warning: found "!bc %s", but %s is not a standard predefined ptex2tex environment' % (envir, envir)

    # --- Final fixes for latex format ---

    appendix_pattern = r'\\(chapter|section\*?)\{Appendix:\s+'
    filestr = re.sub(appendix_pattern,
                     '\n\n\\\\appendix\n\n' + r'\\\g<1>{', filestr,  # the first
                     count=1)
    filestr = re.sub(appendix_pattern, r'\\\g<1>{', filestr) # all others

    if include_numbering_of_exercises:
        # Remove section numbers of exercise sections
        filestr = re.sub(r'section\{(Exercise|Problem|Project)( +[^}])',
                         r'section*{\g<1>\g<2>', filestr)

    if '--latex-printed' in sys.argv:
        # Make adjustments for printed versions of the PDF document.
        # Fix links so that the complete URL is in a footnote
        pattern = r'\\href\{\{(.+?)\}\}\{(.+?)\}'
        def subst(m):  # m is match object
            url = m.group(1).strip()
            text = m.group(2).strip()
            #print 'url:', url, 'text:', text
            if not ('http' in text or '\\nolinkurl{' in text):
                texttt_url = url.replace('_', '\\_').replace('#', '\\#')
                # fix % without backslash
                texttt_url = re.sub(r'([^\\])\%', r'\g<1>\\%', texttt_url)
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
            filestr = filestr.replace(r'%s{%s}' % (tp, heading),
                                      r'%s{%s}' % (tp, new_heading))
            # Fix double }} for code ending (\section{...\code{...}})
            filestr = re.sub(r'\\code\{(.*?)\}\}', r'\code{\g<1>} }', filestr)

    return filestr

def latex_figure(m, includegraphics=True):
    filename = m.group('filename')
    basename  = os.path.basename(filename)
    stem, ext = os.path.splitext(basename)
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
    from plaintext import default_movie
    text = default_movie(m)

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
\\begin{figure}[ht]
\\begin{center}

% #ifdef MOVIE15
\includemovie[poster,
label=\g<filename>,
autoplay,
%controls,
%toolbar,
% #ifdef EXTERNAL_MOVIE_VIEWER
externalviewer,
% #endif
text={\small (Loading \g<filename>)},
repeat,
]{0.9\linewidth}{0.9\linewidth}{\g<filename>}    % requires \usepackage{movie15}
% #ifndef EXTERNAL_MOVIE_VIEWER
\movieref[rate=0.5]{\g<filename>}{Slower}
\movieref[rate=2]{\g<filename>}{Faster}
\movieref[default]{\g<filename>}{Normal}
\movieref[pause]{\g<filename>}{Play/Pause}
\movieref[stop]{\g<filename>}{Stop}
% #else
\href{run:\g<filename>}{\g<filename>}
% #endif

% #else
\href{run:\g<filename>}{\g<filename>}

% alternative: \movie command that comes with beamer
% \movie[options]{\g<filename>}{\g<filename>}
% #endif
\end{center}
\caption{\g<caption>}
\end{figure}
"""
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
    # Make appropriate linebreaks for the default typesetting
    import textwrap
    multiline_title = r' \\\\ [1.5mm] '.join(textwrap.wrap(title, width=38))

    text = fix_latex_command_regex(pattern=r"""

%% ----------------- title -------------------------
%% #if LATEX_HEADING == "traditional"

\title{%s}

%% #elif LATEX_HEADING == "titlepage"

\thispagestyle{empty}
\hbox{\ \ }
\vfill
\begin{center}
{\huge{\bfseries{%s}}}

%% #elif LATEX_HEADING == "Springer-collection"

\title*{%s}
%% Short version of title:
%%\titlerunning{...}

%% #else

\begin{center}
{\LARGE\bf %s}
\end{center}

%% #endif
""" % (title, title, title, multiline_title), application='replacement')
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
% #elif LATEX_HEADING == "Springer-collection"
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

    # Handle 50% and similar
    filestr = re.sub(r'([0-9]{1,3})%', r'\g<1>\%', filestr)

    # fix periods followed by too long space:
    prefix = r'Prof\.', r'Profs\.', r'prof\.', r'profs\.', r'Dr\.', \
             r'assoc\.', r'Assoc.', r'Assist.', r'Mr\.', r'Ms\.', 'Mss\.', \
             r'Fig\.', r'Tab\.', r'Univ\.', r'Dept\.', r'abbr\.', r'cf\.', \
             r'e\.g\.', r'E\.g\.', r'i\.e\.', r'Approx\.', r'approx\.', \
             r'Exer\.',
    # avoid r'assist\.' - matches too much
    for p in prefix:
        filestr = re.sub(r'(%s) +([\\A-Za-z0-9])' % p, r'\g<1>~\g<2>',
                         filestr)

    return filestr

def latex_index_bib(filestr, index, citations, bibfile):
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
    if 'bib' in bibfile:
        bibtext = fix_latex_command_regex(r"""

\bibliographystyle{plain}
\bibliography{%s}
""" % bibfile['bib'], application='replacement')
        #filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr,
        #                 flags=re.MULTILINE)
        cpattern = re.compile(r'^BIBFILE:.+$', re.MULTILINE)
        filestr = cpattern.sub(bibtext, filestr)
    return filestr


def latex_exercise(exer):
    begin_exercise = '# --- begin exercise\n' + r'\begin{exercise}' + '\n' + r'\refstepcounter{exerno}' + '\n'
    end_exercise = '\n' + r'\end{exercise}' + '\n# --- end of exercise'
    begin_solution = '# --- begin solution of exercise\n\n__Solution.__\n'
    end_solution = '\n# --- end solution of exercise'
    begin_answer = '# --- begin short answer in exercise\n\n__Answer.__ '
    end_answer = '\n# --- end short answer in exercise'
    begin_hint = '__Hint.__ '
    end_hint = ''

    # if include_numbering_of_exercises, we could generate a toc for
    # the exercises, based in the exer list of dicts, and store this
    # in a file for later use in latex_code, for instance.
    # This can also be done by a doconce latex_exercise_toc feature
    # that reads the .filename.exerinfo file.

    return doconce_exercise_output(
        exer,
        begin_exercise, end_exercise,
        begin_answer, end_answer,
        begin_solution, end_solution,
        begin_hint, end_hint,
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
""" % (indent_lines(block, format, ' '*4))

def latex_notes(block, format):
    # Set notes in comments
    return r"""
%s
""" % (indent_lines(block, format, '% '))

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


def _latex_admonition(admon, admon_name, figname, rgb):
    if isinstance(rgb[0], (float,int)):
        rgb = [str(v) for v in rgb]
    text = '''
def latex_%s(block, format):
    ext = '.eps' if format == 'latex' else '.pdf'
    _get_admon_figs('%s' + ext)
    return r"""
\definecolor{%sbackground}{rgb}{%s}
\setlength{\\fboxrule}{2pt}
\\begin{center}
\\fcolorbox{black}{%sbackground}{
\\begin{minipage}{0.8\\textwidth}
\includegraphics[height=0.3in]{%s/%s%%s}
\\vskip-0.3in\hskip1.5in{\large\\bf %s} \\\\[0.4cm]
%%s
\end{minipage}}
\end{center}
\setlength{\\fboxrule}{0.4pt} %%%% Back to default
""" %% (ext, block)
''' % (admon, admon, admon, ', '.join(rgb), admon, latexfigdir, figname, admon_name)
    return text

_admon2rgb = dict(warning=(1.0, 0.8235294, 0.8235294),   # pink
                  question=(0.87843, 0.95686, 1.0),      # light blue
                  notice=(0.988235, 0.964706, 0.862745), # light yellow
                  summary=(0.988235, 0.964706, 0.862745), # light yellow
                  hint=(0.87843, 0.95686, 1.0),          # light blue
                  )
for _admon in ['warning', 'question', 'hint', 'notice', 'summary']:
    exec(_latex_admonition(_admon, _admon.upper(),
                           _admon, _admon2rgb[_admon]))


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
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)

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
        'citation':      r'~\\cite{\g<subst>}',
        #'linkURL':       r'\g<begin>\href{\g<url>}{\g<link>}\g<end>',
        'linkURL2':      r'\href{{\g<url>}}{\g<link>}',
        'linkURL3':      r'\href{{\g<url>}}{\g<link>}',
        'linkURL2v':     r'\href{{\g<url>}}{\\nolinkurl{\g<link>}}',
        'linkURL3v':     r'\href{{\g<url>}}{\\nolinkurl{\g<link>}}',
        'plainURL':      r'\href{{\g<url>}}{\\nolinkurl{\g<url>}}',  # cannot use \code inside \href, use \nolinkurl to handle _ and # etc. (implies verbatim font)
        'inlinecomment': r'\inlinecomment{\g<name>}{\g<comment>}',
        'chapter':       r'\n\n\chapter{\g<subst>}\n',
        'section':       r'\n\n\section{\g<subst>}\n',
        'subsection':    r'\n\subsection{\g<subst>}\n',
        #'subsubsection': '\n' + r'\subsubsection{\g<subst>}' + '\n',
        'subsubsection': r'\n\paragraph{\g<subst>.}',
        'paragraph':     r'\paragraph{\g<subst>}\n',
        #'abstract':      '\n\n' + r'\\begin{abstract}' + '\n' + r'\g<text>' + '\n' + r'\end{abstract}' + '\n\n' + r'\g<rest>', # not necessary with separate \n
        #'abstract':      r'\n\n\\begin{abstract}\n\g<text>\n\end{abstract}\n\n\g<rest>',
        'abstract':      r"""

% #if LATEX_HEADING == "Springer-collection"
\\abstract{
% #else
\\begin{abstract}
% #endif
\g<text>
% #if LATEX_HEADING == "Springer-collection"
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
        'notes':         latex_notes,
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
    TOC['latex'] = lambda s: r'\tableofcontents' + '\n\n' + r'\vspace{1cm} % after toc' + '\n\n'

    INTRO['latex'] = r"""%%
%% This file is automatically generated from doconce source
%%
%% doconce: http://code.google.com/p/doconce/
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
%% to turn myfile.p.tex into an ordinary LaTeX file myfile.tex.
%% Many preprocess options can be added:
%%
%%      ptex2tex -DBOOK -DMINTED -DPALATINO -DA6PAPER -DLATEX_HEADING=traditional myfile
%%      doconce ptex2tex myfile -DMINTED -DLATEX_HEADING=Springer-collection
% #endif

% #ifndef LATEX_HEADING
% #define LATEX_HEADING
% #endif

% #ifndef PREAMBLE
% #if LATEX_HEADING == "Springer-collection"
% #undef PREAMBLE
% #else
% #define PREAMBLE
% #endif
% #endif


% #ifdef PREAMBLE
%-------------------------- begin preamble --------------------------
% #ifdef BOOK
\documentclass[%
oneside,                 % oneside: electronic viewing, twoside: printing
final,                   % or draft (marks overfull hboxes)
chapterprefix=true,      % "Chapter" word at beginning of each chapter
open=right               % start new chapters on odd-numbered pages
10pt]{book}
% #else
\documentclass[%
oneside,                 % oneside: electronic viewing, twoside: printing
final,                   % or draft (marks overfull hboxes)
10pt]{article}
% #endif

\listfiles               % print all files needed to compile this document

% #ifdef A4PAPER
\usepackage[a4paper]{geometry}
% #endif
% #ifdef A6PAPER
% a6paper is suitable for epub-style formats
\usepackage[%
  a6paper,
  text={90mm,130mm},
  inner={5mm},              % inner margin (two-sided documents)
  top=5mm,
  headsep=4mm
  ]{geometry}
% #endif


\usepackage{relsize,epsfig,makeidx,amsmath,amsfonts}
\usepackage[latin1]{inputenc}
\usepackage{ptex2tex}
% #ifdef MINTED
\usepackage{minted}  % requires latex/pdflatex -shell-escape (to run pygments)
\usemintedstyle{default}
% #endif

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

\setcounter{tocdepth}{2}

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

\newenvironment{exercise}{}{}
\newcounter{exerno}

\newcommand{\inlinecomment}[2]{  ({\bf #1}: \emph{#2})  }
%\newcommand{\inlinecomment}[2]{}  % turn off inline comments

% insert custom LaTeX commands...

\makeindex

\begin{document}
%-------------------------- end preamble --------------------------

% #endif

"""
    if '--latex-printed' in sys.argv:
       INTRO['latex'] = INTRO['latex'].replace('oneside,', 'twoside,')

    pygm_style = 'default'
    for arg in sys.argv[1:]:
        if arg.startswith('--minted-latex-style='):
           pygm_style = arg.split('=')[1]
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
