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
    csss=None,
    dzslides=None,
    )

for slide_system in themes:
    if themes[slide_system] is not None:
        for theme in themes[slide_system]:
            system('doconce format html demo')
            system('doconce slides_html demo %s --html-slide-theme=%s' %
                      (slide_system, theme))
            shutil.copy('demo.html', 'demo_%s_%s.html' % (slide_system, theme))
            #sys.exit(0)
    else:
        system('doconce format html demo')
        system('doconce slides_html demo %s' % slide_system)
        shutil.copy('demo.html', 'demo_%s.html' % slide_system)

