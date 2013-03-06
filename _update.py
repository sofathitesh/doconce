#!/usr/bin/env python
import sys, os, shutil, glob

def system(cmd):
    print cmd
    failure = os.system(cmd)
    if failure:
        print 'could not run\n%s\nin%s' % (cmd, os.getcwd())
        sys.exit(1)

def rmtree(directory):
    try:
        shutil.rmtree(directory)
    except OSError:
        pass # OK if the directory does not exist

def zip_dir(dirname):
    os.system('rm -rf %s/.git' % dirname)  # remove .git, all will be removed...
    system('zip -r %s.zip %s' % (dirname, dirname))

def insertdoc():
    # To run from the root dir
    system('python bin/doconce insertdocstr plain lib/doconce')

def wide_clean():
    # remove files that are to be regenerated:
    #system('sh clean.sh')
    # (must be in the root directory)
    thisdir = os.getcwd()
    dirs = [os.path.join('lib', 'doconce', 'docstrings'),
            os.path.join('doc', 'tutorial'),
            os.path.join('doc', 'manual'),
            os.path.join('doc', 'quickref'),
            os.path.join('doc', 'slides'),
            os.path.join('doc', 'blog'),
            'test',
            'bundled',
            ]
    for d in dirs:
        os.chdir(d)
        system('sh ./clean.sh')
        os.chdir(thisdir)

def pack_local_dirs():
    system('zip -r sphinx_themes.zip sphinx_themes')
    system('zip -r html_images.zip html_images')

    # Pack latex styles and figures in a zip file without any directory.
    # minted.sty and anslistings.sty are not copied from some
    # repo every time, so get the latest versions from ptex2tex manually.
    os.chdir('latex_styles')
    system('zip latex_styles.zip *.sty *.pdf *.pdf *.eps')
    system('mv -f latex_styles.zip ..')
    os.chdir(os.pardir)

    zipfiles2lib()


def zipfiles2lib():
    for zfile in glob.glob('*.zip'):
        shutil.copy(zfile, os.path.join(os.pardir, 'lib', 'doconce', zfile))


def pack_reveal_deck_csss():
    system('sh clean.sh')

    rmtree('reveal.js')
    system('git clone git://github.com/hakimel/reveal.js.git')
    os.system('cp doconce_modifications/reveal/css/reveal*.css reveal.js/css/')
    os.system('cp doconce_modifications/reveal/css/theme/*.css reveal.js/css/theme/')
    zip_dir('reveal.js')

    rmtree('csss')
    system('git clone git://github.com/LeaVerou/csss.git')
    os.system('cp doconce_modifications/csss/*.css csss/')
    zip_dir('csss')

    rmtree('deck.js')
    system('git clone git://github.com/imakewebthings/deck.js.git')
    rmtree('mnml')
    system('git clone git://github.com/duijf/mnml.git')
    system('cp mnml/mnml.css deck.js/themes/style')
    rmtree('deckjs-theme-mozilla')
    system('git clone git://github.com/groovecoder/deckjs-theme-mozilla.git')
    system('cp deckjs-theme-mozilla/*.*css deck.js/themes/style')
    rmtree('deck.js-codemirror')
    system('git clone git://github.com/iros/deck.js-codemirror.git')
    os.mkdir('deck.js/extensions/codemirror')
    system('cp -r deck.js-codemirror/* deck.js/extensions/codemirror/')
    rmtree('deck.ext.js')
    system('git clone git://github.com/barraq/deck.ext.js.git')
    system('cp -r deck.ext.js/themes/style/*.*css deck.js/themes/style/')
    rmtree('deck.pointer.js')
    system('git clone git://github.com/mikeharris100/deck.pointer.js.git')
    os.mkdir('deck.js/extensions/pointer')
    system('cp -r deck.pointer.js/deck.pointer.* deck.js/extensions/pointer/')
    rmtree('presenterview')
    system('git clone git://github.com/stvnwrgs/presenterview.git')
    system('cp -r presenterview/ deck.js/extensions/')
    rmtree('deck.annotate.js')
    system('git clone git://github.com/nemec/deck.annotate.js.git')
    system('cp -r deck.annotate.js deck.js/extensions/')

    system('cp doconce_modifications/deck/core/*.css deck.js/core/')
    system('cp doconce_modifications/deck/themes/style/*.css deck.js/themes/style/')
    # this find will always generate errors..., use os.system
    os.system("find deck.js/extensions -name '.git' -exec rm -rf {} \;")
    zip_dir('deck.js')

    zipfiles2lib()

def run_all():
    # pack zip files distributed as data with doconce
    pack_local_dirs()
    pack_reveal_deck_csss()

    # back to root dir
    os.chdir(os.pardir)

    insertdoc()
    wide_clean()


if __name__ == '__main__':
    software_dir = 'bundled'
    os.chdir(software_dir)
    os.system('rm -f *.zip')

    if len(sys.argv) == 1:
        print 'Usage: python _update.py all | local'
        sys.exit(1)
    if sys.argv[1] == 'all':
        run_all()
    else:
        #func = sys.argv[1]
        #eval(func + '()')
        pack_local_dirs()

    print 'Successful execution of', sys.argv[0]
