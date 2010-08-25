import re, os

# not this one: http://en.wikipedia.org/wiki/Help:Wiki_markup ??

def wiki_code(filestr, format):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'{{{\n', filestr)
    filestr = re.sub(r'!ec\n', r'}}}\n', filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'{{{\n', filestr)
    filestr = re.sub(r'!et\n', r'}}}\n', filestr)
    return filestr

def wiki_reference(m):
    ref = m.group('subst').replace('fig:','')
    refstr = r'[YourWikiPage#Figure_%s %s]' % (ref, ref)
    return refstr

def wiki_figure(m):
    filename = m.group('filename')
    basename  = os.path.basename(filename)
    stem, ext = os.path.splitext(basename)
    root, ext = os.path.splitext(filename)
    if not ext in '.png .gif .jpg .jpeg':
        # try to convert image file to PNG, using
        # convert from ImageMagick:
        cmd = 'convert %s png:%s.png' % (filename, root)
        failure, output = commands.getstatusoutput(cmd)
        if failure:
            print '\n**** Warning: could not run', cmd
        filename = root + '.png'
    result = r"""
======Figure %s======

yourproject.googlecode.com/svn/wiki/%s %s

""" % (stem, filename, m.group('caption'))
    return result

def wiki_table(table):
    s = ''
    for row in table:
        s += '|| '
        for column in row:
            s += '|| %s ||' % column
        s += '\n'
    s += '\n'
    return s

def handle_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # remove label{...} from output
    filestr = re.sub(r'label\{.+?\}', '', filestr)

    # insert anchors (section substitutions are already done)
    for label in section_label2title:
        title = section_label2title[label]
        filestr = re.sub(r'(=+ %s (=+)' % title,
                  r'\g<1> <span id="%s">%s</span> \g<2>' % (label, title),
                  filestr)

    # replace all references to sections:
    for label in section_label2title:
        title = section_label2title[label]
        filestr = filestr.replace('ref{%s}' % label,
                                  '[[#%s|%s]]' % (label, title))

    from common import ref2equations
    filestr = ref2equations(filestr)

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
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)
    
    FILENAME_EXTENSION['wiki'] = '.wiki'  # output file extension
    BLANKLINE['wiki'] = '\n'

    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['wiki'] = {
        #http://chart.apis.google.com/chart?cht=tx&chl={\partial%20u\over\partial%20t}=f&nonsense=test.png
        #http://chart.apis.google.com/chart?cht=tx&chl=\Phi(x)%20=%20\frac1{\sqrt{2\pi}}%20\int_{-\infty}^x%20e^{-u^2/2}%20\,%20du&nonsense=test.png
        # use verbatim mode for math:
        'math':          r'\g<begin>`\g<subst>`\g<end>',
        'math2':         r'\g<begin>`\g<puretext>`\g<end>',
        'emphasize':     r'\g<begin>_\g<subst>_\g<end>',
        'bold':          r'\g<begin>*\g<subst>*\g<end>',
        'verbatim':      r'\g<begin>`\g<subst>`\g<end>',
        'linkURL':       r'\g<begin>[\g<link> | \g<url>]\g<end>',
        'plainURL':      r'[\g<url>]',
#        'section':       r'== \g<subst> ==',
#        'subsection':    r'=== \g<subst> ===',
#        'subsubsection': r'==== \g<subst> ====',
        'section':       r'++++ \g<subst> ++++',
        'subsection':    r'++++++ \g<subst> ++++++',
        'subsubsection': r'++++++++ \g<subst> ++++++++',
        'paragraph':     r'*\g<subst>* ',
        'title':         r'#summary \g<subst>',
        'date':          r'<center><h3>\g<subst></h3></center>',
        'author':        r'<center><h3>\g<name><br>\g<institution></h3></center>',
#        'figure':        r'<\g<filename>>',
        'figure':        wiki_figure,
        'comment':       '<wiki:comment> %s </wiki:comment>',
        }

    CODE['wiki'] = wiki_code
    from html import html_table
    TABLE['wiki'] = html_table

    LIST['wiki'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': ''},

        'enumerate':
        {'begin': '', 'item': '#', 'end': ''},

        'description':
        {'begin': '', 'item': '* %s ', 'end': ''},

        'separator': '', 
        }
    
    # how to type set description lists for function arguments, return
    # values, and module/class variables:
    ARGLIST['wiki'] = {
        'parameter': '*argument*',
        'keyword': '*keyword argument*',
        'return': '*return value(s)*',
        'instance variable': '*instance variable*',
        'class variable': '*class variable*',
        'module variable': '*module variable*',
        }

    FIGURE_EXT['wiki'] = ('.png', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['wiki'] = handle_ref_and_label
    TABLE['wiki'] = wiki_table

    # document start:
    INTRO['wiki'] = '#summary YourOneLineSummary\n'
    INTRO['wiki'] += '<wiki:toc max_depth="1" />\n'
