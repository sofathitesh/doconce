import os, commands, re

def LaTeX_code(filestr, format):
    lines = filestr.splitlines()
    arg = None
    bc_arg = re.compile(r'^!bc\s+([^ ]+?)$')
    ec = re.compile(r'^!ec\s*$')
    for i in range(len(lines)):
        #if re.search(r'^![be]c', lines[i]):a
        #    print 'LaTeX_code treats line\n', lines[i]

        # !bc without argument is substituted as !bc ccq:
        lines[i] = re.sub(r'^!bc\s*$', r'!bc ccq', lines[i])
        #print 'after mod:', lines[i]

        # treat a line !bc arg:
        m = bc_arg.search(lines[i])
        if m:
            arg = m.group(1)
            #print 'yes, this is a !bc line with arg =', arg
            # add \b to arg, e.g., if arg is cod, make \bcod (ptex2tex)
            lines[i] = bc_arg.sub(r'\\b' + arg, lines[i])
            #print 'new b envir:', lines[i]
        # treat a line !ec:
        m = ec.search(lines[i])
        if m:
            #print 'yes, this is a !ec line with arg =', arg
            lines[i] = ec.sub(r'\\e' + arg, lines[i])
            #print 'new e envir:', lines[i]
            arg = None
    filestr = '\n'.join(lines)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub('\n', filestr)
    filestr = re.sub(r'!et\n', '', filestr)
    return filestr

def figure_latex(m, includegraphics=True):
    filename = m.group('filename')
    basename  = os.path.basename(filename)
    stem, ext = os.path.splitext(basename)
    root, ext = os.path.splitext(filename)
    if not ext in ('.ps', '.eps'):
        # try to convert image file to PostScript, using
        # convert from ImageMagick:
        cmd = 'convert %s ps:%s.ps' % (filename, root)
        failure, output = commands.getstatusoutput(cmd)
        if failure:
            print '\n**** Warning: could not run', cmd
        filename = root + '.ps'
    # note that label{...} are substituted by \label{...} (inline
    # label tag) so we write just label and not \label below:
    if includegraphics:
        result = r"""
\begin{figure}
  \centerline{\includegraphics[width=\linewidth]{%s}}
  \caption{label{fig:%s}
  %s
  }
\end{figure}
""" % (filename, stem, m.group('caption'))
    else:
        result = r"""
\begin{figure}
  \centerline{\psfig{figure=%s,width=\linewidth}}
  \caption{label{fig:%s}
  %s
  }
\end{figure}
""" % (filename, stem, m.group('caption'))
    return result

from common import table_analysis

def latex_table(table):
    column_width = table_analysis(table)
    ncolumns = max(len(row) for row in table)
    column_spec = 'c'*ncolumns
    s = '\n' + r'\begin{quote}\begin{tabular}{%s}' % column_spec + '\n'
    for i, row in enumerate(table):
        if row == ['horizontal rule']:
            s += r'\hline' + '\n'
        else:
            # check if this is a headline between two horizontal rules:
            if i == 1 and \
               table[i-1] == ['horizontal rule'] and \
               table[i+1] == ['horizontal rule']:
                headline = True
            else:
                headline = False

            if headline:
                row = [r'\multicolumn{1}{c}{%s}' % r for r in row]
            else:
                row = [r.ljust(w) for r, w in zip(row, column_width)]
                
            s += ' & '.join(row) + ' \\\\\n'

    s += r'\end{tabular}\end{quote}' + \
        '\n\n' + r'\noindent' + '\n'
    return s

def handle_ref_and_label(section_label2title, format, filestr):
    filestr = filestr.replace('label{', r'\label{')
    # add ~\ between chapter/section and the reference
    pattern = r'(section|chapter)(s?)\s+ref\{'
    replacement = r'\g<1>\g<2>~\ref{\\'
    filestr = re.sub(pattern, replacement, filestr, flags=re.IGNORECASE)
    # equations are ok in the doconce markup (in doconce2format we
    # make a final ref -> \ref and label -> \label

    return filestr


def define(FILENAME_EXTENSION,
           BLANKLINE,
           INLINE_TAGS_SUBST,
           CODE,
           LIST,
           ARGLIST,
           TABLE,
           FIGURE_EXT,
           CROSS_REFS,
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)
    
    FILENAME_EXTENSION['LaTeX'] = '.p.tex'
    BLANKLINE['LaTeX'] = '\n'

    INLINE_TAGS_SUBST['LaTeX'] = {
        # Note: re.sub "eats" backslashes: \t and \b will not survive to
        # latex if text goes through re.sub. Then we must write \\b and \\t here:

        'math': None,  # indicates no substitution, leave as is
        'math2':         r'\g<begin>$\g<latexmath>$\g<end>',        
        'emphasize':     r'\g<begin>\emph{\g<subst>}\g<end>',
        'bold':          r'\g<begin>\\textbf{\g<subst>}\g<end>',  # (re.sub swallows a \)
        'verbatim':      r'\g<begin>\code{\g<subst>}\g<end>',
        'citation':      r'~\\cite{\g<subst>}',
        'linkURL':       r'\g<begin>\href{\g<url>}{\g<link>}\g<end>',
        'plainURL':      r'\href{\g<url>}{\g<url>}',  # cannot use \code inside \href
        'section':       '\n\n' + r'\section*{\g<subst>}' + '\n',
        'subsection':    '\n' + r'\subsection*{\g<subst>}' + '\n',
        #'subsubsection': '\n' + r'\subsubsection*{\g<subst>}' + '\n',
        'subsubsection': r'\paragraph{\g<subst>.}' + '\n',
        'paragraph':     r'\paragraph{\g<subst>}' + '\n',
        # recall that this is regex so LaTeX commands must be treated carefully:
        'title':         r'\\title{\g<subst>}' + '\n',
        'author':        r'\\author{\g<name> \\\\ \g<institution>}' + '\n',
        'date':          r'\\date{\g<subst>}' ' \n\\maketitle\n\n',
        'figure':        figure_latex,
        'comment':       '%% %s',
        }
    # should be configureable:
    # [tex]
    # verbatim = \code{, }
    # verbatim = \verb!, !

    LIST['LaTeX'] = {
        'itemize':
        {'begin': r'\begin{itemize}' + '\n',
         'item': r'\item', 'end': r'\end{itemize}' + '\n'},

        'enumerate':
        {'begin': r'\begin{enumerate}' + '\n', 'item': r'\item',
         'end': r'\end{enumerate}' + '\n'},

        'description':
        {'begin': r'\begin{description}' + '\n', 'item': r'\item[%s]',
         'end': r'\end{description}' + '\n'},

        'separator': '',
        } 

    CODE['LaTeX'] = LaTeX_code
    ARGLIST['LaTeX'] = {
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

    FIGURE_EXT['LaTeX'] = ('.ps', '.eps')

    CROSS_REFS['LaTeX'] = handle_ref_and_label

    TABLE['LaTeX'] = latex_table

    INTRO['LaTeX'] = r"""\documentclass{article}
\usepackage{hyperref,relsize,,epsfig,a4,amsmath,amssymb}
\usepackage[latin1]{inputenc}
% required by ptex2tex:
\usepackage{graphicx,hyperref,relsize,fancyvrb,epsfig}
\usepackage{a4,amsmath,amssymb,framed,subfigure}
\usepackage[usenames]{color}
\begin{document}
"""
    newcommands_files = 'newcommands.tex', 'newcommands_replace.tex', \
                        'newcommands_keep.tex'
    for filename in newcommands_files:
        if os.path.isfile(filename):
            INTRO['LaTeX'] += r"""
\input{%s}
""" % filename
        #print '... found', 
    else:
        #print '... did not find',
        pass

    OUTRO['LaTeX'] = r"""\end{document}
"""


def fix_latex_command_regex(pattern, application='match'):
    """
    Given a pattern for a regular expression match or substitution,
    the function checks for problematic patterns commonly
    encountered when working with LaTeX texts, namely commands
    starting with a backslash. 

    For a pattern to be matched or substituted, and extra backslash is
    always needed (either a special regex construction like \w leads
    to wrong match, or \c leads to wrong substitution since \ just
    escapes c so only the c is replaced, leaving an undesired
    backslash). For the replacement pattern in a substitutions, specified
    by the application='replacement' argument, a backslash
    before any of the characters abfgnrtv must be preceeded by an
    additional backslash.

    The application variable equals 'match' if pattern is used for
    a match and 'replacement' if pattern defines a replacement
    regex in a re.sub command.

    Caveats: let pattern just contain LaTeX commands, not combination
    of commands and other regular expressions (\s, \d, etc.) as the
    latter will end up with an extra undesired backslash.

    Here are examples on failures::

    >>> re.sub(r'\begin\{equation\}', r'\[', r'\begin{equation}')
    '\\begin{equation}'
    >>> # match of mbox, not \mbox, and wrong output:
    >>> re.sub(r'\mbox\{(.+?)\}', r'\fbox{\g<1>}', r'\mbox{not}')
    '\\\x0cbox{not}'

    Here are examples on using this function:

    >>> from doconce.latex import fix_latex_command_regex as fix
    >>> pattern = fix(r'\begin\{equation\}', application='match')
    >>> re.sub(pattern, r'\[', r'\begin{equation}')
    '\\['
    >>> pattern = fix(r'\mbox\{(.+?)\}', application='match')
    >>> replacement = fix(r'\fbox{\g<1>}', application='replacement')
    >>> re.sub(pattern, replacement, r'\mbox{not}')
    '\\fbox{not}'

    Avoid mixing LaTeX commands and ordinary regular expression
    commands, e.g.::

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

