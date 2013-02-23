#!/bin/sh

# Compile plain HTML doc
doconce format html mydoc.do.txt
pygmentize -f html -O full,style=emacs -o mydoc_plain_pygmentized.html -l html mydoc.html
mv mydoc.html mydoc_plain.html

# Utilize the GitHub theme "minimal" as template
doconce format html mydoc.do.txt --html-template=github_template/template_github_minimal.html
pygmentize -f html -O full,style=emacs -o mydoc_github_pygmentized.html -l html mydoc.html
mv mydoc.html mydoc_github.html

# Utilize the template made from 5620.html
doconce format html mydoc.do.txt --html-template=uio/template_5620.html
mv mydoc.html mydoc_uio.html

# Utilize the vagrant template
cp -r ../../bundled/html_styles/vagrant .
cp vagrant/css/* css/
# Customize the template
doconce replace LogoWord 'DiffEq' vagrant/template_vagrant.html
doconce replace withSubWord '101' vagrant/template_vagrant.html
doconce replace '<a href="">GO TO 1</a>' '<a href="http://wikipedia.org">Wikipedia</a>' vagrant/template_vagrant.html
doconce replace '<a href="">GO TO 2</a>' '<a href="http://wolframalpha.com">WolframAlpha</a>' vagrant/template_vagrant.html
doconce replace 'Here goes a footer, if desired, maybe with a Copyright &copy;' '&copy; 2013' vagrant/template_vagrant.html

doconce format html mydoc.do.txt --html-style=vagrant --html-template=vagrant/template_vagrant.html
pygmentize -f html -O full,style=emacs -o mydoc_vagrant_pygmentized.html -l html mydoc.html
mv mydoc.html mydoc_vagrant.html

# Report about the technology
doconce format html wrapper_tech