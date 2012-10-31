import re, os, sys
from common import remove_code_and_tex, insert_code_and_tex, indent_lines, \
    table_analysis, plain_exercise
from html import html_movie

# replacement patterns for substitutions of inline tags
def rst_figure(m):
    result = ''
    # m is a MatchObject

    caption = m.group('caption').strip()

    # Stubstitute Doconce label by rst label in caption
    # (also, remove final period in caption since caption is used as hyperlink
    # text to figures).

    m_label = re.search(r'label\{(.+?)\}', caption)
    if m_label:
        label = m_label.group(1)
        result += '\n.. _%s:\n' % label
        # remove . at the end of the caption text
        parts = caption.split('label')
        parts[0] = parts[0].rstrip()
        if parts[0] and parts[0][-1] == '.':
            parts[0] = parts[0][:-1]
        # insert emphasize marks
        parts[0] = '*' + parts[0].strip() + '*'
        caption = '  label'.join(parts)
        caption = re.sub(r'label\{(.+?)\}', '(\g<1>)', caption)
    else:
        if caption and caption[-1] == '.':
            caption = caption[:-1]


    filename = m.group('filename')
    if not os.path.isfile(filename):
        #raise IOError('No figure file %s' % filename)
        print 'No figure file %s' % filename
        sys.exit(1)

    result += '\n.. figure:: ' + filename + '\n'  # utilize flexibility
    opts = m.group('options')
    if opts:
        # opts: width=600 frac=0.5 align=center
        # opts: width=600, frac=0.5, align=center
        info = [s.split('=') for s in opts.split()]
        fig_info = ['   :%s: %s' % (option, value.replace(',', ''))
                    for option, value in info if option not in ['frac']]
        result += '\n'.join(fig_info)
    # remove final period in caption since caption is used as hyperlink
    # text to figures
    if caption and caption[-1] == '.':
        caption = caption[:-1]
    if caption:
        result += '\n\n   ' + caption + '\n'
    else:
        result += '\n\n'
    return result

def rst_movie(m):
    html_text = html_movie(m)
    html_text = indent_lines(html_text, 'sphinx')
    rst_text = '.. raw:: html\n' + html_text + '\n\n'
    return rst_text

# these global patterns are used in st, epytext, plaintext as well:
bc_regex_pattern = r'([a-zA-Z0-9)"`.*_}=-^~+])[\n:.?!, ]\s*?^!bc.*?$'
bt_regex_pattern = r'([a-zA-Z0-9)"`.*_}=-^~])[\n:.?!, ]\s*?^!bt.*?$'

def rst_code(filestr, code_blocks, code_block_types,
             tex_blocks, format):
    # In rst syntax, code blocks are typeset with :: (verbatim)
    # followed by intended blocks. This function indents everything
    # inside code (or TeX) blocks.

    for i in range(len(code_blocks)):
        code_blocks[i] = indent_lines(code_blocks[i], format)
    for i in range(len(tex_blocks)):
        tex_blocks[i] = indent_lines(tex_blocks[i], format)

    filestr = insert_code_and_tex(filestr, code_blocks, tex_blocks, 'rst')

    # substitute !bc and !ec appropriately:
    # the line before the !bc block must end in [a-zA-z0-9)"]
    # followed by [\n:.?!,] see the bc_regex_pattern global variable above
    # (problems with substituting !bc and !bt may be caused by
    # missing characters in these two families)
    #c = re.compile(bc_regex_pattern, re.DOTALL)
    c = re.compile(bc_regex_pattern, re.MULTILINE)
    filestr = c.sub(r'\g<1>::\n\n', filestr)
    filestr = re.sub(r'!ec\n', '\n\n', filestr)
    #filestr = re.sub(r'!ec\n', '\n', filestr)
    #filestr = re.sub(r'!ec\n', '', filestr)

    #c = re.compile(r'([a-zA-Z0-9)"])[:.]?\s*?!bt\n', re.DOTALL)
    #filestr = c.sub(r'\g<1>:\n\n', filestr)
    #filestr = re.sub(r'!bt\n', '.. latex-math::\n\n', filestr)
    #filestr = re.sub(r'!bt\n', '.. latex::\n\n', filestr)

    # just use the same substitution as for code blocks:
    c = re.compile(bt_regex_pattern, re.MULTILINE)
    #filestr = c.sub(r'\g<1>::\n\n', filestr)
    filestr = c.sub(r'\g<1>::\n', filestr)
    #filestr = re.sub(r'!et *\n', '\n\n', filestr)
    filestr = re.sub(r'!et *\n', '\n\n', filestr)

    # sphinx math:
    #filestr = re.sub(r'!bt\n', '\n.. math::\n\n', filestr)
    #filestr = re.sub(r'!et\n', '\n\n', filestr)

    #filestr = re.sub(r'!et\n', '\n', filestr)
    #filestr = re.sub(r'!et\n', '', filestr)

    # Fix: if there are !bc-!ec or !bt-!et environments after each
    # other without text in between, there is a difficulty with the
    # :: symbol before the code block. In these cases, we get
    # !ec:: and !et:: from the above substitutions. We just replace
    # these by empty text.
    filestr = filestr.replace('!ec::', '')
    filestr = filestr.replace('!et::', '')

    # Check
    for pattern in '^!bt', '^!et':
        c = re.compile(pattern, re.MULTILINE)
        m = c.search(filestr)
        if m:
            print """
Still %s left after handling of code and tex blocks. Problem is probably
that %s is not preceded by text which can be extended with :: (required).
""" % (pattern, pattern)
            print 'Abort!'
            sys.exit(1)
    return filestr


def rst_table(table):
    # Note: rst and sphinx do not offer alignment of cell
    # entries, everything is always left-adjusted (Nov. 2011)

    # Math in column headings may be significantly expanded and
    # this must be done first
    column_width = table_analysis(table['rows'])
    ncolumns = len(column_width)
    column_spec = table.get('columns_align', 'c'*ncolumns).replace('|', '')
    heading_spec = table.get('headings_align', 'c'*ncolumns).replace('|', '')
    a2py = {'r': 'rjust', 'l': 'ljust', 'c': 'center'}
    s = ''  # '\n'
    for i, row in enumerate(table['rows']):
        #s += '    '  # indentation of tables
        if row == ['horizontal rule']:
            for w in column_width:
                s += '='*w + '  '
        else:
            # check if this is a headline between two horizontal rules:
            if i == 1 and \
               table['rows'][i-1] == ['horizontal rule'] and \
               table['rows'][i+1] == ['horizontal rule']:
                headline = True
            else:
                headline = False

            for w, c, ha, ca in \
                    zip(column_width, row, heading_spec, column_spec):
                if headline:
                    s += getattr(c, a2py[ha])(w) + '  '
                else:
                    s += getattr(c, a2py[ca])(w) + '  '
        s += '\n'
    s += '\n'
    return s

def rst_author(authors_and_institutions, auth2index,
               inst2index, index2inst, auth2email):
    authors = []
    for author, i, email in authors_and_institutions:
        if email:
            email = email.replace('@', ' at ')
            authors.append(author + ' (%s)' % email)
        else:
            authors.append(author)

    text = ':Author: ' + ', '.join(authors) + '\n\n'
    # we skip institutions in rst
    return text

def ref_and_label_commoncode(section_label2title, format, filestr):
    # .... see section ref{my:sec} is replaced by
    # see the section "...section heading..."
    pattern = r'[Ss]ection(s?)\s+ref\{'
    replacement = r'the section\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    pattern = r'[Cc]hapter(s?)\s+ref\{'
    replacement = r'the chapter\g<1> ref{'
    filestr = re.sub(pattern, replacement, filestr)
    # Need special adjustment to handle start of sentence (capital) or not.
    pattern = r'([.?!])\s+the (sections?|captions?)\s+ref'
    replacement = r'\g<1> The \g<2> ref'
    filestr = re.sub(pattern, replacement, filestr)
    # Remove Exercise, Project, Problem in references since those words
    # are used in the title of the section too
    pattern = r'(the\s*)?([Ee]xercises?|[Pp]rojects?|[Pp]roblems?)\s+ref\{'
    replacement = r'ref{'
    filestr = re.sub(pattern, replacement, filestr)

    # Deal with the problem of identical titles, which makes problem
    # with non-unique links in reST: add a counter to the title
    debugtext = ''
    section_pattern = r'^\s*(_{3,9}|={3,9})(.+?)(_{3,9}|={3,9})(\s*label\{(.+?)\})?'
    m = re.findall(section_pattern, filestr, flags=re.MULTILINE)
    # First count the no of titles with the same wording
    titles = {}
    for heading, title, dummy2, dummy3, label in m:
        entry = None if label == '' else label
        if title in titles:
            titles[title].append(entry)
        else:
            titles[title] = [entry]
    # Make new titles
    title_counter = {}   # count repeated titles
    sections = []
    for heading, title, dummy2, dummy3, label in m:
        label = None if label == '' else label
        if len(titles[title]) > 1:
            if title in title_counter:
                title_counter[title] += 1
            else:
                title_counter[title] = 1
            new_title = title + ' (%d) ' % title_counter[title]
            sections.append((heading, new_title, label, title))
            if label in section_label2title:
                section_label2title[label] = new_title
        else:
            sections.append((heading, title, label, title))
    # Make replacements
    for heading, title, label, old_title in sections:
        if title != old_title:
            debugtext += '\nchanged title: %s -> %s\n' % (old_title, title)
        # Avoid trouble with \t, \n in replacement
        title = title.replace('\\', '\\\\')
        # The substitution depends on whether we have a label or not
        if label is not None:
            title_pattern = r'%s\s*%s\s*%s\s*label\{%s\}' % (heading, re.escape(old_title), heading, label)
            # title may contain ? () etc., that's why we take re.escape
            replacement = '.. _%s:\n\n' % label + r'%s %s %s' % \
                          (heading, title, heading)
        else:
            title_pattern = r'%s\s*%s\s*%s' % (heading, re.escape(old_title), heading)
            replacement = r'%s %s %s' % (heading, title, heading)
        filestr, n = re.subn(title_pattern, replacement, filestr, count=1)
        if n > 1:
            raise ValueError('Replaced more than one title. BUG!')

    """[[[
    # Deal with the problem of identical titles, which makes problem
    # with non-unique links in reST: add a counter to the title
    title2label = {}
    for label in section_label2title:
        title = section_label2title[label]
        if title in title2label:
            title2label[title].append(label)
        else:
            title2label[title] = [label]
    problematic_titles = [title for title in title2label \
                          if len(title2label[title]) > 1]
    adjusted_titles = {}
    for title in problematic_titles:
        counter = 1
        for label in title2label[title]:
            # Add counter to non-unique titles (only for rst and sphinx)
            adjusted_titles[(title,label)] = title + ' (%d)' % counter
            counter += 1
    debugtext = '\nProblematic multiple titles:\n%s\nAdjusted titles:\n%s' %\
                (problematic_titles, adjusted_titles)

    # Insert labels before all section headings: (not necessary, but ok)
    for label in section_label2title:
        title = section_label2title[label]
        # Problem: one title can be common to many sections and different
        # labels, making this first regex
        #pattern = r'(_{3,9}|={3,9})(\s*%s\s*)(_{3,9}|={3,9})' % title
        # lead to several rst labels for a title. The remedy consists of
        # two steps: a pattern regex that matches the label too, and
        # adding a counter to titles with the same name (done above)
        pattern = r'(_{3,9}|={3,9})(\s*%s\s*)(_{3,9}|={3,9})\s*label\{%s\}' \
                  % (re.escape(title), label)
        # (title may contain ? () etc., that's why we take re.escape)
        title_new = title.replace('\\', '\\\\')  # avoid trouble with \t, \n
        try:
            title_new = adjusted_titles[(title_new, label)]
            debugtext += 'Found an adjusted title: %s\n' % title_new
        except KeyError:
            pass
        replacement = '.. _%s:\n\n' % label + r'\g<1> %s \g<3>' % \
                      title_new
        filestr, n = re.subn(pattern, replacement, filestr)
        if n == 0:
            #raise Exception('problem with substituting "%s"' % title)
            pass
    # Update label2title mapping with new titles
    for title, label in adjusted_titles:
        section_label2title[label] = adjusted_titles[(title,label)]
    """

    # remove label{...} from output
    #filestr = re.sub(r'^label\{.+?\}\s*$', '', filestr, flags=re.MULTILINE)
    cpattern = re.compile(r'^label\{[^}]+?\}\s*$', flags=re.MULTILINE)
    filestr = cpattern.sub('', filestr)
    filestr = re.sub(r'label\{[^}]+?\}', '', filestr)  # all the remaining

    import doconce
    doconce.debugpr(debugtext)

    return filestr


def rst_ref_and_label(section_label2title, format, filestr):
    filestr = ref_and_label_commoncode(section_label2title, format, filestr)

    # replace all references to sections:
    for label in section_label2title:
        filestr = filestr.replace('ref{%s}' % label,
                                  '`%s`_' % section_label2title[label])

    from common import ref2equations
    filestr = ref2equations(filestr)
    # replace remaining ref{x} as x_
    filestr = re.sub(r'ref\{(.+?)\}', '`\g<1>`_', filestr)

    return filestr

def rst_bib(filestr, citations, bibfile):
    for label in citations:
        filestr = filestr.replace('cite{%s}' % label, '[%s]_' % label)
    if 'rst' in bibfile:
        f = open(bibfile['rst'], 'r');  bibtext = f.read();  f.close()
        #filestr = re.sub(r'^BIBFILE:.+$', bibtext, filestr, flags=re.MULTILINE)
        cpattern = re.compile(r'^BIBFILE:.+$', re.MULTILINE)
        filestr = cpattern.sub(bibtext, filestr)
    return filestr

def rst_index_bib(filestr, index, citations, bibfile):
    filestr = rst_bib(filestr, citations, bibfile)

    # reStructuredText does not have index/glossary
    filestr = re.sub(r'idx\{.+?\}\n?', '', filestr)

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

    FILENAME_EXTENSION['rst'] = '.rst'
    BLANKLINE['rst'] = '\n'

    INLINE_TAGS_SUBST['rst'] = {
        'math':      r'\g<begin>\g<subst>\g<end>',
        'math2':     r'\g<begin>\g<puretext>\g<end>',
        #'math':      r'\g<begin>:math:`\g<subst>`\g<end>',  # sphinx
        #'math2':     r'\g<begin>:math:`\g<latexmath>`\g<end>',
        'emphasize': None,  # => just use doconce markup (*emphasized words*)
        'bold':      r'\g<begin>**\g<subst>**\g<end>',
        'verbatim':  r'\g<begin>``\g<subst>``\g<end>',
        'label':     r'\g<subst>',  # should be improved, rst has cross ref
        'reference': r'\g<subst>',
        #'linkURL':   r'\g<begin>`\g<link> <\g<url>>`_\g<end>',
        #'linkURL':   r'\g<begin>`\g<link>`_\g<end>' + '\n\n.. ' + r'_\g<link>: \g<url>' + '\n\n',  # better (?): make function instead that stacks up the URLs and dumps them at the end; can be used for citations as well
        'linkURL2':  r'`\g<link> <\g<url>>`_',
        'linkURL3':  r'`\g<link> <\g<url>>`_',
        'linkURL2v': r'`\g<link> <\g<url>>`_', # no verbatim, does not work well
        'linkURL3v': r'`\g<link> <\g<url>>`_', # with triple backticks...
        'plainURL':  r'`<\g<url>>`_',
        'inlinecomment': r'(**\g<name>**: \g<comment>)',
        # the replacement string differs, depending on the match object m:
        # (note len(m.group('subst')) gives wrong length for non-ascii strings,
        # better with m.group('subst').decode('utf-8')) or latin-1
        #'section':    lambda m: r'\g<subst>' + '\n%s' % ('-'*len(m.group('subst').decode('utf-8'))),
        # note: r'\g<subst>\n%s' also works fine ?), despite being different...
        # (it just works in substitution...)
        'chapter':       lambda m: r'\g<subst>\n%s' % ('%'*len(m.group('subst').decode('latin-1'))),
        'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('latin-1'))),
        #'section':       lambda m: r'\g<subst>\n%s' % ('='*len(m.group('subst').decode('latin-1'))),
        'subsection':    lambda m: r'\g<subst>\n%s' % ('-'*len(m.group('subst').decode('latin-1'))),
        'subsubsection': lambda m: r'\g<subst>\n%s' % ('~'*len(m.group('subst').decode('latin-1'))),
        'paragraph':     r'*\g<subst>* ',  # extra blank
        'abstract':      r'\n*\g<type>.* \g<text>\n\g<rest>',
        'title':         r'======= \g<subst> =======\n',  # doconce top section, is later replaced
        'date':          r':Date: \g<subst>\n',
        'author':        rst_author,
        'figure':        rst_figure,
        'movie':         rst_movie,
        #'comment':       '.. %s',  # rst does not like empty comment lines:
        # so therefore we introduce a function to remove empty comment lines
        'comment':       lambda c: '' if c.isspace() or c == '' else '.. %s\n' % c
        }

    CODE['rst'] = rst_code  # function for typesetting code

    LIST['rst'] = {
        'itemize':
        {'begin': '', 'item': '*', 'end': '\n'},
        # lists must end with a blank line - we insert one extra,

        'enumerate':
        {'begin': '', 'item': '%d.', 'end': '\n'},

        'description':
        {'begin': '', 'item': '%s', 'end': '\n'},

        'separator': '\n',
        }
    from common import DEFAULT_ARGLIST
    ARGLIST['rst'] = DEFAULT_ARGLIST
    FIGURE_EXT['rst'] = ('.png', '.gif', '.jpg', '.jpeg', '.pdf', '.eps', '.ps')
    CROSS_REFS['rst'] = rst_ref_and_label
    INDEX_BIB['rst'] = rst_index_bib

    TABLE['rst'] = rst_table
    EXERCISE['rst'] = plain_exercise
    TOC['rst'] = lambda s: '.. contents:: Table of Contents\n   :depth: 2'
    INTRO['rst'] = """\
.. Automatically generated reST file from Doconce source
   (http://code.google.com/p/doconce/)

"""
