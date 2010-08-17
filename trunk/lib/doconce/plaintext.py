
def define(FILENAME_EXTENSION,
           BLANKLINE,
           INLINE_TAGS_SUBST,
           CODE,
           LIST,
           ARGLIST,
           TABLE,
           FIGURE_EXT,
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
        'verbatim':  r'\g<begin>\g<subst>\g<end>',  # no ` chars
        'label':     r'\g<subst>',
        'reference': r'\g<subst>',
        'linkURL':   r'\g<begin>\g<link> (\g<url>)\g<end>',
        'plainURL':  r'\g<url>',
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('utf-8'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst').decode('utf-8'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst').decode('utf-8'))),
        'paragraph':     r'*\g<subst>* '  # extra blank
        }

    from rst import rst_code
    CODE['plain'] = rst_code
    from common import DEFAULT_ARGLIST
    ARGLIST['plain'] = DEFAULT_ARGLIST
    LIST['plain'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': ''},

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': ''},

        'description':
        {'begin': '', 'item': '%s', 'end': ''},

        'separator': '',
        }
    from rst import rst_table
    TABLE['plain'] = rst_table
    #TABLE['plain'] = plain_table


    # no return, rely on in-place modification of dictionaries
