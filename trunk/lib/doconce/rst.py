import re, os
from common import remove_code_and_tex, insert_code_and_tex, indent_lines, \
    table_analysis

# replacement patterns for substitutions of inline tags
def rst_figure(m):
    result = ''
    # m is a MatchObject
    caption = m.group('caption').strip()
    m_label = re.search(r'label\{(.+?)\}', caption)
    if m_label:
        label = m.group(1)
        result += '\n.. _%s:\n' % label

    filename = m.group('filename')
    result += '\n.. figure:: ' + filename + '\n'  # utilize flexibility
    opts = m.group('options')
    if opts:
        info = [s.split('=') for s in opts.split()]
        rst_info = ['   :%s: %s' % (option, value)  for option, value in info]
        result += '\n'.join(rst_info)
    result += '\n\n   ' + caption + '\n'
    return result

# these global patterns are used in st, epytext, plaintext as well:
bc_regex_pattern = r'([a-zA-Z0-9)"`.])[\n:.?!, ]\s*?!bc.*?\n'
bt_regex_pattern = r'([a-zA-Z0-9)"`.])[\n:.?!, ]\s*?!bt.*?\n'

def rst_code(filestr, format):
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

    # substitute !bc and !ec appropriately:
    # the line before the !bc block must end in [a-zA-z0-9)"]
    # followed by [\n:.?!,] see the bc_regex_pattern global variable above
    # (problems with substituting !bc and !bt may be caused by
    # missing characters in these two families)
    c = re.compile(bc_regex_pattern, re.DOTALL)
    filestr = c.sub(r'\g<1>::\n\n', filestr)
    filestr = re.sub(r'!ec\n', '\n\n', filestr)
    #filestr = re.sub(r'!ec\n', '\n', filestr)
    #filestr = re.sub(r'!ec\n', '', filestr)

    #c = re.compile(r'([a-zA-Z0-9)"])[:.]?\s*?!bt\n', re.DOTALL)
    #filestr = c.sub(r'\g<1>:\n\n', filestr)
    #filestr = re.sub(r'!bt\n', '.. latex-math::\n\n', filestr)
    #filestr = re.sub(r'!bt\n', '.. latex::\n\n', filestr)

    # just use the same substitution as for code blocks:
    c = re.compile(bt_regex_pattern, re.DOTALL)
    filestr = c.sub(r'\g<1>::\n\n', filestr)
    filestr = re.sub(r'!et\n', '\n\n', filestr)

    # sphinx math:
    #filestr = re.sub(r'!bt\n', '\n.. math::\n\n', filestr)
    #filestr = re.sub(r'!et\n', '\n\n', filestr)

    #filestr = re.sub(r'!et\n', '\n', filestr)
    #filestr = re.sub(r'!et\n', '', filestr)
    return filestr

    
def rst_table(table):
    column_width = table_analysis(table)
    s = ''  # '\n'
    for i, row in enumerate(table):
        #s += '    '  # indentation of tables
        if row == ['horizontal rule']:
            for w in column_width:
                s += '='*w + '  '
        else:
            # check if this is a headline between two horizontal rules:
            if i == 1 and \
               table[i-1] == ['horizontal rule'] and \
               table[i+1] == ['horizontal rule']:
                headline = True
            else:
                headline = False

            for w, c in zip(column_width, row):
                if headline:
                    s += c.center(w) + '  '
                else:
                    s += c.ljust(w) + '  '
        s += '\n'
    s += '\n'
    return s
    
def rst_author(authors_and_institutions, auth2index, 
               inst2index, index2inst):
    authors = ', '.join([author for author, i in authors_and_institutions])
    text = ':Author: ' + authors + '\n\n'
    # we skip institutions in rst
    return text

def rst_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # insert labels before all section headings: (not necessary, but ok)
    for label in section_label2title:
        title = section_label2title[label]
        pattern = r'(_{3,7}|={3,7})(\s*%s\s*)(_{3,7}|={3,7})' % re.escape(title)  # title may contain ? () etc.
        replacement = '.. _%s:\n\n' % label + r'\g<1>\g<2>\g<3>'
        filestr, n = re.subn(pattern, replacement, filestr)
        if n == 0:
            raise Exception('problem with substituting "%s"' % title)

    # remove label{...} from output
    filestr = re.sub(r'label\{.+?\}' + '\n?', '', filestr)

    # replace all references to sections:
    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label,
                                  '`%s`_' % section_label2title[label])
    
    from common import ref2equations
    filestr = ref2equations(filestr)
    
    return filestr

def rst_bib(filestr, citations, bibfile):
    for label in citations:
        filestr = filestr.replace('cite{%s}' % label, '[%s]_' % label)
    if 'rst' in bibfile:
        f = open(bibfile['rst'], 'r');  bibtext = f.read();  f.close()
        filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, 
                         flags=re.MULTILINE)
    return filestr

def rst_index_bib(filestr, index, citations, bibfile):
    filestr = rst_bib(filestr, citations, bibfile)

    # reStructuredText does not have index/glossary
    filestr = re.sub(r'idx\{.+?\}' + '\n?', '', filestr)

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
    # all arguments are dicts and accept in-place modifications (extensions)
    
    FILENAME_EXTENSION['rst'] = '.rst'
    BLANKLINE['rst'] = '\n'

    INLINE_TAGS_SUBST['rst'] = {
        'math':      r'\g<begin>\g<subst>\g<end>',
        'math2':     r'\g<begin>\g<puretext>\g<end>',
        #'math':      r'\g<begin>:math:`\g<subst>`\g<end>',  # sphinx
        #'math2':     r'\g<begin>:math:`\g<latexmath>`\g<end>',
        'emphasize': None,  # => just use doconce markup (*emphasized words*)
        'bold':      r'\g<begin>**\g<subst>**\g<end>',
        'verbatim':  r'\g<begin>``\g<subst>``\g<end>',
        'label':     r'\g<subst>',  # should be improved, rst has cross ref
        'reference': r'\g<subst>',
        'linkURL':   r'\g<begin>`\g<link> <\g<url>>`_\g<end>',
        #'linkURL':   r'\g<begin>`\g<link>`_\g<end>' + '\n\n.. ' + r'_\g<link>: \g<url>' + '\n\n',  # better (?): make function instead that stacks up the URLs and dumps them at the end; can be used for citations as well
        'plainURL':  r'`<\g<url>>`_',
        # the replacement string differs, depending on the match object m:
        # (note len(m.group('subst')) gives wrong length for non-ascii strings,
        # better with m.group('subst').decode('utf-8'))
        #'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst'))),
        #'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst'))),
        #'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst'))),
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('utf-8'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst').decode('utf-8'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst').decode('utf-8'))),
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'title':         r'======= \g<subst> =======\n',  # doconce top section, is later replaced
        'date':          r':Date: \g<subst>' + '\n',
        'author':        rst_author,
        'figure':        rst_figure,
        #'comment':       '.. %s',  # rst does not like empty comment lines:
        # so therefore we introduce a function to remove empty comment lines
        'comment':       lambda c: '' if c.isspace() or c == '' else '.. %s' % c
        }

    CODE['rst'] = rst_code  # function for typesetting code

    LIST['rst'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': '\n'},
        # lists must end with a blank line - we insert one extra,

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s', 'end': '\n'},

        'separator': '\n', 
        }
    from common import DEFAULT_ARGLIST
    ARGLIST['rst'] = DEFAULT_ARGLIST
    FIGURE_EXT['rst'] = ('.ps', '.eps', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['rst'] = rst_ref_and_label
    INDEX_BIB['rst'] = rst_index_bib

    TABLE['rst'] = rst_table
