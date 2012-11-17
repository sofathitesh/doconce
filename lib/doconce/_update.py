#!/usr/bin/env python
if __name__ == '__main__':
    # (important to not execute anything for epydoc)
    import os
    # the insertdocstr script is part of the Doconce package
    os.system('python ../../bin/doconce insertdocstr plain . ')

    # pack zip files distributed as data with doconce
    os.system('zip -r shpinx_themes.zip sphinx_themes')
    os.system('zip -r html_images.zip html_images')
    if not os.path.isdir('reveal.js'):
        os.system('git clone git://github.com/hakimel/reveal.js.git')
    else:
        os.system('cd reveal.js; git pull origin master; cd ..')
    os.system('zip -r reveal.js.zip reveal.js')
    os.system('zip -d .git reveal.js.zip')

    # remove files that are to be regenerated:
    os.chdir(os.path.join(os.pardir, os.pardir))
    thisdir = os.getcwd()
    os.chdir(os.path.join('lib', 'doconce', 'docstrings'))
    failure = os.system('sh ./clean.sh')
    if failure:
        print 'Could not run clean.sh in', os.getcwd()
    os.chdir(thisdir)
    os.chdir(os.path.join('doc', 'tutorial'))
    failure = os.system('sh ./clean.sh')
    if failure:
        print 'Could not run clean.sh in', os.getcwd()
    os.chdir(thisdir)
    os.chdir(os.path.join('doc', 'manual'))
    failure = os.system('sh ./clean.sh')
    if failure:
        print 'Could not run clean.sh in', os.getcwd()
    os.chdir(thisdir)
    os.chdir('test')
    failure = os.system('sh ./clean.sh')
    if failure:
        print 'Could not run clean.sh in', os.getcwd()
    os.chdir(thisdir)

