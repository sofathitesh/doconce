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
