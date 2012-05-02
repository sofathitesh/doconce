#!/usr/bin/env python
import re, os, sys, shutil, commands, pprint, time, glob, codecs
try:
    from collections import OrderedDict   # v2.7 and v3.1
except ImportError:
    # use standard arbitrary-ordered dict instead (original order of
    # citations is then lost)
    OrderedDict = dict

global debug
debug = False  # can be reset in main()
def debugpr(out):
    if debug:
        #print out
        global _log
        _log = open('_doconce_debugging.log','a')
        _log.write(out + '\n')
        _log.close()


from common import *
import html, latex, pdflatex, rst, sphinx, st, epytext, plaintext, gwiki, mwiki, cwiki, pandoc
for module in html, latex, pdflatex, rst, sphinx, st, epytext, plaintext, gwiki, mwiki, cwiki, pandoc:
    #print 'calling define function in', module.__name__
    module.define(FILENAME_EXTENSION,
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
                  INTRO,
                  OUTRO)

def supported_format_names():
    return 'html', 'latex', 'pdflatex', 'rst', 'sphinx', 'st', 'epytext', 'plain', 'gwiki', 'mwiki', 'cwiki', 'pandoc'

#----------------------------------------------------------------------------
# Translators: (do not include, use import as shown above)
# include "common.py"
# include "html.py"
# include "latex.py"
#----------------------------------------------------------------------------

def syntax_check(filestr, format):

    pattern = re.compile(r'^ +![eb][ct]', re.MULTILINE)
    m = pattern.search(filestr)
    if m:
        print '\nSyntax error: !bc/!bt/!ec/!et does not start at the beginning of the line'
        print repr(filestr[m.start():m.start()+80])
        sys.exit(1)

    pattern = re.compile(r'[^\n:.?!,]^(!b[ct]|@@@CODE)', re.MULTILINE)
    m = pattern.search(filestr)
    if m:
        print '\nSyntax error: Line before !bc/!bt/@@@CODE block\nends with wrong character (must be among [\\n:.?!, ]):'
        print repr(filestr[m.start():m.start()+80])
        sys.exit(1)

    # Code blocks cannot come directly after tables or headings.
    # Remove idx{} and label{} since these will be move for rst.
    # Also remove all comments since these are also "invisible"
    filestr2 = filestr
    for tag in 'label', 'idx':
        filestr2 = re.sub('%s\{.+?\}' % tag, '', filestr2)
    pattern = re.compile(r'^#.*$', re.MULTILINE)
    filestr2 = pattern.sub('', filestr2)
    for linetp in '===', r'-\|', '__':  # section, table, paragraph
        pattern = re.compile(r'%s\s+^(!b[ct]|@@@CODE)' % linetp,
                             re.MULTILINE)
        m = pattern.search(filestr2)
        if m and format in ('rst', 'plain', 'epytext', 'st'):
            print '\nSyntax error: Must have a plain sentence before\na code block like !bc/!bt/@@@CODE, not a section/paragraph heading,\ntable, or comment:'
            print filestr2[m.start():m.start()+80]
            sys.exit(1)

    # Code/latex blocks cannot have a comment, table, figure, etc.
    # right before them
    constructions = {'comment': r'^\s*#.*?$',
                     'table': r'-\|\s*$',
                     'figure': r'^\s*FIGURE:.+$',
                     'movie': r'^\s*MOVIE:.+$',
                     }
    for construction in constructions:
        pattern = re.compile(r'%s\s*^(!b[ct]|@@@CODE|\s*\*)' % \
                             constructions[construction],
                             re.MULTILINE)
        m = pattern.search(filestr)
        if m:
            #and (format == 'rst' or format == 'sphinx'):
            print '\nSyntax error: Line before list or !bc/!bt/@@@CODE block is a %s line\nwhich will "swallow" the block in reST format.\nInsert some ekstra line (text) to separate the two elements.' % construction
            print filestr[m.start():m.start()+80]
            sys.exit(1)

    matches = re.findall(r'\\cite\{.+?\}', filestr)
    if matches:
        print '\nWarning: found \\cite{...} (cite{...} has no backslash)'
        print '\n'.join(matches)

    matches = re.findall(r'\\idx\{.+?\}', filestr)
    if matches:
        print '\nWarning: found \\idx{...} (indx{...} has no backslash)'
        print '\n'.join(matches)
        sys.exit(1)

    matches = re.findall(r'\\index\{.+?\}', filestr)
    if matches:
        print '\nWarning: found \\index{...} (index is written idx{...})'
        print '\n'.join(matches)

    # There should only be ref and label *without* the latex-ish backslash
    matches = re.findall(r'\\label\{.+?\}', filestr)
    if matches:
        print '\nWarning: found \\label{...} (label{...} has no backslash)'
        print '\n'.join(matches)

    matches = re.findall(r'\\ref\{.+?\}', filestr)
    if matches:
        print '\nWarning: found \\ref{...} (ref{...} has no backslash)'
        print '\n'.join(matches)

    # consistency check between label{} and ref{}:
    # (does not work well without labels from the !bt environments)
    """
    labels = re.findall(r'label\{(.+?)\}', filestr)
    refs = re.findall(r'ref\{(.+?)\}', filestr)
    for ref in refs:
        if not ref in labels:
            print '...ref{%s} has no corresponding label{%s} (within this file)' % \
                (ref, ref)
    """

    # Double quotes and not double single quotes in *plain text*:
    inside_code = False
    inside_math = False
    for line in filestr.splitlines():
        if line.startswith('!bc'):
            inside_code = True
        if line.startswith('!bt'):
            inside_math = True
        if line.startswith('!ec'):
            inside_code = False
        if line.startswith('!et'):
            inside_math = False

        if not inside_code:
            if "``" in line:
                print '''\nWarning: Double back-quotes `` found in file - should be "?'''
        if not inside_math:
            if "''" in line:
                #print '''\nWarning: Double forward-quotes '' found in file - should be "\n(unless derivatives in math)'''
                pass

    commands = [
        'begin{equation}',
        'end{equation}',
        'begin{equation*}',
        'end{equation*}',
        'begin{eqnarray}',
        'end{eqnarray}',
        'begin{eqnarray*}',
        'end{eqnarray*}',
        'begin{align}',
        'end{align}',
        'begin{align*}',
        'end{align*}',
        'begin{multline}',
        'end{multline}',
        'begin{multline*}',
        'end{multline*}',
        'begin{gather}',
        'end{gather}',
        'begin{gather*}',
        'end{gather*}',
        # some common abbreviations (newcommands):
        'beqan',
        'eeqan',
        'beqa',
        'eeqa',
        'balnn',
        'ealnn',
        'baln',
        'ealn',
        'beq',
        'eeq',  # the simplest, contained in others, must come last...
        ]
    lines = filestr.splitlines()
    for i in range(len(lines)):
        for c in commands:
            if c[0] == 'b':
                if (c in lines[i] or r'\[' in lines[i]) and '`' not in lines[i]:
                    # begin math, do we have !bt at the line before?
                    prev_line = i-1
                    while prev_line >= 0 and lines[prev_line].isspace():
                        prev_line -= 1
                    if not lines[prev_line].startswith('!bt'):
                        # Must have !bt unless !bc block
                        if not lines[prev_line].startswith('!bc'):
                            print '\nWarning: forgot to precede math (%s) by !bt:' % c
                            stop_line = i+2 if i+2 <+ len(lines)-1 else len(lines)-1
                            for k in range(prev_line, stop_line):
                                print lines[k]
            elif c[0] == 'e':
                # actually, the end part is never reached, because
                # if the begin part is missing, program stops, and
                # if the begin part is there, the whole block, incl
                # an erroneous end part, is removed when this syntax
                # check is performed...
                pass
            """
                if c in lines[i] or r'\]' in lines[i]:
                    # end math, do we have !et at the line after?
                    ...
            """
    """
    # This is better done in sphinx.py, or should we provide warnings
    # to enforce writers to stay away from a range of latex
    # constructions even if sphinx.py can substitute them away?
    """
    not_for_sphinx = [
        '{eqnarray}',
        '{eqnarray*}',
        '{multline}',
        '{multline*}',
        '{gather}',
        '{gather*}',
        'beqan',
        'beqa',
        ]
    warning_given = False
    if format == 'sphinx':
        for command in not_for_sphinx:
            if command in filestr:
                if not warning_given:
                    print '\nWarning:'
                print 'Not recommended for sphinx output: math environment %s' % command
                if not warning_given:
                    print '(use equation, \[ \], or align/align*)'
                    warning_given = True
    """
    """

    # Cannot check on these since doconce documents about ptex2tex and
    # latex writings may contain these expressions in inline verbatim or
    # block verbatim
    """
    patterns = r'\\[be]cod', r'\\begin{[Vv]erbatim', r'\\end{[Vv]erbatim', r'\\[be]sys', r'\\[be]py',
    for pattern in patterns:
        matches = re.findall(pattern, filestr)
        if matches:
            print '\nSyntax error: Wrong syntax (latex!)'
            print '\n'.join(matches)
            sys.exit(1)
    """

    pattern = r'__[A-Z][A-Za-z0-9,:` ]+__\.'
    matches = re.findall(pattern, filestr)
    if matches:
        print '\nSyntax error: Wrong paragraphs'
        print '\n'.join(matches)
        sys.exit(1)

    pattern = re.compile(r'^__[A-Za-z0-9,: ]+?__', re.MULTILINE)
    matches = pattern.findall(filestr)
    if matches:
        print 'Warning: Missing period or similar after paragraph heading'
        print '\n'.join(matches)

    pattern = r'idx\{[^}]*?\\_[^}]*?\}'
    matches = re.findall(pattern, filestr)
    if matches:
        print 'Warning: Backslash before underscore(s) in idx'
        print matches

    # Figure without comma between filename and options? Or initial spaces?
    pattern = r'^FIGURE:\s*\[[^,\]]+ +[^\]]*\]'
    cpattern = re.compile(pattern, re.MULTILINE)
    matches = cpattern.findall(filestr)
    if matches:
        print '\nSyntax error in FIGURE specification'\
              '\nmissing comma after filename, before options'
        print '\n'.join(matches)
        sys.exit(1)

    # Movie without comma between filename and options? Or initial spaces?
    pattern = r'^MOVIE:\s*\[[^,\]]+ +[^\]]*\]'
    cpattern = re.compile(pattern, re.MULTILINE)
    matches = cpattern.findall(filestr)
    if matches:
        print '\nSyntax error in MOVIE specification'\
              '\nmissing comma after filename, before options'
        print '\n'.join(matches)
        sys.exit(1)

    # Keywords at the beginning of the lines:
    keywords = 'AUTHOR', 'TITLE', 'DATE', 'FIGURE', 'BIBFILE', 'MOVIE'
    for kw in keywords:
        pattern = '^ +' + kw
        cpattern = re.compile(pattern, re.MULTILINE)
        matches = cpattern.findall(filestr)
        if matches:
            print '\nSyntax error in %s specification'\
                  '\ninitial space(s) online before keyword' % kw
            print '\n'.join(matches)
            sys.exit(1)

    # Keywords without colon:
    for kw in keywords:
        pattern = '^' + kw + ' +'
        cpattern = re.compile(pattern, re.MULTILINE)
        matches = cpattern.findall(filestr)
        if matches:
            print '\nSyntax error in %s: specification'\
                  '\nmissing colon after keyword' % kw
            print '\n'.join(matches)
            sys.exit(1)

    if format == "latex":
        # if TITLE is given, AUTHOR and DATE must also be present
        #md = re.search(r'^DATE:', filestr, flags=re.MULTILINE)
        #mt = re.search(r'^TITLE:', filestr, flags=re.MULTILINE)
        #ma = re.search(r'^AUTHOR:', filestr, flags=re.MULTILINE)
        cdate   = re.compile(r'^DATE:', re.MULTILINE)  # v2.6 way of doing it
        ctitle  = re.compile(r'^TITLE:', re.MULTILINE)
        cauthor = re.compile(r'^AUTHOR:', re.MULTILINE)
        md = cdate.search(filestr)
        mt = ctitle.search(filestr)
        ma = cauthor.search(filestr)
        if md or mt or ma:
            if not (md and mt and ma):
                print """
Syntax error: latex format requires TITLE, AUTHOR and DATE to be
specified if one of them is present."""
                if not md:
                    print 'DATE is missing'
                if not mt:
                    print 'TITLE is missing'
                if not ma:
                    print 'AUTHOR is missing'
                sys.exit(1)

def make_one_line_paragraphs(filestr, format):
    # THIS FUNCTION DOES NOT WORK WELL - it's difficult to make
    # one-line paragraphs...
    print 'make_one_line_paragraphs: this function does not work well'
    print 'drop oneline_paragraphs option on the command line...'
    # make double linebreaks to triple
    filestr = re.sub('\n *\n', '[[[[[DOUBLE_NEWLINE]]]]]', filestr)
    # save some single linebreaks
    # section headings
    filestr = re.sub('(===+)\n', r'\g<1>[[[[[SINGLE_NEWLINE]]]]]\n', filestr)
    # tables
    filestr = re.sub('(\\|\\s*)\n', r'\g<1>[[[[[SINGLE_NEWLINE]]]]]\n', filestr)
    # idx/label/ref{}
    filestr = re.sub('(\\}\\s*)\n', r'\g<1>[[[[[SINGLE_NEWLINE]]]]]\n', filestr)
    filestr = re.sub('\n(AUTHOR|TITLE|DATE|FIGURE)', r'\n[[[[[SINGLE_NEWLINE]]]]]\g<1>', filestr)
    debugpr('\n\n\n**** ONELINE1:\n\n%s\n\n' % filestr)

    # then remove all single linebreaks + following indentation
    filestr = re.sub('\n *', ' ', filestr)
    debugpr('\n\n\n**** ONELINE2:\n\n%s\n\n' % filestr)
    # finally insert single and double linebreaks
    filestr = filestr.replace('[[[[[SINGLE_NEWLINE]]]]] ', '\n')
    filestr = filestr.replace('[[[[[SINGLE_NEWLINE]]]]]', '\n')
    debugpr('\n\n\n**** ONELINE3:\n\n%s\n\n' % filestr)
    filestr = filestr.replace('[[[[[DOUBLE_NEWLINE]]]]] ', '\n\n')
    filestr = filestr.replace('[[[[[DOUBLE_NEWLINE]]]]]', '\n\n')
    debugpr('\n\n\n**** ONELINE4:\n\n%s\n\n' % filestr)
    return filestr

def insert_code_from_file(filestr, format):
    lines = filestr.splitlines()
    inside_verbatim = False
    for i in range(len(lines)):
        line = lines[i]
        line = line.lstrip()

        # detect if we are inside verbatim blocks:
        if line.startswith('!bc'):
            inside_verbatim = True
        if line.startswith('!ec'):
            inside_verbatim = False
        if inside_verbatim:
            continue

        if line.startswith('@@@CODE'):
            debugpr('\nFound verbatim copy (line %d):\n%s\n' % (i+1, line))
            words = line.split()
            try:
                filename = words[1]
            except IndexError:
                raise SyntaxError, \
                      'Syntax error: missing filename in line\n  %s' % line
            try:
                codefile = open(filename, 'r')
            except IOError, e:
                print 'Could not open the file %s used in @@@CODE instruction' % filename
                print e
                sys.exit(1)

            # Determine code environment from filename extension
            filename_ext = os.path.splitext(filename)[1]
            if filename_ext == '.cxx' or filename_ext == '.C':
                filename_ext = '.cpp'
            if filename_ext == '.pyx':  # Cython code is called cy
                filename_ext = '.cy'
            if filename_ext in ('.py', '.f', '.c', '.cpp', '.sh',
                                '.m', '.pl', '.cy'):
                code_envir = filename_ext[1:]
            else:
                code_envir = ''

            m = re.search(r'from-?to:', line)
            if m:
                index = m.start()
                fromto = m.group()
            else:
                index = -1  # no from-to or fromto
                fromto = 'fromto:'  # default

            #print index, words
            if index == -1 and len(words) < 3:
                # no from/to regex, read the whole file:
                print 'copy complete file %s' % filename,
                complete_file = True
                code = codefile.read().strip()
                debugpr('copy the whole file "%s" into a verbatim block\n' % filename)

            else:
                complete_file = False
                if index >= 0:
                    patterns = line[index+len(fromto):].strip()
                else:
                    # fromto: was not found, that is okay, use the
                    # remaining words as patterns
                    patterns = ' '.join(words[2:]).strip()
                try:
                    from_, to_ = patterns.split('@')
                except:
                    raise SyntaxError, \
                    'Syntax error: missing @ in regex in line\n  %s' % line

                print 'copy %s regex "%s" until "%s"\n     file: %s,' % \
                      ('after' if fromto == 'from-to:' else 'from',
                       from_, to_, filename),
                # Note that from_ and to_ are regular expressions
                # and to_ might be empty
                cfrom = re.compile(from_)
                cto = re.compile(to_)

                # Task: copy from the line with from_ if fromto is 'fromto:',
                # or copy from the line after the with from_ if fromto
                # is 'from-to:', and copy all lines up to, but not including,
                # the line matching to_

                codefile_lines = codefile.readlines()
                from_found = False
                to_found = False
                from_line = -1
                to_line = len(codefile_lines)
                codelines = []
                copy = False
                for line_no, codeline in enumerate(codefile_lines):
                    mf = cfrom.search(codeline)
                    if mf and fromto == 'fromto:' and not from_found:
                        # The test on not to_found ensures that
                        # we cannot get a second match for from_
                        # (which copies to the end if there are no
                        # following matches for to_!)
                        copy = True
                        from_found = True
                        from_line = line_no+1
                        debugpr('hit (fromto:) start "%s" (as "%s") in line no. %d\n%s\ncode environment: %s' % (from_, codeline[mf.start():mf.end()], line_no+1, codeline, code_envir if code_envir else 'none'))

                    if to_:
                        mt = cto.search(codeline)
                        if mt:
                            copy = False
                            to_found = True
                            to_line = line_no+1
                            # now the to_ line is not included
                            debugpr('hit end "%s" (as "%s") in line no. %d\n%s' %  (to_, codeline[mt.start():mt.end()], line_no+1, codeline))
                    if copy:
                        debugpr('copy: %s' % codeline.rstrip())
                        if codeline[-2:] == '\\\n':
                            # Insert extra space to preserve
                            # continuation line
                            codeline = codeline[:-2] + '\\ \n'
                        codelines.append(codeline)

                    if mf and fromto == 'from-to:' and not from_found:
                        copy = True  # start copy from next codeline
                        from_found = True
                        from_line = line_no+2
                        debugpr('hit (from-to:) start "%s" (as "%s") in line no. %d\n%s\ncode environment: %s' % (from_, codeline[mf.start():mf.end()], line_no+1, codeline, code_envir if code_envir else 'none'))

                code = ''.join(codelines)
                code = code.rstrip() # remove trailing whitespace
                if code == '' or code.isspace():
                    if not from_found:
                        print 'Could not find regex "%s".' % from_,
                    if not to_found:
                        print 'Could not find regex "%s".' % to_,
                    if from_found and to_found:
                        print '"From" and "to" regex match at the same line - empty text.',
                    print '\nAbort!'
                    sys.exit(1)
                print ' lines %d-%d' % (from_line, to_line),
            codefile.close()

            #if format == 'latex' or format == 'pdflatex' or format == 'sphinx':
                # Insert a cod or pro directive for ptex2tex and sphinx.
            if True:
                if complete_file:
                    code = "!bc %spro\n%s\n!ec" % (code_envir, code)
                    print ' (format: %spro)' % code_envir
                else:
                    code = "!bc %scod\n%s\n!ec" % (code_envir, code)
                    print ' (format: %scod)' % code_envir
            else:
                code = "!bc\n%s\n!ec" % code
                print
            lines[i] = code

    filestr = '\n'.join(lines)
    return filestr


def exercises(filestr, format):
    # Exercise: ===== Exercise: title ===== (starts with at least 3 =, max 5)
    # label{some:label} file=thisfile.py solution=somefile.do.txt or file.py
    # __Hint 1.__ some paragraph...,
    # __Hint 2.__ ...

    debugpr('\n\n\n***** Exercises *****\nLooking for exercises in the whole file:\n%s\n..............\n' % filestr)

    all_exer = []   # collection of all exercises
    exer = {}       # data for one exercise
    inside_exer = False
    exer_end = False
    exer_counter = 0
    lines = filestr.splitlines()
    newlines = []  # lines in resulting file
    exer_line_pattern = re.compile(r'^\s*([_=]{3,5})\s*([Ee]xercise|[Pp]roblem|[Pp]roject):\s*(?P<title>[^ =-].+?)\s*[_=]+')
    label_pattern = re.compile(r'label\{(.+?)\}')
    file_pattern = re.compile(r'file\s*=\s*([^\s]+)')
    solution_pattern = re.compile(r'solution\s*=\s*([^\s]+)')
    for i in range(len(lines)):
        m = exer_line_pattern.search(lines[i])
        if m:
            exer = {}  # data in the exercise
            exer['title'] = m.group('title')
            exer['heading'] = m.group(1)
            exer['type'] = m.group(2)
            inside_exer = True
            exer['text'] = []
            exer['hint'] = {}
            exer['comments'] = []
            exer_counter += 1
            exer['no'] = exer_counter
            hint_counter = 0
            inside_hint = False
            exer_end = False
            text_line = True
        elif inside_exer:
            label_info_line = False
            m = label_pattern.search(lines[i])
            if m:
                exer['label'] = m.group(1)
                label_info_line = True
            m = file_pattern.search(lines[i])
            if m:
                exer['file'] = m.group(1)
                label_info_line = True
            m = solution_pattern.search(lines[i])
            if m:
                exer['solution'] = m.group(1)
                label_info_line = True

            # Hints have to come at the end of the text.
            # Only __Hint marks the beginning of a new hint.
            if '__Hint' in lines[i]:
                hint_counter += 1
                exer['hint'][hint_counter] = []
                inside_hint = True
                text_line = False
            if inside_hint:
                if lines[i].startswith('#'):
                    exer['comments'].append(lines[i])
                else:
                    exer['hint'][hint_counter].append(lines[i])

            if text_line and not label_info_line:
                if lines[i].startswith('#'):
                    exer['comments'].append(lines[i])
                else:
                    exer['text'].append(lines[i])
        else:  # outside exercise
            newlines.append(lines[i])

        # End of exercise? Either new (sub)section with at least ===
        # or end of file
        if i == len(lines) - 1:  # last line?
            exer_end = True
        elif inside_exer and lines[i+1].startswith('==='):
            exer_end = True

        if exer and exer_end:
            exer['text'] = '\n'.join(exer['text']).strip()
            for hint_no in exer['hint']:
                exer['hint'][hint_no] = '\n'.join(exer['hint'][hint_no]).strip()
            exer['comments'] = '\n'.join(exer['comments']).strip()

            debugpr(pprint.pformat(exer))
            formatted_exercise = EXERCISE[format](exer)
            newlines.append(formatted_exercise)
            all_exer.append(exer)
            inside_exer = False
            exer_end = False
            exer = {}

    filestr = '\n'.join(newlines)
    if all_exer:
        exer_filename = filename.replace('.do.txt', '')
        exer_filename = '.%s.exerinfo' % exer_filename
        f = open(exer_filename, 'w')
        f.write("""
# Information about all exercises in the file %s.
# The information can be loaded into a Python list of dicts
# by the code (f is an open filehandle to the current file):
#
# for i in range(7): f.readline()  # skip comments in the top
# exer = eval(f.read())
#
""" % filename)
        f.write(pprint.pformat(all_exer))
        f.close()
        print 'Info about %d exercises written to %s' % \
              (len(all_exer), exer_filename)
    else:
        debugpr('No exercises found.\n')

    return filestr


def parse_keyword(keyword, format):
    """
    Parse a keyword for a description list when the keyword may
    represent information about an argument to a function or a
    variable in a program::

      - argument x: x coordinate (float).
      - keyword argument tolerance: error tolerance (float).
      - return: corresponding y coordinate (float).
    """
    keyword = keyword.strip()
    if keyword[-1] == ':':      # strip off trailing colon
        keyword = keyword[:-1]

    typical_words = ('argument', 'keyword argument', 'return', 'variable')
    parse = False
    for w in typical_words:
        if w in keyword:    # part of function argument++ explanation?
            parse = True
            break
    if not parse:
        # no need to parse for variable type and name
        if format == 'epytext':
            # epytext does not have description lists, add a "bullet" -
            keyword = '- ' + keyword
        return keyword

    # parse:
    if 'return' in keyword:
        type = 'return'
        varname = None
        type = ARGLIST[format][type]  # formatting of keyword type
        return type
    else:
        words = keyword.split()
        varname = words[-1]
        type = ' '.join(words[:-1])
        if type == 'argument':
            type = 'parameter'
        elif type == 'keyword argument':
            type = 'keyword'
        elif type == 'instance variable':
            type = 'instance variable'
        elif type == 'class variable':
            type = 'class variable'
        elif type == 'module variable':
            type = 'module variable'
        else:
            return keyword # probably not a list of variable explanations
        # construct "type varname" string, where varname is typeset in
        # inline verbatim:
        pattern = r'(?P<begin>^)(?P<subst>%s)(?P<end>$)' % varname
        #varname = re.sub(pattern, INLINE_TAGS_SUBST[format]['verbatim'], varname)
        keyword = ARGLIST[format][type] + ' ' + varname
        return keyword


def typeset_tables(filestr, format):
    """
    Translate tables with pipes and dashes to a list of
    row-column values. Horizontal rules become a row
    ['horizontal rule'] in the list.
    The list is easily translated to various output formats
    by other modules.
    """
    from StringIO import StringIO
    result = StringIO()
    # table is a dict with keys rows, headings_align, columns_align
    table = {'rows': []}  # init new table
    inside_table = False
    for line in filestr.splitlines():
        lin = line.lstrip()
        # horisontal table rule?
        if lin.startswith('|--') and lin.endswith('-|'):
            table['rows'].append(['horizontal rule'])
            # see if there is c-l-r alignments:
            align = lin[1:-1].replace('-', '') # keep | in align spec.
            if align:
                if align == '|'*len(align):  # Just '|||'?
                    print 'Syntax error: horizontal rule in table '\
                          'contains | between columns - remove these.'
                    print line
                    sys.exit(1)
                for char in align:
                    if char not in ('|', 'r', 'l', 'c'):
                        print 'illegal alignment character in table:', char
                        sys.exit(1)

                if len(table['rows']) == 0:
                    # first horizontal rule, align concern headings
                    table['headings_align'] = align
                else:
                    # align concerns column alignment
                    table['columns_align'] = align
            continue  # continue with next line
        if lin.startswith('|') and not lin.startswith('|--'):
            # row in table:
            if not inside_table:
                inside_table = True
            columns = line.strip().split('|')
            # remove empty columns and extra white space:
            #columns = [c.strip() for c in columns if c]
            columns = [c.strip() for c in columns if c.strip()]
            table['rows'].append(columns)
        elif lin.startswith('#') and inside_table:
            continue  # just skip commented table lines
        else:
            if inside_table:
                # not a table line anymore, but we were just inside a table
                # so the table is ended
                inside_table = False
                result.write(TABLE[format](table))   # typeset table
                table = {'rows': []}  # init new table
            else:
                result.write(line + '\n')
    return result.getvalue()

def typeset_lists(filestr, format, debug_info=[]):
    """
    Go through filestr and parse all lists and typeset them correctly.
    This function must be called after all (verbatim) code and tex blocks
    have been removed from the file.
    This function also treats comment lines and blank lines.
    """
    debugpr('*** List typesetting phase + comments and blank lines ***')
    from StringIO import StringIO
    result = StringIO()
    lastindent = 0
    lists = []
    inside_description_environment = False
    lines = filestr.splitlines()
    lastline = lines[0]
    # for debugging only:
    _code_block_no = 0; _tex_block_no = 0

    for line in lines:
        debugpr('\n------------------------\nsource line=[%s]' % line)
        # do a syntax check:
        for tag in INLINE_TAGS_BUGS:
            bug = INLINE_TAGS_BUGS[tag]
            if bug:
                m = re.search(bug[0], line)
                if m:
                    print '>>> Syntax ERROR? "%s"\n    %s!' % \
                          (m.group(0), bug[1])
                    print '    In line\n', line

        if not line or line.isspace():  # blank line?
            if not lists:
                result.write(BLANKLINE[format])
            # else: drop writing out blank line inside lists
                debugpr('  > This is a blank line')
            lastline = line
            continue

        if line.startswith('#'):

            # first do some debug output:
            if line.startswith('#!!CODE') and len(debug_info) >= 1:
                result.write(line + '\n')
                debugpr('  > Here is a code block:\n%s\n--------' % \
                      debug_info[0][_code_block_no])
                _code_block_no += 1
            elif line.startswith('#!!TEX') and len(debug_info) >= 2:
                result.write(line + '\n')
                debugpr('  > Here is a latex block:\n%s\n--------' % \
                      debug_info[1][_tex_block_no])
                _tex_block_no += 1

            else:
                debugpr('  > This is just a comment line')
                # the comment can be propagated to some formats
                # (rst, latex, html):
                line = line[1:]  # strip off initial #
                if 'comment' in INLINE_TAGS_SUBST[format]:
                    comment_action = INLINE_TAGS_SUBST[format]['comment']
                    if isinstance(comment_action, str):
                        new_comment = comment_action % line.strip()
                    elif callable(comment_action):
                        new_comment = comment_action(line.strip())
                    result.write(new_comment + '\n')

            lastline = line
            continue

        # structure of a line:
        linescan = re.compile(
            r"(?P<indent> *(?P<listtype>[*o-] )? *)" +
            r"(?P<keyword>.+?:\s+)?(?P<text>.*)\s?")
            #r"(?P<keyword>[^:]+?:)?(?P<text>.*)\s?")

        m = linescan.match(line)
        indent = len(m.group('indent'))
        listtype = m.group('listtype')
        if listtype:
            listtype = listtype.strip()
            listtype = LIST_SYMBOL[listtype]
        keyword = m.group('keyword')
        text = m.group('text')
        debugpr('  > indent=%d (previous indent=%d), keyword=[%s], text=[%s]' % (indent, lastindent, keyword, text))

        # new (sub)section makes end of any indent (we could demand
        # (sub)sections to start in column 1, but we have later relaxed
        # such a requirement; it is easier to just test for ___ or === and
        # set indent=0 here):
        if line.lstrip().startswith('___') or line.lstrip().startswith('==='):
            indent = 0


        if indent > lastindent and listtype:
            debugpr('  > This is a new list of type "%s"' % listtype)
            # begin a new list or sublist:
            lists.append({'listtype': listtype, 'indent': indent})
            result.write(LIST[format][listtype]['begin'])
            if len(lists) > 1:
                result.write(LIST[format]['separator'])

            lastindent = indent
            if listtype == 'enumerate':
                enumerate_counter = 0
        elif listtype:
            # inside a list, but not in the beginning
            # (we don't write out blank lines inside lists anymore!)
            # write a possible blank line if the format wants that between items
            result.write(LIST[format]['separator'])

        if indent < lastindent:
            # end a list or sublist, nest back all list
            # environments on the lists stack:
            while lists and lists[-1]['indent'] > indent:
                 debugpr('  > This is the end of a %s list' % \
                       lists[-1]['listtype'])
                 result.write(LIST[format][lists[-1]['listtype']]['end'])
                 del lists[-1]
            lastindent = indent

        if indent == lastindent:
            debugpr('  > This line belongs to the previous block since it has '\
                  'the same indent (%d blanks)' % indent)

        if listtype:
            # (a separator (blank line) is written above because we need
            # to ensure that the separator is not written in the top of
            # an entire new list)

            # first write the list item identifier:
            itemformat = LIST[format][listtype]['item']
            if format == 'cwiki' or format == 'mwiki':
                itemformat = itemformat*len(lists)  # *, **, #, ## etc. for sublists
            item = itemformat
            if listtype == 'enumerate':
                debugpr('  > This is an item in an enumerate list')
                enumerate_counter += 1
                if '%d' in itemformat:
                    item = itemformat % enumerate_counter
                # indent here counts with '3. ':
                result.write(' '*(indent - 2 - enumerate_counter//10 - 1))
                result.write(item + ' ')
            elif listtype == 'description':
                if '%s' in itemformat:
                    if not keyword:
                        # empty keyword, the regex has a bad problem: when only
                        # keyword on the line, keyword is None and text
                        # is keyword - make a fix here
                        if text[-1] == ':':
                            keyword = text
                            text = ''
                    if keyword:
                        keyword = parse_keyword(keyword, format) + ':'
                        item = itemformat % keyword + ' '
                        debugpr('  > This is an item in a description list '\
                              'with parsed keyword=[%s]' % keyword)
                        keyword = '' # to avoid adding keyword up in
                        # below (ugly hack, but easy linescan parsing...)
                    else:
                        debugpr('  > This is an item in a description list, but empty keyword, serious error....')
                result.write(' '*(indent-2))  # indent here counts with '- '
                result.write(item)
                if not (text.isspace() or text == ''):
                    #result.write('\n' + ' '*(indent-1))
                    # Need special treatment if type specifications in
                    # descrption lists for sphinx API doc
                    if format == 'sphinx' and text.lstrip().startswith('type:'):
                        text = text.lstrip()[5:].lstrip()
                        # no newline for type info
                    else:
                        result.write('\n' + ' '*(indent))
            else:
                debugpr('  > This is an item in a bullet list')
                result.write(' '*(indent-2))  # indent here counts with '* '
                result.write(item + ' ')

        else:
            debugpr('  > This line is some ordinary line, no special list syntax involved')
            # should check emph, verbatim, etc., syntax check and common errors
            result.write(' '*indent)      # ordinary line

        # this is not a list definition line and therefore we must
        # add keyword + text because these two items make up the
        # line if a : present in an ordinary line
        if keyword:
            text = keyword + text
        debugpr('text=[%s]' % text)

        # hack to make wiki have all text in an item on a single line:
        newline = '' if lists and (format == 'gwiki' or format == 'mwiki' or format == 'cwiki') \
                  else '\n'  # hack...
        #newline = '\n'
        result.write(text + newline)
        lastindent = indent
        lastline = line

    # end lists if any are left:
    while lists:
        debugpr('  > This is the end of a %s list' % lists[-1]['listtype'])
        result.write(LIST[format][lists[-1]['listtype']]['end'])
        del lists[-1]

    return result.getvalue()


def handle_figures(filestr, format):
    if not format in FIGURE_EXT:
        # no special handling of figures:
        return filestr

    pattern = INLINE_TAGS['figure']
    c = re.compile(pattern, re.MULTILINE)

    # First check if the figure files are of right type, then
    # call format-specific functions for how to format the figures.

    files = [filename for filename, options, caption in c.findall(filestr)]
    if type(FIGURE_EXT[format]) is str:
        extensions = [FIGURE_EXT[format]]  # wrap in list
    else:
        extensions = FIGURE_EXT[format]
    import sets; files = sets.Set(files)   # remove multiple occurences
    for figfile in files:
        file_found = False
        if not os.path.isfile(figfile):
            basepath, ext = os.path.splitext(figfile)
            if not ext:  # no extension?
                # try to see if f + ext exists:
                for ext in extensions:
                    newname = figfile + ext
                    if os.path.isfile(newname):
                        print 'Figure file %s:\n    can use %s for format %s' % \
                              (figfile, newname, format)
                        filestr = filestr.replace(figfile, newname)
                        figfile = newname
                        file_found = True
                        break
                # try to see if other extensions exist:
                if not file_found:
                    candidate_files = glob.glob(figfile + '.*')
                    for newname in candidate_files:
                        if os.path.isfile(newname):
                            print 'Found', newname
                            filestr = filestr.replace(figfile, newname)
                            figfile = newname
                            file_found = True
                            break
        if not os.path.isfile(figfile):
            #raise ValueError('file %s does not exist' % figfile)
            print 'Figure file %s does not exist' % figfile
            sys.exit(1)

        basepath, ext = os.path.splitext(figfile)
        if not ext in extensions:
            # use convert from ImageMagick to convert to proper format:
            for e in extensions:
                converted_file = basepath + e
                if not os.path.isfile(converted_file):
                    # ext might be empty, in that case we cannot convert
                    # anything:
                    if ext:
                        failure = os.system('convert %s %s' % (figfile, converted_file))
                        if not failure:
                            print 'Figure', figfile, 'must have extension(s)', extensions
                            print '....converted %s to %s' % (figfile, converted_file)
                            filestr = filestr.replace(figfile, converted_file)
                            break  # jump out of inner e loop
                else:  # right file exists:
                    #print '....ok, ', converted_file, 'exists'
                    filestr = filestr.replace(figfile, converted_file)
                    break

    # replace FIGURE... by format specific syntax:
    try:
        replacement = INLINE_TAGS_SUBST[format]['figure']
        filestr = c.sub(replacement, filestr)
    except KeyError:
        pass
    return filestr


def handle_cross_referencing(filestr, format):
    # 1. find all section/chapter titles and corresponding labels
    #section_pattern = r'(_+|=+)([A-Za-z !.,;0-9]+)(_+|=+)\s*label\{(.+?)\}'
    section_pattern = r'(_{3,7}|={3,7})(.+?)(_{3,7}|={3,7})\s*label\{(.+?)\}'
    m = re.findall(section_pattern, filestr)
    #pprint.pprint(m)
    # Make sure sections appear in the right order
    # (in case rst.ref_and_label_commoncode has to assign numbers
    # to section titles that are identical)
    section_label2title = OrderedDict()
    for dummy1, title, dummy2, label in m:
        section_label2title[label] = title.strip()
    #pprint.pprint(section_label2title)

    # 2. perform format-specific editing of ref{...} and label{...}
    filestr = CROSS_REFS[format](section_label2title, format, filestr)
    return filestr


def handle_index_and_bib(filestr, format, has_title):
    """Process idx{...} and cite{...} instructions."""
    index = {}  # index[word] = lineno
    citations = OrderedDict()  # citations[label] = no_in_list (1,2,3,...)
    line_counter = 0
    cite_counter = 0
    bibfile = {}
    for line in filestr.splitlines():
        line_counter += 1
        line = line.strip()
        if line.startswith('BIBFILE:'):
            files = re.split(r'\s*,\s*', line[8:].strip())
            for filename in files:
                stem, ext = os.path.splitext(filename)
                if ext == '.bib':
                    bibfile['bib'] = stem
                elif ext == '.rst':
                    bibfile['rst'] = filename
                elif ext == '.py':
                    bibfile['py'] = filename
                else:
                    print '\nUnknown extension of BIBFILE:', filename
                    sys.exit(1)
        else:
            index_words = re.findall(r'idx\{(.+?)\}', line)
            if index_words:
                for word in index_words:
                    if word in index:
                        index[word].append(line_counter)
                    else:
                        index[word] = [line_counter]
                # note: line numbers in the .do.txt file are of very limited
                # value for the end format file...anyway, we make them...

            cite_args = re.findall(r'cite\{(.+?)\}', line)
            if cite_args:
                # multiple labels can be separated by comma:
                cite_labels = []
                for arg in cite_args:
                    for c in arg.split(','):
                        cite_labels.append(c.strip())
                for label in cite_labels:
                    if not label in citations:
                        cite_counter += 1  # new citation label
                        citations[label] = cite_counter
                # Replace cite{label1,label2,...} by individual cite{label1}
                # cite{label2}, etc. if not latex or pandoc format
                if format != 'latex' and format != 'pdflatex' and \
                       format != 'pandoc':
                    for arg in cite_args:
                        replacement = ' '.join(['cite{%s}' % label.strip() \
                                                 for label in arg.split(',')])
                        filestr = filestr.replace('cite{%s}' % arg,
                                                  replacement)
                elif format == 'pandoc':
                    # prefix labels with @ and substitute , by ;
                    for arg in cite_args:
                        replacement = ';'.join(
                            ['@' + label for label in arg.split(',')])
                        filestr = filestr.replace('cite{%s}' % arg,
                                                  replacement)

    # version < 2.7 warning
    if len(citations) > 0 and OrderedDict is dict:
        print 'Warning: citations may appear in random order unless you upgrade to Python version 2.7 or 3.1'
    filestr = INDEX_BIB[format](filestr, index, citations, bibfile)
    return filestr

def interpret_authors(filestr, format):
    debugpr('\n*** Dealing with authors and institutions ***')
    # first deal with AUTHOR as there can be several such lines
    author_lines = re.findall(r'^AUTHOR:\s*(?P<author>.+)\s*$', filestr,
                              re.MULTILINE)
    #filestr = re.sub(r'^AUTHOR:.+$', 'XXXAUTHOR', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^AUTHOR:.+$', re.MULTILINE)
    filestr = cpattern.sub('XXXAUTHOR', filestr)  # v2.6 way of doing it
    # contract multiple AUTHOR lines to one single:
    filestr = re.sub('(XXXAUTHOR\n)+', 'XXXAUTHOR', filestr)

    # (author, (inst1, inst2, ...) or (author, None)
    authors_and_institutions = []
    for line in author_lines:
        if ' at ' in line:
            # author and institution(s) given
            try:
                a, i = line.split(' at ')
            except ValueError:
                print 'Wrong syntax of author(s) and institution(s): too many "at":\n', line, '\nauthor at inst1, adr1 and inst2, adr2a, adr2b and inst3, adr3'
                sys.exit(1)
            a = a.strip()
            if ' and ' in i:
                i = [w.strip() for w in i.split(' and ')]
            else:
                i = (i.strip(),)
        else:  # just author's name
            a = line.strip()
            i = None
        if 'mail:' in a:  # email?
            a, e = re.split(r'[Ee]?mail:\s*', a)
            a = a.strip()
            e = e.strip()
            if not '@' in e:
                print 'Syntax error: wrong email specification in AUTHOR line: "%s" (no @)' % e
        else:
            e = None
        authors_and_institutions.append((a, i, e))

    inst2index = OrderedDict()
    index2inst = {}
    auth2index = OrderedDict()
    auth2email = OrderedDict()
    # get unique institutions:
    for a, institutions, e in authors_and_institutions:
        if institutions is not None:
            for i in institutions:
                inst2index[i] = None
    for index, i in enumerate(inst2index):
        inst2index[i] = index+1
        index2inst[index+1] = i
    for a, institutions, e in authors_and_institutions:
        if institutions is not None:
            auth2index[a] = [inst2index[i] for i in institutions]
        else:
            auth2index[a] = ''  # leads to empty address
        auth2email[a] = e

    # version < 2.7 warning:
    if len(auth2index) > 1 and OrderedDict is dict:
        print 'Warning: multiple authors\n - correct order of authors requires Python version 2.7 or 3.1 (or higher)'
    return authors_and_institutions, auth2index, inst2index, index2inst, auth2email, filestr

def typeset_authors(filestr, format):
    authors_and_institutions, auth2index, inst2index, \
        index2inst, auth2email, filestr = interpret_authors(filestr, format)
    author_block = INLINE_TAGS_SUBST[format]['author']\
        (authors_and_institutions, auth2index, inst2index,
         index2inst, auth2email)
    filestr = filestr.replace('XXXAUTHOR', author_block)
    return filestr


def inline_tag_subst(filestr, format):
    """Deal with all inline tags by substitution."""
    # Note that all tags are *substituted* so that the sequence of
    # operations are not important for the contents of the document - we
    # choose a sequence that is appropriate from a substitution point
    # of view

    filestr = typeset_authors(filestr, format)

    # deal with DATE: today (i.e., find today's date)
    m = re.search(r'^(DATE:\s*[Tt]oday)', filestr, re.MULTILINE)
    if m:
        origstr = m.group(1)
        w = time.asctime().split()
        date = w[1] + ' ' + w[2] + ', ' + w[4]
        filestr = filestr.replace(origstr, 'DATE: ' + date)

    debugpr('\n*** Inline tags substitution phase ***')

    ordered_tags = (
        'title', 'date',
        'movie',
        #'figure',  # done separately
        'abstract',  # must become before sections since it tests on ===
        # important to do section, subsection, etc. BEFORE paragraph and bold:
        'emphasize', 'math2', 'math',
        'chapter', 'section', 'subsection', 'subsubsection',
        'bold',
        'inlinecomment',
        'verbatim',
        'citation',
        'paragraph',  # after bold and emphasize
        'plainURL',   # before linkURL2 to avoid "URL" as link name
        'linkURL2v',
        'linkURL3v',
        'linkURL2',
        'linkURL3',
        'linkURL',
        )
    for tag in ordered_tags:
        debugpr('\n*************** Working with tag "%s"' % tag)
        tag_pattern = INLINE_TAGS[tag]
        #print 'working with tag "%s" = "%s"' % (tag, tag_pattern)
        if tag in ('abstract',):
            c = re.compile(tag_pattern, re.MULTILINE|re.DOTALL)
        else:
            c = re.compile(tag_pattern, re.MULTILINE)
        try:
            replacement = INLINE_TAGS_SUBST[format][tag]
        except KeyError:
            continue  # just ignore missing tags in current format
        if replacement is None:
            continue  # no substitution

        if isinstance(replacement, basestring):
            # first some info for debug output:
            findlist = c.findall(filestr)
            occurences = len(findlist)
            findlist = pprint.pformat(findlist)
            if occurences > 0:
                debugpr('Found %d occurences of "%s":\nfindall list: %s' % (occurences, tag, findlist))
                debugpr('%s is to be replaced using %s' % (tag, replacement))
                m = c.search(filestr)
                if m:
                    debugpr('First occurence: "%s"\ngroups: %s\nnamed groups: %s' % (m.group(0), m.groups(), m.groupdict()))

            filestr = c.sub(replacement, filestr)
        elif callable(replacement):
            # treat line by line because replacement string depends
            # on the match object for each occurence
            # (this is mainly for headlines in rst format)
            lines = filestr.splitlines()
            occurences = 0
            for i in range(len(lines)):
                m = re.search(tag_pattern, lines[i])
                if m:
                    try:
                        replacement_str = replacement(m)
                    except Exception, e:
                        print 'Problem at line\n   ', lines[i], \
                              '\nException:\n', e
                        print 'occured while replacing inline tag "%s" (%s) with aid of function %s' % (tag, tag_pattern, replacement.__name__)
                        #raise Exception(e)
                        # Raising exception is misleading since the
                        # error occured in the replacement function
                        sys.exit(1)
                    lines[i] = re.sub(tag_pattern, replacement_str, lines[i])
                    occurences += 1
            filestr = '\n'.join(lines)

        else:
            raise ValueError, 'replacement is of type %s' % type(replacement)
        if occurences > 0:
            debugpr('\n**** The file after %d "%s" substitutions ***\n%s\n%s\n\n' % \
                  (occurences, tag, filestr, '-'*80))
    return filestr

def subst_away_inline_comments(filestr):
    # inline comments: [hpl: this is a comment]
    pattern = r'\[(?P<name>[A-Za-z0-9_ ,.@]+?):(?P<comment>[^\]]*?)\]\s*'
    filestr = re.sub(pattern, '', filestr)
    return filestr

def subst_class_func_mod(filestr, format):
    if format == 'sphinx' or format == 'rst':
        return filestr

    # Replace :mod:`~my.pack.mod` by `my.pack.mod`
    tp = 'class', 'func', 'mod'
    for t in tp:
        filestr = re.sub(r':%s:`~?([A-Za-z0-9_.]+?)`' % t,
                         r'`\g<1>`', filestr)
    return filestr


def file2file(in_filename, format, out_filename):
    """
    Perform the transformation of a doconce file, stored in in_filename,
    to a given format (html, latex, etc.), written to out_filename.
    This is the "main" function in the module.
    """
    if in_filename.startswith('__'):
        print 'translate preprocessed doconce text in', in_filename
    else:
        print 'translate doconce text in', in_filename

    # if trouble with encoding:
    # Unix> doconce guess_encoding myfile.do.txt
    # Unix> doconce change_encoding utf-8 latin1 myfile.do.txt
    # or plain Unix:
    # Unix> file myfile.do.txt
    # myfile.do.txt: UTF-8 Unicode English text
    # Unix> # convert to latin-1:
    # Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile
    if encoding:  # global variable
        print 'Open file with encoding', encoding
        f = codecs.open(in_filename, 'r', encoding)
    else:
        f = open(in_filename, 'r')
    filestr = f.read()
    f.close()

    if in_filename.endswith('.py') or in_filename.endswith('.py.do.txt'):
        filestr = doconce2format4docstrings(filestr, format)
    else:
        filestr = doconce2format(filestr, format)

    if encoding:
        f = codecs.open(out_filename, 'w', encoding)
    else:
        f = open(out_filename, 'w')
    f.write(filestr)
    f.close()


def doconce2format4docstrings(filestr, format):
    """Run doconce2format on all doc strings in a Python file."""

    c1 = re.compile(r'^\s*(class|def)\s+[A-Za-z0-9_,() =]+:\s+(""".+?""")',
                    re.DOTALL|re.MULTILINE)
    c2 = re.compile(r"^\s*(class|def)\s+[A-Za-z0-9_,() =]+:\s+('''.+?''')",
                    re.DOTALL|re.MULTILINE)
    doc_strings = [doc_string for dummy, doc_string in c1.findall(filestr)] + \
                  [doc_string for dummy, doc_string in c2.findall(filestr)]
    lines = filestr.splitlines()
    for i, line in enumerate(lines):
        if not line.lstrip().startswith('#'):
            break
    filestr2 = '\n'.join(lines[i:])
    c3 = re.compile(r'^\s*""".+?"""', re.DOTALL) # ^ is the very start
    c4 = re.compile(r"^\s*'''.+?'''", re.DOTALL) # ^ is the very start
    doc_strings = c3.findall(filestr2) + c4.findall(filestr2) + doc_strings

    # Find and remove indentation
    all = []
    for doc_string in doc_strings:
        lines = doc_string.splitlines()
        if len(lines) > 1:
            indent = 0
            line1 = lines[1]
            while line1[indent] == ' ':
                indent += 1
            for i in range(1, len(lines)):
                lines[i] = lines[i][indent:]
            all.append(('\n'.join(lines), indent))
        else:
            all.append((doc_string, None))

    for doc_string, indent in all:
        new_doc_string = doconce2format(doc_string, format)
        if indent is not None:
            lines = new_doc_string.splitlines()
            for i in range(1, len(lines)):
                lines[i] = ' '*indent + lines[i]
            new_doc_string = '\n'.join(lines)
            lines = doc_string.splitlines()
            for i in range(1, len(lines)):
                if lines[i].isspace() or lines[i] == '':
                    pass  # don't indent blank lines
                else:
                    lines[i] = ' '*indent + lines[i]
            doc_string = '\n'.join(lines)

        filestr = filestr.replace(doc_string, new_doc_string)

    return filestr

def doconce2format(filestr, format):
    # A special case: `!bc`, `!bt`, `!ec`, and `!et` at the beginning
    # of a line gives wrong consistency checks for plaintext format,
    # so we avoid having these at the beginning of a line.
    if format == 'plain':
        for directive in 'bc', 'ec', 'bt', 'et':
            cpattern = re.compile(r'^`!%s' % directive, re.MULTILINE)
            filestr = cpattern.sub('  `!%s' % directive,
                                   filestr)  # space avoids beg.of line
    syntax_check(filestr, format)


    # -----------------------------------------------------------------

    # Step: check if ^#?TITLE: is present, and if so, header and footer
    # are to be included (later below):
    if re.search(r'^#?TITLE:', filestr, re.MULTILINE):
        has_title = True
    else:
        has_title = False

    # Next step: insert verbatim code from other (source code) files:
    # (if the format is latex, we could let ptex2tex do this, but
    # the CODE start@stop specifications may contain uderscores and
    # asterix, which will be replaced later and hence destroyed)
    #if format != 'latex':
    filestr = insert_code_from_file(filestr, format)
    debugpr('%s\n**** The file after inserting @@@CODE (from file):\n\n%s\n\n' % \
          ('*'*80, filestr))

    # hack to fix a bug with !ec/!et at the end of files, which is not
    # correctly substituted by '' in rst, sphinx, st, epytext, plain
    # (the fix is to add "enough" blank lines)
    if format in ('rst', 'sphinx', 'st', 'epytext', 'plain'):
        filestr = filestr.rstrip()
        if filestr.endswith('!ec') or filestr.endswith('!et'):
            filestr += '\n'*10

    # Next step: remove all verbatim and math blocks

    filestr, code_blocks, tex_blocks = remove_code_and_tex(filestr)

    # for html we should make replacements of < and > in code_blocks,
    # since these can be interpreted as tags, and we must
    # handle latin-1 characters
    if format == 'html':  # fix
        for i in range(len(code_blocks)):
            # This does not catch things like '<x ...<y>'
            #code_blocks[i] = re.sub(r'(<)([^>]*?)(>)',
            #                        '&lt;\g<2>&gt;', code_blocks[i])
            code_blocks[i] = code_blocks[i].replace('<', '&lt;')
            code_blocks[i] = code_blocks[i].replace('>', '&gt;')

        # This special character transformation is easier done
        # with encoding="utf-8" in the first line in the html file:
        # (but we do it explicitly to make it robust)
        filestr = html.latin2html(filestr)
    elif format == 'latex' or format == 'pdflatex':  # fix
        # labels inside tex envirs must have backslash \label:
        for i in range(len(tex_blocks)):
            tex_blocks[i] = re.sub(r'([^\\])label', r'\g<1>\\label',
                                    tex_blocks[i])

    debugpr('%s\n**** The file after removal of code/tex blocks:\n\n%s\n\n' % \
          ('*'*80, filestr))
    debugpr('%s\n**** The code blocks:\n\n%s\n\n' % \
          ('*'*80, pprint.pformat(code_blocks)))
    debugpr('%s\n**** The tex blocks:\n\n%s\n\n' % \
          ('*'*80, pprint.pformat(tex_blocks)))

    # remove linebreaks within paragraphs:
    if oneline_paragraphs:  # (does not yet work well)
        filestr = make_one_line_paragraphs(filestr, format)

    if skip_inline_comments:
        filestr = subst_away_inline_comments(filestr)

    # Next step: deal with exercises
    filestr = exercises(filestr, format)

    # Next step: deal with figures
    filestr = handle_figures(filestr, format)

    # Next step: deal with cross referencing (must occur before other format subst)
    filestr = handle_cross_referencing(filestr, format)

    debugpr('%s\n**** The file after handling ref and label cross referencing\n\n%s\n\n' % ('*'*80, filestr))

    # Next step: deal with index and bibliography (must be done before lists):
    filestr = handle_index_and_bib(filestr, format, has_title)

    debugpr('%s\n**** The file after handling index and bibliography\n\n%s\n\n' % ('*'*80, filestr))

    # Next step: deal with lists
    filestr = typeset_lists(filestr, format,
                            debug_info=[code_blocks, tex_blocks])
    debugpr('%s\n**** The file after typesetting of list:\n\n%s\n\n' % \
          ('*'*80, filestr))

    # Next step: deal with tables
    filestr = typeset_tables(filestr, format)
    debugpr('%s\n**** The file after typesetting of tables:\n\n%s\n\n' % \
          ('*'*80, filestr))

    # Next step: do substitutions:
    filestr = inline_tag_subst(filestr, format)

    debugpr('%s\n**** The file after all inline substitutions:\n\n%s\n\n' % ('*'*80, filestr))

    # Next step: substitute latex-style newcommands in filestr and tex_blocks
    # (not in code_blocks)
    from expand_newcommands import expand_newcommands
    if format != 'latex' and format != 'pdflatex' and format != 'pandoc':
        newcommand_files = ['newcommands_replace.tex']
        if format == 'sphinx':  # replace all newcommands in sphinx
            newcommand_files.extend(['newcommands.tex', 'newcommands_keep.tex'])
            # note: could use substitutions (|newcommand|) in rst/sphinx,
            # but they don't allow arguments so expansion of \newcommand
            # is probably a better solution
        filestr = expand_newcommands(newcommand_files, filestr)
        for i in range(len(tex_blocks)):
            tex_blocks[i] = expand_newcommands(newcommand_files, tex_blocks[i])

    # Next step: subst :class:`ClassName` by `ClassName` for
    # non-rst/sphinx formats:
    filestr = subst_class_func_mod(filestr, format)

    # Next step: insert verbatim and math code blocks again:
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)
    filestr += '\n'

    # Next step: substitute code and tex environments:
    filestr = CODE[format](filestr, format)
    debugpr('%s\n**** The file after inserting tex/code blocks:\n\n%s\n\n' % \
          ('*'*80, filestr))

    if has_title:
        if format in INTRO:
            filestr = INTRO[format] + filestr
        if format in OUTRO:
            filestr = filestr + OUTRO[format]

    if format == 'latex' or format == 'pdflatex':
        if r'\includemovie[' not in filestr:
            # avoid the need for movie15 package in latex file
            filestr = filestr.replace('define MOVIE', 'undef MOVIE')

    return filestr


def preprocess(filename, format, preprocessor_options=[]):
    """
    Run mako or the preprocess script on filename and return the name
    of the resulting file. The preprocessor_options list contains
    the preprocessor options given on the command line.
    In addition, the preprocessor option FORMAT (=format) is
    always defined.
    """

    f = open(filename, 'r'); filestr = f.read(); f.close()
    preprocessor = None

    # First guess if preprocess or mako is used
    preprocess_commands = r'^#\s*#(if|define|include)'
    mako_commands = r'^\s*<?%'
    if re.search(preprocess_commands, filestr, re.MULTILINE):
        #print 'run preprocess on', filename, 'to make', resultfile
        preprocessor = 'preprocess'
        # Add -D to name=value options (mako style parameters)
        preprocess_options = preprocessor_options[:]  # copy
        for i in range(len(preprocess_options)):
            if preprocess_options[i][:2] != '-U' and \
               preprocess_options[i][:2] != '-D':
                preprocess_options[i] = '-D' + preprocess_options[i]
        preprocess_options = ' '.join(preprocess_options)
        resultfile = '__tmp.do.txt'

        # Syntax check: preprocess directives without leading #?
        pattern1 = r'^#if.*'; pattern2 = r'^#else'
        pattern3 = r'^#elif'; pattern4 = r'^#endif'
        for pattern in pattern1, pattern2, pattern3, pattern4:
            cpattern = re.compile(pattern, re.MULTILINE)
            matches = cpattern.findall(filestr)
            if matches:
                print '\nSyntax error in preprocess directives: missing # '\
                      'before directive'
                print pattern
                sys.exit(1)

        try:
            import preprocess
        except ImportError:
            print """\
%s makes use of preprocess directives and therefore requires
the preprocess program to be installed (see code.google.com/p/preprocess).
On Debian systems, preprocess can be installed through the
preprocess package (sudo apt-get install preprocess).
""" % filename
            sys.exit(1)

        cmd = 'preprocess -DFORMAT=%s %s %s > %s' % \
              (format, preprocess_options, filename, resultfile)
        print 'run', cmd
        failure, outtext = commands.getstatusoutput(cmd)
        if failure:
            print 'Could not run preprocessor:\n%s' % cmd
            print outtext
            sys.exit(1)
        # Make filestr the result of preprocess in case mako shall be run
        f = open(resultfile, 'r'); filestr = f.read(); f.close()


    if re.search(mako_commands, filestr, re.MULTILINE):
        if preprocessor is not None:  # already found preprocess commands?
            # The output is in resultfile, preprocess is run on that
            filename = resultfile
        preprocessor = 'mako'
        resultfile = '__tmp.do.txt'

        try:
            import mako
        except ImportError:
            print """\
%s makes use of mako directives and therefore requires mako
to be installed (www.makotemplates.org).
On Debian systems, mako can easily be installed through the
python-mako package (sudo apt-get install python-mako).
""" % filename
            sys.exit(1)

        print 'run mako on', filename, 'to make', resultfile
        # add a space after \\ at the end of lines (otherwise mako
        # eats one of the backslashes in tex blocks)
        # same for a single \ before newline
        f = open(filename, 'r')
        filestr = f.read()
        f.close()
        filestr = filestr.replace('\\\\\n', '\\\\ \n')
        filestr = filestr.replace('\\\n', '\\ \n')
        f = open(resultfile, 'w')
        f.write(filestr)
        f.close()

        from mako.template import Template
        from mako.lookup import TemplateLookup
        lookup = TemplateLookup(directories=[os.curdir])
        temp = Template(filename=resultfile, lookup=lookup)
        f = open(resultfile, 'w')
        kwargs = {'FORMAT': format}
        for option in preprocessor_options:
            try:
                key, value = option.split('=')
            except ValueError:
                print 'command line argument "%s" not recognized' % option
                sys.exit(1)
            # Try eval(value), if it fails, assume string
            try:
                kwargs[key] = eval(value)
            except (NameError, SyntaxError):
                kwargs[key] = value
        debugpr('Keyword arguments to be sent to mako: %s' % \
                pprint.pformat(kwargs))
        try:
            f.write(temp.render(**kwargs))
        except TypeError, e:
            if "'Undefined' object is not callable" in str(e):
                calls = '\n'.join(re.findall(r'(\$\{[A-Za-z0-9_ ]+?\()[^}]+?\}', filestr))
                print '${func(...)} calls undefined function "func",\ncheck all ${...} calls in the file(s) for possible typos and lack of includes!\n%s' % calls
                sys.exit(1)
        except NameError, e:
            if "Undefined" in str(e):
                variables = '\n'.join(re.findall(r'\$\{[A-Za-z0-9_]+?\}', filestr))
                print 'One or more ${var} variables are undefined, check all!\n%s' % variables
                sys.exit(1)

        f.close()
        if preprocessor_options:
            print 'mako variables:', kwargs

    if preprocessor is None:
        # no preprocessor syntax detected
        resultfile = filename

    return resultfile

def main():
    # doconce format accepts special command-line arguments:
    #   - debug (for debugging in file _doconce_debugging.log) or
    #   - skip_inline_comments
    #   - oneline (for removal of newlines/linebreaks within paragraphs)
    #   - encoding utf-8 (e.g.)
    #   - preprocessor options (-DVAR etc. for preprocess)

    # oneline is inactive (doesn't work well yet)

    options = ['debug', 'skip_inline_comments', 'encoding=',
               'oneline_paragraphs',] # 'tmp1']

    global debug, _log, oneline_paragraphs, \
           skip_inline_comments, encoding, filename

    try:
        format = sys.argv[1]
        filename = sys.argv[2]
        del sys.argv[1:3]
    except IndexError:
        print 'Usage: %s format filename [%s] [preprocessor options]\n' \
              % (sys.argv[0], ' | '.join(options))
        if len(sys.argv) == 1:
            print 'Missing format specification!'
        print 'formats:', str(supported_format_names())[1:-1]
        print '\n-DFORMAT=format is always defined when running preprocess'
        print 'Other -Dvar preprocess options can be added'
        sys.exit(1)

    names = supported_format_names()
    if format not in names:
        print '%s is not among the supported formats:\n%s' % (format, names)
        sys.exit(1)

    debug = False
    if 'debug' in sys.argv[1:]:
        debug = True
        sys.argv.remove('debug')
    if '--debug' in sys.argv[1:]:
        debug = True
        sys.argv.remove('--debug')

    oneline_paragraphs = False
    if 'oneline_paragraphs' in sys.argv[1:]:
        oneline_paragraphs = True
        sys.argv.remove('oneline_paragraphs')
    if '--oneline_paragraphs' in sys.argv[1:]:
        oneline_paragraphs = True
        sys.argv.remove('--oneline_paragraphs')

    skip_inline_comments = False
    if 'skip_inline_comments' in sys.argv[1:]:
        skip_inline_comments = True
        sys.argv.remove('skip_inline_comments')
    if '--skip_inline_comments' in sys.argv[1:]:
        skip_inline_comments = True
        sys.argv.remove('--skip_inline_comments')

    encoding = ''
    for arg in sys.argv[1:]:
        if arg.startswith('encoding=') or arg.startswith('--encoding='):
            dummy, encoding = arg.split('=')
            break
    if encoding:
        sys.argv.remove(arg)

    if debug:
        _log_filename = '_doconce_debugging.log'
        _log = open(_log_filename,'w')
        _log.write("""
    This is a log file for the doconce script.
    Debugging is turned on by a 3rd command-line argument '--debug'
    to doconce format. Without that command-line argument,
    this file is not produced.

    """)
        print 'debug output in', _log_filename


    debugpr('\n\n>>>>>>>>>>>>>>>>> %s >>>>>>>>>>>>>>>>>\n\n' % format)

    if not os.path.isfile(filename):
        basename = filename
        filename = filename + '.do.txt'
        if not os.path.isfile(filename):
            print 'No such Doconce file: %s' % (filename[:-7])
            sys.exit(1)
    else:
        basename = filename[:-7]

    out_filename = basename + FILENAME_EXTENSION[format]
    #print '\n----- doconce format %s %s' % (format, filename)
    filename_preprocessed = preprocess(filename, format, sys.argv[1:])
    file2file(filename_preprocessed, format, out_filename)
    if filename_preprocessed.startswith('__') and not debug:
        os.remove(filename_preprocessed)  # clean up
    #print '----- successful run: %s filtered to %s\n' % (filename, out_filename)
    print 'output in', out_filename

if __name__ == '__main__':
    main()
