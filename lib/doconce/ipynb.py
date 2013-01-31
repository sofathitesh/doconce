# NOTE: very experimental start

import re, sys
from common import default_movie, plain_exercise, table_analysis, \
     insert_code_and_tex
from html import html_movie
from pandoc import pandoc_table, pandoc_ref_and_label as ipynb_ref_and_label, \
     pandoc_index_bib as ipynb_index_bib, pandoc_quote as ipynb_quote

"""
Ideas:

 * Translate the standard doconce elements to markdown or latex and
   wrap with json_markdown etc.
 * Paragraph and lists are just output as std markdown text, which
   must be wrapped in json_markdown probably at the very end.
   Every piece of text that is outside the json cell structures at
   the very end must be placed inside a cell structure.
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

    # Final fixes: replace all text between cells by markdown code cells
    # Note: the patterns are overlapping so a plain re.sub will not work,
    # here we run through all blocks found and subsitute the first remaining
    # one, one by one.
    pattern = r'\},\n(.+?)\{\n    "cell_type":'
    remaining_blocks = re.findall(pattern, filestr, flags=re.DOTALL)
    def repl(m):
        text = m.group(1)
        text = json_markdown(text)
        out = """\
    },
%s    {
    "cell_type":""" % text
    for block in remaining_blocks:
        filestr = re.sub(pattern, repl, filestr, count=1, flags=re.DOTALL)

    print 'filestr after subst of remaining parts:'
    print filestr #[[[
    return filestr

def ipynb_table(table):
    return json_markdown(pandoc_table(table))



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

    FILENAME_EXTENSION['ipynb'] = '.ipynb'
    BLANKLINE['ipynb'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['ipynb'] = {
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
        'title':     r'# \g<subst>',
        'author':    ipynb_author,
        'date':      '_\g<subst>_\n',
        'chapter':       lambda m: r'# \g<subst>',
        'section':       lambda m: r'## \g<subst>',
        'subsection':    lambda m: r'### \g<subst>',
        'subsubsection': lambda m: r'#### \g<subst>',
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'abstract':      r'*\g<type>.* \g<text>\n\n\g<rest>',
        'comment':       '<!-- %s -->',
        }

    CODE['ipynb'] = ipynb_code
    ENVIRS['ipynb'] = {
        'quote':        ipynb_quote,
        }

    from common import DEFAULT_ARGLIST
    ARGLIST['ipynb'] = DEFAULT_ARGLIST
    LIST['ipynb'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': '\n'},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s\n  :   ', 'end': '\n'},

        'separator': '\n',
        }
    CROSS_REFS['ipynb'] = ipynb_ref_and_label

    TABLE['ipynb'] = ipynb_table
    INDEX_BIB['ipynb'] = ipynb_index_bib
    EXERCISE['ipynb'] = plain_exercise
    TOC['ipynb'] = lambda s: ''

    # no return, rely on in-place modification of dictionaries
