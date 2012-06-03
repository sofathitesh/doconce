#!/bin/sh
files="tmp_* *~ test.v verify* testdoc.*wiki testdoc.html testdoc.rst* testdoc.txt testdoc.epytext testdoc*.tex testdoc.st testdoc.mkd testdoc.sphinx.rst *.log sphinx-rootdir tmp_encoding.txt tmp1.do.txt tmp2.do.txt wavepacket*.html mjolnir.html tmp* *.aux *.dvi *.idx *.out testdoc.pdf _static"
ls $files 2> /dev/null
rm -rf $files
rm -f test.v

