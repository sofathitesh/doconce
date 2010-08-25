
import re

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

    # replace all references to sections:
    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label,
                                  '"%s"' % section_label2title[label])

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

    FILENAME_EXTENSION['plain'] = '.txt'
    BLANKLINE['plain'] = '\n'
    # replacement patterns for substitutions of inline tags
    INLINE_TAGS_SUBST['plain'] = {
        'math':      r'\g<begin>\g<subst>\g<end>',  # drop $ signs
        'math2':     r'\g<begin>\g<puretext>\g<end>',
        'emphasize': None,
        'bold':      None,
        'verbatim':  r'\g<begin>\g<subst>\g<end>',  # no ` chars
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
    CROSS_REFS['plain'] = handle_ref_and_label
    from rst import rst_table
    TABLE['plain'] = rst_table
    #TABLE['plain'] = plain_table



    # no return, rely on in-place modification of dictionaries
