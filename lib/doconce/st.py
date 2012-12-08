
from epytext import epytext_author
from common import default_movie, plain_exercise, DEFAULT_ARGLIST

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

    FILENAME_EXTENSION['st'] = '.st'
    BLANKLINE['st'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['st'] = {
        'math':      r'\g<begin>\g<subst>\g<end>',
        'math2':     r'\g<begin>\g<puretext>\g<end>',
        'emphasize': None,
        'bold':      r'\g<begin>**\g<subst>**\g<end>',
        'verbatim':  r"\g<begin>'\g<subst>'\g<end>",
        #'linkURL':   r'\g<begin>"\g<url>":\g<link>\g<end>',
        'linkURL2':  r'"\g<url>":\g<link>',
        'linkURL3':  r'"\g<url>":\g<link>',
        'linkURL2v': r"""\g<url>:'\g<link>'""",
        'linkURL3v': r"""\g<url>:'\g<link>'""",
        'plainURL':  r'"\g<url>":\g<url>',
        # the replacement string differs, depending on the match object m:
        'chapter':       r'\n\g<subst>\n',
        'section':       r'\n\g<subst>\n',
        'subsection':    r'\n\g<subst>\n',
        'subsubsection': r'\n\g<subst>\n',
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'abstract':      r'*\g<type>.* \g<text>\n\g<rest>',
        'title':         r'TITLE: \g<subst>',
        'date':          r'DATE: \g<subst>',
        'author':        epytext_author,
        'movie':         default_movie,
        }

    from rst import rst_code, rst_table
    CODE['st'] = rst_code
    TABLE['st'] = rst_table

    LIST['st'] = {
        'itemize':
        {'begin': '', 'item': '-', 'end': '\n'},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s -- ', 'end': '\n'},

        'separator': '',
        }
    ARGLIST['st'] = DEFAULT_ARGLIST
    from plaintext import plain_ref_and_label, plain_index_bib
    CROSS_REFS['st'] = plain_ref_and_label
    INDEX_BIB['st'] = plain_index_bib
    EXERCISE['st'] = plain_exercise
    TOC['st'] = lambda s: ''  # drop

