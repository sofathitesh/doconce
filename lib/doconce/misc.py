import os, sys, shutil, re, glob, sets, time

_registered_command_line_options = [
    ('--help',
     'Print all options to the doconce program.'),
    ('--debug',
     'Write a debugging file _doconce_debugging.log with lots if intermediate results'),
    ('--no-abort',
     'Do not abort the execution if syntax errors are found.'),
    ('--skip_inline_comments',
     'Remove all inline comments of the form [ID: comment].'),
    ('--encoding=',
     'Specify encoding (e.g., latin1 or utf-8).'),
    ('--oneline_paragraphs',
     'Combine paragraphs to one line (does not work well).'),
    ('--no-mako',
     'Do not run the Mako preprocessor program.'),
    ('--no-preprocess',
     'Do not run the Preprocess preprocessor program.'),
    ('--no-pygments-html',
     """Do not use pygments to typeset computer code in HTML,
use plain <pre> tags."""),
    ('--minted-latex-style=',
     'Specify the minted style to be used for typesetting code in LaTeX.'),
    ('--pygments-html-style=',
     'Specify the minted style to be used for typesetting code in HTML.'),
    ('--pygments-html-linenos',
     """Turn on line numbers in pygmentized computer code in HTML.
(In LaTeX line numbers can be added via doconce subst or replace
such that the verbatim environments become like
\begin{minted}[...,linenos=true,...].)"""),
    ('--html-style=',
     'Name of theme for HTML style (solarized, vagrant, ...).'),
    ('--html-template=',
     """Specify an HTML template with header/footer in which the doconce
document is embedded."""),
    ('--html-slide-theme=',
     """Specify a theme for the present slide type.
(See the HTML header for a list of theme files and their names."""),
    ('--latex-printed',
     """True if the LaTeX output is to be printed on paper such that links
will not work (the full URL of links then appear as footnotes)."""),
    ('--latex-preamble=',
     """User-provided LaTeX preamble file, either complete or additions."""),
    ('--html-color-admon',
     """True if color admon images are to be used in notice, warning, etc.
environments, otherwise simpler (lyx_*.png) files are used."""),
    ('--css=',
     """Specify a .css style file for HTML output.
(If the file does not exist, a default style is written to it."""),
    ('--verbose',
     'Write out all OS commands run by doconce.'),
    ('--examples-as-exercises',
     'Treat examples of the form "==== Example: ..." like exercise environments.'),
    ('--without-solutions',
     'Leave out solution environments from exercises.'),
    ('--without-answers',
     'Leave out answer environments from exercises.'),
    ('--without-hints',
     'Leave out hints from exercises.'),
    ('--wordpress',
     'Make HTML output for wordpress pages.'),
    ]

_legal_command_line_options = \
      [opt for opt, help in _registered_command_line_options]

def get_legal_command_line_options():
    """Return list of legal command-line options."""
    return _legal_command_line_options

def option(name, default=None):
    """
    Return value of command-line option with the given name.
    If name ends with = (``--name=value``), return the value,
    otherwise return True or False whether the option ``--name``
    is found or not. If default is provided, this value is returned
    in case the option was not found.
    """
    # Note: Do not use fancy command-line parsers as much functionality
    # is dependent on command-line info (preprocessor options for instance)
    # that is not compatible with simple options( --name).
    name = '--' + name
    if not name in _legal_command_line_options:
        print 'test for illegal option:', name
        print 'Abort!'
        sys.exit(1)
    if name.endswith('='):
        for arg in sys.argv[1:]:
            if arg.startswith(name):
                opt, value = arg.split('=')
                return value
        return default
    else:
        return (name in sys.argv)


def system(cmd, abort_on_failure=True, verbose=False, failure_info=''):
    """
    Run OS command cmd.
    If abort_on_failure: abort when cmd gives failure and print
    command and failure_info (to explain what the command does).
    If verbose: print cmd.
    """
    if verbose or '--verbose' in sys.argv:
        print 'running', cmd
    failure = os.system(cmd)
    if failure:
        print 'could not run', cmd, failure_info
        if abort_on_failure:
            print 'Abort!'
            sys.exit(1)

def recommended_html_styles_and_pygments_styles():
    """
    List good combinations of HTML slide styles and
    pygments styles for typesetting code.
    """
    combinations = {
        'deck': {
        'neon': ['fruity', 'native'],
        'sandstone.aurora': ['fruity'],
        'sandstone.dark': ['native', 'fruity'],
        'sandstone.mdn': ['fruity'],
        'sandstone.mightly': ['fruity'],
        'beamer': ['autumn', 'perldoc', 'manni', 'default', 'emacs'],
        'mnml': ['default', 'autumn', 'manni', 'emacs'],
        'sandstone.firefox': ['default', 'manni', 'autumn', 'emacs'],
        'sandstone.default': ['perldoc', 'autumn', 'manni', 'default'],
        'sandstone.light': ['emacs', 'autumn'],  # purple
        'swiss': ['autumn', 'default', 'perldoc', 'manni', 'emacs'],
        'web-2.0': ['autumn', 'default', 'perldoc', 'emacs'],
        },
        'reveal': {
        'beige': ['perldoc',],
        'beigesmall': ['perldoc',],
        'simple': ['autumn', 'default', 'perldoc'],
        'sky': ['default'],
        'night': ['fruity', 'native'],
        'darkgray': ['native', 'monokai'],
        'serif': ['perldoc'],
        },
        'csss': {
        'csss_default': ['monokai'],
        },
        'dzslides': {
        'dzslides_default': ['autumn', 'default'],
        },
        'html5slides': {
        'template-default': ['autumn', 'default'],
        'template-io2011': ['autumn', 'default'],
        }
        }
    return combinations

# ------------- functions used by the doconce program -------------

def remove_inline_comments():
    try:
        filename = sys.argv[1]
    except IndexError:
        print 'Usage: doconce remove_inline_comments myfile.do.txt'
        sys.exit(1)

    shutil.copy(filename, filename + '.old~~')
    f = open(filename, 'r')
    filestr = f.read()
    f.close()
    import doconce
    filestr = doconce.doconce.subst_away_inline_comments(filestr)
    f = open(filename, 'w')
    f.write(filestr)
    f.close()
    print 'inline comments removed in', filename

def latin2html():
    """
    Substitute latin characters by their equivalent HTML encoding
    in an HTML file. See doconce.html.latin2html for more
    documentation.
    """
    from doconce.html import latin2html
    import os, shutil, sys
    for filename in sys.argv[1:]:
        if not os.path.isfile(filename):
            continue
        oldfilename = filename + '.old~'
        shutil.copy(filename, oldfilename)
        print 'transformin latin characters to HTML encoding in', filename
        f = open(oldfilename, 'r')
        try:
            text = f.read()
            newtext = latin2html(text)
            f.close()
            f = open(filename, 'w')
            f.write(newtext)
            f.close()
        except Exception, e:
            print e.__class__.__name__, ':', e,

def gwiki_figsubst():
    try:
        gwikifile = sys.argv[1]
        URLstem = sys.argv[2]
    except IndexError:
        print 'Usage: %s wikifile URL-stem' % sys.argv[0]
        print 'Ex:    %s somefile.gwiki http://code.google.com/p/myproject/trunk/doc/somedir' % sys.argv[0]
        sys.exit(1)

    # first grep out all filenames with local path:
    shutil.copy(gwikifile, gwikifile + '.old~~')
    f = open(gwikifile, 'r')
    fstr = f.read()
    f.close()

    pattern = r'\(the URL of the image file (.+?) must be inserted here\)'
    #figfiles = re.findall(pattern, fstr)
    replacement = r'%s/\g<1>' % URLstem
    fstr, n = re.subn(pattern, replacement, fstr)
    pattern = re.compile(r'<wiki:comment>\s+Put the figure file .*?</wiki:comment>', re.DOTALL)
    fstr, n2 = pattern.subn('', fstr)
    f = open(gwikifile, 'w')
    f.write(fstr)
    f.close()
    print 'Replaced %d figure references in' % n, gwikifile
    if n != n2:
        print 'Something strange: %d fig references and %g comments... Bug.' % \
              (n, n2)



# subst is taken from scitools
def _usage_subst():
    print 'Usage: doconce subst [-s -m -x --restore] pattern '\
          'replacement file1 file2 file3 ...'
    print '--restore brings back the backup files'
    print '-s is the re.DOTALL or re.S modifier'
    print '-m is the re.MULTILINE or re.M modifier'
    print '-x is the re.VERBODE or re.X modifier'

def _scitools_subst(patterns, replacements, filenames,
                    pattern_matching_modifiers=0):
    """
    Replace a set of patterns by a set of replacement strings (regular
    expressions) in a series of files.
    The function essentially performs::

      for filename in filenames:
          file_string = open(filename, 'r').read()
          for pattern, replacement in zip(patterns, replacements):
              file_string = re.sub(pattern, replacement, file_string)

    A copy of the original file is taken, with extension `.old~`.
    """
    # if some arguments are strings, convert them to lists:
    if isinstance(patterns, basestring):
        patterns = [patterns]
    if isinstance(replacements, basestring):
        replacements = [replacements]
    if isinstance(filenames, basestring):
        filenames = [filenames]

    # pre-compile patterns:
    cpatterns = [re.compile(pattern, pattern_matching_modifiers) \
                 for pattern in patterns]
    modified_files = dict([(p,[]) for p in patterns])  # init
    messages = []   # for return info

    for filename in filenames:
        if not os.path.isfile(filename):
            raise IOError('%s is not a file!' % filename)
        f = open(filename, 'r');
        filestr = f.read()
        f.close()

        for pattern, cpattern, replacement in \
            zip(patterns, cpatterns, replacements):
            if cpattern.search(filestr):
                filestr = cpattern.sub(replacement, filestr)
                shutil.copy2(filename, filename + '.old~') # backup
                f = open(filename, 'w')
                f.write(filestr)
                f.close()
                modified_files[pattern].append(filename)

    # make a readable return string with substitution info:
    for pattern in sorted(modified_files):
        if modified_files[pattern]:
            replacement = replacements[patterns.index(pattern)]
            messages.append('%s replaced by %s in %s' % \
                                (pattern, replacement,
                                 ', '.join(modified_files[pattern])))

    return ', '.join(messages) if messages else 'no substitutions'

def wildcard_notation(files):
    """
    On Unix, a command-line argument like *.py is expanded
    by the shell. This is not done on Windows, where we must
    use glob.glob inside Python. This function provides a
    uniform solution.
    """
    if isinstance(files, basestring):
        files = [files]  # ensure list when single filename is given
    if sys.platform[:3] == 'win':
        import glob, operator
        filelist = [glob.glob(arg) for arg in files]
        files = reduce(operator.add, filelist)  # flatten
    return files

def subst():
    if len(sys.argv) < 3:
        _usage_subst()
        sys.exit(1)

    from getopt import getopt
    optlist, args = getopt(sys.argv[1:], 'smx', ['restore'])
    if not args:
        print 'no filename(s) given'
        sys.exit(1)

    restore = False
    pmm = 0  # pattern matching modifiers (re.compile flags)
    for opt, value in optlist:
        if opt in ('-s',):
            if not pmm:  pmm = re.DOTALL
            else:        pmm = pmm|re.DOTALL
        if opt in ('-m',):
            if not pmm:  pmm = re.MULTILINE
            else:        pmm = pmm|re.MULTILINE
        if opt in ('-x',):
            if not pmm:  pmm = re.VERBOSE
            else:        pmm = pmm|re.VERBOSE
        if opt in ('--restore',):
            restore = True

    if restore:
        for oldfile in args:
            newfile = re.sub(r'\.old~$', '', oldfile)
            if not os.path.isfile(oldfile):
                print '%s is not a file!' % oldfile; continue
            os.rename(oldfile, newfile)
            print 'restoring %s as %s' % (oldfile,newfile)
    else:
        pattern = args[0]; replacement = args[1]
        s = _scitools_subst(pattern, replacement,
                            wildcard_notation(args[2:]), pmm)
        print s  # print info about substitutions

# replace is taken from scitools
def _usage_replace():
    print 'Usage: doconce replace from-text to-text file1 file2 ...'

def replace():
    if len(sys.argv) < 4:
        _usage_replace()
        sys.exit(1)

    from_text = sys.argv[1]
    to_text = sys.argv[2]
    filenames = wildcard_notation(sys.argv[3:])
    for filename in filenames:
        f = open(filename, 'r')
        text = f.read()
        f.close()
        if from_text in text:
            backup_filename = filename + '.old~~'
            shutil.copy(filename, backup_filename)
            print 'replacing %s by %s in' % (from_text, to_text), filename
            text = text.replace(from_text, to_text)
            f = open(filename, 'w')
            f.write(text)
            f.close()

def _usage_replace_from_file():
    print 'Usage: doconce replace_from_file file-with-from-to file1 file2 ...'

def replace_from_file():
    """
    Replace one set of words by another set of words in a series
    of files. The set of words are stored in a file (given on
    the command line). The data format of the file is

    word replacement-word
    word
    # possible comment line, recognized by starting with #
    word
    word replacement-word

    That is, there are either one or two words on each line. In case
    of two words, the first is to be replaced by the second.
    (This format fits well with the output of list_labels.)
    """
    if len(sys.argv) < 3:
        _usage_replace_from_file()
        sys.exit(1)

    fromto_file = sys.argv[1]
    f = open(fromto_file, 'r')
    fromto_lines = f.readlines()
    f.close()

    filenames = wildcard_notation(sys.argv[2:])

    for filename in filenames:
        f = open(filename, 'r')
        text = f.read()
        f.close()
        replacements = False
        for line in fromto_lines:
            if line.startswith('#'):
                continue
            words = line.split()
            if len(words) == 2:
                from_text, to_text = words

                if from_text in text:
                    backup_filename = filename + '.old~~'
                    shutil.copy(filename, backup_filename)
                    print 'replacing %s by %s in' % (from_text, to_text), filename
                    text = text.replace(from_text, to_text)
                    replacements = True
        if replacements:
            f = open(filename, 'w')
            f.write(text)
            f.close()

def _dofix_localURLs(filename, exclude_adr):
    if os.path.splitext(filename)[1] != '.rst':
        print 'Wrong filename extension in "%s" - must be a .rst file' \
              % filename
        sys.exit(1)

    f = open(filename, 'r')
    text = f.read()
    f.close()
    """
    # This is for doconce format:
    link1 = r'''"(?P<link>[^"]+?)" ?:\s*"(?P<url>([^"]+?\.html?|[^"]+?\.txt|[^"]+?\.pdf|[^"]+?\.f|[^"]+?\.c|[^"]+?\.cpp|[^"]+?\.cxx|[^"]+?\.py|[^"]+?\.java|[^"]+?\.pl))"'''
    link2 = r'("URL"|"url"|URL|url) ?:\s*"(?P<url>.+?)"'
    groups1 = [(link, url) for link, url, url in re.findall(link1, text)]
    print groups1
    print groups2
    """
    link_pattern = r'<([A-Za-z0-9/._-]+?)>`_'
    links = re.findall(link_pattern, text)
    num_fixed_links = 0
    for link in links:
        if link in exclude_adr:
            print 'not modifying', link
            if link.endswith('htm') or link.endswith('html'):
                print 'Note: %s\n      is an HTML file that may link to other files.\n      This may require copying many files! Better: link to _static directly in the doconce document.' % link
            continue
        if not (link.startswith('http') or link.startswith('file:/') or \
            link.startswith('_static')):
            if os.path.isfile(link):
                if not os.path.isdir('_static'):
                    os.mkdir('_static')
                newlink = os.path.join('_static', os.path.basename(link))
                text = text.replace('<%s>' % link, '<%s>' % newlink)
                print 'fixing link to %s as link to %s' % \
                      (link, newlink)
                print '       copying %s to _static' % os.path.basename(link)
                shutil.copy(link, newlink)
                if link.endswith('htm') or link.endswith('html'):
                    print 'Note: %s\n      is an HTML file that may link to other files.\n      This may require copying many files! Better: link to _static directly in the doconce document.' % link
                num_fixed_links += 1
    if num_fixed_links > 0:
        os.rename(filename, filename + 'old~~')
        f = open(filename, 'w')
        f.write(text)
        f.close()
    return num_fixed_links


def _usage_sphinxfix_localURLs():
    print """\
Usage: doconce sphinxfix_localURLs file1.rst file2.rst ... -not adr1 adr2 ...

Each link to a local file, e.g., "link": "src/dir1/myfile.txt",
is replaced by a link to the file placed in _static:
"link": "_static/myfile.txt". The file myfile.txt is copied
from src/dir1 to _static. The user must later copy all _static/*
files to the _static subdirectory in the sphinx directory.
Note that local links to files in _static are not modified.

The modification of links is not always wanted. The -not adr1 adr2 makes
it possible to exclude modification of a set of addresses adr1, adr2, ...

Example: doconce sphinxfix_localURLs file1.rst file2.rst \
         -not src/dir1/mymod1.py src/dir2/index.html

The old files are available as file1.rst.old~~, file2.rst.old~~ etc.

Note that local links to HTML files which are linked to other local HTML
documents (say a Sphinx document) demand all relevant files to be
copied to _static. In such cases it is best to physically place
the HTML documents in _static and let the Doconce document link
directly to _static.

In general, it is better to link to _static from the Doconce document
rather than relying on the fixes in this script...
"""

def sphinxfix_localURLs():
    if len(sys.argv) < 2:
        _usage_sphinxfix_localURLs()
        sys.exit(1)

    # Find addresses to exclude
    idx = -1  # index in sys.argv for the -not option
    for i, arg in enumerate(sys.argv[1:]):
        if arg.endswith('-not'):
            idx = i+1
    exclude_adr = sys.argv[idx+1:] if idx > 0 else []
    if idx > 0:
       del sys.argv[idx:]

    for filename in sys.argv[1:]:
        if os.path.dirname(filename) != '':
            print 'doconce sphinxfix_localURLs must be run from the same directory as %s is located in' % filename
        num_fixed_links = _dofix_localURLs(filename, exclude_adr)
        if num_fixed_links > 0:
            print "\nYou must copy _static/* to the sphinx directory's _static directory"


def _usage_latex_exercise_toc():
    print 'Usage: doconce latex_exercise_toc myfile.do.txt ["List of exercises"]'
    print """
Can insert
# Short: My own short title
in the text of an exercise and this defines a short version of the
title of the exercise to be used in the toc table.
This is convenient when the automatic truncation of (long) titles
fails (happens if truncated in the middle of mathematical $...$
constructions). Any short title is appearing in the table exactly
how it is written, so this is also a method to avoid truncating
a title.
"""

def latex_exercise_toc():
    if len(sys.argv) < 2:
        _usage_latex_exercise_toc()
        sys.exit(1)
    dofile = sys.argv[1]
    if dofile.endswith('.do.txt'):
        dofile = dofile[:-7]
    exerfile = '.' + dofile + '.exerinfo'
    if not os.path.isfile(exerfile):
        print 'no file %s with exercises from %s found' % (exerfile, dofile)
        return

    f = open(exerfile, 'r')
    exer = eval(f.read())
    f.close()

    try:
        heading = sys.argv[2]
    except IndexError:
        # Build default heading from types of environments found
        import sets
        types_of_exer = sets.Set()
        for ex in exer:
            if ex['type'] != 'Example':
                types_of_exer.add(ex['type'])
        types_of_exer = list(types_of_exer)
        types_of_exer = ['%ss' % tp for tp in types_of_exer]  # plural
        types_of_exer = [tp for tp in sorted(types_of_exer)]  # alphabetic order
        if len(types_of_exer) == 1:
            types_of_exer = types_of_exer[0]
        elif len(types_of_exer) == 2:
            types_of_exer = ' and '.join(types_of_exer)
        elif len(types_of_exer) > 2:
            types_of_exer[-1] = 'and ' + types_of_exer[-1]
            types_of_exer = ', '.join(types_of_exer)
        heading = "List of %s" % types_of_exer
    latex = r"""
\subsection*{%s}
\\begin{tabular}{lrll}
""" % heading
    max_title_length = 45
    for ex in exer:
        if ex['type'] == 'Example':
            continue
        title = ex['title']
        # Short title?
        short = ''
        for line in ex['text'].splitlines():
            m = re.search(r'#\s*[Ss]hort:\s*(.+)', line)
            if m:
                short = m.group(1).strip()
                title = short
                break
        if not short:
            # Truncate long titles
            if len(title) > max_title_length:
                words = title.split()
                title = []
                for word in words:
                    title.append(word)
                    if len(' '.join(title)) > max_title_length - 5:
                        title.append('...')
                        break
                title = ' '.join(title)
        title = title.replace('\\', '\\\\') # re.sub later swallows \
        latex += ex['type'] + ' & ' + str(ex['no']) + ' & ' + title
        if ex['label']:
            latex += r' & p.~\pageref{%s}' % ex['label']
        else:
            # Leave pageref empty
            latex += ' &'
        latex += ' \\\\\\\\' + '\n'
        # (need 8 \ for \\ to survive because re.sub below eats them)
    latex += r"""\end{tabular}
% --- end of table of exercises

"""
    ptexfile = dofile + '.p.tex'
    f = open(ptexfile, 'r')
    shutil.copy(ptexfile, ptexfile + '.old~~')
    filestr = f.read()
    f.close()
    if r'\tableofcontents' in filestr:
        # Insert table of exercises on the next line
        filestr = re.sub(r'(tableofcontents.*$)', '\g<1>\n' + latex,
                         filestr, flags=re.MULTILINE)
        f = open(ptexfile, 'w')
        f.write(filestr)
        print 'table of exercises inserted in', ptexfile
        f.close()
    else:
        print 'cannot insert table of exercises because there is no'
        print 'table of contents requested in the', dofile, 'document'


def _usage_combine_images():
    print 'Usage: doconce combine_images image1 image2 ... output_file'
    print 'Use montage if not PDF or EPS images, else use'
    print 'pdftk, pdfnup and pdfcrop.'

def combine_images():

    if len(sys.argv) < 3:
        _usage_combine_images()
        sys.exit(1)

    remove_options_from_command_line()

    imagefiles = sys.argv[1:-1]
    output_file = sys.argv[-1]
    ext = [os.path.splitext(f)[1] for f in imagefiles]
    formats = '.png', '.tif.', '.tiff', '.gif', '.jpeg', 'jpg'
    montage = False
    # If one of the formats in formats: montage = True
    for format in formats:
        if format in ext:
            montage = True

    cmds = []
    if montage:
        cmds.append('montage -background white -geometry 100%% -tile 2x %s %s' % \
                    (' '.join(imagefiles), output_file))
        cmds.append('convert -trim %s %s' % (output_file, output_file))

    else:
        # Assume all are .pdf or .eps
        # Convert EPS to PDF
        for i in range(len(imagefiles)):
            f = imagefiles[i]
            if '.eps' in f:
                cmds.append('ps2pdf -DEPSCrop %s' % f)
                imagefiles[i] = f.replace('.eps', '.pdf')

        # Combine PDF images
        rows = int(round(len(imagefiles)/2.))
        cmds.append('pdftk %s output tmp.pdf' % ' '.join(imagefiles))
        cmds.append('pdfnup --nup 2x%d tmp.pdf' % rows)
        cmds.append('pdfcrop tmp-nup.pdf')
        cmds.append('cp tmp-nup-crop.pdf %s' % output_file)
        cmds.append('rm -f tmp.pdf tmp-nup.pdf tmp-nup-crop.pdf')
    print
    for cmd in cmds:
        system(cmd, verbose=True)
    print 'output in', output_file


def _usage_expand_commands():
    print 'Usage: doconce expand_commands file1 file2 ...'
    print """
A file .expand_commands may define _replace and _regex_subst lists
for str.replace and re.sub substitutions (respectively) to be applied
to file1 file2 ...

By default we use some common LaTeX math abbreviations:
_replace = [
(r'\bals', r'\begin{align*}'),  # must appear before \bal
(r'\eals', r'\end{align*}'),
(r'\bal', r'\begin{align}'),
(r'\eal', r'\end{align}'),
(r'\beq', r'\begin{equation}'),
(r'\eeq', r'\end{equation}'),
]

_regex_subst = []
"""

def expand_commands():
    if len(sys.argv) < 2:
        _usage_expand_commands()
        sys.exit(1)

    # Default set of str.replace and re.sub substitutions
    _replace = [
    (r'\bals', r'\begin{align*}'),  # must appear before \bal
    (r'\eals', r'\end{align*}'),
    (r'\bal', r'\begin{align}'),
    (r'\eal', r'\end{align}'),
    (r'\beq', r'\begin{equation}'),
    (r'\eeq', r'\end{equation}'),
    ]

    # These \ep subst don't work properly
    _regex_subst = [
    (r'^\ep\n', r'\\thinspace .\n', re.MULTILINE),
    (r'\ep\n', r' \\thinspace .\n'),
    (r'\ep\s*\\\]', r' \\thinspace . \]'),
    (r'\ep\s*\\e', r' \\thinspace . \e'),
    (r' \\thinspace', 'thinspace'),
    ]
    _regex_subst = []

    expand_commands_file = '.expand_commands'
    if os.path.isfile(expand_commands_file):
        execfile(expand_commands_file)
    else:
        replace = []
        regex_subst = []
    # Add standard definitions (above)
    replace += _replace
    regex_subst += _regex_subst

    filenames = sys.argv[1:]
    for filename in filenames:
        changed = False
        f = open(filename, 'r')
        text = f.read()
        f.close()
        for from_, to_ in replace:
            if from_ in text:
                text = text.replace(from_, to_)
                print 'replacing %s by %s in %s' % (from_, to_, filename)
                changed = True
        for item in regex_subst:
            if len(item) == 2:
                from_, to_ = item
                if re.search(from_, text):
                    text = re.sub(from_, to_, text)
                    print 'substituting %s by %s in %s' % (from_, to_, filename)
                    changed = True
            elif len(item) == 3:
                frm_, to_, modifier = item
                if re.search(from_, text, flags=modifier):
                    text = re.sub(from_, to_, text, flags=modifier)
                    print 'substituting %s by %s in %s' % (from_, to_, filename)
                    changed = True
        if changed:
            shutil.copy(filename, filename + '.old~~')
            f = open(filename, 'w')
            f.write(text)
            f.close()



def _usage_ptex2tex():
    print r"""\
Usage: doconce ptex2tex [file | file.p.tex] [-Dvar1=val1 ...] \
       [cod=\begin{quote}\begin{verbatim}@\end{verbatim}\end{quote} \
        pypro=Verbatim fcod=minted ccod=ans cpppro=anslistings:nt]'

or
       doconce ptex2tex file -Dvar1=val1 ... envir=ans:nt

or
       doconce ptex2tex file sys=\begin{Verbatim}[frame=lines,label=\fbox{{\tiny Terminal}},framesep=2.5mm,framerule=0.7pt]@\end{Verbatim} envir=minted

or

       doconce ptex2tex file envir=Verbatim

Here the Verbatim (from fancyvrb) is used for all environments, with
some options added (base linestretch 0.85 and font size 9pt).

The last command is equivalent to the default

   doconce ptex2tex


Note that specifications of how "!bc environment" is to be typeset
in latex is done by environment=begin@end, where begin is the latex
begin command, end is the latex end command, and the two must
be separated by the at sign (@). Writing just environment=package implies
the latex commands \begin{package} and \end{package}.

Choosing environment=minted gives the minted environment with
the specified language inserted. Similarly, environment=ans,
environment=ans:nt, environment=anslistings, or environment=anslistings:nt
imply the anslistings package with the right environment
(\begin{c++:nt} for instance for !bc cppcod or !bc cpppro,
environment=ans:nt - :nt means no title over the code box).

If environment is simply the string "envir", the value applies to all
registered environments. Specifying (e.g.) sys=... and then envir=ans,
will substitute the sys environment by the specified syntax and all
other environments will apply the latex construct from anslistings.sty.
"""

def ptex2tex():
    if len(sys.argv) <= 1:
        _usage_ptex2tex()
        sys.exit(1)

    # All envirs in the .ptex2tex.cfg file as of June 2012.
    # (Recall that the longest names must come first so that they
    # are substituted first, e.g., \bcc after \bccod)
    envirs = 'pro pypro cypro cpppro cpro fpro plpro shpro mpro cod pycod cycod cppcod ccod fcod plcod shcod mcod rst cppans pyans fans bashans swigans uflans sni dat dsni sys slin ipy rpy plin ver warn rule summ ccq cc ccl py'.split()

    # Process command-line options

    preprocess_options = []  # -Dvariable or -Dvariable=value
    envir_user_spec = []     # user's specified environments
    for arg in sys.argv[1:]:
        if arg.startswith('-D') or arg.startswith('-U'):
            preprocess_options.append(arg)
        elif '=' in arg:
            items = arg.split('=')
            envir, value = items[0], '='.join(items[1:])
            if '@' in value:
                begin, end = value.split('@')

                if envir == 'envir':
                    # User specifies all ptex2tex environments at once
                    # as "envir=begin@end"
                    for e in envirs:
                        envir_user_spec.append((e, begin, end))
                else:
                    envir_user_spec.append((envir, begin, end))
            else:
                # Fix value=minted and value=ans*:
                # they need the language explicitly
                if value == 'minted':
                    languages = dict(py='python', cy='cython', f='fortran',
                                     c='c', cpp='c++', sh='bash', rst='rst',
                                     m ='matlab', pl='perl', swig='c++',
                                     latex='latex', html='html', js='js',
                                     xml='xml')
                    if envir == 'envir':
                        for lang in languages:
                            begin = '\\' + 'begin{minted}[fontsize=\\fontsize{9pt}{9pt},linenos=false,mathescape,baselinestretch=1.0,fontfamily=tt,xleftmargin=7mm]{' \
                                    + languages[lang] + '}'
                            end = '\\' + 'end{minted}'
                            envir_user_spec.append((lang+'cod', begin, end))
                            envir_user_spec.append((lang+'pro', begin, end))
                    else:
                        for lang in languages:
                            if envir == lang + 'cod' or envir == lang + 'pro':
                                begin = '\\' + 'begin{' + value + '}{' \
                                        + languages[lang] + '}'
                                end = '\\' + 'end{' + value + '}'
                                envir_user_spec.append((envir, begin, end))
                elif value.startswith('ans'):
                    languages = dict(py='python', cy='python', f='fortran',
                                     cpp='c++', sh='bash', swig='swigcode',
                                     ufl='uflcode', m='matlab', c='c++',
                                     latex='latexcode', xml='xml')
                    if envir == 'envir':
                        for lang in languages:
                            language = languages[lang]
                            if value.endswith(':nt'):
                                language += ':nt'
                            begin = '\\' + 'begin{' + language + '}'
                            end = '\\' + 'end{' + language + '}'
                            envir_user_spec.append((lang+'cod', begin, end))
                            envir_user_spec.append((lang+'pro', begin, end))
                    else:
                        for lang in languages:
                            if envir == lang + 'cod' or envir == lang + 'pro':
                                lang = languages[lang]
                                if value.endswith(':nt'):
                                    lang += ':nt'
                                begin = '\\' + 'begin{' + lang + '}'
                                end = '\\' + 'end{' + lang + '}'
                                envir_user_spec.append((envir, begin, end))
                else:
                    # value is not minted or ans*
                    options = ''
                    if value == 'Verbatim':
                        # provide lots of options
                        options = r'[numbers=none,fontsize=\fontsize{9pt}{9pt},baselinestretch=0.85,xleftmargin=0mm]'

                    begin = '\\' + 'begin{' + value + '}' + options
                    end = '\\' + 'end{' + value + '}'
                    if envir == 'envir':
                        for e in envirs:
                            envir_user_spec.append((e, begin, end))
                    else:
                        envir_user_spec.append((envir, begin, end))
        else:
            filename = arg

    try:
        filename
    except:
        print 'no specification of the .p.tex file'
        sys.exit(1)

    # Find which environments that will be defined and which
    # latex packages that must be included.

    ans = ['c++', 'c', 'fortran', 'python', 'cython', 'xml',
           'bash', 'swigcode', 'uflcode', 'matlab', 'progoutput',
           'latexcode', 'anycode']
    ans = ans + [i+':nt' for i in ans]
    package2envir = dict(fancyvrb='Verbatim', anslistings=ans, minted='minted')
    latexenvir2package = {}
    for package in package2envir:

        if isinstance(package2envir[package], list):
            for latexenvir in package2envir[package]:
                latexenvir2package[latexenvir] = package
        else: # str
            latexenvir2package[package2envir[package]] = package
    #print 'envir_user_spec:' #
    #import pprint; pprint.pprint(envir_user_spec)
    #print 'latex2envir2package:'; pprint.pprint(latexenvir2package)
    # Run through user's specifications and grab latexenvir from
    # end = \end{latexenvir}, find corresponding package and add to set
    import sets
    packages = sets.Set()
    for envir, begin, end in envir_user_spec:
        m = re.search(r'\\end\{(.+?)\}', end)
        if m:
            latexenvir = m.group(1)
            if latexenvir in latexenvir2package:
                packages.add(latexenvir2package[latexenvir])
            else:
                print 'No package known for latex environment "%s" ' % latexenvir
    packages = list(packages)
    # fancyvrb is needed for \code{...} -> \Verb!...! translation
    if not 'fancyvrb' in packages:
        packages.append('fancyvrb')

    #print 'packages:';  pprint.pprint(packages)

    if filename.endswith('.p.tex'):
        filename = filename[:-6]

    # Run preprocess
    if not preprocess_options:
        #preprocess_options += ['-DLATEX_HEADING=traditional']
        if 'minted' in packages:
            preprocess_options += ['-DMINTED']

    if not os.path.isfile(filename + '.p.tex'):
        print 'No file %s' % (filename + '.p.tex')
        sys.exit(1)

    output_filename = filename + '.tex'
    cmd = 'preprocess %s %s > %s' % \
          (' '.join(preprocess_options),
           filename + '.p.tex',
           output_filename)
    system(cmd, failure_info="""
preprocess failed or is not installed;
download preprocess from http://code.google.com/p/preprocess""")

    # Mimic ptex2tex by replacing all code environments by
    # a plain verbatim command
    f = open(output_filename, 'r')
    filestr = f.read()
    f.close()

    # Replace the environments specified by the user
    for envir, begin, end in envir_user_spec:
        ptex2tex_begin = '\\' + 'b' + envir
        ptex2tex_end = '\\' + 'e' + envir
        if ptex2tex_begin in filestr:
            filestr = filestr.replace(ptex2tex_begin, begin)
            filestr = filestr.replace(ptex2tex_end, end)
            print '%s (!bc %s) -> %s' % (ptex2tex_begin, envir, begin)

    # Replace other known ptex2tex environments by a default choice
    begin = r"""\begin{Verbatim}[numbers=none,fontsize=\fontsize{9pt}{9pt},baselinestretch=0.85]"""
    end = r"""\end{Verbatim}"""
    #begin = r"""\begin{quote}\begin{verbatim}"""
    #end = r"""\end{verbatim}\end{quote}"""
    for envir in envirs:
        ptex2tex_begin = '\\' + 'b' + envir
        ptex2tex_end = '\\' + 'e' + envir
        if ptex2tex_begin in filestr:
            filestr = filestr.replace(ptex2tex_begin, begin)
            filestr = filestr.replace(ptex2tex_end, end)
            print '%s (!bc %s) -> %s' % (ptex2tex_begin, envir, begin)

    # Make sure we include the necessary verbatim packages
    if packages:
        filestr = filestr.replace(r'\usepackage{ptex2tex}',
           r'\usepackage{%s} %% packages needed for verbatim environments' %
                                          (','.join(packages)))
    else:
        filestr = filestr.replace(r'\usepackage{ptex2tex}', '')

    # Copy less well-known latex packages to the current directory
    # if the packages are not found on the (Unix) system
    import commands
    for style in ['minted', 'anslistings', 'fancyvrb']:
        if style in packages:
            failure, output = commands.getstatusoutput('kpsewhich %s.sty' % style)
            if output == '':
                # Copy style.sty to current dir
                filename = style + '.sty'
                datafile = latexstyle_files  # global variable (latex_styles.zip)
                if not os.path.isfile(filename):
                    import doconce
                    doconce_dir = os.path.dirname(doconce.__file__)
                    doconce_datafile = os.path.join(doconce_dir, datafile)
                    shutil.copy(doconce_datafile, os.curdir)
                    import zipfile
                    zipfile.ZipFile(datafile).extract(filename)
                    print 'extracted %s (from %s in the doconce installation)' % (filename, latexstyle_files)
                    os.remove(datafile)

    if 'minted' in packages:
        failure, output = commands.getstatusoutput('pygmentize')
        if failure:
            print 'You have requested the minted latex style, but this'
            print 'requires the pygments package to be installed. On Debian/Ubuntu: run'
            print 'Terminal> sudo apt-get install python-pygments'
            sys.exit(1)

    # --- Treat the \code{} commands ---

    # Remove one newline (two implies far too long inline verbatim)
    pattern = re.compile(r'\\code\{([^\n}]*?)\n(.*?)\}', re.DOTALL)
    # (this pattern does not handle \code{...} with internal } AND \n!)
    filestr = pattern.sub(r'\code{\g<1> \g<2>}', filestr)
    verb_command = 'Verb'  # requires fancyvrb package, otherwise use std 'verb'

    cpattern = re.compile(r"""\\code\{(.*?)\}([ \n,.;:?!)"'-])""", re.DOTALL)
    filestr = cpattern.sub(r'\\%s!\g<1>!\g<2>' % verb_command, filestr)

    '''
    # If fontsize is part of the \Verb command (which is not wise, since
    # explicit fontsize is not suitable for section headings),
    # first handle combination of \protect and \code
    fontsize = 10          # should be configurable from the command line
    cpattern = re.compile(r"""\\protect\s*\\code\{(.*?)\}([ \n,.;:?!)"'-])""", re.DOTALL)
    filestr = cpattern.sub(r'{\\fontsize{%spt}{%spt}\protect\\%s!\g<1>!}\g<2>' %
                           (fontsize, fontsize, verb_command), filestr)
    # Handle ordinary \code
    cpattern = re.compile(r"""\\code\{(.*?)\}([ \n,.;:?!)"'-])""", re.DOTALL)
    filestr = cpattern.sub(r'{\\fontsize{%spt}{%spt}\\%s!\g<1>!}\g<2>' %
                           (fontsize, fontsize, verb_command), filestr)
    '''
    f = open(output_filename, 'w')
    f.write(filestr)
    f.close()
    print 'output in', output_filename


def _usage_grab():
    print 'Usage: doconce grab --from[-] from-text [--to[-] to-text] file'

def grab():
    """
    Grab a portion of text from a file, starting with from-text
    (included if specified as --from, not included if specified
    via --from-) up to the first occurence of to-text (--to implies
    that the last line is included, --to- excludes the last line).
    If --to[-] is not specified, all text up to the end of the file
    is returned.

    from-text and to-text are specified as regular expressions.
    """
    if len(sys.argv) < 4:
        _usage_grab()
        sys.exit(1)

    filename = sys.argv[-1]
    if not sys.argv[1].startswith('--from'):
        print 'missing --from fromtext or --from- fromtext option on the command line'
        sys.exit(1)
    from_included = sys.argv[1] == '--from'
    from_text = sys.argv[2]

    # Treat --to

    # impossible text (has newlines) that will never be found
    # is used as to-text if this is not specified
    impossible_text = '@\n\n@'
    try:
        to_included = sys.argv[3] == '--to'
        to_text = sys.argv[4]
    except IndexError:
        to_included = True
        to_text = impossible_text

    from_found = False
    to_found = False
    copy = False
    lines = []  # grabbed lines
    for line in open(filename, 'r'):
        m_from = re.search(from_text, line)
        m_to = re.search(to_text, line)
        if m_from and not from_found:
            copy = True
            from_found = True
            if from_included:
                lines.append(line)
        elif m_to:
            copy = False
            to_found = True
            if to_included:
                lines.append(line)
        elif copy:
            lines.append(line)
    if not from_found:
        print 'Could not find match for from regex "%s"' % from_text
        sys.exit(1)
    if not to_found and to_text != impossible_text:
        print 'Could not find match for to   regex "%s"' % to_text
        sys.exit(1)
    print ''.join(lines).rstrip()

def remove_text(filestr, from_text, from_included, to_text, to_included):
    """
    Remove a portion of text from the string filestr.
    See remove() for explanation of arguments.
    """
    impossible_text = '@\n\n@'  # must be compatible with remove()

    from_found = False
    to_found = False
    remove = False
    lines = []  # survived lines
    for line in filestr.splitlines():
        m_from = re.search(from_text, line)
        m_to = re.search(to_text, line)
        if m_from:
            remove = True
            from_found = True
            if not from_included:
                lines.append(line)
        elif m_to:
            remove = False
            to_found = True
            if not to_included:
                lines.append(line)
        elif not remove:
            lines.append(line)

    return '\n'.join(lines).rstrip() + '\n', from_found, to_found

def _usage_remove():
    print 'Usage: doconce remove --from[-] from-text [--to[-] to-text] file'

def remove():
    """
    Remove a portion of text from a file, starting with from-text
    (included if specified as --from, not included if specified
    via --from-) up to the first occurence of to-text (--to implies
    that the last line is included, --to- excludes the last line).
    If --to[-] is not specified, all text up to the end of the file
    is returned.

    from-text and to-text are specified as regular expressions.
    """
    if len(sys.argv) < 4:
        _usage_remove()
        sys.exit(1)

    filename = sys.argv[-1]
    f = open(filename, 'r')
    filestr = f.read()
    f.close()

    if not sys.argv[1].startswith('--from'):
        print 'missing --from fromtext or --from- fromtext option on the command line'
        sys.exit(1)
    from_included = sys.argv[1] == '--from'
    from_text = sys.argv[2]

    # Treat --to

    # impossible text (has newlines) that will never be found
    # is used as to-text if this is not specified
    impossible_text = '@\n\n@'
    try:
        to_included = sys.argv[3] == '--to'
        to_text = sys.argv[4]
    except IndexError:
        to_included = True
        to_text = impossible_text

    filestr, from_found, to_found = remove_text(
        filestr, from_text, from_included, to_text, to_included)

    if not from_found:
        print 'Could not find match for from regex "%s"' % from_text
        sys.exit(1)
    if not to_found and to_text != impossible_text:
        print 'Could not find match for to   regex "%s"' % to_text
        sys.exit(1)

    os.rename(filename, filename + '.old~~')
    f = open(filename, 'w')
    f.write(filestr)
    f.close()

def _usage_remove_exercise_answers():
    print 'Usage: doconce remove_exercise_answers file_in_some_format'

def remove_exercise_answers():
    if len(sys.argv) < 2:
        _usage_remove_exercise_answers()
        sys.exit(1)

    filename = sys.argv[1]
    f = open(filename, 'r')
    filestr = f.read()
    f.close()

    envirs = ['solution of exercise', 'short answer in exercise']
    from_texts = [r'--- begin ' + envir for envir in envirs]
    to_texts = [r'--- end ' + envir for envir in envirs]
    for from_text, to_text in zip(from_texts, to_texts):
        filestr, from_found, to_found = remove_text(
            filestr, from_text, True, to_text, True)
    if from_found and to_found:
        pass
    else:
        print 'no answers/solutions to exercises found in', filename

    os.rename(filename, filename + '.old~~')
    f = open(filename, 'w')
    f.write(filestr)
    f.close()


def clean():
    """
    Remove all Doconce generated files and trash files.
    Place removed files in generated subdir Trash.

    For example, if ``d1.do.txt`` and ``d2.do.txt`` are found,
    all files ``d1.*`` and ``d1.*`` are deleted, except when ``*``
    is ``.do.txt`` or ``.sh``. The subdirectories ``sphinx-rootdir``
    and ``html_images`` are also removed, as well as all ``._part*.html``,
    ``*~`` and ``tmp*`` files.
    """
    if os.path.isdir('Trash'):
        print
        shutil.rmtree('Trash')
        print 'Removing Trash directory'
    removed = []

    trash_files = '_doconce_debugging.log', '__tmp.do.txt', 'texput.log'
    for trash_file in trash_files:
        if os.path.isfile(trash_file):
            removed.append(trash_file)

    doconce_files = glob.glob('*.do.txt')
    for dof in doconce_files:
        namestem = dof[:-7]
        generated_files = glob.glob(namestem + '.*')
        extensions_to_keep = '.sh', '.do.txt'
        #print 'generated_files:', namestem + '.*', generated_files
        for ext in extensions_to_keep:
            filename = namestem + ext
            if os.path.isfile(filename):
                generated_files.remove(filename)
        for f in generated_files:
            removed.append(f)
    removed.extend(glob.glob('*~') + glob.glob('tmp*') +
                   glob.glob('._part*.html') + glob.glob('.*.exerinfo') +
                   glob.glob('.*_html_file_collection'))
    directories = ['sphinx-rootdir', 'html_images']
    for d in directories:
        if os.path.isdir(d):
            removed.append(d)
    if removed:
        print 'Remove:', ' '.join(removed), '(-> Trash)'
        os.mkdir('Trash')
        for f in removed:
            try:
                shutil.move(f, 'Trash')
            except shutil.Error, e:
                if 'already exists' in str(e):
                    pass
                else:
                    print 'Move problems with', f, e
            if os.path.isdir(f):
                shutil.rmtree(f)

def _usage_guess_encoding():
    print 'Usage: doconce guess_encoding filename'

def _encoding_guesser(filename, verbose=False):
    """Try to guess the encoding of a file."""
    f = open(filename, 'r')
    text = f.read()
    f.close()
    encodings = ['ascii', 'us-ascii', 'iso-8859-1', 'iso-8859-2',
                 'iso-8859-3', 'iso-8859-4', 'cp37', 'cp930', 'cp1047',
                 'utf-8', 'utf-16', 'windows-1250', 'windows-1252',]
    for encoding in encodings:
        try:
            if verbose:
                print 'Trying encoding', encoding, 'with unicode(text, encoding)'
            unicode(text, encoding, "strict")
        except Exception, e:
            if verbose:
                print 'failed:', e
        else:
            break
    return encoding

def guess_encoding():
    if len(sys.argv) != 2:
        _usage_guess_encoding()
        sys.exit(1)
    filename = sys.argv[1]
    print _encoding_guesser(filename, verbose=False)

def _usage_change_encoding():
    print 'Usage: doconce change_encoding from-encoding to-encoding file1 file2 ...'
    print 'Example: doconce change_encoding utf-8 latin1 myfile.do.txt'

def _change_encoding_unix(filename, from_enc, to_enc):
    backupfile = filename + '.old~~'
    if sys.platform == 'linux2':
        cmd = 'iconv -f %s -t %s %s --output %s' % \
              (from_enc, to_enc, backupfile, filename)
    elif sys.platform == 'darwin':
        cmd = 'iconv -f %s -t %s %s > %s' % \
              (from_enc, to_enc, backupfile, filename)
    else:
        print 'Changing encoding is not implemented on Windows machines'
        sys.exit(1)
    os.rename(filename, backupfile)
    system(cmd)

def _change_encoding_python(filename, from_enc, to_enc):
    f = codecs.open(filename, 'r', from_enc)
    text = f.read()
    f.close()
    f = codecs.open(filename, 'w', to_enc)
    f.write(text)
    f.close()

def change_encoding():
    if len(sys.argv) < 4:
        _usage_change_encoding()
        sys.exit(1)

    from_encoding = sys.argv[1]
    to_encoding = sys.argv[2]
    filenames = wildcard_notation(sys.argv[3:])
    for filename in filenames:
        _change_encoding_unix(filename, from_encoding, to_encoding)
        # Perhaps better alternative with pure Python:
        #_change_encoding_python(filename, from_encoding, to_encoding)


def _usage_bbl2rst():
    print 'Usage: doconce bbl2rst file.bbl'

def bbl2rst():
    """
    Very simple function for helping to covert a .bbl latex
    file to reST bibliography syntax.
    A much more complete solution converting bibtex to reST
    is found in the bib2rst.py script in doconce/bin.
    """
    if len(sys.argv) <= 1:
        _usage_bbl2rst()
        sys.exit(1)

    bblfile = sys.argv[1]
    text = open(bblfile, 'r').read()
    pattern = r'\\bibitem\{(.+)\}' + '\n'
    text = re.sub(pattern, r'.. [\g<1>] ', text)
    text = text.replace(r'\newblock ', '')
    text = text.replace('~', ' ')
    pattern = r'\{\\em (.+?)\}'
    text = re.sub(pattern, r'*\g<1>*', text)
    text = text.replace('\\', '')
    text = re.sub(r'(\d)--(\d)', r'\1-\2', text)
    lines = []
    for line in text.splitlines():
        line = line.strip()
        if 'thebibliography' in line:
            continue
        elif line[:2] == '..':
            lines.append(line + '\n')
        else:
            lines.append('   ' + line  + '\n')

    outfile = bblfile[:-4] + '_bib.rst'
    f = open(outfile, 'w')
    f.writelines(lines)
    f.close()
    print 'reStructuredText bibliography in', outfile

    # Could continue with the .py file
    outfile = bblfile[:-4] + '_bib.py'
    f = open(outfile, 'w')
    f.write('{')
    first_entry = True
    label_pattern = r'\.\. \[(.*?)\] ([A-Za-z].+$)'
    for line in lines:
        m = re.search(label_pattern, line)
        if m:
            label = m.group(1).strip()
            restline = m.group(2).strip()
            if not first_entry:
                f.write('""",\n\n')
            f.write(''''%s': """\n%s\n''' % (label, restline))
            first_entry = False
        else:
            f.write(line.lstrip())
    f.write('""",\n}\n')
    f.close()
    print 'Python bibliography in', outfile


html_images = 'html_images.zip'
reveal_files = 'reveal.js.zip'
csss_files = 'csss.zip'
deck_files = 'deck.js.zip'
latexstyle_files = 'latex_styles.zip'

def html_imagefile(imagename):
    filename = os.path.join(html_images[:-4], imagename + '.png')
    return filename

def copy_datafiles(datafile):
    """
    Get a doconce datafile, ``files.zip`` or ``files.tar.gz``, to
    the current directory and pack it out unless the subdirectory
    ``files`` exists.
    """
    if datafile.endswith('.zip'):
        subdir = datafile[:-4]
        import zipfile
        uncompressor = zipfile.ZipFile
    elif datafile.endswith('.tar.gz'):
        subdir = datafile[:-7]
        import tarfile
        uncompressor = tarfile.TarFile
    if not os.path.isdir(subdir):
        import doconce
        doconce_dir = os.path.dirname(doconce.__file__)
        doconce_datafile = os.path.join(doconce_dir, datafile)
        shutil.copy(doconce_datafile, os.curdir)
        uncompressor(datafile).extractall()
        print 'made subdirectory', subdir
        os.remove(datafile)
        return True
    else:
        return False


def _usage_html_colorbullets():
    print 'Usage: doconce html_colorbullets mydoc.html'

def html_colorbullets():
    # A much better implementation, avoiding tables, is given
    # here: http://www.eng.buffalo.edu/webguide/Bullet_Lists.html
    """
    Replace unordered lists by a table, in order to replace
    ``<li>`` tags (and the default bullets) by
    images of balls with colors.
    """
    if len(sys.argv) <= 1:
        _usage_html_collorbullets()
        sys.exit(1)

    red_bullet = 'red_bullet2'
    green_bullet = 'green_bullet2'
    #red_bullet = 'red_bullet1'
    #green_bullet = 'green_bullet1'

    filenames = sys.argv[1:]
    for filename in filenames:
        f = open(filename, 'r')
        text = f.read()
        f.close()
        #if '<li>' in text:
        #    copy_datafiles(html_images)  # copy html_images subdir if needed
        lines = text.splitlines()
        f = open(filename, 'w')
        level = 0
        for line in lines:
            linel = line.lower()
            if '<ul>' in linel:
                level += 1
                line = '<table border="0">\n'
            if '</ul>' in linel:
                line = '</td></tr></table>\n'
                level -= 1
            if '<li>' in linel:
                line = line.replace('<li>', """</tr><p><tr><td valign='top'><img src="BULLET"></td><td>""")
                if level == 1:
                    #image_filename = html_imagefile(red_bullet)
                    image_filename = 'https://doconce.googlecode.com/hg/bundled/html_images/' + red_bullet
                elif level >= 2:
                    #image_filename = html_imagefile(green_bullet)
                    image_filename = 'https://doconce.googlecode.com/hg/bundled/html_images/' + green_bullet
                line = line.replace('BULLET', image_filename)
            f.write(line + '\n')
        f.close()

def _usage_split_html():
    print 'Usage: doconce split_html mydoc.html'

def split_html():
    """
    Split html file into parts. Use !split command as separator between
    parts.
    """
    if len(sys.argv) <= 1:
        _usage_split_html()
        sys.exit(1)

    filename = sys.argv[1]
    if not filename.endswith('.html'):
        basename = filename
        filename += '.html'
    else:
        basename = filename[:-5]

    header, parts, footer = get_header_parts_footer(filename, "html")
    files = doconce_html_split(header, parts, footer, basename, filename)
    print '%s now links to the generated files' % filename
    print ', '.join(files)


def _usage_slides_html():
    print 'Usage: doconce slides_html mydoc.html slide_type --html-slide-theme=themename [--reveal-doconce]'
    print 'slide_types: reveal|reveal.js deck|deck.js csss dzslides'
    print '--reveal-doconce applies doconce versions of themes (left-adjusted)'
    print 'or:    doconce slides_html mydoc.html all  (generate a lot)'

def slides_html():
    """
    Split html file into slides and typeset slides using
    various tools. Use !split command as slide separator.
    """
    # Overview: http://www.impressivewebs.com/html-slidedeck-toolkits/
    # Overview: http://www.sitepoint.com/5-free-html5-presentation-systems/
    # x http://leaverou.github.com/CSSS/
    # x http://lab.hakim.se/reveal-js/ (easy and fancy)
    # x http://paulrouget.com/dzslides/ (easy and fancy, Keynote like)
    # http://imakewebthings.com/deck.js/ (also easy)
    # http://code.google.com/p/html5slides/ (also easy)
    # http://slides.seld.be/?file=2010-05-30+Example.html#1 (also easy)
    # http://www.w3.org/Talks/Tools/Slidy2/#(1) (also easy)
    # http://johnpolacek.github.com/scrolldeck.js/ (inspired by reveal.js)
    # http://meyerweb.com/eric/tools/s5/ (easy)
    # https://github.com/mbostock/stack (very easy)
    # https://github.com/markdalgleish/fathom
    # http://shama.github.com/jmpress.js/#/home  # jQuery version of impress
    # https://github.com/bartaz/impress.js/

    # Fancy and instructive demo:
    # http://yihui.name/slides/2011-r-dev-lessons.html
    # (view the source code)

    # pandoc can make dzslides and embeds all javascript (no other files needed)
    # pandoc -s -S -i -t dzslides --mathjax my.md -o my.html

    # Could introduce !btabXY to define elements in a slide that will
    # appear in position XY in a table! Works after split_html on a
    # page by page basis (split is more general and should be factored out).
    # Figures without caption must not have number (think that is in place).

    if len(sys.argv) <= 2:
        _usage_slides_html()
        sys.exit(1)

    filename = sys.argv[1]
    if not filename.endswith('.html'):
        filename += '.html'
    if not os.path.isfile(filename):
        print 'doconce file in html format, %s, does not exist - abort' % filename
        sys.exit(1)
    basename = os.path.basename(filename)
    filestem = os.path.splitext(basename)[0]

    slide_type = sys.argv[2]

    # Treat the special case of generating a script for generating
    # all the different slide versions that are supported
    if slide_type == 'all':
         #from doconce.misc import recommended_html_styles_and_pygments_styles
         r = recommended_html_styles_and_pygments_styles()
         f = open('tmp_slides_html_all.sh', 'w')
         f.write('#!/bin/sh\n\n')
         f.write('doconce format html %s\ndoconce slides_html %s doconce\n\n' %
                 (filestem, filestem))
         for sl_tp in r:
             for style in r[sl_tp]:
                 pygm_style = r[sl_tp][style][0]
                 f.write('doconce format html %s --pygments-html-style=%s\ndoconce slides_html %s %s --html-slide-theme=%s\ncp %s.html %s_%s_%s.html\n\n' % (filestem, pygm_style, filestem, sl_tp, style, filestem, filestem, sl_tp, style.replace('.', '_')))
         f.write('echo "Here are the slide shows:"\n/bin/ls %s_*_*.html\n' % filestem)
         print 'run\n  sh tmp_slides_html_all.sh\nto generate the slides'
         #print 'names:', ' '.join(glob.glob('%s_*_*.html' % filestem))
         return


    # --- Create a slide presentation from the HTML file ---

    header, parts, footer = get_header_parts_footer(filename, "html")
    parts = tablify(parts, "html")

    filestr = None
    if slide_type == 'doconce':
        doconce_html_split(header, parts, footer, basename, filename)
    elif slide_type in ('reveal', 'csss', 'dzslides', 'deck', 'html5slides'):
        filestr = generate_html5_slides(header, parts, footer,
                                        basename, filename, slide_type)
    else:
        print 'unknown slide type "%s"' % slide_type

    if filestr is not None:
        f = open(filename, 'w')
        f.write(filestr)
        f.close()
        print 'slides written to', filename


def tablify(parts, format="html"):
    """
    Detect !bslidecell XY and !eslidecell environments and typeset
    elements of a part (slide page) as a table.
    """
    begin_comment, end_comment = _format_comments(format)
    for i in range(len(parts)):
        part = ''.join(parts[i])
        if '%s !bslidecell' % begin_comment in part:
            pattern = r'%s !bslidecell +(\d\d) *%s(.+?)%s !eslidecell *%s' % \
                      (begin_comment, end_comment, begin_comment, end_comment)
            cpattern = re.compile(pattern, re.DOTALL)
            cells = cpattern.findall(part)
            #print 'CELLS:'; import pprint; pprint.pprint(cells)
            data = []
            row_max = 0
            col_max = 0
            for pos, entry in cells:
                ypos = int(pos[0])
                xpos = int(pos[1])
                if ypos > row_max:
                    row_max += 1
                if xpos > col_max:
                    col_max += 1
                data.append(((ypos, xpos), entry))
            table = [['']*(col_max+1) for j in range(row_max+1)]
            for pos, body in data:
                table[pos[0]][pos[1]] = body
            #print 'table:'; pprint.pprint(table)

            # typeset table in html
            tbl = '\n<table border="0">\n'
            for row in table:
                tbl += '<tr>\n'
                for column in row:
                    tbl += '<td class="padding"> %s </td>\n' % (column)
                    # This is an attempt to control the width of columns,
                    # but it does not work well.
                    #tbl += '<td class="padding"><div style="width: %d%%"> %s </div></td>\n' % (100./len(row), column)
                tbl += '</tr>\n'
            tbl += '</table>\n'

            # Put the whole table where cell 00 was defined
            pattern00 = r'%s !bslidecell +00 *%s(.+?)%s !eslidecell *%s' % \
                      (begin_comment, end_comment, begin_comment, end_comment)
            cpattern00 = re.compile(pattern00, re.DOTALL)
            #part = cpattern00.sub(tbl, part)  # does not preserve math \
            part = cpattern00.sub('XXXYYY@#$', part)  # some ID and then replace
            part = part.replace('XXXYYY@#$', tbl) # since replace handles \
            # Let the other cells be empty
            part = cpattern.sub('', part)
            #print 'part:'; pprint.pprint(part)
            part = [line + '\n' for line in part.splitlines()]
            parts[i] = part
    return parts

def _format_comments(format='html'):
    if format == 'html':
        return '<!--', '-->'
    elif format == 'latex':
        return '%', ''
    else:
        return None, None

def get_header_parts_footer(filename, format='html'):
    """Return list of lines for header, parts split by !split, and footer."""
    header = []
    footer = []
    parts = [[]]
    loc = 'header'
    #comment_pattern = INLINE_TAGS_SUBST[format]['comment']
    begin_comment, end_comment = _format_comments(format)
    f = open(filename, 'r')
    for line in f:
        if re.search(r'^%s -+ main content -+ %s' %
                     (begin_comment, end_comment), line):
            loc = 'body'
        if re.search(r'^%s !split.*?%s' % (begin_comment, end_comment), line):
            parts.append([])
        if re.search(r'^%s -+ end of main content -+ %s' %
                     (begin_comment, end_comment), line):
            loc = 'footer'
        if loc == 'header':
            header.append(line)
        elif loc == 'body':
            parts[-1].append(line)
        elif loc == 'footer':
            footer.append(line)
    f.close()
    return header, parts, footer


def doconce_html_split(header, parts, footer, basename, filename):
    """Native doconce style splitting of HTML file into parts."""
    import html

    local_navigation_pics = False    # avoid copying images to subdir...
    if local_navigation_pics:
        copy_datafiles(html_images)  # copy html_images subdir if needed

    prev_part = 'prev1'  # "Knob_Left"
    next_part = 'next1'  # "Knob_Forward"
    header_part_line = ''  # 'colorline'

    # Fix internal links to point to the right splitted file
    name_pattern = r'<a name="(.+?)">'
    href_pattern = r'<a href="#(.+?)">'
    parts_name = [re.findall(name_pattern, ''.join(part)) for part in parts]
    parts_href = [re.findall(href_pattern, ''.join(part)) for part in parts]
    parts_name2part = {}
    for i in range(len(parts_name)):
        for name in parts_name[i]:
            parts_name2part[name] = i

    import pprint
    for i in range(len(parts_name)):
        for href in parts_href[i]:
            n = parts_name2part[href]
            if n != i:
                # Reference to label in another file
                part_filename = '._part%04d_%s.html' % (n, basename)
                text = ''.join(parts[i]).replace(
                    '<a href="#%s">' % href,
                    '<a href="%s#%s">' % (part_filename, href))
                parts[i] = text.splitlines(True)
    if local_navigation_pics:
        prev_filename = html_imagefile(prev_part)
        next_filename = html_imagefile(next_part)
    else:
        prev_filename = 'https://doconce.googlecode.com/hg/bundled/html_images/%s.png' % prev_part
        next_filename = 'https://doconce.googlecode.com/hg/bundled/html_images/%s.png' % next_part

    generated_files = []
    for pn, part in enumerate(parts):
        lines = header[:]
        lines.append('<a name="part%04d"></a>\n' % pn)

        # Decoration line?
        if header_part_line:
            if local_navigation_pics:
                header_part_line_filename = html_imagefile(header_part_line)
                header_part_line_filename = 'https://doconce.googlecode.com/hg/bundled/html_images/%s.png' % header_part_line
            lines.append("""
<p><br><img src="%s"><p><br><p>
""" % header_part_line_filename)

        part_filename = '._part%04d_%s.html' % (pn, basename)
        prev_part_filename = '._part%04d_%s.html' % (pn-1, basename)
        next_part_filename = '._part%04d_%s.html' % (pn+1, basename)
        generated_files.append(part_filename)

        # Navigation in the top of the page
        if pn > 0:
            lines.append("""
<a href="%s"><img src="%s" border=0 alt="previous"></a>
""" % (prev_part_filename, prev_filename))
        if pn < len(parts)-1:
            lines.append("""
<a href="%s"><img src="%s" border=0 alt="next"></a>
""" % (next_part_filename, next_filename))
        lines.append('<p>\n')

        # Main body of text
        lines += part

        # Navigation in the bottom of the page
        lines.append('<p>\n')
        if pn > 0:
            lines.append("""
<a href="%s"><img src="%s" border=0 alt="previous"></a>
""" % (prev_part_filename, prev_filename))
        if pn < len(parts)-1:
            lines.append("""
<a href="%s"><img src="%s" border=0 alt="next"></a>
""" % (next_part_filename, next_filename))
        lines += footer
        html.add_to_file_collection(part_filename, filename, 'a')
        f = open(part_filename, 'w')
        f.write(''.join(lines))
        f.close()
        if pn == 0:
            shutil.copy(part_filename, filename)
    return generated_files


def generate_html5_slides(header, parts, footer, basename, filename,
                          slide_tp='reveal'):
    if slide_tp not in ['dzslides', 'html5slides']:
        copy_datafiles(eval(slide_tp + '_files'))  # copy to subdir if needed

    slide_syntax = dict(
        reveal=dict(
            default_theme='beige',
            #main_style='reveal.min',
            main_style='reveal',
            slide_envir_begin='<section>',
            slide_envir_end='</section>',
            notes='<aside class="notes">\n\g<1>\n</aside>',
            pop=('fragment', 'li'),
            head_header="""
<!-- reveal.js: http://lab.hakim.se/reveal-js/ -->

<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

<link rel="stylesheet" href="reveal.js/css/%(main_style)s.css">
<link rel="stylesheet" href="reveal.js/css/theme/%(theme)s.css" id="theme">
<!--
<link rel="stylesheet" href="reveal.js/css/reveal.css">
<link rel="stylesheet" href="reveal.js/css/reveal.min.css">
<link rel="stylesheet" href="reveal.js/css/theme/beige.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/beigesmall.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/night.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/simple.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/sky.css" id="theme">

*_do.css have left-adjusted header and text:
<link rel="stylesheet" href="reveal.js/css/reveal_do.css">
<link rel="stylesheet" href="reveal.js/css/reveal.min_do.css">
<link rel="stylesheet" href="reveal.js/css/theme/default_do.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/beige_do.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/night_do.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/simple_do.css" id="theme">
<link rel="stylesheet" href="reveal.js/css/theme/sky_do.css" id="theme">
-->

<script>
document.write( '<link rel="stylesheet" href="reveal.js/css/print/' + ( window.location.search.match( /print-pdf/gi ) ? 'pdf' : 'paper' ) + '.css" type="text/css" media="print">' );
</script>
""",
            body_header="""\
<body>
<div class="reveal">

<!-- Any section element inside the <div class="slides"> container
     is displayed as a slide -->

<div class="slides">
""",
            footer="""
</div> <!-- class="slides" -->
</div> <!-- class="reveal" -->

<script src="reveal.js/lib/js/head.min.js"></script>
<script src="reveal.js/js/reveal.min.js"></script>

<script>

// Full list of configuration options available here:
// https://github.com/hakimel/reveal.js#configuration
Reveal.initialize({
controls: true,
progress: true,
history: true,
center: true,
heme: Reveal.getQueryHash().theme, // available themes are in reveal.js/css/theme
transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/none

// Optional libraries used to extend on reveal.js
dependencies: [
{ src: 'reveal.js/lib/js/classList.js', condition: function() { return !document.body.classList; } },
{ src: 'reveal.js/plugin/markdown/showdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
{ src: 'reveal.js/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
{ src: 'reveal.js/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
{ src: 'reveal.js/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
{ src: 'reveal.js/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
// { src: 'reveal.js/plugin/remotes/remotes.js', async: true, condition: function() { return !!document.body.classList; } }
]
});
</script>
""",
            theme=None,
            title=None,
            ),
        csss=dict(
            default_theme='csss_default',
            slide_envir_begin='<section class="slide">',
            slide_envir_end='</section>',
            notes='<p class="presenter-notes">\n\g<1>\n</p>',
            pop=('delayed', 'li'),
            head_header="""
<!-- CSSS: http://leaverou.github.com/CSSS/ -->

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link href="csss/slideshow.css" rel="stylesheet" />
<link href="csss/theme.css" rel="stylesheet" />
<link href="csss/talk.css" rel="stylesheet" />
<script src="csss/prefixfree.min.js"></script>
""",
            body_header="""\
<body data-duration="10">
""",
            footer="""
<script src="csss/slideshow.js"></script>
<script src="csss/plugins/css-edit.js"></script>
<script src="csss/plugins/css-snippets.js"></script>
<script src="csss/plugins/css-controls.js"></script>
<script src="csss/plugins/code-highlight.js"></script>
<script>
var slideshow = new SlideShow();

var snippets = document.querySelectorAll('.snippet');
for(var i=0; i<snippets.length; i++) {
	new CSSSnippet(snippets[i]);
}

var cssControls = document.querySelectorAll('.css-control');
for(var i=0; i<cssControls.length; i++) {
	new CSSControl(cssControls[i]);
}
</script>
""",
            theme=None,
            title=None,
            ),
        dzslides=dict(
            default_theme='dzslides_default',  # just one theme in dzslides
            slide_envir_begin='<section>',
            slide_envir_end='</section>',
            #notes='<div role="note">\n\g<1>\n</div>',
            notes='<details>\n\g<1>\n</details>',
            pop=('incremental', 'ul', 'ol'),
            head_header="""
<!-- dzslides: http://paulrouget.com/dzslides/ -->

<!-- One section is one slide -->
""",
            body_header="""\
<body>
""",
            footer="""
<!-- Define the style of your presentation -->

<!--
Style by Hans Petter Langtangen hpl@simula.no:
a slight modification of the original dzslides style,
basically smaller fonts and left-adjusted titles.
-->

<!-- Maybe a font from http://www.google.com/webfonts ? -->
<link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet'>

<style>
  html, .view body { background-color: black; counter-reset: slideidx; }
  body, .view section { background-color: white; border-radius: 12px }
  /* A section is a slide. It's size is 800x600, and this will never change */
  section, .view head > title {
      /* The font from Google */
      font-family: 'Oswald', arial, serif;
      font-size: 30px;
  }

  .view section:after {
    counter-increment: slideidx;
    content: counter(slideidx, decimal-leading-zero);
    position: absolute; bottom: -80px; right: 100px;
    color: white;
  }

  .view head > title {
    color: white;
    text-align: center;
    margin: 1em 0 1em 0;
  }

  center {
    font-size: 20px;
  }
  h1 {
    margin-top: 100px;
    text-align: center;
    font-size: 50px;
  }
  h2 {
    margin-top: 10px;
    margin: 25px;
    text-align: left;
    font-size: 40px;
  }
  h3 {
    margin-top: 10px;
    margin: 25px;
    text-align: left;
    font-size: 30px;

  }

  ul {
    margin: 0px 60px;
    font-size: 20px;
  }

  ol {
    margin: 0px 60px;
    font-size: 20px;
  }

  p {
    margin: 25px;
    font-size: 20px;
  }

  pre {
    font-size: 50%;
    margin: 25px;
  }

  blockquote {
    height: 100%;
    background-color: black;
    color: white;
    font-size: 60px;
    padding: 50px;
  }
  blockquote:before {
    content: open-quote;
  }
  blockquote:after {
    content: close-quote;
  }

  /* Figures are displayed full-page, with the caption
     on top of the image/video */
  figure {
    background-color: black;
    width: 100%;
    height: 100%;
  }
  figure > * {
    position: absolute;
  }
  figure > img, figure > video {
    width: 100%; height: 100%;
  }
  figcaption {
    margin: 70px;
    font-size: 50px;
  }

  footer {
    position: absolute;
    bottom: 0;
    width: 100%;
    padding: 40px;
    text-align: right;
    background-color: #F3F4F8;
    border-top: 1px solid #CCC;
  }

  /* Transition effect */
  /* Feel free to change the transition effect for original
     animations. See here:
     https://developer.mozilla.org/en/CSS/CSS_transitions
     How to use CSS3 Transitions: */
  section {
    -moz-transition: left 400ms linear 0s;
    -webkit-transition: left 400ms linear 0s;
    -ms-transition: left 400ms linear 0s;
    transition: left 400ms linear 0s;
  }
  .view section {
    -moz-transition: none;
    -webkit-transition: none;
    -ms-transition: none;
    transition: none;
  }

  .view section[aria-selected] {
    border: 5px red solid;
  }

  /* Before */
  section { left: -150%; }
  /* Now */
  section[aria-selected] { left: 0; }
  /* After */
  section[aria-selected] ~ section { left: +150%; }

  /* Incremental elements */

  /* By default, visible */
  .incremental > * { opacity: 1; }

  /* The current item */
  .incremental > *[aria-selected] { opacity: 1; }

  /* The items to-be-selected */
  .incremental > *[aria-selected] ~ * { opacity: 0; }

  /* The progressbar, at the bottom of the slides, show the global
     progress of the presentation. */
  #progress-bar {
    height: 2px;
    background: #AAA;
  }
</style>

<!-- {{{{ dzslides core
#
#
#     __  __  __       .  __   ___  __
#    |  \  / /__` |    | |  \ |__  /__`
#    |__/ /_ .__/ |___ | |__/ |___ .__/ core
#
#
# The following block of code is not supposed to be edited.
# But if you want to change the behavior of these slides,
# feel free to hack it!
#
-->

<div id="progress-bar"></div>

<!-- Default Style -->
<style>
  * { margin: 0; padding: 0; -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; }
  [role="note"] { display: none; }
  body {
    width: 800px; height: 600px;
    margin-left: -400px; margin-top: -300px;
    position: absolute; top: 50%; left: 50%;
    overflow: hidden;
    display: none;
  }
  .view body {
    position: static;
    margin: 0; padding: 0;
    width: 100%; height: 100%;
    display: inline-block;
    overflow: visible; overflow-x: hidden;
    /* undo Dz.onresize */
    transform: none !important;
    -moz-transform: none !important;
    -webkit-transform: none !important;
    -o-transform: none !important;
    -ms-transform: none !important;
  }
  .view head, .view head > title { display: block }
  section {
    position: absolute;
    pointer-events: none;
    width: 100%; height: 100%;
  }
  .view section {
    pointer-events: auto;
    position: static;
    width: 800px; height: 600px;
    margin: -150px -200px;
    float: left;

    transform: scale(.4);
    -moz-transform: scale(.4);
    -webkit-transform: scale(.4);
    -o-transform: scale(.4);
    -ms-transform: scale(.4);
  }
  .view section > * { pointer-events: none; }
  section[aria-selected] { pointer-events: auto; }
  html { overflow: hidden; }
  html.view { overflow: visible; }
  body.loaded { display: block; }
  .incremental {visibility: hidden; }
  .incremental[active] {visibility: visible; }
  #progress-bar{
    bottom: 0;
    position: absolute;
    -moz-transition: width 400ms linear 0s;
    -webkit-transition: width 400ms linear 0s;
    -ms-transition: width 400ms linear 0s;
    transition: width 400ms linear 0s;
  }
  .view #progress-bar {
    display: none;
  }
</style>

<script>
  var Dz = {
    remoteWindows: [],
    idx: -1,
    step: 0,
    html: null,
    slides: null,
    progressBar : null,
    params: {
      autoplay: "1"
    }
  };

  Dz.init = function() {
    document.body.className = "loaded";
    this.slides = Array.prototype.slice.call($$("body > section"));
    this.progressBar = $("#progress-bar");
    this.html = document.body.parentNode;
    this.setupParams();
    this.onhashchange();
    this.setupTouchEvents();
    this.onresize();
    this.setupView();
  }

  Dz.setupParams = function() {
    var p = window.location.search.substr(1).split('&');
    p.forEach(function(e, i, a) {
      var keyVal = e.split('=');
      Dz.params[keyVal[0]] = decodeURIComponent(keyVal[1]);
    });
  // Specific params handling
    if (!+this.params.autoplay)
      $$.forEach($$("video"), function(v){ v.controls = true });
  }

  Dz.onkeydown = function(aEvent) {
    // Don't intercept keyboard shortcuts
    if (aEvent.altKey
      || aEvent.ctrlKey
      || aEvent.metaKey
      || aEvent.shiftKey) {
      return;
    }
    if ( aEvent.keyCode == 37 // left arrow
      || aEvent.keyCode == 38 // up arrow
      || aEvent.keyCode == 33 // page up
    ) {
      aEvent.preventDefault();
      this.back();
    }
    if ( aEvent.keyCode == 39 // right arrow
      || aEvent.keyCode == 40 // down arrow
      || aEvent.keyCode == 34 // page down
    ) {
      aEvent.preventDefault();
      this.forward();
    }
    if (aEvent.keyCode == 35) { // end
      aEvent.preventDefault();
      this.goEnd();
    }
    if (aEvent.keyCode == 36) { // home
      aEvent.preventDefault();
      this.goStart();
    }
    if (aEvent.keyCode == 32) { // space
      aEvent.preventDefault();
      this.toggleContent();
    }
    if (aEvent.keyCode == 70) { // f
      aEvent.preventDefault();
      this.goFullscreen();
    }
    if (aEvent.keyCode == 79) { // o
      aEvent.preventDefault();
      this.toggleView();
    }
  }

  /* Touch Events */

  Dz.setupTouchEvents = function() {
    var orgX, newX;
    var tracking = false;

    var db = document.body;
    db.addEventListener("touchstart", start.bind(this), false);
    db.addEventListener("touchmove", move.bind(this), false);

    function start(aEvent) {
      aEvent.preventDefault();
      tracking = true;
      orgX = aEvent.changedTouches[0].pageX;
    }

    function move(aEvent) {
      if (!tracking) return;
      newX = aEvent.changedTouches[0].pageX;
      if (orgX - newX > 100) {
        tracking = false;
        this.forward();
      } else {
        if (orgX - newX < -100) {
          tracking = false;
          this.back();
        }
      }
    }
  }

  Dz.setupView = function() {
    document.body.addEventListener("click", function ( e ) {
      if (!Dz.html.classList.contains("view")) return;
      if (!e.target || e.target.nodeName != "SECTION") return;

      Dz.html.classList.remove("view");
      Dz.setCursor(Dz.slides.indexOf(e.target) + 1);
    }, false);
  }

  /* Adapt the size of the slides to the window */

  Dz.onresize = function() {
    var db = document.body;
    var sx = db.clientWidth / window.innerWidth;
    var sy = db.clientHeight / window.innerHeight;
    var transform = "scale(" + (1/Math.max(sx, sy)) + ")";

    db.style.MozTransform = transform;
    db.style.WebkitTransform = transform;
    db.style.OTransform = transform;
    db.style.msTransform = transform;
    db.style.transform = transform;
  }


  Dz.getNotes = function(aIdx) {
    var s = $("section:nth-of-type(" + aIdx + ")");
    var d = s.$("[role='note']");
    return d ? d.innerHTML : "";
  }

  Dz.onmessage = function(aEvent) {
    var argv = aEvent.data.split(" "), argc = argv.length;
    argv.forEach(function(e, i, a) { a[i] = decodeURIComponent(e) });
    var win = aEvent.source;
    if (argv[0] === "REGISTER" && argc === 1) {
      this.remoteWindows.push(win);
      this.postMsg(win, "REGISTERED", document.title, this.slides.length);
      this.postMsg(win, "CURSOR", this.idx + "." + this.step);
      return;
    }
    if (argv[0] === "BACK" && argc === 1)
      this.back();
    if (argv[0] === "FORWARD" && argc === 1)
      this.forward();
    if (argv[0] === "START" && argc === 1)
      this.goStart();
    if (argv[0] === "END" && argc === 1)
      this.goEnd();
    if (argv[0] === "TOGGLE_CONTENT" && argc === 1)
      this.toggleContent();
    if (argv[0] === "SET_CURSOR" && argc === 2)
      window.location.hash = "#" + argv[1];
    if (argv[0] === "GET_CURSOR" && argc === 1)
      this.postMsg(win, "CURSOR", this.idx + "." + this.step);
    if (argv[0] === "GET_NOTES" && argc === 1)
      this.postMsg(win, "NOTES", this.getNotes(this.idx));
  }

  Dz.toggleContent = function() {
    // If a Video is present in this new slide, play it.
    // If a Video is present in the previous slide, stop it.
    var s = $("section[aria-selected]");
    if (s) {
      var video = s.$("video");
      if (video) {
        if (video.ended || video.paused) {
          video.play();
        } else {
          video.pause();
        }
      }
    }
  }

  Dz.setCursor = function(aIdx, aStep) {
    // If the user change the slide number in the URL bar, jump
    // to this slide.
    aStep = (aStep != 0 && typeof aStep !== "undefined") ? "." + aStep : ".0";
    window.location.hash = "#" + aIdx + aStep;
  }

  Dz.onhashchange = function() {
    var cursor = window.location.hash.split("#"),
        newidx = 1,
        newstep = 0;
    if (cursor.length == 2) {
      newidx = ~~cursor[1].split(".")[0];
      newstep = ~~cursor[1].split(".")[1];
      if (newstep > Dz.slides[newidx - 1].$$('.incremental > *').length) {
        newstep = 0;
        newidx++;
      }
    }
    this.setProgress(newidx, newstep);
    if (newidx != this.idx) {
      this.setSlide(newidx);
    }
    if (newstep != this.step) {
      this.setIncremental(newstep);
    }
    for (var i = 0; i < this.remoteWindows.length; i++) {
      this.postMsg(this.remoteWindows[i], "CURSOR", this.idx + "." + this.step);
    }
  }

  Dz.back = function() {
    if (this.idx == 1 && this.step == 0) {
      return;
    }
    if (this.step == 0) {
      this.setCursor(this.idx - 1,
                     this.slides[this.idx - 2].$$('.incremental > *').length);
    } else {
      this.setCursor(this.idx, this.step - 1);
    }
  }

  Dz.forward = function() {
    if (this.idx >= this.slides.length &&
        this.step >= this.slides[this.idx - 1].$$('.incremental > *').length) {
        return;
    }
    if (this.step >= this.slides[this.idx - 1].$$('.incremental > *').length) {
      this.setCursor(this.idx + 1, 0);
    } else {
      this.setCursor(this.idx, this.step + 1);
    }
  }

  Dz.goStart = function() {
    this.setCursor(1, 0);
  }

  Dz.goEnd = function() {
    var lastIdx = this.slides.length;
    var lastStep = this.slides[lastIdx - 1].$$('.incremental > *').length;
    this.setCursor(lastIdx, lastStep);
  }

  Dz.toggleView = function() {
    this.html.classList.toggle("view");

    if (this.html.classList.contains("view")) {
      $("section[aria-selected]").scrollIntoView(true);
    }
  }

  Dz.setSlide = function(aIdx) {
    this.idx = aIdx;
    var old = $("section[aria-selected]");
    var next = $("section:nth-of-type("+ this.idx +")");
    if (old) {
      old.removeAttribute("aria-selected");
      var video = old.$("video");
      if (video) {
        video.pause();
      }
    }
    if (next) {
      next.setAttribute("aria-selected", "true");
      if (this.html.classList.contains("view")) {
        next.scrollIntoView();
      }
      var video = next.$("video");
      if (video && !!+this.params.autoplay) {
        video.play();
      }
    } else {
      // That should not happen
      this.idx = -1;
      // console.warn("Slide doesn't exist.");
    }
  }

  Dz.setIncremental = function(aStep) {
    this.step = aStep;
    var old = this.slides[this.idx - 1].$('.incremental > *[aria-selected]');
    if (old) {
      old.removeAttribute('aria-selected');
    }
    var incrementals = $$('.incremental');
    if (this.step <= 0) {
      $$.forEach(incrementals, function(aNode) {
        aNode.removeAttribute('active');
      });
      return;
    }
    var next = this.slides[this.idx - 1].$$('.incremental > *')[this.step - 1];
    if (next) {
      next.setAttribute('aria-selected', true);
      next.parentNode.setAttribute('active', true);
      var found = false;
      $$.forEach(incrementals, function(aNode) {
        if (aNode != next.parentNode)
          if (found)
            aNode.removeAttribute('active');
          else
            aNode.setAttribute('active', true);
        else
          found = true;
      });
    } else {
      setCursor(this.idx, 0);
    }
    return next;
  }

  Dz.goFullscreen = function() {
    var html = $('html'),
        requestFullscreen = html.requestFullscreen || html.requestFullScreen || html.mozRequestFullScreen || html.webkitRequestFullScreen;
    if (requestFullscreen) {
      requestFullscreen.apply(html);
    }
  }

  Dz.setProgress = function(aIdx, aStep) {
    var slide = $("section:nth-of-type("+ aIdx +")");
    if (!slide)
      return;
    var steps = slide.$$('.incremental > *').length + 1,
        slideSize = 100 / (this.slides.length - 1),
        stepSize = slideSize / steps;
    this.progressBar.style.width = ((aIdx - 1) * slideSize + aStep * stepSize) + '%';
  }

  Dz.postMsg = function(aWin, aMsg) { // [arg0, [arg1...]]
    aMsg = [aMsg];
    for (var i = 2; i < arguments.length; i++)
      aMsg.push(encodeURIComponent(arguments[i]));
    aWin.postMessage(aMsg.join(" "), "*");
  }

  function init() {
    Dz.init();
    window.onkeydown = Dz.onkeydown.bind(Dz);
    window.onresize = Dz.onresize.bind(Dz);
    window.onhashchange = Dz.onhashchange.bind(Dz);
    window.onmessage = Dz.onmessage.bind(Dz);
  }

  window.onload = init;
</script>


<script> // Helpers
  if (!Function.prototype.bind) {
    Function.prototype.bind = function (oThis) {

      // closest thing possible to the ECMAScript 5 internal IsCallable
      // function
      if (typeof this !== "function")
      throw new TypeError(
        "Function.prototype.bind - what is trying to be fBound is not callable"
      );

      var aArgs = Array.prototype.slice.call(arguments, 1),
          fToBind = this,
          fNOP = function () {},
          fBound = function () {
            return fToBind.apply( this instanceof fNOP ? this : oThis || window,
                   aArgs.concat(Array.prototype.slice.call(arguments)));
          };

      fNOP.prototype = this.prototype;
      fBound.prototype = new fNOP();

      return fBound;
    };
  }

  var $ = (HTMLElement.prototype.$ = function(aQuery) {
    return this.querySelector(aQuery);
  }).bind(document);

  var $$ = (HTMLElement.prototype.$$ = function(aQuery) {
    return this.querySelectorAll(aQuery);
  }).bind(document);

  $$.forEach = function(nodeList, fun) {
    Array.prototype.forEach.call(nodeList, fun);
  }

</script>
""",
            theme=None,
            title=None,
            ),
        deck=dict(
            default_theme='web-2.0',
            slide_envir_begin='<section class="slide">',
            slide_envir_end='</section>',
            notes='<!-- \g<1> -->',  # no support of notes
            pop=('slide', 'li'),
            head_header="""
<!-- deck.js: https://github.com/imakewebthings/deck.js -->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=1024, user-scalable=no">

<title>%(title)s</title>

<!-- Required stylesheet -->
<link rel="stylesheet" href="deck.js/core/deck.core.css">

<!-- Extension CSS files go here. Remove or add as needed.
deck.goto: Adds a shortcut key to jump to any slide number.
Hit g, type in the slide number, and hit enter.

deck.hash: Enables internal linking within slides, deep
linking to individual slides, and updates the address bar and
a permalink anchor with each slide change.

deck.menu: Adds a menu view, letting you see all slides in a grid.
Hit m to toggle to menu view, continue navigating your deck,
and hit m to return to normal view. Touch devices can double-tap
the deck to switch between views.

deck.navigation: Adds clickable left and right buttons for the
less keyboard inclined.

deck.status: Adds a page number indicator. (current/total).

deck.scale: Scales each slide to fit within the deck container
using CSS Transforms for those browsers that support them.

deck.pointer: Turn mouse into laser pointer (toggle with p).
(Requires https://github.com/mikeharris100/deck.pointer.js)
-->

<link rel="stylesheet" href="deck.js/extensions/menu/deck.menu.css">
<link rel="stylesheet" href="deck.js/extensions/navigation/deck.navigation.css">
<link rel="stylesheet" href="deck.js/extensions/scale/deck.scale.css">
<link rel="stylesheet" href="deck.js/extensions/pointer/deck.pointer.css">
<!--
<link rel="stylesheet" href="deck.js/extensions/goto/deck.goto.css">
<link rel="stylesheet" href="deck.js/extensions/hash/deck.hash.css">
<link rel="stylesheet" href="deck.js/extensions/status/deck.status.css">
-->

<!-- Style theme. More available in themes/style/ or create your own. -->
<link rel="stylesheet" href="deck.js/themes/style/%(theme)s.css">

<!--
<link rel="stylesheet" href="deck.js/themes/style/neon.css">
<link rel="stylesheet" href="deck.js/themes/style/swiss.css">
<link rel="stylesheet" href="deck.js/themes/style/web-2.0.css">

git clone git://github.com/duijf/mnml.git
<link rel="stylesheet" href="deck.js/themes/style/mnml.css">

git://github.com/groovecoder/deckjs-theme-mozilla.git
<link rel="stylesheet" href="deck.js/themes/style/sandstone.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.aurora.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.dark.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.default.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.firefox.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.light.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.mdn.css">
<link rel="stylesheet" href="deck.js/themes/style/sandstone.nightly.css">

git://github.com/barraq/deck.ext.js.git
<link rel="stylesheet" href="deck.js/themes/style/beamer.css">
-->

<!-- Transition theme. More available in /themes/transition/ or create your own. -->
<link rel="stylesheet" href="deck.js/themes/transition/horizontal-slide.css">
<!--
<link rel="stylesheet" href="deck.js/themes/transition/fade.css">
<link rel="stylesheet" href="deck.js/themes/transition/vertical-slide.css">
<link rel="stylesheet" href="deck.js/themes/transition/horizontal-slide.css">
-->

<!-- Required Modernizr file -->
<script src="deck.js/modernizr.custom.js"></script>

""",
            body_header="""\
<body class="deck-container">
""",
            footer="""
<!-- Begin extension snippets. Add or remove as needed. -->

<!-- deck.navigation snippet -->
<a href="#" class="deck-prev-link" title="Previous">&#8592;</a>
<a href="#" class="deck-next-link" title="Next">&#8594;</a>

<!-- deck.status snippet
<p class="deck-status">
	<span class="deck-status-current"></span>
	/
	<span class="deck-status-total"></span>
</p>
-->

<!-- deck.goto snippet
<form action="." method="get" class="goto-form">
	<label for="goto-slide">Go to slide:</label>
	<input type="text" name="slidenum" id="goto-slide" list="goto-datalist">
	<datalist id="goto-datalist"></datalist>
	<input type="submit" value="Go">
</form>
-->

<!-- deck.hash snippet
<a href="." title="Permalink to this slide" class="deck-permalink">#</a>
-->

<!-- End extension snippets. -->


<!-- Required JS files. -->
<script src="deck.js/jquery-1.7.2.min.js"></script>
<script src="deck.js/core/deck.core.js"></script>

<!-- Extension JS files. Add or remove as needed. -->
<script src="deck.js/core/deck.core.js"></script>
<script src="deck.js/extensions/hash/deck.hash.js"></script>
<script src="deck.js/extensions/menu/deck.menu.js"></script>
<script src="deck.js/extensions/goto/deck.goto.js"></script>
<script src="deck.js/extensions/status/deck.status.js"></script>
<script src="deck.js/extensions/navigation/deck.navigation.js"></script>
<script src="deck.js/extensions/scale/deck.scale.js"></script>

<!-- From https://github.com/mikeharris100/deck.pointer.js -->
<script src="deck.js/extensions/pointer/deck.pointer.js"></script>

<!-- From https://github.com/stvnwrgs/presenterview -->
<script type="text/javascript" src="deck.js/extensions/presenterview/deck.presenterview.js"></script>

<!-- From https://github.com/nemec/deck.annotate.js
<script type="text/javascript" src="deck.js/extensions/deck.annotate.js/deck.annotate.js"></script>
-->


<!-- Initialize the deck. You can put this in an external file if desired. -->
<script>
	$(function() {
		$.deck('.slide');
	});
</script>
""",
            theme=None,
            title=None,
            ),
        html5slides=dict(
            default_theme='template-default',  # template-io2011
            slide_envir_begin='<article>',
            slide_envir_end='</article>',
            notes='',
            pop=('build', 'ul'),
            head_header="""
<!-- Google HTML5 Slides:
     http://code.google.com/p/html5slides/
-->

<meta charset='utf-8'>
<script
   src='http://html5slides.googlecode.com/svn/trunk/slides.js'>
</script>

</head>

<style>
/* Your individual styles here... */
</style>
""",
            body_header="""\
 <body style='display: none'>

<!-- See http://code.google.com/p/html5slides/source/browse/trunk/styles.css
     for definition of template-default and other styles -->

<section class='slides layout-regular %(theme)s'>
<!-- <section class='slides layout-regular template-io2011'> -->
<!-- <section class='slides layout-regular template-default'> -->

<!-- Slides are in <article> tags -->

""",
            footer="""
</section>
""",
            theme=None,
            title=None,
            ),
        )

    theme = option('html-slide-theme=', default='default')
    # Check that the theme name is registered
    #from doconce.misc import recommended_html_styles_and_pygments_styles
    all_combinations = recommended_html_styles_and_pygments_styles()
    if not slide_tp in all_combinations:
        # This test will not be run since it is already tested that
        # the slide type is legal (before calling this function)
        print '*** error: slide type "%s" is not known - abort' % slide_tp
        print 'known slide types:', ', '.join(list(all_combinations.keys()))
        sys.exit(1)
    if theme != 'default':
        if not theme in all_combinations[slide_tp]:
            print '*** error: %s theme "%s" is not known - abort' % \
                  (slide_tp, theme)
            print 'known themes:', ', '.join(list(all_combinations[slide_tp].keys()))
            sys.exit(1)

    m = re.search(r'<title>(.*?)</title>', ''.join(header))
    if m:
        title = m.group(1).strip()
    else:
        title = ''
    slide_syntax[slide_tp]['title'] = title
    slide_syntax[slide_tp]['theme'] = \
       slide_syntax[slide_tp]['default_theme'] if (theme == 'default' or theme.endswith('_default')) else theme

    # Fill in theme etc.
    slide_syntax[slide_tp]['head_header'] = \
           slide_syntax[slide_tp]['head_header'] % slide_syntax[slide_tp]
    slide_syntax[slide_tp]['body_header'] = \
           slide_syntax[slide_tp]['body_header'] % slide_syntax[slide_tp]

    slides = """\
<!DOCTYPE html>
<html lang="en">

<!--
    Automatically translated from Doconce source.
    http://code.google.com/p/doconce
-->

<head>
<meta charset="utf-8">

<title>%(title)s</title>
%(head_header)s

<!-- Styles for table layout of slides -->
<style type="text/css">
td.padding {
  padding-top:20px;
  padding-bottom:20px;
  padding-right:50px;
  padding-left:50px;
}
</style>

<!-- Use MathJax to render mathematics -->
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: {
     equationNumbers: {  autoNumber: "AMS"  },
     extensions: ["AMSmath.js", "AMSsymbols.js", "autobold.js"]
  }
});
</script>
<script type="text/javascript"
 src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
<!-- Fix slow MathJax rendering in IE8 -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">

</head>

%(body_header)s
""" % slide_syntax[slide_tp]

    cinline_comment_pattern = re.compile(r'<!-- begin inline comment -->\s*\[<b>.+?</b>:\s*<em>(.+?)</em>]\s*<!-- end inline comment -->', re.DOTALL)
    for part in parts:
        part = ''.join(part)
        part = cinline_comment_pattern.sub(
                  slide_syntax[slide_tp]['notes'], part)
        if '!bpop' not in part:
            part = part.replace('<li>', '<p><li>')  # more space between bullets
        # else: the <p> destroys proper handling of incremental pop up

        # Find pygments style
        m = re.search(r'typeset with pygments style "(.+?)"', part)
        pygm_style = m.group(1) if m else 'plain <pre>'
        html_style = slide_syntax[slide_tp]['theme']
        recommended_combinations = all_combinations[slide_tp]
        if html_style in recommended_combinations:
            if pygm_style != 'plain <pre>' and \
               not pygm_style in recommended_combinations[html_style]:
                print '*** warning: pygments style "%s" is not '\
                      'recommended for "%s"!' % (pygm_style, html_style)
                print 'recommended styles are %s' % \
                (', '.join(['"%s"' % combination
                            for combination in
                            recommended_combinations[html_style]]))

        # Fix styles: native should have black background for neon and night
        if slide_syntax[slide_tp]['theme'] in ['neon', 'night']:
            if pygm_style == 'native':
                # Change to black background
                part = part.replace('background: #202020',
                                    'background: #000000')

        # Pieces to pop up item by item as the user is clicking
        if '<!-- !bpop' in part:
            pattern = r'<!-- !bpop (.*?)-->(.+?)<!-- !epop.*?-->'
            cpattern = re.compile(pattern, re.DOTALL)
            #import pprint;pprint.pprint(cpattern.findall(part))
            def subst(m):  # m is match object
                arg = m.group(1).strip()
                if arg:
                    arg = ' ' + arg

                class_tp = slide_syntax[slide_tp]['pop'][0]
                placements = slide_syntax[slide_tp]['pop'][1:]
                body = m.group(2)
                if '<ol>' in body or '<ul>' in body:
                    for tag in placements:
                        tag = '<%s>' % tag.lower()
                        if tag in body:
                            body = body.replace(tag, '%s class="%s%s">' % (tag[:-1], class_tp, arg))
                else:
                    # treat whole block as paragraph
                    body = body.replace('<p>', '')  # can make strange behavior
                    body2 = '\n<p class="%s">\n' % class_tp
                    if slide_tp == 'reveal' and arg:  # reveal specific
                        args = arg.split()
                        for arg in args:
                            if arg:
                                body2 += '\n<span class="%s %s">\n' % (class_tp, arg)
                        body2 += body
                        for arg in args:
                            if arg:
                                body2 += '\n</span>\n'
                    else:
                        body2 += body
                    body2 += '\n</p>\n'
                    body = body2
                return body

            part = cpattern.sub(subst, part)

        # Special treatment of the text for some slide tools
        if slide_tp == 'deck':
            part = part.replace('<pre>', '<pre><code>')
            part = part.replace('</pre>', '</code></pre>')

        part = part.replace('</ul>', '</ul>\n<p>')
        part = part.replace('</ol>', '</ol>\n<p>')

        slides += """
%s
%s
%s

""" % (slide_syntax[slide_tp]['slide_envir_begin'],
       part,
       slide_syntax[slide_tp]['slide_envir_end'])
    slides += """
%s

</body>
</html>
""" % (slide_syntax[slide_tp]['footer'])
    slides = re.sub(r'<!-- !split .*-->\n', '', slides)
    return slides

def _usage_split_rst():
    print 'Usage: doconce split_rst complete_file.rst'

def split_rst():
    """
    Split a large .rst file into smaller files corresponding
    to each main section (7= in headings).

    The large complete doconce file typically looks like this::

        #>>>>>>> part: header >>>>>
        # #include "header.do.txt"

        #>>>>>>> part: fundamentals >>>>>
        # #include "fundamentals.do.txt"

        #>>>>>>> part: nonlinear >>>>>
        # #include "nonlinear.do.txt"

        #>>>>>>> part: timedep >>>>>
        # #include "timedep.do.txt"

    Note that the comment lines ``#>>>...`` *must* appear right above
    the include directives. The includes are replaced by text, while
    the ``#>>>...`` are still left as markers in the complete document
    for the various sections. These markers are used to split the
    text into parts. For Sphinx to treat section headings right,
    each part should start with a main section (7=).

    The ``split_rst`` command will in this example take the complete
    ``.rst`` file and make files ``header.rst``, ``fundamentals.rst``,
    ``nonlinear.rst``, etc.  The ``doconce sphinx_dir`` command takes
    all these ``.rst`` files as arguments and creates the
    corresponding index file etc. The names of the various ``.rst``
    files are specified in the ``#>>>... Part: ...`` markers. Normally,
    a part name corresponding to the included filename is used.

    CAVEAT: Nested includes in doconce files and doconce files in subdirs.
    SOLUTION: Use #>>> Part: mypart >>> for an include mypart/mypart.do.txt.
    All parts are then split into files in the top directory.

    fig dirs must be copied, but that can be easily done automatically
    if the fig dir name is of the right form.
    """

    if len(sys.argv) <= 1:
        _usage_split_rst()
        sys.exit(1)

    complete_file = sys.argv[1]
    f = open(complete_file, 'r')
    filestr = f.read()
    f.close()

    # Determine parts
    part_pattern = r'\.\.\s*>>+\s*[Pp]art:\s*%s\s*>>+'
    parts = re.findall(part_pattern % '([^ ]+?)', filestr)

    # Split file
    for i in range(len(parts)):
        if i < len(parts)-1:  # not the last part?
            this_part = part_pattern % parts[i]
            next_part = part_pattern % parts[i+1]
        else:
            this_part = part_pattern % parts[i]
            next_part = '$'  # end of string
        pattern = '%s(.+?)%s' % (this_part, next_part)
        cpattern = re.compile(pattern, re.DOTALL)
        m = cpattern.search(filestr)
        text = m.group(1)
        filename = parts[i] + '.rst'
        f = open(filename, 'w')
        f.write(text)
        f.close()
        #print 'Extracted part', parts[i], 'in', filename
    print ' '.join(parts)


def _usage_list_labels():
    print 'Usage: doconce list_labels doconcefile.do.txt | latexfile.tex'

def list_labels():
    """
    List all labels used in a doconce or latex file.
    Since labels often are logically connected to headings in
    a document, the headings are printed in between in the
    output from this function, with a comment sign # in
    front so that such lines can easily be skipped when
    processing the output.

    The purpose of the function is to enable clean-up of labels
    in a document. For example, one can add to the output a
    second column of improved labels and then make replacements.
    """
    if len(sys.argv) <= 1:
        _usage_list_labels()
        sys.exit(1)
    filename = sys.argv[1]

    # doconce or latex file
    dofile = True if filename.endswith('.do.txt') else False
    lines = open(filename, 'r').readlines()
    labels = []  # not yet used, but nice to collect all labels
    for line in lines:
        # Identify heading and print out
        heading = ''
        if dofile:
            m = re.search(r'[_=]{3,7}\s*(.+?)\s*[_=]{3,7}', line)
            if m:
                heading = m.group(1).strip()
        else:
            m = re.search(r'section\{(.+?)\}', line)
            if m:
                heading = m.group(1).strip()
        if heading:
            print '#', heading

        # Identify label
        if 'label{' in line:
            m = re.search(r'label\{(.+?)\}', line)
            if m:
                label = m.group(1).strip()
            else:
                print 'Syntax error in line'
                print line
                sys.exit(1)
            print label
            labels.append(label)


def _usage_teamod():
    print 'Usage: doconce teamod name'

def teamod():
    if len(sys.argv) < 2:
        _usage_teamod()
        sys.exit(1)

    name = sys.argv[1]
    if os.path.isdir(name):
        os.rename(name, name + '.old~~')
        print 'directory %s exists, renamed to %s.old~~' % (name, name)
    os.mkdir(name)
    os.chdir(name)
    os.mkdir('fig-%s' % name)
    os.mkdir('src-%s' % name)
    os.mkdir('lec-%s' % name)
    f = open('wrap_%s.do.txt' % name, 'w')
    f.write("""# Wrapper file for teaching module "%s"

TITLE: Here Goes The Title ...
AUTHOR: name1 email:..@.. at institution1, institution2, ...
AUTHOR: name2 at institution3
DATE: today

# #include "%s.do.txt"
""" % name)
    f.close()
    f = open('%s.do.txt' % name, 'w')
    f.write("""# Teaching module: %s
======= Section =======

===== Subsection =====
idx{example}
label{mysubsec}

__Paragraph.__ Running text...

Some mathematics:

!bt
\begin{align}
a &= b,  label{eq1}\\
a &= b,  label{eq2}
\end{align}
!et
or

!bt
\[ a = b, \quad c=d \]
!et

Some code:
!bc pycod
def f(x):
    return x + 1
!ec

A list with

 * item1
 * item2
   * subitem2
 * item3
   continued on a second line

""")
    f.close()


def _usage_assemble():
    print 'Usage: doconce assemble master.do.txt'

def assemble():
    # See 2DO and teamod.do.txt

    # Assume some master.do.txt including other .do.txt recursively.
    # search for all @@@CODE, FIGURE, MOVIE and archive in list/dict.
    # search for all #include ".+\.do\.txt", call recursively
    # for each of these with dirname and dotxtname as arguments.
    # Build local links to all src- and figs- directories, make
    # sure all teamod names are unique too.

    # analyzer: old comments on how to implement this. Try the
    # description above first.
    if len(sys.argv) < 2:
        _usage_assemble()
        sys.exit(1)

    master = sys.argv[2]

    # Run analyzer...

def _usage_analyzer():
    print 'Usage: doconce analyzer complete_file.do.txt'

def analyzer():
    """
    For a doconce file, possibly composed of many other doconce
    files, in a nested fashion, this function returns a tree
    data structure with the various parts, included files,
    involved source code, figures, movies, etc.

    Method:
    Go through all #include's in a doconce file, find subdirectories
    used in @@@CODE, FIGURE, and MOVIE commands, and make links
    in the present directory to these subdirectories such that
    @@@CODE, FIGURE, and MOVIE works from the present directory.
    This is very important functionality when a doconce document
    is made up of many distributed documents, in different
    directories, included in a (big) document.

    Make recursive calls.
    """
    # 2DO:
    # - start with an example (some Cython intro examples? in a tree?)
    # - make doconce nested_include
    #   which makes a tree of all the dirs that are involved in a
    #   complete document
    # - simply copy all subnits and the complete doc to a new _build dir
    # - simply copy all figs-*, movies-*, src-* to _build
    # - compile

    # IDEA: Have a convention of src-poisson, figs-poisson etc
    # naming and use a simple script here to link from one dir to
    # all src-* and figs-* movies-* found in a series of dir trees. YES!!
    # Maybe use code below to issue warnings if FIGURE etc applies other
    # directories (could extend with eps-*, ps-*, pdf-*, png-*, jpeg-*,
    # gif-*, flv-*, avi-*, ...) and/or do this also in std doconce
    # translation (no, simple stand-alone thing must be fine with
    # figs/, it's the big distributed projects that need this
    # naming convention).  YES! Should be figs-basename(os.getcwd())

    # Can play with fenics tut: put each section in sep dirs,
    # stationary/poisson, transient/diffusion etc.,
    # with local src and figs
    # Need a script that can pack all local src dirs into a separate tree
    # for distribution (doconce pack_src): create new tree, walk a set
    # of trees, for each subdir with name src-*, strip off src-, copy
    # subdir to right level in new tree

    # Support for latex files too (includegraphics, movie15, psfig,
    # input, include), starting point is a .tex file with includes/inputs

    if len(sys.argv) <= 1:
        _usage_bbl2rst()
        sys.exit(1)

    # Must have this in a function since we need to do this recursively
    filename = sys.argv[1]
    alltext = open(filename, 'r').read()
    # preprocess parts and includes
    part_pattern = r'\.\.\s*>>+\s*[Pp]art:\s*%s\s*>>+'
    parts = re.findall(part_pattern % '([^ ]+?)', alltext)

    include_files = re.findall(r"""[#%]\s+\#include\s*["']([A-Za-z0-9_-., ~]+?)["']""", alltext)
    include_files = [filename for dummy, filename in include_files]

    figure = re.compile(r'^FIGURE:\s*\[(?P<filename>[^,\]]+),?(?P<options>[^\]]*)\]\s*?(?P<caption>.*)$', re.MULTILINE)
    movie = re.compile(r'^MOVIE:\s*\[(?P<filename>[^,\]]+),?(?P<options>[^\]]*)\]\s*?(?P<caption>.*)$', re.MULTILINE)
    code = re.compile(r'^\s*@@@CODE\s+([^ ]+?) ')

    for filename in include_files:
        f = open(filename, 'r')
        directory = os.path.dirname(f)
        fstr = f.read()
        f.close()
        # What about figs/myfig/1stver/t.png? Just link to figs...
        # but it's perhaps ok with links at different levels too?
        figure_files = [filename for filename, options, captions in \
                        figure.findall(fstr)]
        movie_files = [filename for filename, options, captions in \
                       movie.findall(fstr)]
        code_files = code.findall(fstr)
        print figure_files
        figure_dirs = [os.path.dirname(f) for f in figure_files] # no dir??
        print figure_dirs
        dirs = [os.path.join(directory, figure_dir) \
                for figure_dir in figure_dirs]




def old2new_format():
    if len(sys.argv) == 1:
        print 'Usage: %s file1.do.txt file2.do.txt ...' % sys.argv[0]
        sys.exit(1)

    for filename in sys.argv[1:]:
        print 'Converting', filename
        _old2new(filename)

def _old2new(filename):
    """
    Read file with name filename and make substitutions of
    ___headings___ to === headings ===, etc.
    A backup of the old file is made (filename + '.old').
    """
    f = open(filename, 'r')
    lines = f.readlines()
    f.close()
    os.rename(filename, filename + '.old')

    # perform substitutions:
    nchanges = 0
    for i in range(len(lines)):
        oldline = lines[i]
        # change from ___headings___ to === headings ===:
        lines[i] = re.sub(r'(^\s*)_{7}\s*(?P<title>[^ ].*?)\s*_+\s*$',
                          r'\g<1>======= \g<title> =======' + '\n', lines[i])
        lines[i] = re.sub(r'(^\s*)_{5}\s*(?P<title>[^ ].*?)\s*_+\s*$',
                          r'\g<1>===== \g<title> =====' + '\n', lines[i])
        lines[i] = re.sub(r'(^\s*)_{3}\s*(?P<title>[^ ].*?)\s*_+\s*$',
                          r'\g<1>=== \g<title> ===' + '\n', lines[i])
        if lines[i].startswith('AUTHOR:'):
            # swith to "name at institution":
            if not ' at ' in lines[i]:
                print 'Warning, file "%s": AUTHOR line needs "name at institution" syntax' % filename

        if oldline != lines[i]:
            nchanges += 1
            print 'Changing\n  ', oldline, 'to\n  ', lines[i]

    print 'Performed %d changes in "%s"' % (nchanges, filename)
    f = open(filename, 'w')
    f.writelines(lines)
    f.close()

def latex_header():
    from doconce.doconce import INTRO
    print INTRO['latex']

def latex_footer():
    from doconce.doconce import OUTRO
    print OUTRO['latex']


# ----------------------- functions for spell checking ---------------------

_environments = [
    # Doconce
    ("!bc",                 "!ec"),  # could have side effect if in text, but that's only in Doconce manuals...
    ("!bt",                 "!et"),
    #("!bhint",              "!ehint"),  # will not remove the environment
    #("!bans",               "!eans"),
    #("!bsol",               "!esol"),
    #("!bsubex",             "!esubex"),
    # Mako
    ("<%doc>",              "</%doc>"),
    # hpl tex stuff
    ("\\beq",               "\\eeq"),
    ("\\beqa",              "\\eeqa"),
    ("\\beqan",             "\\eeqan"),
    # Wait until the end with removing comment lines
    ]

# These are relevant if doconce spellcheck is applied latex or ptex2tex files
_latex_environments = [
   ("\\begin{equation}",   "\\end{equation}"),
    ("\\begin{equation*}",  "\\end{equation*}"),
    ("\\begin{align}",      "\\end{align}"),
    ("\\begin{align*}",     "\\end{align*}"),
    ("\\begin{eqnarray}",   "\\end{eqnarray}"),
    ("\\begin{eqnarray*}",  "\\end{eqnarray*}"),
    ("\\begin{figure}[",    "]"),
    ("\\begin{figure*}[",   "]"),
    ("\\begin{multline}",   "\\end{multiline}"),
    ("\\begin{tabbing}",   "\\end{tabbing}"),
    # ptex2tex environments
    ("\\bccq",              "\\eccq"),
    ("\\bcc",               "\\ecc"),
    ("\\bcod",              "\\ecod"),
    ("\\bpro",              "\\epro"),
    ("\\bpy",               "\\epy"),
    ("\\brpy",              "\\erpy"),
    ("\\bipy",              "\\eipy"),
    ("\\bsys",              "\\esys"),
    ("\\bdat",              "\\edat"),
    ("\\bsni",              "\\esni"),
    ("\\bdsni",             "\\edsni"),
    ]

_replacements = [
    # General
    (r'cf.', ''),
    # Doconce
    (r"^#.*$", "", re.MULTILINE),
    (r"(idx|label|ref)\{.*?\}", ""),
    (r"={3,}",  ""),
    (r'`[^ ][^`]*?`', ""),
    (r"`[A-Za-z0-9_.]+?`", ""),
    (r"^#.*$",          "", re.MULTILINE),
    (r'"https?://.*?"', ""),
    (r'"ftp://.*?"', ""),
    (r'\[[A-Za-z]+:\s+[^\]]*?\]', ''),  # inline comment
    (r'^\s*file=[A-Za-z_0-9.]+\s*$', '', re.MULTILINE),
    (r"^@@@CODE.*$",    "", re.MULTILINE),
    (r"^\s*(FIGURE|MOVIE):\s*\[.+?\]",    "", re.MULTILINE),
    (r"^\s*TOC:\s+(on|off)", "", re.MULTILINE),
    ('!split', ''),
    (r'![be]slidecell', ''),
    (r'![be]ans', ''),
    (r'![be]sol', ''),
    (r'![be]subex', ''),
    (r'![be]hint', ''),
    (r'![be]notes', ''),
    (r'![be]pop', ''),
    # Preprocess
    (r"^#.*ifn?def.*$", "", re.MULTILINE),
    (r"^#.*else.*$", "", re.MULTILINE),
    (r"^#.*endif.*$", "", re.MULTILINE),
    (r"^#include.*$", "", re.MULTILINE),
    # Mako
    (r"^% .*$", "", re.MULTILINE),
    (r"^<%.*$", "", re.MULTILINE),
    ]

_latex_replacements = [
    (r"%.*$", "", re.MULTILINE),  # comments
    (r"\\.*section\{(.+?)\}", "\g<1>"),
    (r"^\\\[[^@]+\\\]",    ""),  # (@ is "unlikely" character)
    (r"\\includegraphics.*?(\.pdf|\.png|\.eps|\.ps|\.jpg)", ""),
    (r"\\(pageref|eqref|ref|label|url|emp)\{.*?\}", ""),
    (r"\\(emph|texttt)\{(.*?)\}", "\g<2>"),
    (r"\\footnote\{", " "),  # leaves an extra trailing } (ok)
    #(r"\\[Vv]erb(.)(.+?)\1", "\g<2>"),
    (r"\\[Vv]erb(.)(.+?)\1", ""),
    (r"\\index\{.*?\}", ""),
    (r"\$.+?\$", ""),  # works line by line (due to .), [^$]+ is dangerous...
    (r"([A-Za-z])~", "\g<1> "),
    (r"``(.+?)''", "\g<1>"),  # very important, otherwise doconce verb eats the text
    (r' \.', '.'),
    ('\n\\.', '.\n'),
    (r':\s*\.', '.'),
    (r' ,', ','),
    ('\n\,', ',\n'),
    (',{2,}', ','),
    # ptex2tex
    (r"^@@@DATA.*$",    "", re.MULTILINE),
    (r"^@@@CMD.*$",    "", re.MULTILINE),
    # hpl's idx latex commands
    (r"\\idx\{.*?\}", ""),
    (r"\\idx(font|f|m|p|st|s|c|e|numpyr|numpy)\{.*?\}", ""),
    (r"\\codett\{.*?\}", ""),
    (r"\\code\{.*?\}", ""),
    ]

_common_typos = [
    '!bsubsex',
    '!esubsex',
    'hiearchy',
    'hieararchy',
    'statment',
    ' imples',
    'imples ',
    'execption',
    'excercise',
    'exersice',
    'eletric',
    'everyting',
    'progam',
    'technqiues',
    'incrased',
    'similarily',
    'occurence',
    'persue',
    'becase',
    'frequence',
    'noticable',
    'peform',
    'paramter',
    'intial',
    'inital',
    'condtion',
    'expontential',
    'differentation',
    'recieved',
    'cateogry',
    'occured',
    '!bc pydoc',
    '!bc pycodc',
    ]


def _grep_common_typos(text, filename, common_typos):
    """Search for common typos and abort program if any is found."""
    found = False
    for i, line in enumerate(text.splitlines()):
        for typo in common_typos:
            if re.search(typo, line):
                print '\ntypo "%s" in line %d in file %s:\n' % \
                      (typo, i+1, filename), line
                found = True
    if found:
        sys.exit(1)

def _strip_environments(text, environments, verbose=0):
    """Remove environments in the ``environments`` list from the text."""
    for item in environments:
        if len(item) != 2:
            raise ValueError(
                '%s in environments to be stripped is wrong' % (str(item)))
        begin, end = item
        if not begin in text:
            continue
        parts = text.split(begin)
        text = parts[0]
        for part in parts[1:]:
            subparts = part.split(end)
            text += end.join(subparts[1:])
            if verbose > 0:
                print '\n============ split %s <-> %s\ntext so far:' % (begin, end)
                print text
                print '\n============\nSkipped:'
                print subparts[0]
    return text

def _do_regex_replacements(text, replacements, verbose=0):
    """Substitute according to the `replacement` list."""
    for item in replacements:
        if len(item) == 2:
            from_, to_ = item
            text = re.sub(from_, to_, text)
        elif len(item) == 3:
            from_, to_, flags = item
            text = re.sub(from_, to_, text, flags=flags)
        if verbose > 0:
            print '=================='
            print 'regex substitution: %s -> %s\nnew text:' % (from_, to_)
            print text
    return text

def _spellcheck(filename, dictionaries=['.dict4spell.txt'], newdict=None,
                remove_multiplicity=False, strip_file='.strip'):
    """
    Spellcheck `filename` and list misspellings in the file misspellings.txt~.
    The `dictionaries` list contains filenames for dictionaries to be
    used with ispell.
    `newdict` is an optional filename for creating a new, updated
    dictionary containing all given dictionaries and all misspellings
    found (assuming they are correct and approved in previous runs).
    `remove_multiplicity` removes multiple occurrences of the same
    misspelling in the misspellings.txt~ (output) file.
    `strip_file` holds the filename of a file with definitions of
    environments to be stripped off in the source file, replacements
    to be performed, and a list of typical misspellings that are first
    check before ispell is run.
    """

    try:
        f = open(filename, 'r')
    except IOError:
        print '\nThe file %s does not exist!' % filename
        sys.exit(1)

    verbose = 1 if option('debug') else 0

    text = f.read()
    f.close()

    # First check for double words

    # Remove inline verbatim and !bc and !bt blocks
    text2 = re.sub(r'`.+?`', '`....`', text)  # remove inline verbatim
    code = re.compile(r'^!bc(.*?)\n(.*?)^!ec *\n', re.DOTALL|re.MULTILINE)
    text2 = code.sub('', text2)
    tex = re.compile(r'^!bt\n(.*?)^!et *\n', re.DOTALL|re.MULTILINE)
    text2 = tex.sub('', text2)

    pattern = r"\b([\w'\-]+)(\s+\1)+\b"
    found = False
    offset = 30  # no of chars before and after double word to be printed
    start = 0
    while start < len(text2)-1:
        m = re.search(pattern, text2[start:])
        if m:
            # Words only
            word = m.group(0)
            try:
                [float(w) for w in word.split()]
                is_word = False
            except ValueError:
                # Drop words with underscore, ...
                #drop = ['_', '--',
                is_word = '_' not in word

            if is_word:
                print "\ndouble words detected in %s (see inside [...]):\n------------------------" % filename
                print "%s[%s]%s\n------------------------" % \
                      (text2[max(0,start+m.start()-offset):start+m.start()],
                       word,
                       text2[start+m.end():min(start+m.end()+offset,
                                               len(text2)-1)])
                found = True
            start += m.end()
        else:
            break
    if found:
        pass
        #print '\nAbort because of double words.'
        #sys.exit(1)

    # Continue with spell checking

    if os.path.isfile(strip_file):
        execfile(strip_file)
    else:
        environments = []
        replacements = []
        common_typos = []
    # Add standard definitions (above)
    environments += _environments
    replacements += _replacements
    common_typos += _common_typos

    # Add standard latex definitions when spellchecking latex
    if os.path.splitext(filename)[1] == '.tex':
        # Make sure to do latex first (\label{} before label{})
        environments = _latex_environments + environments
        replacements = _latex_replacements + replacements


    _grep_common_typos(text, filename, common_typos)

    text = _strip_environments(text, environments, verbose)
    #print 'Text after environment strip:\n', text

    text = _do_regex_replacements(text, replacements, verbose)
    #print 'Text after regex replacements:\n', text

    # Write modified text to scratch file and run ispell
    scratchfile = 'tmp_stripped_%s' % filename
    f = open(scratchfile, 'w')
    text = text.replace('  ', ' ').replace('\n\n', '\n')
    f.write(text)
    f.close()
    personal_dictionaries = []
    p_opt = ''  # personal dictionary specification for ispell
    for dictionary in dictionaries:
        if os.path.isfile(dictionary):
            p_opt += " -p`pwd`/%s" % dictionary
            f = open(dictionary, 'r')
            personal_dictionaries += f.readlines()
            f.close()
        else:
            print 'Dictionary file %s does not exist.' % dictionary

    personal_dictionaries = list(sets.Set(personal_dictionaries))
    misspellings = 'tmp_misspelled_' + filename + '~'
    cmd = 'cat %s | ispell -l -t -d american %s > %s' % \
          (scratchfile, p_opt, misspellings)
    #cmd = 'cat %s | aspell -t -d american list %s > %s'
    system(cmd)

    # Load misspellings, remove duplicates
    f = open(misspellings, 'r')
    words = f.readlines()
    f.close()
    words2 = list(sets.Set(words))  # remove multiple words
    if len(words2) > 0:             # do we have misspellings?
        print '%d misspellings in %s' % (len(words2), filename)
        if remove_multiplicity:
            f = open(misspellings, 'w')
            f.write(words2)
            f.close()
    else:
        os.remove(misspellings)

    # Make convenient updates of personal dictionaries
    if newdict is not None:
        accepted_words = words2 + personal_dictionaries
        if os.path.isfile(newdict):
            f = open(newdict, 'r')
            newdict_words = f.readlines()
            f.close()
            newdict_add = words2 + newdict_words
            newdict_add = sorted(list(sets.Set(newdict_add)))
            union = accepted_words + newdict_words
            union = sorted(list(sets.Set(union)))
            #print '%s %d: %d misspellings (%d from personal dicts) -> %d' % (newdict, len(newdict_words), len(words2), len(personal_dictionaries), len(union))
        else:
            union = accepted_words
            newdict_add = words2
        # union is the potentially new personal dictionary
        #
        f = open(newdict, 'w')
        f.writelines(newdict_add)
        f.close()
        f = open('new_dictionary.txt~', 'w')
        f.writelines(union)
        f.close()
        #if len(newdict_add) > 0:
        #    print '%s: %d, %s: %d items' % (newdict, len(newdict_add), 'new_dictionary.txt~', len(union))


def _spellcheck_all(**kwargs):
    for filename in glob.glob('tmp_misspelled*~') + glob.glob('misspellings.txt~*'):
        os.remove(filename)
    for filename in ['__tmp.do.txt']:
        if filename in sys.argv[1:]:  # iterate over copy
            os.remove(filename)
            del sys.argv[sys.argv.index(filename)]
    for filename in sys.argv[1:]:
        if not filename.startswith('tmp_stripped_'):
            _spellcheck(filename, **kwargs)
    tmp_misspelled = glob.glob('tmp_misspelled*~')
    if len(tmp_misspelled) > 0:
        print
        if len(sys.argv[1:]) == 1:
            print 'See misspellings.txt~ for all misspelled words found.'
        else:
            for name in tmp_misspelled:
                print 'See', name, 'for misspellings in', name.replace('tmp_misspelled_', '')[:-1]
        dictfile = kwargs.get('dictionary', '.dict4spell.txt')
        print 'When all misspellings are acceptable, cp new_dictionary.txt~',\
              dictfile, '\n'
        sys.exit(1)
    else:
        sys.exit(0)

def _usage_spellcheck():
    print """
doconce spellcheck file1.do.txt file2.do.txt ...  # use .dict4spell.txt
doconce spellcheck -d .mydict.txt file1.do.txt file2.do.txt ...

Spellcheck of files via ispell (but problematic parts are removed from the
files first).

Output:

misspellings.txt~: dictionary of potentially new accepted words, based on all
the current misspellings.

new_dictionary.txt~: suggested new dictionary, consisting of the old and
all new misspellings (if they can be accepted).

tmp_stripped_file1.do.txt: the original files are stripped off for
various constructs that cause trouble in spelling and the stripped
text is found in files with a filename prefix tmp_stripped_ (this file
can be checked for spelling and grammar mistakes in MS Word, for
instance).

Usage
-----

For a new project, do the points below for initializating a new accepted
personal dictionary for this project. Thereafter, the process is
automated: misspellings.txt~ should be empty if there are no new misspellings.
tmp_misspelled*~ are made for each file tested with the file's misspelled
words.

For each file:

  * Run spellcheck.py without a dictionary or with a previous dictionary:
    doconce spellcheck file or doconce spellcheck -d .mydict.txt file
    (default dictionary file is .dict4spell.txt)
  * Check misspelled.txt~ for misspelled words. Change wrong words.
  * Rerun. If all words in misspelled.txt are acceptable,
    copy new_dictionary.txt to .dict4spell.txt (or another name)
  * Optional: import tmp_stripped_text.txt into MS Word for grammar check.
  * Remove tmp_* and *~ files

The next time one can run::

  spellcheck.py file*                   # use .dict4spell.txt
  spellcheck.py -d .mydict.txt file*

misspellings.txt~ should ideally be empty if there are no (new)
spelling errors. One can check that the file is empty or check
the $? variable on Unix since this prorgram exits with 1
when spelling errors are found in any of the tested files::

  # Run spellcheck
  doconce spellcheck *.do.txt
  if [ $? -ne 0 ]; then exit; fi


How to correct misspellings
---------------------------

Some misspellings can be hard to find if the word is strange
(like "emp", for instance). Then invoke ``tmp_stripped_text.txt``,
which is the stripped version of the text file being spellchecked.
All references, labels, code segments, etc., are removed in this
stripped file. Run ispell on the file::

  ispell -l -p.dict4spell.txt tmp_stripped_text.txt

Now, ispell will prompt you for the misspellings and show the context.
A common error in latex is to forget a ``\ref`` or ``\label`` in front
of a label so that the label gets spellchecked.  This may give rise to
strange words flagged as misspelled.

How to control what is stripped
-------------------------------

The spellcheck function loads a file .strip, if present, with
possibly three lists that defines what is being stripped away
in ``tmp_stripped_*`` files:

  * ``environments``, holding begin-end pairs of environments that
    should be entirely removed from the text.
  * ``replacements``, holding (from, to) pairs or (from, to, regex-flags)
    triplets for substituting text.
  * ``common_typos``, holding typical wrong spellings of words.

execfile is applied to .strip to execute the definition of the lists.

"""


def spellcheck():
    if sys.argv[1] == '-d':
        dictionary = [sys.argv[2]]
        del sys.argv[1:3]
    else:
        if os.path.isfile('.dict4spell.txt'):
            dictionary = ['.dict4spell.txt']
        else:
            dictionary = []
    if len(sys.argv) < 2:
        _usage_spellcheck()
        sys.exit(1)

    _spellcheck_all(newdict='misspellings.txt~', remove_multiplicity=False,
                    dictionaries=dictionary,)

# ----------------------- functions for insertdocstr -----------------------

def insertdocstr():
    """
    This scripts first finds all .do.txt (Doconce source code) files in a
    directory tree and transforms these to a format given as command-line
    argument to the present script. The transformed file has the extension
    .dst.txt (dst for Doc STring), regardless of the format.

    In the next phase, all .p.py files (Python files that need preprocessing)
    are visited, and for each file the C-like preprocessor (preprocess.py)
    is run on the file to include .dst.txt files into doc strings.
    The result is an ordinary .py file.

    Example:
    A file basename.p.py has a module doc string which looks like
    '''
    # #include "docstrings/doc1.dst.txt"
    '''

    In the subdirectory docstrings we have the file doc1.do.txt, which
    contains the documentation in Doconce format. The current script
    detects this file, transforms it to be desired format, say Epytext.
    That action results in doc1.epytext. This file is then renamed to
    doc1.dst.txt.

    In the next step, files of the form basename.p.py is visisted, the
    preprocess program is run, and the docstrings/doc1.dst.txt file is
    inserted in the doc string. One can run with Epytext format, which is
    suitable for running Epydoc on the files afterwards, then run with
    Sphinx, and finally re-run with "plain" format such that only quite
    raw plain text appears in the final basename.py file (this is suitable
    for Pydoc, for instance).

    Usage: doconce insertdocstr format root [preprocessor options]
    """

    try:
        format = sys.argv[1]
        root = sys.argv[2]
    except:
        print 'Usage: doconce insertdocstr format root [preprocessor options]'
        sys.exit(1)

    global doconce_program
    if os.path.isfile(os.path.join('bin', 'doconce')):
        doconce_program = 'python ' + os.path.join(os.getcwd(), 'bin', 'doconce')
    else:
        doconce_program = 'doconce'  # must be found somewhere in PATH
    # alternative: use sys.argv[3] argument to tell where to find doconce
    # can then run "bin/doconce insertdocstr bin" from setup.py

    print '\n----- doconce insertdocstr %s %s\nFind and transform doconce files (.do.txt) ...' % (format, root)
    arg = format
    os.path.walk(root, _walker_doconce, arg)

    print 'Find and preprocess .p.py files (insert doc strings etc.)...'
    arg = ' '.join(sys.argv[3:])  # options for preprocessor
    os.path.walk(root, _walker_include, arg)
    print '----- end of doconce insertdocstr -----\n'



# not used:
def _preprocess_all_files(rootdir, options=''):
    """
    Run preprocess on all files of the form basename.p.ext
    in the directory with root rootdir. The output of each
    preprocess run is directed to basename.ext.
    """
    def _treat_a_dir(arg, d, files):
        for f in files:
            path = os.path.join(d, f)
            if '.p.' in f and not '.svn' in f:
                basename_dotp, ext = os.path.splitext(f)
                basename, dotp = os.path.splitext(basename_dotp)
                outfilename = basename + ext
                outpath = os.path.join(d, outfilename)
                cmd = 'preprocess %s %s > %s' % (options, path, outpath)
                system(cmd)

    os.path.walk(rootdir, _treat_a_dir, None)

def _run_doconce(filename_doconce, format):
    """
    Run doconce format filename_doconce.
    The result is a file with extension .dst.txt (same basename
    as filename_doconce).
    """
    if filename_doconce.startswith('__'):
        # old preprocessed file from aborted doconce execution
        print 'skipped', filename_doconce
        return

    global doconce_program # set elsewhere
    cmd = '%s format %s %s' % (doconce_program, format, filename_doconce)
    print 'run', cmd
    failure, outtext = getstatusoutput(cmd)
    if failure:
        raise OSError, 'Could not run\n%s\nin %s\n%s\n\n\n' % \
              (cmd, os.getcwd(), outtext)
    out_filename = outtext.split()[-1]
    root, ext = os.path.splitext(out_filename)
    new_filename = root + '.dst.txt'
    os.rename(out_filename, new_filename)
    print '(renamed %s to %s for possible inclusion in doc strings)\n' % (out_filename, new_filename)

def _walker_doconce(arg, dir, files):
    format = arg
    # we move to the dir:
    origdir = os.getcwd()
    os.chdir(dir)
    for f in files:
        if f[-7:] == '.do.txt':
            _run_doconce(f, format)
    os.chdir(origdir)

def _run_preprocess4includes(filename_dotp_py, options=''):
    pyfile = filename_dotp_py[:-5] + '.py'
    cmd = 'preprocess %s %s > %s' % (options, filename_dotp_py, pyfile)
    print 'run', cmd
    failure, outtext = getstatusoutput(cmd)
    #os.remove(tmp_filename)
    if failure:
        raise OSError, 'Could not run\n%s\nin %s\n%s\n\n\n' % \
              (cmd, os.getcwd(), outtext)

def _walker_include(arg, dir, files):
    options = arg
    # we move to the dir:
    origdir = os.getcwd()
    os.chdir(dir)
    for f in files:
        if f[-5:] == '.p.py':
            _run_preprocess4includes(f, options)
    os.chdir(origdir)

# ----------------------------------------------------------------------


def which(program):
    """
    Mimic the Unix ``which`` command and return the full path of
    a program whose name is in the `program` argument.
    Return None if the program is not found in any of the
    directories in the user's ``PATH`` variable.
    """
    pathdirs = os.environ['PATH'].split(os.pathsep)
    program_path = None
    for d in pathdirs:
        if os.path.isdir(d):
            if os.path.isfile(os.path.join(d, program)):
                program_path = d
                break
    return program_path
