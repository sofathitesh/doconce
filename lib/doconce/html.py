import re, os, glob, sys, glob
from common import table_analysis, plain_exercise, insert_code_and_tex

# how to replace code and LaTeX blocks by html (<pre>) environment:
def html_code(filestr, code_blocks, code_block_types,
              tex_blocks, format):

    types2languages = dict(py='python', cy='cython', f='fortran',
                           c='c', cpp='c++', sh='bash', rst='rst',
                           m ='matlab', pl='perl', swig='c++',
                           latex='latex', html='html', js='js',
                           sys='bash', xml='xml')
    try:
        import pygments as pygm
        from pygments.lexers import guess_lexer, get_lexer_by_name
        from pygments.formatters import HtmlFormatter
        from pygments import highlight
    except ImportError:
        pygm = None
    # Can turn off pygments on the cmd line
    if '--no-pygments-html' in sys.argv:
        pygm = None
    if pygm is not None:
        linenos = '--pygments-html-linenos' in sys.argv

    # For html we should make replacements of < and > in code_blocks,
    # since these can be interpreted as tags, and we must
    # handle latin-1 characters.
    for i in range(len(code_blocks)):

        if pygm is not None:
            # Typeset with pygments
            #lexer = guess_lexer(code_blocks[i])
            if code_block_types[i].endswith('cod') or \
               code_block_types[i].endswith('pro'):
                type_ = code_block_types[i][:-3]
            else:
                type_ = code_block_types[i]
            if type_ in types2languages:
                language = types2languages[type_]
            else:
                language = 'text'
            lexer = get_lexer_by_name(language)
            formatter = HtmlFormatter(linenos=linenos, noclasses=True,
                                      style='emacs')
            result = highlight(code_blocks[i], lexer, formatter)

            # Fix ugly error boxes
            result = re.sub(r'<span style="border: 1px .*?">(.+?)</span>',
                            '\g<1>', result)

            code_blocks[i] = result

        else:
            # Plain <pre>: This does not catch things like '<x ...<y>'
            #code_blocks[i] = re.sub(r'(<)([^>]*?)(>)',
            #                        '&lt;\g<2>&gt;', code_blocks[i])
            code_blocks[i] = code_blocks[i].replace('<', '&lt;')
            code_blocks[i] = code_blocks[i].replace('>', '&gt;')

    from doconce import debugpr
    debugpr('Hei1\n%s' % filestr)
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)
    debugpr('Hei2\n%s' % filestr)


    if pygm:
        c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
        filestr = c.sub(r'<p>\n\n', filestr)
        filestr = re.sub(r'!ec\n', r'<p>\n', filestr)
        debugpr('Hei3\n%s' % filestr)
    else:
        c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
        # Do not use <code> here, it gives an extra line at the top
        filestr = c.sub(r'<blockquote>    <!-- begin verbatim block \g<1>-->\n<pre>\n', filestr)
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

    filestr = re.sub(r'\(ref\{(.+?)\}\)', r'\eqref{\g<1>}', filestr)

    # Final fixes for html format

    #print filestr
    #print '========================================================='
    header = '<title>' in filestr  # will the html file get a header?
    template = ''
    for arg in sys.argv:
        if arg.startswith('--html-template='):
            template = arg.split('=')[1]
            if header:
                print 'Warning: HTML template %s ignored since the file has a title (and hence an HTML header)' % template
            authors = '<! -- author(s) -->' in filestr
            if authors:
                print 'Warning: AUTHOR is not recommended when using HTML templates (looks no good)'
            break
    if template and not header:
        title = ''
        date = ''
        # The first section heading or a #TITLE: ... line becomes the title
        pattern = r'<!--\s+TITLE:\s*(.+?) -->'
        m = re.search(pattern, filestr)
        if m:
            title = m.group(1).strip()
            filestr = re.sub(pattern, '\n<h1>%s</h1>\n' % title, filestr)
        else:
            m = re.search(r'<h\d>(.+?)<a name=', filestr)
            if m:
                title = m.group(1).strip()
        pattern = r'<center><h\d>(.+?)</h\d></center>\s*<!-- date -->'
        m = re.search(pattern, filestr)
        if m:
            date = m.group(1).strip()
            # remove date since date is in template
            filestr = re.sub(pattern, '', filestr)

        f = open(template, 'r'); template = f.read(); f.close()
        # template can only have slots for title, date, main
        template = latin2html(template) # code non-ascii chars
        # replate % by %% in template, except for %(title), %(date), %(main)
        template = template.replace('%(title)s', '@@@TITLE@@@')
        template = template.replace('%(date)s', '@@@DATE@@@')
        template = template.replace('%(main)s', '@@@MAIN@@@')
        template = template.replace('%', '%%')
        template = template.replace('@@@TITLE@@@', '%(title)s')
        template = template.replace('@@@DATE@@@', '%(date)s')
        template = template.replace('@@@MAIN@@@', '%(main)s')

        variables = {'title': title, 'date': date, 'main': filestr}
        filestr = template % variables

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
       return """
<center> <! -- figure -->
<hr class="figure">
<center><p class="caption"> %s </p></center>
<p><img src="%s" align="bottom" %s></p>
</center>
""" % (caption, filename, opts)
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
                s += '<td align="%s"><b> %s </b></td> ' % \
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
    text = '\n\n<! -- author(s) -->\n'

    def email(author):
        address = auth2email[author]
        if address is None:
            email_text = ''
        else:
            name, place = address.split('@')
            #email_text = ' (<tt>%s</tt> at <tt>%s</tt>)' % (name, place)
            email_text = ' (<tt>%s at %s</tt>)' % (name, place)
        return email_text

    one_author_at_one_institution = False
    if len(auth2index) == 1:
        author = list(auth2index.keys())[0]
        if len(auth2index[author]) == 1:
            one_author_at_one_institution = True
    if one_author_at_one_institution:
        # drop index
        author = list(auth2index.keys())[0]
        text += '\n<center>\n<b>%s</b> %s\n</center>\n' % \
            (author, email(author))
        text += '\n\n<p>\n<!-- institution -->\n\n'
        text += '<center><b>%s</b></center>\n' % (index2inst[1])
    else:
        for author in auth2index:
            text += '\n<center>\n<b>%s</b> %s%s\n</center>\n' % \
                (author, str(auth2index[author]), email(author))
        text += '\n\n<p>\n<!-- institution(s) -->\n\n'
        for index in index2inst:
            text += '<center>[%d] <b>%s</b></center>\n' % \
                    (index, index2inst[index])
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
    # Remove Exercise, Project, Problem in references since those words
    # are used in the title of the section too
    pattern = r'(the\s*)?([Ee]xercises?|[Pp]rojects?|[Pp]roblems?)\s+ref\{'
    replacement = r'ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # extract the labels in the text (filestr is now without
    # mathematics and those labels)
    running_text_labels = re.findall(r'label\{(.+?)\}', filestr)

    # make special anchors for all the section titles with labels:
    for label in section_label2title:
        """[[[
        # first remove the anchor with this label as created above
        # because it shall not appear after a heading when it is
        # associated with the heading
        filestr = filestr.replace('<a name="%s"></a>' % label, '')
        """
        # make new anchor for this label (put in title):
        title = section_label2title[label]
        title_pattern = r'(_{3,9}|={3,9})\s*%s\s*(_{3,9}|={3,9})\s*label\{%s\}' % (re.escape(title), label)
        title_new = '\g<1> %s <a name="%s"></a> \g<2>' % (title.replace('\\', '\\\\'), label)
        filestr, n = re.subn(title_pattern, title_new, filestr)
        # (a little odd with mix of doconce title syntax and html NAME tag...)
        if n == 0:
            #raise Exception('problem with substituting "%s"' % title)
            pass

    # turn label{myname} to anchors <a name="myname"></a>
    filestr = re.sub(r'label\{(.+?)\}', r'<a name="\g<1>"></a>', filestr)

    # replace all references to sections by section titles:
    for label in section_label2title:
        title = section_label2title[label]
        filestr = filestr.replace('ref{%s}' % label,
                                  '<a href="#%s">%s</a>' % (label, title))

    # This special character transformation is easier done
    # with encoding="utf-8" in the first line in the html file:
    # (but we do it explicitly to make it robust)
    filestr = latin2html(filestr)
    # (wise to do latin2html before filestr = '\n'.join(lines) below)

    # Number all figures, find all figure labels and replace their
    # references by the figure numbers
    # (note: figures are already handled!)
    caption_start = '<p class="caption">'
    caption_pattern = r'%s(.+?)</p>' % caption_start
    label_pattern = r'%s.+?<a name="(.+?)">' % caption_start
    lines = filestr.splitlines()
    label2no = {}
    fig_no = 0
    for i in range(len(lines)):
        if caption_start in lines[i]:
            m = re.search(caption_pattern, lines[i])
            if m:
                fig_no += 1
                caption = m.group(1)
                from_ = caption_start + caption
                to_ = caption_start + 'Figure %d: ' % fig_no + caption
                lines[i] = lines[i].replace(from_, to_)

            m = re.search(label_pattern, lines[i])
            if m:
                label2no[m.group(1)] = fig_no
    filestr = '\n'.join(lines)

    for label in label2no:
        filestr = filestr.replace('ref{%s}' % label,
                                  '<a href="#%s">%d</a>' %
                                  (label, label2no[label]))

    # replace all other references ref{myname} by <a href="#myname">myname</a>:
    for label in running_text_labels:
        filestr = filestr.replace('ref{%s}' % label,
                                  '<a href="#%s">%s</a>' % (label, label))

    # insert enumerated anchors in all section headings without label
    # anchors, in case we want a table of contents with linkes to each section
    section_pattern = r'(_{3,9}|={3,9})(.+?)(_{3,9}|={3,9})'
    m = re.findall(section_pattern, filestr)
    for i in range(len(m)):
        heading1, title, heading2 = m[i]
        if not '<a name="' in title:
            newtitle = title + ' <a name="___sec%d"></a>' % i
            filestr = filestr.replace(heading1 + title + heading2,
                                      heading1 + newtitle + heading2,
                                      1) # count=1: only the first!

    return filestr

def bibdict2htmllist(pyfile, citations):
    """Transform dict with bibliography to an HTML ordered list with anchors."""
    f = open(pyfile, 'r')
    bibstr = f.read()
    try:
        bibdict = eval(bibstr)
    except Exception, e:
        print 'Error in Python dictionary for bibliography in', pyfile
        print e
        sys.exit(1)
    text = '\n\n<h1>Bibliography</h1>\n\n<ol>\n'
    for label in citations:
        if label in bibdict:
            bibdict[label] = latin2html(bibdict[label])
            # remove newlines in reference data:
            text += '  <p><li><a name="%s"> ' % label + \
                    ' '.join(bibdict[label].splitlines()) + '\n'
        else:
            print 'ERROR: cite{%s}: %s is not defined in %s' % \
                  (label, label, pyfile)
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


def html_toc(sections):
    # Find minimum section level
    tp_min = 4
    for title, tp, label in sections:
        if tp < tp_min:
            tp_min = tp

    #hr = '<hr>'
    hr = ''
    s = '<h2>Table of contents</h2>\n\n%s\n' % hr
    for i in range(len(sections)):
        title, tp, label = sections[i]
        href = label if label is not None else '___sec%d' % i
        s += '&nbsp; '*(3*(tp-tp_min)) + \
             '<a href="#%s">%s</a>' % (href, title ) + '<br>\n'
    s += '%s\n<p>\n' % hr
    return s

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
           TOC,
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)

    FILENAME_EXTENSION['html'] = '.html'  # output file extension
    BLANKLINE['html'] = '\n<p>\n'         # blank input line => new paragraph

    INLINE_TAGS_SUBST['html'] = {         # from inline tags to HTML tags
        # keep math as is:
        'math':          r'\g<begin>\( \g<subst> \)\g<end>',
        #'math2':         r'\g<begin>\g<puretext>\g<end>',
        'math2':         r'\g<begin>\( \g<latexmath> \)\g<end>',
        'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
        'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
        'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
        'citation':      '',  # no citations
        #'linkURL':       r'\g<begin><a href="\g<url>">\g<link></a>\g<end>',
        'linkURL2':      r'<a href="\g<url>">\g<link></a>',
        'linkURL3':      r'<a href="\g<url>">\g<link></a>',
        'linkURL2v':     r'<a href="\g<url>"><tt>\g<link></tt></a>',
        'linkURL3v':     r'<a href="\g<url>"><tt>\g<link></tt></a>',
        'plainURL':      r'<a href="\g<url>"><tt>\g<url></tt></a>',
        'inlinecomment': r'[<b>\g<name></b>: <em>\g<comment></em>]',
        'chapter':       r'\n<h1>\g<subst></h1>',
        'section':       r'\n<h2>\g<subst></h2>',
        'subsection':    r'\n<h3>\g<subst></h3>',
        'subsubsection': r'\n<h4>\g<subst></h4>',
        'paragraph':     r'<b>\g<subst></b> ',
        'abstract':      r'<b>\g<type>.</b> \g<text>\n\g<rest>',
        'title':         r'\n<title>\g<subst></title>\n\n<center><h1>\g<subst></h1></center>  <! -- document title -->\n',
        'date':          r'<center><h4>\g<subst></h4></center> <!-- date -->',
        'author':        html_author,
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
    TOC['html'] = html_toc

    # document start:
    if '--html-solarized' in sys.argv:
        css = """\
    body {
      margin:5;
      padding:0;
      border:0;	/* Remove the border around the viewport in old versions of IE */
      width:100%;
      background: #fdf6e3;
      min-width:600px;	/* Minimum width of layout - remove if not required */
      font-family: Verdana, Helvetica, Arial, sans-serif;
      font-size: 1.0em;
      line-height: 1.3em;
      color: #657b83;
    }
    a { color: #657b83; text-decoration:none; }
    a:hover { color: #b58900; background: #eee8d5; text-decoration:none; }
    h1, h2, h3 { margin:.8em 0 .2em 0; padding:0; }
    h2 { font-variant: small-caps; }
    pre {
      background: #fdf6e3;
      -webkit-box-shadow: inset 0 0 2px #000000;
      -moz-box-shadow: inset 0 0 2px #000000;
      box-shadow: inset 0 0 2px #000000;
      color: #586e75;
      margin-left: 0px;
      font-family: 'Droid Sans Mono', monospace;
      padding: 2px;
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
      -moz-background-clip: padding;
      -webkit-background-clip: padding-box;
      background-clip: padding-box;
    }
    tt { font-family: "Courier New", Courier; }
    hr { border: 0; width: 80%; border-bottom: 1px solid #aaa}
    p { text-indent: 0px; }
    p.caption { width: 80%; font-style: normal; text-align: left; }
    hr.figure { border: 0; width: 80%; border-bottom: 1px solid #aaa}
"""
    else:
        css = """\
    body {
      margin-top: 1.0em;
      background-color: #ffffff;
      font-family: Helvetica, Arial, FreeSans, san-serif;
      color: #000000;
    }
    h1 { font-size: 1.8em; color: #1e36ce; }
    h2 { font-size: 1.5em; color: #1e36ce; }
    h3 { color: #1e36ce; }
    a { color: #1e36ce; text-decoration:none; }
    tt { font-family: "Courier New", Courier; }
    pre { background: #ededed; color: #000; padding: 15px;}
    p { text-indent: 0px; }
    hr { border: 0; width: 80%; border-bottom: 1px solid #aaa}
    p.caption { width: 80%; font-style: normal; text-align: left; }
    hr.figure { border: 0; width: 80%; border-bottom: 1px solid #aaa}
"""
    # too small margin bottom: h1 { font-size: 1.8em; color: #1e36ce; margin-bottom: 3px; }


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

<!--
Color definitions:  http://www.december.com/html/spec/color0.html
CSS examples:       http://www.w3schools.com/css/css_examples.asp
-->

<style type="text/css">
%s
</style>

<!-- Use MathJax to render mathematics -->
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: {
     equationNumbers: {  autoNumber: "AMS"  },
     extensions: ["AMSmath.js", "AMSsymbols.js", "autobold.js"]
  }
});
</script>
<script type="text/javascript"
 src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
<!-- Fix slow MathJax rendering in IE8 -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">

</head>

<body>
    """ % css

    newcommands_files = glob.glob('newcommands*[^p].tex')
    newcommands = ''
    for filename in newcommands_files:
        f = open(filename, 'r')
        text = f.read().strip()
        if text:
            newcommands += '\n<!-- %s -->\n' % filename + '$$\n' + text \
                           + '\n$$\n\n'
    INTRO['html'] += newcommands
    INTRO['html'] += """

<!-- ------------------- main content ------------------------>
"""
    # document ending:
    OUTRO['html'] = """

<!-- ------------------- end of main content ----------------->
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
