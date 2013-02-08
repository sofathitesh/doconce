import sys, os

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
    ('--html-solarized',
     'Use a solarized color theme in HTML output.'),
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
