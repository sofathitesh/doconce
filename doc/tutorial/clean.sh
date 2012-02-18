#!/bin/sh
# clean up all files that are easily regenerated by the make.sh script

name=tutorial
files="*~ demo *.log ${name}*.dst.txt ${name}*.html $name.txt ${name}*.tex ${name}_rst.* $name.rst $name.sphinx.rst $name.odt $name.pnd $name.st $name.epytext $name.gwiki ${name}.pyg __tmp.do.txt ._tmp.do.txt ${name}*.ps ${name}*.pdf _*.log *.*xml *.aux *.bbl *.blg *.idx *.ilg *.ind tmp* ${name}*.log ${name}*.dvi *.out sphinx-rootdir collection_of_results.pdf tmp.*"
dir=`pwd`
echo "Removing in $dir:"
/bin/ls $files 2> /dev/null
rm -rf $files
