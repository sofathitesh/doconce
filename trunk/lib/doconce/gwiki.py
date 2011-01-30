"""
Google Code Wiki translator.
Syntax defined by http://code.google.com/p/support/wiki/WikiSyntax
Here called gwiki to make the dialect clear (g for google).
"""


import re, os, commands, sys

def gwiki_code(filestr, format):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'{{{\n', filestr)
    filestr = re.sub(r'!ec\n', r'}}}\n', filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'{{{\n', filestr)
    filestr = re.sub(r'!et\n', r'}}}\n', filestr)
    return filestr

def gwiki_figure(m):
    filename = m.group('filename')
    if not os.path.isfile(filename):
        raise IOError('no figure file %s' % filename)

    basename  = os.path.basename(filename)
    stem, ext = os.path.splitext(basename)
    root, ext = os.path.splitext(filename)
    if not ext in '.png .gif .jpg .jpeg'.split():
        # try to convert image file to PNG, using
        # convert from ImageMagick:
        cmd = 'convert %s png:%s' % (filename, root+'.png')
        failure, output = commands.getstatusoutput(cmd)
        if failure:
            print '\n**** Warning: could not run', cmd
            print 'Convert %s to PNG format manually' % filename
            sys.exit(1)
        filename = root + '.png'
    caption = m.group('caption')
    # keep label if it's there:
    caption = re.sub(r'label\{(.+?)\}', '(\g<1>)', caption)
        
    print """
NOTE: Place %s at some place on the web and edit the
      .gwiki page, either manually (seach for 'Figure: ')
      or use the doconce_gwiki_figsubst.py script:
      doconce_gwiki_figsubst.py mydoc.gwiki URL
""" % filename

    result = r"""

---------------------------------------------------------------

Figure: %s

(the URL of the image file %s must be inserted here)

<wiki:comment> 
Put the figure file %s on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------

""" % (caption, filename, filename)
    return result

from common import table_analysis

def gwiki_table(table):
    """Native gwiki table."""
    # add 2 chars for column width since we add boldface _..._
    # in headlines:
    column_width = [c+2 for c in table_analysis(table)]

    s = '\n'
    for i, row in enumerate(table):
        if row == ['horizontal rule']:
            continue
        if i == 1 and \
           table[i-1] == ['horizontal rule'] and \
           table[i+1] == ['horizontal rule']:
            headline = True
        else:
            headline = False

        for column, w in zip(row, column_width):
            if headline:
                c = ' %s ' % (('_'+ column + '_').center(w))
            else:
                c = ' %s ' % column.ljust(w)
            s += ' || %s ' % c
        s += ' ||\n'
    s += '\n\n'
    return s

def gwiki_author(authors_and_institutions, auth2index, 
                 inst2index, index2inst):
    authors = ['_%s_' % author \
               for author, i in authors_and_institutions]
    if len(authors) ==  1:
        authors = authors[0]
    elif len(authors) == 2:
        authors = authors[0] + ' and ' + authors[1]
    elif len(authors) > 2:
        authors[-1] = 'and ' + authors[-1]
        authors = ', '.join(authors)
    else:
        # no authors:
        return ''
    text = '\n\nBy ' + authors + '\n\n'
    # we skip institutions in gwiki
    return text

def gwiki_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # remove label{...} from output
    filestr = re.sub(r'label\{.+?\}', '', filestr)  # all the remaining

    # anchors in titles do not work...

    # replace all references to sections:
    for label in section_label2title:
        title = section_label2title[label]
        filestr = filestr.replace('ref{%s}' % label,
                                  '[#%s]' % title.replace(' ', '_'))

    from common import ref2equations
    filestr = ref2equations(filestr)

    # replace remaining ref{x} as x
    filestr = re.sub(r'ref\{(.+?)\}', '\g<1>', filestr)

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
    
    FILENAME_EXTENSION['gwiki'] = '.gwiki'  # output file extension
    BLANKLINE['gwiki'] = '\n'

    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['gwiki'] = {
        # use verbatim mode for math:
        'math':          r'\g<begin>`\g<subst>`\g<end>',
        'math2':         r'\g<begin>`\g<puretext>`\g<end>',
        'emphasize':     r'\g<begin>_\g<subst>_\g<end>',
        'bold':          r'\g<begin>*\g<subst>*\g<end>',
        'verbatim':      r'\g<begin>`\g<subst>`\g<end>',
        'linkURL':       r'\g<begin>[\g<url> \g<link>]\g<end>',
        'linkURL2':      r'[\g<url> \g<link>]',
        'plainURL':      r'\g<url>',
        'section':       '\n\n\n' + r'== \g<subst> ==\n',
        'subsection':    '\n\n' + r'=== \g<subst> ===\n',
        'subsubsection': '\n' + r'==== \g<subst> ====\n',
#        'section':       r'++++ \g<subst> ++++',
#        'subsection':    r'++++++ \g<subst> ++++++',
#        'subsubsection': r'++++++++ \g<subst> ++++++++',
        'paragraph':     r'*\g<subst>* ',
        'title':         r'#summary \g<subst>\n<wiki:toc max_depth="2" />',
        'date':          r'===== \g<subst> =====',
        'author':        gwiki_author, #r'===== \g<name>, \g<institution> =====',
#        'figure':        r'<\g<filename>>',
        'figure':        gwiki_figure,
        'comment':       '<wiki:comment> %s </wiki:comment>',
        }

    CODE['gwiki'] = gwiki_code
    from html import html_table
    #TABLE['gwiki'] = html_table
    TABLE['gwiki'] = gwiki_table

    # native list:
    LIST['gwiki'] = {
        'itemize':     {'begin': '\n', 'item': '*', 'end': '\n\n'},
        'enumerate':   {'begin': '\n', 'item': '#', 'end': '\n\n'},
        'description': {'begin': '\n', 'item': '* %s ', 'end': '\n\n'},
        'separator': '\n'}
    # (the \n\n for end is a hack because doconce.p.py avoids writing
    # newline at the end of lists until the next paragraph is hit)
    #LIST['gwiki'] = LIST['HTML']  # does not work well

    
    # how to type set description lists for function arguments, return
    # values, and module/class variables:
    ARGLIST['gwiki'] = {
        'parameter': '*argument*',
        'keyword': '*keyword argument*',
        'return': '*return value(s)*',
        'instance variable': '*instance variable*',
        'class variable': '*class variable*',
        'module variable': '*module variable*',
        }

    FIGURE_EXT['gwiki'] = ('.png', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['gwiki'] = gwiki_ref_and_label
    from plaintext import plain_index_bib
    INDEX_BIB['gwiki'] = plain_index_bib

    # document start:
    INTRO['gwiki'] = ''
    #INTRO['gwiki'] = '#summary YourOneLineSummary\n<wiki:toc max_depth="1" />\n'