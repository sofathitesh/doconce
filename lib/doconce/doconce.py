#!/usr/bin/env python
import re, os, sys, shutil, commands, pprint, time, glob, codecs
try:
    from collections import OrderedDict   # v2.7 and v3.1
except ImportError:
    # use standard arbitrary-ordered dict instead (original order of
    # citations is then lost)
    OrderedDict = dict

def _abort():
    if not option('no-abort'):
        print 'Abort! (add --no-abort on the command line to avoid this abortion)'
        sys.exit(1)
    else:
        print 'avoided abortion because of --no-abort'


def debugpr(out):
    """Add the text in string `out` to the log file (name in _log variable)."""
    if option('debug'):
        global _log
        _log = open('_doconce_debugging.log','a')
        _log.write(out + '\n')
        _log.close()


from common import *
from misc import option
import html, latex, pdflatex, rst, sphinx, st, epytext, plaintext, gwiki, mwiki, cwiki, pandoc, ipynb
for module in html, latex, pdflatex, rst, sphinx, st, epytext, plaintext, gwiki, mwiki, cwiki, pandoc, ipynb:
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
                  TOC,
                  ENVIRS,
                  INTRO,
                  OUTRO)

def supported_format_names():
    return 'html', 'latex', 'pdflatex', 'rst', 'sphinx', 'st', 'epytext', 'plain', 'gwiki', 'mwiki', 'cwiki', 'pandoc', 'ipynb'

def doconce_envirs():
    return ['c', 't',                 # verbatim and tex blocks
            'ans', 'sol', 'subex',    # exercises
            'pop', 'slidecell',       # slides
            'hint', 'remarks', # exercises and general
            'quote', 'notice',
            'summary', 'warning', 'question']

#----------------------------------------------------------------------------
# Translators: (do not include, use import as shown above)
# include "common.py"
# include "html.py"
# include "latex.py"
#----------------------------------------------------------------------------

def fix(filestr, format, verbose=0):
    """Fix issues with the text (correct wrong syntax)."""
    # A special case: `!bc`, `!bt`, `!ec`, and `!et` at the beginning
    # of a line gives wrong consistency checks for plaintext format,
    # so we avoid having these at the beginning of a line.
    if format == 'plain':
        for directive in 'bc', 'ec', 'bt', 'et':
            # could test for bsol, bhint, etc. as well...
            cpattern = re.compile(r'^`!%s' % directive, re.MULTILINE)
            filestr = cpattern.sub('  `!%s' % directive,
                                   filestr)  # space avoids beg.of line

    num_fixes = 0

    # Fix figure and movie captions that span several lines (the
    # replacement via re.sub works line by line so the caption *must*
    # be on one line, but this might be forgotten by many writers...)
    pattern = r'^\s*(?P<type>FIGURE|MOVIE):\s*\[(?P<filename>[^,\]]+),?(?P<options>[^\]]*)\]\s*?(?P<caption>.*?)^\s*$'
    figs = re.findall(pattern, filestr, flags=re.MULTILINE|re.DOTALL)

    for fig in figs:
        caption = fig[3]
        if '\n' in caption.strip():   # multiline caption?
            if not '!ec' in caption:  # avoid verbatim block...
                caption1 = caption.replace('\n', ' ') + '\n'
                filestr = filestr.replace(caption, caption1)
                num_fixes += 1
                if verbose > 0:
                    print '\nFIX: multi-line caption\n\n%s\n-- fixed to one line' % caption

    # Space before commands that should begin in 1st column at a line?
    commands = 'FIGURE MOVIE TITLE AUTHOR DATE TOC BIBFILE'.split()
    commands += ['!b' + envir for envir in doconce_envirs()]
    commands += ['!e' + envir for envir in doconce_envirs()]
    for command in commands:
        pattern = r'^ +' + command
        m = re.search(pattern, filestr, flags=re.MULTILINE)
        if m:
            lines = '\n'.join(re.findall(r'^ +%s.*$' % command, filestr, flags=re.MULTILINE)) + '\n'
            filestr, n = re.subn(pattern, command, filestr, flags=re.MULTILINE)
            num_fixes += n

            if verbose > 0:
                print '\nFIX: %s not at the beginning of the line - %d fixes' % (command, n)
                print lines

    if verbose and num_fixes:
        print '\n*** The total of %d fixes above should be incorporated in the file!\n\n' % num_fixes
    return filestr



def syntax_check(filestr, format):
    """Check for common errors in the doconce syntax."""

    filestr = fix(filestr, format, verbose=1)

    begin_end_consistency_checks(filestr, doconce_envirs())

    # Check that headings have consistent use of = signs
    for line in filestr.splitlines():
        if line.strip().startswith('==='):
            w = line.split()
            if w[0] != w[-1]:
                print '\ninconsistent no of = in heading:\n', line
                print 'lengths: %d and %d, must be equal and odd' % \
                      (len(w[0]), len(w[-1]))
                _abort()

    # Check that references have parenthesis (equations) or
    # the right preceding keyword (Section, Chapter, Exercise, etc.)
    pattern = re.compile(r'\s+([A-Za-z]+?)\s+(ref\{.+\})', re.MULTILINE)
    refs = pattern.findall(filestr)
    prefixes = ['chapter', 'ch.',
                'section', 'sec.',
                'appendix', 'app.',
                'figure', 'fig.',
                'movie',
                'exercise',
                'problem',
                'project',
                'example', 'ex.',
                'and', 'or']
    for prefix, ref in refs:
        if prefix[-1] == 's':
            prefix = prefix[:-1]  # skip plural
        if not prefix.lower() in prefixes:
            print 'found reference "%s %s" with unexpected word "%s" in front' % (prefix, ref, prefix),
            print '(reference to equation, but missing parenthesis in (%s)?)' % (ref)

    # Check that are environments !bc, !ec, !bans, !eans, etc.
    # appear at the beginning of the line
    for envir in doconce_envirs():
        pattern = re.compile(r'^ +![eb]%s' % envir, re.MULTILINE)
        m = pattern.search(filestr)
        if m:
            print '\nSyntax error: !b%s and/or !e%s not at the beginning of the line' % (envir, envir)
            print repr(filestr[m.start():m.start()+120])
            _abort()

    pattern = re.compile(r'[^\n:.?!,]^(!b[ct]|@@@CODE)', re.MULTILINE)
    m = pattern.search(filestr)
    if m:
        print '\nSyntax error: Line before !bc/!bt/@@@CODE block\nends with wrong character (must be among [\\n:.?!, ]):'
        print repr(filestr[m.start():m.start()+80])
        _abort()

    # Code blocks cannot come directly after tables or headings.
    # Remove idx{} and label{} before checking
    # since these will be moved for rst.
    # Also remove all comments since these are also "invisible".
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
            print filestr2[m.start()-40:m.start()+80]
            _abort()

    # Code/tex blocks cannot have a comment, table, figure, etc.
    # right before them
    constructions = {'comment': r'^\s*#.*?$',
                     'table': r'-\|\s*$',
                     'figure': r'^\s*FIGURE:.+$',
                     'movie': r'^\s*MOVIE:.+$',
                     }
    for construction in constructions:
        pattern = re.compile(r'%s\s*^(!b[ct]\s*$|@@@CODE| +\* +| +o +)' % \
                             constructions[construction],
                             re.MULTILINE)
        m = pattern.search(filestr)
        if m and format in ('rst', 'sphinx'):
            print '\nSyntax error: Line before list, !bc, !bt or @@@CODE block is a %s line\nwhich will "swallow" the block in reST format.\nInsert some extra line (text) to separate the two elements.' % construction
            print filestr[m.start():m.start()+80]
            _abort()

    matches = re.findall(r'\\cite\{.+?\}', filestr)
    if matches:
        print '\n*** warning: found \\cite{...} (cite{...} has no backslash)'
        print '\n'.join(matches)

    matches = re.findall(r'\\idx\{.+?\}', filestr)
    if matches:
        print '\n*** warning: found \\idx{...} (indx{...} has no backslash)'
        print '\n'.join(matches)
        _abort()

    matches = re.findall(r'\\index\{.+?\}', filestr)
    if matches:
        print '\n*** warning: found \\index{...} (index is written idx{...})'
        print '\n'.join(matches)

    # There should only be ref and label *without* the latex-ish backslash
    matches = re.findall(r'\\label\{.+?\}', filestr)
    if matches:
        print '\n*** warning: found \\label{...} (label{...} has no backslash)'
        print '\n'.join(matches)

    matches = re.findall(r'\\ref\{.+?\}', filestr)
    if matches:
        print '\n*** warning: found \\ref{...} (ref{...} has no backslash)'
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
                print '''\n*** warning: Double back-quotes `` found in file - should be "?'''
                print 'Line:', line
        if not inside_math:
            if "''" in line:
                #print '''\n*** warning: Double forward-quotes '' found in file - should be "\n(unless derivatives in math)'''
                pass

    commands = [
        r'\[',
        r'\]',
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
        'balns',
        'ealns',
        'beq',
        'eeq',  # the simplest, contained in others, must come last...
        ]
    lines = filestr.splitlines()
    inside_bt = False
    inside_bt_i = 0
    inside_bc = False
    for i in range(len(lines)):
        if lines[i].startswith('!bt'):
            inside_bt = True
            inside_bt_i = i
        if lines[i].startswith('!et'):
            inside_bt = False
            inside_bt_i = 0
        if lines[i].startswith('!bc'):
            inside_bc = True
        if lines[i].startswith('!ec'):
            inside_bc = False
        for command in commands:
            if '\\' + command in lines[i] and not inside_bt:
                if '`' not in lines[i] and not inside_bc:  # not verbatim
                    print '\nError: math equation with \n%s\nis not inside !bt - !et environment' % command
                    print '\n'.join(lines[i-3:i+3])
                    _abort()

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
                    print '\n*** warning:'
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
        _abort()

    pattern = re.compile(r'^__.+?[^.:?]__', re.MULTILINE)
    matches = pattern.findall(filestr)
    if matches:
        print '*** warning: missing ., : or ? after paragraph heading:'
        print '\n'.join(matches)

    pattern = r'idx\{[^}]*?\\_[^}]*?\}'
    matches = re.findall(pattern, filestr)
    if matches:
        print '*** warning: Backslash before underscore(s) in idx (remove backslash)'
        print matches

    # Figure without comma between filename and options? Or initial spaces?
    pattern = r'^FIGURE:\s*\[[^,\]]+ +[^\]]*\]'
    cpattern = re.compile(pattern, re.MULTILINE)
    matches = cpattern.findall(filestr)
    if matches:
        print '\nSyntax error in FIGURE specification'\
              '\nmissing comma after filename, before options'
        print '\n'.join(matches)
        _abort()

    # Movie without comma between filename and options? Or initial spaces?
    pattern = r'^MOVIE:\s*\[[^,\]]+ +[^\]]*\]'
    cpattern = re.compile(pattern, re.MULTILINE)
    matches = cpattern.findall(filestr)
    if matches:
        print '\nSyntax error in MOVIE specification'\
              '\nmissing comma after filename, before options'
        print '\n'.join(matches)
        _abort()

    # Keywords at the beginning of the lines:
    keywords = 'AUTHOR', 'TITLE', 'DATE', 'FIGURE', 'BIBFILE', 'MOVIE', 'TOC',
    for kw in keywords:
        pattern = '^ +' + kw
        cpattern = re.compile(pattern, re.MULTILINE)
        matches = cpattern.findall(filestr)
        if matches:
            print '\nSyntax error in %s specification:'\
                  '%s must appear at the beginning of the line!' % (kw,kw)
            print '\n'.join(matches)
            _abort()

    # Keywords without colon:
    for kw in keywords:
        pattern = '^' + kw + ' +'
        cpattern = re.compile(pattern, re.MULTILINE)
        matches = cpattern.findall(filestr)
        if matches:
            print '\nSyntax error in %s: specification'\
                  '\nmissing colon after keyword' % kw
            print '\n'.join(matches)
            _abort()

    if format in ('latex', 'pdflatex'):
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
                    print 'AUTHOR is missing '
                _abort()

    if format == "sphinx":
        # Check that local URLs are in _static directory
        links = []
        for link_tp in 'linkURL2', 'linkURL3', 'linkURL2v', 'linkURL3v', \
                'plainURL':
            links.extend(re.findall(INLINE_TAGS[link_tp], filestr))
        import sets
        links = list(sets.Set([link[1] for link in links]))
        links2local = []
        for link in links:
            if not (link.startswith('http') or link.startswith('file:/') or \
                    link.startswith('_static')):
                links2local.append(link)
        for link in links2local:
            print '*** warning: hyperlink to URL %s is to a local file,\n  - should be _static/%s for sphinx.' % (link, link)
        if links2local:
            print 'Move files to _static and change URLs!'
            #_abort()  # no abort since some documentation has local URLs for illustration

    return filestr  # fixes may have been performed

def make_one_line_paragraphs(filestr, format):
    # THIS FUNCTION DOES NOT WORK WELL - it's difficult to make
    # one-line paragraphs...
    print 'make_one_line_paragraphs: this function does not work well'
    print 'drop --oneline_paragraphs option on the command line...'
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
    CREATE_DUMMY_FILE = False # create dummy file if specified file not found?
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
                if CREATE_DUMMY_FILE and 'No such file or directory' in str(e):
                    print '    No such file or directory!'
                    print '    A dummy file %s is generated...' % filename
                    dummyfile = open(filename, 'w')
                    dummyfile.write(
                        'File %s missing - made this dummy file...\n'
                        % filename)
                    dummyfile.close()
                    codefile = open(filename, 'r')
                else:
                    print e
                    _abort()

            # Determine code environment from filename extension
            filetype = os.path.splitext(filename)[1][1:]  # drop dot
            if filetype == 'cxx' or filetype == 'C' or filetype == 'h' \
                   or filetype == 'i':
                filetype = 'cpp'
            elif filetype in ('f90', 'f95'):
                filetype = 'f'
            elif filetype == 'pyx':  # Cython code is called cy
                filetype = 'cy'
            elif filetype == 'ufl':  # UFL applies Python
                filetype = 'py'
            elif filetype in ('csh', 'ksh', 'zsh', 'tcsh'):
                filetype = 'sh'
            if filetype in ('py', 'f', 'c', 'cpp', 'sh',
                            'm', 'pl', 'cy', 'rst', 'pyopt'):
                code_envir = filetype
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

                print 'copying %s regex "%s" until "%s"\n     file: %s,' % \
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
                    _abort()
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


def exercises(filestr, format, code_blocks, tex_blocks):
    # Exercise:
    # ===== Exercise: title ===== (starts with at least 3 =, max 5)
    # label{some:label} file=thisfile.py solution=somefile.do.txt
    # __Hint 1.__ some paragraph...,
    # __Hint 2.__ ...

    debugpr('\n\n***** Data structure from interpreting exercises *****\n')

    all_exer = []   # collection of all exercises
    exer = {}       # data for one exercise, to be appended to all_exer
    inside_exer = False
    exer_end = False
    exer_counter = dict(Exercise=0, Problem=0, Project=0, Example=0)

    if option('examples-as-exercises'):
        exer_heading_pattern = re.compile(r'^\s*(=====)\s*\{?(Exercise|Problem|Project|Example)\}?:\s*(?P<title>[^ =-].+?)\s*=====')
    else:
        exer_heading_pattern = re.compile(r'^\s*(=====)\s*\{?(Exercise|Problem|Project)\}?:\s*(?P<title>[^ =-].+?)\s*=====')

    label_pattern = re.compile(r'^\s*label\{(.+?)\}')
    # We accept file and solution to be comment lines
    #file_pattern = re.compile(r'^#?\s*file\s*=\s*([^\s]+)')
    file_pattern = re.compile(r'^#?\s*files?\s*=\s*([A-Za-z0-9\-._, ]+)')
    solution_pattern = re.compile(r'^#?\s*solutions?\s*=\s*([A-Za-z0-9\-._, ]+)')
    keywords_pattern = re.compile(r'^#?\s*(keywords|kw)\s*=\s*([A-Za-z0-9\-._;, ]+)')

    hint_pattern_begin = '!bhint'
    hint_pattern_end = '!ehint'
    answer_pattern_begin = '!bans'
    answer_pattern_end = '!eans'
    solution_pattern_begin = '!bsol'
    solution_pattern_end = '!esol'
    subex_pattern_begin = '!bsubex'
    subex_pattern_end = '!esubex'
    closing_remarks_pattern_begin = '!bremarks'
    closing_remarks_pattern_end = '!eremarks'

    lines = filestr.splitlines()
    newlines = []  # lines in resulting file
    # m_* variables: various match objects from regex searches

    for line_no in range(len(lines)):
        line = lines[line_no].lstrip()
        #print 'LINE %d:' % i, line #[[[
        #import pprint; pprint.pprint(exer) #[[[

        m_heading = exer_heading_pattern.search(line)
        if m_heading:
            inside_exer = True

            exer = {}  # data in the exercise
            exer['title'] = m_heading.group('title')
            exer['heading'] = m_heading.group(1)   # heading type

            exer_tp = m_heading.group(2)           # exercise type
            if '{' + exer_tp + '}' in line:
                exer['type_visible'] = False
            else:
                exer['type_visible'] = True
            exer['type'] = exer_tp
            exer_counter[exer_tp] += 1
            exer['no'] = exer_counter[exer_tp]

            exer['label'] = None
            exer['solution_file'] = None
            exer['file'] = None
            exer['keywords'] = None
            exer.update(dict(text=[], hints=[], answer=[],
                             solution=[], subex=[], closing_remarks=[]))

            exer_end = False

            inside_hint = False
            inside_subex = False
            inside_answer = False
            inside_solution = False
            inside_closing_remarks = False
        elif inside_exer:
            instruction_line = True

            m_label = label_pattern.search(line)
            m_file = file_pattern.search(line)
            m_solution_file = solution_pattern.search(line)
            m_keywords = keywords_pattern.search(line)

            if m_label:
                if exer['label'] is None:
                    exer['label'] = m_label.group(1)
            elif m_keywords:
                exer['keywords'] = [name.strip() for name in
                                    m_keywords.group(2).split(';')]
            elif m_file and not inside_subex:
                if exer['file'] is None:  # only the first counts
                    exer['file'] = [name.strip() for name in
                                    m_file.group(1).split(',')]
            elif m_file and inside_subex:
                subex['file'] = [name.strip() for name in
                                 m_file.group(1).split(',')]
            elif m_solution_file:
                exer['solution_file'] = [name.strip() for name in
                                         m_solution_file.group(1).split(',')]

            elif line.startswith(subex_pattern_begin):
                inside_subex = True
                subex = dict(text=[], hints=[], answer=[],
                             solution=[], file=None)
            elif line.startswith(subex_pattern_end):
                inside_subex = False
                subex['text'] = '\n'.join(subex['text']).strip()
                subex['answer'] = '\n'.join(subex['answer']).strip()
                subex['solution'] = '\n'.join(subex['solution']).strip()
                for _i in range(len(subex['hints'])):
                    subex['hints'][_i] = '\n'.join(subex['hints'][_i]).strip()

                exer['subex'].append(subex)

            elif line.startswith(answer_pattern_begin):
                inside_answer = True
            elif line.startswith(answer_pattern_end):
                inside_answer = False

            elif line.startswith(solution_pattern_begin):
                inside_solution = True
            elif line.startswith(solution_pattern_end):
                inside_solution = False

            elif line.startswith(hint_pattern_begin):
                inside_hint = True
                if inside_subex:
                    subex['hints'].append([])
                else:
                    exer['hints'].append([])
            elif line.startswith(hint_pattern_end):
                inside_hint = False

            elif line.startswith(closing_remarks_pattern_begin):
                inside_closing_remarks = True
            elif line.startswith(closing_remarks_pattern_end):
                inside_closing_remarks = False

            else:
                instruction_line = False

            # [[[
            # How to do multiple choice in exer or subex:
            # !bmchoices, !emchoices (bchoices does not work since it starts with bc!)
            # inside_mchoices: store all that text in subex/exer['multiple_choice']
            # afterwards: interpret the text in multiple_choices
            # syntax: Cf/Cr: ..., required E: ... for explanation (can be empty)
            # Cf is a false choice, Cr is a right choice (or False:/True:)
            # Easy to use a regex to pick out the structure of the multiple
            # choice text (False|True):(.+?)(E|Explanation|$): (with $ explanations are optional - NO!!)
            # Better: do a split on True: and then a split on False,
            # for each True/False, extract E: if it exists (split?)
            # (E|Explanation):(.+?)($|False|True)
            # HTML can generate JavaScript a la INF1100 quiz (put all
            # js in the html file), latex can use fancy constructions,
            # others can use a plain list. --with-sol determines if
            # the solution is published (as for the answer/solution).
            if inside_subex and not instruction_line:
                if inside_answer:
                    subex['answer'].append(lines[line_no])
                elif inside_solution:
                    subex['solution'].append(lines[line_no])
                elif inside_hint:
                    subex['hints'][-1].append(lines[line_no])
                else:
                    # ordinary text line
                    subex['text'].append(lines[line_no])
            elif not inside_subex and not instruction_line:
                if inside_answer:
                    exer['answer'].append(lines[line_no])
                elif inside_solution:
                    exer['solution'].append(lines[line_no])
                elif inside_hint:
                    exer['hints'][-1].append(lines[line_no])
                elif inside_closing_remarks:
                    exer['closing_remarks'].append(lines[line_no])
                else:
                    # ordinary text line
                    exer['text'].append(lines[line_no])

        else:  # outside exercise
            newlines.append(lines[line_no])

        # End of exercise? Either 1) new (sub)section with at least ===,
        # 2) !split, or 3) end of file
        if line_no == len(lines) - 1:  # last line?
            exer_end = True
        elif inside_exer and lines[line_no+1].startswith('!split'):
            exer_end = True
        elif inside_exer and lines[line_no+1].startswith('==='):
            exer_end = True

        if exer and exer_end:
            exer['text'] = '\n'.join(exer['text']).strip()
            exer['answer'] = '\n'.join(exer['answer']).strip()
            exer['solution'] = '\n'.join(exer['solution']).strip()
            exer['closing_remarks'] = '\n'.join(exer['closing_remarks']).strip()
            for i_ in range(len(exer['hints'])):
                exer['hints'][i_] = '\n'.join(exer['hints'][i_]).strip()

            debugpr(pprint.pformat(exer))
            formatted_exercise = EXERCISE[format](exer)
            newlines.append(formatted_exercise)
            all_exer.append(exer)
            inside_exer = False
            exer_end = False
            exer = {}

    filestr = '\n'.join(newlines)
    if all_exer:
        # Replace code and math blocks by actual code.
        # This must be done in the all_exer data structure,
        # if a pprint.pformat'ed string is used, quotes in
        # computer code and derivatives lead to errors
        # if we take an eval on the output.

        from common import _CODE_BLOCK, _MATH_BLOCK

        def replace_code_math(text):
            if not isinstance(text, basestring):
                return text

            pattern = r"(\d+) %s( +)([a-z]+)" % _CODE_BLOCK
            code = re.findall(pattern, text, flags=re.MULTILINE)
            for n, space, tp in code:
                block = code_blocks[int(n)]
                from_ = '%s %s%s%s' % (n, _CODE_BLOCK, space, tp)
                to_ = '!bc %s\n' % (tp) + block + '\n!ec'
                text = text.replace(from_, to_)
            # Remaining blocks without type
            pattern = r"(\d+) %s" % _CODE_BLOCK
            code = re.findall(pattern, text, flags=re.MULTILINE)
            for n in code:
                block = code_blocks[int(n)]
                from_ = '%s %s' % (n, _CODE_BLOCK)
                to_ = '!bc\n' + block + '\n!ec'
                text = text.replace(from_, to_)
            pattern = r"(\d+) %s" % _MATH_BLOCK
            math = re.findall(pattern, text, flags=re.MULTILINE)
            for n in math:
                block = tex_blocks[int(n)]
                from_ = '%s %s' % (n, _MATH_BLOCK)
                to_ = '!bt\n' + block + '\n!et'
                text = text.replace(from_, to_)
            return text

        for e in range(len(all_exer)):
            for key in all_exer[e]:
                if key == 'subex':
                    for es in range(len(all_exer[e][key])):
                       for keys in all_exer[e][key][es]:
                           all_exer[e][key][es][keys] = \
                               replace_code_math(all_exer[e][key][es][keys])
                else:
                     all_exer[e][key] = \
                               replace_code_math(all_exer[e][key])

        all_exer_str = pprint.pformat(all_exer)

        # (recall that we write to pprint-formatted string!)

        # Dump this data structure to file
        exer_filename = filename.replace('.do.txt', '')
        exer_filename = '.%s.exerinfo' % exer_filename
        f = open(exer_filename, 'w')
        f.write("""
# Information about all exercises in the file %s.
# The information can be loaded into a Python list of dicts by
#
# f = open('%s', 'r')
# exer = eval(f.read())
#
""" % (filename, exer_filename))
        f.write(all_exer_str)
        f.close()
        print 'found info about %d exercises, written to %s' % \
              (len(all_exer), exer_filename)
        debugpr('\n%s\n**** The file after interpreting exercises ***\n\n%s\n%s\n\n\n' % ('-'*80, filestr, '-'*80))
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

    horizontal_rule_pattern = r'^\|[\-lrc]+\|'
    lines = filestr.splitlines()
    # Fix: add blank line if document ends with a table (otherwise we
    # cannot see the end of the table)
    if re.search(horizontal_rule_pattern, lines[-1]):
        lines.append('\n')

    for line in lines:
        lin = line.strip()
        # horisontal table rule?
        if re.search(horizontal_rule_pattern, lin):
            horizontal_rule = True
        else:
            horizontal_rule = False
        if horizontal_rule:
            table['rows'].append(['horizontal rule'])

            # See if there is c-l-r alignments:
            align = lin[1:-1].replace('-', '') # keep | in align spec.
            if align:
                # Non-empty string contains lrc letters for alignment
                # (can be alignmend of heading or of columns)
                if align == '|'*len(align):  # Just '|||'?
                    print 'Syntax error: horizontal rule in table '\
                          'contains | between columns - remove these.'
                    print line
                    _abort()
                for char in align:
                    if char not in ('|', 'r', 'l', 'c'):
                        print 'illegal alignment character in table:', char
                        _abort()
                if len(table['rows']) == 0:
                    # first horizontal rule, align spec concern headings
                    table['headings_align'] = align
                else:
                    # align spec concerns column alignment
                    table['columns_align'] = align
            continue  # continue with next line
        if lin.startswith('|') and not horizontal_rule:
            # row in table:
            if not inside_table:
                inside_table = True
            columns = line.strip().split('|')  # does not work with math2 syntax
            # Possible fix so that | $\bar T$|$T$ | $...$ | ... is possible:
            # .split(' | '), but need to make sure the syntax and no of columns
            # are correct

            # remove empty columns and extra white space:
            #columns = [c.strip() for c in columns if c]
            columns = [c.strip() for c in columns if c.strip()]
            # substitute math (may expand columns significantly)
            for tag in ['math', 'verbatim']:  #, 'math2']:
                replacement = INLINE_TAGS_SUBST[format][tag]
                if replacement is not None:
                    for i in range(len(columns)):
                        columns[i] = re.sub(INLINE_TAGS[tag],
                                            replacement,
                                            columns[i])
            table['rows'].append(columns)
        elif lin.startswith('#') and inside_table:
            continue  # just skip commented table lines
        else:
            if inside_table:
                # not a table line anymore, but we were just inside a table
                # so the table is ended
                inside_table = False
                #import pprint; pprint.pprint(table)
                result.write(TABLE[format](table))   # typeset table
                table = {'rows': []}  # init new table
            else:
                result.write(line + '\n')
    return result.getvalue()

def typeset_envirs(filestr, format):
    # Note: exercises are done (and translated to doconce syntax)
    # before this function is called
    envirs = doconce_envirs()[7:]

    for envir in envirs:
        if format in ENVIRS and envir in ENVIRS[format]:
            def subst(m):  # m: match object from re.sub, group(1) is the text
                return ENVIRS[format][envir](m.group(1), format)
        else:
            # subst functions for default handling
            if envir == 'quote':
                def subst(m):
                    return indent_lines(m.group(1), format, ' '*4) + '\n'
            elif envir in ['warning', 'question', 'hint', 'notice', 'summary',
                           'remarks']:
                # Just a plan paragraph with paragraph heading
                def subst(m):
                    return '\n\n__%s.__\n%s\n\n' % \
                           (envir[0].upper() + envir[1:], m.group(1))

        pattern = r'^!b%s\s*(.+?)\s*^!e%s\s*' % (envir, envir)
        filestr = re.sub(pattern, subst, filestr,
                         flags=re.DOTALL | re.MULTILINE)
    return filestr


def check_URLs(filestr, format):
    """Check if URLs exist and work."""
    # Could use webchecker probably, or just urllib.urlopen
    # on all links of types below, extract with re.findall
    pass #[[[
"""
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
"""

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

    for i, line in enumerate(lines):
        debugpr('\n------------------------\nsource line=[%s]' % line)
        # do a syntax check:
        for tag in INLINE_TAGS_BUGS:
            bug = INLINE_TAGS_BUGS[tag]
            if bug:
                m = re.search(bug[0], line)
                if m:
                    print '>>> syntax error: "%s"\n    %s' % \
                          (m.group(0), bug[1])
                    print '    in line\n[%s]' % line
                    print '    surrounding text is\n'
                    for l in lines[i-4:i+5]:
                        print l

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
        newline = '' if lists and format in ('gwiki', 'cwiki') else '\n'
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
        if figfile.startswith('http'):
            # latex, pdflatex must download the file, not yet implemented
            # html, sphinx and web-based formats can use the URL
            continue
        file_found = False
        if not os.path.isfile(figfile):
            basepath, ext = os.path.splitext(figfile)
            # Avoid ext = '.05' etc from numbers in the filename
            if not ext.lower() in ['.eps', '.pdf', '.png', '.jpg', 'jpeg',
                                   '.gif', '.tif', '.tiff']:
                ext = ''
            if not ext:  # no extension?
                # try to see if figfile + ext exists:
                for ext in extensions:
                    newname = figfile + ext
                    if os.path.isfile(newname):
                        print 'figure file %s:\n    can use %s for format %s' % \
                              (figfile, newname, format)
                        filestr = re.sub(r'%s([,\]])' % figfile,
                                         '%s\g<1>' % newname, filestr)
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
            _abort()
        basepath, ext = os.path.splitext(figfile)
        if not ext in extensions:
            # convert to proper format
            for e in extensions:
                converted_file = basepath + e
                if not os.path.isfile(converted_file):
                    # ext might be empty, in that case we cannot convert
                    # anything:
                    if ext:
                        print 'figure', figfile, 'must have extension(s)', \
                              extensions
                        # use ps2pdf and pdf2ps for vector graphics
                        # and only convert if to/from png/jpg/gif
                        if ext.endswith('ps') and e == '.pdf':
                            #cmd = 'epstopdf %s %s' % \
                            #      (figfile, converted_file)
                            cmd = 'ps2pdf -dEPSCrop %s %s' % \
                                  (figfile, converted_file)
                        elif ext == '.pdf' and ext.endswith('ps'):
                            cmd = 'pdf2ps %s %s' % \
                                  (figfile, converted_file)
                        else:
                            cmd = 'convert %s %s' % (figfile, converted_file)
                            if e in ('.ps', '.eps', '.pdf') and \
                               ext in ('.png', '.jpg', '.jpeg', '.gif'):
                                print """\
*** warning: need to convert from %s to %s
using ImageMagick's convert program, but the result will
be loss of quality. Generate a proper %s file.""" % \
                                (figfile, converted_file, converted_file)
                        failure = os.system(cmd)
                        if not failure:
                            print '....image conversion:', cmd
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
    section_pattern = r'^\s*(_{3,9}|={3,9})(.+?)(_{3,9}|={3,9})\s*label\{(.+?)\}'
    m = re.findall(section_pattern, filestr, flags=re.MULTILINE)
    #pprint.pprint(m)
    # Make sure sections appear in the right order
    # (in case rst.ref_and_label_commoncode has to assign numbers
    # to section titles that are identical)
    section_label2title = OrderedDict()
    for dummy1, title, dummy2, label in m:
        section_label2title[label] = title.strip()
        if 'ref{' in title and format in ('rst', 'sphinx', 'html'):
            print '*** warning: reference in title\n  %s\nwill come out wrong in format %s' % (title, format)
    #pprint.pprint(section_label2title)


    # 2. Make table of contents
    # TOC: on|off
    #section_pattern = r'^\s*(_{3,9}|={3,9})(.+?)(_{3,9}|={3,9})'
    section_pattern = r'^\s*(_{3,9}|={3,9})(.+?)(_{3,9}|={3,9})(\s*label\{(.+?)\})?'
    m = re.findall(section_pattern, filestr, flags=re.MULTILINE)
    sections = []
    heading2section_type = {9: 0, 7: 1, 5: 2, 3: 3}
    for heading, title, dummy2, dummy3, label in m:
        if label == '':
            label = None
        sections.append((title, heading2section_type[len(heading)], label))
    #print 'sections:'
    #import pprint; pprint.pprint(sections)

    pattern = re.compile(r'^TOC:\s*(on|off).*$', re.MULTILINE)
    m = pattern.search(filestr)
    if m:
        value = m.group(1)
        if value == 'on':
            toc = TOC[format](sections)
            toc_fixed = toc.replace('\\', '\\\\') # re.sub swallows backslashes
            filestr = pattern.sub('\n%s\n\n' % toc_fixed, filestr)
        else:
            filestr = pattern.sub('', filestr)

    # 3. Handle references that can be internal or external
    #    ref[internal][cite][external-HTML]
    internal_labels = re.findall(r'label\{(.+?)\}', filestr)
    ref_pattern = r'ref\[([^\]]*?)\]\[([^\]]*?)\]\[([^\]]*?)\]'
    general_refs = re.findall(ref_pattern, filestr)
    for internal, cite, external in general_refs:
        ref_text = 'ref[%s][%s][%s]' % (internal, cite, external)
        if not internal and not external:
            print ref_text, 'has empty fields'
            _abort()
        ref2labels = re.findall(r'ref\{(.+?)\}', internal)
        refs_to_this_doc = [label for label in ref2labels
                            if label in internal_labels]
        if len(refs_to_this_doc) == len(ref2labels):
            # All refs to labels in this doc
            filestr = filestr.replace(ref_text, internal)
        elif format in ('latex', 'pdflatex'):
            replacement = internal
            if cite:
                replacement += ' ' + cite
            filestr = filestr.replace(ref_text, replacement)
        else:
            filestr = filestr.replace(ref_text, external)

    # 4. Perform format-specific editing of ref{...} and label{...}
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
                    _abort()
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
        print '*** warning: citations may appear in random order unless you upgrade to Python version 2.7 or 3.1'
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
                _abort()
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
        print '*** warning: multiple authors\n - correct order of authors requires Python version 2.7 or 3.1 (or higher)'
    return authors_and_institutions, auth2index, inst2index, index2inst, auth2email, filestr

def typeset_authors(filestr, format):
    authors_and_institutions, auth2index, inst2index, \
        index2inst, auth2email, filestr = interpret_authors(filestr, format)
    author_block = INLINE_TAGS_SUBST[format]['author']\
        (authors_and_institutions, auth2index, inst2index,
         index2inst, auth2email).rstrip() + '\n'  # ensure one newline
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
        'title',
        'date',
        'movie',
        #'figure',  # done separately
        'abstract',  # must become before sections since it tests on ===
        # important to do section, subsection, etc. BEFORE paragraph and bold:
        'emphasize', 'math2', 'math',  # must come after sections
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
        if tag in ('abstract', ):
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
                        _abort()
                    lines[i] = re.sub(tag_pattern, replacement_str, lines[i])
                    occurences += 1
            filestr = '\n'.join(lines)

        else:
            raise ValueError, 'replacement is of type %s' % type(replacement)
        if occurences > 0:
            debugpr('\n**** The file after %d "%s" substitutions ***\n%s\n%s\n\n' % (occurences, tag, filestr, '-'*80))
    return filestr

def subst_away_inline_comments(filestr):
    # inline comments: [hpl: this is a comment]
    pattern = r'\[(?P<name>[A-Za-z0-9_ ,.@]+?): +(?P<comment>[^\]]*?)\]\s*'
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
        print 'translating preprocessed doconce text in', in_filename, \
              'to', format
    else:
        print 'translating doconce text in', in_filename, 'to', format

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

    try:
        f.write(filestr)
    except UnicodeEncodeError, e:
        m = str(e)
        if "codec can't encode character" in m:
            pos = int(m.split('position')[1].split(':')[0])
            print 'pos', pos
            print 'Problem with character when writing to file:', filestr[pos]
            print filestr[pos-40:pos], '|', filestr[pos], '|', filestr[pos+1:pos+40]
            print 'Fix character or try --encoding=utf-8 or --encoding=iso-8859-15'
            _abort()
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
    filestr = syntax_check(filestr, format)


    # -----------------------------------------------------------------

    # Step: check if ^?TITLE: is present, and if so, header and footer
    # are to be included (later below):
    if re.search(r'^TITLE:', filestr, re.MULTILINE):
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

    # Hack to fix a bug with !ec/!et at the end of files, which is not
    # correctly substituted by '' in rst, sphinx, st, epytext, plain, wikis
    # (the fix is to add "enough" blank lines - the reason can be
    # an effective strip of filestr, e.g., through '\n'.join(lines))
    if format in ('rst', 'sphinx', 'st', 'epytext', 'plain',
                  'mwiki', 'cwiki', 'gwiki'):
        filestr = filestr.rstrip()
        if filestr.endswith('!ec') or filestr.endswith('!et'):
            filestr += '\n'*10

    # Sphinx hack for transforming align envirs to separate equations
    if format in ("sphinx", "pandoc", "ipynb"):
        filestr = align2equations(filestr)
        debugpr('%s\n**** The file after {align} envirs are rewritten as separate equations:\n\n%s\n\n' % \
          ('*'*80, filestr))

    # Next step: remove all verbatim and math blocks

    filestr, code_blocks, code_block_types, tex_blocks = \
             remove_code_and_tex(filestr)

    debugpr('%s\n**** The file after removal of code/tex blocks:\n\n%s\n\n' % \
          ('*'*80, filestr))
    debugpr('%s\n**** The code blocks:\n\n%s\n\n' % \
          ('*'*80, pprint.pformat(code_blocks)))
    debugpr('%s\n**** The code block types:\n\n%s\n\n' % \
          ('*'*80, pprint.pformat(code_block_types)))
    debugpr('%s\n**** The tex blocks:\n\n%s\n\n' % \
          ('*'*80, pprint.pformat(tex_blocks)))

    # Remove linebreaks within paragraphs
    if option('oneline_paragraphs'):  # (does not yet work well)
        filestr = make_one_line_paragraphs(filestr, format)

    # Remove inline comments
    if option('skip_inline_comments'):
        filestr = subst_away_inline_comments(filestr)

    # Fix stand-alone http(s) URLs (after verbatim blocks are removed,
    # but before figure handling and inline_tag_subst)
    pattern = r' (https?://.+?)([ ,?:;!)\n])'
    filestr = re.sub(pattern, ' URL: "\g<1>"\g<2>', filestr)

    # Next step: deal with exercises
    filestr = exercises(filestr, format, code_blocks, tex_blocks)

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

    # Next step: deal with !b... !e... environments
    filestr = typeset_envirs(filestr, format)

    # Next step: extract all URLs for checking
    check_URLs(filestr, format)

    # Next step: do substitutions:
    filestr = inline_tag_subst(filestr, format)

    debugpr('%s\n**** The file after all inline substitutions:\n\n%s\n\n' % ('*'*80, filestr))

    # Next step: deal with various commands and envirs to be put as comments
    commands = ['!split', '!bpop', '!epop', '!bslidecell', '!eslidecell',
                '!bnotes', '!enotes',]
    for command in commands:
        comment_action = INLINE_TAGS_SUBST[format].get('comment', '# %s')
        if isinstance(comment_action, str):
            split_comment = comment_action % (command + r'\g<1>')
        elif callable(comment_action):
            split_comment = comment_action((command + r'\g<1>'))
        cpattern = re.compile('^%s( *| +.*)$' % command, re.MULTILINE)
        filestr = cpattern.sub(split_comment, filestr)

    # Next step: substitute latex-style newcommands in filestr and tex_blocks
    # (not in code_blocks)
    from expand_newcommands import expand_newcommands
    if format not in ('latex', 'pdflatex'):  # replace for 'pandoc', 'html'
        newcommand_files = glob.glob('newcommands*_replace.tex')
        if format == 'sphinx':  # replace all newcommands in sphinx
            newcommand_files = [name for name in glob.glob('newcommands*.tex')
                                if not name.endswith('.p.tex')]
            # note: could use substitutions (|newcommand|) in rst/sphinx,
            # but they don't allow arguments so expansion of \newcommand
            # is probably a better solution
        filestr = expand_newcommands(newcommand_files, filestr)
        for i in range(len(tex_blocks)):
            tex_blocks[i] = expand_newcommands(newcommand_files, tex_blocks[i])

    # Next step: subst :class:`ClassName` by `ClassName` for
    # non-rst/sphinx formats:
    filestr = subst_class_func_mod(filestr, format)

    # Next step: add header and footer
    if has_title:
        if format in INTRO:
            filestr = INTRO[format] + filestr
        if format in OUTRO:
            filestr = filestr + OUTRO[format]

    # Next step: check if there are unprocessed environments and give
    # warning (must be checked before next step since !bwarning etc
    # may appear inside code blocks)
    for envir in doconce_envirs():
        pattern = r'^(![be]%s)\s' % envir
        m = re.search(pattern, filestr, flags=re.MULTILINE)
        if m:
            print '*** error: found environment\n%s' % m.group(1)
            print """
Causes:
 * %s inside code block (replace ! by |)'
 * forgotten --examples-as-exercises (if the environment is inside an example)
 * wrong match of %s and the corresponding begin/end clause
""" % (m.group(1), m.group(1))
            print 'Here is the context:\n----------------------------------'
            print filestr[m.start()-50:m.end()+50]
            print '----------------------------------'
            _abort()

    # Next step: insert verbatim and math code blocks again and
    # substitute code and tex environments:
    # (this is the place to do package-specific fixes too!)
    filestr = CODE[format](filestr, code_blocks, code_block_types,
                           tex_blocks, format)
    filestr += '\n'

    debugpr('%s\n**** The file after inserting intro/outro and tex/code blocks, and fixing last format-specific issues:\n\n%s\n\n' % \
          ('*'*80, filestr))

    # Next step: remove exercise solution/answers, notes, etc
    # (Note: must be done after code and tex blocks are inserted!
    # Otherwise there is a mismatch between all original blocks
    # and those present after solutions, answers, etc. are removed)
    envir2option = dict(sol='solutions', ans='answers', hint='hints')
    # Recall that the comment syntax is now dependent on the format
    comment_pattern = INLINE_TAGS_SUBST[format].get('comment', '# %s')
    for envir in 'sol', 'ans', 'hint':
        option_name = 'without-' + envir2option[envir]
        if option(option_name):
            pattern = comment_pattern % envir_delimiter_lines[envir][0] + \
                      '\n.+?' + comment_pattern % \
                      envir_delimiter_lines[envir][1] + '\n'
            replacement = comment_pattern % ('removed !b%s ... !e%s environment\n' % (envir, envir)) + comment_pattern % ('(because of the command-line option --%s)\n' % option_name)
            filestr = re.sub(pattern, replacement, filestr, flags=re.DOTALL)


    debugpr('%s\n**** The file after removal of solutions, answers, notes, hints, etc.:\n\n%s\n\n' % \
          ('*'*80, filestr))

    """
    # Not necessary after blocks have numbers
    from common import _CODE_BLOCK, _MATH_BLOCK
    remaining_code = filestr.count(_CODE_BLOCK)
    remaining_math = filestr.count(_MATH_BLOCK)
    if remaining_code > 0:
        print '*** BUG: %d remaining uninserted code blocks!' % remaining_code
        _abort()
    if remaining_math > 0:
        print '*** BUG: %d remaining uninserted tex blocks!' % remaining_math
        _abort()
    """

    # Final step: replace environments starting with | (instead of !)
    # by ! (for illustration of doconce syntax inside !bc/!ec directives).
    # Enough to consider |bc, |ec, |bt, and |et since all other environments
    # are processed when code and tex blocks are removed from the document.
    for envir in ['c', 't']:
        filestr = filestr.replace('|b' + envir, '!b' + envir)
        filestr = filestr.replace('|e' + envir, '!e' + envir)

    debugpr('%s\n**** The file after replacing |bc and |bt environments by true !bt and !et (in code blocks):\n\n%s\n\n' % \
          ('*'*80, filestr))

    return filestr


def preprocess(filename, format, preprocessor_options=[]):
    """
    Run the preprocess and mako programs on filename and return the name
    of the resulting file. The preprocessor_options list contains
    the preprocessor options given on the command line.
    In addition, the preprocessor option FORMAT (=format) is
    always defined.
    """

    f = open(filename, 'r'); filestr = f.read(); f.close()
    preprocessor = None

    # First guess if preprocess or mako is used

    # Collect first -Dvar=value options on the command line
    preprocess_options = [opt for opt in preprocessor_options
                          if opt[:2] == '-D']
    # Add -D to mako name=value options so that such variables
    # are set for preprocess too
    for opt in preprocessor_options:
        if opt[0] != '-' and '=' in opt:
            preprocess_options.append('-D' + opt)

    # Look for mako variables
    mako_kwargs = {'FORMAT': format}
    for opt in preprocessor_options:
        if opt.startswith('-D'):
            opt2 = opt[2:]
            if '=' in opt:
                key, value = opt2.split('=')
            else:
                key = opt2;  value = opt.startswith('-D')
        elif not opt.startswith('--'):
            try:
                key, value = opt.split('=')
            except ValueError:
                print 'command line argument "%s" not recognized' % opt
                _abort()
        else:
            key = None

        if key is not None:
            # Try eval(value), if it fails, assume string or bool
            try:
                mako_kwargs[key] = eval(value)
            except (NameError, TypeError, SyntaxError):
                mako_kwargs[key] = value

    filestr_without_code, code_blocks, code_block_types, tex_blocks = \
                          remove_code_and_tex(filestr)

    preprocess_commands = r'^#\s*#(if|define|include)'
    if re.search(preprocess_commands, filestr_without_code, re.MULTILINE):
        #print 'run preprocess on', filename, 'to make', resultfile
        preprocessor = 'preprocess'
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
                _abort()
        try:
            import preprocess
        except ImportError:
            print """\
%s makes use of preprocess directives and therefore requires
the preprocess program to be installed (see code.google.com/p/preprocess).
On Debian systems, preprocess can be installed through the
preprocess package (sudo apt-get install preprocess).
""" % filename
            _abort()

        if option('no-preprocess'):
            print 'Found preprocess-like statements, but --no-preprocess prevents running preprocess'
            shutil.copy(filename, resultfile)  # just copy
        else:
            cmd = 'preprocess -DFORMAT=%s %s %s > %s' % \
                  (format, preprocess_options, filename, resultfile)
            print 'running', cmd
            failure, outtext = commands.getstatusoutput(cmd)
            if failure:
                print 'Could not run preprocessor:\n%s' % cmd
                print outtext
                _abort()
            # Make filestr the result of preprocess in case mako shall be run
            f = open(resultfile, 'r'); filestr = f.read(); f.close()


    mako_commands = r'^ *<?%[^%]'
    # Problem: mako_commands match Matlab comments and SWIG directives,
    # so we need to remove code blocks for testing if we really use
    # mako. Also issue warnings if code blocks contain mako instructions
    # matching the mako_commands pattern
    match_percentage = re.search(mako_commands, filestr_without_code,
                                 re.MULTILINE)
    match_mako_variable = False
    for name in mako_kwargs:
        pattern = r'\$\{%s\}' % name
        if re.search(pattern, filestr_without_code):
            match_mako_variable = True
            break

    if (match_percentage or match_mako_variable) and option('no-mako'):
        # Found mako-like statements, but --no-mako is forced, give a message
        print '*** warning: mako is not run because of the option --no-mako'

    if (not option('no-mako')) and (match_percentage or match_mako_variable):
        # Found use of mako

        # Check if there is SWIG or Matlab code that can fool mako with a %
        mako_problems = False
        for code_block in code_blocks:
            m = re.search(mako_commands, code_block, re.MULTILINE)
            if m:
                print '\n\n*** warning: the code block\n---------------------------'
                print code_block
                print '''---------------------------
contains a single %% on the beginning of a line: %s
Such lines cause problems for the mako preprocessor
since it thinks this is a mako statement.
''' % (m.group(0))
                print
                mako_problems = True
        if mako_problems:
            print '''\
Use %% in the code block(s) above to fix the
problem with % at the beginning of lines,
or put the code in a file that is included
with @@@CODE filename, or drop mako instructions
or variables and rely on preprocess only in the
preprocessing step. In the latter case you
need to include --no-mako on the command line.
'''
            print 'mako is not run because of the lines starting with %!!\n'
            return filename if preprocessor is None else resultfile

        if preprocessor is not None:  # already found preprocess commands?
            # The output is in resultfile, mako is run on that
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
            _abort()

        print 'running mako on', filename, 'to make', resultfile
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

        debugpr('Keyword arguments to be sent to mako: %s' % \
                pprint.pformat(mako_kwargs))
        if preprocessor_options:
            print 'mako variables:', mako_kwargs


        try:
            filestr = temp.render(**mako_kwargs)
        except TypeError, e:
            if "'Undefined' object is not callable" in str(e):
                calls = '\n'.join(re.findall(r'(\$\{[A-Za-z0-9_ ]+?\()[^}]+?\}', filestr))
                print '*** mako error: ${func(...)} calls undefined function "func",\ncheck all ${...} calls in the file(s) for possible typos and lack of includes!\n%s' % calls
                _abort()
            else:
                # Just dump everything mako has
                print '*** mako error:'
                filestr = temp.render(**mako_kwargs)


        except NameError, e:
            if "Undefined" in str(e):
                variables = '\n'.join(re.findall(r'\$\{[A-Za-z0-9_]+?\}', filestr))
                print '*** mako error: one or more ${var} variables are undefined, check all!\n%s' % variables
                _abort()
            else:
                # Just dump everything mako has
                print '*** mako error:'
                filestr = temp.render(**mako_kwargs)

        f = open(resultfile, 'w')
        f.write(filestr)
        f.close()

    if preprocessor is None:
        # no preprocessor syntax detected
        resultfile = filename
    else:
        debugpr('%s\n**** The file after running preprocess and/or mako:\n\n%s\n\n' % (' '*80, filestr))

    return resultfile

def main():
    # doconce format accepts special command-line arguments:
    #   - debug (for debugging in file _doconce_debugging.log) or
    #   - skip_inline_comments
    #   - oneline (for removal of newlines/linebreaks within paragraphs)
    #   - encoding utf-8 (e.g.)
    #   - preprocessor options (-DVAR etc. for preprocess)

    # oneline is inactive (doesn't work well yet)

    global _log, encoding, filename

    try:
        format = sys.argv[1]
        filename = sys.argv[2]
        del sys.argv[1:3]
    except IndexError:
        from misc import get_legal_command_line_options
        options = ' '.join(get_legal_command_line_options())
        print 'Usage: %s format filename [preprocessor options] [%s]\n' \
              % (sys.argv[0], options)
        if len(sys.argv) == 1:
            print 'Missing format specification!'
        print 'formats:', str(supported_format_names())[1:-1]
        print '\n-DFORMAT=format is always defined when running preprocess'
        print 'Other -Dvar preprocess options can be added'
        _abort()

    names = supported_format_names()
    if format not in names:
        print '%s is not among the supported formats:\n%s' % (format, names)
        _abort()

    encoding = option('encoding=', default='')

    if option('debug'):
        _log_filename = '_doconce_debugging.log'
        _log = open(_log_filename,'w')
        _log.write("""
    This is a log file for the doconce script.
    Debugging is turned on by the command-line argument '--debug'
    to doconce format. Without that command-line argument,
    this file is not produced.

    """)
        print 'debug output in', _log_filename


    debugpr('\n\n>>>>>>>>>>>>>>>>> %s >>>>>>>>>>>>>>>>>\n\n' % format)

    if not os.path.isfile(filename):
        basename = filename
        filename = filename + '.do.txt'
        if not os.path.isfile(filename):
            print 'no such doconce file: %s' % (filename[:-7])
            _abort()
    else:
        basename = filename[:-7]

    out_filename = basename + FILENAME_EXTENSION[format]
    #print '\n----- doconce format %s %s' % (format, filename)
    preprocessor_options = [arg for arg in sys.argv[1:]
                            if not arg.startswith('--')]
    filename_preprocessed = preprocess(filename, format,
                                       preprocessor_options)
    file2file(filename_preprocessed, format, out_filename)

    if filename_preprocessed.startswith('__') and not option('debug'):
        os.remove(filename_preprocessed)  # clean up
    #print '----- successful run: %s filtered to %s\n' % (filename, out_filename)
    print 'output in', out_filename

if __name__ == '__main__':
    main()
