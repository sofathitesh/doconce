#!/bin/sh
# test multiple authors:
doconce2format HTML testdoc.do.txt
doconce2format LaTeX testdoc.do.txt
doconce2format plain testdoc.do.txt
doconce2format st testdoc.do.txt
doconce2format sphinx testdoc.do.txt
mv -f testdoc.rst testdoc.sphinx.rst
doconce2format rst testdoc.do.txt
doconce2format epytext testdoc.do.txt
doconce2format gwiki testdoc.do.txt
