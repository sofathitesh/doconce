
************** File: tutorial.do.txt *****************
TITLE: Doconce: Document Once, Include Everywhere
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: July 30, 2010


# lines beginning with # are comment lines

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

If any of these questions are of interest, you should keep on reading.


===== The Doconce Concept  =====

Doconce is two things:

  o Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).
    
  o Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).


===== What Does Doconce Look Like? =====

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterix,

  * *emphasized words* are surrounded by an asterix, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,
 
  * there is support oforboth LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

Here is an example of some simple text written in the Doconce format:
!bc
===== A Subsection with Sample Text =====

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have automatically numbered items instead of bullets,

  o item 1
  o item 2
  o item 3

URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
!ec
The Doconce text above results in the following little document:

===== A Subsection with Sample Text =====

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have numbered items instead of bullets, just use an
o (for ordered) instead of the asterix:

  o item 1
  o item 2
  o item 3

URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|


===== Mathematics and Computer Code =====

Inline mathematics, such as $\nu = \sin(x)$|$v = sin(x)$,
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like $\nu = \sin(x)$|$v = sin(x)$ is
typeset as
!bc
$\nu = \sin(x)$|$v = sin(x)$
!ec
The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside
`!bt` and `!et` (begin tex / end tex) instructions. 
The result looks like this:
!bt
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
!et
Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
`!bc` and `!ec` instructions, respectively. Such blocks look like
!bc
from math import sin, pi
def myfunc(x):
    return sin(pi*x)

import integrate
I = integrate.trapezoidal(myfunc, 0, pi, 100)
!ec

One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing `#include "mynote.do.txt"`
on a line starting with (another) hash sign.  Doconce documents have
extension `do.txt`. The `do` part stands for doconce, while the
trailing `.txt` denotes a text document so that editors gives you the
right writing enviroment for plain text.


===== Seeing More of What Doconce Is ===== 

After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder `doc/tutorial.do.txt` in the
source code tree of Doconce. The Doconce example documentation
displays both the source `tutorial.do.txt` and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file `lib/doconce/doc/doconce.do.txt` in the Doconce
source code tree. The same documentation appears in the doc string of
the `doconce` module.

# Example on including another Doconce file:

# #include "_doconce2anything.do.txt"


=== Demos ===

The current text is generated from a Doconce format stored in the file
!bc
tutorial/tutorial.do.txt
!ec
The file `make.sh` in the `tutorial` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, `tutorial.do.txt` is the
starting point.  Running `make.sh` and studying the various generated
files and comparing them with the original `doconce.do.txt` file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the `lib/doconce/doc` directory which
translates the more comprehensive documentation, `doconce.do.txt`, to
various formats.  For example, to go from the LaTeX format to PDF, see
`latex.sh`.


===== The Doconce Documentation Strategy for User Manuals ===== 

Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the `doconce2format` script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
`#include` statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a `basename.p.py` file.
The `.p.py` extension identifies this as a file that has to be
preprocessed) by the `preprocess` program. 
In a doc string in `basename.p.py` we do a preprocessor include
in a comment line, say
!bc
#    #include "docstrings/doc1.dst.txt
!ec
#
# Note: we insert an error right above as the right quote is missing.
# Then preprocess skips the statement, otherwise it gives an error
# message about a missing file docstrings/doc1.dst.txt (which we don't
# have, it's just a sample file name). Also note that comment lines
# must not come before a code block for the rst/st/epytext formats to work.
#
The file `docstrings/doc1.dst.txt` is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named `docstrings/doc1.do.txt`. The `.dst.txt`
is the extension of a file filtered ready for being included in a doc
string (`d` for doc, `st` for string).

For making an Epydoc manual, the `docstrings/doc1.do.txt` file is
filtered to `docstrings/doc1.epytext` and renamed to
`docstrings/doc1.dst.txt`.  Then we run the preprocessor on the
`basename.p.py` file and create a real Python file
`basename.py`. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce `docstrings/doc1.do.txt` file is filtered to
`docstrings/doc1.rst` and renamed to `docstrings/doc1.dst.txt`. A
Sphinx directory must have been made with the right `index.rst` and
`conf.py` files. Going to this directory and typing `make html` makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter `docstrings/doc1.do.txt` to plain text format
(`docstrings/doc1.txt`) and rename to `docstrings/doc1.dst.txt`. The
preprocessor transforms the `basename.p.py` file to a standard Python
file `basename.py`. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the `insertdocstr.py` script.  Here are the corresponding Unix
commands:

!bc
# make Epydoc API manual of basename module:
cd docstrings
doconce2format epytext doc1.do.txt
mv doc1.epytext doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
epydoc basename

# make Sphinx API manual of basename module:
cd doc
doconce2format sphinx doc1.do.txt
mv doc1.rst doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
cd docstrings/sphinx-rootdir  # sphinx directory for API source
make clean
make html
cd ../..

# make ordinary Python module files with doc strings:
cd docstrings
doconce2format plain doc1.do.txt
mv doc1.txt doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py

# can automate inserting doc strings in all .p.py files:
insertdocstr.py plain .
# (runs through all .do.txt files and filters them to plain format and
# renames to .dst.txt extension, then the script runs through all 
# .p.py files and runs the preprocessor, which includes the .dst.txt
# files)
!ec


======= Warning/Disclaimer =======

Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.

************** File: tutorial.html *****************

    <html>
    <body bgcolor="white">
    <title>Doconce: Document Once, Include Everywhere</title>
<center><h1>Doconce: Document Once, Include Everywhere</h1></center>
<center><h3>Hans Petter Langtangen<br>Simula Research Laboratory and University of Oslo</h3></center>
<center><h3>July 30, 2010</h3></center>
<p>

<p>
<!-- lines beginning with # are comment lines -->

<p>

<ul>
 <li> When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

<p>
 <li> Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

<p>
</ul>

If any of these questions are of interest, you should keep on reading.

<p>

<p>
<h3>The Doconce Concept</h3>
<p>
Doconce is two things:

<p>

<ol>
 <li> Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

<p>
 <li> Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).

<p>

<p>
</ol>
<h3>What Does Doconce Look Like?</h3>
<p>
Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

<p>

<ul>
  <li> bullet lists arise from lines starting with an asterix,

<p>
  <li> <em>emphasized words</em> are surrounded by an asterix, 

<p>
  <li> <b>words in boldface</b> are surrounded by underscores, 

<p>
  <li> words from computer code are enclosed in back quotes and 
    then typeset verbatim,

<p>
  <li> blocks of computer code can easily be included, also from source files,

<p>
  <li> blocks of LaTeX mathematics can easily be included,

<p>
  <li> there is support oforboth LaTeX and text-like inline mathematics,

<p>
  <li> figures with captions, URLs with links, labels and references
    are supported,

<p>
  <li> comments can be inserted throughout the text,

<p>
  <li> a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

<p>
</ul>

Here is an example of some simple text written in the Doconce format:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
===== A Subsection with Sample Text =====

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have automatically numbered items instead of bullets,

  o item 1
  o item 2
  o item 3

URLs with a link word are possible, as in http://folk.uio.no/hpl&lt;hpl&gt;.
Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The Doconce text above results in the following little document:

<p>
<h3>A Subsection with Sample Text</h3>
<p>
Ordinary text looks like ordinary text, and the tags used for
<b>boldface</b> words, <em>emphasized</em> words, and <tt>computer</tt> words look
natural in plain text.  Lists are typeset as you would do in an email,

<p>

<ul>
  <li> item 1
  <li> item 2
  <li> item 3

<p>
</ul>

Lists can also have numbered items instead of bullets, just use an

<ol>
<li> (for ordered) instead of the asterix:

<p>

<ol>
 <li> item 1
 <li> item 2
 <li> item 3

<p>
</ol>

</ol>

URLs with a link word are possible, as in <a href="http://folk.uio.no/hpl">hpl</a>.
Tables are also supperted, e.g.,

<p>
<TABLE border="1">
<TR><TD><B>    time    </B></TD> <TD><B>  velocity  </B></TD> <TD><B>acceleration</B></TD> </TR>
<TR><TD>   0.0             </TD> <TD>   1.4186          </TD> <TD>   -5.01           </TD> </TR>
<TR><TD>   2.0             </TD> <TD>   1.376512        </TD> <TD>   11.919          </TD> </TR>
<TR><TD>   4.0             </TD> <TD>   1.1E+1          </TD> <TD>   14.717624       </TD> </TR>
</TABLE>
<p>

<p>
<h3>Mathematics and Computer Code</h3>
<p>
Inline mathematics, such as v = sin(x),
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like v = sin(x) is
typeset as
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
$\nu = \sin(x)$|$v = sin(x)$
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

<p>
Blocks of mathematics are better typeset with raw LaTeX, inside
<tt>!bt</tt> and <tt>!et</tt> (begin tex / end tex) instructions. 
The result looks like this:
<blockquote><pre>
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
</pre></blockquote>
Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

<p>
You can have blocks of computer code, starting and ending with
<tt>!bc</tt> and <tt>!ec</tt> instructions, respectively. Such blocks look like
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
from math import sin, pi
def myfunc(x):
    return sin(pi*x)

import integrate
I = integrate.trapezoidal(myfunc, 0, pi, 100)
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>
One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

<p>
Another document can be included by writing <tt>#include "mynote.do.txt"</tt>
on a line starting with (another) hash sign.  Doconce documents have
extension <tt>do.txt</tt>. The <tt>do</tt> part stands for doconce, while the
trailing <tt>.txt</tt> denotes a text document so that editors gives you the
right writing enviroment for plain text.

<p>

<p>
<h3>Seeing More of What Doconce Is</h3>
<p>
After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder <tt>doc/tutorial.do.txt</tt> in the
source code tree of Doconce. The Doconce example documentation
displays both the source <tt>tutorial.do.txt</tt> and the result of many other
formats.

<p>
A more complete documentation of and motivation for Doconce appears
in the file <tt>lib/doconce/doc/doconce.do.txt</tt> in the Doconce
source code tree. The same documentation appears in the doc string of
the <tt>doconce</tt> module.

<p>
<!-- Example on including another Doconce file: -->

<p>

<p>
<h3>From Doconce to Other Formats</h3>
<p>
Transformation of a Doconce document to various other
formats applies the script <tt>doconce2format</tt>:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format format mydoc.do.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The <tt>preprocess</tt> program is always used to preprocess the file first,
and options to <tt>preprocess</tt> can be added after the filename. For example,
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The variable <tt>FORMAT</tt> is always defined as the current format when
running <tt>preprocess</tt>. That is, in the last example, <tt>FORMAT</tt> is
defined as <tt>LaTeX</tt>. Inside the Doconce document one can then perform
format specific actions through tests like <tt>#if FORMAT == "LaTeX"</tt>.

<p>

<p>
<h5>HTML</h5>
<p>
Making an HTML version of a Doconce file <tt>mydoc.do.txt</tt>
is performed by
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format HTML mydoc.do.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The resulting file <tt>mydoc.html</tt> can be loaded into any web browser for viewing.

<p>
<h5>LaTeX</h5>
<p>
Making a LaTeX file <tt>mydoc.tex</tt> from <tt>mydoc.do.txt</tt> is done in two steps:
<!-- Note: putting code blocks inside a list is not successful in many -->
<!-- formats - the text may be messed up. A better choice is a paragraph -->
<!-- environment, as used here. -->

<p>
<b>Step 1.</b> Filter the doconce text to a pre-LaTeX form <tt>mydoc.p.tex</tt> for
     <tt>ptex2tex</tt>:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format LaTeX mydoc.do.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file <tt>newcommands.tex</tt>. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

<p>
<b>Step 2.</b> Run <tt>ptex2tex</tt> (if you have it) to make a standard LaTeX file,
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> ptex2tex mydoc
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
     or just perform a plain copy,
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> cp mydoc.p.tex mydoc.tex
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The <tt>ptex2tex</tt> tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile <tt>mydoc.tex</tt> the usual way and create the PDF file.

<p>
<h5>Plain ASCII Text</h5>
<p>
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>
<h5>reStructuredText</h5>
<p>
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file <tt>mydoc.rst</tt>:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format rst mydoc.do.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
We may now produce various other formats:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The OpenOffice file <tt>mydoc.odt</tt> can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

<p>
<h5>Sphinx</h5>
<p>
Sphinx documents can be created from a Doconce source in a few steps.

<p>
<b>Step 1.</b> Translate Doconce into the Sphinx dialect of
the reStructuredText format:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> doconce2format sphinx mydoc.do.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>
<b>Step 2.</b> Create a Sphinx root directory with a <tt>conf.py</tt> file, 
either manually or by using the interactive <tt>sphinx-quickstart</tt>
program. Here is a scripted version of the steps with the latter:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
mkdir sphinx-rootdir
sphinx-quickstart <<EOF
sphinx-rootdir
n
_
Name of My Sphinx Document
Author
version
version
.rst
index
y
n
n
n
n
y
n
n
y
y
EOF
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>
<b>Step 3.</b> Move the <tt>tutorial.rst</tt> file to the Sphinx root directory:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> mv mydoc.rst sphinx-rootdir
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>
<b>Step 4.</b> Edit the generated <tt>index.rst</tt> file so that <tt>mydoc.rst</tt>
is included, i.e., add <tt>mydoc</tt> to the <tt>toctree</tt> section so that it becomes
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
.. toctree::
   :maxdepth: 2

   mydoc
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
(The spaces before <tt>mydoc</tt> are important!)

<p>
<b>Step 5.</b> Generate, for instance, an HTML version of the Sphinx source:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
make clean   # remove old versions
make html
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
Many other formats are also possible.

<p>
<b>Step 6.</b> View the result:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
Unix/DOS> firefox _build/html/index.html
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>

<p>

<p>
<h5>Demos</h5>
<p>
The current text is generated from a Doconce format stored in the file
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
tutorial/tutorial.do.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
The file <tt>make.sh</tt> in the <tt>tutorial</tt> directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, <tt>tutorial.do.txt</tt> is the
starting point.  Running <tt>make.sh</tt> and studying the various generated
files and comparing them with the original <tt>doconce.do.txt</tt> file,
gives a quick introduction to how Doconce is used in a real case.

<p>
There is another demo in the <tt>lib/doconce/doc</tt> directory which
translates the more comprehensive documentation, <tt>doconce.do.txt</tt>, to
various formats.  For example, to go from the LaTeX format to PDF, see
<tt>latex.sh</tt>.

<p>

<p>
<h3>The Doconce Documentation Strategy for User Manuals</h3>
<p>
Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the <tt>doconce2format</tt> script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
<tt>#include</tt> statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

<p>
Consider an example involving a Python module in a <tt>basename.p.py</tt> file.
The <tt>.p.py</tt> extension identifies this as a file that has to be
preprocessed) by the <tt>preprocess</tt> program. 
In a doc string in <tt>basename.p.py</tt> we do a preprocessor include
in a comment line, say
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
#    #include "docstrings/doc1.dst.txt
</pre></blockquote>
<! -- END VERBATIM BLOCK -->
<!--  -->
<!-- Note: we insert an error right above as the right quote is missing. -->
<!-- Then preprocess skips the statement, otherwise it gives an error -->
<!-- message about a missing file docstrings/doc1.dst.txt (which we don't -->
<!-- have, it's just a sample file name). Also note that comment lines -->
<!-- must not come before a code block for the rst/st/epytext formats to work. -->
<!--  -->
The file <tt>docstrings/doc1.dst.txt</tt> is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named <tt>docstrings/doc1.do.txt</tt>. The <tt>.dst.txt</tt>
is the extension of a file filtered ready for being included in a doc
string (<tt>d</tt> for doc, <tt>st</tt> for string).

<p>
For making an Epydoc manual, the <tt>docstrings/doc1.do.txt</tt> file is
filtered to <tt>docstrings/doc1.epytext</tt> and renamed to
<tt>docstrings/doc1.dst.txt</tt>.  Then we run the preprocessor on the
<tt>basename.p.py</tt> file and create a real Python file
<tt>basename.py</tt>. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce <tt>docstrings/doc1.do.txt</tt> file is filtered to
<tt>docstrings/doc1.rst</tt> and renamed to <tt>docstrings/doc1.dst.txt</tt>. A
Sphinx directory must have been made with the right <tt>index.rst</tt> and
<tt>conf.py</tt> files. Going to this directory and typing <tt>make html</tt> makes
the HTML version of the Sphinx API documentation.

<p>
The next step is to produce the final pure Python source code. For
this purpose we filter <tt>docstrings/doc1.do.txt</tt> to plain text format
(<tt>docstrings/doc1.txt</tt>) and rename to <tt>docstrings/doc1.dst.txt</tt>. The
preprocessor transforms the <tt>basename.p.py</tt> file to a standard Python
file <tt>basename.py</tt>. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the <tt>insertdocstr.py</tt> script.  Here are the corresponding Unix
commands:
<!-- BEGIN VERBATIM BLOCK  -->
<blockquote><pre>
# make Epydoc API manual of basename module:
cd docstrings
doconce2format epytext doc1.do.txt
mv doc1.epytext doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
epydoc basename

# make Sphinx API manual of basename module:
cd doc
doconce2format sphinx doc1.do.txt
mv doc1.rst doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
cd docstrings/sphinx-rootdir  # sphinx directory for API source
make clean
make html
cd ../..

# make ordinary Python module files with doc strings:
cd docstrings
doconce2format plain doc1.do.txt
mv doc1.txt doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py

# can automate inserting doc strings in all .p.py files:
insertdocstr.py plain .
# (runs through all .do.txt files and filters them to plain format and
# renames to .dst.txt extension, then the script runs through all 
# .p.py files and runs the preprocessor, which includes the .dst.txt
# files)
</pre></blockquote>
<! -- END VERBATIM BLOCK -->

<p>

<p>
<h1>Warning/Disclaimer</h1>
<p>
Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.

    </body>
    </html>
    
************** File: tutorial.txt *****************
TITLE: Doconce: Document Once, Include Everywhere
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: July 30, 2010



 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
-------------------

Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).


What Does Doconce Look Like?
----------------------------

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterix,

  * *emphasized words* are surrounded by an asterix, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support oforboth LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

Here is an example of some simple text written in the Doconce format::

        ===== A Subsection with Sample Text =====
        
        Ordinary text looks like ordinary text, and the tags used for
        _boldface_ words, *emphasized* words, and `computer` words look
        natural in plain text.  Lists are typeset as you would do in an email,
        
          * item 1
          * item 2
          * item 3
        
        Lists can also have automatically numbered items instead of bullets,
        
          o item 1
          o item 2
          o item 3
        
        URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The Doconce text above results in the following little document:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and computer words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have numbered items instead of bullets, just use an
1. (for ordered) instead of the asterix:

 1. item 1
 2. item 2
 3. item 3

URLs with a link word are possible, as in hpl (http://folk.uio.no/hpl).
Tables are also supperted, e.g.,

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  


Mathematics and Computer Code
-----------------------------

Inline mathematics, such as v = sin(x),
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like v = sin(x) is
typeset as::

        $\nu = \sin(x)$|$v = sin(x)$


The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside::

The result looks like this::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}

Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with::

        !bc 
        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)



One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing #include "mynote.do.txt"
on a line starting with (another) hash sign.  Doconce documents have
extension do.txt. The do part stands for doconce, while the
trailing .txt denotes a text document so that editors gives you the
right writing enviroment for plain text.


Seeing More of What Doconce Is
------------------------------

After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder doc/tutorial.do.txt in the
source code tree of Doconce. The Doconce example documentation
displays both the source tutorial.do.txt and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file lib/doconce/doc/doconce.do.txt in the Doconce
source code tree. The same documentation appears in the doc string of
the doconce module.



From Doconce to Other Formats
-----------------------------

Transformation of a Doconce document to various other
formats applies the script doconce2format::

        Unix/DOS> doconce2format format mydoc.do.txt


The preprocess program is always used to preprocess the file first,
and options to preprocess can be added after the filename. For example::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections


The variable FORMAT is always defined as the current format when
running preprocess. That is, in the last example, FORMAT is
defined as LaTeX. Inside the Doconce document one can then perform
format specific actions through tests like #if FORMAT == "LaTeX".


HTML
~~~~

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
~~~~~

Making a LaTeX file mydoc.tex from mydoc.do.txt is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form mydoc.p.tex for
     ptex2tex::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt


LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file newcommands.tex. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

*Step 2.* Run ptex2tex (if you have it) to make a standard LaTeX file::

        Unix/DOS> ptex2tex mydoc


     or just perform a plain copy::

        Unix/DOS> cp mydoc.p.tex mydoc.tex


The ptex2tex tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile mydoc.tex the usual way and create the PDF file.

Plain ASCII Text
~~~~~~~~~~~~~~~~

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
~~~~~~~~~~~~~~~~

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file mydoc.rst::

        Unix/DOS> doconce2format rst mydoc.do.txt


We may now produce various other formats::

        Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
        Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice


The OpenOffice file mydoc.odt can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
~~~~~~

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::

        Unix/DOS> doconce2format sphinx mydoc.do.txt



*Step 2.* Create a Sphinx root directory with a conf.py file, 
either manually or by using the interactive sphinx-quickstart
program. Here is a scripted version of the steps with the latter::

        mkdir sphinx-rootdir
        sphinx-quickstart <<EOF
        sphinx-rootdir
        n
        _
        Name of My Sphinx Document
        Author
        version
        version
        .rst
        index
        y
        n
        n
        n
        n
        y
        n
        n
        y
        y
        EOF



*Step 3.* Move the tutorial.rst file to the Sphinx root directory::

        Unix/DOS> mv mydoc.rst sphinx-rootdir



*Step 4.* Edit the generated index.rst file so that mydoc.rst
is included, i.e., add mydoc to the toctree section so that it becomes::

        .. toctree::
           :maxdepth: 2
        
           mydoc


(The spaces before mydoc are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source::

        make clean   # remove old versions
        make html


Many other formats are also possible.

*Step 6.* View the result::

        Unix/DOS> firefox _build/html/index.html





Demos
~~~~~

The current text is generated from a Doconce format stored in the file::

        tutorial/tutorial.do.txt


The file make.sh in the tutorial directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, tutorial.do.txt is the
starting point.  Running make.sh and studying the various generated
files and comparing them with the original doconce.do.txt file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the lib/doconce/doc directory which
translates the more comprehensive documentation, doconce.do.txt, to
various formats.  For example, to go from the LaTeX format to PDF, see
latex.sh.


The Doconce Documentation Strategy for User Manuals
---------------------------------------------------

Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the doconce2format script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
#include statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a basename.p.py file.
The .p.py extension identifies this as a file that has to be
preprocessed) by the preprocess program. 
In a doc string in basename.p.py we do a preprocessor include
in a comment line, say::

        #    #include "docstrings/doc1.dst.txt


The file docstrings/doc1.dst.txt is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named docstrings/doc1.do.txt. The .dst.txt
is the extension of a file filtered ready for being included in a doc
string (d for doc, st for string).

For making an Epydoc manual, the docstrings/doc1.do.txt file is
filtered to docstrings/doc1.epytext and renamed to
docstrings/doc1.dst.txt.  Then we run the preprocessor on the
basename.p.py file and create a real Python file
basename.py. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce docstrings/doc1.do.txt file is filtered to
docstrings/doc1.rst and renamed to docstrings/doc1.dst.txt. A
Sphinx directory must have been made with the right index.rst and
conf.py files. Going to this directory and typing make html makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter docstrings/doc1.do.txt to plain text format
(docstrings/doc1.txt) and rename to docstrings/doc1.dst.txt. The
preprocessor transforms the basename.p.py file to a standard Python
file basename.py. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the insertdocstr.py script.  Here are the corresponding Unix
commands::

        # make Epydoc API manual of basename module:
        cd docstrings
        doconce2format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce2format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce2format plain doc1.do.txt
        mv doc1.txt doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        
        # can automate inserting doc strings in all .p.py files:
        insertdocstr.py plain .
        # (runs through all .do.txt files and filters them to plain format and
        # renames to .dst.txt extension, then the script runs through all 
        # .p.py files and runs the preprocessor, which includes the .dst.txt
        # files)




Warning/Disclaimer
==================

Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.
************** File: tutorial.rst *****************
Doconce: Document Once, Include Everywhere
==========================================

:Author: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
:Date: July 30, 2010

.. lines beginning with # are comment lines

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?


If any of these questions are of interest, you should keep on reading.


The Doconce Concept
-------------------

Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).



What Does Doconce Look Like?
----------------------------

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterix,

  * *emphasized words* are surrounded by an asterix, 

  * **words in boldface** are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support oforboth LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.


Here is an example of some simple text written in the Doconce format::

        ===== A Subsection with Sample Text =====
        
        Ordinary text looks like ordinary text, and the tags used for
        _boldface_ words, *emphasized* words, and `computer` words look
        natural in plain text.  Lists are typeset as you would do in an email,
        
          * item 1
          * item 2
          * item 3
        
        Lists can also have automatically numbered items instead of bullets,
        
          o item 1
          o item 2
          o item 3
        
        URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The Doconce text above results in the following little document:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
**boldface** words, *emphasized* words, and ``computer`` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1

  * item 2

  * item 3


Lists can also have numbered items instead of bullets, just use an

1. (for ordered) instead of the asterix:

 1. item 1

 2. item 2

 3. item 3



URLs with a link word are possible, as in hpl (http://folk.uio.no/hpl).
Tables are also supperted, e.g.,

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  


Mathematics and Computer Code
-----------------------------

Inline mathematics, such as v = sin(x),
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like v = sin(x) is
typeset as::

        $\nu = \sin(x)$|$v = sin(x)$


The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside
``!bt`` and ``!et`` (begin tex / end tex) instructions. 
The result looks like this::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}

Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
``!bc`` and ``!ec`` instructions, respectively. Such blocks look like::

        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)



One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing ``#include "mynote.do.txt"``
on a line starting with (another) hash sign.  Doconce documents have
extension ``do.txt``. The ``do`` part stands for doconce, while the
trailing ``.txt`` denotes a text document so that editors gives you the
right writing enviroment for plain text.


Seeing More of What Doconce Is
------------------------------

After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder ``doc/tutorial.do.txt`` in the
source code tree of Doconce. The Doconce example documentation
displays both the source ``tutorial.do.txt`` and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file ``lib/doconce/doc/doconce.do.txt`` in the Doconce
source code tree. The same documentation appears in the doc string of
the ``doconce`` module.

.. Example on including another Doconce file:


From Doconce to Other Formats
-----------------------------

Transformation of a Doconce document to various other
formats applies the script ``doconce2format``::

        Unix/DOS> doconce2format format mydoc.do.txt


The ``preprocess`` program is always used to preprocess the file first,
and options to ``preprocess`` can be added after the filename. For example::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections


The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.


HTML
~~~~

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
~~~~~

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many
.. formats - the text may be messed up. A better choice is a paragraph
.. environment, as used here.

*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt


LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file ``newcommands.tex``. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file::

        Unix/DOS> ptex2tex mydoc


     or just perform a plain copy::

        Unix/DOS> cp mydoc.p.tex mydoc.tex


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile ``mydoc.tex`` the usual way and create the PDF file.

Plain ASCII Text
~~~~~~~~~~~~~~~~

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
~~~~~~~~~~~~~~~~

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``::

        Unix/DOS> doconce2format rst mydoc.do.txt


We may now produce various other formats::

        Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
        Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice


The OpenOffice file ``mydoc.odt`` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
~~~~~~

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::

        Unix/DOS> doconce2format sphinx mydoc.do.txt



*Step 2.* Create a Sphinx root directory with a ``conf.py`` file, 
either manually or by using the interactive ``sphinx-quickstart``
program. Here is a scripted version of the steps with the latter::

        mkdir sphinx-rootdir
        sphinx-quickstart <<EOF
        sphinx-rootdir
        n
        _
        Name of My Sphinx Document
        Author
        version
        version
        .rst
        index
        y
        n
        n
        n
        n
        y
        n
        n
        y
        y
        EOF



*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory::

        Unix/DOS> mv mydoc.rst sphinx-rootdir



*Step 4.* Edit the generated ``index.rst`` file so that ``mydoc.rst``
is included, i.e., add ``mydoc`` to the ``toctree`` section so that it becomes::

        .. toctree::
           :maxdepth: 2
        
           mydoc


(The spaces before ``mydoc`` are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source::

        make clean   # remove old versions
        make html


Many other formats are also possible.

*Step 6.* View the result::

        Unix/DOS> firefox _build/html/index.html





Demos
~~~~~

The current text is generated from a Doconce format stored in the file::

        tutorial/tutorial.do.txt


The file ``make.sh`` in the ``tutorial`` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, ``tutorial.do.txt`` is the
starting point.  Running ``make.sh`` and studying the various generated
files and comparing them with the original ``doconce.do.txt`` file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the ``lib/doconce/doc`` directory which
translates the more comprehensive documentation, ``doconce.do.txt``, to
various formats.  For example, to go from the LaTeX format to PDF, see
``latex.sh``.


The Doconce Documentation Strategy for User Manuals
---------------------------------------------------

Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the ``doconce2format`` script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
``#include`` statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a ``basename.p.py`` file.
The ``.p.py`` extension identifies this as a file that has to be
preprocessed) by the ``preprocess`` program. 
In a doc string in ``basename.p.py`` we do a preprocessor include
in a comment line, say::

        #    #include "docstrings/doc1.dst.txt



.. Note: we insert an error right above as the right quote is missing.
.. Then preprocess skips the statement, otherwise it gives an error
.. message about a missing file docstrings/doc1.dst.txt (which we don't
.. have, it's just a sample file name). Also note that comment lines
.. must not come before a code block for the rst/st/epytext formats to work.

The file ``docstrings/doc1.dst.txt`` is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named ``docstrings/doc1.do.txt``. The ``.dst.txt``
is the extension of a file filtered ready for being included in a doc
string (``d`` for doc, ``st`` for string).

For making an Epydoc manual, the ``docstrings/doc1.do.txt`` file is
filtered to ``docstrings/doc1.epytext`` and renamed to
``docstrings/doc1.dst.txt``.  Then we run the preprocessor on the
``basename.p.py`` file and create a real Python file
``basename.py``. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce ``docstrings/doc1.do.txt`` file is filtered to
``docstrings/doc1.rst`` and renamed to ``docstrings/doc1.dst.txt``. A
Sphinx directory must have been made with the right ``index.rst`` and
``conf.py`` files. Going to this directory and typing ``make html`` makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter ``docstrings/doc1.do.txt`` to plain text format
(``docstrings/doc1.txt``) and rename to ``docstrings/doc1.dst.txt``. The
preprocessor transforms the ``basename.p.py`` file to a standard Python
file ``basename.py``. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the ``insertdocstr.py`` script.  Here are the corresponding Unix
commands::

        # make Epydoc API manual of basename module:
        cd docstrings
        doconce2format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce2format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce2format plain doc1.do.txt
        mv doc1.txt doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        
        # can automate inserting doc strings in all .p.py files:
        insertdocstr.py plain .
        # (runs through all .do.txt files and filters them to plain format and
        # renames to .dst.txt extension, then the script runs through all 
        # .p.py files and runs the preprocessor, which includes the .dst.txt
        # files)




Warning/Disclaimer
==================

Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.
************** File: tutorial.wiki *****************
#summary Doconce: Document Once, Include Everywhere
<center><h3>Hans Petter Langtangen<br>Simula Research Laboratory and University of Oslo</h3></center>
<center><h3>July 30, 2010</h3></center>
<!-- lines beginning with # are comment lines -->

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

If any of these questions are of interest, you should keep on reading.
== The Doconce Concept ==
Doconce is two things:

 # Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

 # Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).
== What Does Doconce Look Like? ==
Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterix,

  * *emphasized words* are surrounded by an asterix, 

  * *words in boldface* are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support oforboth LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

Here is an example of some simple text written in the Doconce format:
{{{
===== A Subsection with Sample Text =====

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have automatically numbered items instead of bullets,

  o item 1
  o item 2
  o item 3

URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
}}}
The Doconce text above results in the following little document:
== A Subsection with Sample Text ==
Ordinary text looks like ordinary text, and the tags used for
*boldface* words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have numbered items instead of bullets, just use an
# (for ordered) instead of the asterix:

 # item 1
 # item 2
 # item 3

URLs with a link word are possible, as in [http://folk.uio.no/hpl hpl].
Tables are also supperted, e.g.,

<TABLE border="1">
<TR><TD><B>    time    </B></TD> <TD><B>  velocity  </B></TD> <TD><B>acceleration</B></TD> </TR>
<TR><TD>   0.0             </TD> <TD>   1.4186          </TD> <TD>   -5.01           </TD> </TR>
<TR><TD>   2.0             </TD> <TD>   1.376512        </TD> <TD>   11.919          </TD> </TR>
<TR><TD>   4.0             </TD> <TD>   1.1E+1          </TD> <TD>   14.717624       </TD> </TR>
</TABLE>
== Mathematics and Computer Code ==
Inline mathematics, such as `v = sin(x)`,
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like `v = sin(x)` is
typeset as
{{{
$\nu = \sin(x)$|$v = sin(x)$
}}}
The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside
`!bt` and `!et` (begin tex / end tex) instructions. 
The result looks like this:
{{{
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
}}}
Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
`!bc` and `!ec` instructions, respectively. Such blocks look like
{{{
from math import sin, pi
def myfunc(x):
    return sin(pi*x)

import integrate
I = integrate.trapezoidal(myfunc, 0, pi, 100)
}}}

One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing `#include "mynote.do.txt"`
on a line starting with (another) hash sign.  Doconce documents have
extension `do.txt`. The `do` part stands for doconce, while the
trailing `.txt` denotes a text document so that editors gives you the
right writing enviroment for plain text.
== Seeing More of What Doconce Is ==
After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder `doc/tutorial.do.txt` in the
source code tree of Doconce. The Doconce example documentation
displays both the source `tutorial.do.txt` and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file `lib/doconce/doc/doconce.do.txt` in the Doconce
source code tree. The same documentation appears in the doc string of
the `doconce` module.

<!-- Example on including another Doconce file: -->
== From Doconce to Other Formats ==
Transformation of a Doconce document to various other
formats applies the script `doconce2format`:
{{{
Unix/DOS> doconce2format format mydoc.do.txt
}}}
The `preprocess` program is always used to preprocess the file first,
and options to `preprocess` can be added after the filename. For example,
{{{
Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections
}}}
The variable `FORMAT` is always defined as the current format when
running `preprocess`. That is, in the last example, `FORMAT` is
defined as `LaTeX`. Inside the Doconce document one can then perform
format specific actions through tests like `#if FORMAT == "LaTeX"`.
=== HTML ===
Making an HTML version of a Doconce file `mydoc.do.txt`
is performed by
{{{
Unix/DOS> doconce2format HTML mydoc.do.txt
}}}
The resulting file `mydoc.html` can be loaded into any web browser for viewing.
=== LaTeX ===
Making a LaTeX file `mydoc.tex` from `mydoc.do.txt` is done in two steps:
<!-- Note: putting code blocks inside a list is not successful in many -->
<!-- formats - the text may be messed up. A better choice is a paragraph -->
<!-- environment, as used here. -->

*Step 1.* Filter the doconce text to a pre-LaTeX form `mydoc.p.tex` for
     `ptex2tex`:
{{{
Unix/DOS> doconce2format LaTeX mydoc.do.txt
}}}
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file `newcommands.tex`. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

*Step 2.* Run `ptex2tex` (if you have it) to make a standard LaTeX file,
{{{
Unix/DOS> ptex2tex mydoc
}}}
     or just perform a plain copy,
{{{
Unix/DOS> cp mydoc.p.tex mydoc.tex
}}}
The `ptex2tex` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile `mydoc.tex` the usual way and create the PDF file.
=== Plain ASCII Text ===
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
{{{
Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt
}}}
=== reStructuredText ===
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file `mydoc.rst`:
{{{
Unix/DOS> doconce2format rst mydoc.do.txt
}}}
We may now produce various other formats:
{{{
Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
}}}
The OpenOffice file `mydoc.odt` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.
=== Sphinx ===
Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format:
{{{
Unix/DOS> doconce2format sphinx mydoc.do.txt
}}}

*Step 2.* Create a Sphinx root directory with a `conf.py` file, 
either manually or by using the interactive `sphinx-quickstart`
program. Here is a scripted version of the steps with the latter:
{{{
mkdir sphinx-rootdir
sphinx-quickstart <<EOF
sphinx-rootdir
n
_
Name of My Sphinx Document
Author
version
version
.rst
index
y
n
n
n
n
y
n
n
y
y
EOF
}}}

*Step 3.* Move the `tutorial.rst` file to the Sphinx root directory:
{{{
Unix/DOS> mv mydoc.rst sphinx-rootdir
}}}

*Step 4.* Edit the generated `index.rst` file so that `mydoc.rst`
is included, i.e., add `mydoc` to the `toctree` section so that it becomes
{{{
.. toctree::
   :maxdepth: 2

   mydoc
}}}
(The spaces before `mydoc` are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source:
{{{
make clean   # remove old versions
make html
}}}
Many other formats are also possible.

*Step 6.* View the result:
{{{
Unix/DOS> firefox _build/html/index.html
}}}
=== Demos ===
The current text is generated from a Doconce format stored in the file
{{{
tutorial/tutorial.do.txt
}}}
The file `make.sh` in the `tutorial` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, `tutorial.do.txt` is the
starting point.  Running `make.sh` and studying the various generated
files and comparing them with the original `doconce.do.txt` file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the `lib/doconce/doc` directory which
translates the more comprehensive documentation, `doconce.do.txt`, to
various formats.  For example, to go from the LaTeX format to PDF, see
`latex.sh`.
== The Doconce Documentation Strategy for User Manuals ==
Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the `doconce2format` script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
`#include` statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a `basename.p.py` file.
The `.p.py` extension identifies this as a file that has to be
preprocessed) by the `preprocess` program. 
In a doc string in `basename.p.py` we do a preprocessor include
in a comment line, say
{{{
#    #include "docstrings/doc1.dst.txt
}}}
<!--  -->
<!-- Note: we insert an error right above as the right quote is missing. -->
<!-- Then preprocess skips the statement, otherwise it gives an error -->
<!-- message about a missing file docstrings/doc1.dst.txt (which we don't -->
<!-- have, it's just a sample file name). Also note that comment lines -->
<!-- must not come before a code block for the rst/st/epytext formats to work. -->
<!--  -->
The file `docstrings/doc1.dst.txt` is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named `docstrings/doc1.do.txt`. The `.dst.txt`
is the extension of a file filtered ready for being included in a doc
string (`d` for doc, `st` for string).

For making an Epydoc manual, the `docstrings/doc1.do.txt` file is
filtered to `docstrings/doc1.epytext` and renamed to
`docstrings/doc1.dst.txt`.  Then we run the preprocessor on the
`basename.p.py` file and create a real Python file
`basename.py`. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce `docstrings/doc1.do.txt` file is filtered to
`docstrings/doc1.rst` and renamed to `docstrings/doc1.dst.txt`. A
Sphinx directory must have been made with the right `index.rst` and
`conf.py` files. Going to this directory and typing `make html` makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter `docstrings/doc1.do.txt` to plain text format
(`docstrings/doc1.txt`) and rename to `docstrings/doc1.dst.txt`. The
preprocessor transforms the `basename.p.py` file to a standard Python
file `basename.py`. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the `insertdocstr.py` script.  Here are the corresponding Unix
commands:
{{{
# make Epydoc API manual of basename module:
cd docstrings
doconce2format epytext doc1.do.txt
mv doc1.epytext doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
epydoc basename

# make Sphinx API manual of basename module:
cd doc
doconce2format sphinx doc1.do.txt
mv doc1.rst doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
cd docstrings/sphinx-rootdir  # sphinx directory for API source
make clean
make html
cd ../..

# make ordinary Python module files with doc strings:
cd docstrings
doconce2format plain doc1.do.txt
mv doc1.txt doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py

# can automate inserting doc strings in all .p.py files:
insertdocstr.py plain .
# (runs through all .do.txt files and filters them to plain format and
# renames to .dst.txt extension, then the script runs through all 
# .p.py files and runs the preprocessor, which includes the .dst.txt
# files)
}}}
= Warning/Disclaimer =
Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.

************** File: tutorial.st *****************
TITLE: Doconce: Document Once, Include Everywhere
By: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
DATE: July 30, 2010
 - When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 - Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

If any of these questions are of interest, you should keep on reading.
The Doconce Concept
Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).
What Does Doconce Look Like?
Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  - bullet lists arise from lines starting with an asterix,

  - *emphasized words* are surrounded by an asterix, 

  - **words in boldface** are surrounded by underscores, 

  - words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  - blocks of computer code can easily be included, also from source files,

  - blocks of LaTeX mathematics can easily be included,

  - there is support oforboth LaTeX and text-like inline mathematics,

  - figures with captions, URLs with links, labels and references
    are supported,

  - comments can be inserted throughout the text,

  - a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

Here is an example of some simple text written in the Doconce format::

        ===== A Subsection with Sample Text =====
        
        Ordinary text looks like ordinary text, and the tags used for
        _boldface_ words, *emphasized* words, and `computer` words look
        natural in plain text.  Lists are typeset as you would do in an email,
        
          * item 1
          * item 2
          * item 3
        
        Lists can also have automatically numbered items instead of bullets,
        
          o item 1
          o item 2
          o item 3
        
        URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The Doconce text above results in the following little document:
A Subsection with Sample Text
Ordinary text looks like ordinary text, and the tags used for
**boldface** words, *emphasized* words, and 'computer' words look
natural in plain text.  Lists are typeset as you would do in an email,

  - item 1
  - item 2
  - item 3

Lists can also have numbered items instead of bullets, just use an
1. (for ordered) instead of the asterix:

 1. item 1
 2. item 2
 3. item 3

URLs with a link word are possible, as in "http://folk.uio.no/hpl":hpl.
Tables are also supperted, e.g.,

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  
Mathematics and Computer Code
Inline mathematics, such as v = sin(x),
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like v = sin(x) is
typeset as::

        $\nu = \sin(x)$|$v = sin(x)$


The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside
'!bt' and '!et' (begin tex / end tex) instructions. 
The result looks like this::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}

Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
'!bc' and '!ec' instructions, respectively. Such blocks look like::

        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)



One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing '#include "mynote.do.txt"'
on a line starting with (another) hash sign.  Doconce documents have
extension 'do.txt'. The 'do' part stands for doconce, while the
trailing '.txt' denotes a text document so that editors gives you the
right writing enviroment for plain text.
Seeing More of What Doconce Is
After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder 'doc/tutorial.do.txt' in the
source code tree of Doconce. The Doconce example documentation
displays both the source 'tutorial.do.txt' and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file 'lib/doconce/doc/doconce.do.txt' in the Doconce
source code tree. The same documentation appears in the doc string of
the 'doconce' module.
From Doconce to Other Formats
Transformation of a Doconce document to various other
formats applies the script 'doconce2format':
!bc  
        Unix/DOS> doconce2format format mydoc.do.txt


The 'preprocess' program is always used to preprocess the file first,
and options to 'preprocess' can be added after the filename. For example::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections


The variable 'FORMAT' is always defined as the current format when
running 'preprocess'. That is, in the last example, 'FORMAT' is
defined as 'LaTeX'. Inside the Doconce document one can then perform
format specific actions through tests like '#if FORMAT == "LaTeX"'.
HTML
Making an HTML version of a Doconce file 'mydoc.do.txt'
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file 'mydoc.html' can be loaded into any web browser for viewing.
LaTeX
Making a LaTeX file 'mydoc.tex' from 'mydoc.do.txt' is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form 'mydoc.p.tex' for
     'ptex2tex':
!bc  
        Unix/DOS> doconce2format LaTeX mydoc.do.txt


LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file 'newcommands.tex'. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

*Step 2.* Run 'ptex2tex' (if you have it) to make a standard LaTeX file::

        Unix/DOS> ptex2tex mydoc


     or just perform a plain copy::

        Unix/DOS> cp mydoc.p.tex mydoc.tex


The 'ptex2tex' tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile 'mydoc.tex' the usual way and create the PDF file.
Plain ASCII Text
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file 'mydoc.rst':
!bc  
        Unix/DOS> doconce2format rst mydoc.do.txt


We may now produce various other formats::

        Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
        Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice


The OpenOffice file 'mydoc.odt' can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.
Sphinx
Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::

        Unix/DOS> doconce2format sphinx mydoc.do.txt



*Step 2.* Create a Sphinx root directory with a 'conf.py' file, 
either manually or by using the interactive 'sphinx-quickstart'
program. Here is a scripted version of the steps with the latter::

        mkdir sphinx-rootdir
        sphinx-quickstart <<EOF
        sphinx-rootdir
        n
        _
        Name of My Sphinx Document
        Author
        version
        version
        .rst
        index
        y
        n
        n
        n
        n
        y
        n
        n
        y
        y
        EOF



*Step 3.* Move the 'tutorial.rst' file to the Sphinx root directory::

        Unix/DOS> mv mydoc.rst sphinx-rootdir



*Step 4.* Edit the generated 'index.rst' file so that 'mydoc.rst'
is included, i.e., add 'mydoc' to the 'toctree' section so that it becomes::

        .. toctree::
           :maxdepth: 2
        
           mydoc


(The spaces before 'mydoc' are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source::

        make clean   # remove old versions
        make html


Many other formats are also possible.

*Step 6.* View the result::

        Unix/DOS> firefox _build/html/index.html


Demos
The current text is generated from a Doconce format stored in the file::

        tutorial/tutorial.do.txt


The file 'make.sh' in the 'tutorial' directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, 'tutorial.do.txt' is the
starting point.  Running 'make.sh' and studying the various generated
files and comparing them with the original 'doconce.do.txt' file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the 'lib/doconce/doc' directory which
translates the more comprehensive documentation, 'doconce.do.txt', to
various formats.  For example, to go from the LaTeX format to PDF, see
'latex.sh'.
The Doconce Documentation Strategy for User Manuals
Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the 'doconce2format' script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
'#include' statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a 'basename.p.py' file.
The '.p.py' extension identifies this as a file that has to be
preprocessed) by the 'preprocess' program. 
In a doc string in 'basename.p.py' we do a preprocessor include
in a comment line, say::

        #    #include "docstrings/doc1.dst.txt


The file 'docstrings/doc1.dst.txt' is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named 'docstrings/doc1.do.txt'. The '.dst.txt'
is the extension of a file filtered ready for being included in a doc
string ('d' for doc, 'st' for string).

For making an Epydoc manual, the 'docstrings/doc1.do.txt' file is
filtered to 'docstrings/doc1.epytext' and renamed to
'docstrings/doc1.dst.txt'.  Then we run the preprocessor on the
'basename.p.py' file and create a real Python file
'basename.py'. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce 'docstrings/doc1.do.txt' file is filtered to
'docstrings/doc1.rst' and renamed to 'docstrings/doc1.dst.txt'. A
Sphinx directory must have been made with the right 'index.rst' and
'conf.py' files. Going to this directory and typing 'make html' makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter 'docstrings/doc1.do.txt' to plain text format
('docstrings/doc1.txt') and rename to 'docstrings/doc1.dst.txt'. The
preprocessor transforms the 'basename.p.py' file to a standard Python
file 'basename.py'. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the 'insertdocstr.py' script.  Here are the corresponding Unix
commands::

        # make Epydoc API manual of basename module:
        cd docstrings
        doconce2format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce2format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce2format plain doc1.do.txt
        mv doc1.txt doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        
        # can automate inserting doc strings in all .p.py files:
        insertdocstr.py plain .
        # (runs through all .do.txt files and filters them to plain format and
        # renames to .dst.txt extension, then the script runs through all 
        # .p.py files and runs the preprocessor, which includes the .dst.txt
        # files)


Warning/Disclaimer
Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.
************** File: tutorial.epytext *****************
TITLE: Doconce: Document Once, Include Everywhere
BY: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
DATE: July 30, 2010
 - When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 - Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
-------------------

Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).


What Does Doconce Look Like?
----------------------------

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  - bullet lists arise from lines starting with an asterix,

  - I{emphasized words} are surrounded by an asterix, 

  - B{words in boldface} are surrounded by underscores, 

  - words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  - blocks of computer code can easily be included, also from source files,

  - blocks of LaTeX mathematics can easily be included,

  - there is support oforboth LaTeX and text-like inline mathematics,

  - figures with captions, URLs with links, labels and references
    are supported,

  - comments can be inserted throughout the text,

  - a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

Here is an example of some simple text written in the Doconce format::

        ===== A Subsection with Sample Text =====
        
        Ordinary text looks like ordinary text, and the tags used for
        _boldface_ words, *emphasized* words, and `computer` words look
        natural in plain text.  Lists are typeset as you would do in an email,
        
          * item 1
          * item 2
          * item 3
        
        Lists can also have automatically numbered items instead of bullets,
        
          o item 1
          o item 2
          o item 3
        
        URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The Doconce text above results in the following little document:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
B{boldface} words, I{emphasized} words, and C{computer} words look
natural in plain text.  Lists are typeset as you would do in an email,

  - item 1
  - item 2
  - item 3

Lists can also have numbered items instead of bullets, just use an
1. (for ordered) instead of the asterix:

 1. item 1
 2. item 2
 3. item 3

URLs with a link word are possible, as in U{hpl<http://folk.uio.no/hpl>}.
Tables are also supperted, e.g.,

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  


Mathematics and Computer Code
-----------------------------

Inline mathematics, such as M{v = sin(x)},
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like M{v = sin(x)} is
typeset as::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.



The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside
C{!bt} and C{!et} (begin tex / end tex) instructions. 
The result looks like this::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
C{!bc} and C{!ec} instructions, respectively. Such blocks look like::

        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)



One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing C{#include "mynote.do.txt"}
on a line starting with (another) hash sign.  Doconce documents have
extension C{do.txt}. The C{do} part stands for doconce, while the
trailing C{.txt} denotes a text document so that editors gives you the
right writing enviroment for plain text.


Seeing More of What Doconce Is
------------------------------

After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder C{doc/tutorial.do.txt} in the
source code tree of Doconce. The Doconce example documentation
displays both the source C{tutorial.do.txt} and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file C{lib/doconce/doc/doconce.do.txt} in the Doconce
source code tree. The same documentation appears in the doc string of
the C{doconce} module.



From Doconce to Other Formats
-----------------------------

Transformation of a Doconce document to various other
formats applies the script C{doconce2format}:
!bc  
        Unix/DOS> doconce2format format mydoc.do.txt


The C{preprocess} program is always used to preprocess the file first,
and options to C{preprocess} can be added after the filename. For example::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections


The variable C{FORMAT} is always defined as the current format when
running C{preprocess}. That is, in the last example, C{FORMAT} is
defined as C{LaTeX}. Inside the Doconce document one can then perform
format specific actions through tests like C{#if FORMAT == "LaTeX"}.


HTML
~~~~

Making an HTML version of a Doconce file C{mydoc.do.txt}
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file C{mydoc.html} can be loaded into any web browser for viewing.

LaTeX
~~~~~

Making a LaTeX file C{mydoc.tex} from C{mydoc.do.txt} is done in two steps:

I{Step 1.} Filter the doconce text to a pre-LaTeX form C{mydoc.p.tex} for
     C{ptex2tex}:
!bc  
        Unix/DOS> doconce2format LaTeX mydoc.do.txt


LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file C{newcommands.tex}. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

I{Step 2.} Run C{ptex2tex} (if you have it) to make a standard LaTeX file::

        Unix/DOS> ptex2tex mydoc


     or just perform a plain copy::

        Unix/DOS> cp mydoc.p.tex mydoc.tex


The C{ptex2tex} tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile C{mydoc.tex} the usual way and create the PDF file.

Plain ASCII Text
~~~~~~~~~~~~~~~~

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
~~~~~~~~~~~~~~~~

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file C{mydoc.rst}:
!bc  
        Unix/DOS> doconce2format rst mydoc.do.txt


We may now produce various other formats::

        Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
        Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice


The OpenOffice file C{mydoc.odt} can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
~~~~~~

Sphinx documents can be created from a Doconce source in a few steps.

I{Step 1.} Translate Doconce into the Sphinx dialect of
the reStructuredText format::

        Unix/DOS> doconce2format sphinx mydoc.do.txt



I{Step 2.} Create a Sphinx root directory with a C{conf.py} file, 
either manually or by using the interactive C{sphinx-quickstart}
program. Here is a scripted version of the steps with the latter::

        mkdir sphinx-rootdir
        sphinx-quickstart <<EOF
        sphinx-rootdir
        n
        _
        Name of My Sphinx Document
        Author
        version
        version
        .rst
        index
        y
        n
        n
        n
        n
        y
        n
        n
        y
        y
        EOF



I{Step 3.} Move the C{tutorial.rst} file to the Sphinx root directory::

        Unix/DOS> mv mydoc.rst sphinx-rootdir



I{Step 4.} Edit the generated C{index.rst} file so that C{mydoc.rst}
is included, i.e., add C{mydoc} to the C{toctree} section so that it becomes::

        .. toctree::
           :maxdepth: 2
        
           mydoc


(The spaces before C{mydoc} are important!)

I{Step 5.} Generate, for instance, an HTML version of the Sphinx source::

        make clean   # remove old versions
        make html


Many other formats are also possible.

I{Step 6.} View the result::

        Unix/DOS> firefox _build/html/index.html





Demos
~~~~~

The current text is generated from a Doconce format stored in the file::

        tutorial/tutorial.do.txt


The file C{make.sh} in the C{tutorial} directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, C{tutorial.do.txt} is the
starting point.  Running C{make.sh} and studying the various generated
files and comparing them with the original C{doconce.do.txt} file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the C{lib/doconce/doc} directory which
translates the more comprehensive documentation, C{doconce.do.txt}, to
various formats.  For example, to go from the LaTeX format to PDF, see
C{latex.sh}.


The Doconce Documentation Strategy for User Manuals
---------------------------------------------------

Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the C{doconce2format} script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
C{#include} statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a C{basename.p.py} file.
The C{.p.py} extension identifies this as a file that has to be
preprocessed) by the C{preprocess} program. 
In a doc string in C{basename.p.py} we do a preprocessor include
in a comment line, say::

        #    #include "docstrings/doc1.dst.txt


The file C{docstrings/doc1.dst.txt} is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named C{docstrings/doc1.do.txt}. The C{.dst.txt}
is the extension of a file filtered ready for being included in a doc
string (C{d} for doc, C{st} for string).

For making an Epydoc manual, the C{docstrings/doc1.do.txt} file is
filtered to C{docstrings/doc1.epytext} and renamed to
C{docstrings/doc1.dst.txt}.  Then we run the preprocessor on the
C{basename.p.py} file and create a real Python file
C{basename.py}. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce C{docstrings/doc1.do.txt} file is filtered to
C{docstrings/doc1.rst} and renamed to C{docstrings/doc1.dst.txt}. A
Sphinx directory must have been made with the right C{index.rst} and
C{conf.py} files. Going to this directory and typing C{make html} makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter C{docstrings/doc1.do.txt} to plain text format
(C{docstrings/doc1.txt}) and rename to C{docstrings/doc1.dst.txt}. The
preprocessor transforms the C{basename.p.py} file to a standard Python
file C{basename.py}. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the C{insertdocstr.py} script.  Here are the corresponding Unix
commands::

        # make Epydoc API manual of basename module:
        cd docstrings
        doconce2format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce2format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce2format plain doc1.do.txt
        mv doc1.txt doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        
        # can automate inserting doc strings in all .p.py files:
        insertdocstr.py plain .
        # (runs through all .do.txt files and filters them to plain format and
        # renames to .dst.txt extension, then the script runs through all 
        # .p.py files and runs the preprocessor, which includes the .dst.txt
        # files)




Warning/Disclaimer
==================

Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.
************** File: tutorial.txt *****************
TITLE: Doconce: Document Once, Include Everywhere
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: July 30, 2010



 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it everywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
-------------------

Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include everywhere". This requires that what you
    write can be transformed to many different formats for a variety
    of documents (manuals, tutorials, books, doc strings, source code
    comments, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. The Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, reStructuredText, Sphinx, XML,
    OpenOffice/Word, Epytext, PDF, XML - and even plain text (with
    tags removed for clearer reading).


What Does Doconce Look Like?
----------------------------

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterix,

  * *emphasized words* are surrounded by an asterix, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support oforboth LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * a preprocessor (much like the C preprocessor) is integrated so
    other documents (files) can be included and large portions of text
    can be defined in or out of the text.

Here is an example of some simple text written in the Doconce format::

        ===== A Subsection with Sample Text =====
        
        Ordinary text looks like ordinary text, and the tags used for
        _boldface_ words, *emphasized* words, and `computer` words look
        natural in plain text.  Lists are typeset as you would do in an email,
        
          * item 1
          * item 2
          * item 3
        
        Lists can also have automatically numbered items instead of bullets,
        
          o item 1
          o item 2
          o item 3
        
        URLs with a link word are possible, as in http://folk.uio.no/hpl<hpl>.
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The Doconce text above results in the following little document:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and computer words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have numbered items instead of bullets, just use an
1. (for ordered) instead of the asterix:

 1. item 1
 2. item 2
 3. item 3

URLs with a link word are possible, as in hpl (http://folk.uio.no/hpl).
Tables are also supperted, e.g.,

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  


Mathematics and Computer Code
-----------------------------

Inline mathematics, such as v = sin(x),
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like v = sin(x) is
typeset as::

        $\nu = \sin(x)$|$v = sin(x)$


The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside::

The result looks like this::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}

Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with::

        !bc 
        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)



One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
never copying anything!).

Another document can be included by writing #include "mynote.do.txt"
on a line starting with (another) hash sign.  Doconce documents have
extension do.txt. The do part stands for doconce, while the
trailing .txt denotes a text document so that editors gives you the
right writing enviroment for plain text.


Seeing More of What Doconce Is
------------------------------

After the quick syntax tour above, we recommend to read the Doconce
source of the current tutorial and compare it with what you see in
a browser, a PDF document, in plain text, and so forth.
The Doconce source is found in the folder doc/tutorial.do.txt in the
source code tree of Doconce. The Doconce example documentation
displays both the source tutorial.do.txt and the result of many other
formats.

A more complete documentation of and motivation for Doconce appears
in the file lib/doconce/doc/doconce.do.txt in the Doconce
source code tree. The same documentation appears in the doc string of
the doconce module.



From Doconce to Other Formats
-----------------------------

Transformation of a Doconce document to various other
formats applies the script doconce2format::

        Unix/DOS> doconce2format format mydoc.do.txt


The preprocess program is always used to preprocess the file first,
and options to preprocess can be added after the filename. For example::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections


The variable FORMAT is always defined as the current format when
running preprocess. That is, in the last example, FORMAT is
defined as LaTeX. Inside the Doconce document one can then perform
format specific actions through tests like #if FORMAT == "LaTeX".


HTML
~~~~

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
~~~~~

Making a LaTeX file mydoc.tex from mydoc.do.txt is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form mydoc.p.tex for
     ptex2tex::

        Unix/DOS> doconce2format LaTeX mydoc.do.txt


LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file newcommands.tex. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

*Step 2.* Run ptex2tex (if you have it) to make a standard LaTeX file::

        Unix/DOS> ptex2tex mydoc


     or just perform a plain copy::

        Unix/DOS> cp mydoc.p.tex mydoc.tex


The ptex2tex tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile mydoc.tex the usual way and create the PDF file.

Plain ASCII Text
~~~~~~~~~~~~~~~~

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
~~~~~~~~~~~~~~~~

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file mydoc.rst::

        Unix/DOS> doconce2format rst mydoc.do.txt


We may now produce various other formats::

        Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
        Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice


The OpenOffice file mydoc.odt can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
~~~~~~

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::

        Unix/DOS> doconce2format sphinx mydoc.do.txt



*Step 2.* Create a Sphinx root directory with a conf.py file, 
either manually or by using the interactive sphinx-quickstart
program. Here is a scripted version of the steps with the latter::

        mkdir sphinx-rootdir
        sphinx-quickstart <<EOF
        sphinx-rootdir
        n
        _
        Name of My Sphinx Document
        Author
        version
        version
        .rst
        index
        y
        n
        n
        n
        n
        y
        n
        n
        y
        y
        EOF



*Step 3.* Move the tutorial.rst file to the Sphinx root directory::

        Unix/DOS> mv mydoc.rst sphinx-rootdir



*Step 4.* Edit the generated index.rst file so that mydoc.rst
is included, i.e., add mydoc to the toctree section so that it becomes::

        .. toctree::
           :maxdepth: 2
        
           mydoc


(The spaces before mydoc are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source::

        make clean   # remove old versions
        make html


Many other formats are also possible.

*Step 6.* View the result::

        Unix/DOS> firefox _build/html/index.html





Demos
~~~~~

The current text is generated from a Doconce format stored in the file::

        tutorial/tutorial.do.txt


The file make.sh in the tutorial directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, tutorial.do.txt is the
starting point.  Running make.sh and studying the various generated
files and comparing them with the original doconce.do.txt file,
gives a quick introduction to how Doconce is used in a real case.

There is another demo in the lib/doconce/doc directory which
translates the more comprehensive documentation, doconce.do.txt, to
various formats.  For example, to go from the LaTeX format to PDF, see
latex.sh.


The Doconce Documentation Strategy for User Manuals
---------------------------------------------------

Doconce was particularly made for writing tutorials or user manuals
associated with computer codes. The text is written in Doconce format
in separate files. LaTeX, HTML, XML, and other versions of the text
is easily produced by the doconce2format script and standard tools.
A plain text version is often wanted for the computer source code,
this is easy to make, and then one can use
#include statements in the computer source code to automatically
get the manual or tutorial text in comments or doc strings.
Below is a worked example.

Consider an example involving a Python module in a basename.p.py file.
The .p.py extension identifies this as a file that has to be
preprocessed) by the preprocess program. 
In a doc string in basename.p.py we do a preprocessor include
in a comment line, say::

        #    #include "docstrings/doc1.dst.txt


The file docstrings/doc1.dst.txt is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named docstrings/doc1.do.txt. The .dst.txt
is the extension of a file filtered ready for being included in a doc
string (d for doc, st for string).

For making an Epydoc manual, the docstrings/doc1.do.txt file is
filtered to docstrings/doc1.epytext and renamed to
docstrings/doc1.dst.txt.  Then we run the preprocessor on the
basename.p.py file and create a real Python file
basename.py. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce docstrings/doc1.do.txt file is filtered to
docstrings/doc1.rst and renamed to docstrings/doc1.dst.txt. A
Sphinx directory must have been made with the right index.rst and
conf.py files. Going to this directory and typing make html makes
the HTML version of the Sphinx API documentation.

The next step is to produce the final pure Python source code. For
this purpose we filter docstrings/doc1.do.txt to plain text format
(docstrings/doc1.txt) and rename to docstrings/doc1.dst.txt. The
preprocessor transforms the basename.p.py file to a standard Python
file basename.py. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the insertdocstr.py script.  Here are the corresponding Unix
commands::

        # make Epydoc API manual of basename module:
        cd docstrings
        doconce2format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce2format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce2format plain doc1.do.txt
        mv doc1.txt doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        
        # can automate inserting doc strings in all .p.py files:
        insertdocstr.py plain .
        # (runs through all .do.txt files and filters them to plain format and
        # renames to .dst.txt extension, then the script runs through all 
        # .p.py files and runs the preprocessor, which includes the .dst.txt
        # files)




Warning/Disclaimer
==================

Doconce can be viewed is a unified interface to a variety of
typesetting formats.  This interface is minimal in the sense that a
lot of typesetting features are not supported, for example, footnotes
and bibliography. For many documents the simple Doconce format is
sufficient, while in other cases you need more sophisticated
formats. Then you can just filter the Doconce text to a more
approprite format and continue working in this format only.  For
example, reStructuredText is a good alternative: it is more tagged
than Doconce and cannot be filtered to plain, untagged text, or wiki,
and the LaTeX output is not at all as clean, but it also has a lot
more typesetting and tagging features than Doconce.
************** File: tmp_Doconce.do.txt *****************

TITLE: My Test of Class Doconce
AUTHOR: Hans Petter Langtangen; Simula Research Laboratory; Dept. of Informatics, Univ. of Oslo
DATE: Mon, 09 Aug 2010 (12:57)



_______First Section_______


Here is some
text for section 1.

This is a *first* example of using the _DocWriter
module_ for writing documents from *Python* scripts.
It could be a nice tool since we do not need to bother
with special typesetting, such as `fixed width fonts`
in plain text.

_____First Subsection_____

Some text for the subsection.

__Test of a Paragraph.__ 
Some paragraph text taken from "Documenting Python": The Python language
has a substantial body of documentation, much of it contributed by various
authors. The markup used for the Python documentation is based on
LaTeX and requires a significant set of macros written specifically
for documenting Python. This document describes the macros introduced
to support Python documentation and how they should be used to support
a wide range of output formats.

This document describes the document classes and special markup used
in the Python documentation. Authors may use this guide, in
conjunction with the template files provided with the distribution, to
create or maintain whole documents or sections.

If you're interested in contributing to Python's documentation,
there's no need to learn LaTeX if you're not so inclined; plain text
contributions are more than welcome as well.
Here is an enumerate list:
o item1
o item2

    o subitem1
    o subitem2

o item3

    o subitem3
    o subitem4
...with some trailing text.
___First Subsubsection with an Itemize List___


* item1
* item2

    * subitem1
    * subitem2

* item3

    * subitem3
    * subitem4
Here is some Python code:
!bc

class A:
    pass

class B(A):
    pass

b = B()
b.item = 0  # create a new attribute

!ec

_______Second Section_______

Here is a description list:
- keyword1:  item1
- keyword2:  item2 goes here, with a colon : and some text after

    - key3:  subitem1
    - key4:  subitem2

- key5:  item3

    - key6:  subitem3
    - key7:  subitem4


And here is a table:

   |---------------------------------------|
   | a                 | b                 |
   | c                 | d                 |
   | e                 | and a longer text |
   |---------------------------------------|


************** File: tmp_DocWriter.do.txt *****************

TITLE: My Test of Class DocWriter
AUTHOR: Hans Petter Langtangen; Simula Research Laboratory; Dept. of Informatics, Univ. of Oslo
DATE: Mon, 09 Aug 2010 (12:57)



_______First Section_______


Here is some
text for section 1.

This is a *first* example of using the _DocWriter
module_ for writing documents from *Python* scripts.
It could be a nice tool since we do not need to bother
with special typesetting, such as `fixed width fonts`
in plain text.

_____First Subsection_____

Some text for the subsection.

__Test of a Paragraph.__ 
Some paragraph text taken from "Documenting Python": The Python language
has a substantial body of documentation, much of it contributed by various
authors. The markup used for the Python documentation is based on
LaTeX and requires a significant set of macros written specifically
for documenting Python. This document describes the macros introduced
to support Python documentation and how they should be used to support
a wide range of output formats.

This document describes the document classes and special markup used
in the Python documentation. Authors may use this guide, in
conjunction with the template files provided with the distribution, to
create or maintain whole documents or sections.

If you're interested in contributing to Python's documentation,
there's no need to learn LaTeX if you're not so inclined; plain text
contributions are more than welcome as well.
Here is an enumerate list:
o item1
o item2

    o subitem1
    o subitem2

o item3

    o subitem3
    o subitem4
...with some trailing text.
___First Subsubsection with an Itemize List___


* item1
* item2

    * subitem1
    * subitem2

* item3

    * subitem3
    * subitem4
Here is some Python code:
!bc

class A:
    pass

class B(A):
    pass

b = B()
b.item = 0  # create a new attribute

!ec

_______Second Section_______

Here is a description list:
- keyword1:  item1
- keyword2:  item2 goes here, with a colon : and some text after

    - key3:  subitem1
    - key4:  subitem2

- key5:  item3

    - key6:  subitem3
    - key7:  subitem4


And here is a table:

   |---------------------------------------|
   | a                 | b                 |
   | c                 | d                 |
   | e                 | and a longer text |
   |---------------------------------------|


************** File: tmp_DocWriter.html *****************
<!-- HTML document generated by __main__.HTML -->
<HTML>
<BODY BGCOLOR="white">

<TITLE>My Test of Class DocWriter</TITLE>
<CENTER><H1>My Test of Class DocWriter</H1></CENTER>

<CENTER>
<H4>Hans Petter Langtangen</H4>
<H6>Simula Research Laboratory</H6>
<H6>Dept. of Informatics, Univ. of Oslo</H6>
</CENTER>

<CENTER>Mon, 09 Aug 2010 (12:57)</CENTER>



<P>

<H1>First Section</H1>

Here is some
text for section 1.

This is a <em>first</em> example of using the <b>DocWriter
module</b> for writing documents from <em>Python</em> scripts.
It could be a nice tool since we do not need to bother
with special typesetting, such as <tt>fixed width fonts</tt>
in plain text.

<H3>First Subsection</H3>
Some text for the subsection.

<P><!-- paragraph with heading -->
<B>Test of a Paragraph.</B>

Some paragraph text taken from "Documenting Python": The Python language
has a substantial body of documentation, much of it contributed by various
authors. The markup used for the Python documentation is based on
LaTeX and requires a significant set of macros written specifically
for documenting Python. This document describes the macros introduced
to support Python documentation and how they should be used to support
a wide range of output formats.

This document describes the document classes and special markup used
in the Python documentation. Authors may use this guide, in
conjunction with the template files provided with the distribution, to
create or maintain whole documents or sections.

If you're interested in contributing to Python's documentation,
there's no need to learn LaTeX if you're not so inclined; plain text
contributions are more than welcome as well.
Here is an enumerate list:
<OL> <!-- start of "enumerate" list -->
<P><LI> item1
<P><LI> item2

  <OL> <!-- start of "enumerate" list -->
    <P><LI> subitem1
    <P><LI> subitem2
  </OL> <!-- end of "enumerate" list -->
<P><LI> item3

  <OL> <!-- start of "enumerate" list -->
    <P><LI> subitem3
    <P><LI> subitem4
  </OL> <!-- end of "enumerate" list -->
</OL> <!-- end of "enumerate" list -->
...with some trailing text.
<H4>First Subsubsection with an Itemize List</H4>

<UL> <!-- start of "itemize" list -->
<P><LI> item1
<P><LI> item2

  <UL> <!-- start of "itemize" list -->
    <P><LI> subitem1
    <P><LI> subitem2
  </UL> <!-- end of "itemize" list -->
<P><LI> item3

  <UL> <!-- start of "itemize" list -->
    <P><LI> subitem3
    <P><LI> subitem4
  </UL> <!-- end of "itemize" list -->
</UL> <!-- end of "itemize" list -->
Here is some Python code:
<PRE>
class A:
    pass

class B(A):
    pass

b = B()
b.item = 0  # create a new attribute

</PRE>

<H1>Second Section</H1>
Here is a description list:
<DL> <!-- start of "description" list -->
<P><DT>keyword1</DT><DD> item1</DD>
<P><DT>keyword2</DT><DD> item2 goes here, with a colon : and some text after</DD>

  <DL> <!-- start of "description" list -->
    <P><DT>key3</DT><DD> subitem1</DD>
    <P><DT>key4</DT><DD> subitem2</DD>
  </DL> <!-- end of "description" list -->
<P><DT>key5</DT><DD> item3</DD>

  <DL> <!-- start of "description" list -->
    <P><DT>key6</DT><DD> subitem3</DD>
    <P><DT>key7</DT><DD> subitem4</DD>
  </DL> <!-- end of "description" list -->
</DL> <!-- end of "description" list -->

<P>
And here is a table:
<P>
<TABLE BORDER="2" CELLPADDING="5" CELLSPACING="2">
<TR><TD>a</TD><TD>b</TD></TR>
<TR><TD>c</TD><TD>d</TD></TR>
<TR><TD>e</TD><TD>and a longer text</TD></TR>
</TABLE>


</BODY>
</HTML>

************** File: tmp_HTML.html *****************
<!-- HTML document generated by __main__.HTML -->
<HTML>
<BODY BGCOLOR="white">

<TITLE>My Test of Class HTML</TITLE>
<CENTER><H1>My Test of Class HTML</H1></CENTER>

<CENTER>
<H4>Hans Petter Langtangen</H4>
<H6>Simula Research Laboratory</H6>
<H6>Dept. of Informatics, Univ. of Oslo</H6>
</CENTER>

<CENTER>Mon, 09 Aug 2010 (12:57)</CENTER>



<P>

<H1>First Section</H1>

Here is some
text for section 1.

This is a <em>first</em> example of using the <b>DocWriter
module</b> for writing documents from <em>Python</em> scripts.
It could be a nice tool since we do not need to bother
with special typesetting, such as <tt>fixed width fonts</tt>
in plain text.

<H3>First Subsection</H3>
Some text for the subsection.

<P><!-- paragraph with heading -->
<B>Test of a Paragraph.</B>

Some paragraph text taken from "Documenting Python": The Python language
has a substantial body of documentation, much of it contributed by various
authors. The markup used for the Python documentation is based on
LaTeX and requires a significant set of macros written specifically
for documenting Python. This document describes the macros introduced
to support Python documentation and how they should be used to support
a wide range of output formats.

This document describes the document classes and special markup used
in the Python documentation. Authors may use this guide, in
conjunction with the template files provided with the distribution, to
create or maintain whole documents or sections.

If you're interested in contributing to Python's documentation,
there's no need to learn LaTeX if you're not so inclined; plain text
contributions are more than welcome as well.
Here is an enumerate list:
<OL> <!-- start of "enumerate" list -->
<P><LI> item1
<P><LI> item2

  <OL> <!-- start of "enumerate" list -->
    <P><LI> subitem1
    <P><LI> subitem2
  </OL> <!-- end of "enumerate" list -->
<P><LI> item3

  <OL> <!-- start of "enumerate" list -->
    <P><LI> subitem3
    <P><LI> subitem4
  </OL> <!-- end of "enumerate" list -->
</OL> <!-- end of "enumerate" list -->
...with some trailing text.
<H4>First Subsubsection with an Itemize List</H4>

<UL> <!-- start of "itemize" list -->
<P><LI> item1
<P><LI> item2

  <UL> <!-- start of "itemize" list -->
    <P><LI> subitem1
    <P><LI> subitem2
  </UL> <!-- end of "itemize" list -->
<P><LI> item3

  <UL> <!-- start of "itemize" list -->
    <P><LI> subitem3
    <P><LI> subitem4
  </UL> <!-- end of "itemize" list -->
</UL> <!-- end of "itemize" list -->
Here is some Python code:
<PRE>
class A:
    pass

class B(A):
    pass

b = B()
b.item = 0  # create a new attribute

</PRE>

<H1>Second Section</H1>
Here is a description list:
<DL> <!-- start of "description" list -->
<P><DT>keyword1</DT><DD> item1</DD>
<P><DT>keyword2</DT><DD> item2 goes here, with a colon : and some text after</DD>

  <DL> <!-- start of "description" list -->
    <P><DT>key3</DT><DD> subitem1</DD>
    <P><DT>key4</DT><DD> subitem2</DD>
  </DL> <!-- end of "description" list -->
<P><DT>key5</DT><DD> item3</DD>

  <DL> <!-- start of "description" list -->
    <P><DT>key6</DT><DD> subitem3</DD>
    <P><DT>key7</DT><DD> subitem4</DD>
  </DL> <!-- end of "description" list -->
</DL> <!-- end of "description" list -->

<P>
And here is a table:
<P>
<TABLE BORDER="2" CELLPADDING="5" CELLSPACING="2">
<TR><TD>a</TD><TD>b</TD></TR>
<TR><TD>c</TD><TD>d</TD></TR>
<TR><TD>e</TD><TD>and a longer text</TD></TR>
</TABLE>


</BODY>
</HTML>
