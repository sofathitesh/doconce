# can reuse most of rst module:
from rst import *

# redefine what is not appropriate:

def sphinx_figure(m):
    result = ''
    # m is a MatchObject
    caption = m.group('caption').strip()
    m_label = re.search(r'label\{(.+?)\}', caption)
    if m_label:
        label = m_label.group(1)
        result += '\n.. _%s:\n' % label

    filename = m.group('filename')
    if not os.path.isfile(filename):
        raise IOError('no figure file %s' % filename)

    filename = os.path.splitext(filename)[0]
    result += '\n.. figure:: ' + filename + '.*\n'  # utilize flexibility
    opts = m.group('options')
    if opts:
        info = [s.split('=') for s in opts.split()]
        rst_info = ['   :%s: %s' % (option, value)  for option, value in info]
        result += '\n'.join(rst_info)
    result += '\n\n   ' + caption + '\n'
    return result


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

def sphinx_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # insert labels before all section headings:
    for label in section_label2title:
        title = section_label2title[label]
        pattern = r'(_{3,7}|={3,7})(\s*%s\s*)(_{3,7}|={3,7})' % re.escape(title)  # title may contain ? () etc.
        replacement = '.. _%s:\n\n' % label + r'\g<1>\g<2>\g<3>'
        filestr, n = re.subn(pattern, replacement, filestr)
        if n == 0:
            raise Exception('problem with substituting "%s"' % title)

    # remove label{...} from output
    filestr = re.sub(r'label\{.+?\}' + '\n', '', filestr)

    # replace all references to sections:
    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label, ':ref:`%s`' % label)
    
    from common import ref2equations
    filestr = ref2equations(filestr)
    
    # replace remaining ref{x} as :ref:`x`
    filestr = re.sub(r'ref\{(.+?)\}', ':ref:`\g<1>`', filestr)

    return filestr

def sphinx_index_bib(filestr, index, citations, bibfile):
    filestr = rst_bib(filestr, citations, bibfile)

    for word in index:
        word = word.replace('`', '')  # drop verbatim in index
        if not '!' in word:
            filestr = filestr.replace('idx{%s}' % word, 
                                      '\n.. index:: ' + word + '\n')
        else:
            word2 = word.replace('!', '; ')
            filestr = filestr.replace('idx{%s}' % word,
                                      '\n.. index::\n   pair: ' + word2 + '\n')
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
           INDEX_BIB,
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
    FIGURE_EXT['sphinx'] = FIGURE_EXT['rst']
    CROSS_REFS['sphinx'] = sphinx_ref_and_label
    INDEX_BIB['sphinx'] = sphinx_index_bib
    TABLE['sphinx'] = TABLE['rst']

    # make true copy of INLINE_TAGS_SUBST:
    INLINE_TAGS_SUBST['sphinx'] = {}
    for tag in INLINE_TAGS_SUBST['rst']:
        INLINE_TAGS_SUBST['sphinx'][tag] = INLINE_TAGS_SUBST['rst'][tag]

    # modify some tags:
    INLINE_TAGS_SUBST['sphinx']['math'] = r'\g<begin>:math:`\g<subst>`\g<end>'
    INLINE_TAGS_SUBST['sphinx']['math2'] = r'\g<begin>:math:`\g<latexmath>`\g<end>'
    INLINE_TAGS_SUBST['sphinx']['figure'] = sphinx_figure
    CODE['sphinx'] = sphinx_code  # function for typesetting code

    ARGLIST['sphinx'] = {
        'parameter': ':param',
        'keyword': ':keyword',
        'return': ':return',
        'instance variable': ':ivar',
        'class variable': ':cvar',
        'module variable': ':var',
        }


