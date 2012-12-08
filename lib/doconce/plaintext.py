
import re, sys
from common import default_movie, plain_exercise

def plain_author(authors_and_institutions, auth2index,
                 inst2index, index2inst, auth2email):
    text = '\n'
    for author in auth2index:
        email = auth2email[author]
        email_text = '' if email is None else '(%s)' % email
        text += ' '.join([author, str(auth2index[author]), email_text]) + '\n'
    text += '\n'
    for index in index2inst:
        text += '[%d] %s\n' % (index, index2inst[index])
    text += '\n'
    return text

def plain_ref_and_label(section_label2title, format, filestr):
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
    replacement = r' ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # remove label{...} from output (when only label{} on a line, remove
    # the newline too, leave label in figure captions, and remove all the rest)
    #filestr = re.sub(r'^label\{.+?\}\s*$', '', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^label\{.+?\}\s*$', flags=re.MULTILINE)
    filestr = cpattern.sub('', filestr)
    #filestr = re.sub(r'^(FIGURE:.+)label\{(.+?)\}', '\g<1>{\g<2>}', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^(FIGURE:.+)label\{(.+?)\}', flags=re.MULTILINE)
    filestr = cpattern.sub('\g<1>{\g<2>}', filestr)
    filestr = re.sub(r'label\{.+?\}', '', filestr)  # all the remaining

    # replace all references to sections:
    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label,
                                  '"%s"' % section_label2title[label])

    from common import ref2equations
    filestr = ref2equations(filestr)

    return filestr

def bibdict2doconcelist(pyfile, citations):
    """Transform dict with bibliography to a doconce ordered list."""
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

def plain_index_bib(filestr, index, citations, bibfile):
    for label in citations:
        filestr = filestr.replace('cite{%s}' % label,
                                  '[%d]' % citations[label])
    if 'py' in bibfile:
        bibtext = bibdict2doconcelist(bibfile['py'], citations)
        #filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, flags=re.MULTILINE)
        cpattern = re.compile(r'^BIBFILE:.+$', flags=re.MULTILINE)
        filestr = cpattern.sub(bibtext, filestr)

    # remove all index entries:
    filestr = re.sub(r'idx\{.+?\}\n?', '', filestr)
    # no index since line numbers from the .do.txt (in index dict)
    # never correspond to the output format file
    #filestr += '\n\n======= Index =======\n\n'
    #for word in index:
    #    filestr + = '%s, line %s\n' % (word, ', '.join(index[word]))

    return filestr

def plain_toc(sections):
    # Find minimum section level
    tp_min = 4
    for title, tp, label in sections:
        if tp < tp_min:
            tp_min = tp

    s = 'Table of contents:\n\n'
    for title, tp, label in sections:
        s += ' '*(2*(tp-tp_min)) + title + '\n'
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
           ENVIRS,
           INTRO,
           OUTRO):
    # all arguments are dicts and accept in-place modifications (extensions)

    FILENAME_EXTENSION['plain'] = '.txt'
    BLANKLINE['plain'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['plain'] = {
        'math':      r'\g<begin>\g<subst>\g<end>',  # drop $ signs
        'math2':     r'\g<begin>\g<puretext>\g<end>',
        'emphasize': None,
        'bold':      None,
        'figure':    None,
        'movie':     default_movie,
        'verbatim':  r'\g<begin>\g<subst>\g<end>',  # no ` chars
        #'linkURL':   r'\g<begin>\g<link> (\g<url>)\g<end>',
        'linkURL2':  r'\g<link> (\g<url>)',
        'linkURL3':  r'\g<link> (\g<url>)',
        'linkURL2v': r'\g<link> (\g<url>)',
        'linkURL3v': r'\g<link> (\g<url>)',
        'plainURL':  r'\g<url>',
        'title':     r'======= \g<subst> =======\n',  # doconce top section, to be substituted later
        'author':    plain_author,
        'date':      r'\nDate: \g<subst>\n',
        'chapter':       lambda m: r'\g<subst>\n%s' % ('%'*len(m.group('subst').decode('utf-8'))),
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('utf-8'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst').decode('utf-8'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst').decode('utf-8'))),
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'abstract':      r'\n*\g<type>.* \g<text>\g<rest>',
        }

    from rst import rst_code
    CODE['plain'] = rst_code
    from common import DEFAULT_ARGLIST
    ARGLIST['plain'] = DEFAULT_ARGLIST
    LIST['plain'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': '\n'},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s', 'end': '\n'},

        'separator': '\n',
        }
    CROSS_REFS['plain'] = plain_ref_and_label
    from rst import rst_table
    TABLE['plain'] = rst_table
    #TABLE['plain'] = plain_table
    EXERCISE['plain'] = plain_exercise
    INDEX_BIB['plain'] = plain_index_bib
    TOC['plain'] = plain_toc

    # no return, rely on in-place modification of dictionaries
