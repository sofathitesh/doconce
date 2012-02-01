#!/usr/bin/env python
"""
Usage of this setup.py script:

python setup.py install [, --prefix=$PREFIX]

"""
__author__ = 'Hans Petter Langtangen <hpl@simula.no>'
__acknowledgemets__ = 'Johannes H. Ring',

from distutils.core import setup

import os, sys

# Make sure we import from doconce in this package, not an installed one:
# (need this for extracting the version below)
sys.path.insert(0, os.path.join('lib')); import doconce

setup(
    version = str(doconce.version),
    author = "Hans Petter Langtangen",
    author_email = "<hpl@simula.no>",
    description = __doc__,
    license = "BSD",
    name = "Doconce",
    url = "http://doconce.googlecode.com",
    package_dir = {'': 'lib'},
    packages = ['doconce'],
    # list individual modules since .p.py and _update.py etc. are not
    # to be included in an official distribution (note: this does not work
    # with package_data - must just specify the package name)
    #py_modules = ['doconce.common', 'doconce.doconce', 'doconce.latex',
    #              'doconce.rst', 'doconce.sphinx',
    #              'doconce.st', 'doconce.plaintext',
    #              'doconce.html', 'doconce.epytext',
    #              'doconce.DocWriter', 'doconce.gwiki', 'doconce.mwiki',
    #              #'doconce.pandoc',
    #             'doconce.expand_newcommands',
    #             ],
    package_data = {'': ['sphinx_themes.zip']},
    scripts = [os.path.join('bin', f) for f in ['doconce']],
    data_files=[(os.path.join("share", "man", "man1"),
                 [os.path.join("doc", "man", "man1", "doconce.1.gz"),]),
                ],
    )

