#!/bin/sh

# make Epydoc API manual of doconce module:
cd ../../lib/doconce/docstrings
doconce2format epytext docstring.do.txt
mv -f docstring.epytext docstring.dst.txt
cd ..
preprocess doconce.p.py > doconce.py
cd ..
rm -rf html
epydoc doconce

# make Sphinx API manual of doconce module:
cd doconce/docstrings
doconce2format sphinx docstring.do.txt
mv -f docstring.rst docstring.dst.txt
cd ..
preprocess doconce.p.py > doconce.py
cd ../../doc/api-source/sphinx-rootdir
make clean
make html

# make ordinary Python module files with doc strings:
cd ../../../lib/doconce/docstrings
doconce2format plain docstring.do.txt
mv -f docstring.txt docstring.dst.txt
cd ..
preprocess doconce.p.py > doconce.py

# copy to api if ok:
cd ../../docs
cp -r api-source/sphinx-rootdir/_build/html api/sphinx
cp -r ../lib/html api/epydoc
rm -rf ../lib/html
