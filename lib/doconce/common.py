"""
This module contains data structures used in translation of the
Doconce format to other formats.  Some convenience functions used in
translation modules (latex.py, html.py, etc.) are also included in
here.
"""
import re, sys

# Identifiers in the text used to identify code and math blocks
_CODE_BLOCK = '<<<!!CODE_BLOCK'
_MATH_BLOCK = '<<<!!MATH_BLOCK'

def where():
    """
    Return the location where the doconce package is installed.
    """
    # Technique: find the directory where this common.py file resides
    import os
    return os.path.dirname(__file__)

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

    # could leave @@@CODE blocks to ptex2tex, but then these lines must be
    # removed since they may contain underscores and asterix and hence
    # be destroyed by substutitions of inline tags

    return filestr, code_blocks, code_block_types, tex_blocks


def insert_code_and_tex(filestr, code_blocks, tex_blocks, format):
    lines = filestr.splitlines()
    for code in code_blocks:
        # the following construction does not handle newlines in regex and
        # similar verbatim environments properly:
        #filestr = re.sub(r'%s (.*?)\n' % _CODE_BLOCK,
        #                 '!bc\g<1>\n%s!ec\n' % code, filestr, 1)
        # use string.replace instead

        for i in range(len(lines)):
            if _CODE_BLOCK in lines[i]:
                words = lines[i].split()
                words[0] = '!bc'
                lines[i] = ' '.join(words) + '\n' + code + '!ec'
                break

    for tex in tex_blocks:
        # Also here problems with this: (\nabla becomes \n (newline) and abla)
        # which means that
        # filestr = re.sub(_MATH_BLOCK, '!bt\n%s!et' % tex, filestr, 1)
        # does not work properly. Instead, we use str.replace

        for i in range(len(lines)):
            if _MATH_BLOCK in lines[i]:
                lines[i] = lines[i].replace(_MATH_BLOCK,
                                            '!bt\n%s!et' % tex)
                break

    filestr = '\n'.join(lines) + '\n' # will fail if ord(char) > 127
    return filestr

def doconce_exercise_output(exer,
                            begin_exercise, end_exercise,
                            begin_answer, end_answer,
                            begin_solution, end_solution,
                            begin_hint, end_hint,
                            include_numbering=True,
                            include_type=True):
    """
    Write exercise in Doconce format. This output can be
    reused in most formats.
    """
    s = '\n\n' + begin_exercise + '\n\n'
    s += exer['heading']  # result string
    if include_numbering and not include_type:
        include_type = True
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
                begin_hint_ = begin_hint
            else:
                begin_hint_ = begin_hint.replace('Hint.', 'Hint %d.' % (i+1))
            s += '\n' + begin_hint_ + hint + end_hint + '\n'

    if exer['answer']:
        s += '\n' + begin_answer + exer['answer'] + end_answer + '\n'

    if exer['solution']:
        s += '\n' + begin_solution
        # Make sure we have a sentence after the heading
        if exer['solution'].lstrip().startswith(_CODE_BLOCK):
            print '\nwarning: open solution in exercise "%s" with a line of\ntext before the code! (Now "Code:" is inserted)' % exer['title'] + '\n'
            s += 'Code:\n'
        s += exer['solution'] + '\n' + end_solution + '\n'

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
                        begin_hint_ = begin_hint
                    else:
                        begin_hint_ = begin_hint.replace(
                            'Hint.', 'Hint %d.' % (i+1))
                    s += '\n' + begin_hint_ + hint + end_hint + '\n'

                if subex['file']:
                    s += '*Filename*: `%s`' % subex['file'] + '.\n'

                if subex['answer']:
                    s += '\n' + begin_answer + subex['answer'] + end_answer + '\n'

                if subex['solution']:
                    s += '\n' + begin_solution
                    # Make sure we have a sentence after the heading
                    if subex['solution'].lstrip().startswith(_CODE_BLOCK):
                        print '\nwarning: open solution in exercise "%s" with a line of text\nbefore the code! (Now "Code:" was inserted)' % exer['title'] + '\n'
                        s += 'Code:\n'
                    s += subex['solution'] + '\n' + end_solution + '\n'

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

    s += '\n' + end_exercise + '\n\n'
    return s

def plain_exercise(exer):
    begin_exercise = '# --- begin exercise'
    end_exercise = '# --- end of exercise'
    begin_solution = '# --- begin solution of exercise\n\n__Solution.__\n'
    end_solution = '\n# --- end solution of exercise'
    begin_answer = '# --- begin short answer in exercise\n\n__Answer.__ '
    end_answer = '\n# --- end short answer in exercise'
    begin_hint = '__Hint.__ '
    end_hint = ''

    return doconce_exercise_output(exer,
                                   begin_exercise, end_exercise,
                                   begin_answer, end_answer,
                                   begin_solution, end_solution,
                                   begin_hint, end_hint,
                                   True, True)

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
