"""
Warning: This is just a sketch of a possible
translator from doconce to pandoc. Not tested!

See http://johnmacfarlane.net/pandoc/README.html
for syntax.
"""

import re, sys
from common import default_movie

def pandoc_author(authors_and_institutions, auth2index,
                 inst2index, index2inst):
    # List authors on multiple lines
    authors = ';  \n'.join([author + ' and '.join(i)
                            for author, i in authors_and_institutions])
    return '% ' + authors

def pandoc_code(filestr, format):
    defs = dict(cod='Python', pycod='Python', cppcod='Cpp',
                fcod='Fortran', ccod='C', 
                pro='Python', pypro='Python', cpppro='Cpp',
                fpro='Fortran', cpro='C', 
                sys='Bash', dat='Python')
        # (the "python" typesetting is neutral if the text
        # does not parse as python)
    
    for key in defs:
        language = defs[key]
        replacement = '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.%s}' % defs[key]
        #replacement = '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.%s .numberLines}' % defs[key]
        #filestr = re.sub(r'^!bc\s+%s\s*\n' % key, 
        #                 replacement, filestr, flags=re.MULTILINE)
        cpattern = re.compile(r'^!bc\s+%s\s*\n' % key, flags=re.MULTILINE)
        filestr = cpattern.sub(replacement, filestr)
                         
    # any !bc with/without argument becomes a cod (python) block:
    replacement = '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.%s}' % defs['cod']
    #filestr = re.sub(r'^!bc.+\n', replacement, filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^!bc.+$', flags=re.MULTILINE)
    filestr = cpattern.sub(replacement, filestr)

    filestr = re.sub(r'!ec *\n', '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', filestr)
    filestr = re.sub(r'!bt *\n', '\n\n', filestr)
    filestr = re.sub(r'!et *\n', '\n\n', filestr)

    return filestr

def pandoc_ref_and_label(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # Remove label{...} from output (when only label{} on a line, remove
    # the newline too, leave label in figure captions, and remove all the rest)
    #filestr = re.sub(r'^label\{.+?\}\s*$', '', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^label\{.+?\}\s*$', flags=re.MULTILINE)
    filestr = cpattern.sub('', filestr)
    #filestr = re.sub(r'^(FIGURE:.+)label\{(.+?)\}', '\g<1>{\g<2>}', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^(FIGURE:.+)label\{(.+?)\}', flags=re.MULTILINE)
    filestr = cpattern.sub('\g<1>{\g<2>}', filestr)
    filestr = re.sub(r'label\{.+?\}', '', filestr)  # all the remaining

    # Replace all references to sections. Pandoc needs a coding of
    # the section header as link.
    def title2pandoc(title):
        # http://johnmacfarlane.net/pandoc/README.html
        for c in ('?', ';', ':'):
            title = title.replace(c, '')
        title = title.replace(' ', '-').strip()
        start = 0
        for i in range(len(title)):
            if title[i].isalpha():
                start = i
        title = title[start:]
        title = title.lower()
        if not title:
            title = 'section'
        return title
            
    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label,
                  '[%s](#%s)' % (section_label2title[label],
                                 title2pandoc(section_label2title[label])))

    from common import ref2equations
    filestr = ref2equations(filestr)

    return filestr

def bibdict2doconcelist(pyfile, citations):
    """Transform dict with bibliography to a doconce ordered list."""
    # Copy from plaintext.py - no modifications yet for pandoc
    f = open(pyfile, 'r')
    bibstr = f.read()
    try:
        bibdict = eval(bibstr)
    except:
        print 'Error in Python dictionary for bibliography in', pyfile
        sys.exit(1)
    text = '\n\n======= Bibliography =======\n\n'
    for label in citations:
        # remove newlines in reference data:
        text += '  o ' + ' '.join(bibdict[label].splitlines()) + '\n'
    text += '\n\n'
    return text

def pandoc_index_bib(filestr, index, citations, bibfile):
    filestr = filestr.replace('cite{', r'\cite{')
    # The rest here is
    # copied from plaintext.py - no modifications yet for pandoc
    
    if 'py' in bibfile:
        bibtext = bibdict2doconcelist(bibfile['py'], citations)
        #filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, flags=re.MULTILINE)
        cpattern = re.compile(r'^BIBFILE:.+$', flags=re.MULTILINE)
        filestr = cpattern.sub(bibtext, filestr)

    # remove all index entries:
    filestr = re.sub(r'idx\{.+?\}' + '\n?', '', filestr)
    # no index since line numbers from the .do.txt (in index dict)
    # never correspond to the output format file
    #filestr += '\n\n======= Index =======\n\n'
    #for word in index:
    #    filestr + = '%s, line %s\n' % (word, ', '.join(index[word]))

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

    FILENAME_EXTENSION['pandoc'] = '.txt'
    BLANKLINE['pandoc'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['pandoc'] = {
        'math':      None,  # indicates no substitution, leave as is
        'math2':     r'\g<begin>$\g<latexmath>$\g<end>',        
        'emphasize': None,
        'bold':      None,
        'figure':    r'![\g<caption>](\g<filename>)',
        'movie':     default_movie,
        'verbatim':  None,
        'linkURL':   r'\g<begin>\g<link> (\g<url>)\g<end>',
        'linkURL2':  r'[\g<link>](\g<url>)',
        'plainURL':  r'<\g<url>>',
        # Reference links are not yet supported
        'title':     r'% \g<subst>n',
        'author':    pandoc_author,
        'date':      '% ' + r'\g<subst>' + '\n',
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('utf-8'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst').decode('utf-8'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst').decode('utf-8'))),
        'paragraph':     r'*\g<subst>* '  # extra blank
        }

    CODE['pandoc'] = pandoc_code
    from common import DEFAULT_ARGLIST
    ARGLIST['pandoc'] = DEFAULT_ARGLIST
    LIST['pandoc'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': '\n'},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s\n  :   ', 'end': '\n'},

        'separator': '\n',
        }
    CROSS_REFS['pandoc'] = pandoc_ref_and_label

    # Uncertain whether rst_table is suited for pandoc!!
    from rst import rst_table
    TABLE['pandoc'] = rst_table
    #TABLE['pandoc'] = pandoc_table
    INDEX_BIB['pandoc'] = pandoc_index_bib

    # no return, rely on in-place modification of dictionaries
