"""
This module contains data structures used in translation of the
Doconce format to other formats.  Some convenience functions used in
translation modules (latex.py, html.py, etc.) are also included in
here.
"""
import re, sys, urllib
from misc import option

# Identifiers in the text used to identify code and math blocks
_CODE_BLOCK = '<<<!!CODE_BLOCK'
_MATH_BLOCK = '<<<!!MATH_BLOCK'

# Comment lines used to identify parts that can later be removed.
# The lines below are wrapped as comments.
# Defined here once so different modules can utilize the same syntax.
envir_delimiter_lines = {
    'sol':
    ('--- begin solution of exercise ---',
     '--- end solution of exercise ---'),
    'ans':
    ('--- begin answer of exercise ---',
     '--- end answer of exercise ---'),
    'hint':
    ('--- begin hint in exercise ---',
     '--- end hint in exercise ---'),
    'exercise':
    ('--- begin exercise ---',
     '--- end exercise ---'),
}


def safe_join(lines, delimiter):
    try:
        filestr = delimiter.join(lines) + '\n' # will fail if ord(char) > 127
        return filestr
    except UnicodeDecodeError, e:
        if "'ascii' codec can't decode" in e and 'position' in e:
            pos = int(e.split('position')[1].split(':'))
            print filestr[pos-50:pos], '[problematic char]', filestr[pos+1:pos+51]
            sys.exit(1)
        else:
            print e
            sys.exit(1)

def where():
    """
    Return the location where the doconce package is installed.
    """
    # Technique: find the directory where this common.py file resides
    import os
    return os.path.dirname(__file__)

def indent_lines(text, format, indentation=' '*8, trailing_newline=True):
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
    if trailing_newline:
        text += '\n'
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

def python_online_tutor(code, return_tp='iframe'):
    """
    Return URL (return_tp is 'url') or iframe HTML code
    (return_tp is 'iframe') for code embedded in
    on pythontutor.com.
    """
    codestr = urllib.quote_plus(code.strip())
    if return_tp == 'iframe':
        urlprm = urllib.urlencode({'py': 2,
                                   'curInstr': 0,
                                   'cumulative': 'false'})
        iframe = """\
<iframe width="950" height="500" frameborder="0"
        src="http://pythontutor.com/iframe-embed.html#code=%s&%s">
</iframe>
""" % (codestr, urlprm) # must treat code separately (urlencode adds chars)
        return iframe
    elif return_tp == 'url':
        url = 'http://pythontutor.com/visualize.html#code=%s&mode=display&cumulative=false&heapPrimitives=false&drawParentPointers=false&textReferences=false&py=2&curInstr=0' % codestr
        url = url.replace('%', '\\%').replace('#', '\\#')
        return url
    else:
        print 'BUG'; sys.exit(1)

def align2equations(filestr):
    """Turn align environments into separate equation environments."""
    if not '{align}' in filestr:
        return filestr

    lines = filestr.splitlines()
    inside_align = False
    inside_code = False
    for i in range(len(lines)):
        if lines[i].startswith('!bc'):
            inside_code = True
        if lines[i].startswith('!ec'):
            inside_code = False
        if inside_code:
            continue

        if r'\begin{align}' in lines[i]:
            inside_align = True
            lines[i] = lines[i].replace(r'\begin{align}', r'\begin{equation}')
        if inside_align and '\\\\' in lines[i]:
            lines[i] = lines[i].replace('\\\\', '\n' + r'\end{equation}' + '\n!et\n\n!bt\n' + r'\begin{equation} ')
        if inside_align and '&' in lines[i]:
            lines[i] = lines[i].replace('&', '')
        if r'\end{align}' in lines[i]:
            inside_align = False
            lines[i] = lines[i].replace(r'\end{align}', r'\end{equation}')
    filestr = '\n'.join(lines)
    return filestr


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

    # Note that we insert "Equation(s)" here, assuming that this word
    # is *not* used in running text prior to a reference. Sometimes
    # sentences are started with "Equation ref{...}" and this double
    # occurence of Equation must be fixed.

    filestr = re.sub('Equation\s+Equation', 'Equation', filestr)
    filestr = re.sub('Equations\s+Equations', 'Equations', filestr)
    return filestr

def default_movie(m):
    """Replace a movie entry by a proper URL with text."""
    # Note: essentially same code as html_movie
    import os, glob
    filename = m.group('filename')
    options = m.group('options')
    caption = m.group('caption')

    # Turn options to dictionary
    if ',' in options:
        options = options.split(',')
    else:
        options = options.split()
    kwargs = {}
    for opt in options:
        if opt.startswith('width') or opt.startswith('WIDTH'):
            kwargs['width'] = int(opt.split('=')[1])
        if opt.startswith('height') or opt.startswith('HEIGHT'):
            kwargs['height'] = int(opt.split('=')[1])

    if '*' in filename:
        # Glob files and use DocWriter.html_movie to make a separate
        # HTML page for viewing the set of files
        plotfiles = sorted(glob.glob(filename))
        if not plotfiles:
            print 'No plotfiles on the form', filename
            sys.exit(1)
        basename  = os.path.basename(plotfiles[0])
        stem, ext = os.path.splitext(basename)
        kwargs['casename'] = stem
        import DocWriter
        header, jscode, form, footer = DocWriter.html_movie(plotfiles, **kwargs)
        #text = jscode + form  # does not work well with several movies
        moviehtml = stem + '.html'
        f = open(moviehtml, 'w')
        f.write(header + jscode + form + footer)
        f.close()
        text = """\n%s (Movie of files `%s` in URL:"%s")\n""" % \
               (caption, filename, moviehtml)
    elif 'youtube.com' in filename:
        # Rename embedded files to ordinary YouTube
        filename = filename.replace('embed/', 'watch?v=')
        text = '%s: URL:"%s"' % (caption, filename)
    else:
        # Make an HTML file where the movie file can be played
        # (alternative to launching a player manually)
        stem  = os.path.splitext(os.path.basename(filename))[0]
        moviehtml = stem + '.html'
        f = open(moviehtml, 'w')
        f.write("""
<HTML>
<BODY>
<TITLE>Embedding movie %s in HTML</TITLE>
   <EMBED SRC="%s" %s AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
   <P>
   <EM>%s</EM>
   </P>
</BODY>
</HTML>
""" % (filename, filename, ' '.join(options), caption))
        text = '%s (Movie %s: play URL:"%s")' % (caption, filename, moviehtml)
    return text

def begin_end_consistency_checks(filestr, envirs):
    """Perform consistency checks: no of !bc must equal no of !ec, etc."""
    for envir in envirs:
        begin = '!b' + envir
        end = '!e' + envir

        nb = len(re.compile(r'^%s' % begin, re.MULTILINE).findall(filestr))
        ne = len(re.compile(r'^%s' % end, re.MULTILINE).findall(filestr))

        lines = []
        if nb != ne:
            print 'ERROR: %d %s do not match %d %s directives' % \
                  (nb, begin, ne, end)
            if not lines:
                lines = filestr.splitlines()
            begin_ends = []
            for i, line in enumerate(lines):
                if line.startswith(begin):
                    begin_ends.append((begin, i))
                if line.startswith(end):
                    begin_ends.append((end, i))
            for k in range(1, len(begin_ends)):
                pattern, i = begin_ends[k]
                if pattern == begin_ends[k-1][0]:
                    print '\n\nTwo', pattern, 'after each other!\n'
                    for j in range(begin_ends[k-1][1], begin_ends[k][1]+1):
                        print lines[j]
                    sys.exit(1)
            if begin_ends[-1][0].startswith('!b'):
                print 'Missing %s after final %s' % \
                      (begin_ends[-1][0].replace('!b', '!e'),
                       begin_ends[-1][0])
                sys.exit(1)


def remove_code_and_tex(filestr):
    """
    Remove verbatim and latex (math) code blocks from the file and
    store separately in lists (code_blocks and tex_blocks).
    The function insert_code_and_tex will insert these blocks again.
    """
    # Method:
    # store code and tex blocks in lists and substitute these blocks
    # by the contents of _CODE_BLOCK and _MATH_BLOCK (arguments after
    # !bc must be copied after _CODE_BLOCK).
    # later we replace _CODE_BLOCK by !bc and !ec and the code block again
    # (similarly for the tex/math block).

    # (recall that !bc can be followed by extra information that we must keep:)
    code = re.compile(r'^!bc(.*?)\n(.*?)^!ec *\n', re.DOTALL|re.MULTILINE)

    # Note: final \n is required and may be missing if there is a block
    # at the end of the file, so let us ensure that a blank final
    # line is appended to the text:
    if filestr[-1] != '\n':
        filestr = filestr + '\n'

    result = code.findall(filestr)
    code_blocks = [c for opt, c in result]
    code_block_types = [opt.strip() for opt, c in result]

    tex = re.compile(r'^!bt\n(.*?)^!et *\n', re.DOTALL|re.MULTILINE)
    tex_blocks = tex.findall(filestr)

    # Remove blocks and substitute by a one-line sign
    filestr = code.sub('%s \g<1>\n' % _CODE_BLOCK, filestr)
    filestr = tex.sub('%s\n' % _MATH_BLOCK, filestr)

    # Number the blocks
    lines = filestr.splitlines()
    code_block_counter = 0
    math_block_counter = 0
    for i in range(len(lines)):
        if lines[i].startswith(_CODE_BLOCK):
            lines[i] = '%d ' % code_block_counter + lines[i]
            code_block_counter += 1
        if lines[i].startswith(_MATH_BLOCK):
            lines[i] = '%d ' % math_block_counter + lines[i]
            math_block_counter += 1
    filestr = safe_join(lines, '\n')

    # Give error if blocks contain !bt

    return filestr, code_blocks, code_block_types, tex_blocks


def insert_code_and_tex(filestr, code_blocks, tex_blocks, format):
    # Consistency check
    n = filestr.count(_CODE_BLOCK)
    if len(code_blocks) != n:
        print '*** BUG: found %d code block markers for %d initial code blocks\nAbort!' % (n, len(code_blocks))
        print 'Possible cause: !bc and !ec inside code blocks - replace by |bc and |ec'
        sys.exit(1)
    n = filestr.count(_MATH_BLOCK)
    if len(tex_blocks) != n:
        print '*** BUG: found %d tex block markers for %d initial tex blocks\nAbort!' % (n, len(tex_blocks))
        print 'Possible cause: !bt and !et inside code blocks - replace by |bt and |ec'
        sys.exit(1)

    lines = filestr.splitlines()

    # Note: re.sub cannot be used because newlines, \nabla, etc
    # are not handled correctly. Need str.replace.

    for i in range(len(lines)):
        if _CODE_BLOCK in lines[i] or _MATH_BLOCK in lines[i]:
            words = lines[i].split()
            # on a line: number block-indicator code-type
            n = int(words[0])
            if _CODE_BLOCK in lines[i]:
                words[1] = '!bc'
                code = code_blocks[n]
                lines[i] = ' '.join(words[1:]) + '\n' + code + '!ec'
            if _MATH_BLOCK in lines[i]:
                words[1] = '!bc'
                math = tex_blocks[n]
                lines[i] = '!bt\n' + math + '!et'

    filestr = safe_join(lines, '\n')
    return filestr


def doconce_exercise_output(exer,
                            solution_header = '__Solution.__',
                            answer_header = '__Answer.__ ',
                            hint_header = '__Hint.__ ',
                            include_numbering=True,
                            include_type=True):
    """
    Write exercise in Doconce format. This output can be
    reused in most formats.
    """
    # Note: answers, solutions, and hints must be written out and not
    # removed here, because if they contain math or code blocks,
    # there will be fewer blocks in the end that what was extracted
    # at the beginning of the translation process.

    s = '\n\n# ' + envir_delimiter_lines['exercise'][0] + '\n\n'
    s += exer['heading']  # result string
    if include_numbering and not include_type:
        include_type = True
    if not exer['type_visible']:
        include_type = False
    if include_type:
        s += ' ' + exer['type']
        if include_numbering:
            s += ' ' + str(exer['no'])
        s += ':'
    s += ' ' + exer['title'] + ' ' + exer['heading'] + '\n'

    if exer['label']:
        s += 'label{%s}' % exer['label'] + '\n'

    if exer['keywords']:
        s += '# keywords = %s' % '; '.join(exer['keywords']) + '\n'

    if exer['text']:
        s += '\n' + exer['text'] + '\n'

    if exer['hints']:
        for i, hint in enumerate(exer['hints']):
            if len(exer['hints']) == 1 and i == 0:
                hint_header_ = hint_header
            else:
                hint_header_ = hint_header.replace('Hint.', 'Hint %d.' % (i+1))
            if exer['type'] != 'Example':
                s += '\n# ' + envir_delimiter_lines['hint'][0] + '\n'
            s += '\n' + hint_header_ + hint + '\n'
            if exer['type'] != 'Example':
                s += '# ' + envir_delimiter_lines['hint'][1] + '\n'

    if exer['answer']:
        s += '\n'
        # Leave out begin-end answer comments if example since we want to
        # avoid marking such sections for deletion (--without-answers)
        if exer['type'] != 'Example':
            s += '\n# ' + envir_delimiter_lines['ans'][0] + '\n'
        s += answer_header + '\n' + exer['answer'] + '\n'
        if exer['type'] != 'Example':
            s += '# ' + envir_delimiter_lines['ans'][1] + '\n'


    if exer['solution']:
        s += '\n'
        # Leave out begin-end solution comments if example since we want to
        # avoid marking such sections for deletion (--without-solutions)
        if exer['type'] != 'Example':
            s += '\n# ' + envir_delimiter_lines['sol'][0] + '\n'
        s += solution_header + '\n'
        # Make sure we have a sentence after the heading
        if re.search(r'^\d+ %s' % _CODE_BLOCK, exer['solution'].lstrip()):
            print '\nwarning: open the solution in exercise "%s" with a line of\ntext before the code! (Now "Code:" is inserted)' % exer['title'] + '\n'
            s += 'Code:\n'
        s += exer['solution'] + '\n'
        if exer['type'] != 'Example':
            s += '# ' + envir_delimiter_lines['sol'][1] + '\n'

    if exer['subex']:
        s += '\n'
        import string
        for i, subex in enumerate(exer['subex']):
            letter = string.ascii_lowercase[i]
            s += '\n__%s)__ ' % letter

            if subex['text']:
                s += '\n' + subex['text'] + '\n'

                for i, hint in enumerate(subex['hints']):
                    if len(subex['hints']) == 1 and i == 0:
                        hint_header_ = hint_header
                    else:
                        hint_header_ = hint_header.replace(
                            'Hint.', 'Hint %d.' % (i+1))
                    if exer['type'] != 'Example':
                        s += '\n# ' + envir_delimiter_lines['hint'][0] + '\n'
                    s += '\n' + hint_header_ + hint + '\n'
                    if exer['type'] != 'Example':
                        s += '# ' + envir_delimiter_lines['hint'][1] + '\n'

                if subex['file']:
                    if len(subex['file']) == 1:
                        s += 'Filename: `%s`' % subex['file'][0] + '.\n'
                    else:
                        s += 'Filenames: %s' % \
                             ', '.join(['`%s`' % f for f in subex['file']]) + '.\n'

                if subex['answer']:
                    s += '\n'
                    if exer['type'] != 'Example':
                        s += '\n# ' + envir_delimiter_lines['ans'][0] + '\n'
                    s += answer_header + '\n' + subex['answer'] + '\n'
                    if exer['type'] != 'Example':
                        s += '# ' + envir_delimiter_lines['ans'][1] + '\n'

                if subex['solution']:
                    s += '\n'
                    if exer['type'] != 'Example':
                        s += '\n# ' + envir_delimiter_lines['sol'][0] + '\n'
                    s += solution_header + '\n'
                    # Make sure we have a sentence after the heading
                    if re.search(r'^\d+ %s' % _CODE_BLOCK,
                                 subex['solution'].lstrip()):
                        print '\nwarning: open the solution in exercise "%s" with a line of\ntext before the code! (Now "Code:" is inserted)' % exer['title'] + '\n'
                        s += 'Code:\n'
                    s += subex['solution'] + '\n'
                    if exer['type'] != 'Example':
                        s += '# ' + envir_delimiter_lines['sol'][1] + '\n'

    if exer['file']:
        if exer['subex']:
            # Place Filename: ... as a list paragraph if subexercises,
            # otherwise let it proceed at the end of the exercise text.
            s += '\n'
        if len(exer['file']) == 1:
            s += 'Filename: `%s`' % exer['file'][0] + '.\n'
        else:
            s += 'Filenames: %s' % \
                 ', '.join(['`%s`' % f for f in exer['file']]) + '.\n'
        #s += '*Filename*: `%s`' % exer['file'] + '.\n'
        #s += '\n' + '*Filename*: `%s`' % exer['file'] + '.\n'

    if exer['closing_remarks']:
        s += '\n# Closing remarks for this %s\n\n=== Remarks ===\n\n' % \
             exer['type'] + exer['closing_remarks'] + '\n\n'

    if exer['solution_file']:
        if len(exer['solution_file']) == 1:
            s += '# solution file: %s\n' % exer['solution_file'][0]
        else:
            s += '# solution files: %s\n' % ', '.join(exer['solution_file'])

    s += '\n# ' + envir_delimiter_lines['exercise'][1] + '\n\n'
    return s

def plain_exercise(exer):
    return doconce_exercise_output(exer)

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
EXERCISE = {}
TOC = {}
ENVIRS = {}


# regular expressions for inline tags:
inline_tag_begin = r"""(?P<begin>(^|[(\s]))"""
inline_tag_end = r"""(?P<end>($|[.,?!;:)}\s-]))"""
# alternatives using positive lookbehind and lookahead (not tested!):
inline_tag_before = r"""(?<=^(|[(\s])))"""
inline_tag_after = r"""(?=($|[.,?!;:)\s]))"""
_linked_files = '''\s*"(?P<url>([^"]+?\.html?|[^"]+?\.html?\#[^"]+?|[^"]+?\.txt|[^"]+?\.pdf|[^"]+?\.f|[^"]+?\.c|[^"]+?\.cpp|[^"]+?\.cxx|[^"]+?\.py|[^"]+?\.java|[^"]+?\.pl|[^"]+?\.sh|[^"]+?\.csh|[^"]+?\.zsh|[^"]+?\.ksh|[^"]+?\.tar\.gz|[^"]+?\.tar|[^"]+?\.f77|[^"]+?\.f90|[^"]+?\.f95))"'''

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

    # http://some.where.org/mypage<link text>  # old outdated syntax
    'linkURL':
    r'%s(?P<url>https?://[^<\n]+)<(?P<link>[^>]+)>%s' % \
    (inline_tag_begin, inline_tag_end),

    'linkURL2':  # "some link": "https://bla-bla"
    r'''"(?P<link>[^"]+?)" ?:\s*"(?P<url>(file:/|https?:)//.+?)"''',
    #r'"(?P<link>[^>]+)" ?: ?"(?P<url>https?://[^<]+?)"'

    'linkURL2v':  # verbatim link "`filelink`": "https://bla-bla"
    r'''"`(?P<link>[^"]+?)`" ?:\s*"(?P<url>(file:/|https?:|ftp:)//.+?)"''',

    'linkURL3':  # "some link": "some/local/file/name.html" or .txt/.pdf/.py/.c/.cpp/.cxx/.f/.java/.pl files
    #r'''"(?P<link>[^"]+?)" ?:\s*"(?P<url>([^"]+?\.html?|[^"]+?\.txt|[^"]+?.pdf))"''',
    r'''"(?P<link>[^"]+?)" ?:''' + _linked_files,
    #r'"(?P<link>[^>]+)" ?: ?"(?P<url>https?://[^<]+?)"'
    'linkURL3v':  # "`somefile`": "some/local/file/name.html" or .txt/.pdf/.py/.c/.cpp/.cxx/.f/.java/.pl files
    r'''"`(?P<link>[^"]+?)`" ?:''' +  _linked_files,

    'plainURL':
    #r'"URL" ?: ?"(?P<url>.+?)"',
    #r'"?(URL|url)"? ?: ?"(?P<url>.+?)"',
    r'("URL"|"url"|URL|url) ?:\s*"(?P<url>.+?)"',

    'inlinecomment':
    r'''\[(?P<name>[A-Za-z0-9_'-]+?):\s+(?P<comment>[^\]]*?)\]''',

    # __Abstract.__ Any text up to a headline === or toc-like keywords
    # (TOC is already processed)
    'abstract':
    r"""^\s*__(?P<type>Abstract|Summary).__\s*(?P<text>.+?)(?P<rest>TOC:|\\tableofcontents|Table of [Cc]ontents|\s*[_=]{3,9})""",
    #r"""^\s*__(?P<type>Abstract|Summary).__\s*(?P<text>.+?)(?P<rest>\s*[_=]{3,9})""",

    # ======= Seven Equality Signs for Headline =======
    # (the old underscores instead of = are still allowed)
    'section':
    #r'^_{7}(?P<subst>[^ ].*)_{7}\s*$',
    # previous: r'^\s*_{7}(?P<subst>[^ ].*?)_+\s*$',
    #r'^\s*[_=]{7}\s*(?P<subst>[^ ].*?)\s*[_=]+\s*$',
    #r'^\s*[_=]{7}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',
    r'^\s*[_=]{7}\s*(?P<subst>[^ =-].+?)\s*[_=]{7}\s*$',

    'chapter':
    #r'^\s*[_=]{9}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',
    r'^\s*[_=]{9}\s*(?P<subst>[^ =-].+?)\s*[_=]{9}\s*$',

    'subsection':
    #r'^\s*_{5}(?P<subst>[^ ].*?)_+\s*$',
    #r'^\s*[_=]{5}\s*(?P<subst>[^ ].*?)\s*[_=]+\s*$',
    #r'^\s*[_=]{5}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',
    r'^\s*[_=]{5}\s*(?P<subst>[^ =-].+?)\s*[_=]{5}\s*$',

    'subsubsection':
    #r'^\s*_{3}(?P<subst>[^ ].*?)_+\s*$',
    #r'^\s*[_=]{3}\s*(?P<subst>[^ ].*?)\s*[_=]+\s*$',
    #r'^\s*[_=]{3}\s*(?P<subst>[^ =-].+?)\s*[_=]+\s*$',
    r'^\s*[_=]{3}\s*(?P<subst>[^ =-].+?)\s*[_=]{3}\s*$',

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
    # (until blank line ^\s*$)
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
