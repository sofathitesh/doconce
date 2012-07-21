# -*- coding: iso-8859-15 -*-

import os, commands, re, sys
from common import plain_exercise, table_analysis
additional_packages = ''  # comma-sep. list of packages for \usepackage{}

def latex_code(filestr, format):
    lines = filestr.splitlines()
    arg = None
    args = []  # list of arg values in "!bc arg" lines; used for warning
    bc_arg = re.compile(r'^!bc\s+([^ ]+?)$')
    ec = re.compile(r'^!ec\s*$')
    for i in range(len(lines)):
        #if re.search(r'^![be]c', lines[i]):a
        #    print 'latex_code treats line\n', lines[i]

        # !bc without argument is substituted as !bc ccq:
        lines[i] = re.sub(r'^!bc\s*$', r'!bc ccq', lines[i])
        #print 'after mod:', lines[i]

        # treat a line !bc arg:
        m = bc_arg.search(lines[i])
        if m:
            arg = m.group(1)
            #print 'yes, this is a !bc line with arg =', arg
            args.append(arg)
            # add \b to arg, e.g., if arg is cod, make \bcod (ptex2tex)
            lines[i] = bc_arg.sub(r'\\b' + arg, lines[i])
            #print 'new b envir:', lines[i]
        # treat a line !ec:
        m = ec.search(lines[i])
        if m:
            #print 'yes, this is a !ec line with arg =', arg
            if arg == None:
                print '\n'.join(lines[:i+1])
                print '\n\nError: !ec with a non-matching !bc before, '\
                      'see print out above, up to the problematic line.'
                sys.exit(1)
            lines[i] = ec.sub(r'\\e' + arg, lines[i])
            #print 'new e envir:', lines[i]
            arg = None
    filestr = '\n'.join(lines)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    #filestr = c.sub('\n', filestr)  # why an extra \n?
    filestr = c.sub('', filestr)
    filestr = re.sub(r'!et\n', '', filestr)

    # Check for misspellings
    envirs = 'pro pypro cypro cpppro cpro fpro plpro shpro mpro cod pycod cycod cppcod ccod fcod plcod shcod mcod rst cppans pyans fans bashans swigans uflans sni dat dsni sys slin ipy rpy plin ver warn rule summ ccq cc ccl py'.split()
    for arg in args:
        if arg not in envirs:
            print 'Warning: found "!bc %s", but %s is not a predefined ptex2tex environment' % (arg, arg)

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
    # `verbatim text` in backquotes does not work so we need to substitute
    # by \texttt{}, and underscores need a backslash
    verbatim_text = re.findall(r'(`[^`]+?`)', caption)
    verbatim_text_new = []
    for words in verbatim_text:
        new_words = words
        if '_' in new_words:
            new_words = new_words.replace('_', r'\_')
        # Replace backquotes by {\rm\texttt{}}
        new_words = r'{\rm\texttt{' + new_words[1:-1] + '}}'
        verbatim_text_new.append(new_words)
    for from_, to_ in zip(verbatim_text, verbatim_text_new):
        caption = caption.replace(from_, to_)
    if caption:
        result = r"""
\begin{figure}
  %s
  \caption{
  %s
  }
\end{figure}
""" % (includeline, caption)
    else:
        # drop caption
        result = r"""
\begin{figure}
  %s
  %%\caption{}
\end{figure}
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
                row = [r'\multicolumn{1}{%s}{%s}' % (a, r) \
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
    default_title = r' \\\\ [1.5mm] '.join(textwrap.wrap(title, width=38))

    text = fix_latex_command_regex(pattern=r"""

%% #ifndef LATEX_HEADING
%% #define LATEX_HEADING
%% #endif

%% ----------------- Title -------------------------
%% #if LATEX_HEADING == "traditional"

\title{%s}

%% #elif LATEX_HEADING == "titlepage"

\thispagestyle{empty}
\hbox{\ \ }
\vfill
\begin{center}
{\huge{\bfseries{%s}}}

%% #else

\begin{center}
{\LARGE\bf %s}
\end{center}

%% #endif
""" % (title, title, default_title), application='replacement')
    return text

def latex_author(authors_and_institutions, auth2index,
                 inst2index, index2inst, auth2email):
    text = r"""

% ----------------- Author(s) -------------------------
% #if LATEX_HEADING == "traditional"
\author{"""

    # Traditional latex heading
    author_command = []
    for a, i, e in authors_and_institutions:
        a_text = a
        if e is not None:
            e = e.replace('_', r'\_')
            name, adr = e.split('@')
            #e_text = r'Email: \texttt{%s} at \texttt{%s}' % (name, adr)
            e_text = r'Email: \texttt{%s@%s}' % (name, adr)
        else:
            e_text = ''
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
            a_text += '.}'
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
    for author in auth2index: # correct order of authors
        email = auth2email[author]
        if email is None:
            email_text = ''
        else:
            email = email.replace('_', r'\_')
            name, adr = email.split('@')
            #email_text = r' (\texttt{%s} at \texttt{%s})' % (name, adr)
            email_text = r' (\texttt{%s@%s})' % (name, adr)
        text += r"""
{\Large\textsf{%s${}^{%s}$%s}}\\ [3mm]
""" % (author, str(auth2index[author])[1:-1], email_text)
    text += r"""
\ \\ [2mm]
"""
    for index in index2inst:
        text += r"""
{\large\textsf{${}^%d$%s} \\ [1.5mm]}""" % \
                (index, index2inst[index])

    text += r"""

% #else
"""
    for author in auth2index: # correct order of authors
        email = auth2email[author]
        if email is None:
            email_text = ''
        else:
            email = email.replace('_', r'\_')
            name, adr = email.split('@')
            #email_text = r' (\texttt{%s} \emph{at} \texttt{%s})' % (name, adr)
            email_text = r' (\texttt{%s@%s})' % (name, adr)
        text += r"""
\begin{center}
{\bf %s${}^{%s}$%s} \\ [0mm]
\end{center}

""" % (author, str(auth2index[author])[1:-1], email_text)

    text += r'\begin{center}' + '\n' + '% List of all institutions:\n'
    for index in index2inst:
        text += r"""\centerline{{\small ${}^%d$%s}}""" % \
                (index, index2inst[index]) + '\n'

    text += r"""\end{center}
% #endif
% ----------------- End of author(s) -------------------------

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
    # This one is not good enough for verbatim `LaTeX`:
    #filestr = re.sub(r'\bLaTeX\b', r'{\LaTeX}', filestr)

    # handle & (Texas A&M -> Texas A{\&}M):
    filestr = re.sub(r'([A-Za-z])\s*&\s*([A-Za-z])', r'\g<1>{\&}\g<2>', filestr)

    # handle non-English characters:
    chars = {'�': r'{\ae}', '�': r'{\o}', '�': r'{\aa}',
             '�': r'{\AE}', '�': r'{\O}', '�': r'{\AA}',
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
             r'e\.g\.', r'E\.g\.', r'i\.e\.', r'Approx\.', r'approx\.'
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
            # verbatim typesetting:
            word = re.sub(r'^(.*)`([^`]+)`(.*)$',
            fix_latex_command_regex(r'\g<1>\g<2>@\g<1>{\rm\texttt{\g<2>}}\g<3>',
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
    s = ''  # result string
    if not 'heading' in exer:
        print 'Wrong formatting of exercise, not a 3/5 === type heading'
        print exer
        sys.exit(1)

    # Reuse plan_exercise (std doconce formatting) where possible
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
        #'verbatim':      r'\g<begin>{\footnotesize{10pt}{10pt}\verb!\g<subst>!\g<end>',
        'citation':      r'~\\cite{\g<subst>}',
        'linkURL':       r'\g<begin>\href{\g<url>}{\g<link>}\g<end>',
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
        #'abstract':      '\n\n' + r'\\begin{abstract}' + '\n' + r'\g<text>' + '\n' + r'\end{abstract}' + '\n\n' + r'\g<rest>',
        'abstract':      r'\n\n\\begin{abstract}\n\g<text>\n\end{abstract}\n\n\g<rest>',
        # recall that this is regex so latex commands must be treated carefully:
        #'title':         r'\\title{\g<subst>}' + '\n', # we don'e use maketitle
        'title':         latex_title,
        'author':        latex_author,
        #'date':          r'\\date{\g<subst>}' ' \n\\maketitle\n\n',
        'date':          fix_latex_command_regex(pattern=r"""

% ----------------- Date -------------------------

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

% #endif
""", application='replacement'),
        'figure':        latex_figure,
        'movie':         latex_movie,
        'comment':       '%% %s',
        }
    # should be configureable:
    # [tex]
    # verbatim = \code{, }
    # verbatim = \verb!, !

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

    INTRO['latex'] = r"""%%
%% Automatically generated ptex2tex (extended LaTeX) file
%% from Doconce source
%% http://code.google.com/p/doconce/
%%

% #ifdef BOOK
\documentclass{book}
% #else
\documentclass{article}
% #endif

\usepackage{relsize,epsfig,makeidx,amsmath,amsfonts}
\usepackage[latin1]{inputenc}
\usepackage{ptex2tex}
% #ifdef MOVIE15
\usepackage{movie15}
% #endif
% #ifdef MINTED
\usepackage{minted}  % requires latex/pdflatex -shell-escape (to run pygments)
% #endif

% #ifdef HELVETICA
% Set helvetica as the default font family:
\RequirePackage{helvet}
\renewcommand\familydefault{phv}
% #endif
% #ifdef PALATINO
% Set paraltino as the default font family:
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

\newcommand{\inlinecomment}[2]{  ({\bf #1}: \emph{#2})  }
%\newcommand{\inlinecomment}[2]{}  % turn off inline comments

\makeindex

\begin{document}

"""
    newcommands_files = 'newcommands.tex', 'newcommands_replace.tex', \
                        'newcommands_keep.tex'
    for filename in newcommands_files:
        pfilename = filename[:-4] + '.p.tex'
        if os.path.isfile(filename) or os.path.isfile(pfilename):
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

\printindex

\end{document}
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

