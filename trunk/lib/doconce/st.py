

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
        'plainURL':  r'"\g<url>":\g<url>',
        # the replacement string differs, depending on the match object m:
        'section':       r'\g<subst>',
        'subsection':    r'\g<subst>',
        'subsubsection': r'\g<subst>',
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'title':         r'TITLE: \g<subst>',
        'date':          r'DATE: \g<subst>',
        'author':        r'By: \g<name>, \g<institution>',
        }

    from rst import rst_code, rst_table
    CODE['st'] = rst_code
    TABLE['st'] = rst_table

    LIST['st'] = {
        'itemize':
        {'begin': '', 'item': '-', 'end': ''},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': ''},

        'description':
        {'begin': '', 'item': '%s -- ', 'end': ''},

        'separator': '',
        }
    from common import DEFAULT_ARGLIST
    ARGLIST['st'] = DEFAULT_ARGLIST
    from plaintext import handle_ref_and_label
    CROSS_REFS['st'] = handle_ref_and_label
    
