#!/bin/sh
files="tmp_* *~ test.v verify* testdoc.gwiki testdoc.html testdoc.rst* testdoc.txt testdoc.epytext testdoc*.tex testdoc.st testdoc.sphinx.rst *.log sphinx-rootdir"
ls $files 2> /dev/null
rm -rf $files
rm -f test.v

