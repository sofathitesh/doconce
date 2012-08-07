"""
MediaWiki translator, aimed at Wikipedia/WikiBooks type of web pages.
Syntax defined by http://en.wikipedia.org/wiki/Help:Wiki_markup
and http://en.wikipedia.org/wiki/Help:Displaying_a_formula.
The prefix m in the name mwiki distinguishes this translator from
gwiki (googlecode wiki).

Not yet implemented:
mwiki_ref_and_label (just using code from gwiki)

Just using plan ASCII solutions for index_bib (requires some work to
port to MediaWiki, but is straightforward - use rst as template) and
exercise (probably ok with the plain solution).
"""


import re, os, commands, sys
from common import default_movie, plain_exercise, insert_code_and_tex

def mwiki_code(filestr, code_blocks, code_block_types,
               tex_blocks, format):
    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, format)

    # Supported programming languages:
    # http://www.mediawiki.org/wiki/Extension:SyntaxHighlight_GeSHi#Supported_languages
    envir2lang = dict(cod='python', pycod='python', cycod='python',
                      fcod='fortran', ccod='c', cppcod='cpp',
                      mcod='matlab', plcod='perl', shcod='bash',
                      pro='python', pypro='python', cypro='python',
                      fpro='fortran', cpro='c', cpppro='cpp',
                      mpro='matlab', plpro='perl', shpro='bash',
                      sys='bash', dat='python')

    for key in envir2lang:
        language = envir2lang[key]
        cpattern = re.compile(r'^!bc\s+%s\s*\n' % key, flags=re.MULTILINE)
        filestr = cpattern.sub('<syntaxhighlight lang="%s">\n' % \
                               envir2lang[key], filestr)
    c = re.compile(r'^!bc.*$\n', re.MULTILINE)
    filestr = c.sub('<code>\n', filestr)
    filestr = re.sub(r'!ec\n', '</code>\n', filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(':<math>\n', filestr)
    filestr = re.sub(r'!et\n', '</math>\n', filestr)
    return filestr


def mwiki_figure(m):
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
NOTE: Upload image file %s to the Wiki* site
      (see http://en.wikipedia.org/wiki/Special:Upload for Wikipedia)
""" % filename

    result = r"""
[[File:%s|frame|alt=%s|%s]]
""" % (filename, filename, caption)
    return result

from common import table_analysis


def mwiki_author(authors_and_institutions, auth2index,
                 inst2index, index2inst, auth2email):

    authors = []
    for author, i, email in authors_and_institutions:
        if email is None:
            email_text = ''
        else:
            name, adr = email.split('@')
            email_text = ' (%s at %s)' % (name, adr)
        authors.append('_%s_%s' % (author, email_text))

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
    # we skip institutions in mwiki
    return text

def mwiki_ref_and_label(section_label2title, format, filestr):
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
           EXERCISE,
           FIGURE_EXT,
           CROSS_REFS,
           INDEX_BIB,
           TOC,
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)

    FILENAME_EXTENSION['mwiki'] = '.mwiki'  # output file extension
    BLANKLINE['mwiki'] = '\n'

    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['mwiki'] = {
        'math':          r'\g<begin><math>\g<subst></math>\g<end>',
        'math2':         r'\g<begin><math>\g<latexmath></math>\g<end>',
        'emphasize':     r"\g<begin>''\g<subst>''\g<end>",
        'bold':          r"\g<begin>'''\g<subst>'''\g<end>",
        'verbatim':      r'\g<begin><code>\g<subst></code>\g<end>',
        'linkURL':       r'\g<begin>[\g<url> \g<link>]\g<end>',
        'linkURL2':      r'[\g<url> \g<link>]',
        'linkURL3':      r'[\g<url> \g<link>]',
        'linkURL2v':     r'[\g<url> <code>\g<link></code>]',
        'linkURL3v':     r'[\g<url> <code>\g<link></code>]',
        'plainURL':      r'\g<url>',
        'chapter':       '\n\n\n' + r"""== '''\g<subst>''' ==\n""",
        'section':       '\n\n\n' + r'== \g<subst> ==\n',
        'subsection':    '\n\n' + r'=== \g<subst> ===\n',
        'subsubsection': '\n' + r'==== \g<subst> ====\n',
        'paragraph':     r"''\g<subst>'' ",
        'title':         r'#TITLE (actually governed by the filename): \g<subst>\n',
        'date':          r'===== \g<subst> =====',
        'author':        mwiki_author, #r'===== \g<name>, \g<institution> =====',
#        'figure':        r'<\g<filename>>',
        'figure':        mwiki_figure,
        'movie':         default_movie,  # will not work for HTML movie player
        'comment':       '<!--> %s -->',
        'abstract':      r'\n*\g<type>.* \g<text>\g<rest>',
        }

    CODE['mwiki'] = mwiki_code
    from html import html_table
    TABLE['mwiki'] = html_table

    # native list:
    LIST['mwiki'] = {
        'itemize':     {'begin': '\n', 'item': '*', 'end': '\n\n'},
        'enumerate':   {'begin': '\n', 'item': '#', 'end': '\n\n'},
        'description': {'begin': '\n', 'item': '* %s ', 'end': '\n\n'},
        'separator': '\n'}  # problem: requires ** and ## at level 2 etc.
    # Try this!
    LIST['mwiki'] = LIST['html']


    # how to typeset description lists for function arguments, return
    # values, and module/class variables:
    ARGLIST['mwiki'] = {
        'parameter': '*argument*',
        'keyword': '*keyword argument*',
        'return': '*return value(s)*',
        'instance variable': '*instance variable*',
        'class variable': '*class variable*',
        'module variable': '*module variable*',
        }

    FIGURE_EXT['mwiki'] = ('.png', '.gif', '.jpg', '.jpeg')
    CROSS_REFS['mwiki'] = mwiki_ref_and_label
    from plaintext import plain_index_bib
    EXERCISE['mwiki'] = plain_exercise
    INDEX_BIB['mwiki'] = plain_index_bib
    TOC['mwiki'] = lambda s: '__TOC__'

    # document start:
    INTRO['mwiki'] = ''

