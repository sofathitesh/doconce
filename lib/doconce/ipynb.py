# NOTE: very experimental start...very unfinished.

import re, sys
from common import default_movie, plain_exercise, table_analysis, \
     insert_code_and_tex
from html import html_movie

"""
Ideas:

 * Translate the standard doconce elements to markdown or latex and
   wrap with json_markdown etc.
 * Paragraph and lists are just output as std markdown text, which
   must be wrapped in json_markdown probably at the very end.
   Every piece of text that is outside the json cell structures at
   the very end must be placed inside a cell structure.
   It should be recognizable as r'\},\n(.+?)\{\n    "cell_type":', re.DOTALL
   and re.sub can have a function here for subst that gets the m (match obj)
   and wraps m.group(1) in json_markdown.
"""

def json_markdown(text):
    """Return a string (text) as a json markdown cell."""
    lines = text.splitlines()
    out = """\
   {
    "cell_type": "markdown",
    "metadata": {},
    "source": [
%s
    ]
   },
""" % '\n'.join([r'    "%s\n",' % line for line in lines[:-1]] +
                [r'    "%s"' % lines[-1]])
    return out

def json_pycode(code_block, prompt_number, language='python'):
    """Return a code string (code_block) as a json code cell."""
    lines = code_block.splitlines()
    out = """\
   {
    "cell_type": "code",
    "collapsed": false,
    "metadata": {},
    "input": [
%s
    ],
    "language": "%s",
    "metadata": {},
    "outputs": [],
    "prompt_number": %s
   },
""" % ('\n'.join([r'    "%s\n",' % line for line in lines[:-1]] +
                 [r'    "%s"' % lines[-1]]), language, prompt_number)
    return out

def ipynb_author(authors_and_institutions, auth2index,
                 inst2index, index2inst, auth2email):
    # List authors on multiple lines
    authors = []
    for author, i, e in authors_and_institutions:
        if i is None:
            authors.append(author)
        else:
            authors.append(author + ' at ' + ' and '.join(i))
    text = ''
    if len(authors) == 1:
        text += 'Author: '
    else:
        text += 'Authors: '
    text += ',  '.join(authors) + '\n'
    return json_markdown(text)


def ipynb_code(filestr, code_blocks, code_block_types,
               tex_blocks, format):
    for i in range(len(code_blocks)):
        code_blocks[i] = json_pycode(code_blocks[i], i+1, 'python')

    # go through tex_blocks and wrap in $$ and then as json_markdown cell
    for i in range(len(tex_blocks)):
        # Remove \[ and \] in single equations
        tex_blocks[i] = tex_blocks[i].replace(r'\[', '')
        tex_blocks[i] = tex_blocks[i].replace(r'\]', '')
        # Check for illegal environments
        m = re.search(r'\\begin\{(.+?)\}', tex_blocks[i])
        if m:
            envir = m.group(1)
            if envir not in ('equation', 'align*', 'align'):
            print """\
*** warning: latex envir \\begin{%s} does not work well:
    pandoc-extended markdown syntax handles only single equations
    (but doconce splits align environments into single equations).
    Labels in equations do not work with pandoc-extended markdown
    output.
""" % envir
        # Add $$ on each side of the equation
        tex_blocks[i] = json_markdown('$$\n' + tex_blocks[i] + '\n$$')

    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)


    filestr = re.sub(r'^!bc.*$', '', filestr, flags=re.MULTILINE)
    filestr = re.sub(r'^!ec *$', '', filestr, flags=re.MULTILINE)
    filestr = re.sub(r'^!bt *$', '', filestr, flags=re.MULTILINE)
    filestr = re.sub(r'^!et *$', '', filestr, flags=re.MULTILINE)

    # \eqref and labels will not work, but labels do no harm
    filestr = filestr.replace(' label{', ' \\label{')
    pattern = r'^label\{'
    filestr = re.sub(pattern, '\\label{', filestr, flags=re.MULTILINE)
    filestr = re.sub(r'\(ref\{(.+?)\}\)', r'\eqref{\g<1>}', filestr)

    # Final fixes

    # Seems that title and author must appear on the very first lines
    filestr = filestr.lstrip()

    return filestr

def ipynb_table(table):
    """

    Simple markdown tables look like this::

        Left         Right   Center     Default
        -------     ------ ----------   -------
        12              12     12            12
        123            123     123          123
        1                1      1             1

    """
    # Slight modification of rst_table
    # Here is the pandoc table format

    column_width = table_analysis(table['rows'])
    ncolumns = len(column_width)
    column_spec = table.get('columns_align', 'c'*ncolumns).replace('|', '')
    heading_spec = table.get('headings_align', 'c'*ncolumns).replace('|', '')
    a2py = {'r': 'rjust', 'l': 'ljust', 'c': 'center'}
    s = ''  # '\n'
    for i, row in enumerate(table['rows']):
        #s += '    '  # indentation of tables
        if row == ['horizontal rule'] and i > 0 and i < len(table['rows'])-1:
            # No horizontal rule at the top and bottom, just after heading
            for w in column_width:
                s += '-'*w + '  '
        else:
            # check if this is a headline between two horizontal rules:
            if i == 1 and \
               table['rows'][i-1] == ['horizontal rule'] and \
               table['rows'][i+1] == ['horizontal rule']:
                headline = True
            else:
                headline = False

            for w, c, ha, ca in \
                    zip(column_width, row, heading_spec, column_spec):
                if headline:
                    s += getattr(c, a2py[ha])(w) + '  '
                elif row != ['horizontal rule']:
                    s += getattr(c, a2py[ca])(w) + '  '
        s += '\n'
    s += '\n'
    return json_markdown(s)

def ipynb_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    # Remove Exercise, Project, Problem in references since those words
    # are used in the title of the section too
    pattern = r'(the\s*)?([Ee]xercises?|[Pp]rojects?|[Pp]roblems?)\s+ref\{'
    replacement = r' ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # Remove label{...} from output (when only label{} on a line, remove
    # the newline too, leave label in figure captions, and remove all the rest)
    #filestr = re.sub(r'^label\{.+?\}\s*$', '', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^label\{.+?\}\s*$', flags=re.MULTILINE)
    filestr = cpattern.sub('', filestr)
    #filestr = re.sub(r'^(FIGURE:.+)label\{(.+?)\}', '\g<1>{\g<2>}', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^(FIGURE:.+)label\{(.+?)\}', flags=re.MULTILINE)
    filestr = cpattern.sub('\g<1>{\g<2>}', filestr)
    filestr = re.sub(r'label\{.+?\}', '', filestr)  # all the remaining

    # Replace all references to sections. Pandoc needs a coding of
    # the section header as link.
    def title2pandoc(title):
        # http://johnmacfarlane.net/pandoc/README.html
        for c in ('?', ';', ':'):
            title = title.replace(c, '')
        title = title.replace(' ', '-').strip()
        start = 0
        for i in range(len(title)):
            if title[i].isalpha():
                start = i
        title = title[start:]
        title = title.lower()
        if not title:
            title = 'section'
        return title

    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label,
                  '[%s](#%s)' % (section_label2title[label],
                                 title2pandoc(section_label2title[label])))

    return filestr


def ipynb_index_bib(filestr, index, citations, bibfile):
    # pandoc citations are of the form
    # bla-bla, see [@Smith04, ch. 1; @Langtangen_2008]
    # Method: cite{..} -> [...], doconce.py has already fixed @ and ;
    filestr = re.sub(r'cite\{(.+?)\}', r'[\g<1>]', filestr)

    #filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^BIBFILE:.+$', flags=re.MULTILINE)
    filestr = cpattern.sub('# References', filestr)

    # pandoc does not support index entries,
    # remove all index entries

    filestr = re.sub(r'idx\{.+?\}' + '\n?', '', filestr)
    return filestr

def ipynb_quote(block, format):
    # block quotes in pandoc start with "> "
    lines = []
    for line in block.splitlines():
        lines.append('> ' + line)
    return '\n'.join(lines) + '\n\n'

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

    FILENAME_EXTENSION['pandoc'] = '.md'
    BLANKLINE['pandoc'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['pandoc'] = {
        'math':      None,  # indicates no substitution, leave as is
        'math2':     r'\g<begin>$\g<latexmath>$\g<end>',
        'emphasize': None,
        'bold':      None,
        'figure':    r'![\g<caption>](\g<filename>)',
        #'movie':     default_movie,
        'movie':     html_movie,
        'verbatim':  None,
        #'linkURL':   r'\g<begin>\g<link> (\g<url>)\g<end>',
        'linkURL2':  r'[\g<link>](\g<url>)',
        'linkURL3':  r'[\g<link>](\g<url>)',
        'linkURL2v': r'[`\g<link>`](\g<url>)',
        'linkURL3v': r'[`\g<link>`](\g<url>)',
        'plainURL':  r'<\g<url>>',
        # "Reference links" in pandoc are not yet supported
        'title':     r'% \g<subst>',
        'author':    ipynb_author,
        'date':      '% \g<subst>\n',
        'chapter':       lambda m: r'\g<subst>\n%s' % ('%'*len(m.group('subst').decode('utf-8'))),
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('utf-8'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst').decode('utf-8'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst').decode('utf-8'))),
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'abstract':      r'*\g<type>.* \g<text>\n\n\g<rest>',
        'comment':       '<!-- %s -->',
        }

    CODE['pandoc'] = ipynb_code
    ENVIRS['pandoc'] = {
        'quote':        ipynb_quote,
        }

    from common import DEFAULT_ARGLIST
    ARGLIST['pandoc'] = DEFAULT_ARGLIST
    LIST['pandoc'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': '\n'},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s\n  :   ', 'end': '\n'},

        'separator': '\n',
        }
    CROSS_REFS['pandoc'] = ipynb_ref_and_label

    TABLE['pandoc'] = ipynb_table
    INDEX_BIB['pandoc'] = ipynb_index_bib
    EXERCISE['pandoc'] = plain_exercise
    TOC['pandoc'] = lambda s: '# Table of contents: Run pandoc with --toc option'

    # no return, rely on in-place modification of dictionaries
