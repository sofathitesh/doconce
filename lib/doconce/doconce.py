#!/usr/bin/env python
import re, os, sys, shutil, commands, pprint, time, glob, codecs

def debugpr(out):
    if debug:
        #print out
        global _log
        _log = open('_doconce_debugging.log','a')
        _log.write(out + '\n')
        _log.close()


from common import *
import html, latex, rst, sphinx, st, epytext, plaintext, gwiki, pandoc
for module in html, latex, rst, sphinx, st, epytext, plaintext, gwiki, pandoc:
    #print 'calling define function in', module.__name__
    module.define(FILENAME_EXTENSION,
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
                  OUTRO)

def supported_format_names():
    return 'HTML', 'LaTeX', 'rst', 'sphinx', 'st', 'epytext', 'plain', 'gwiki', 'pandoc'

#----------------------------------------------------------------------------
# Translators: (no, do not include! use import! - as shown above)
# include "common.py"
# include "html.py"
# include "rst.py"
# include "st.py"
# include "plaintext.py"
# include "latex.py"
#----------------------------------------------------------------------------

def syntax_check(filestr, format):

    pattern = re.compile(r'^ +![eb][ct]', re.MULTILINE)
    m = pattern.search(filestr)
    if m:
        print '\nSyntax error: !bc/!bt/!ec/!et does not start at the beginning of the line'
        print filestr[m.start():m.start()+80]
        sys.exit(1)
    
    pattern = r'[^\n:.?!, ]\s*?^!b[ct]'
    m = re.search(pattern, filestr)
    if m:
        print '\nSyntax error: Line before !bc/!bt blocks ends with wrong character:'
        print filestr[m.start():m.start()+80]
        sys.exit(1)
    
    pattern = r'[^a-zA-Z0-9)"`.*_}][\n:.?!, ]\s*?^!b[ct]'
    m = re.search(pattern, filestr)
    if m:
        print '\nSyntax error: Line before !bc/!bt blocks has wrong character right before the final one (must be in [a-zA-Z0-9)"`.*_}]:'
        print filestr[m.start():m.start()+80]
        sys.exit(1)
    
    matches = re.findall(r'\\cite\{.+?\}', filestr)
    if matches:
        print r'\nSyntax error: found \cite{...} (should be no backslash!)'
        print matches
        sys.exit(1)

    matches = re.findall(r'\\idx\{.+?\}', filestr)
    if matches:
        print r'\nSyntax error: found \idx{...} (should be no backslash!)'
        print matches
        sys.exit(1)

    matches = re.findall(r'\\index\{.+?\}', filestr)
    if matches:
        print r'\nSyntax error: found \index{...} (should be idx{...}!)'
        print matches
        sys.exit(1)

    # outside !bt/!et environments there should only
    # be ref and label *without* the latex-ish backslash
    matches = re.findall(r'\\label\{.+?\}', filestr)
    if matches:
        print r'\nSyntax error: found \label{...} (should be no backslash!)'
        print matches
        sys.exit(1)
    matches = re.findall(r'\\ref\{.+?\}', filestr)
    if matches:
        print r'\nSyntax error: found \ref{...} (should be no backslash!)'
        print matches
        sys.exit(1)

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

    # Double quotes and not double single quotes in plain text:
    if "``" in filestr:
        print '''\nSyntax error: Double back-quotes `` found in file - should be "'''
        sys.exit(1)
    if "''" in filestr:
        print '''\nWarning: Double forward-quotes '' found in file - should be " (unless derivatives in math)'''

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
        'begin{split}',
        'end{split}',
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
                if c in lines[i] or r'\[' in lines[i]:
                    # begin math, do we have !bt at the line before?
                    if not lines[i-1].startswith('!bt'):
                        print '\nSyntax error: forgot to precede math (%s) by !bt:' % c
                        print lines[i-1]
                        print lines[i]
                        print lines[i+1]
                        sys.exit(1)
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
                    if not lines[i+1].startswith('!et'):
                        print '\nSyntax error: forgot to proceed math (%s) by !et:' % c
                        print lines[i-1]
                        print lines[i]
                        print lines[i+1]
                        sys.exit(1)
            """
    pattern = r'__[A-Za-z0-9,:` ]+__\.'
    matches = re.findall(pattern, filestr)
    if matches:
        print '\nSyntax error: Wrong paragraphs'
        print matches
        sys.exit(1)
    
    pattern = r'[^`]__[A-Za-z0-9,:` ]+[^.]__[^`]'
    # (exclude misunderstood paragraphs like `__call__`)
    matches = re.findall(pattern, filestr)
    if matches:
        print 'Warning: Missing period after paragraph heading'
        print matches
    
    pattern = r'idx\{[^}]*?\\_[^}]*?\}'
    matches = re.findall(pattern, filestr)
    if matches:
        print 'Warning: Backslash before underscore(s) in idx'
        print matches

    # Figure without comman between filename and options? Or initial spaces?
    pattern = r'^FIGURE:\s*\[[^,\]]+ +[^\]]*\]'
    cpattern = re.compile(pattern, re.MULTILINE)
    matches = cpattern.findall(filestr)
    if matches:
        print '\nSyntax error in FIGURE specification'\
              '\nmissing comma after filename, before options'
        print matches
        sys.exit(1)

    # Movie without comma between filename and options? Or initial spaces?
    pattern = r'^MOVIE:\s*\[[^,\]]+ +[^\]]*\]'
    cpattern = re.compile(pattern, re.MULTILINE)
    matches = cpattern.findall(filestr)
    if matches:
        print '\nSyntax error in MOVIE specification'\
              '\nmissing comma after filename, before options'
        print matches
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
            print matches
            sys.exit(1)
    
    # Keywords without colon:
    for kw in keywords:
        pattern = '^' + kw + ' +'
        cpattern = re.compile(pattern, re.MULTILINE)
        matches = cpattern.findall(filestr)
        if matches:
            print '\nSyntax error in %s: specification'\
                  '\nmissing colon after keyword' % kw
            print matches
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
        debugpr('Read ' + line)
        line = line.lstrip()

        # detect if we are inside verbatim blocks:
        if line.startswith('!bc'):
            inside_verbatim = True
        if line.startswith('!ec'):
            inside_verbatim = False
        if inside_verbatim:
            continue
            
        if line.startswith('@@@CODE'):
            debugpr('Found verbatim copy (line %d): %s' % (i+1, line))
            try:
                filename = line.split()[1]
            except IndexError:
                raise SyntaxError, \
                      'Syntax error: missing filename in line\n  %s' % line
            try:
                f = open(filename, 'r')
            except IOError, e:
                print 'Could not open the file %s used in @@@CODE instruction' % filename
                print e
                sys.exit(1)
            index = line.find('fromto:')
            if index == -1:
                # no from/to regex, read the whole file:
                complete_file = True
                code = f.read()
                debugpr('copy the file "%s" into a verbatim block\n' % filename)
               
            else:
                complete_file = False
                patterns = line[index+7:]
                try:
                    from_, to_ = patterns.split('@')
                except:
                    raise SyntaxError, \
                    'Syntax error: missing @ in regex in line\n  %s' % line
                cfrom = re.compile(from_)
                cto = re.compile(to_)
                codelines = []
                copy = False
                for codeline in f:
                    m = cfrom.search(codeline)
                    if m:
                        copy = True
                    m = cto.search(codeline)
                    if m:
                        copy = False
                        # now the to line is not included
                    if copy:
                        debugpr('copy from "%s" the line\n%s' % \
                              (filename, codeline))
                        codelines.append(codeline)
                code = ''.join(codelines)

            if format == 'LaTeX' or format == 'sphinx':
                # insert a cod or pro directive for ptex2tex:
                if complete_file:
                    code = "!bc pro\n%s\n!ec" % code
                else:
                    code = "!bc cod\n%s\n!ec" % code
            else:
                code = "!bc\n%s\n!ec" % code
            lines[i] = code
    
    filestr = '\n'.join(lines)
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
                # (rst, LaTeX, HTML):
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
            r"(?P<keyword>[^:]+?:)?(?P<text>.*)\s?")

        m = linescan.match(line)
        indent = len(m.group('indent'))
        listtype = m.group('listtype')
        if listtype:
            listtype = listtype.strip()
            listtype = LIST_SYMBOL[listtype]
        keyword = m.group('keyword')
        text = m.group('text')
        debugpr('  > indent=%d (previous indent=%d)' % (indent, lastindent))

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
                    if keyword:
                        keyword = parse_keyword(keyword, format) + ':'
                        item = itemformat % keyword + ' '
                        debugpr('  > This is an item in a description list '\
                              'with keyword "%s"' % keyword)
                        keyword = '' # to avoid adding keyword up in
                        # below (ugly hack, but easy linescan parsing...)
                result.write(' '*(indent-2))  # indent here counts with '* '
                result.write(item)
                if not (text.isspace() or not text):
                    result.write('\n' + ' '*(indent-1))
            else:
                debugpr('  > This is an item in a bullet list')
                result.write(' '*(indent-2))  # indent here counts with '* '
                result.write(item + ' ')

        else:
            debugpr('  > This line is not part of a list environment...')
            # should check emph, verbatim, etc., syntax check and common errors
            result.write(' '*indent)      # ordinary line

        # this is not a list definition line and therefore we must
        # add keyword + text because these two items make up the
        # line if a : present in an ordinary line
        if keyword:
            text = keyword + text
        debugpr('text=[%s]' % text)
        
        # hack to make wiki have all text in an item on a single line:
        newline = '' if lists and format == 'gwiki' else '\n'  # hack...
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

    # first check if the figure files are of right type:
    files = [filename for filename, options, caption in c.findall(filestr)]
    if type(FIGURE_EXT[format]) is str:
        extensions = [FIGURE_EXT[format]]
    else:
        extensions = FIGURE_EXT[format]  # is list
    for figfile in files:
        file_found = False
        if not os.path.isfile(figfile):
            basepath, ext = os.path.splitext(figfile)
            if not ext:  # no extension?
                # try to see if f + ext exists:
                for ext in extensions:
                    newname = figfile + ext
                    if os.path.isfile(newname):
                        filestr = filestr.replace(figfile, newname)
                        figfile = newname
                        file_found = True
                        break
                # try to see if other extensions exist:
                if not file_found:
                    candidate_files = glob.glob(figfile + '.*')
                    for newname in candidate_files:
                        if os.path.isfile(newname):
                            filestr = filestr.replace(figfile, newname)
                            figfile = newname
                            file_found = True
                            break
        if not os.path.isfile(figfile):
            raise ValueError('file %s does not exist' % figfile)

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
    #import pprint
    #pprint.pprint(m)
    section_label2title = {}
    for dummy1, title, dummy2, label in m:
        section_label2title[label] = title.strip()
    #pprint.pprint(section_label2title)

    # 2. perform format-specific editing of ref{...} and label{...}
    filestr = CROSS_REFS[format](section_label2title, format, filestr)
    return filestr


def handle_index_and_bib(filestr, format, has_title):
    """Process idx{...} and cite{...} instructions."""
    index = {}  # index[word] = lineno
    try:
        from collections import OrderedDict   # v2.7 and v3.1
    except ImportError:
        # use standard arbitrary-ordered dict instead (original order of
        # citations is then lost)
        OrderedDict = dict
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
                # replace cite{label1,label2,...} by individual cite{label1}
                # cite{label2}, etc. if not LaTeX format:
                if format != 'LaTeX':
                    for arg in cite_args:
                        replacement = ' '.join(['cite{%s}' % label.strip() \
                                                 for label in arg.split(',')])
                        filestr = filestr.replace('cite{%s}' % arg,
                                                  replacement)
                
    # version < 2.7 warning:
    if len(citations) > 0 and OrderedDict is dict:
        print 'Warning: citations may appear in random order unless you upgrade to Python version 2.7 or 3.1'
    filestr = INDEX_BIB[format](filestr, index, citations, bibfile)
    return filestr

def typeset_authors(filestr, format):
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
            a, i = line.split(' at ')
            if ' and ' in i:
                i = [w.strip() for w in i.split(' and ')]
            else:
                i = (i.strip(),)
            authors_and_institutions.append((a.strip(), i))
        else:  # just author's name
            authors_and_institutions.append((line.strip(), None))
    try:
        from collections import OrderedDict  # v2.7 and v3.1
    except ImportError:
        # use standard arbitrary-ordered dict instead (original order of
        # multiple authors is then lost)
        OrderedDict = dict
    inst2index = OrderedDict()
    index2inst = {}
    auth2index = OrderedDict()
    # get unique institutions:
    for a, institutions in authors_and_institutions:
        if institutions is not None:
            for i in institutions:
                inst2index[i] = None
    for index, i in enumerate(inst2index):
        inst2index[i] = index+1
        index2inst[index+1] = i
    for a, institutions in authors_and_institutions:
        if institutions is not None:
            auth2index[a] = [inst2index[i] for i in institutions]
        else:
            auth2index[a] = ''  # leads to empty address

    # version < 2.7 warning:
    if len(auth2index) > 1 and OrderedDict is dict:
        print 'Warning: multiple authors\n - correct order of authors requires Python version 2.7 or 3.1 (or higher)'
    author_block = INLINE_TAGS_SUBST[format]['author']\
        (authors_and_institutions, auth2index, inst2index, index2inst)
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
        #'figure',
        # important to do section, subsection, etc. BEFORE paragraph and bold:
        'emphasize', 'math2', 'math',
        'section', 'subsection', 'subsubsection',
        'bold', 'verbatim',
        'inlinecomment',
        'citation',
        'paragraph',  # after bold and emphasize
        'plainURL',   # before linkURL2 to avoid "URL" as linkename
        'linkURL2',
        'linkURL', 
        )
    for tag in ordered_tags:
        debugpr('Working with tag "%s"' % tag)
        tag_pattern = INLINE_TAGS[tag]
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
                debugpr('Found %d occurences of "%s":\n%s' % (occurences, tag, findlist))
                debugpr('%s is to be replaced using %s' % (tag, replacement))
            
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
                    #if 1:
                    try:
                        replacement_str = replacement(m)
                    #else:
                    except Exception, e:
                        print 'Problem at line', lines[i], '\n', e
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
                  (occurences, tag, filestr, ':'*80))
    return filestr
        
def subst_away_inline_comments(filestr):
    # inline comments: [hpl: this is a comment]
    pattern = r'\[(?P<name>[A-Za-z0-9_ ,.@]+?):(?P<comment>[^\]]*?)\]\s*'
    filestr = re.sub(pattern, '', filestr)
    return filestr



def doconce2format(in_filename, format, out_filename):
    """
    Perform the transformation of a doconce file, stored in in_filename,
    to a given format (HTML, LaTeX, etc.), written to out_filename.
    This is the "main" function in the module.
    """
    if in_filename.startswith('__'):
        print 'translate preprocessed Doconce text in', in_filename
    else:
        print 'translate Doconce text in', in_filename

    # if trouble with encoding:
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

    # hack to fix a bug with !ec/!et at the end of files, which is not
    # correctly substituted by '' in rst, sphinx, st, epytext, plain
    # (the fix is to add "enough" blank lines)
    if format in ('rst', 'sphinx', 'st', 'epytext', 'plain'):
        filestr = filestr.rstrip()
        if filestr.endswith('!ec') or filestr.endswith('!et'):
            filestr += '\n'*10

    # 0. step: check if ^#?TITLE: is present, and if so, header and footer
    # are to be included (later below):
    if re.search(r'^#?TITLE:', filestr, re.MULTILINE):
        has_title = True
    else:
        has_title = False
        
    # 1. step: insert verbatim code from other (source code) files:
    # (if the format is LaTeX, we could let ptex2tex do this, but
    # the CODE start@stop specifications may contain uderscores and
    # asterix, which will be replaced later and hence destroyed)
    #if format != 'LaTeX':
    filestr = insert_code_from_file(filestr, format)
    debugpr('%s\n**** The file after inserting @@@CODE (from file):\n\n%s\n\n' % \
          ('*'*80, filestr))

    # 2. step: remove all verbatim and math blocks
    
    filestr, code_blocks, tex_blocks = remove_code_and_tex(filestr)

    # for HTML we should make replacements of < ... > in code_blocks,
    # and handle latin-1 characters
    if format == 'HTML':  # fix
        from urllib import quote
        for i in range(len(code_blocks)):
            code_blocks[i] = re.sub(r'(<)([^>]*?)(>)',
                                    '&lt;\g<2>&gt;', code_blocks[i])
        # This special character transformation is easier done
        # with encoding="utf-8" in the first line in the HTML file:
        # (but we do it explicitly to make it robust)
        filestr = html.latin2html(filestr)
    elif format == 'LaTeX':  # fix
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
    if oneline_paragraphs:
        filestr = make_one_line_paragraphs(filestr, format)

    if remove_inline_comments:
        filestr = subst_away_inline_comments(filestr)

    syntax_check(filestr, format)

    # 3. step: deal with figures
    filestr = handle_figures(filestr, format)

    # 4. step: deal with cross referencing (must occur before other format subst)
    filestr = handle_cross_referencing(filestr, format)
    
    debugpr('%s\n**** The file after handling ref and label cross referencing\n\n%s\n\n' % ('*'*80, filestr))

    # 5. step: deal with index and bibliography (must be done before lists):
    filestr = handle_index_and_bib(filestr, format, has_title)

    debugpr('%s\n**** The file after handling index and bibliography\n\n%s\n\n' % ('*'*80, filestr))

    # 6. step: deal with lists
    filestr = typeset_lists(filestr, format,
                            debug_info=[code_blocks, tex_blocks])
    debugpr('%s\n**** The file after typesetting of list:\n\n%s\n\n' % \
          ('*'*80, filestr))

    # 7. step: deal with tables
    filestr = typeset_tables(filestr, format)
    debugpr('%s\n**** The file after typesetting of tables:\n\n%s\n\n' % \
          ('*'*80, filestr))

    # 8. step: do substitutions:
    filestr = inline_tag_subst(filestr, format)

    debugpr('%s\n**** The file after all inline substitutions:\n\n%s\n\n' % ('*'*80, filestr))
        
    # 9. step: substitute latex-style newcommands in filestr and tex_blocks
    # (not in code_blocks)
    from expand_newcommands import expand_newcommands
    if format != 'LaTeX' and format != 'pandoc':
        newcommand_files = ['newcommands_replace.tex']
        if format == 'sphinx':  # replace all newcommands in sphinx
            newcommand_files.extend(['newcommands.tex', 'newcommands_keep.tex'])
            # note: could use substitutions (|newcommand|) in rst/sphinx,
            # but they don't allow arguments so expansion of \newcommand
            # is probably a better solution
        filestr = expand_newcommands(newcommand_files, filestr)
        for i in range(len(tex_blocks)):
            tex_blocks[i] = expand_newcommands(newcommand_files, tex_blocks[i])

    # 10. step: insert verbatim and math code blocks again:
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)
    filestr += '\n'
    
    # 11. step: substitute code and tex environments:
    filestr = CODE[format](filestr, format)
    debugpr('%s\n**** The file after inserting tex/code blocks:\n\n%s\n\n' % \
          ('*'*80, filestr))

    if has_title:
        if format in INTRO:
            filestr = INTRO[format] + filestr
        if format in OUTRO:
            filestr = filestr + OUTRO[format]

    if format == 'LaTeX':
        if r'\includemovie[' not in filestr:
            # avoid the need for movie15 package in LaTeX file
            filestr = filestr.replace('define MOVIE', 'undef MOVIE')
     
    if encoding:
        f = codecs.open(out_filename, 'w', encoding)
    else:
        f = open(out_filename, 'w')
    f.write(filestr)
    f.close()


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
        preprocess_options = ' '.join(preprocessor_options)
        resultfile = '__tmp.do.txt'

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

    if re.search(mako_commands, filestr, re.MULTILINE):
        if preprocessor is not None:  # already found preprocess commands?
            print 'preprocess and mako preprocessor statements are mixed!'
            print 'Use only one of them!'
            sys.exit(1)
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
        
        print 'run mako preprocessor on', filename, 'to make', resultfile
        # add a space after \\ at the end of lines (otherwise mako
        # eats one of the backslashes in tex blocks)
        f = open(filename, 'r')
        filestr = f.read()
        f.close()
        filestr = filestr.replace('\\\\\n', '\\\\ \n')
        f = open(resultfile, 'w')
        f.write(filestr)
        f.close()
        from mako.template import Template
        temp = Template(filename=resultfile)
        f = open(resultfile, 'w')
        kwargs = {'FORMAT': format}
        for option in preprocessor_options:
            key, value = option.split('=')
            # Try eval(value), if it fails, assume string
            try:
                kwargs[key] = eval(value)
            except (NameError, SyntaxError):
                kwargs[key] = value
        f.write(temp.render(**kwargs))
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
    #   - remove_inline_comments
    #   - oneline (for removal of newlines/linebreaks within paragraphs)
    #   - encoding utf-8 (e.g.)
    #   - preprocessor options (-DVAR etc. for preprocess)

    # oneline is inactive (doesn't work well yet)

    global debug, _log, oneline_paragraphs, \
           remove_inline_comments, encoding
    options = ['debug', 'remove_inline_comments', 'encoding=',
               'oneline_paragraphs',] # 'tmp1']
    try:
        format = sys.argv[1]
        filename = sys.argv[2]
        del sys.argv[1:3]
    except IndexError:
        print 'Usage: %s format filename [%s] [preprocessor options]\n' \
              % (sys.argv[0], ' | '.join(options))
        if os.path.isfile(sys.argv[1]):
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
    
    remove_inline_comments = False
    if 'remove_inline_comments' in sys.argv[1:]:
        remove_inline_comments = True
        sys.argv.remove('remove_inline_comments')
    if '--remove_inline_comments' in sys.argv[1:]:
        remove_inline_comments = True
        sys.argv.remove('--remove_inline_comments')
                
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
    This is a log file for the doconce2format script.
    Debugging is turned on by a 3rd command-line argument 'debug'
    to doconce2format. Without that command-line argument,
    this file is not produced.

    """)

        
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
    doconce2format(filename_preprocessed, format, out_filename)
    if filename_preprocessed.startswith('__'):
        os.remove(filename_preprocessed)  # clean up
    #print '----- successful run: %s filtered to %s\n' % (filename, out_filename)
    print 'output in', out_filename
    
if __name__ == '__main__':
    main()
