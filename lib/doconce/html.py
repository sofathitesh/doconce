import re, os, glob, sys, glob
from common import table_analysis, plain_exercise, insert_code_and_tex, \
     indent_lines, python_online_tutor, bibliography, \
     cite_with_multiple_args2multiple_cites
from misc import option

global _file_collection_filename

# From http://service.real.com/help/library/guides/realone/ProductionGuide/HTML/htmfiles/colors.htm:
color_table = [
('white', '#FFFFFF', 'rgb(255,255,255)'),
('silver', '#C0C0C0', 'rgb(192,192,192)'),
('gray', '#808080', 'rgb(128,128,128)'),
('black', '#000000', 'rgb(0,0,0)'),
('yellow', '#FFFF00', 'rgb(255,255,0)'),
('fuchsia', '#FF00FF', 'rgb(255,0,255)'),
('red', '#FF0000', 'rgb(255,0,0)'),
('maroon', '#800000', 'rgb(128,0,0)'),
('lime', '#00FF00', 'rgb(0,255,0)'),
('olive', '#808000', 'rgb(128,128,0)'),
('green', '#008000', 'rgb(0,128,0)'),
('purple', '#800080', 'rgb(128,0,128)'),
('aqua', '#00FFFF', 'rgb(0,255,255)'),
('teal', '#008080', 'rgb(0,128,128)'),
('blue', '#0000FF', 'rgb(0,0,255)'),
('navy', '#000080', 'rgb(0,0,128)'),]


def add_to_file_collection(filename, doconce_docname=None, mode='a'):
    """
    Add filename to the collection of needed files for a Doconce-based
    HTML document to work.

    The first time the function is called, `doconce_docname` != None
    and this name is used to set the filename of the file collection.
    Later, `doconce_docname` is not given (otherwise previous info is erased).
    """
    # bin/doconce functions that add info to the file collection
    # must provide the right doconce_docname and mode='a' in order
    # to write correctly to an already existing file.
    global _file_collection_filename
    if isinstance(doconce_docname, str) and doconce_docname != '':
        if doconce_docname.endswith('.do.txt'):
            doconce_docname = doconce_docname[:-7]
        if doconce_docname.endswith('.html'):
            doconce_docname = doconce_docname[:-5]
        _file_collection_filename = '.' + doconce_docname + \
                                    '_html_file_collection'
    try:
        f = open(_file_collection_filename, mode)
        f.write(filename + '\n')
        f.close()
    except:
        pass

# Style sheets

admon_styles = """\
    .notice, .summary, .warning, .hint, .question {
    border: 1px solid; margin: 10px 0px; padding:15px 10px 15px 50px;
    background-repeat: no-repeat; background-position: 10px center;
    }
    .notice   { color: #00529B; background-color: #BDE5F8;
                background-image: url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Message.png'); }
    .summary  { color: #4F8A10; background-color: #DFF2BF;
                background-image:url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Valid_Green.png'); }
    .warning  { color: #9F6000; background-color: #FEEFB3;
                background-image: url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Attention.png'); }
    .hint     { color: #00529B; background-color: #BDE5F8;
                background-image: url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Info.png'); }
    .question { color: #4F8A10; background-color: #DFF2BF;
                background-image:url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Forward.png'); }

    .alert {
      padding:8px 35px 8px 14px; margin-bottom:18px;
      color:#c09853; text-shadow:0 1px 0 rgba(255,255,255,0.5);
      background-color:#fcf8e3; border:1px solid #fbeed5;
      -webkit-border-radius:4px; -moz-border-radius:4px;
       border-radius:4px}
     .alert-block {padding-top:14px; padding-bottom:14px}
     .alert-block > p, .alert-block > ul {margin-bottom:0}
     .alert-block p+p {margin-top:5px}
     .alert-notice, .alert-warning, .alert-question, .alert-hint, alert-summary {
       color: #555;
       background-color: whiteSmoke;
       background-position: 10px 10px;
       background-repeat: no-repeat;
       padding-left: 52px;
       font-size: 0.8em;
      }
     .alert-notice { background-image: url(https://doconce.googlecode.com/hg/bundled/html_images/Knob_Message.png); }
    .alert-summary  { background-image:url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Valid_Green.png'); }
    .alert-warning { background-image: url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Attention.png'); }
    .alert-hint { background-image: url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Info.png'); }
    .alert-question {background-image:url('https://doconce.googlecode.com/hg/bundled/html_images/Knob_Forward.png'); }
"""
# alt: background-image: url(data:image/png;base64,iVBORw0KGgoAAAAN...);

css_solarized = """\
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
    h1, h2, h3 { margin:.8em 0 .2em 0; padding:0; line-height: 125%; }
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

css_blueish = """\
    /* Color definitions:  http://www.december.com/html/spec/color0.html
       CSS examples:       http://www.w3schools.com/css/css_examples.asp */

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

css_blueish2 = """\
    /* Color definitions:  http://www.december.com/html/spec/color0.html
       CSS examples:       http://www.w3schools.com/css/css_examples.asp */

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
    pre {
    background-color: #fefbf3;
    vpadding: 9px;
    border: 1px solid rgba(0,0,0,.2);
    -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.1);
       -moz-box-shadow: 0 1px 2px rgba(0,0,0,.1);
            box-shadow: 0 1px 2px rgba(0,0,0,.1);
    }
    pre, code { font-size: 90%; line-height: 1.6em; }
    pre > code { background-color: #fefbf3; border: none }
    p { text-indent: 0px; }
    hr { border: 0; width: 80%; border-bottom: 1px solid #aaa}
    p.caption { width: 80%; font-style: normal; text-align: left; }
    hr.figure { border: 0; width: 80%; border-bottom: 1px solid #aaa}
"""

css_bloodish = """\
    body {
      font-family: Helvetica, Verdana, Arial, Sans-serif;
      color: #404040;
      background: #ffffff;
    }
    h1 { font-size: 1.8em;  color: #8A0808; }
    h2 { font-size: 1.5em;  color: #8A0808; }
    h3, h4 { color: #8A0808; }
    a { color: #8A0808; text-decoration:none; }
    tt { font-family: "Courier New", Courier; }
    pre { background: #ededed; color: #000; padding: 15px;}
    p { text-indent: 0px; }
    hr { border: 0; width: 80%; border-bottom: 1px solid #aaa}
    p.caption { width: 80%; font-style: normal; text-align: left; }
    hr.figure { border: 0; width: 80%; border-bottom: 1px solid #aaa}
"""

# too small margin bottom: h1 { font-size: 1.8em; color: #1e36ce; margin-bottom: 3px; }


def html_code(filestr, code_blocks, code_block_types,
              tex_blocks, format):
    """Replace code and LaTeX blocks by html environments."""

    types2languages = dict(py='python', cy='cython', f='fortran',
                           c='c', cpp='c++', sh='bash', rst='rst',
                           m ='matlab', pl='perl', rb='ruby',
                           swig='c++', latex='latex', tex='latex',
                           html='html', xml='xml',
                           js='js', sys='bash',
                           pyproopt='python')
    try:
        import pygments as pygm
        from pygments.lexers import guess_lexer, get_lexer_by_name
        from pygments.formatters import HtmlFormatter
        from pygments import highlight
        from pygments.styles import get_all_styles
    except ImportError:
        pygm = None
    # Can turn off pygments on the cmd line
    if option('no-pygments-html'):
        pygm = None
    if pygm is not None:
        pygm_style = option('pygments-html-style=', default='default')
        legal_styles = list(get_all_styles())
        legal_styles += ['no', 'none']
        if pygm_style not in legal_styles:
            print 'pygments style "%s" is not legal, must be among\n%s' % (pygm_style, ', '.join(legal_styles))
            #sys.exit(1)
            print 'using the default style...'
            pygm_style = 'default'
        if pygm_style in ['no', 'none']:
            pygm = None

        linenos = option('pygments-html-linenos')

    PythoOnlineTutor = False  # True if one occurence
    for i in range(len(code_blocks)):
        if code_block_types[i].startswith('pyoptpro'):
            PythoOnlineTutor = True
            if pygm is None:
                print '*** error: cannot use Python Online Tutorial (pyproopt)'
                print '    without pygmentized code'
                sys.exit(1)
            code_blocks[i] = python_online_tutor(code_blocks[i],
                                                 return_tp='iframe')

        elif pygm is not None:
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
                                      style=pygm_style)
            result = highlight(code_blocks[i], lexer, formatter)

            result = '<!-- code=%s%s typeset with pygments style "%s" -->\n' % (language, '' if code_block_types[i] == '' else ' (from !bc %s)' % code_block_types[i], pygm_style) + result
            # Fix ugly error boxes
            result = re.sub(r'<span style="border: 1px .*?">(.+?)</span>',
                            '\g<1>', result)

            code_blocks[i] = result

        else:
            # Plain <pre>: This does not catch things like '<x ...<y>'
            #code_blocks[i] = re.sub(r'(<)([^>]*?)(>)',
            #                        '&lt;\g<2>&gt;', code_blocks[i])
            # Substitute & first, otherwise & in &quot; becomes &amp;quot;
            code_blocks[i] = code_blocks[i].replace('&', '&amp;')
            code_blocks[i] = code_blocks[i].replace('<', '&lt;')
            code_blocks[i] = code_blocks[i].replace('>', '&gt;')
            code_blocks[i] = code_blocks[i].replace('"', '&quot;')

    if option('wordpress'):
        # Change all equations to $latex ...$\n
        replace = [
            (r'\[', '$latex '),
            (r'\]', ' $\n'),
            (r'\begin{equation}', '$latex '),
            (r'\end{equation}', ' $\n'),
            (r'\begin{equation*}', '$latex '),
            (r'\end{equation*}', ' $\n'),
            (r'\begin{align}', '$latex '),
            (r'\end{align}', ' $\n'),
            (r'\begin{align*}', '$latex '),
            (r'\end{align*}', ' $\n'),
            ]
        for i in range(len(tex_blocks)):
            if '{align' in tex_blocks[i]:
                tex_blocks[i] = tex_blocks[i].replace('&', '')
                tex_blocks[i] = tex_blocks[i].replace('\\\\', ' $\n\n$latex ')
            for from_, to_ in replace:
                tex_blocks[i] = tex_blocks[i].replace(from_, to_)
            tex_blocks[i] = re.sub(r'label\{.+?\}', '', tex_blocks[i])

    for i in range(len(tex_blocks)):
        """
        Not important - the problem was repeated label.
        if 'begin{equation' in tex_blocks[i]:
            # Make sure label is on a separate line inside begin{equation}
            # environments (insert \n after labels with something before)
            tex_blocks[i] = re.sub('([^ ]) +label\{', '\g<1>\nlabel{',
                                   tex_blocks[i])
        """
        if 'label' in tex_blocks[i]:
            # Fix label -> \label in tex_blocks
            tex_blocks[i] = tex_blocks[i].replace(' label{', ' \\label{')
            pattern = r'^label\{'
            cpattern = re.compile(pattern, re.MULTILINE)
            tex_blocks[i] = cpattern.sub('\\label{', tex_blocks[i])


    from doconce import debugpr
    debugpr('File before call to insert_code_and_tex (format html)\n%s'
            % filestr)
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)
    debugpr('File after call to isnert_code_and tex (format html)\n%s'
            % filestr)

    if pygm or PythoOnlineTutor:
        c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
        filestr = c.sub(r'<p>\n\n', filestr)
        filestr = re.sub(r'!ec\n', r'<p>\n', filestr)
        debugpr('\n\nAfter replacement of !bc and !ec (pygmntized code)\n%s' % filestr)
    else:
        c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
        # <code> gives an extra line at the top unless the code starts
        # right after (do that - <pre><code> might be important for many
        # HTML/CSS styles).
        filestr = c.sub(r'<!-- begin verbatim block \g<1>-->\n<pre><code>', filestr)
        filestr = re.sub(r'!ec\n',
                r'</code></pre>\n<!-- end verbatim block -->\n',
                filestr)

    if option('wordpress'):
        MATH_TYPESETTING = 'WordPress'
    else:
        MATH_TYPESETTING = 'MathJax'
    c = re.compile(r'^!bt *\n', re.MULTILINE)
    m1 = c.search(filestr)
    # common.INLINE_TAGS['math'] won't work since we have replaced
    # $...$ by \( ... \)
    pattern = r'\\\( .+? \\\)'
    m2 = re.search(pattern, filestr)
    math = bool(m1) or bool(m2)

    if MATH_TYPESETTING == 'MathJax':
        # LaTeX blocks are surrounded by $$
        filestr = re.sub(r'!bt *\n', '$$\n', filestr)
        # (add extra newline after $$ since Google's blogspot HTML
        # needs that line to show the math right - otherwise it does not matter)
        filestr = re.sub(r'!et *\n', '$$\n\n', filestr)

        # Remove inner \[..\] from equations $$ \[ ... \] $$
        filestr = re.sub(r'\$\$\s*\\\[', '$$', filestr)
        filestr = re.sub(r'\\\]\s*\$\$', '$$', filestr)
        # Equation references (ref{...}) must be \eqref{...} in MathJax
        # (note: this affects also (ref{...}) syntax in verbatim blocks...)
        filestr = re.sub(r'\(ref\{(.+?)\}\)', r'\eqref{\g<1>}', filestr)

    elif MATH_TYPESETTING == 'WordPress':
        filestr = re.sub(r'!bt *\n', '\n', filestr)
        filestr = re.sub(r'!et *\n', '\n', filestr)
        # References are not supported
        # (note: this affects also (ref{...}) syntax in verbatim blocks...)
        filestr = re.sub(r'\(ref\{(.+?)\}\)',
                         r'<b>(REF to equation \g<1> not supported)</b>', filestr)
    else:
        # Plain verbatim display of LaTeX syntax in math blocks
        filestr = c.sub(r'<blockquote><pre>\n', filestr)
        filestr = re.sub(r'!et *\n', r'</pre></blockquote>\n', filestr)

    # --- Final fixes for html format ---

    # Add MathJax script if math is present (math is defined right above)
    if math and MATH_TYPESETTING == 'MathJax':
        newcommands_files = list(
            sorted([name
                    for name in glob.glob('newcommands*.tex')
                    if not name.endswith('.p.tex')]))
        newcommands = ''
        for filename in newcommands_files:
            f = open(filename, 'r')
            text = f.read().strip()
            if text:
                newcommands += '\n<!-- %s -->\n' % filename + '$$\n' + text \
                               + '\n$$\n\n'
        mathjax = """

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

"""
        latex = '\n\n' + mathjax + newcommands + '\n\n'
        if '<body>' in filestr:
            # Add MathJax stuff after <body> tag
            filestr = filestr.replace('<body>\n', '<body>' + latex)
        else:
            # Add MathJax stuff to the beginning
            filestr = latex + filestr

    # Add </li> in lists
    cpattern = re.compile('<li>(.+?)(\s+)<li>', re.DOTALL)
    def find_list_items(match):
        """Return replacement from match of <li> tags."""
        # Does the match run out of the list?
        if re.search(r'</?(ul|ol)>', match.group(1)):
            return '<li>' + match.group(1) + match.group(2)
        else:
            return '<li>' + match.group(1) + '</li>' + match.group(2)

    # cpattern can only detect every two list item because it cannot work
    # with overlapping patterns. Remedy: have two <li> to avoid overlap,
    # fix that after all replacements are done.
    filestr = filestr.replace('<li>', '<li><li>')
    filestr = cpattern.sub(find_list_items, filestr)
    # Fix things that go wrong with cpattern: list items that go
    # through end of lists over to next list item.
    cpattern = re.compile('<li>(.+?)(\s+)(</?ol>|</?ul>)', re.DOTALL)
    filestr = cpattern.sub('<li>\g<1></li>\g<2>\g<3>', filestr)
    filestr = filestr.replace('<li><li>', '<li>')  # fix

    # Strip multiple <p> tags in sequence down to one (must be repeated)
    pattern = r'(<p>\s+<p>)+'
    filestr = re.sub(pattern, '<p>\n', filestr)
    filestr = re.sub(pattern, '<p>\n', filestr)
    filestr = re.sub(pattern, '<p>\n', filestr)

    # Find all URLs to files (non http, ftp)
    import common
    pattern = '<a href="' + common._linked_files
    files = re.findall(pattern, filestr)
    for f in files:
        add_to_file_collection(f)





    # Add info about the toc (for construction of navigation panels etc.).
    # Just dump the tocinfo dict so that we can read it and take eval
    # later
    import pprint
    global tocinfo
    if tocinfo is not None and isinstance(tocinfo, dict):
        toc = '\n<!-- tocinfo\n%s\nend of tocinfo -->\n\n' % \
              pprint.pformat(tocinfo)

        if '<body>' in filestr:
            # toc before the <body> tag
            filestr = filestr.replace('<body>\n', toc + '<body>\n')
        else:
            # tocinfo to the beginning
            filestr = toc + filestr

    # Add header from external template
    template = option('html-template=', default='')
    if option('html-style=') == 'vagrant':
        # Set template_vagrant.html as template
        if not template:
            print """
*** error: --html-style=vagrant requires
    cp -r path/to/doconce-source-root/bundled/html_styles/style_vagrant/* .
    # edit template_vargrant.html to template_mystyle.html
    --html-template=template_mystyle.html
"""
            sys.exit(1)
    if 'template_vagrant.html' in template \
       and not option('html-style=') == 'vagrant':
        print """
*** error: --html-template= with a template based on
    template_vagrant.html requires --html-style=vagrant
"""
        sys.exit(1)

    if template:
        title = ''
        date = ''

        header = '<title>' in filestr  # will the html file get a header?
        if header:
            print """\
*** warning: TITLE may look strange with a template -
             it is recommended to comment out the title: #TITLE:"""
            pattern = r'<title>(.+?)</title>'
            m = re.search(pattern, filestr)
            if m:
                title = m.group(1).strip()
                filestr = re.sub(pattern, r'<h1>\g<1></h1>', filestr)
        authors = '<!-- author(s):' in filestr

        if authors:
            print """\
*** warning: AUTHOR may look strange with a template -
             it is recommended to comment out all authors: #AUTHOR.
             Better to hardcode authors in a footer in the template."""

        # Extract title
        if title == '':
            # No real title found above.
            # The first section heading or a #TITLE: ... line becomes the title
            pattern = r'<!--\s+TITLE:\s*(.+?) -->'
            m = re.search(pattern, filestr)
            if m:
                title = m.group(1).strip()
                filestr = re.sub(pattern, '\n<h1>%s</h1>\n' % title, filestr)

            # Now use the first heading as title
            m = re.search(r'<h\d>(.+?)<a name=', filestr)
            if m:
                title = m.group(1).strip()

        # Extract date
        pattern = r'<center><h\d>(.+?)</h\d></center>\s*<!-- date -->'
        m = re.search(pattern, filestr)
        if m:
            date = m.group(1).strip()
            # remove date since date is in template
            filestr = re.sub(pattern, '', filestr)

        # Make toc for navigation
        toc_html = ''
        if option('html-style=') == 'vagrant':
            level_min = tocinfo['highest level']
            toc_html = ''
            for title, level, label, href in tocinfo['sections']:
                nspaces = 1
                indent = '&nbsp; '*(nspaces*(level - level_min))
                toc_html += '     <!-- vagrant nav toc: "%s" --> <li> %s <a href="#%s">%s</a>\n' % (title, indent, href, title)

        f = open(template, 'r'); template = f.read(); f.close()
        # template can only have slots for title, date, main
        template = latin2html(template) # code non-ascii chars
        # replate % by %% in template, except for %(title), %(date), %(main),
        # etc which are the variables we can plug into the template.
        # The keywords list holds the names of these variables (can define
        # more than we actually use).
        keywords = ['title', 'date', 'main', 'table_of_contents',
                    ]
        for keyword in keywords:
            from_ = '%%(%s)s' % keyword
            to_ = '@@@%s@@@' % keyword.upper()
            template = template.replace(from_, to_)
        template = template.replace('%', '%%')
        for keyword in keywords:
            to_ = '%%(%s)s' % keyword
            from_ = '@@@%s@@@' % keyword.upper()
            template = template.replace(from_, to_)

        variables = {keyword: '' for keyword in keywords} # init
        variables.update({'title': title, 'date': date, 'main': filestr,
                          'table_of_contents': toc_html})
        if '%(date)s' in template and date == '':
            print '*** warning: template contains date (%(date)s)'
            print '    but no date is specified in the document'
        filestr = template % variables

    if MATH_TYPESETTING == 'WordPress':
        # Remove all comments for wordpress.com html
        pattern = re.compile('<!-- .+? -->', re.DOTALL)
        filestr = re.sub(pattern, '', filestr)
    return filestr

def html_figure(m):
    caption = m.group('caption').strip()
    filename = m.group('filename').strip()
    opts = m.group('options').strip()

    if not filename.startswith('http'):
        add_to_file_collection(filename)

    if opts:
        info = [s.split('=') for s in opts.split()]
        opts = ' ' .join(['%s=%s' % (opt, value)
                          for opt, value in info if opt not in ['frac']])

    if caption:
       # Caption above figure and a horizontal rule (fine for anchoring):
       return """
<center> <!-- figure -->
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
    caption = m.group('caption').strip()

    if not filename.startswith('http'):
        add_to_file_collection(filename)

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

    if 'youtu.be' in filename:
        filename = filename.replace('youtu.be', 'youtube.com')

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
            filename = filename.replace('watch?v=', '')
            filename = filename.replace('youtube.com/', 'youtube.com/embed/')
            filename = filename.replace('http://youtube.com/', 'http://www.youtube.com/')
        # Make html for a local YouTube frame
        width = kwargs.get('width', 640)
        height = kwargs.get('height', 365)
        text = """
<iframe width="%s" height="%s" src="%s" frameborder="0" allowfullscreen></iframe>
""" % (width, height, filename)
        if caption:
            text += """\n<em>%s</em>\n\n""" % caption
    elif 'vimeo.com' in filename:
        if not 'player.vimeo.com/video/' in filename:
            if not filename.startswith('http://'):
                filename = 'http://' + filename
            filename = filename.replace('http://vimeo.com', 'http://player.vimeo.com/video')
        # Make html for a local Vimeo frame
        width = kwargs.get('width', 640)
        height = kwargs.get('height', 365)
        text = """
<iframe width="%s" height="%s" src="%s" frameborder="0" allowfullscreen></iframe>
""" % (width, height, filename)
        if caption:
            text += """\n<em>%s</em>\n\n""" % caption
    else:
        width = kwargs.get('width', 640)
        height = kwargs.get('height', 365)
        if filename.endswith('.mp4'):
            text= """
<video width='%s' height='%s' preload='none' controls ><source src='%s' type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'/></video></p>
<p><em>%s</em></p>
""" % (width, height, filename, caption)
        else:
            text = """
<embed src="%s" %s autoplay="false" loop="true"></embed>
<p><em>%s</em></p>
""" % (filename, ' '.join(options), caption)
    return text

def html_author(authors_and_institutions, auth2index,
                inst2index, index2inst, auth2email):
    # Make a short list of author names - can be extracted elsewhere
    # from the HTML code and used in, e.g., footers.
    authors = [author for author in auth2index]
    if len(authors) > 1:
        authors[-1] = 'and ' + authors[-1]
    authors = ', '.join(authors)
    text = """

<p>
<!-- author(s): %s -->
""" % authors

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
    # anchors, in case we want a table of contents with links to each section
    section_pattern = re.compile(r'^\s*(_{3,9}|={3,9})(.+?)(_{3,9}|={3,9})\s*$',
                                 re.MULTILINE)
    m = section_pattern.findall(filestr)
    for i in range(len(m)):
        heading1, title, heading2 = m[i]
        if not '<a name="' in title:
            newtitle = title + ' <a name="___sec%d"></a>' % i
            filestr = filestr.replace(heading1 + title + heading2,
                                      heading1 + newtitle + heading2,
                                      1) # count=1: only the first!

    return filestr


def html_index_bib(filestr, index, citations, pubfile, pubdata):
    if citations:
        filestr = cite_with_multiple_args2multiple_cites(filestr)
    for label in citations:
        filestr = filestr.replace('cite{%s}' % label,
                                  '<a href="#%s">[%d]</a>' % \
                                  (label, citations[label]))
    if pubfile is not None:
        bibtext = bibliography(pubdata, citations, format='doconce')
        for label in citations:
            bibtext = bibtext.replace('label{%s}' % label,
                                      '<a name="%s"></a>' % label)
        filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, flags=re.MULTILINE)

    # could use anchors for idx{...}, but multiple entries of an index
    # would lead to multiple anchors, so remove them all:
    filestr = re.sub(r'idx\{.+?\}\n?', '', filestr)

    return filestr

# Module variable holding info about section titles etc.
# To be used in navitation panels.
global tocinfo
tocinfo = None

def html_toc(sections):
    # Find minimum section level
    level_min = 4
    for title, level, label in sections:
        if level < level_min:
            level_min = level


    extended_sections = []  # extended list for toc in HTML file
    #hr = '<hr>'
    hr = ''
    s = '<h2>Table of contents</h2>\n\n%s\n' % hr
    for i in range(len(sections)):
        title, level, label = sections[i]
        href = label if label is not None else '___sec%d' % i
        indent = '&nbsp; '*(3*(level - level_min))
        s += indent + '<a href="#%s">%s</a>' % (href, title ) + '<br>\n'
        extended_sections.append((title, level, label, href))
    s += '%s\n<p>\n' % hr

    # Store for later use in navgation panels etc.
    global tocinfo
    tocinfo = {'sections': extended_sections, 'highest level': level_min}

    return s

def html_quote(block, format):
    return """\
<blockquote>
%s
</blockquote>
""" % (indent_lines(block, format, ' '*4, trailing_newline=False))


for _admon in ['warning', 'question', 'hint', 'notice', 'summary']:
    _Admon = _admon[0].upper() + _admon[1:]  # upper first char
    # Below we could use
    # <img src="data:image/png;base64,iVBORw0KGgoAAAANSUh..."/>
    _text = '''
def html_%s(block, format):
    lyx = """
<table width="95%%%%" border="0">
<tr>
<td width="25" align="center" valign="top">
<img src="https://doconce.googlecode.com/hg/bundled/html_images/lyx_%s.png" hspace="5" alt="%s"></td>
<th align="left" valign="middle"><b>%s</b></th>
</tr>
<tr><td>&nbsp;</td> <td align="left" valign="top"><p>
%%s
</p></td></tr>
</table>
""" %% block
    janko = '<div class="%s">%%s</div>' %% block
    vagrant = '<div class="alert alert-block alert-%s">%%s</div>' %% block
    if option('html-color-admon'):
        return janko
    elif option('html-style=') == 'vagrant':
        return vagrant
    else:
        return lyx
''' % (_admon, _admon, _Admon, _Admon, _admon, _admon)
    exec(_text)

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
           ENVIRS,
           INTRO,
           OUTRO,
           filestr):

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
        'verbatim':      r'\g<begin><code>\g<subst></code>\g<end>',
        'colortext':     r'<font color="\g<color>">\g<text></font>',
        #'linkURL':       r'\g<begin><a href="\g<url>">\g<link></a>\g<end>',
        'linkURL2':      r'<a href="\g<url>">\g<link></a>',
        'linkURL3':      r'<a href="\g<url>">\g<link></a>',
        'linkURL2v':     r'<a href="\g<url>"><tt>\g<link></tt></a>',
        'linkURL3v':     r'<a href="\g<url>"><tt>\g<link></tt></a>',
        'plainURL':      r'<a href="\g<url>"><tt>\g<url></tt></a>',
        'inlinecomment': r'\n<!-- begin inline comment -->\n[<b>\g<name></b>: <em>\g<comment></em>]\n<!-- end inline comment -->\n',
        'chapter':       r'\n<h1>\g<subst></h1>',
        'section':       r'\n<h2>\g<subst></h2>',
        'subsection':    r'\n<h3>\g<subst></h3>',
        'subsubsection': r'\n<h4>\g<subst></h4>\n',
        'paragraph':     r'<b>\g<subst></b>\n',
        'abstract':      r'<b>\g<type>.</b> \g<text>\n\g<rest>',
        'title':         r'\n<title>\g<subst></title>\n\n<center><h1>\g<subst></h1></center>  <!-- document title -->\n',
        'date':          r'<p>\n<center><h4>\g<subst></h4></center> <!-- date -->',
        'author':        html_author,
        'figure':        html_figure,
        'movie':         html_movie,
        'comment':       '<!-- %s -->',
        }

    if option('wordpress'):
        INLINE_TAGS_SUBST['html'].update({
            'math':          r'\g<begin>$latex \g<subst>$\g<end>',
            'math2':         r'\g<begin>$latex \g<latexmath>$\g<end>'
            })

    ENVIRS['html'] = {
        'quote':         html_quote,
        'warning':       html_warning,
        'question':      html_question,
        'notice':        html_notice,
        'hint':          html_hint,
        'summary':       html_summary,
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

    # Embedded style sheets
    if option('html-style=') == 'solarized':
        css = css_solarized
    elif option('html-style=') == 'blueish':
        css = css_blueish
    elif option('html-style=') == 'blueish2':
        css = css_blueish2
    elif option('html-style=') == 'bloodish':
        css = css_bloodish
    else:
        css = css_blueish # default

    # Fonts
    body_font_family = option('html-body-font=', None)
    heading_font_family = option('html-heading-font=', None)
    google_fonts = ('Patrick+Hand+SC', 'Molle:400italic', 'Happy+Monkey',
                    'Roboto+Condensed', 'Fenix', 'Yesteryear',
                    'Clicker+Script', 'Stalemate',
                    'Herr+Von+Muellerhoff', 'Sacramento',
                    'Architects+Daughter', 'Kotta+One',)
    if body_font_family == '?' or body_font_family == 'help' or \
       heading_font_family == '?' or heading_font_family == 'help':
        print ' '.join(google_fonts)
        sys.exit(1)
    link = "@import url(http://fonts.googleapis.com/css?family=%s);"
    import_body_font = ''
    if body_font_family is not None:
        if body_font_family in google_fonts:
            import_body_font = link % body_font_family
    import_heading_font = ''
    if heading_font_family is not None:
        if heading_font_family in google_fonts:
            import_heading_font = link % heading_font_family
    if import_body_font or import_heading_font:
        css = '    ' + '\n    '.join([import_body_font, import_heading_font]) \
              + '\n' + css
    if body_font_family is not None:
        css = re.sub(r'font-family:.+;',
                     "font-family: '%s';" % body_font_family.replace('+', ' '),
                     css)
    if heading_font_family is not None:
        css += "\n    h1, h2, h3 { font-family: '%s'; }\n" % heading_font_family.replace('+', ' ')

    # Need to add admon_styles?
    admons = 'hint', 'notice', 'summary', 'warning', 'question'
    for admon in admons:
        if '!b'+admon in filestr and '!e'+admon in filestr:
            css += admon_styles
            break

    style = """
<style type="text/css">
%s
</style>
""" % css
    css_filename = option('css=')
    if css_filename:
        style = ''
        if ',' in css_filename:
            css_filenames = css_filename.split(',')
        else:
            css_filenames = [css_filename]
        for css_filename in css_filenames:
            if css_filename:
                if not os.path.isfile(css_filename):
                    # Put the style in the file when the file does not exist
                    f = open(css_filename, 'w')
                    f.write(css)
                    f.close()
                style += '<link rel="stylesheet" href="%s">\n' % css_filename

    meta_tags = """\
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="generator" content="Doconce: http://code.google.com/p/doconce/" />
"""
    m = re.search(r'^TITLE: *(.+)$', filestr, flags=re.MULTILINE)
    if m:
        meta_tags += '<meta name="description" content="%s">\n' % \
                     m.group(1).strip()
    keywords = re.findall(r'idx\{(.+?)\}', filestr)
    # idx with verbatim is usually too specialized - remove them
    keywords = [keyword for keyword in keywords
                if not '`' in keyword]
    # keyword!subkeyword -> keyword subkeyword
    keywords = ','.join(keywords).replace('!', ' ')

    if keywords:
        meta_tags += '<meta name="keywords" content="%s">\n' % keywords


    INTRO['html'] = """\
<?xml version="1.0" encoding="utf-8" ?>
<!--
Automatically generated HTML file from Doconce source
(http://code.google.com/p/doconce/)
-->

<html>
<head>
%s

%s
</head>
<body>

    """ % (meta_tags, style)

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
