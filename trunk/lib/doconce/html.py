import re

# how to replace code and LaTeX blocks by HTML (<pre>) environment:
def HTML_code(filestr, format):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<BLOCKQUOTE><PRE>\n',
                    filestr)
    filestr = re.sub(r'!ec\n',
                     r'</PRE></BLOCKQUOTE>\n<! -- END VERBATIM BLOCK -->\n',
                     filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'<BLOCKQUOTE><PRE>\n', filestr)
    filestr = re.sub(r'!et\n', r'</PRE></BLOCKQUOTE>\n', filestr)
    return filestr

from common import table_analysis

def html_table(table):
    column_width = table_analysis(table)
    s = '<TABLE border="1">\n'
    for i, row in enumerate(table):
        if row == ['horizontal rule']:
            continue
        if i == 1 and \
           table[i-1] == ['horizontal rule'] and \
           table[i+1] == ['horizontal rule']:
            headline = True
        else:
            headline = False

        s += '<TR>'
        for column, w in zip(row, column_width):
            if headline:
                c = '<B>%s</B>' % column.center(w)
            else:
                c = '   %s    ' % column.ljust(w)
            s += '<TD>%s</TD> ' % c
        s += '</TR>\n'
    s += '</TABLE>\n'
    return s

def html_author(authors_and_institutions, auth2index, 
                inst2index, index2inst):
    text = ''
    for author in auth2index:
        text += '\n<CENTER>\n<B>%s</B> %s\n</CENTER>\n' % \
            (author, str(auth2index[author]))
    text += '\n<P>\n'
    for index in index2inst:
        text += '[%d] <B>%s</B>\n<P>\n' % (index, index2inst[index])
    text += '\n\n'
    return text


def html_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # turn label{myname} to anchors <A NAME="myname"></a>
    filestr = re.sub(r'label\{(.+?)\}', r'<A NAME="\g<1>"></A>', filestr)

    # make special anchors for all the section titles:
    for label in section_label2title:
        # first remove the anchor with this label as created above:
        filestr = filestr.replace('<A NAME="%s"></A>' % label, '')
        # make new anchor for this label (put in title):
        title = section_label2title[label]
        title_pattern = r'(_{3,7}|={3,7})\s*%s\s*(_{3,7}|={3,7})' % re.escape(title)  # title may contain ? () etc.
        filestr, n = re.subn(title_pattern,
                     '\g<1> %s <A NAME="%s"></A> \g<2>' % (title, label),
                     filestr)
        # (a little odd with mix of doconce title syntax and HTML NAME tag...)
        if n == 0:
            raise Exception('problem with substituting "%s"' % title)

    # replace all references to sections by section titles:
    for label in section_label2title:
        title = section_label2title[label]
        filestr = filestr.replace('ref{%s}' % label,
                                  '<A HREF="#%s">%s</a>' % (label, title))

    # replace all other references ref{myname} by <a href="#myname">myname</a>:
    filestr = re.sub(r'ref\{(.+?)\}', r'<A HREF="#\g<1>">\g<1></a>', filestr)

    from common import ref2equations
    filestr = ref2equations(filestr)

    return filestr

def bibdict2htmllist(pyfile, citations):
    """Transform dict with bibliography to an HTML ordered list with anchors."""
    f = open(pyfile, 'r')
    bibstr = f.read()
    try:
        bibdict = eval(bibstr)
    except:
        print 'Error in Python dictionary for bibliography in', pyfile
        sys.exit(1)
    text = '\n\n<H1>Bibliography</H1>\n\n<OL>\n'
    for label in citations:
        # remove newlines in reference data:
        text += '  <P><LI><A NAME="%s"> ' % label + \
                ' '.join(bibdict[label].splitlines()) + '\n'
    text += '</OL>\n\n'
    return text

def html_index_bib(filestr, index, citations, bibfile):
    for label in citations:
        filestr = filestr.replace('cite{%s}' % label, 
                                  '<A HREF="#%s">[%d]</A>' % \
                                  (label, citations[label]))
    if 'py' in bibfile:
        bibtext = bibdict2htmllist(bibfile['py'], citations)
        filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, 
                         flags=re.MULTILINE)

    # could use anchors for idx{...}, but multiple entries of an index
    # would lead to multiple anchors
    filestr = re.sub(r'idx\{.+?\}', '', filestr)  # remove all index entries

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
    
    FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
    BLANKLINE['HTML'] = '\n<P>\n'         # blank input line => new paragraph

    INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
        # keep math as is:
        'math':          r'\g<begin>\g<subst>\g<end>',
        'math2':         r'\g<begin>\g<puretext>\g<end>',
        'emphasize':     r'\g<begin><EM>\g<subst></EM>\g<end>',
        'bold':          r'\g<begin><B>\g<subst></B>\g<end>',
        'verbatim':      r'\g<begin><TT>\g<subst></TT>\g<end>',
        'citation':      '',  # no citations
        'linkURL':       r'\g<begin><A HREF="\g<url>">\g<link></A>\g<end>',
        'plainURL':      r'<A HREF="\g<url>"><TT>\g<url></TT></A>',
        'section':       r'<H1>\g<subst></H1>',
        'subsection':    r'<H3>\g<subst></H3>',
        'subsubsection': r'<H4>\g<subst></H4>',
        'paragraph':     r'<B>\g<subst></B> ',
        'title':         r'<TITLE>\g<subst></TITLE>\n<CENTER><H1>\g<subst></H1></CENTER>',
        'date':          r'<CENTER><H3>\g<subst></H3></CENTER>',
        'author':        html_author,
        'figure':        r'<IMG SRC="\g<filename>" \g<options>> \g<caption>',
        'comment':       '<!-- %s -->',
        }

    CODE['HTML'] = HTML_code

    # how to typeset lists and their items in HTML:
    LIST['HTML'] = {
        'itemize':
        {'begin': '\n<UL>\n', 'item': '<LI>', 'end': '</UL>\n\n'},

        'enumerate':
        {'begin': '\n<OL>\n', 'item': '<LI>', 'end': '</OL>\n\n'},

        'description':
        {'begin': '\n<DL>\n', 'item': '<DT>%s<DD>', 'end': '</DL>\n\n'},

        'separator': '',  # no need for blank lines between items and before/after
        }

    # how to typeset description lists for function arguments, return
    # values, and module/class variables:
    ARGLIST['HTML'] = {
        'parameter': '<B>argument</B>',
        'keyword': '<B>keyword argument</B>',
        'return': '<B>return value(s)</B>',
        'instance variable': '<B>instance variable</B>',
        'class variable': '<B>class variable</B>',
        'module variable': '<B>module variable</B>',
        }

    FIGURE_EXT['HTML'] = ('.png', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['HTML'] = html_ref_and_label
    TABLE['HTML'] = html_table
    INDEX_BIB['HTML'] = html_index_bib


    # document start:
    INTRO['HTML'] = """
<HTML>
<BODY BGCOLOR="white">
    """
    # document ending:
    OUTRO['HTML'] = """
</BODY>
</HTML>
    """

def latin2html(text):
    """
    Transform a text with possible latin-1 characters to the
    equivalent valid text in HTML with all special characters
    with ordinal > 159 encoded as &#number;

    Method: convert from plain text (open(filename, 'r')) to utf-8,
    run through each character c, if ord(c) > 159,
    add the HTML encoded text to a list, otherwise just add c to the list,
    then finally join the list to make the new version of the text.

    Note: A simpler method is just to set
    <?xml version="1.0" encoding="utf-8" ?>
    as the first line in the HTML file, see how rst2html.py
    starts the HTML file.
    (However, the method below shows how to cope with special
    European characters in general.)
    """
    text_new = []
    try:
        text = text.decode('utf-8')
    except UnicodeDecodeError:
        try:
            text = text.decode('latin-1')
        except UnicodeDecodeError, e:
            print 'Tried to interpret the file as utf-8 (failed) and latin-1 (failed) - aborted'
            raise e
    for c in text:
        try:
            if ord(c) > 159:
                text_new.append('&#%d;' % ord(c))
            else:
                text_new.append(c)
        except Exception, e:
            print e
            print 'character causing problems:', c
            raise e.__class__('%s: character causing problems: %s' % \
                              (e.__class__.__name__, c))
    return ''.join(text_new)
