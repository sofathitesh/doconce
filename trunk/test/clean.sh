#!/bin/sh
files="tmp_* *~ test.v verify* testdoc.gwiki testdoc.html testdoc.rst* testdoc.txt testdoc.epytext testdoc.st *.log"
ls $files 2> /dev/null
rm -rf $files
