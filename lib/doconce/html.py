import re, os, glob, sys
from common import table_analysis, plain_exercise

# how to replace code and LaTeX blocks by html (<pre>) environment:
def html_code(filestr, format):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    # Do not use <code> here, it gives an extra line at the top
    filestr = c.sub(r'<blockquote>    <!-- begin verbatim block \g<1>-->\n<pre>\n',
                    filestr)
    filestr = re.sub(r'!ec\n',
                     r'</pre>\n</blockquote>   <! -- end verbatim block -->\n',
                     filestr)

    MATH_TYPESETTING = 'MathJax'
    c = re.compile(r'^!bt\n', re.MULTILINE)
    if MATH_TYPESETTING == 'MathJax':
        filestr = re.sub(r'!bt *\n', '$$\n', filestr)
        filestr = re.sub(r'!et *\n', '$$\n', filestr)

        filestr = re.sub(r'\$\$\s*\\\[', '$$', filestr)
        filestr = re.sub(r'\\\]\s*\$\$', '$$', filestr)

        filestr = filestr.replace(' label{', ' \\label{')
        pattern = r'^label\{'
        cpattern = re.compile(pattern, re.MULTILINE)
        filestr = cpattern.sub('\\label{', filestr)
    else:
        filestr = c.sub(r'<blockquote><pre>\n', filestr)
        filestr = re.sub(r'!et\n', r'</pre></blockquote>\n', filestr)
    return filestr

def html_figure(m):
    caption = m.group('caption').strip()
    filename = m.group('filename').strip()
    opts = m.group('options').strip()

    if opts:
        info = [s.split('=') for s in opts.split()]
        opts = ' ' .join(['%s=%s' % (option, value)
                          for option, value in info if option not in ['frac']])

    if caption:
       # Caption above figure and a horizontal rule (fine for anchoring):
       return '<center><hr>\n<caption><i>%s</i></caption>\n<p><img src="%s" align="bottom" %s></p>\n</center>' % (caption, filename, opts)
    else:
       # Just insert image file
       return '<center><p><img src="%s" align="bottom" %s></p></center>' % \
              (filename, opts)

def html_table(table):
    column_width = table_analysis(table['rows'])
    ncolumns = len(column_width)
    column_spec = table.get('columns_align', 'c'*ncolumns).replace('|', '')
    heading_spec = table.get('headings_align', 'c'*ncolumns).replace('|', '')
    a2html = {'r': 'right', 'l': 'left', 'c': 'center'}

    s = '<table border="1">\n'
    for i, row in enumerate(table['rows']):
        if row == ['horizontal rule']:
            continue
        if i == 1 and \
           table['rows'][i-1] == ['horizontal rule'] and \
           table['rows'][i+1] == ['horizontal rule']:
            headline = True
        else:
            headline = False

        s += '<tr>'
        for column, w, ha, ca in \
                zip(row, column_width, heading_spec, column_spec):
            if headline:
                s += '<td align="%s"><b>%s</b></td> ' % \
                     (a2html[ha], column.center(w))
            else:
                s += '<td align="%s">   %s    </td> ' % \
                     (a2html[ca], column.ljust(w))
        s += '</tr>\n'
    s += '</table>\n'
    return s

def html_movie(m):
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
        # html page for viewing the set of files
        plotfiles = glob.glob(filename)
        if not plotfiles:
            print 'No plotfiles on the form', filename
            sys.exit(1)
        plotfiles.sort()
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
        text = """
<p><a href="%s">Movie of files <tt>%s</tt></a>\n<em>%s</em></p>""" % \
               (moviehtml, filename, caption)
    elif 'youtube.com' in filename:
        if not 'youtube.com/embed/' in filename:
            filename = filename.replace('embed/', 'watch?v=')
        # Make html for a local YouTube frame
        width = kwargs.get('width', 425)
        height = kwargs.get('height', 349)
        text = """
<iframe width="%s" height="%s" src="%s" frameborder="0" allowfullscreen></iframe>
""" % (width, height, filename)
    else:
        text = """
<embed src="%s" %s autoplay="false" loop="true"></embed>
<p>
<em>%s</em>
</p>
""" % (filename, ' '.join(options), caption)
    return text

def html_author(authors_and_institutions, auth2index,
                inst2index, index2inst, auth2email):
    text = ''
    for author in auth2index:
        email = auth2email[author]
        if email is None:
            email_text = ''
        else:
            name, adr = email.split('@')
            email_text = ' (<tt>%s</tt> at <tt>%s</tt>)' % (name, adr)

        text += '\n<center>\n<b>%s</b> %s%s\n</center>\n' % \
            (author, str(auth2index[author]), email_text)
    text += '\n<p>\n'
    for index in index2inst:
        text += '<center>[%d] <b>%s</b></center>\n' % (index, index2inst[index])
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
    filestr = re.sub(r'label\{(.+?)\}', r'<a name="\g<1>"></A>', filestr)

    # make special anchors for all the section titles:
    for label in section_label2title:
        # first remove the anchor with this label as created above:
        filestr = filestr.replace('<a name="%s"></A>' % label, '')
        # make new anchor for this label (put in title):
        title = section_label2title[label]
        title_pattern = r'(_{3,7}|={3,7})\s*%s\s*(_{3,7}|={3,7})' % re.escape(title)  # title may contain ? () etc.
        filestr, n = re.subn(title_pattern,
                     '\g<1> %s <a name="%s"></A> \g<2>' % (title, label),
                     filestr)
        # (a little odd with mix of doconce title syntax and html NAME tag...)
        if n == 0:
            raise Exception('problem with substituting "%s"' % title)

    # replace all references to sections by section titles:
    for label in section_label2title:
        title = section_label2title[label]
        filestr = filestr.replace('ref{%s}' % label,
                                  '<a href="#%s">%s</a>' % (label, title))

    # replace all other references ref{myname} by <a href="#myname">myname</a>:
    filestr = re.sub(r'ref\{(.+?)\}', r'<a href="#\g<1>">\g<1></a>', filestr)

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
    text = '\n\n<h1>Bibliography</h1>\n\n<ol>\n'
    for label in citations:
        # remove newlines in reference data:
        text += '  <p><li><a name="%s"> ' % label + \
                ' '.join(bibdict[label].splitlines()) + '\n'
    text += '</ol>\n\n'
    return text

def html_index_bib(filestr, index, citations, bibfile):
    for label in citations:
        filestr = filestr.replace('cite{%s}' % label,
                                  '<a href="#%s">[%d]</a>' % \
                                  (label, citations[label]))
    if 'py' in bibfile:
        bibtext = bibdict2htmllist(bibfile['py'], citations)
        #filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, flags=re.MULTILINE)
        cpattern = re.compile(r'^BIBFILE:.+$', flags=re.MULTILINE)
        filestr = cpattern.sub(bibtext, filestr) # v2.6

    # could use anchors for idx{...}, but multiple entries of an index
    # would lead to multiple anchors, so remove them all:
    filestr = re.sub(r'idx\{.+?\}\n?', '', filestr)

    return filestr


def define(FILENAME_EXTENSION,
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
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)

    FILENAME_EXTENSION['html'] = '.html'  # output file extension
    BLANKLINE['html'] = '\n<P>\n'         # blank input line => new paragraph

    INLINE_TAGS_SUBST['html'] = {         # from inline tags to HTML tags
        # keep math as is:
        'math':          r'\g<begin>\( \g<subst> \)\g<end>',
        #'math2':         r'\g<begin>\g<puretext>\g<end>',
        'math2':         r'\g<begin>\( \g<latexmath> \)o\g<end>',
        'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
        'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
        'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
        'citation':      '',  # no citations
        'linkURL':       r'\g<begin><a href="\g<url>">\g<link></a>\g<end>',
        'linkURL2':      r'<a href="\g<url>">\g<link></a>',
        'linkURL3':      r'<a href="\g<url>">\g<link></a>',
        'linkURL2v':     r'<a href="\g<url>"><tt>\g<link></tt></a>',
        'linkURL3v':     r'<a href="\g<url>"><tt>\g<link></tt></a>',
        'plainURL':      r'<a href="\g<url>"><tt>\g<url></tt></a>',
        'inlinecomment': r'[<b>\g<name></b>: <em>\g<comment></em>]',
        'chapter':       r'<h1>\g<subst></h1>',
        'section':       r'<h2>\g<subst></h2>',
        'subsection':    r'<h3>\g<subst></h3>',
        'subsubsection': r'<h4>\g<subst></h4>',
        'paragraph':     r'<b>\g<subst></b> ',
        'abstract':      r'<b>\g<type>.</b> \g<text>\n\g<rest>',
        'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
        'date':          r'<center><h3>\g<subst></h3></center>',
        'author':        html_author,
        #'figure':        r'<p><em>\g<caption></em></p><img src="\g<filename>" align="bottom" \g<options>>',
        #'figure':        r'<img src="\g<filename>" align="bottom" \g<options>> <p><em>\g<caption></em></p>',
        #'figure':        r'<center><img src="\g<filename>" align="bottom" \g<options>> <br><caption><i>\g<caption></i></caption></center>',
        'figure':        html_figure,
        'movie':         html_movie,
        'comment':       '<!-- %s -->',
        }

    CODE['html'] = html_code

    # how to typeset lists and their items in html:
    LIST['html'] = {
        'itemize':
        {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},

        'enumerate':
        {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},

        'description':
        {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},

        'separator': '',  # no need for blank lines between items and before/after
        }

    # how to typeset description lists for function arguments, return
    # values, and module/class variables:
    ARGLIST['html'] = {
        'parameter': '<b>argument</b>',
        'keyword': '<b>keyword argument</b>',
        'return': '<b>return value(s)</b>',
        'instance variable': '<b>instance variable</b>',
        'class variable': '<b>class variable</b>',
        'module variable': '<b>module variable</b>',
        }

    FIGURE_EXT['html'] = ('.png', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['html'] = html_ref_and_label
    TABLE['html'] = html_table
    INDEX_BIB['html'] = html_index_bib
    EXERCISE['html'] = plain_exercise

    # document start:
    INTRO['html'] = """\
<?xml version="1.0" encoding="utf-8" ?>
<!--
Automatically generated HTML file from Doconce source
(http://code.google.com/p/doconce/)
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="generator" content="Doconce: http://code.google.com/p/doconce/" />

<script type="text/javascript"
 src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

</head>

<body bgcolor="white">
    """
    # document ending:
    OUTRO['html'] = """
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
