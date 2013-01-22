import sys, os

_legal_command_line_options = [
    '--help',
    '--debug',
    '--no-abort',
    '--skip_inline_comments',
    '--encoding=',
    '--oneline_paragraphs',
    '--no-mako',
    '--no-preprocess',
    '--no-pygments-html',
    '--minted-latex-style=',
    '--pygments-html-style=',
    '--pygments-html-linenos',
    '--html-solarized',
    '--html-template=',
    '--html-slide-theme=',
    '--latex-printed',
    '--html-color-admon',
    '--css=',
    '--verbose',
    '--example-as-exercise',
    '--wordpress',
    ]

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
        if default is not None:
            return default
        else:
            return False
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
