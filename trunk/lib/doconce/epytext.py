import re
from common import remove_code_and_tex, insert_code_and_tex, indent_lines

def old_epytext_code(filestr):
    # In rst syntax, code blocks are typeset with :: (verbatim)
    # followed by intended blocks. This function indents everything
    # inside code (or TeX) blocks. The code here is similar to
    # rst.rst_code, but a special epytext version was
    # necessary since epytext is fooled by \n in code/tex blocks.
    
    # first indent all code/tex blocks:
    filestr, code_blocks, tex_blocks = remove_code_and_tex(filestr)
    for i in range(len(code_blocks)):
        code_blocks[i] = indent_lines(code_blocks[i], True)
    for i in range(len(tex_blocks)):
        tex_blocks[i] = indent_lines(tex_blocks[i], True)
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, 'rst')

    # substitute !bc and !ec appropriately:
    # (see rst.rst_code for comments if problems)
    c = re.compile(r'([a-zA-Z0-9)"])[\n:.?!]\s*?!bc.*?\n', re.DOTALL)
    filestr = c.sub(r'\g<1>::\n\n', filestr)
    filestr = re.sub(r'!ec\n', '\n\n', filestr)
    #filestr = re.sub(r'!ec\n', '\n', filestr)
    #filestr = re.sub(r'!ec\n', '', filestr)
    c = re.compile(r'([a-zA-Z0-9)"])[:.]?\s*?!bt\n', re.DOTALL)
    filestr = c.sub(r'\g<1>::\n\n', filestr)
    filestr = re.sub(r'!et\n', '\n\n', filestr)
    #filestr = re.sub(r'!et\n', '\n', filestr)
    #filestr = re.sub(r'!et\n', '', filestr)
    return filestr

def define(FILENAME_EXTENSION,
           BLANKLINE,
           INLINE_TAGS_SUBST,
           CODE,
           LIST,
           ARGLIST,
           TABLE,
           FIGURE_EXT,
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)

    FILENAME_EXTENSION['epytext'] = '.epytext'
    BLANKLINE['epytext'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['epytext'] = {
        'math':      r'\g<begin>M{\g<subst>}\g<end>',
        #'math2':     r'\g<begin>M{\g<latexmath>}\g<end>', # has \ in \sin e.g. so we rather use the puretext version
        'math2':    r'\g<begin>M{\g<puretext>}\g<end>',
        'emphasize': r'\g<begin>I{\g<subst>}\g<end>',
        'bold':      r'\g<begin>B{\g<subst>}\g<end>',
        'verbatim':  r'\g<begin>C{\g<subst>}\g<end>',
        'label':     r'\g<subst>',
        'reference': r'\g<subst>',
        'linkURL':   r'\g<begin>U{\g<link><\g<url>>}\g<end>',
        'plainURL':  r'U{\g<url><\g<url>>}',
        # the replacement string differs, depending on the match object m:
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst'))),
        'paragraph':     r'I{\g<subst>} ',
        'title':         r'TITLE: \g<subst>',
        'date':          r'DATE: \g<subst>',
        'author':        r'BY: \g<name>, \g<institution>',
        }

    from rst import rst_code, rst_table
    CODE['epytext'] = rst_code
    TABLE['epytext'] = rst_table

    LIST['epytext'] = {
        'itemize':
        {'begin': '', 'item': '-', 'end': ''},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': ''},

        'description':
        {'begin': '', 'item': '%s', 'end': ''},

        'separator': '',
        } 
    ARGLIST['epytext'] = {
        'parameter': '@param',
        'keyword': '@keyword',
        'return': '@return',
        'instance variable': '@ivar',
        'class variable': '@cvar',
        'module variable': '@var',
        }

