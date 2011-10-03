#!/bin/sh
files="tmp_* *~ test.v verify* testdoc.gwiki testdoc.html testdoc.rst* testdoc.txt testdoc.epytext testdoc*.tex testdoc.st testdoc.sphinx.rst *.log sphinx-rootdir tmp_encoding.txt tmp1.do.txt tmp2.do.txt"
ls $files 2> /dev/null
rm -rf $files
rm -f test.v

