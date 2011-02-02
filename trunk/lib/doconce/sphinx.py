# can reuse most of rst module:
from rst import *

legal_pygments_languages = [
    'Cucumber', 'cucumber', 'Gherkin', 'gherkin', 
    'abap', 'ada', 'ada95ada2005', 
    'antlr-as', 'antlr-actionscript', 'antlr-cpp', 'antlr-csharp', 
    'antlr-c#', 'antlr-java', 'antlr-objc', 'antlr-perl', 
    'antlr-python', 'antlr-ruby', 'antlr-rb', 'antlr', 
    'apacheconf', 'aconf', 'apache', 'applescript', 'as', 
    'actionscript', 'as3', 'actionscript3', 'aspx-cs', 'aspx-vb', 
    'asy', 'asymptote', 'basemake', 'bash', 'sh', 'ksh', 'bat', 
    'bbcode', 'befunge', 'boo', 'brainfuck', 'bf', 'c-objdump', 
    'c', 'cfm', 'cfs', 'cheetah', 'spitfire', 'clojure', 'clj', 
    'cmake', 'coffee-script', 'coffeescript', 'common-lisp', 
    'cl', 'console', 'control', 
    'cpp', 'c++', 'cpp-objdump', 'c++-objdumb', 'cxx-objdump', 
    'csharp', 'c#', 
    'css+django', 'css+jinja', 'css+erb', 'css+ruby', 
    'css+genshitext', 'css+genshi', 'css+mako', 'css+myghty', 
    'css+php', 'css+smarty', 'css', 
    'cython', 'pyx', 'd-objdump', 'd', 'delphi', 'pas', 
    'pascal', 'objectpascal', 'diff', 'udiff', 
    'django', 'jinja', 'dpatch', 'dylan', 'erb', 
    'erl', 'erlang', 'evoque', 'felix', 'flx', 
    'fortran', 'gas', 'genshi', 'kid', 
    'xml+genshi', 'xml+kid', 'genshitext', 'glsl', 
    'gnuplot', 'go', 'groff', 'nroff', 'man', 'haml', 
    'HAML', 'haskell', 'hs', 
    'html+cheetah', 'html+spitfire', 'html+django', 'html+jinja', 
    'html+evoque', 'html+genshi', 'html+kid', 'html+mako', 
    'html+myghty', 'html+php', 'html+smarty', 'html', 
    'hx', 'haXe', 'ini', 'cfg', 'io', 'irc', 
    'java', 'js+cheetah', 'javascript+cheetah', 'js+spitfire', 
    'javascript+spitfire', 'js+django', 'javascript+django', 
    'js+jinja', 'javascript+jinja', 'js+erb', 'javascript+erb', 
    'js+ruby', 'javascript+ruby', 'js+genshitext', 'js+genshi', 
    'javascript+genshitext', 'javascript+genshi', 'js+mako', 
    'javascript+mako', 'js+myghty', 'javascript+myghty', 
    'js+php', 'javascript+php', 'js+smarty', 'javascript+smarty', 
    'js', 'javascript', 'jsp', 
    'lhs', 'literate-haskell', 'lighty', 'lighttpd', 'llvm', 
    'logtalk', 'lua', 'make', 'makefile', 'mf', 'bsdmake', 
    'mako', 'matlab', 'octave', 'matlabsession', 'minid', 
    'modelica', 'modula2', 'm2', 'moocode', 'mupad', 'mxml', 
    'myghty', 'mysql', 'nasm', 'newspeak', 'nginx', 'numpy', 
    'objdump', 'objective-c', 'objectivec', 'obj-c', 'objc', 
    'objective-j', 'objectivej', 'obj-j', 'objj', 'ocaml', 
    'ooc', 'perl', 'pl', 'php', 'php3', 'php4', 'php5', 
    'pot', 'po', 'pov', 'prolog', 'py3tb', 'pycon', 'pytb', 
    'python', 'py', 'python3', 'py3', 'ragel-c', 'ragel-cpp', 
    'ragel-d', 'ragel-em', 'ragel-java', 'ragel-objc', 
    'ragel-ruby', 'ragel-rb', 'ragel', 'raw', 'rb', 'ruby', 
    'rbcon', 'irb', 'rconsole', 'rout', 'rebol', 'redcode', 
    'rhtml', 'html+erb', 'html+ruby', 'rst', 'rest', 
    'restructuredtext', 'sass', 'SASS', 'scala', 'scheme', 
    'scm', 'smalltalk', 'squeak', 'smarty', 'sourceslist', 
    'sources.list', 'splus', 's', 'r', 'sql', 'sqlite3', 
    'squidconf', 'squid.conf', 'squid', 'tcl', 'tcsh', 
    'csh', 'tex', 'latex', 'text', 'trac-wiki', 'moin', 
    'vala', 'vapi', 'vb.net', 'vbnet', 'vim', 
    'xml+cheetah', 'xml+spitfire', 'xml+django', 'xml+jinja', 
    'xml+erb', 'xml+ruby', 'xml+evoque', 'xml+mako', 
    'xml+myghty', 'xml+php', 'xml+smarty', 'xml', 'xslt', 'yaml']

# redefine what is not appropriate:

def sphinx_figure(m):
    result = ''
    # m is a MatchObject
    caption = m.group('caption').strip()
    m_label = re.search(r'label\{(.+?)\}', caption)
    if m_label:
        label = m_label.group(1)
        result += '\n.. _%s:\n' % label
        # here we do not write label into caption (as in rst.py) 
        # since we just want to remove the whole label as part 
        # of the caption (done when handling ref and label)

    filename = m.group('filename')
    #stem = os.path.splitext(filename)[0]
    #result += '\n.. figure:: ' + stem + '.*\n'  # utilize flexibility  # does not work yet
    result += '\n.. figure:: ' + filename + '\n'
    opts = m.group('options')
    if opts:
        info = [s.split('=') for s in opts.split()]
        rst_info = ['   :%s: %s' % (option, value)  for option, value in info]
        result += '\n'.join(rst_info)
    result += '\n\n   ' + caption + '\n'
    return result

from latex import fix_latex_command_regex as fix_latex

def sphinx_code(filestr, format):
    # In rst syntax, code blocks are typeset with :: (verbatim)
    # followed by intended blocks. This function indents everything
    # inside code (or TeX) blocks.

    # grab #sphinx code-blocks: cod=python cpp=c++ etc line
    # (do this before code is inserted in case verbatim blocks contain
    # such specifications for illustration)
    m = re.search(r'#\s*[Ss]phinx\s+code-blocks?:(.+?)\n', filestr)
    if m:
        defs_line = m.group(1)
        # turn defs into a dictionary definition:
        defs = {}
        for definition in defs_line.split():
            key, value = definition.split('=')
            defs[key] = value
    else:
        # default mappings:
        defs = dict(cod='python', pycod='python', cppcod='c++',
                    fcod='fortran', ccod='c', 
                    pro='python', pypro='python', cpppro='c++',
                    fpro='fortran', cpro='c', 
                    sys='console', dat='python')
        # (the "python" typesetting is neutral if the text
        # does not parse as python)
    
    # first indent all code/tex blocks by 1) extracting all blocks,
    # 2) intending each block, and 3) inserting the blocks:
    filestr, code_blocks, tex_blocks = remove_code_and_tex(filestr)
    for i in range(len(code_blocks)):
        code_blocks[i] = indent_lines(code_blocks[i], format)
    for i in range(len(tex_blocks)):
        tex_blocks[i] = indent_lines(tex_blocks[i], format)
        # remove all \label{}s inside tex blocks:
        tex_blocks[i] = re.sub(fix_latex(r'\label\{.+?\}', application='match'),
                              '', tex_blocks[i])
        # remove those without \ if there are any:
        tex_blocks[i] = re.sub(r'label\{.+?\}', '', tex_blocks[i])

        # fix latex constructions that do not work with sphinx math
        commands = [r'\begin{equation}',
                    r'\end{equation}',
                    r'\begin{equation*}',
                    r'\end{equation*}',
                    r'\begin{eqnarray}',
                    r'\end{eqnarray}',
                    r'\begin{eqnarray*}',
                    r'\end{eqnarray*}',
                    r'\begin{align}',
                    r'\end{align}',
                    r'\begin{align*}',
                    r'\end{align*}',
                    r'\begin{multline}',
                    r'\end{multline}',
                    r'\begin{multline*}',
                    r'\end{multline*}',
                    r'\begin{split}',
                    r'\end{split}',
                    r'\begin{gather}',
                    r'\end{gather}',
                    r'\begin{gather*}',
                    r'\end{gather*}',
                    r'\[',
                    r'\]',
                    # some common abbreviations (newcommands):
                    r'\beqan',
                    r'\eeqan',
                    r'\beqa',
                    r'\eeqa',
                    r'\balnn',
                    r'\ealnn',
                    r'\baln',
                    r'\ealn',
                    r'\beq',
                    r'\eeq',  # the simplest, contained in others, must come last...
                    ]
        for command in commands:
            tex_blocks[i] = tex_blocks[i].replace(command, '')
        tex_blocks[i] = re.sub('&\s*=\s*&', ' &= ', tex_blocks[i])
        # provide warnings for problematic environments
        if '{alignat' in tex_blocks[i]:
            print '\nWarning: the "alignat" environment will give errors in Sphinx:\n\n', tex_blocks[i], '\n'
    
        
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, 'rst')

    for key in defs:
        language = defs[key]
        if not language in legal_pygments_languages:
            raise TypeError('%s is not a legal Pygments language '\
                            '(lexer) in line with:\n  %s' % \
                                (language, defs_line))
        #filestr = re.sub(r'^!bc\s+%s\s*\n' % key, 
        #                 '\n.. code-block:: %s\n\n' % defs[key], filestr,
        #                 flags=re.MULTILINE)
        cpattern = re.compile(r'^!bc\s+%s\s*\n' % key, flags=re.MULTILINE)
        filestr = cpattern.sub('\n.. code-block:: %s\n\n' % defs[key], filestr)
                         
    # any !bc with/without argument becomes a py (python) block:
    #filestr = re.sub(r'^!bc.+\n', '\n.. code-block:: py\n\n', filestr,
    #                 flags=re.MULTILINE)
    cpattern = re.compile(r'^!bc.+$', flags=re.MULTILINE)
    filestr = cpattern.sub('\n.. code-block:: py\n\n', filestr)

    filestr = re.sub(r'!ec *\n', '\n\n', filestr)
    #filestr = re.sub(r'!ec\n', '\n', filestr)
    #filestr = re.sub(r'!ec\n', '', filestr)
    filestr = re.sub(r'!bt *\n', '\n.. math::\n\n', filestr)
    filestr = re.sub(r'!et *\n', '\n\n', filestr)

    return filestr

def sphinx_ref_and_label(section_label2title, format, filestr):
    filestr = ref_and_label_commoncode(section_label2title, format, filestr)

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
        word2 = word.replace('`', '')  # drop verbatim in index
        if not '!' in word:
            filestr = filestr.replace('idx{%s}' % word, 
                                      '\n.. index:: ' + word2 + '\n')
        else:
            word3 = word2.replace('!', '; ')
            filestr = filestr.replace('idx{%s}' % word,
                                      '\n.. index::\n   pair: ' + word3 + '\n')
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
    FIGURE_EXT['sphinx'] = ('.png', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['sphinx'] = sphinx_ref_and_label
    INDEX_BIB['sphinx'] = sphinx_index_bib
    TABLE['sphinx'] = TABLE['rst']
    INTRO['sphinx'] = INTRO['rst']

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


