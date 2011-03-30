#!/usr/bin/env python
import os
# the insertdocstr script is part of the Doconce package
os.system('python ../../bin/doconce insertdocstr plain . ')

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

