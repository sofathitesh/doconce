#!/usr/bin/env python
if __name__ == '__main__':
    # (important to not execute anything for epydoc)
    import os
    # the insertdocstr script is part of the Doconce package
    os.system('python ../../bin/doconce insertdocstr plain . ')

    # pack sphinx_themes.zip
    os.system('zip -r shpinx_themes.zip sphinx_themes')

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

