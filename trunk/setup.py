#!/usr/bin/env python
"""
The doconce package contans the doconce.py script/module and
the DocWriter module (and associated helper modules).

Doconce is a very simple, minimal tagged markup language for
writing software documentation once (i.e., in one place)
and include in many different contexts: Python doc strings,
HTML pages, and LaTeX tutorials/manuals. The doconce.py script
filters Doconce syntax to reStructuredText, plain text,
HTML, LaTeX, Epytext. From reStructuredText one can go to
XML, LaTeX, HTML, (and later) Docbook, OpenOffice, RTF.

DocWriter offers a unified Python syntax (API) for writing
documents from Python scripts. Supported output formats
are Doconce, HTML.

Usage of this setup.py script:

python setup.py install [, --prefix=$PREFIX]

"""
__author__ = 'Hans Petter Langtangen <hpl@simula.no>'
__acknowledgemets__ = 'Johannes H. Ring', 

from distutils.core import setup

# If there are problems with installation, try cd test; ./clean_all.sh

print 'setup.py:'
# Before we can install, we must run doconce_insertdocstr on the files
# in lib/doconce such that documentation is copied from doconce files
# into doc strings in Python files.

import os, sys
# remove files that are to be regenerated:
thisdir = os.getcwd()
os.chdir(os.path.join('lib', 'doconce', 'docstrings'))
failure = os.system('sh ./clean.sh')
if failure:
    print 'Could not run clean.sh in', os.getcwd()
os.chdir(thisdir)
os.chdir(os.path.join('docs', 'tutorial'))
failure = os.system('sh ./clean.sh')
if failure:
    print 'Could not run clean.sh in', os.getcwd()
os.chdir(thisdir)
os.chdir(os.path.join('docs', 'manual'))
failure = os.system('sh ./clean.sh')
if failure:
    print 'Could not run clean.sh in', os.getcwd()
os.chdir(thisdir)

# make sure doconce_insertdocstr finds the local bin/doconce2format
# script, so add the bin dir with full path to the PATH variable first:
os.environ['PATH'] = os.path.join(os.getcwd(), 'bin') + \
                     os.pathsep + os.environ['PATH']
# python bin/doconce_insertdocstr plain lib/doconce:
cmd = 'python ' + os.path.join('bin', 'doconce_insertdocstr') + ' plain ' + os.path.join('lib', 'doconce')
print '\n\nrun', cmd
failure = os.system(cmd) # run preprocessing step
if failure:
    print 'Could not run\n  ', cmd
    sys.exit(1)

setup(
    version = "0.2", 
    author = "Hans Petter Langtangen",
    author_email = "<hpl@simula.no>",
    description = __doc__,
    license = "BSD",
    name = "Doconce",
    url = "",
    package_dir = {'': 'lib'},
    #packages = ['doconce'],
    # list individual modules since .p.py and _update.py etc. are not
    # to be included in an official distribution:
    py_modules = ['doconce.common', 'doconce.doconce', 'doconce.latex',
                  'doconce.rst', 'doconce.sphinx',
                  'doconce.st', 'doconce.plaintext',
                  'doconce.html', 'doconce.epytext',
                  'doconce.DocWriter', 'doconce.gwiki', 
                  'doconce.expand_newcommands',
                  ],
    scripts = [os.path.join('bin', f) for \
               f in 'doconce_insertdocstr', 'doconce2format', \
               'doconce_old2new_format.py', 'doconce_latin2html.py']
    )
    
               

    
