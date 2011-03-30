
from epytext import epytext_author

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

    FILENAME_EXTENSION['st'] = '.st'
    BLANKLINE['st'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['st'] = {
        'math':      r'\g<begin>\g<subst>\g<end>',
        'math2':     r'\g<begin>\g<puretext>\g<end>',
        'emphasize': None,
        'bold':      r'\g<begin>**\g<subst>**\g<end>',
        'verbatim':  r"\g<begin>'\g<subst>'\g<end>",
        'linkURL':   r'\g<begin>"\g<url>":\g<link>\g<end>',
        'linkURL2':  r'"\g<url>":\g<link>',
        'plainURL':  r'"\g<url>":\g<url>',
        # the replacement string differs, depending on the match object m:
        'section':       r'\g<subst>',
        'subsection':    r'\g<subst>',
        'subsubsection': r'\g<subst>',
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'title':         r'TITLE: \g<subst>',
        'date':          r'DATE: \g<subst>',
        'author':        epytext_author,
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
    from common import DEFAULT_ARGLIST
    ARGLIST['st'] = DEFAULT_ARGLIST
    from plaintext import plain_ref_and_label, plain_index_bib
    CROSS_REFS['st'] = plain_ref_and_label
    INDEX_BIB['st'] = plain_index_bib
    
