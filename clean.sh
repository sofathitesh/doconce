#!/bin/sh
cd doc/manual; sh clean.sh; cd ../..
cd doc/tutorial; sh clean.sh; cd ../..
cd doc/quickref; sh clean.sh; cd ../..
cd test; sh clean.sh; cd ..

rm -rf doc/api-source/sphinx-rootdir/_build
rm -f lib/doconce/docstrings/docstring.dst.txt

