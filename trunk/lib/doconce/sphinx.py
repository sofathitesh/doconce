# can reuse most of rst module:
from rst import *

# redefine what is not appropriate:

def sphinx_code(filestr, format):
    # In rst syntax, code blocks are typeset with :: (verbatim)
    # followed by intended blocks. This function indents everything
    # inside code (or TeX) blocks.
    
    # first indent all code/tex blocks:
    filestr, code_blocks, tex_blocks = remove_code_and_tex(filestr)
    for i in range(len(code_blocks)):
        code_blocks[i] = indent_lines(code_blocks[i], format)
    for i in range(len(tex_blocks)):
        tex_blocks[i] = indent_lines(tex_blocks[i], format)
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, 'rst')

    filestr = re.sub(r'!bc *[a-z]*\n', '\n.. code-block:: python\n\n', filestr)
    filestr = re.sub(r'!ec\n', '\n\n', filestr)
    #filestr = re.sub(r'!ec\n', '\n', filestr)
    #filestr = re.sub(r'!ec\n', '', filestr)
    filestr = re.sub(r'!bt\n', '\n.. math::\n\n', filestr)
    filestr = re.sub(r'!et\n', '\n\n', filestr)

    # fix latex constructions that do not work with sphinx math
    commands = [r'\begin{equation}',
                r'\end{equation}',
                r'\begin{eqnarray}',
                r'\end{eqnarray}',
                r'\begin{eqnarray*}',
                r'\end{eqnarray*}',
                r'\begin{align}',
                r'\end{align}',
                r'\[',
                r'\]',
                # some common abbreviations (newcommands):
                r'\beq',
                r'\eeq',
                r'\beqa',
                r'\eeqa',
                r'\beqan',
                r'\eeqan',
                ]
    for command in commands:
        filestr = filestr.replace(command, '')
    filestr = re.sub('&\s*=\s*&', ' &= ', filestr)
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
    if not 'rst' in BLANKLINE:
        # rst.define is not yet ran on these dictionaries, do it:
        import rst
        rst.define(FILENAME_EXTENSION,
                   BLANKLINE,
                   INLINE_TAGS_SUBST,
                   CODE,
                   LIST,
                   ARGLIST,
                   TABLE,
                   FIGURE_EXT,
                   INTRO,
                   OUTRO)

    FILENAME_EXTENSION['sphinx'] = FILENAME_EXTENSION['rst']
    BLANKLINE['sphinx'] = BLANKLINE['rst']
    CODE['sphinx'] = CODE['rst']
    LIST['sphinx'] = LIST['rst']
    ARGLIST['sphinx'] = ARGLIST['rst']
    FIGURE_EXT['sphinx'] = FIGURE_EXT['rst']
    TABLE['sphinx'] = TABLE['rst']

    # make true copy of INLINE_TAGS_SUBST:
    INLINE_TAGS_SUBST['sphinx'] = {}
    for tag in INLINE_TAGS_SUBST['rst']:
        INLINE_TAGS_SUBST['sphinx'][tag] = INLINE_TAGS_SUBST['rst'][tag]

    # modify some:
    INLINE_TAGS_SUBST['sphinx']['math'] = r'\g<begin>:math:`\g<subst>`\g<end>'
    INLINE_TAGS_SUBST['sphinx']['math2'] = r'\g<begin>:math:`\g<latexmath>`\g<end>'
    CODE['sphinx'] = sphinx_code  # function for typesetting code

