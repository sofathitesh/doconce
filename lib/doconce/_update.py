#!/usr/bin/env python

def system(cmd):
    print cmd
    failure = os.system(cmd)
    if failure:
        print 'could not run\n%s\in%s' % (cmd, os.getcwd())

def zip_dir(dirname):
    if not os.path.isdir('tmp'):
        os.mkdir('tmp')
    system('mv -f %s/.git tmp/' % dirname)
    system('zip -r %s.zip %s' % (dirname, dirname))
    system('mv tmp/.git %s/' % dirname)

if __name__ == '__main__':
    # (important to not execute anything for epydoc)
    import os
    # the insertdocstr script is part of the Doconce package
    ##system('python ../../bin/doconce insertdocstr plain . ')

    # pack zip files distributed as data with doconce
    ##system('zip -r sphinx_themes.zip sphinx_themes')
    os.chdir('html_software')
    system('zip -r html_images.zip html_images')
    if not os.path.isdir('reveal.js'):
        system('git clone git://github.com/hakimel/reveal.js.git')
    else:
        system('cd reveal.js; git pull origin master; cd ..')
    os.system('cp reveal_doconce/css/reveal*.css reveal.js/css/')
    os.system('cp reveal_doconce/css/theme/*.css reveal.js/css/theme/')
    zip_dir('reveal.js')
    if not os.path.isdir('csss'):
        system('git clone git://github.com/LeaVerou/csss.git')
    else:
        system('cd csss; git pull origin master; cd ..')
    zip_dir('csss')
    if not os.path.isdir('deck.js'):
        system('git clone git://github.com/imakewebthings/deck.js.git')
    else:
        system('cd deck.js; git pull origin master; cd ..')
    if not os.path.isdir('mnml'):
        system('git clone git://github.com/duijf/mnml.git')
    else:
        system('cd mnml; git pull origin master; cd ..')
    system('cp mnml/mnml.css deck.js/themes/style')
    if not os.path.isdir('deckjs-theme-mozilla'):
        system('git clone git://github.com/groovecoder/deckjs-theme-mozilla.git')
    else:
        system('cd deckjs-theme-mozilla; git pull origin master; cd ..')
    system('cp deckjs-theme-mozilla/*.*css deck.js/themes/style')
    if not os.path.isdir('deck.js-codemirror'):
        system('git clone git://github.com/iros/deck.js-codemirror.git')
    else:
        system('cd deck.js-codemirror; git pull origin master; cd ..')
    if not os.path.isdir('deck.js/extensions/codemirror'):
        os.mkdir('deck.js/extensions/codemirror')
    system('cp -r deck.js-codemirror/* deck.js/extensions/codemirror/')
    if not os.path.isdir('deck.ext.js'):
        system('git clone git://github.com/barraq/deck.ext.js.git')
    else:
        system('cd deck.ext.js; git pull origin master; cd ..')
    system('cp -r deck.ext.js/themes/style/*.*css deck.js/themes/style/')
    if not os.path.isdir('deck.pointer.js'):
        system('git clone git://github.com/mikeharris100/deck.pointer.js.git')
    else:
        system('cd deck.pointer.js; git pull origin master; cd ..')
    if not os.path.isdir('deck.js/extensions/pointer'):
        os.mkdir('deck.js/extensions/pointer')
    system('cp -r deck.pointer.js/deck.pointer.* deck.js/extensions/pointer/')
    if not os.path.isdir('presenterview'):
        system('git clone git://github.com/stvnwrgs/presenterview.git')
    else:
        system('cd presenterview; git pull origin master; cd ..')
    system('cp -r presenterview/ deck.js/extensions/')
    if not os.path.isdir('deck.annotate.js'):
        system('git clone git://github.com/nemec/deck.annotate.js.git')
    else:
        system('cd deck.annotate.js; git pull origin master; cd ..')
    system('cp -r deck.annotate.js deck.js/extensions/')

    system("find deck.js/extensions -name '.git' -exec rm -rf {} \;")
    zip_dir('deck.js')

    """
    # No need to pack these - the styles and scripts are embedded
    if not os.path.isdir('dzslides'):
        system('git clone git://github.com/paulrouget/dzslides.git')
    else:
        system('cd dzslides; git pull origin master; cd ..')
    system('zip -r dzslides.zip dzslides')
    system('zip -d .git dzslides.zip')
    """
    system('cp *.zip ..')
    os.chdir(os.pardir)

    # remove files that are to be regenerated:
    os.chdir(os.path.join(os.pardir, os.pardir))
    thisdir = os.getcwd()
    os.chdir(os.path.join('lib', 'doconce', 'docstrings'))
    system('sh ./clean.sh')
    os.chdir(thisdir)
    os.chdir(os.path.join('doc', 'tutorial'))
    system('sh ./clean.sh')
    os.chdir(thisdir)
    os.chdir(os.path.join('doc', 'manual'))
    system('sh ./clean.sh')
    os.chdir(thisdir)
    os.chdir(os.path.join('doc', 'quickref'))
    system('sh ./clean.sh')
    os.chdir(thisdir)
    os.chdir(os.path.join('doc', 'slides'))
    system('sh ./clean.sh')
    os.chdir(thisdir)
    os.chdir('test')
    system('sh ./clean.sh')
    os.chdir(thisdir)
    os.chdir('test')
    system('sh ./clean.sh')
    os.chdir(thisdir)

