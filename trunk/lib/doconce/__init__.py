'''


What Is Doconce?
================


Doconce are two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code doc., 
    etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx
    reStructuredText, Epytext, and even plain text (where non-obvious
    formatting/tags are removed for clear reading). From
    reStructuredText you can go to XML, HTML, and LaTeX.

The first point may be of interest even if you adopt a different
markup language than Doconce (e.g., reStructuredText). 

Documentation of Doconce is found in

  * The tutorial in tutorial/tutorial.do.txt (file paths are here given
    relative to the root of the Doconce source code).

  * The more comprehensive documentation in lib/doconce/doc/doconce.do.txt.

Both directories contain a make.sh file for creating various formats.
'''

__version__ = '0.5'
version = __version__
__author__ = 'Hans Petter Langtangen', 'Johannes H. Ring'
author = __author__

__acknowledgmets__ = ''

from doconce import main

