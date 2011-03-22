"""
This module contains data structures used in translation of the
Doconce format to other formats.  Some convenience functions used in
translation modules (latex.py, html.py, etc.) are also included in
here.
"""
import re

def indent_lines(text, format, indentation=' '*8):
    """
    Indent each line in the string text, provided in a format for
    HTML, LaTeX, epytext, ..., by the blank string indentation.
    Return new version of text.
    """
    if format == 'epytext':
        # some formats (Epytext) give wrong behavior if there is a \n
        # in code or tex blocks (\nabla is one example), hence we
        # comment out the block in those cases: (\b also gives problems...
        # it seems that Epytext is not capable of doing raw strings here)
        if re.search(r'\\n', text):
            comment_out = True
            text = """\
            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.
"""
            return text
        
    # indent X chars (choose X=6 for sufficient indent in lists)
    text = '\n'.join([indentation + line for line in text.splitlines()])
    return text


def table_analysis(table):
    """Return max width of each column."""
    column_list = []
    for i, row in enumerate(table):
        if row != ['horizontal rule']:
            if not column_list:
                column_list = [[]]*len(row)
            for j, column in enumerate(row):
                column_list[j].append(len(column))
    return [max(c) for c in column_list]
            

def ref2equations(filestr):
    """
    Replace references to equations:
    (ref{my:label}) -> Equation (my:label)
    (ref{my:label1})-(ref{my:label2}) -> Equations (my:label1)-(my:label2)
    (ref{my:label1}) and (ref{my:label2}) -> Equations (my:label1) and (my:label2)
    (ref{my:label1}), (ref{my:label2}) and (ref{my:label3}) -> Equations (my:label1), (my:label2) and (ref{my:label2})
    """
    filestr = re.sub(r'\(ref\{(.+?)\}\)-\(ref\{(.+?)\}\)',
                     r'Equations (\g<1>)-(\g<2>)', filestr)
    filestr = re.sub(r'\(ref\{(.+?)\}\)\s+and\s+\(ref\{(.+?)\}\)',
                     r'Equations (\g<1>) and (\g<2>)', filestr)
    filestr = re.sub(r'\(ref\{(.+?)\}\),\s*\(ref\{(.+?)\}\)(,?)\s+and\s+\(ref\{(.+?)\}\)',
                     r'Equations (\g<1>), (\g<2>)\g<3> and (\g<4>)', filestr)
    filestr = re.sub(r'\(ref\{(.+?)\}\)',
                     r'Equation (\g<1>)', filestr)
    return filestr

def remove_code_and_tex(filestr):
    """
    Remove verbatim and latex (math) code blocks from the file and
    store separately in lists (code_blocks and tex_blocks).
    The function insert_code_and_tex will insert these blocks again.
    """
    # Method:
    # store code and tex blocks in lists and substitute these blocks
    # by #!!CODE_BLOCK and #!!TEX_BLOCK ("arguments" to !bc must be
    # copied after #!!CODE_BLOCK).
    # later we replace #!!CODE_BLOCK by !bc and the code block again
    # (similarly for the tex block).
    
    # (recall that !bc can be followed by extra information that we must keep:)
    code = re.compile(r'^!bc(.*?)\n(.*?)^!ec *\n', re.DOTALL|re.MULTILINE)
    code_blocks = [c for opt, c in code.findall(filestr)]

    tex = re.compile(r'^!bt\n(.*?)!et *\n', re.DOTALL|re.MULTILINE)
    tex_blocks = tex.findall(filestr)

    # remove blocks and substitute by a one-line sign:
    filestr = code.sub('#!!CODE_BLOCK \g<1>\n', filestr)
    filestr = tex.sub('#!!TEX_BLOCK\n', filestr)

    # could leave @@@CODE blocks to LaTeX, but then these lines must be
    # removed since they may contain underscores and asterix and hence
    # be destroyed by substutitions of inline tags
    #CODE = re.compile(r'^@@@CODE .+$', re.MULTILINE)
    #CODE_lines = [c for opt, c in CODE.findall(filestr)]
    #filestr = CODE.sub('#@@@CODE', filestr)

    return filestr, code_blocks, tex_blocks
        

def insert_code_and_tex(filestr, code_blocks, tex_blocks, format):
    lines = filestr.splitlines()
    for code in code_blocks:
        # this construction does not handle newlines in regex and
        # similar verbatim environments properly:
        #filestr = re.sub(r'#!!CODE_BLOCK (.*?)\n',
        #                 '!bc\g<1>\n%s!ec\n' % code, filestr, 1)
        # use string.replace instead

        for i in range(len(lines)):
            if '#!!CODE_BLOCK' in lines[i]:
                # use re.sub for the heading when we need a group:
                lines[i] = re.sub('#!!CODE_BLOCK(.*)',
                                  '!bc\g<1>\n!XX&XX', lines[i])
                # use string.replace to deal correctly with \n:
                try:
                    #lines[i] = lines[i].replace('!XX&XX', '%s\n!ec' % code)
                    # the \n should not be there (gives extra newline)
                    lines[i] = lines[i].replace('!XX&XX', '%s!ec' % code)
                except UnicodeDecodeError, e:
                    raise UnicodeDecodeError(e + '\nproblem with code block:\n' + code)
                break
    for tex in tex_blocks:
        # Also here problems with this: (\nabla becomes \n (newline) and abla)
        # which means that
        # filestr = re.sub(r'#!!TEX_BLOCK', '!bt\n%s!et' % tex, filestr, 1)
        # does not work properly. Instead, we use str.replace

        if format == 'LaTeX':  # fix
            # ref/label is ok outside tex environments (see test in 
            # cross_referencing), but inside !bt/!et environments the user 
            # is allowed to have ref and label without backslashes 
            # and these must be equipped by backslashes in LaTeX format
            filestr = re.sub(r'([^\\])label\{', r'\g<1>\label{', filestr)
            filestr = re.sub(r'([^\\])ref\{', r'\g<1>\\ref{', filestr)

        for i in range(len(lines)):
            if '#!!TEX_BLOCK' in lines[i]:
                lines[i] = lines[i].replace('#!!TEX_BLOCK',
                                            '!bt\n%s!et' % tex)
                break
    filestr = '\n'.join(lines)
    return filestr

    
BLANKLINE = {}
FILENAME_EXTENSION = {}
LIST = {}
CODE = {}
# listing of function parameters/arguments and return values:
ARGLIST = {}
DEFAULT_ARGLIST = {
    'parameter': 'argument',
    'keyword': 'keyword argument',
    'return': 'return value(s)',
    'instance variable': 'instance variable',
    'class variable': 'class variable',
    'module variable': 'module variable',
    }
TABLE = {}
FIGURE_EXT = {}
CROSS_REFS = {}
INDEX_BIB = {}
INTRO = {}
OUTRO = {}

        
# regular expressions for inline tags:
inline_tag_begin = r"""(?P<begin>(^|[(\s]))"""
inline_tag_end = r"""(?P<end>($|[.,?!;:)\s]))"""
# alternatives using positive lookbehind and lookahead (not tested!):
inline_tag_before = r"""(?<=^(|[(\s])))"""
inline_tag_after = r"""(?=($|[.,?!;:)\s]))"""

INLINE_TAGS = {
    # math: text inside $ signs, as in $a = b$, with space before the
    # first $ and space, comma, period, colon, semicolon, or question
    # mark after the enclosing $.
    'math':
    r'%s\$(?P<subst>[^ `][^$`]*)\$%s' % \
    (inline_tag_begin, inline_tag_end),

    # $latex text$|$pure text alternative$
    'math2':
    r'%s\$(?P<latexmath>[^ `][^$`]*)\$\|\$(?P<puretext>[^ `][^$`]*)\$%s' % \
    (inline_tag_begin, inline_tag_end),
    # simpler (not tested):
    #r'%s\$(?P<latexmath>[^$]+?)\$\|\$(?P<puretext>[^$]+)\$%s' % \
    #(inline_tag_begin, inline_tag_end),

    # *emphasized words*
    'emphasize':
    r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
    (inline_tag_begin, inline_tag_end),

    # `verbatim inline text is enclosed in back quotes`
    'verbatim':
    r'%s`(?P<subst>[^ ][^`]*)`%s' % \
    (inline_tag_begin, inline_tag_end),

    # _underscore before and after signifies bold_
    'bold':
    r'%s_(?P<subst>[^ `][^\]_`]*)_%s' % \
    (inline_tag_begin, inline_tag_end),

    # cite{labelname}
    'citation':
    r' cite\{(?P<subst>[^}]+)\}',

    # http://some.where.org/mypage<link text>
    'linkURL':
    r'%s(?P<url>https?://[^<\n]+)<(?P<link>[^>]+)>%s' % \
    (inline_tag_begin, inline_tag_end),

    'linkURL2':  # "some link": "https://bla-bla"
    r'"(?P<link>.+?)" ?:\s*"(?P<url>(file:/|https?:)//.+?)"',
    #r'"(?P<link>[^>]+)" ?: ?"(?P<url>https?://[^<]+?)"'

    'plainURL': 
    #r'"URL" ?: ?"(?P<url>.+?)"',
    #r'"?(URL|url)"? ?: ?"(?P<url>.+?)"',
    r'("URL"|"url"|URL|url) ?:\s*"(?P<url>.+?)"',

    'inlinecomment':
    r'''\[(?P<name>[A-Za-z0-9_'-]+?):\s+(?P<comment>[^\]]*?)\]''',

    # _______Seven Underscores Before and Any After Section Title_______
    # or ======= Seven Equality Signs =======
    'section':
    #r'^_{7}(?P<subst>[^ ].*)_{7}\s*$',
    # previous: r'^\s*_{7}(?P<subst>[^ ].*?)_+\s*$',
    #r'^\s*[_=]{7}\s*(?P<subst>[^ ].*?)\s*[_=]+\s*$',
    r'^\s*[_=]{7}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',

    # _____Five _ or = for Subsection Title_____
    'subsection':
    #r'^\s*_{5}(?P<subst>[^ ].*?)_+\s*$',
    #r'^\s*[_=]{5}\s*(?P<subst>[^ ].*?)\s*[_=]+\s*$',
    r'^\s*[_=]{5}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',

    # ___Three _ or = for Subsubsection Title___
    'subsubsection':
    #r'^\s*_{3}(?P<subst>[^ ].*?)_+\s*$',
    #r'^\s*[_=]{3}\s*(?P<subst>[^ ].*?)\s*[_=]+\s*$',
    r'^\s*[_=]{3}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',


    # __Two underscores for Inline Paragraph Title.__
    'paragraph':
    r'(?P<begin>^)__(?P<subst>.+?)__\s+',
    #r'(?P<begin>^)[_=]{2}\s*(?P<subst>[^ =-].+?)[_=]{2}\s+',

    # TITLE: My Document Title
    'title':
    r'^TITLE:\s*(?P<subst>.+)\s*$',

    # AUTHOR: Some Name
    'author':
    #r'^AUTHOR:\s*(?P<name>.+?)\s+at\s+(?P<institution>.+)\s*$',
    # for backward compatibility (comma or at as separator):
    r'^AUTHOR:\s*(?P<name>.+?)(,|\s+at\s+)(?P<institution>.+)\s*$',

    # DATE: Jan 27, 2010
    'date':
    r'^DATE:\s*(?P<subst>.+)\s*$',

    # FIGURE:[filename, options] some caption text label{some:label}
    'figure':
    r'^FIGURE:\s*\[(?P<filename>[^,\]]+),?(?P<options>[^\]]*)\]\s*?(?P<caption>.*)$',
    # MOVIE:[filename, options] some caption text label{some:label}
    'movie':
    r'^MOVIE:\s*\[(?P<filename>[^,\]]+),?(?P<options>[^\]]*)\]\s*?(?P<caption>.*)$',
    }
INLINE_TAGS_SUBST = {}

# frequent syntax errors that we can test for: (not yet used)
heading_error = (r'(^ [_=]+[^_=]*|^[_=]+[^ _=]*$)',
                 'Initial spaces or missing underscore(s) or = at the end')
INLINE_TAGS_BUGS = {
    # look for space after first special character ($ ` _ etc)
    'math': (r'%s(?P<subst>\$ [^$]*\$)%s' % (inline_tag_begin, inline_tag_end),
             'Space after first $ in inline math expressions'),
    'emphasize': None, # *item with *emph* word is legal (no error)
    'verbatim': (r'%s(?P<subst>` [^`]*`)%s' % \
                 (inline_tag_begin, inline_tag_end),
                 'Space after first ` in inline verbatim expressions'),
    'bold': (r'%s(?P<subst>_ [^_]*_)%s' % \
             (inline_tag_begin, inline_tag_end),
             'Space after first _ in inline boldface expressions'),
    'section': heading_error,
    'subsection': heading_error,
    'subsubsection': heading_error,
    'paragraph': heading_error,
    }

LIST_SYMBOL = {'*': 'itemize', 'o': 'enumerate', '-': 'description'}
