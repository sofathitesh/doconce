#!/bin/sh
# test multiple authors:
doconce format HTML testdoc.do.txt
doconce format LaTeX testdoc.do.txt
doconce format plain testdoc.do.txt
doconce format st testdoc.do.txt
doconce format sphinx testdoc.do.txt
mv -f testdoc.rst testdoc.sphinx.rst
doconce format rst testdoc.do.txt
doconce format epytext testdoc.do.txt
doconce format gwiki testdoc.do.txt
