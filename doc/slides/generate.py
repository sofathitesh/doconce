import os, shutil, sys

def system(cmd):
    print cmd
    failure = os.system(cmd)
    if failure:
        print 'could not run', cmd
        sys.exit(1)

from collections import OrderedDict as dict
themes = dict(
    reveal=['beige', 'default', 'night', 'simple', 'sky'],
    deck=['neon', 'swiss','web-2', 'mnml', 'sandstone','sandstone.aurora',
          'sandstone.dark', 'sandstone.default', 'sandstone.firefox',
          'sandstone.light', 'sandstone.mdn', 'sandstone.nightly',
          'beamer'],
    csss=['default'],
    dzslides=['default'],
    )

dark_styles = ['night', 'neon', 'sandstone.aurora', 'sandstone.dark',
               'sandstone.mdn', 'sandstone.nightly']
dark_pygments=['monokai', 'fruity', 'native']
light_pygments = ['default', 'manni', 'autumn', 'perldoc', 'emacs']

system('sh clean.sh')

def generate(name):
    for slide_system in themes:
        for theme in themes[slide_system]:
            if theme in dark_styles:
                pygm_style = dark_pygments[0]
            else:
                pygm_style = 'default'
            system('doconce replace XXX %s %s.do.txt' % (slide_system, name))
            system('doconce replace YYY %s %s.do.txt' % (theme, name))
            system('doconce replace ZZZ %s %s.do.txt' % (pygm_style, name))

            system('doconce format html %s --pygments-html-style=%s' %
                   (name, pygm_style))
            system('doconce slides_html %s %s --html-slide-theme=%s' %
                   (name, slide_system, theme))
            shutil.copy('%s.html' % name, '%s_%s_%s_%s.html' %
                        (name, slide_system, theme, pygm_style))
            #sys.exit(0)

generate('demo')
