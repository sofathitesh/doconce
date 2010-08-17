import re

# how to replace code and LaTeX blocks by HTML (<pre>) environment:
def HTML_code(filestr, format):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<blockquote><pre>\n',
                    filestr)
    filestr = re.sub(r'!ec\n',
                     r'</pre></blockquote>\n<! -- END VERBATIM BLOCK -->\n',
                     filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'<blockquote><pre>\n', filestr)
    filestr = re.sub(r'!et\n', r'</pre></blockquote>\n', filestr)
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

def define(FILENAME_EXTENSION,
           BLANKLINE,
           INLINE_TAGS_SUBST,
           CODE,
           LIST,
           ARGLIST,
           TABLE,
           FIGURE_EXT,
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)
    
    FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
    BLANKLINE['HTML'] = '\n<p>\n'         # blank input line => new paragraph

    INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
        # keep math as is:
        'math':          r'\g<begin>\g<subst>\g<end>',
        'math2':         r'\g<begin>\g<puretext>\g<end>',
        'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
        'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
        'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
        'label':         r'<a name="\g<subst>">',
        'reference':     r'<a href="#\g<subst>">\g<subst></a>',
        'citation':      '',  # no citations
        'linkURL':       r'\g<begin><a href="\g<url>">\g<link></a>\g<end>',
        'plainURL':      r'<a href="\g<url>"><tt>\g<url></tt></a>',
        'section':       r'<h1>\g<subst></h1>',
        'subsection':    r'<h3>\g<subst></h3>',
        'subsubsection': r'<h5>\g<subst></h5>',
        'paragraph':     r'<b>\g<subst></b> ',
        'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
        'date':          r'<center><h3>\g<subst></h3></center>',
        'author':        r'<center><h3>\g<name><br>\g<institution></h3></center>',
        'figure':        r'<img src="\g<filename>" \g<options>> \g<caption>',
        'comment':       '<!-- %s -->',
        }

    CODE['HTML'] = HTML_code

    # how to typeset lists and their items in HTML:
    LIST['HTML'] = {
        'itemize':
        {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},

        'enumerate':
        {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},

        'description':
        {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},

        'separator': '',  # no need for blank lines between items and before/after
        }

    # how to type set description lists for function arguments, return
    # values, and module/class variables:
    ARGLIST['HTML'] = {
        'parameter': '<b>argument</b>',
        'keyword': '<b>keyword argument</b>',
        'return': '<b>return value(s)</b>',
        'instance variable': '<b>instance variable</b>',
        'class variable': '<b>class variable</b>',
        'module variable': '<b>module variable</b>',
        }

    FIGURE_EXT['HTML'] = ('.png', '.gif', '.jpg', '.jpeg')

    TABLE['HTML'] = html_table


    # document start:
    INTRO['HTML'] = """
    <html>
    <body bgcolor="white">
    """
    # document ending:
    OUTRO['HTML'] = """
    </body>
    </html>
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
