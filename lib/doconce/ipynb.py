# NOTE: very experimental start

import re, sys
from common import default_movie, plain_exercise, table_analysis, \
     insert_code_and_tex
from html import html_movie
from pandoc import pandoc_table, pandoc_ref_and_label, \
     pandoc_index_bib, pandoc_quote, pandoc_figure


def ipynb_author(authors_and_institutions, auth2index,
                 inst2index, index2inst, auth2email):
    authors = []
    for author, i, e in authors_and_institutions:
        author_str = "new_author(name=u'%s'" % author
        if i is not None:
            author_str += ", affiliation=u'%s'" % ' and '.join(i)
        if e is not None:
            author_str += ", email=u'%s'" % e
        author_str += ')'
        authors.append(author_str)
    s ='authors = [%s]' % (', '.join(authors))
    return s

def ipynb_figure(m):
    filename = m.group('filename')
    caption = m.group('caption').strip()
    text = '![%s](%s)' % (caption, filename)
    # Hack...
    text = '![%s](files/%s)' % (caption, filename)
    return text

def ipynb_code(filestr, code_blocks, code_block_types,
               tex_blocks, format):
    # Parse document into markdown text, code blocks, and tex blocks
    from common import _CODE_BLOCK, _MATH_BLOCK
    authors = ''
    blocks = [[]]
    for line in filestr.splitlines():
        if line.startswith('authors = [new_author(name='):
            authors = line
        elif _CODE_BLOCK in line:
            blocks[-1] = '\n'.join(blocks[-1]).strip()
            blocks.append(line)
        elif _MATH_BLOCK in line:
            blocks[-1] = '\n'.join(blocks[-1]).strip()
            blocks.append(line)
        else:
            if not isinstance(blocks[-1], list):
                blocks.append([])
            blocks[-1].append(line)
    if isinstance(blocks[-1], list):
        blocks[-1] = '\n'.join(blocks[-1]).strip()


    # Add block type info
    pattern = r'(\d+) +%s'
    for i in range(len(blocks)):
        if re.match(pattern % _CODE_BLOCK, blocks[i]):
            blocks[i] = ['code', blocks[i]]
        elif re.match(pattern % _MATH_BLOCK, blocks[i]):
            blocks[i] = ['math', blocks[i]]
        else:
            blocks[i] = ['text', blocks[i]]

    # Go through tex_blocks and wrap in $$
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
        eq_type = 'heading'  # or '$$'
        eq_type = '$$'
        # Markdown: add $$ on each side of the equation
        if eq_type == '$$':
            # Make sure there are no newline after equation
            tex_blocks[i] = '$$\n' + tex_blocks[i].strip() + '\n$$'
        # Here: use heading (###) and simple formula (remove newline
        # in math expressions to keep everything within a heading) as
        # the equation then looks bigger
        elif eq_type == 'heading':
            tex_blocks[i] = '### $ ' + '  '.join(tex_blocks[i].splitlines()) + ' $'

    # blocks is now a list of text chunks in markdown and math/code line
    # instructions. Insert code and tex blocks
    for i in range(len(blocks)):
        if _CODE_BLOCK in blocks[i][1] or _MATH_BLOCK in blocks[i][1]:
            words = blocks[i][1].split()
            # start of blocks[i]: number block-indicator code-type
            n = int(words[0])
            if _CODE_BLOCK in blocks[i][1]:
                blocks[i][1] = code_blocks[n]
            if _MATH_BLOCK in blocks[i][1]:
                blocks[i][1] = tex_blocks[n]

    # Make IPython structures
    from IPython.nbformat.v3 import (
         NotebookNode,
         new_code_cell, new_text_cell, new_worksheet, new_notebook, new_output,
         new_metadata, new_author)
    import IPython.nbformat.v3.nbjson
    ws = new_worksheet()
    prompt_number = 1
    for block_tp, block in blocks:
        if block_tp == 'text' or block_tp == 'math':
            ws.cells.append(new_text_cell(u'markdown', source=block))
        elif block_tp == 'code':
            ws.cells.append(new_code_cell(input=block,
                                          prompt_number=prompt_number,
                                          collapsed=False))
    # Catch the title as the first heading
    m = re.search(r'^#+\s*(.+)$', filestr, flags=re.MULTILINE)
    title = m.group(1).strip() if m else ''
    if authors:
        exec(authors)
        md = new_metadata(name=title, authors=authors)
    else:
        md = new_metadata(name=title)
    nb = new_notebook(worksheets=[ws], metadata=new_metadata())

    # Convert nb to json format
    filestr = IPython.nbformat.v3.nbjson.writes(nb)

    # must do the replacements here at the very end when json is written out
    # \eqref and labels will not work, but labels do no harm
    filestr = filestr.replace(' label{', ' \\\\label{')
    pattern = r'^label\{'
    filestr = re.sub(pattern, '\\\\label{', filestr, flags=re.MULTILINE)
    # \eqref crashes the notebook
    #filestr = re.sub(r'\(ref\{(.+?)\}\)', r'\eqref{\g<1>}', filestr)
    filestr = re.sub(r'\(ref\{(.+?)\}\)', r'Eq (\g<1>)', filestr)

    '''
    # Final fixes: replace all text between cells by markdown code cells
    # Note: the patterns are overlapping so a plain re.sub will not work,
    # here we run through all blocks found and subsitute the first remaining
    # one, one by one.
    pattern = r'   \},\n(.+?)\{\n    "cell_type":'
    begin_pattern = r'^(.+?)\{\n    "cell_type":'
    remaining_block_begin = re.findall(begin_pattern, filestr, flags=re.DOTALL)
    remaining_blocks = re.findall(pattern, filestr, flags=re.DOTALL)
    import string
    for block in remaining_block_begin + remaining_blocks:
        filestr = string.replace(filestr, block, json_markdown(block) + '   ',
                                 maxreplace=1)
    filestr_end = re.sub(r'   \{\n    "cell_type": .+?\n   \},\n', '', filestr,
                         flags=re.DOTALL)
    filestr = filestr.replace(filestr_end, json_markdown(filestr_end))
    filestr = """{
 "metadata": {
  "name": "SOME NAME"
 },
 "nbformat": 3,
 "nbformat_minor": 0,
 "worksheets": [
  {
   "cells": [
""" + filestr.rstrip() + '\n'+ \
    json_pycode('', final_prompt_no+1, 'python').rstrip()[:-1] + """
   ],
   "metadata": {}
  }
 ]
}"""
    '''
    return filestr


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

    FILENAME_EXTENSION['ipynb'] = '.ipynb'
    BLANKLINE['ipynb'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['ipynb'] = {
        'math':      None,  # indicates no substitution, leave as is
        'math2':     r'\g<begin>$\g<latexmath>$\g<end>',
        'emphasize': None,
        'bold':      None,
        'figure':    ipynb_figure,
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
        'abstract':      r'\n*\g<type>.* \g<text>\n\n\g<rest>',
        'comment':       '<!-- %s -->',
        }

    CODE['ipynb'] = ipynb_code
    ENVIRS['ipynb'] = {
        'quote':        pandoc_quote,
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
    CROSS_REFS['ipynb'] = pandoc_ref_and_label

    TABLE['ipynb'] = pandoc_table
    INDEX_BIB['ipynb'] = pandoc_index_bib
    EXERCISE['ipynb'] = plain_exercise
    TOC['ipynb'] = lambda s: ''
    FIGURE_EXT['ipynb'] = ('.png', '.gif', '.jpg', '.jpeg', '.tif', '.tiff', '.pdf')

    # no return, rely on in-place modification of dictionaries
