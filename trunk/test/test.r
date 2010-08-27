
************** File: manual.do.txt *****************
TITLE: Doconce Description
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: August 27, 2010


# lines beginning with # are comment lines


======= What Is Doconce? ======= 
label{what:is:doconce}

Doconce is two things:

  o Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).
    
  o Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce

  * can convert to plain *untagged* text, 
    more desirable for computer programs and email, 
  * has less cluttered tagging of text,
  * has better support for copying in computer code from other files,
  * has stronger support for mathematical typesetting,
  * works better as a complete or partial source for large LaTeX 
    documents (reports and books).

Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to Section ref{doconce:strategy} to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.


======= Motivation: Problems with Documenting Software =======

__Duplicated Information.__ It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

__Different Tagging for Different Formats.__ A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

__Solution.__ Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

__A Common Format.__ There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need

  o A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.

  o Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 

  o Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).

One answer to these points is the Doconce markup language, its associated
tools, and the http://code.google.com/p/preprocess/<C-style preprocessor tool>.
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in Section ref{what:is:doconce}, but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).


===== Dependencies =====

Doconce needs the Python packages
http://docutils.sourceforge.net/<docutils>,
http://code.google.com/p/preprocess/<preprocess>, and
http://code.google.com/p/ptex2tex/<ptex2tex>. The latter is only
needed for the LaTeX formats.


===== The Doconce Documentation Strategy ===== 
label{doconce:strategy}

   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use `#include` statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program `doconce2format` before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.

   * Run the preprocessor `preprocess` on the files to produce native
     files for pure computer code and for various other documents.

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

# #ifdef MORE_MOTIVATION

===== Why Yet Another Minimally Tagged Markup Language? ===== 
label{why:another:markup}

The Python community has already produced two successful, ASCII-based
markup languages with a modest amount of tagging:
http://docutils.sourceforge.net/rst.html<reStructuredText> (part of
the http://www.docutils.org<Docutils package>) and Epytext (part of
http://epydoc.sourceforge.net/<Epydoc for Python APIs>).  The
http://sphinx.pocoo.org<Sphinx documentation system>, now being the
standard Python documentation system, builds on reStructuredText.
http://www.pault.com/xmlalternatives.html<Other minimum-tagged markup languages do also exist>. So why is Doconce needed?

  - Simplicity:
    Doconce supports only a handful of formatting constructions and
    is therefore simpler than Epytext and reStructuredText.
    Consequently, the latter two are more flexible. However,
    their parsing modules are also much more complex, and it is
    an order of magnitude simpler to add support for a new format
    in Doconce than in most other markup languages. 

    The simple Doconce format is less cluttered and easier 
    to read than more flexible and advanced ASCII-based markup languages,
    such as reStructuredText. Many who receive close-to-plain ASCII
    text in email tend to be annoyed by the tagging and may remove tags
    and clean up the text.

  - Flexibility:
    Epydoc and Sphinx produce complete module/package documentation.
    Doconce can work with small pieces of documentation, e.g.,
    module doc strings to be filtered to and used by Epydoc or Sphinx, and
    also included in a LaTeX thesis or a Word document.

  - Math:
    Doconce supports inline mathematical expressions and blocks
    of mathematical LaTeX code. (Epytext is easily fooled by TeX
    code with the backslashes and gives lots of error messages
    even if the code block is to be typeset in varbatim mode.) 

  - Clean output:
    The LaTeX output of Doconce was much cleaner than the source produced by
    reStructuredText at the time Doconce was constructed. TThis may be important if a book or manual in
    LaTeX is to be built from some building blocks in a more general
    format and the LaTeX output needs some tweeking before it can
    qualify for a book/manual context. Typically, one wants parts of
    the book/manual to be available in several formats, e.g., through
    Sphinx. Doconce may then be a better source for these building
    blocks than reStructuredText.

  - More formats:
    Doconce can currently be translated to HTML, LaTeX, reStructuredText,
    Sphinx, StructuredText, Epytext, Wiki, and (important!) plain 
    "untagged" ASCII. 

    When Doconce is transformed to reStructuredText, the text can
    further be transformed to HTML, LaTeX, and XML.  The
    reStructuredText support for Docbook, RTF, and OpenOffice is under
    development. Doconce can also be transformed to Epytext or Sphinx
    for formatting of API documentation of Python modules, or to
    StructuredText used by the older HappyDoc tool for API
    documentation.  The plain untagged ASCII text is very suitable for
    online manuals intended to be read in terminal windows, or for
    emails.  Especially for emails, plain untagged text handy since
    many who are unfamiliar with, e.g., reStructuredText may to be
    annoyed by the tagging and even start "correcting" the text.

    A page of code, containing definitions of how emphasized text, 
    verbatim text, lists, etc. are rendered, is all you need to 
    implement a new format.
    (Everything except lists are parsed by regular expressions in Doconce.)

# #endif

#
# some comment lines that do not affect any formatting
# these lines are simply removed
#
#
#
#
#


===== Demos ===== 

The current text is generated from a Doconce format stored in the
!bc
docs/manual/doconce.do.txt
!ec
file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file `make.sh` in the same directory as the `doconce.do.txt` file
(the current text) shows how to run `doconce2format` on the
`doconce.do.txt` file to obtain documents in various formats.  Running
this demo (`make.sh`) and studying the various generated files and
comparing them with the original `doconce.do.txt` file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in
!bc
docs/tutorial/tutorial.do.txt
!ec
In the `tutorial` directory there is also a `make.sh` file producing a
lot of formats.

# Example on including another Doconce file:

# #include "../tutorial/_doconce2anything.do.txt"



======= The Doconce Markup Language ======= 

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

===== Lists ===== 

An unordered bullet list makes use of the `*` as bullet sign
and is indented as follows

!bc
   * item 1

   * item 2

     * subitem 1, if there are more
       lines, each line must
       be intended as shown here

     * subitem 2,
       also spans two lines

   * item 3
!ec

This list gets typeset as

   * item 1

   * item 2

     * subitem 1, if there are more
       lines, each line must
       be intended as shown here

     * subitem 2,
       also spans two lines

   * item 3

# #if FORMAT == "gwiki"
(As seen, nested lists in (g)wiki format are not treated well by
Doconce. Plain unnested lists work fine. And the (g)wiki format
automatically puts multiple lines of an item on a single line as
required :-)
# #endif

In an ordered list, each item starts with an `o` (as the first letter 
in "ordered"):

!bc
   o item 1

   o item 2

     * subitem 1

     * subitem 2

   o item 3
!ec

resulting in

   o item 1

   o item 2

     * subitem 1

     * subitem 2

   o item 3

# #if FORMAT == "gwiki"
(Again, there are problems with mixing nested lists and liststypes
for the (g)wiki format.)
# #endif

Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon:

!bc
   - keyword1: explanation of keyword1

   - keyword2: explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
!ec

The result becomes

   - keyword1: explanation of keyword1

   - keyword2: explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)


===== Special Lines ===== 

The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax `name at institution(s)`.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example:

!bc
TITLE: On The Ultimate Markup Language: Doconce
AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
DATE: November 9, 2006
!ec
Note the `at` with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.
   
Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):
   * 7 underscores or equal signs for sections
   * 5 for subsections
   * 3 for subsubsections
   * 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)
Headings can be surrounded by blanks if desired.

Here are some examples:
!bc
======= Example on a Section Heading ======= 

The running text goes here. 

      ===== Example on a Subsection Heading ===== 
The running text goes here.

          ===Example on a Subsubsection Heading===

The running text goes here.

__A Paragraph.__ The running text goes here.
!ec

The result for the present format looks like this:

======= Example on a Section Heading ======= 

The running text goes here. 

      ===== Example on a Subsection Heading ===== 
The running text goes here.

          ===Example on a Subsubsection Heading===

The running text goes here.

__A Paragraph.__ The running text goes here.

Figures are recognized by the special line syntax
!bc
FIGURE:[filename, height=xxx width=yyy scale=zzz] caption
!ec
The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename `mypic.eps` is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say `mypic.png` for HTML output).

FIGURE:[figs/dinoimpact.gif, width=400] It can't get worse than this.... label{fig:impact}



Another type of special lines starts with `@@@CODE` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.


_____Inline Tagging_____
label{inline:tagging}

Doconce supports tags for *emphasized phrases*, _boldface phrases_,
and `verbatim text` (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as $\nu = \sin(x)$|$v = sin(x)$.

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in
!bc
*emphasized words*
!ec

Boldface font is recognized by an underscore instead of an asterisk:
!bc
_several words in boldface_ followed by *ephasized text*.
!ec
The line above gets typeset as
_several words in boldface_ followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes:
!bc
`call myroutine(a, b)` looks like a Fortran call
while `void myfunc(double *a, double *b)` must be C.
!ec
The typesetting result looks like this:
`call myroutine(a, b)` looks like a Fortran call
while `void myfunc(double *a, double *b)` must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and `ptex2tex`) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as
!bc
some URL like http://my.place.in.space/src<MyPlace>
!ec
which appears as some URL like http://my.place.in.space/src<MyPlace>.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:
!bc
URL:"doconce.do.txt"
!ec
This constructions results in the link URL:"doconce.do.txt".


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII:
!bc
Here is an example on a linear system 
${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
$\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.
!ec
That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, where $\bf A$|$A$ 
is an $n\times n$|$nxn$ matrix, and $\bf x$|$x$ and $\bf b$|$b$
are vectors of length $n$|$n$."

===== Cross-Referencing =====

References and labels are supported. The syntax is simple:
!bc
label{section:verbatim}   # defines a label
For more information we refer to Section ref{section:verbatim}.
!ec
This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by `doconce2format`. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to Sections ref{mathtext} and ref{newcommands} are
nice to demonstrate, as well as a reference to equations,
say (ref{my:eq1})--(ref{my:eq2}). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.
     
Hyperlinks to files or web addresses are handled as explained
in Section ref{inline:tagging}.


===== Tables =====

A table like

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|

is built up of pipe symbols and dashes:
!bc
  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
!ec
The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


===== Blocks of Verbatim Computer Code ===== 

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" `!bc` keyword and an "end code" `!ec` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the `!bc` tag to specify a
certain `ptex2tex` environ (for instance, `!bc dat` corresponds to the
data file environment in `ptex2tex`; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The `!ec` tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block:
!bc cod
# regular expressions for inline tags:
inline_tag_begin = r'(?P<begin>(^|\s+))'
inline_tag_end = r'(?P<end>[.,?!;:)\s])'
INLINE_TAGS = {
    'emphasize':
    r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
    (inline_tag_begin, inline_tag_end),
    'verbatim':
    r'%s`(?P<subst>[^ ][^`]*)`%s' % \
    (inline_tag_begin, inline_tag_end),
    'bold':
    r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
    (inline_tag_begin, inline_tag_end),
}
!ec

Computer code can be copied directly from a file, if desired. The syntax
is then
!bc
 @@@CODE myfile.f
 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1
!ec
The first line implies that all lines in the file `myfile.f` are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the `@` sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
`subroutine test` (with as many blanks as desired between the two words)
and the line matching `C      END1` (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above):

@@@CODE __testcode.f

Let us then copy just a piece in the middle as indicated by the `fromto:`
directive above:

@@@CODE __testcode.f fromto:subroutine\s+test@^C\s{5}END1

(Remark for those familiar with `ptex2tex`: The from-to
syntax is slightly different from that used in `ptex2tex`. When
transforming Doconce to LaTeX, one first transforms the document to a
`.p.tex` file to be treated by `ptex2tex`. However, the `@@@CODE` line
is interpreted by Doconce and replaced by a *pro* or *cod* `ptex2tex`
environment.)


===== LaTeX Blocks of Mathematical Text =====
label{mathtext}

Blocks of mathematical text are like computer code blocks, but
the opening tag is `!bt` (begin TeX) and the closing tag is
`!et`. It is important that `!bt` and `!et` appear on the beginning of the
line and followed by a newline. 

Here is the result of a `!bt` - `!et` block:
!bt
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
!et

This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

===== Macros (Newcommands) =====
label{newcommands}

Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
`newcommand_replace.tex` are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names `newcommands.tex` and
`newcommands_keep.tex` are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
`!bt` and `!et` in `newcommands_keep.tex` to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
`newcommands_replace.tex` and expanded by Doconce.  The definitions of
newcommands in the `newcommands*.tex` files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

__Example.__ Suppose we have the following commands in 
`newcommand_replace.tex`:

@@@CODE newcommands_replace.tex

and these in `newcommands_keep.tex`:

@@@CODE newcommands_keep.tex

The LaTeX block
!bc
\beqa
\x\cdot\normalvec &=& 0,\label{my:eq1}\\
\Ddt{\uvec} &=& \Q \ep\label{my:eq2}
\eeqa
!ec
will then be rendered to
!bt
\beqa
\x\cdot\normalvec &=& 0,\label{my:eq1}\\
\Ddt{\uvec} &=& \Q \ep\label{my:eq2}
\eeqa
!et
in the current format.

===== Missing Features ===== 

  * Footnotes
  * Citations and bibliography
  * Index

If these things are important, one should go with reStructuredText instead.


===== Troubleshooting =====

__Disclaimer.__ First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running `doconce2format`, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

__The LaTeX File Does Not Compile.__ 
If the problem is undefined control sequence involving
!bc
\code{...}
!ec
the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

__Verbatim Code Blocks Inside Lists Look Ugly.__ 
Read the Section *Blocks of Verbatim Computer Code* above.  Start the
`!bc` and `!ec` tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

__LaTeX Code Blocks Inside Lists Look Ugly.__
Same solution as for computer code blocks as described in the
previous paragraph. Make sure the `!bt` and `!et` tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

__Inconsistent Headings in reStructuredText.__
The `rst2*.py` and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for `===`,
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

__Strange Nested Lists in gwiki.__
Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the `.gwiki` file directly.

__Lists in gwiki Look Ugly in the Sourc.__
Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

__Debugging.__
Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
`_doconce_debugging.log`, if the third argument to `doconce2format`
is `debug`. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.


===== Header and Footer ===== 

Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if `TITLE:` or
`#TITLE:` is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.


===== Basic Parsing Ideas ===== 

# avoid list here since we have code in between (never a good idea)

The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression

!bc
(?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?
!ec

That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.


===== A Glimpse of How to Write a New Translator ===== 

This is the HTML-specific part of the
source code of the HTML translator:
# #if FORMAT == "HTML"
(note that in HTML one of the the less-than and greater-than signs
in a link come up wrong because of the simple regex that is used
to substitute these pair of signs by special HTML expressions)
# #endif

# #if FORMAT != "epytext"

!bc
FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
    # keep math as is:
    'math': None,  # indicates no substitution
    'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
    'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
    'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
    'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
    'section':       r'<h1>\g<subst></h1>',
    'subsection':    r'<h3>\g<subst></h3>',
    'subsubsection': r'<h5>\g<subst></h5>',
    'paragraph':     r'<b>\g<subst></b>. ',
    'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
    'date':          r'<center><h3>\g<subst></h3></center>',
    'author':        r'<center><h3>\g<subst></h3></center>',
    }

# how to replace code and LaTeX blocks by HTML (<pre>) environment:
def HTML_code(filestr):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
    filestr = re.sub(r'!ec\n',
                     r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'<pre>\n', filestr)
    filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
    return filestr
CODE['HTML'] = HTML_code

# how to typeset lists and their items in HTML:
LIST['HTML'] = {
    'itemize':
    {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
    'enumerate':
    {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
    'description':
    {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
    }

# how to type set description lists for function arguments, return
# values, and module/class variables:
ARGLIST['HTML'] = {
    'parameter': '<b>argument</b>',
    'keyword': '<b>keyword argument</b>',
    'return': '<b>return value(s)</b>',
    'instance variable': '<b>instance variable</b>',
    'class variable': '<b>class variable</b>',
    'module variable': '<b>module variable</b>',
    }

# document start:
INTRO['HTML'] = """
<html>
<body bgcolor="white">
"""
# document ending:
OUTRO['HTML'] = """
</body>
</html>
"""
!ec

# #else
Note that for Epytext, code or LaTeX blocks that contain a newline
character (for example as in `\nabla` in LaTeX), will lead to an
effect of the newline and generate error messages. Our remedy is
to remove such code blocks and provide a notice about the removal.
Eight here we only displacy a smaller snippet that Epytext can
treat properly:

!bc
INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
    # keep math as is:
    'math': None,  # indicates no substitution
    'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
    'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
    'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
    'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
    }
!ec

# #endif

===== Typesetting of Function Arguments, Return Values, and Variables ===== 

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that `argument`, `keyword argument`, `return`,
`instance variable`, `class variable`, and `module variable` are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string). 

!bc
    - argument x: x value (float),
      which must be a positive number.
    - keyword argument tolerance: tolerance (float) for stopping
      the iterations.
    - return: the root of the equation (float), if found, otherwise None.
    - instance variable eta: surface elevation (array).
    - class variable items: the total number of MyClass objects (int).
    - module variable debug: True: debug mode is on; False: no debugging 
      (bool variable).
!ec

The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.

    - module variable x: x value (float),
      which must be a positive number.
    - module variable tolerance: tolerance (float) for stopping
      the iterations.


************** File: manual.html *****************

<HTML>
<BODY BGCOLOR="white">
    <TITLE>Doconce Description</TITLE>
<CENTER><H1>Doconce Description</H1></CENTER>
<CENTER><H3>Hans Petter Langtangen<BR>Simula Research Laboratory and University of Oslo</H3></CENTER>
<CENTER><H3>August 27, 2010</H3></CENTER>
<P>

<P>
<!-- lines beginning with # are comment lines -->

<P>

<P>
<H1>What Is Doconce? <A NAME="what:is:doconce"></A></H1>
<P>

<P>
Doconce is two things:

<P>

<OL>
 <LI> Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).
 <LI> Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
</OL>

The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

<P>
So why not just use reStructuredText or Sphinx? Because Doconce

<P>

<UL>
  <LI> can convert to plain <EM>untagged</EM> text, 
    more desirable for computer programs and email, 
  <LI> has less cluttered tagging of text,
  <LI> has better support for copying in computer code from other files,
  <LI> has stronger support for mathematical typesetting,
  <LI> works better as a complete or partial source for large LaTeX 
    documents (reports and books).
</UL>

Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

<P>
You can jump to the section <A HREF="#doconce:strategy">The Doconce Documentation Strategy</a> to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.

<P>

<P>
<H1>Motivation: Problems with Documenting Software</H1>
<P>
<B>Duplicated Information.</B> It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

<P>
<B>Different Tagging for Different Formats.</B> A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

<P>
<B>Solution.</B> Accurate information is crucial and can only be
maintained in a <EM>single physical</EM> place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

<P>
<B>A Common Format.</B> There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, <EM>and</EM> plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need

<P>

<OL>
 <LI> A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.
 <LI> Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 
 <LI> Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).
</OL>

One answer to these points is the Doconce markup language, its associated
tools, and the <A HREF="http://code.google.com/p/preprocess/">C-style preprocessor tool</A>.
Then we can <EM>write once, include anywhere</EM>!
And what we write is close to plain ASCII text.

<P>
But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section <A HREF="#what:is:doconce">What Is Doconce?</a>, but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

<P>
A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).

<P>

<P>
<H3>Dependencies</H3>
<P>
Doconce needs the Python packages
<A HREF="http://docutils.sourceforge.net/">docutils</A>,
<A HREF="http://code.google.com/p/preprocess/">preprocess</A>, and
<A HREF="http://code.google.com/p/ptex2tex/">ptex2tex</A>. The latter is only
needed for the LaTeX formats.

<P>

<P>
<H3>The Doconce Documentation Strategy <A NAME="doconce:strategy"></A></H3>
<P>

<P>

<UL>
   <LI> Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   <LI> Use <TT>#include</TT> statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program <TT>doconce2format</TT> before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   <LI> Run the preprocessor <TT>preprocess</TT> on the files to produce native
     files for pure computer code and for various other documents.
</UL>

Consider an example involving a Python module in a <TT>basename.p.py</TT> file.
The <TT>.p.py</TT> extension identifies this as a file that has to be
preprocessed) by the <TT>preprocess</TT> program. 
In a doc string in <TT>basename.p.py</TT> we do a preprocessor include
in a comment line, say
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
#    #include "docstrings/doc1.dst.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
<!--  -->
<!-- Note: we insert an error right above as the right quote is missing. -->
<!-- Then preprocess skips the statement, otherwise it gives an error -->
<!-- message about a missing file docstrings/doc1.dst.txt (which we don't -->
<!-- have, it's just a sample file name). Also note that comment lines -->
<!-- must not come before a code block for the rst/st/epytext formats to work. -->
<!--  -->
The file <TT>docstrings/doc1.dst.txt</TT> is a file filtered to a specific format
(typically plain text, reStructedText, or Epytext) from an original
"singleton" documentation file named <TT>docstrings/doc1.do.txt</TT>. The <TT>.dst.txt</TT>
is the extension of a file filtered ready for being included in a doc
string (<TT>d</TT> for doc, <TT>st</TT> for string).

<P>
For making an Epydoc manual, the <TT>docstrings/doc1.do.txt</TT> file is
filtered to <TT>docstrings/doc1.epytext</TT> and renamed to
<TT>docstrings/doc1.dst.txt</TT>.  Then we run the preprocessor on the
<TT>basename.p.py</TT> file and create a real Python file
<TT>basename.py</TT>. Finally, we run Epydoc on this file. Alternatively, and
nowadays preferably, we use Sphinx for API documentation and then the
Doconce <TT>docstrings/doc1.do.txt</TT> file is filtered to
<TT>docstrings/doc1.rst</TT> and renamed to <TT>docstrings/doc1.dst.txt</TT>. A
Sphinx directory must have been made with the right <TT>index.rst</TT> and
<TT>conf.py</TT> files. Going to this directory and typing <TT>make html</TT> makes
the HTML version of the Sphinx API documentation.

<P>
The next step is to produce the final pure Python source code. For
this purpose we filter <TT>docstrings/doc1.do.txt</TT> to plain text format
(<TT>docstrings/doc1.txt</TT>) and rename to <TT>docstrings/doc1.dst.txt</TT>. The
preprocessor transforms the <TT>basename.p.py</TT> file to a standard Python
file <TT>basename.py</TT>. The doc strings are now in plain text and well
suited for Pydoc or reading by humans. All these steps are automated
by the <TT>insertdocstr.py</TT> script.  Here are the corresponding Unix
commands:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
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
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>

<P>
<!--  -->
<!-- some comment lines that do not affect any formatting -->
<!-- these lines are simply removed -->
<!--  -->
<!--  -->
<!--  -->
<!--  -->
<!--  -->

<P>

<P>
<H3>Demos</H3>
<P>
The current text is generated from a Doconce format stored in the
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
docs/manual/doconce.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

<P>
The file <TT>make.sh</TT> in the same directory as the <TT>doconce.do.txt</TT> file
(the current text) shows how to run <TT>doconce2format</TT> on the
<TT>doconce.do.txt</TT> file to obtain documents in various formats.  Running
this demo (<TT>make.sh</TT>) and studying the various generated files and
comparing them with the original <TT>doconce.do.txt</TT> file, gives a quick
introduction to how Doconce is used in a real case.

<P>
Another demo is found in
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
docs/tutorial/tutorial.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In the <TT>tutorial</TT> directory there is also a <TT>make.sh</TT> file producing a
lot of formats.

<P>
<!-- Example on including another Doconce file: -->

<P>

<P>
<H1>From Doconce to Other Formats</H1>
<P>
Transformation of a Doconce document to various other
formats applies the script <TT>doconce2format</TT>:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format format mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>preprocess</TT> program is always used to preprocess the file first,
and options to <TT>preprocess</TT> can be added after the filename. For example,
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The variable <TT>FORMAT</TT> is always defined as the current format when
running <TT>preprocess</TT>. That is, in the last example, <TT>FORMAT</TT> is
defined as <TT>LaTeX</TT>. Inside the Doconce document one can then perform
format specific actions through tests like <TT>#if FORMAT == "LaTeX"</TT>.

<P>

<P>
<H3>HTML</H3>
<P>
Making an HTML version of a Doconce file <TT>mydoc.do.txt</TT>
is performed by
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format HTML mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The resulting file <TT>mydoc.html</TT> can be loaded into any web browser for viewing.

<P>
<H3>LaTeX</H3>
<P>
Making a LaTeX file <TT>mydoc.tex</TT> from <TT>mydoc.do.txt</TT> is done in two steps:
<!-- Note: putting code blocks inside a list is not successful in many -->
<!-- formats - the text may be messed up. A better choice is a paragraph -->
<!-- environment, as used here. -->

<P>
<B>Step 1.</B> Filter the doconce text to a pre-LaTeX form <TT>mydoc.p.tex</TT> for
     <TT>ptex2tex</TT>:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format LaTeX mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file <TT>newcommands.tex</TT>. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

<P>
<B>Step 2.</B> Run <TT>ptex2tex</TT> (if you have it) to make a standard LaTeX file,
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just perform a plain copy,
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> cp mydoc.p.tex mydoc.tex
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>ptex2tex</TT> tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile <TT>mydoc.tex</TT> the usual way and create the PDF file.

<P>
<H3>Plain ASCII Text</H3>
<P>
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<H3>reStructuredText</H3>
<P>
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file <TT>mydoc.rst</TT>:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format rst mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
We may now produce various other formats:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The OpenOffice file <TT>mydoc.odt</TT> can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

<P>
<H3>Sphinx</H3>
<P>
Sphinx documents can be created from a Doconce source in a few steps.

<P>
<B>Step 1.</B> Translate Doconce into the Sphinx dialect of
the reStructuredText format:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format sphinx mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 2.</B> Create a Sphinx root directory with a <TT>conf.py</TT> file, 
either manually or by using the interactive <TT>sphinx-quickstart</TT>
program. Here is a scripted version of the steps with the latter:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
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
n
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
y
EOF
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 3.</B> Move the <TT>tutorial.rst</TT> file to the Sphinx root directory:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> mv mydoc.rst sphinx-rootdir
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 4.</B> Edit the generated <TT>index.rst</TT> file so that <TT>mydoc.rst</TT>
is included, i.e., add <TT>mydoc</TT> to the <TT>toctree</TT> section so that it becomes
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
.. toctree::
   :maxdepth: 2

   mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
(The spaces before <TT>mydoc</TT> are important!)

<P>
<B>Step 5.</B> Generate, for instance, an HTML version of the Sphinx source:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
make clean   # remove old versions
make html
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Many other formats are also possible.

<P>
<B>Step 6.</B> View the result:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> firefox _build/html/index.html
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<H3>Google Code Wiki</H3>
<P>
There are several different wiki dialects, but Doconce only support the
one used by <A HREF="http://code.google.com/p/support/wiki/WikiSyntax">Google Code</A>.
The transformation to this format, called <TT>gwiki</TT> to explicitly mark
it as the Google Code dialect, is done by
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce2format gwiki mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
You can then open a new wiki page for your Google Code project, copy
the <TT>mydoc.gwiki</TT> output file from <TT>doconce2format</TT> and paste the
file contents into the wiki page. Press <B>Preview</B> or <B>Save Page</B> to
see the formatted result.

<P>

<P>

<P>

<P>
<H1>The Doconce Markup Language</H1>
<P>
The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

<P>
<H3>Lists</H3>
<P>
An unordered bullet list makes use of the <TT>*</TT> as bullet sign
and is indented as follows
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
   * item 1

   * item 2

     * subitem 1, if there are more
       lines, each line must
       be intended as shown here

     * subitem 2,
       also spans two lines

   * item 3
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
This list gets typeset as

<P>

<UL>
   <LI> item 1
   <LI> item 2

<UL>
     <LI> subitem 1, if there are more
       lines, each line must
       be intended as shown here
     <LI> subitem 2,
       also spans two lines
</UL>

   <LI> item 3
</UL>

In an ordered list, each item starts with an <TT>o</TT> (as the first letter 
in "ordered"):
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
   o item 1

   o item 2

     * subitem 1

     * subitem 2

   o item 3
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
resulting in

<P>

<OL>
  <LI> item 1
  <LI> item 2

<UL>
     <LI> subitem 1
     <LI> subitem 2
</UL>

  <LI> item 3
</OL>

Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

<P>
In a description list, each item is recognized by a dash followed
by a keyword followed by a colon:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
   - keyword1: explanation of keyword1

   - keyword2: explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The result becomes

<P>

<DL>
   <DT>keyword1:<DD> 
     explanation of keyword1
   <DT>keyword2:<DD> 
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
</DL>
<H3>Special Lines</H3>
<P>
The Doconce markup language has a concept called <EM>special lines</EM>.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

<P>
Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax <TT>name at institution(s)</TT>.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
TITLE: On The Ultimate Markup Language: Doconce
AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
DATE: November 9, 2006
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Note the <TT>at</TT> with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

<P>
Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):

<UL>
   <LI> 7 underscores or equal signs for sections
   <LI> 5 for subsections
   <LI> 3 for subsubsections
   <LI> 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)
</UL>

Headings can be surrounded by blanks if desired.

<P>
Here are some examples:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
======= Example on a Section Heading ======= 

The running text goes here. 

      ===== Example on a Subsection Heading ===== 
The running text goes here.

          ===Example on a Subsubsection Heading===

The running text goes here.

__A Paragraph.__ The running text goes here.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The result for the present format looks like this:

<P>
<H1>Example on a Section Heading</H1>
<P>
The running text goes here. 

<P>
<H3>Example on a Subsection Heading</H3>
The running text goes here.

<P>
<H4>Example on a Subsubsection Heading</H4>
<P>
The running text goes here.

<P>
<B>A Paragraph.</B> The running text goes here.

<P>
Figures are recognized by the special line syntax
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
FIGURE:[filename, height=xxx width=yyy scale=zzz] caption
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

<P>
Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

<P>
The filename extension may not be compatible with the chosen output format.
For example, a filename <TT>mypic.eps</TT> is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say <TT>mypic.png</TT> for HTML output).

<P>
<IMG SRC="figs/dinoimpact.gif"  width=400> It can't get worse than this.... <A NAME="fig:impact"></A>

<P>

<P>

<P>
Another type of special lines starts with <TT>@@@CODE</TT> and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.

<P>

<P>
<H3>Inline Tagging <A NAME="inline:tagging"></A></H3>
<P>

<P>
Doconce supports tags for <EM>emphasized phrases</EM>, <B>boldface phrases</B>,
and <TT>verbatim text</TT> (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as v = sin(x).

<P>
Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
*emphasized words*
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Boldface font is recognized by an underscore instead of an asterisk:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
_several words in boldface_ followed by *ephasized text*.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The line above gets typeset as
<B>several words in boldface</B> followed by <EM>ephasized text</EM>.

<P>
Verbatim text, typically used for short inline code,
is typeset between backquotes:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
`call myroutine(a, b)` looks like a Fortran call
while `void myfunc(double *a, double *b)` must be C.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The typesetting result looks like this:
<TT>call myroutine(a, b)</TT> looks like a Fortran call
while <TT>void myfunc(double *a, double *b)</TT> must be C.

<P>
It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and <TT>ptex2tex</TT>) will have
problems with inline verbatim text that is split over two lines.

<P>
Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

<P>
Web addresses with links are typeset as
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
some URL like http://my.place.in.space/src&lt;MyPlace&gt;
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
which appears as some URL like <A HREF="http://my.place.in.space/src">MyPlace</A>.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
URL:"doconce.do.txt"
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
This constructions results in the link <A HREF="doconce.do.txt"><TT>doconce.do.txt</TT></A>.

<P>

<P>
Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Here is an example on a linear system 
${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
$\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system Ax=b, where A 
is an nxn matrix, and x and b
are vectors of length n."

<P>
<H3>Cross-Referencing</H3>
<P>
References and labels are supported. The syntax is simple:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
label{section:verbatim}   # defines a label
For more information we refer to Section ref{section:verbatim}.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by <TT>doconce2format</TT>. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

<P>
It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure <A HREF="#fig:impact">fig:impact</a>
(the label appears in the figure caption in the source code of this document).
Additional references to the sections <A HREF="#mathtext">LaTeX Blocks of Mathematical Text</a> and <A HREF="#newcommands">Macros (Newcommands)</a> are
nice to demonstrate, as well as a reference to equations,
say (<A HREF="#my:eq1">my:eq1</a>)--(<A HREF="#my:eq2">my:eq2</a>). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

<P>
Hyperlinks to files or web addresses are handled as explained
in the section <A HREF="#inline:tagging">Inline Tagging</a>.

<P>

<P>
<H3>Tables</H3>
<P>
A table like

<P>
<TABLE border="1">
<TR><TD><B>    time    </B></TD> <TD><B>  velocity  </B></TD> <TD><B>acceleration</B></TD> </TR>
<TR><TD>   0.0             </TD> <TD>   1.4186          </TD> <TD>   -5.01           </TD> </TR>
<TR><TD>   2.0             </TD> <TD>   1.376512        </TD> <TD>   11.919          </TD> </TR>
<TR><TD>   4.0             </TD> <TD>   1.1E+1          </TD> <TD>   14.717624       </TD> </TR>
</TABLE>
<P>
is built up of pipe symbols and dashes:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).

<P>

<P>
<H3>Blocks of Verbatim Computer Code</H3>
<P>
Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" <TT>!bc</TT> keyword and an "end code" <TT>!ec</TT> keyword. Both
keywords must be on a single line and <EM>start at the beginning of the
line</EM>.  There may be an argument after the <TT>!bc</TT> tag to specify a
certain <TT>ptex2tex</TT> environ (for instance, <TT>!bc dat</TT> corresponds to the
data file environment in <TT>ptex2tex</TT>; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The <TT>!ec</TT> tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

<P>
Here is a verbatim code block:
<!-- BEGIN VERBATIM BLOCK   cod-->
<BLOCKQUOTE><PRE>
# regular expressions for inline tags:
inline_tag_begin = r'(?P&lt;begin&gt;(^|\s+))'
inline_tag_end = r'(?P&lt;end&gt;[.,?!;:)\s])'
INLINE_TAGS = {
    'emphasize':
    r'%s\*(?P&lt;subst&gt;[^ `][^*`]*)\*%s' % \
    (inline_tag_begin, inline_tag_end),
    'verbatim':
    r'%s`(?P&lt;subst&gt;[^ ][^`]*)`%s' % \
    (inline_tag_begin, inline_tag_end),
    'bold':
    r'%s_(?P&lt;subst&gt;[^ `][^_`]*)_%s' % \
    (inline_tag_begin, inline_tag_end),
}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Computer code can be copied directly from a file, if desired. The syntax
is then
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
 @@@CODE myfile.f
 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The first line implies that all lines in the file <TT>myfile.f</TT> are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the <TT>@</TT> sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
<TT>subroutine test</TT> (with as many blanks as desired between the two words)
and the line matching <TT>C      END1</TT> (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

<P>
Let us copy a whole file (the first line above):
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
C     a comment

      subroutine    test()
      integer i
      real*8 r
      r = 0
      do i = 1, i
         r = r + i
      end do
      return
C     END1

      program testme
      call test()
      return
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Let us then copy just a piece in the middle as indicated by the <TT>fromto:</TT>
directive above:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
      subroutine    test()
      integer i
      real*8 r
      r = 0
      do i = 1, i
         r = r + i
      end do
      return
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
(Remark for those familiar with <TT>ptex2tex</TT>: The from-to
syntax is slightly different from that used in <TT>ptex2tex</TT>. When
transforming Doconce to LaTeX, one first transforms the document to a
<TT>.p.tex</TT> file to be treated by <TT>ptex2tex</TT>. However, the <TT>@@@CODE</TT> line
is interpreted by Doconce and replaced by a <EM>pro</EM> or <EM>cod</EM> <TT>ptex2tex</TT>
environment.)

<P>

<P>
<H3>LaTeX Blocks of Mathematical Text <A NAME="mathtext"></A></H3>
<P>

<P>
Blocks of mathematical text are like computer code blocks, but
the opening tag is <TT>!bt</TT> (begin TeX) and the closing tag is
<TT>!et</TT>. It is important that <TT>!bt</TT> and <TT>!et</TT> appear on the beginning of the
line and followed by a newline. 

<P>
Here is the result of a <TT>!bt</TT> - <TT>!et</TT> block:
<BLOCKQUOTE><PRE>
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
</PRE></BLOCKQUOTE>

<P>
This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

<P>
<H3>Macros (Newcommands) <A NAME="newcommands"></A></H3>
<P>

<P>
Doconce supports a type of macros via a LaTeX-style <EM>newcommand</EM>
construction.  The newcommands defined in a file with name
<TT>newcommand_replace.tex</TT> are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names <TT>newcommands.tex</TT> and
<TT>newcommands_keep.tex</TT> are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
<TT>!bt</TT> and <TT>!et</TT> in <TT>newcommands_keep.tex</TT> to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
<TT>newcommands_replace.tex</TT> and expanded by Doconce.  The definitions of
newcommands in the <TT>newcommands*.tex</TT> files <EM>must</EM> appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

<P>
<B>Example.</B> Suppose we have the following commands in 
<TT>newcommand_replace.tex</TT>:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
\newcommand{\beqa}{\begin{eqnarray}}
\newcommand{\eeqa}{\end{eqnarray}}
\newcommand{\ep}{\thinspace . }
\newcommand{\uvec}{\vec u}
\newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
\newcommand{\Q}{\mathbfx{Q}}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
and these in <TT>newcommands_keep.tex</TT>:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
\newcommand{\x}{\mathbfx{x}}
\newcommand{\normalvec}{\mathbfx{n}}
\newcommand{\Ddt}[1]{\frac{D#1}{dt}}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The LaTeX block
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
\beqa
\x\cdot\normalvec &=& 0,\label{my:eq1}\\
\Ddt{\uvec} &=& \Q \ep\label{my:eq2}
\eeqa
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
will then be rendered to
<BLOCKQUOTE><PRE>
\begin{eqnarray}
\x\cdot\normalvec &=& 0,\label{my:eq1}\\
\Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
\end{eqnarray}
</PRE></BLOCKQUOTE>
in the current format.

<P>
<H3>Missing Features</H3>
<P>

<UL>
  <LI> Footnotes
  <LI> Citations and bibliography
  <LI> Index
</UL>

If these things are important, one should go with reStructuredText instead.

<P>

<P>
<H3>Troubleshooting</H3>
<P>
<B>Disclaimer.</B> First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running <TT>doconce2format</TT>, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

<P>
However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

<P>
<B>The LaTeX File Does Not Compile.</B> If the problem is undefined control sequence involving
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
\code{...}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

<P>
<B>Verbatim Code Blocks Inside Lists Look Ugly.</B> Read the Section <EM>Blocks of Verbatim Computer Code</EM> above.  Start the
<TT>!bc</TT> and <TT>!ec</TT> tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

<P>
<B>LaTeX Code Blocks Inside Lists Look Ugly.</B> Same solution as for computer code blocks as described in the
previous paragraph. Make sure the <TT>!bt</TT> and <TT>!et</TT> tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

<P>
<B>Inconsistent Headings in reStructuredText.</B> The <TT>rst2*.py</TT> and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for <TT>===</TT>,
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

<P>
<B>Strange Nested Lists in gwiki.</B> Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the <TT>.gwiki</TT> file directly.

<P>
<B>Lists in gwiki Look Ugly in the Sourc.</B> Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

<P>
<B>Debugging.</B> Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
<TT>_doconce_debugging.log</TT>, if the third argument to <TT>doconce2format</TT>
is <TT>debug</TT>. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.

<P>

<P>
<H3>Header and Footer</H3>
<P>
Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if <TT>TITLE:</TT> or
<TT>#TITLE:</TT> is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.

<P>

<P>
<H3>Basic Parsing Ideas</H3>
<P>
<!-- avoid list here since we have code in between (never a good idea) -->

<P>
The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

<P>
All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

<P>
The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
(?P&lt;indent&gt; *(?P&lt;listtype&gt;[*o-] )? *)(?P&lt;keyword&gt;[^:]+?:)?(?P&lt;text&gt;.*)\s?
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

<P>
When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

<P>
The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

<P>
It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.

<P>

<P>
<H3>A Glimpse of How to Write a New Translator</H3>
<P>
This is the HTML-specific part of the
source code of the HTML translator:
(note that in HTML one of the the less-than and greater-than signs
in a link come up wrong because of the simple regex that is used
to substitute these pair of signs by special HTML expressions)
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
BLANKLINE['HTML'] = '&lt;p&gt;\n'           # blank input line => new paragraph
INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
    # keep math as is:
    'math': None,  # indicates no substitution
    'emphasize':     r'\g&lt;begin&gt;&lt;em&gt;\g&lt;subst&gt;&lt;/em&gt;\g&lt;end&gt;',
    'bold':          r'\g&lt;begin&gt;&lt;b&gt;\g&lt;subst&gt;&lt;/b&gt;\g&lt;end&gt;',
    'verbatim':      r'\g&lt;begin&gt;&lt;tt&gt;\g&lt;subst&gt;&lt;/tt&gt;\g&lt;end&gt;',
    'URL':           r'\g&lt;begin&gt;&lt;a href="\g<url&gt;">\g&lt;link&gt;&lt;/a&gt;',
    'section':       r'&lt;h1&gt;\g&lt;subst&gt;&lt;/h1&gt;',
    'subsection':    r'&lt;h3&gt;\g&lt;subst&gt;&lt;/h3&gt;',
    'subsubsection': r'&lt;h5&gt;\g&lt;subst&gt;&lt;/h5&gt;',
    'paragraph':     r'&lt;b&gt;\g&lt;subst&gt;&lt;/b&gt;. ',
    'title':         r'&lt;title&gt;\g&lt;subst&gt;&lt;/title&gt;\n&lt;center&gt;&lt;h1&gt;\g&lt;subst&gt;&lt;/h1&gt;&lt;/center&gt;',
    'date':          r'&lt;center&gt;&lt;h3&gt;\g&lt;subst&gt;&lt;/h3&gt;&lt;/center&gt;',
    'author':        r'&lt;center&gt;&lt;h3&gt;\g&lt;subst&gt;&lt;/h3&gt;&lt;/center&gt;',
    }

# how to replace code and LaTeX blocks by HTML (&lt;pre&gt;) environment:
def HTML_code(filestr):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'&lt;!-- BEGIN VERBATIM BLOCK \g<1&gt;-->\n&lt;pre&gt;\n', filestr)
    filestr = re.sub(r'!ec\n',
                     r'&lt;/pre&gt;\n&lt;! -- END VERBATIM BLOCK --&gt;\n', filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'&lt;pre&gt;\n', filestr)
    filestr = re.sub(r'!et\n', r'&lt;/pre&gt;\n', filestr)
    return filestr
CODE['HTML'] = HTML_code

# how to typeset lists and their items in HTML:
LIST['HTML'] = {
    'itemize':
    {'begin': '\n&lt;ul&gt;\n', 'item': '&lt;li&gt;', 'end': '&lt;/ul&gt;\n\n'},
    'enumerate':
    {'begin': '\n&lt;ol&gt;\n', 'item': '&lt;li&gt;', 'end': '&lt;/ol&gt;\n\n'},
    'description':
    {'begin': '\n&lt;dl&gt;\n', 'item': '&lt;dt&gt;%s&lt;dd&gt;', 'end': '&lt;/dl&gt;\n\n'},
    }

# how to type set description lists for function arguments, return
# values, and module/class variables:
ARGLIST['HTML'] = {
    'parameter': '&lt;b&gt;argument&lt;/b&gt;',
    'keyword': '&lt;b&gt;keyword argument&lt;/b&gt;',
    'return': '&lt;b&gt;return value(s)&lt;/b&gt;',
    'instance variable': '&lt;b&gt;instance variable&lt;/b&gt;',
    'class variable': '&lt;b&gt;class variable&lt;/b&gt;',
    'module variable': '&lt;b&gt;module variable&lt;/b&gt;',
    }

# document start:
INTRO['HTML'] = """
&lt;html&gt;
&lt;body bgcolor="white"&gt;
"""
# document ending:
OUTRO['HTML'] = """
&lt;/body&gt;
&lt;/html&gt;
"""
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>

<P>
<H3>Typesetting of Function Arguments, Return Values, and Variables</H3>
<P>
As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and <EM>placed at the end of
the doc string</EM>. Note that <TT>argument</TT>, <TT>keyword argument</TT>, <TT>return</TT>,
<TT>instance variable</TT>, <TT>class variable</TT>, and <TT>module variable</TT> are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using <EM>fields</EM> in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string). 
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
    - argument x: x value (float),
      which must be a positive number.
    - keyword argument tolerance: tolerance (float) for stopping
      the iterations.
    - return: the root of the equation (float), if found, otherwise None.
    - instance variable eta: surface elevation (array).
    - class variable items: the total number of MyClass objects (int).
    - module variable debug: True: debug mode is on; False: no debugging 
      (bool variable).
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.

<P>

<DL>
    <DT><B>module variable</B> x:<DD> 
      x value (float),
      which must be a positive number.
    <DT><B>module variable</B> tolerance:<DD> 
      tolerance (float) for stopping
      the iterations.
</DL>


</BODY>
</HTML>
    
************** File: manual.txt *****************
TITLE: Doconce Description
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: August 27, 2010




What Is Doconce?
================


Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).
 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce

  * can convert to plain *untagged* text, 
    more desirable for computer programs and email, 
  * has less cluttered tagging of text,
  * has better support for copying in computer code from other files,
  * has stronger support for mathematical typesetting,
  * works better as a complete or partial source for large LaTeX 
    documents (reports and books).
Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section "The Doconce Documentation Strategy" to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.


Motivation: Problems with Documenting Software
==============================================

*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

*Different Tagging for Different Formats.* A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

*Solution.* Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

*A Common Format.* There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need

 1. A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.
 2. Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 
 3. Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).
One answer to these points is the Doconce markup language, its associated
tools, and the C-style preprocessor tool (http://code.google.com/p/preprocess/).
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section "What Is Doconce?", but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).


Dependencies
------------

Doconce needs the Python packages
docutils (http://docutils.sourceforge.net/),
preprocess (http://code.google.com/p/preprocess/), and
ptex2tex (http://code.google.com/p/ptex2tex/). The latter is only
needed for the LaTeX formats.


The Doconce Documentation Strategy
----------------------------------


   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   * Use #include statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program doconce2format before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   * Run the preprocessor preprocess on the files to produce native
     files for pure computer code and for various other documents.
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






Demos
-----

The current text is generated from a Doconce format stored in the::

        docs/manual/doconce.do.txt


file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file make.sh in the same directory as the doconce.do.txt file
(the current text) shows how to run doconce2format on the
doconce.do.txt file to obtain documents in various formats.  Running
this demo (make.sh) and studying the various generated files and
comparing them with the original doconce.do.txt file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in::

        docs/tutorial/tutorial.do.txt


In the tutorial directory there is also a make.sh file producing a
lot of formats.



From Doconce to Other Formats
=============================

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
----

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
-----

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
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
----------------

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
------

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
        n
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



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by Google Code (http://code.google.com/p/support/wiki/WikiSyntax).
The transformation to this format, called gwiki to explicitly mark
it as the Google Code dialect, is done by::

        Unix/DOS> doconce2format gwiki mydoc.do.txt


You can then open a new wiki page for your Google Code project, copy
the mydoc.gwiki output file from doconce2format and paste the
file contents into the wiki page. Press _Preview_ or _Save Page_ to
see the formatted result.




The Doconce Markup Language
===========================

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

Lists
-----

An unordered bullet list makes use of the * as bullet sign
and is indented as follows::

           * item 1
        
           * item 2
        
             * subitem 1, if there are more
               lines, each line must
               be intended as shown here
        
             * subitem 2,
               also spans two lines
        
           * item 3



This list gets typeset as

   * item 1
   * item 2
     * subitem 1, if there are more
       lines, each line must
       be intended as shown here
     * subitem 2,
       also spans two lines
   * item 3
In an ordered list, each item starts with an o (as the first letter 
in "ordered")::

           o item 1
        
           o item 2
        
             * subitem 1
        
             * subitem 2
        
           o item 3



resulting in

  1. item 1
  2. item 2
     * subitem 1
     * subitem 2
  3. item 3
Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon::

           - keyword1: explanation of keyword1
        
           - keyword2: explanation
             of keyword2 (remember to indent properly
             if there are multiple lines)



The result becomes

   keyword1: 
     explanation of keyword1
   keyword2: 
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
Special Lines
-------------

The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax name at institution(s).
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example::

        TITLE: On The Ultimate Markup Language: Doconce
        AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        DATE: November 9, 2006


Note the at with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):
   * 7 underscores or equal signs for sections
   * 5 for subsections
   * 3 for subsubsections
   * 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)
Headings can be surrounded by blanks if desired.

Here are some examples::

        ======= Example on a Section Heading ======= 
        
        The running text goes here. 
        
              ===== Example on a Subsection Heading ===== 
        The running text goes here.
        
                  ===Example on a Subsubsection Heading===
        
        The running text goes here.
        
        __A Paragraph.__ The running text goes here.



The result for the present format looks like this:

Example on a Section Heading
============================

The running text goes here. 

Example on a Subsection Heading
-------------------------------
The running text goes here.

Example on a Subsubsection Heading
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The running text goes here.

*A Paragraph.* The running text goes here.

Figures are recognized by the special line syntax::

        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption


The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename mypic.eps is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say mypic.png for HTML output).

FIGURE:[figs/dinoimpact.gif, width=400] It can't get worse than this.... 



Another type of special lines starts with @@@CODE and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.


Inline Tagging
--------------


Doconce supports tags for *emphasized phrases*, _boldface phrases_,
and verbatim text (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as v = sin(x).

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in::

        *emphasized words*



Boldface font is recognized by an underscore instead of an asterisk::

        _several words in boldface_ followed by *ephasized text*.


The line above gets typeset as
_several words in boldface_ followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes::

        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.


The typesetting result looks like this:
call myroutine(a, b) looks like a Fortran call
while void myfunc(double *a, double *b) must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and ptex2tex) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as::

        some URL like http://my.place.in.space/src<MyPlace>


which appears as some URL like MyPlace (http://my.place.in.space/src).
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::

        URL:"doconce.do.txt"


This constructions results in the link doconce.do.txt.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII::

        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.


That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system Ax=b, where A 
is an nxn matrix, and x and b
are vectors of length n."

Cross-Referencing
-----------------

References and labels are supported. The syntax is simple::

        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.


This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by doconce2format. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections "LaTeX Blocks of Mathematical Text" and "Macros (Newcommands)" are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section "Inline Tagging".


Tables
------

A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

is built up of pipe symbols and dashes::

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" !bc keyword and an "end code" !ec keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the !bc tag to specify a
certain ptex2tex environ (for instance::

data file environment in ptex2tex; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The !ec tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block::

        # regular expressions for inline tags:
        inline_tag_begin = r'(?P<begin>(^|\s+))'
        inline_tag_end = r'(?P<end>[.,?!;:)\s])'
        INLINE_TAGS = {
            'emphasize':
            r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
            (inline_tag_begin, inline_tag_end),
            'verbatim':
            r'%s`(?P<subst>[^ ][^`]*)`%s' % \
            (inline_tag_begin, inline_tag_end),
            'bold':
            r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
            (inline_tag_begin, inline_tag_end),
        }



Computer code can be copied directly from a file, if desired. The syntax
is then::

         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1


The first line implies that all lines in the file myfile.f are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the @ sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
subroutine test (with as many blanks as desired between the two words)
and the line matching C      END1 (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above)::

        C     a comment
        
              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        C     END1
        
              program testme
              call test()
              return



Let us then copy just a piece in the middle as indicated by the fromto:
directive above::

              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return



(Remark for those familiar with ptex2tex: The from-to
syntax is slightly different from that used in ptex2tex. When
transforming Doconce to LaTeX, one first transforms the document to a
.p.tex file to be treated by ptex2tex. However, the @@@CODE line
is interpreted by Doconce and replaced by a *pro* or *cod* ptex2tex
environment.)


LaTeX Blocks of Mathematical Text
---------------------------------


Blocks of mathematical text are like computer code blocks, but
the opening tag is !bt (begin TeX) and the closing tag is
!et. It is important that !bt and !et appear on the beginning of the
line and followed by a newline. 

Here is the result of a !bt - !et block::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}


This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

Macros (Newcommands)
--------------------


Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
newcommand_replace.tex are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names newcommands.tex and
newcommands_keep.tex are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by::

least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
newcommands_replace.tex and expanded by Doconce.  The definitions of
newcommands in the newcommands*.tex files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

*Example.* Suppose we have the following commands in 
newcommand_replace.tex::

        \newcommand{\beqa}{\begin{eqnarray}}
        \newcommand{\eeqa}{\end{eqnarray}}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}



and these in newcommands_keep.tex::

        \newcommand{\x}{\mathbfx{x}}
        \newcommand{\normalvec}{\mathbfx{n}}
        \newcommand{\Ddt}[1]{\frac{D#1}{dt}}



The LaTeX block::

        \beqa
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\uvec} &=& \Q \ep\label{my:eq2}
        \eeqa


will then be rendered to::

        \begin{eqnarray}
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
        \end{eqnarray}

in the current format.

Missing Features
----------------

  * Footnotes
  * Citations and bibliography
  * Index
If these things are important, one should go with reStructuredText instead.


Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running doconce2format, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::

        \code{...}


the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the Section *Blocks of Verbatim Computer Code* above.  Start the::

        indenting the surrounding plain text of the list item correctly. If
        you cannot resolve the problem this way, get rid of the list and use
        paragraph headings instead. In fact, that is what is recommended:
        avoid verbatim code blocks inside lists (it makes life easier).
        
        *LaTeX Code Blocks Inside Lists Look Ugly.* Same solution as for computer code blocks as described in the
        previous paragraph. Make sure the !bt and !et tags are in column 1
        and that the rest of the non-LaTeX surrounding text is correctly indented.
        Using paragraphs instead of list items is a good idea also here.
        
        *Inconsistent Headings in reStructuredText.* The rst2*.py and Sphinx converters abort if the headers of sections
        are not consistent, i.e., a subsection must come under a section,
        and a subsubsection must come under a subsection (you cannot have
        a subsubsection directly under a section). Search for ===,
        count the number of equality signs (or underscores if you use that)
        and make sure they decrease by two every time a lower level is encountered.
        
        *Strange Nested Lists in gwiki.* Doconce cannot handle nested lists correctly in the gwiki format.
        Use nonnested lists or edit the .gwiki file directly.
        
        *Lists in gwiki Look Ugly in the Sourc.* Because the Google Code wiki format requires all text of a list item to
        be on one line, Doconce simply concatenates lines in that format,
        and because of the indentation in the original Doconce text, the gwiki
        output looks somewhat ugly. The good thing is that this gwiki source
        is seldom to be looked at - it is the Doconce source that one edits
        further.
        
        *Debugging.* Given a problem, extract a small portion of text surrounding the
        problematic area and debug that small piece of text. Doconce does a
        series of transformations of the text. The effect of each of these
        transformation steps are dumped to a logfile, named
        _doconce_debugging.log, if the third argument to doconce2format
        is debug. The logfile is inteded for the developers of Doconce, but
        may still give some idea of what is wrong.  The section "Basic Parsing
        Ideas" explains how the Doconce text is transformed into a specific
        format, and you need to know these steps to make use of the logfile.
        
        
        Header and Footer
        -----------------
        
        Some formats use a header and footer in the document. LaTeX and
        HTML are two examples of such formats. When the document is to be
        included in another document (which is often the case with
        Doconce-based documents), the header and footer are not wanted, while
        these are needed (at least in a LaTeX context) if the document is
        stand-alone. We have introduce the convention that if TITLE: or
        #TITLE: is found at the beginning of the line (i.e., the document
        has, or has an intention have, a title), the header and footer
        are included, otherwise not.
        
        
        Basic Parsing Ideas
        -------------------
        
        
        The (parts of) files with computer code to be directly included in
        the document are first copied into verbatim blocks.
        
        All verbatim and TeX blocks are removed and stored elsewhere
        to ensure that no formatting rules are not applied to these blocks.
        
        The text is examined line by line for typesetting of lists, as well as
        handling of blank lines and comment lines.
        List parsing needs some awareness of the context.
        Each line is interpreted by a regular expression::

        (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?



That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.


A Glimpse of How to Write a New Translator
------------------------------------------

This is the HTML-specific part of the
source code of the HTML translator::

        FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
        BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
        INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
            # keep math as is:
            'math': None,  # indicates no substitution
            'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
            'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
            'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
            'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
            'section':       r'<h1>\g<subst></h1>',
            'subsection':    r'<h3>\g<subst></h3>',
            'subsubsection': r'<h5>\g<subst></h5>',
            'paragraph':     r'<b>\g<subst></b>. ',
            'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
            'date':          r'<center><h3>\g<subst></h3></center>',
            'author':        r'<center><h3>\g<subst></h3></center>',
            }
        
        # how to replace code and LaTeX blocks by HTML (<pre>) environment:
        def HTML_code(filestr):
            c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
            filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
            filestr = re.sub(r'!ec\n',
                             r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
            c = re.compile(r'^!bt\n', re.MULTILINE)
            filestr = c.sub(r'<pre>\n', filestr)
            filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
            return filestr
        CODE['HTML'] = HTML_code
        
        # how to typeset lists and their items in HTML:
        LIST['HTML'] = {
            'itemize':
            {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
            'enumerate':
            {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
            'description':
            {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
            }
        
        # how to type set description lists for function arguments, return
        # values, and module/class variables:
        ARGLIST['HTML'] = {
            'parameter': '<b>argument</b>',
            'keyword': '<b>keyword argument</b>',
            'return': '<b>return value(s)</b>',
            'instance variable': '<b>instance variable</b>',
            'class variable': '<b>class variable</b>',
            'module variable': '<b>module variable</b>',
            }
        
        # document start:
        INTRO['HTML'] = """
        <html>
        <body bgcolor="white">
        """
        # document ending:
        OUTRO['HTML'] = """
        </body>
        </html>
        """




Typesetting of Function Arguments, Return Values, and Variables
---------------------------------------------------------------

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that argument, keyword argument, return,
instance variable, class variable, and module variable are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string)::

            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).



The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.

    module variable x: 
      x value (float),
      which must be a positive number.
    module variable tolerance: 
      tolerance (float) for stopping
      the iterations.
************** File: manual.rst *****************
Doconce Description
===================

:Author: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
:Date: August 27, 2010

.. lines beginning with # are comment lines


What Is Doconce?
================


Doconce is two things:


 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce


  * can convert to plain *untagged* text, 
    more desirable for computer programs and email, 

  * has less cluttered tagging of text,

  * has better support for copying in computer code from other files,

  * has stronger support for mathematical typesetting,

  * works better as a complete or partial source for large LaTeX 
    documents (reports and books).

Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section `The Doconce Documentation Strategy`_ to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.


Motivation: Problems with Documenting Software
==============================================

*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

*Different Tagging for Different Formats.* A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

*Solution.* Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

*A Common Format.* There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need


 1. A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.

 2. Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 

 3. Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).

One answer to these points is the Doconce markup language, its associated
tools, and the `C-style preprocessor tool <http://code.google.com/p/preprocess/>`_.
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section `What Is Doconce?`_, but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).


Dependencies
------------

Doconce needs the Python packages
`docutils <http://docutils.sourceforge.net/>`_,
`preprocess <http://code.google.com/p/preprocess/>`_, and
`ptex2tex <http://code.google.com/p/ptex2tex/>`_. The latter is only
needed for the LaTeX formats.


The Doconce Documentation Strategy
----------------------------------



   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use ``#include`` statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program ``doconce2format`` before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.

   * Run the preprocessor ``preprocess`` on the files to produce native
     files for pure computer code and for various other documents.

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





.. some comment lines that do not affect any formatting
.. these lines are simply removed







Demos
-----

The current text is generated from a Doconce format stored in the::

        docs/manual/doconce.do.txt


file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file ``make.sh`` in the same directory as the ``doconce.do.txt`` file
(the current text) shows how to run ``doconce2format`` on the
``doconce.do.txt`` file to obtain documents in various formats.  Running
this demo (``make.sh``) and studying the various generated files and
comparing them with the original ``doconce.do.txt`` file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in::

        docs/tutorial/tutorial.do.txt


In the ``tutorial`` directory there is also a ``make.sh`` file producing a
lot of formats.

.. Example on including another Doconce file:


From Doconce to Other Formats
=============================

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
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

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
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
----------------

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
------

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
        n
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



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by `Google Code <http://code.google.com/p/support/wiki/WikiSyntax>`_.
The transformation to this format, called ``gwiki`` to explicitly mark
it as the Google Code dialect, is done by::

        Unix/DOS> doconce2format gwiki mydoc.do.txt


You can then open a new wiki page for your Google Code project, copy
the ``mydoc.gwiki`` output file from ``doconce2format`` and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.




The Doconce Markup Language
===========================

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

Lists
-----

An unordered bullet list makes use of the ``*`` as bullet sign
and is indented as follows::

           * item 1
        
           * item 2
        
             * subitem 1, if there are more
               lines, each line must
               be intended as shown here
        
             * subitem 2,
               also spans two lines
        
           * item 3



This list gets typeset as


   * item 1

   * item 2

     * subitem 1, if there are more
       lines, each line must
       be intended as shown here

     * subitem 2,
       also spans two lines


   * item 3

In an ordered list, each item starts with an ``o`` (as the first letter 
in "ordered")::

           o item 1
        
           o item 2
        
             * subitem 1
        
             * subitem 2
        
           o item 3



resulting in


  1. item 1

  2. item 2

     * subitem 1

     * subitem 2


  3. item 3

Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon::

           - keyword1: explanation of keyword1
        
           - keyword2: explanation
             of keyword2 (remember to indent properly
             if there are multiple lines)



The result becomes


   keyword1: 
     explanation of keyword1

   keyword2: 
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)

Special Lines
-------------

The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax ``name at institution(s)``.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example::

        TITLE: On The Ultimate Markup Language: Doconce
        AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        DATE: November 9, 2006


Note the ``at`` with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):

   * 7 underscores or equal signs for sections

   * 5 for subsections

   * 3 for subsubsections

   * 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)

Headings can be surrounded by blanks if desired.

Here are some examples::

        ======= Example on a Section Heading ======= 
        
        The running text goes here. 
        
              ===== Example on a Subsection Heading ===== 
        The running text goes here.
        
                  ===Example on a Subsubsection Heading===
        
        The running text goes here.
        
        __A Paragraph.__ The running text goes here.



The result for the present format looks like this:

Example on a Section Heading
============================

The running text goes here. 

Example on a Subsection Heading
-------------------------------
The running text goes here.

Example on a Subsubsection Heading
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The running text goes here.

*A Paragraph.* The running text goes here.

Figures are recognized by the special line syntax::

        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption


The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename ``mypic.eps`` is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say ``mypic.png`` for HTML output).


.. figure:: figs/dinoimpact.gif
   :width: 400

   It can't get worse than this....




Another type of special lines starts with ``@@@CODE`` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.


Inline Tagging
--------------


Doconce supports tags for *emphasized phrases*, **boldface phrases**,
and ``verbatim text`` (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as v = sin(x).

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in::

        *emphasized words*



Boldface font is recognized by an underscore instead of an asterisk::

        _several words in boldface_ followed by *ephasized text*.


The line above gets typeset as
**several words in boldface** followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes::

        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.


The typesetting result looks like this:
``call myroutine(a, b)`` looks like a Fortran call
while ``void myfunc(double *a, double *b)`` must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and ``ptex2tex``) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as::

        some URL like http://my.place.in.space/src<MyPlace>


which appears as some URL like `MyPlace <http://my.place.in.space/src>`_.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::

        URL:"doconce.do.txt"


This constructions results in the link `<doconce.do.txt>`_.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII::

        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.


That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system Ax=b, where A 
is an nxn matrix, and x and b
are vectors of length n."

Cross-Referencing
-----------------

References and labels are supported. The syntax is simple::

        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.


This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by ``doconce2format``. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections `LaTeX Blocks of Mathematical Text`_ and `Macros (Newcommands)`_ are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section `Inline Tagging`_.


Tables
------

A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

is built up of pipe symbols and dashes::

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" ``!bc`` keyword and an "end code" ``!ec`` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the ``!bc`` tag to specify a
certain ``ptex2tex`` environ (for instance, ``!bc dat`` corresponds to the
data file environment in ``ptex2tex``; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The ``!ec`` tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block::

        # regular expressions for inline tags:
        inline_tag_begin = r'(?P<begin>(^|\s+))'
        inline_tag_end = r'(?P<end>[.,?!;:)\s])'
        INLINE_TAGS = {
            'emphasize':
            r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
            (inline_tag_begin, inline_tag_end),
            'verbatim':
            r'%s`(?P<subst>[^ ][^`]*)`%s' % \
            (inline_tag_begin, inline_tag_end),
            'bold':
            r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
            (inline_tag_begin, inline_tag_end),
        }



Computer code can be copied directly from a file, if desired. The syntax
is then::

         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1


The first line implies that all lines in the file ``myfile.f`` are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the ``@`` sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
``subroutine test`` (with as many blanks as desired between the two words)
and the line matching ``C      END1`` (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above)::

        C     a comment
        
              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        C     END1
        
              program testme
              call test()
              return



Let us then copy just a piece in the middle as indicated by the ``fromto:``
directive above::

              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return



(Remark for those familiar with ``ptex2tex``: The from-to
syntax is slightly different from that used in ``ptex2tex``. When
transforming Doconce to LaTeX, one first transforms the document to a
``.p.tex`` file to be treated by ``ptex2tex``. However, the ``@@@CODE`` line
is interpreted by Doconce and replaced by a *pro* or *cod* ``ptex2tex``
environment.)


LaTeX Blocks of Mathematical Text
---------------------------------


Blocks of mathematical text are like computer code blocks, but
the opening tag is ``!bt`` (begin TeX) and the closing tag is
``!et``. It is important that ``!bt`` and ``!et`` appear on the beginning of the
line and followed by a newline. 

Here is the result of a ``!bt`` - ``!et`` block::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}


This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

Macros (Newcommands)
--------------------


Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
``newcommand_replace.tex`` are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names ``newcommands.tex`` and
``newcommands_keep.tex`` are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
``!bt`` and ``!et`` in ``newcommands_keep.tex`` to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
``newcommands_replace.tex`` and expanded by Doconce.  The definitions of
newcommands in the ``newcommands*.tex`` files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

*Example.* Suppose we have the following commands in 
``newcommand_replace.tex``::

        \newcommand{\beqa}{\begin{eqnarray}}
        \newcommand{\eeqa}{\end{eqnarray}}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}



and these in ``newcommands_keep.tex``::

        \newcommand{\x}{\mathbfx{x}}
        \newcommand{\normalvec}{\mathbfx{n}}
        \newcommand{\Ddt}[1]{\frac{D#1}{dt}}



The LaTeX block::

        \beqa
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\uvec} &=& \Q \ep\label{my:eq2}
        \eeqa


will then be rendered to::

        \begin{eqnarray}
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
        \end{eqnarray}

in the current format.

Missing Features
----------------


  * Footnotes

  * Citations and bibliography

  * Index

If these things are important, one should go with reStructuredText instead.


Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running ``doconce2format``, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::

        \code{...}


the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the Section *Blocks of Verbatim Computer Code* above.  Start the
``!bc`` and ``!ec`` tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

*LaTeX Code Blocks Inside Lists Look Ugly.* Same solution as for computer code blocks as described in the
previous paragraph. Make sure the ``!bt`` and ``!et`` tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

*Inconsistent Headings in reStructuredText.* The ``rst2*.py`` and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for ``===``,
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

*Strange Nested Lists in gwiki.* Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the ``.gwiki`` file directly.

*Lists in gwiki Look Ugly in the Sourc.* Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
``_doconce_debugging.log``, if the third argument to ``doconce2format``
is ``debug``. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.


Header and Footer
-----------------

Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if ``TITLE:`` or
``#TITLE:`` is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.


Basic Parsing Ideas
-------------------

.. avoid list here since we have code in between (never a good idea)

The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression::

        (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?



That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.


A Glimpse of How to Write a New Translator
------------------------------------------

This is the HTML-specific part of the
source code of the HTML translator::

        FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
        BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
        INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
            # keep math as is:
            'math': None,  # indicates no substitution
            'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
            'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
            'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
            'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
            'section':       r'<h1>\g<subst></h1>',
            'subsection':    r'<h3>\g<subst></h3>',
            'subsubsection': r'<h5>\g<subst></h5>',
            'paragraph':     r'<b>\g<subst></b>. ',
            'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
            'date':          r'<center><h3>\g<subst></h3></center>',
            'author':        r'<center><h3>\g<subst></h3></center>',
            }
        
        # how to replace code and LaTeX blocks by HTML (<pre>) environment:
        def HTML_code(filestr):
            c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
            filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
            filestr = re.sub(r'!ec\n',
                             r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
            c = re.compile(r'^!bt\n', re.MULTILINE)
            filestr = c.sub(r'<pre>\n', filestr)
            filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
            return filestr
        CODE['HTML'] = HTML_code
        
        # how to typeset lists and their items in HTML:
        LIST['HTML'] = {
            'itemize':
            {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
            'enumerate':
            {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
            'description':
            {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
            }
        
        # how to type set description lists for function arguments, return
        # values, and module/class variables:
        ARGLIST['HTML'] = {
            'parameter': '<b>argument</b>',
            'keyword': '<b>keyword argument</b>',
            'return': '<b>return value(s)</b>',
            'instance variable': '<b>instance variable</b>',
            'class variable': '<b>class variable</b>',
            'module variable': '<b>module variable</b>',
            }
        
        # document start:
        INTRO['HTML'] = """
        <html>
        <body bgcolor="white">
        """
        # document ending:
        OUTRO['HTML'] = """
        </body>
        </html>
        """




Typesetting of Function Arguments, Return Values, and Variables
---------------------------------------------------------------

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that ``argument``, ``keyword argument``, ``return``,
``instance variable``, ``class variable``, and ``module variable`` are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string)::

            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).



The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.


    module variable x: 
      x value (float),
      which must be a positive number.

    module variable tolerance: 
      tolerance (float) for stopping
      the iterations.
************** File: manual.sphinx.rst *****************
Doconce Description
===================

:Author: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
:Date: August 27, 2010

.. lines beginning with # are comment lines


What Is Doconce?
================


Doconce is two things:


 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).

 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce


  * can convert to plain *untagged* text, 
    more desirable for computer programs and email, 

  * has less cluttered tagging of text,

  * has better support for copying in computer code from other files,

  * has stronger support for mathematical typesetting,

  * works better as a complete or partial source for large LaTeX 
    documents (reports and books).

Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section :ref:`doconce:strategy` to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.


Motivation: Problems with Documenting Software
==============================================

*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

*Different Tagging for Different Formats.* A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

*Solution.* Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

*A Common Format.* There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need


 1. A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.

 2. Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 

 3. Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).

One answer to these points is the Doconce markup language, its associated
tools, and the `C-style preprocessor tool <http://code.google.com/p/preprocess/>`_.
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section :ref:`what:is:doconce`, but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).


Dependencies
------------

Doconce needs the Python packages
`docutils <http://docutils.sourceforge.net/>`_,
`preprocess <http://code.google.com/p/preprocess/>`_, and
`ptex2tex <http://code.google.com/p/ptex2tex/>`_. The latter is only
needed for the LaTeX formats.


The Doconce Documentation Strategy
----------------------------------



   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use ``#include`` statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program ``doconce2format`` before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.

   * Run the preprocessor ``preprocess`` on the files to produce native
     files for pure computer code and for various other documents.

Consider an example involving a Python module in a ``basename.p.py`` file.
The ``.p.py`` extension identifies this as a file that has to be
preprocessed) by the ``preprocess`` program. 
In a doc string in ``basename.p.py`` we do a preprocessor include
in a comment line, say

.. code-block:: python

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
commands:

.. code-block:: python

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





.. some comment lines that do not affect any formatting
.. these lines are simply removed







Demos
-----

The current text is generated from a Doconce format stored in the

.. code-block:: python

        docs/manual/doconce.do.txt


file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file ``make.sh`` in the same directory as the ``doconce.do.txt`` file
(the current text) shows how to run ``doconce2format`` on the
``doconce.do.txt`` file to obtain documents in various formats.  Running
this demo (``make.sh``) and studying the various generated files and
comparing them with the original ``doconce.do.txt`` file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in

.. code-block:: python

        docs/tutorial/tutorial.do.txt


In the ``tutorial`` directory there is also a ``make.sh`` file producing a
lot of formats.

.. Example on including another Doconce file:


From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script ``doconce2format``:

.. code-block:: python

        Unix/DOS> doconce2format format mydoc.do.txt


The ``preprocess`` program is always used to preprocess the file first,
and options to ``preprocess`` can be added after the filename. For example,

.. code-block:: python

        Unix/DOS> doconce2format LaTeX mydoc.do.txt -Dextra_sections


The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by

.. code-block:: python

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many
.. formats - the text may be messed up. A better choice is a paragraph
.. environment, as used here.

*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``:

.. code-block:: python

        Unix/DOS> doconce2format LaTeX mydoc.do.txt


LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in a file ``newcommands.tex``. If this file is present,
it is included in the LaTeX document so that your commands are
defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file,

.. code-block:: python

        Unix/DOS> ptex2tex mydoc


or just perform a plain copy,

.. code-block:: python

        Unix/DOS> cp mydoc.p.tex mydoc.tex


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents.
Finally, compile ``mydoc.tex`` the usual way and create the PDF file.

Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:

.. code-block:: python

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``:

.. code-block:: python

        Unix/DOS> doconce2format rst mydoc.do.txt


We may now produce various other formats:

.. code-block:: python

        Unix/DOS> rst2html.py  mydoc.rst > mydoc.html # HTML
        Unix/DOS> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Unix/DOS> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Unix/DOS> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice


The OpenOffice file ``mydoc.odt`` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format:

.. code-block:: python

        Unix/DOS> doconce2format sphinx mydoc.do.txt



*Step 2.* Create a Sphinx root directory with a ``conf.py`` file, 
either manually or by using the interactive ``sphinx-quickstart``
program. Here is a scripted version of the steps with the latter:

.. code-block:: python

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
        n
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
        y
        EOF



*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory:

.. code-block:: python

        Unix/DOS> mv mydoc.rst sphinx-rootdir



*Step 4.* Edit the generated ``index.rst`` file so that ``mydoc.rst``
is included, i.e., add ``mydoc`` to the ``toctree`` section so that it becomes

.. code-block:: python

        .. toctree::
           :maxdepth: 2
        
           mydoc


(The spaces before ``mydoc`` are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source:

.. code-block:: python

        make clean   # remove old versions
        make html


Many other formats are also possible.

*Step 6.* View the result:

.. code-block:: python

        Unix/DOS> firefox _build/html/index.html



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by `Google Code <http://code.google.com/p/support/wiki/WikiSyntax>`_.
The transformation to this format, called ``gwiki`` to explicitly mark
it as the Google Code dialect, is done by

.. code-block:: python

        Unix/DOS> doconce2format gwiki mydoc.do.txt


You can then open a new wiki page for your Google Code project, copy
the ``mydoc.gwiki`` output file from ``doconce2format`` and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.




The Doconce Markup Language
===========================

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

Lists
-----

An unordered bullet list makes use of the ``*`` as bullet sign
and is indented as follows

.. code-block:: python

           * item 1
        
           * item 2
        
             * subitem 1, if there are more
               lines, each line must
               be intended as shown here
        
             * subitem 2,
               also spans two lines
        
           * item 3



This list gets typeset as


   * item 1

   * item 2

     * subitem 1, if there are more
       lines, each line must
       be intended as shown here

     * subitem 2,
       also spans two lines


   * item 3

In an ordered list, each item starts with an ``o`` (as the first letter 
in "ordered"):

.. code-block:: python

           o item 1
        
           o item 2
        
             * subitem 1
        
             * subitem 2
        
           o item 3



resulting in


  1. item 1

  2. item 2

     * subitem 1

     * subitem 2


  3. item 3

Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon:

.. code-block:: python

           - keyword1: explanation of keyword1
        
           - keyword2: explanation
             of keyword2 (remember to indent properly
             if there are multiple lines)



The result becomes


   keyword1: 
     explanation of keyword1

   keyword2: 
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)

Special Lines
-------------

The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax ``name at institution(s)``.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example:

.. code-block:: python

        TITLE: On The Ultimate Markup Language: Doconce
        AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        DATE: November 9, 2006


Note the ``at`` with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):

   * 7 underscores or equal signs for sections

   * 5 for subsections

   * 3 for subsubsections

   * 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)

Headings can be surrounded by blanks if desired.

Here are some examples:

.. code-block:: python

        ======= Example on a Section Heading ======= 
        
        The running text goes here. 
        
              ===== Example on a Subsection Heading ===== 
        The running text goes here.
        
                  ===Example on a Subsubsection Heading===
        
        The running text goes here.
        
        __A Paragraph.__ The running text goes here.



The result for the present format looks like this:

Example on a Section Heading
============================

The running text goes here. 

Example on a Subsection Heading
-------------------------------
The running text goes here.

Example on a Subsubsection Heading
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The running text goes here.

*A Paragraph.* The running text goes here.

Figures are recognized by the special line syntax

.. code-block:: python

        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption


The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename ``mypic.eps`` is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say ``mypic.png`` for HTML output).


.. figure:: figs/dinoimpact.*
   :width: 400

   It can't get worse than this....




Another type of special lines starts with ``@@@CODE`` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.


Inline Tagging
--------------


Doconce supports tags for *emphasized phrases*, **boldface phrases**,
and ``verbatim text`` (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as :math:`\nu = \sin(x)`.

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in

.. code-block:: python

        *emphasized words*



Boldface font is recognized by an underscore instead of an asterisk:

.. code-block:: python

        _several words in boldface_ followed by *ephasized text*.


The line above gets typeset as
**several words in boldface** followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes:

.. code-block:: python

        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.


The typesetting result looks like this:
``call myroutine(a, b)`` looks like a Fortran call
while ``void myfunc(double *a, double *b)`` must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and ``ptex2tex``) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as

.. code-block:: python

        some URL like http://my.place.in.space/src<MyPlace>


which appears as some URL like `MyPlace <http://my.place.in.space/src>`_.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:

.. code-block:: python

        URL:"doconce.do.txt"


This constructions results in the link `<doconce.do.txt>`_.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII:

.. code-block:: python

        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.


That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system :math:`{\bf A}{\bf x} = {\bf b}`, where :math:`\bf A` 
is an :math:`n\times n` matrix, and :math:`\bf x` and :math:`\bf b`
are vectors of length :math:`n`."

Cross-Referencing
-----------------

References and labels are supported. The syntax is simple:

.. code-block:: python

        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.


This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by ``doconce2format``. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections :ref:`mathtext` and :ref:`newcommands` are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section :ref:`inline:tagging`.


Tables
------

A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

is built up of pipe symbols and dashes:

.. code-block:: python

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" ``!bc`` keyword and an "end code" ``!ec`` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the ``!bc`` tag to specify a
certain ``ptex2tex`` environ (for instance, ``!bc dat`` corresponds to the
data file environment in ``ptex2tex``; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The ``!ec`` tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block:

.. code-block:: python

        # regular expressions for inline tags:
        inline_tag_begin = r'(?P<begin>(^|\s+))'
        inline_tag_end = r'(?P<end>[.,?!;:)\s])'
        INLINE_TAGS = {
            'emphasize':
            r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
            (inline_tag_begin, inline_tag_end),
            'verbatim':
            r'%s`(?P<subst>[^ ][^`]*)`%s' % \
            (inline_tag_begin, inline_tag_end),
            'bold':
            r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
            (inline_tag_begin, inline_tag_end),
        }



Computer code can be copied directly from a file, if desired. The syntax
is then

.. code-block:: python

         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1


The first line implies that all lines in the file ``myfile.f`` are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the ``@`` sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
``subroutine test`` (with as many blanks as desired between the two words)
and the line matching ``C      END1`` (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above):

.. code-block:: python

        C     a comment
        
              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        C     END1
        
              program testme
              call test()
              return



Let us then copy just a piece in the middle as indicated by the ``fromto:``
directive above:

.. code-block:: python

              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return



(Remark for those familiar with ``ptex2tex``: The from-to
syntax is slightly different from that used in ``ptex2tex``. When
transforming Doconce to LaTeX, one first transforms the document to a
``.p.tex`` file to be treated by ``ptex2tex``. However, the ``@@@CODE`` line
is interpreted by Doconce and replaced by a *pro* or *cod* ``ptex2tex``
environment.)


LaTeX Blocks of Mathematical Text
---------------------------------


Blocks of mathematical text are like computer code blocks, but
the opening tag is ``!bt`` (begin TeX) and the closing tag is
``!et``. It is important that ``!bt`` and ``!et`` appear on the beginning of the
line and followed by a newline. 

Here is the result of a ``!bt`` - ``!et`` block:

.. math::

        
        {\partial u\over\partial t}  &=  \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t}  &=  \nabla\cdot(q(u)\nabla v) + g
        


This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

Macros (Newcommands)
--------------------


Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
``newcommand_replace.tex`` are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names ``newcommands.tex`` and
``newcommands_keep.tex`` are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
``!bt`` and ``!et`` in ``newcommands_keep.tex`` to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
``newcommands_replace.tex`` and expanded by Doconce.  The definitions of
newcommands in the ``newcommands*.tex`` files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

*Example.* Suppose we have the following commands in 
``newcommand_replace.tex``:

.. code-block:: python

        \newcommand{a}{}
        \newcommand{a}{}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}



and these in ``newcommands_keep.tex``:

.. code-block:: python

        \newcommand{\x}{\mathbfx{x}}
        \newcommand{\normalvec}{\mathbfx{n}}
        \newcommand{\Ddt}[1]{\frac{D#1}{dt}}



The LaTeX block

.. code-block:: python

        a
        \x\cdot\normalvec  &=  0,\label{my:eq1}\\
        \Ddt{\uvec}  &=  \Q \ep\label{my:eq2}
        a


will then be rendered to

.. math::

        
        {\mbox{\boldmath $x$}}\cdot{\mbox{\boldmath $n$}}  &=  0,\label{my:eq1}\\
        \frac{D\vec u}{dt}  &=  {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
        

in the current format.

Missing Features
----------------


  * Footnotes

  * Citations and bibliography

  * Index

If these things are important, one should go with reStructuredText instead.


Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running ``doconce2format``, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving

.. code-block:: python

        \code{...}


the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the Section *Blocks of Verbatim Computer Code* above.  Start the
``!bc`` and ``!ec`` tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

*LaTeX Code Blocks Inside Lists Look Ugly.* Same solution as for computer code blocks as described in the
previous paragraph. Make sure the ``!bt`` and ``!et`` tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

*Inconsistent Headings in reStructuredText.* The ``rst2*.py`` and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for ``===``,
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

*Strange Nested Lists in gwiki.* Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the ``.gwiki`` file directly.

*Lists in gwiki Look Ugly in the Sourc.* Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
``_doconce_debugging.log``, if the third argument to ``doconce2format``
is ``debug``. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.


Header and Footer
-----------------

Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if ``TITLE:`` or
``#TITLE:`` is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.


Basic Parsing Ideas
-------------------

.. avoid list here since we have code in between (never a good idea)

The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression

.. code-block:: python

        (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?



That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.


A Glimpse of How to Write a New Translator
------------------------------------------

This is the HTML-specific part of the
source code of the HTML translator:

.. code-block:: python

        FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
        BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
        INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
            # keep math as is:
            'math': None,  # indicates no substitution
            'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
            'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
            'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
            'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
            'section':       r'<h1>\g<subst></h1>',
            'subsection':    r'<h3>\g<subst></h3>',
            'subsubsection': r'<h5>\g<subst></h5>',
            'paragraph':     r'<b>\g<subst></b>. ',
            'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
            'date':          r'<center><h3>\g<subst></h3></center>',
            'author':        r'<center><h3>\g<subst></h3></center>',
            }
        
        # how to replace code and LaTeX blocks by HTML (<pre>) environment:
        def HTML_code(filestr):
            c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
            filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
            filestr = re.sub(r'!ec\n',
                             r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
            c = re.compile(r'^!bt\n', re.MULTILINE)
            filestr = c.sub(r'<pre>\n', filestr)
            filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
            return filestr
        CODE['HTML'] = HTML_code
        
        # how to typeset lists and their items in HTML:
        LIST['HTML'] = {
            'itemize':
            {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
            'enumerate':
            {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
            'description':
            {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
            }
        
        # how to type set description lists for function arguments, return
        # values, and module/class variables:
        ARGLIST['HTML'] = {
            'parameter': '<b>argument</b>',
            'keyword': '<b>keyword argument</b>',
            'return': '<b>return value(s)</b>',
            'instance variable': '<b>instance variable</b>',
            'class variable': '<b>class variable</b>',
            'module variable': '<b>module variable</b>',
            }
        
        # document start:
        INTRO['HTML'] = """
        <html>
        <body bgcolor="white">
        """
        # document ending:
        OUTRO['HTML'] = """
        </body>
        </html>
        """




Typesetting of Function Arguments, Return Values, and Variables
---------------------------------------------------------------

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that ``argument``, ``keyword argument``, ``return``,
``instance variable``, ``class variable``, and ``module variable`` are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string). 

.. code-block:: python

            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).



The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.


    module variable x: 
      x value (float),
      which must be a positive number.

    module variable tolerance: 
      tolerance (float) for stopping
      the iterations.
************** File: manual.gwiki *****************
#summary Doconce Description
<wiki:toc max_depth="2" />

==== Hans Petter Langtangen, Simula Research Laboratory and University of Oslo ====

==== August 27, 2010 ====

<wiki:comment> lines beginning with # are comment lines </wiki:comment>



== What Is Doconce? ==

Doconce is two things:



 # Doconce is a working strategy for documenting software in a single    place and avoiding duplication of information. The slogan is:    "Write once, include anywhere". This requires that what you write    can be transformed to many different formats for a variety of    documents (manuals, tutorials, books, doc strings, source code    documentation, etc.).
 # Doconce is a simple and minimally tagged markup language that can    be used for the above purpose. That is, the Doconce format look    like ordinary ASCII text (much like what you would use in an    email), but the text can be transformed to numerous other formats,    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,    Epytext, and also plain text (where non-obvious formatting/tags are    removed for clear reading in, e.g., emails). From reStructuredText    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the    latter to RTF and MS Word.

The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce



  * can convert to plain *untagged* text,     more desirable for computer programs and email, 
  * has less cluttered tagging of text,
  * has better support for copying in computer code from other files,
  * has stronger support for mathematical typesetting,
  * works better as a complete or partial source for large LaTeX     documents (reports and books).

Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section [#The_Doconce_Documentation_Strategy] to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.



== Motivation: Problems with Documenting Software ==

*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

*Different Tagging for Different Formats.* A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

*Solution.* Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

*A Common Format.* There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need



 # A minimally tagged markup language with full support for     for mathematics and verbatim computer code.
 # Filters for producing highly tagged formats (LaTeX, HTML, XML),    medium tagged formats (reStructuredText, Epytext), and plain    text with completely invivisble tagging. 
 # Tools for inserting appropriately filtered versions of a "singleton"    documentation file in other documents (doc strings, manuals, tutorials).

One answer to these points is the Doconce markup language, its associated
tools, and the [http://code.google.com/p/preprocess/ C-style preprocessor tool].
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section [#What_Is_Doconce?], but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).

==== Dependencies ====

Doconce needs the Python packages
[http://docutils.sourceforge.net/ docutils],
[http://code.google.com/p/preprocess/ preprocess], and
[http://code.google.com/p/ptex2tex/ ptex2tex]. The latter is only
needed for the LaTeX formats.

==== The Doconce Documentation Strategy ====

   * Write software documentation, both tutorials and manuals, in     the Doconce format. Use many files - and never duplicate information!
   * Use `#include` statements in source code (especially in doc     strings) and in LaTeX documents for including documentation     files.  These documentation files must be filtered to an     appropriate format by the program `doconce2format` before being     included. In a Python context, this means plain text for computer     source code (and Pydoc); Epytext for Epydoc API documentation, or     the Sphinx dialect of reStructuredText for Sphinx API     documentation; LaTeX for LaTeX manuals; and possibly     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   * Run the preprocessor `preprocess` on the files to produce native     files for pure computer code and for various other documents.

Consider an example involving a Python module in a `basename.p.py` file.
The `.p.py` extension identifies this as a file that has to be
preprocessed) by the `preprocess` program. 
In a doc string in `basename.p.py` we do a preprocessor include
in a comment line, say
{{{
#    #include "docstrings/doc1.dst.txt
}}}
<wiki:comment>  </wiki:comment>
<wiki:comment> Note: we insert an error right above as the right quote is missing. </wiki:comment>
<wiki:comment> Then preprocess skips the statement, otherwise it gives an error </wiki:comment>
<wiki:comment> message about a missing file docstrings/doc1.dst.txt (which we don't </wiki:comment>
<wiki:comment> have, it's just a sample file name). Also note that comment lines </wiki:comment>
<wiki:comment> must not come before a code block for the rst/st/epytext formats to work. </wiki:comment>
<wiki:comment>  </wiki:comment>
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


<wiki:comment>  </wiki:comment>
<wiki:comment> some comment lines that do not affect any formatting </wiki:comment>
<wiki:comment> these lines are simply removed </wiki:comment>
<wiki:comment>  </wiki:comment>
<wiki:comment>  </wiki:comment>
<wiki:comment>  </wiki:comment>
<wiki:comment>  </wiki:comment>
<wiki:comment>  </wiki:comment>

==== Demos ====

The current text is generated from a Doconce format stored in the
{{{
docs/manual/doconce.do.txt
}}}
file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file `make.sh` in the same directory as the `doconce.do.txt` file
(the current text) shows how to run `doconce2format` on the
`doconce.do.txt` file to obtain documents in various formats.  Running
this demo (`make.sh`) and studying the various generated files and
comparing them with the original `doconce.do.txt` file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in
{{{
docs/tutorial/tutorial.do.txt
}}}
In the `tutorial` directory there is also a `make.sh` file producing a
lot of formats.

<wiki:comment> Example on including another Doconce file: </wiki:comment>



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

==== HTML ====

Making an HTML version of a Doconce file `mydoc.do.txt`
is performed by
{{{
Unix/DOS> doconce2format HTML mydoc.do.txt
}}}
The resulting file `mydoc.html` can be loaded into any web browser for viewing.

==== LaTeX ====

Making a LaTeX file `mydoc.tex` from `mydoc.do.txt` is done in two steps:
<wiki:comment> Note: putting code blocks inside a list is not successful in many </wiki:comment>
<wiki:comment> formats - the text may be messed up. A better choice is a paragraph </wiki:comment>
<wiki:comment> environment, as used here. </wiki:comment>

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

==== Plain ASCII Text ====

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
{{{
Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt
}}}

==== reStructuredText ====

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

==== Sphinx ====

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
n
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

==== Google Code Wiki ====

There are several different wiki dialects, but Doconce only support the
one used by [http://code.google.com/p/support/wiki/WikiSyntax Google Code].
The transformation to this format, called `gwiki` to explicitly mark
it as the Google Code dialect, is done by
{{{
Unix/DOS> doconce2format gwiki mydoc.do.txt
}}}
You can then open a new wiki page for your Google Code project, copy
the `mydoc.gwiki` output file from `doconce2format` and paste the
file contents into the wiki page. Press *Preview* or *Save Page* to
see the formatted result.



== The Doconce Markup Language ==

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

==== Lists ====

An unordered bullet list makes use of the `*` as bullet sign
and is indented as follows
{{{
   * item 1

   * item 2

     * subitem 1, if there are more
       lines, each line must
       be intended as shown here

     * subitem 2,
       also spans two lines

   * item 3
}}}

This list gets typeset as



   * item 1
   * item 2

     * subitem 1, if there are more       lines, each line must       be intended as shown here
     * subitem 2,       also spans two lines


   * item 3

(As seen, nested lists in (g)wiki format are not treated well by
Doconce. Plain unnested lists work fine. And the (g)wiki format
automatically puts multiple lines of an item on a single line as
required :-)

In an ordered list, each item starts with an `o` (as the first letter 
in "ordered"):
{{{
   o item 1

   o item 2

     * subitem 1

     * subitem 2

   o item 3
}}}

resulting in



  # item 1
  # item 2

     * subitem 1
     * subitem 2


  # item 3

(Again, there are problems with mixing nested lists and liststypes
for the (g)wiki format.)

Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon:
{{{
   - keyword1: explanation of keyword1

   - keyword2: explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
}}}

The result becomes



   * keyword1:  
     explanation of keyword1
   * keyword2:  
     explanation     of keyword2 (remember to indent properly     if there are multiple lines)

==== Special Lines ====

The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax `name at institution(s)`.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example:
{{{
TITLE: On The Ultimate Markup Language: Doconce
AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
DATE: November 9, 2006
}}}
Note the `at` with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):


   * 7 underscores or equal signs for sections
   * 5 for subsections
   * 3 for subsubsections
   * 2 underscrores (only! - it looks best) for paragraphs      (paragraph heading will be inlined)

Headings can be surrounded by blanks if desired.

Here are some examples:
{{{
======= Example on a Section Heading ======= 

The running text goes here. 

      ===== Example on a Subsection Heading ===== 
The running text goes here.

          ===Example on a Subsubsection Heading===

The running text goes here.

__A Paragraph.__ The running text goes here.
}}}

The result for the present format looks like this:



== Example on a Section Heading ==

The running text goes here. 

==== Example on a Subsection Heading ====

The running text goes here.

==== Example on a Subsubsection Heading ====

The running text goes here.

*A Paragraph.* The running text goes here.

Figures are recognized by the special line syntax
{{{
FIGURE:[filename, height=xxx width=yyy scale=zzz] caption
}}}
The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename `mypic.eps` is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say `mypic.png` for HTML output).



---------------------------------------------------------------

Figure: It can't get worse than this.... 

https://doconce.googlecode.com/hg/trunk/docs/manual/figs/dinoimpact.gif

<wiki:comment> 
Put the figure file figs/dinoimpact.gif on the web and write the
URL above or below the Figure: ... line. Then remove these comments.

Typical URLs for figures stored along with the code at googlecode.com:
[http://yourproject.googlecode.com/svn/.../figs/dinoimpact.gif
http://yourproject.googlecode.com/hg/.../figs/dinoimpact.gif
 /wiki:comment]
---------------------------------------------------------------





Another type of special lines starts with `@@@CODE` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.

==== Inline Tagging ====

Doconce supports tags for *emphasized phrases*, *boldface phrases*,
and `verbatim text` (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as `v = sin(x)`.

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in
{{{
*emphasized words*
}}}

Boldface font is recognized by an underscore instead of an asterisk:
{{{
_several words in boldface_ followed by *ephasized text*.
}}}
The line above gets typeset as
*several words in boldface* followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes:
{{{
`call myroutine(a, b)` looks like a Fortran call
while `void myfunc(double *a, double *b)` must be C.
}}}
The typesetting result looks like this:
`call myroutine(a, b)` looks like a Fortran call
while `void myfunc(double *a, double *b)` must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and `ptex2tex`) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as
{{{
some URL like http://my.place.in.space/src<MyPlace>
}}}
which appears as some URL like [http://my.place.in.space/src MyPlace].
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:
{{{
URL:"doconce.do.txt"
}}}
This constructions results in the link doconce.do.txt.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII:
{{{
Here is an example on a linear system 
${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
$\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.
}}}
That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system `Ax=b`, where `A` 
is an `nxn` matrix, and `x` and `b`
are vectors of length `n`."

==== Cross-Referencing ====

References and labels are supported. The syntax is simple:
{{{
label{section:verbatim}   # defines a label
For more information we refer to Section ref{section:verbatim}.
}}}
This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by `doconce2format`. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections [#LaTeX_Blocks_of_Mathematical_Text] and [#Macros_(Newcommands)] are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section [#Inline_Tagging].

==== Tables ====

A table like


 ||      *time*       ||    *velocity*     ||  *acceleration*   ||
 ||  0.0              ||  1.4186           ||  -5.01            ||
 ||  2.0              ||  1.376512         ||  11.919           ||
 ||  4.0              ||  1.1E+1           ||  14.717624        ||


is built up of pipe symbols and dashes:
{{{
  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
}}}
The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).

==== Blocks of Verbatim Computer Code ====

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" `!bc` keyword and an "end code" `!ec` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the `!bc` tag to specify a
certain `ptex2tex` environ (for instance, `!bc dat` corresponds to the
data file environment in `ptex2tex`; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The `!ec` tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block:
{{{
# regular expressions for inline tags:
inline_tag_begin = r'(?P<begin>(^|\s+))'
inline_tag_end = r'(?P<end>[.,?!;:)\s])'
INLINE_TAGS = {
    'emphasize':
    r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
    (inline_tag_begin, inline_tag_end),
    'verbatim':
    r'%s`(?P<subst>[^ ][^`]*)`%s' % \
    (inline_tag_begin, inline_tag_end),
    'bold':
    r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
    (inline_tag_begin, inline_tag_end),
}
}}}

Computer code can be copied directly from a file, if desired. The syntax
is then
{{{
 @@@CODE myfile.f
 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1
}}}
The first line implies that all lines in the file `myfile.f` are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the `@` sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
`subroutine test` (with as many blanks as desired between the two words)
and the line matching `C      END1` (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above):
{{{
C     a comment

      subroutine    test()
      integer i
      real*8 r
      r = 0
      do i = 1, i
         r = r + i
      end do
      return
C     END1

      program testme
      call test()
      return
}}}

Let us then copy just a piece in the middle as indicated by the `fromto:`
directive above:
{{{
      subroutine    test()
      integer i
      real*8 r
      r = 0
      do i = 1, i
         r = r + i
      end do
      return
}}}

(Remark for those familiar with `ptex2tex`: The from-to
syntax is slightly different from that used in `ptex2tex`. When
transforming Doconce to LaTeX, one first transforms the document to a
`.p.tex` file to be treated by `ptex2tex`. However, the `@@@CODE` line
is interpreted by Doconce and replaced by a *pro* or *cod* `ptex2tex`
environment.)

==== LaTeX Blocks of Mathematical Text ====

Blocks of mathematical text are like computer code blocks, but
the opening tag is `!bt` (begin TeX) and the closing tag is
`!et`. It is important that `!bt` and `!et` appear on the beginning of the
line and followed by a newline. 

Here is the result of a `!bt` - `!et` block:
{{{
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
}}}

This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

==== Macros (Newcommands) ====

Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
`newcommand_replace.tex` are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names `newcommands.tex` and
`newcommands_keep.tex` are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
`!bt` and `!et` in `newcommands_keep.tex` to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
`newcommands_replace.tex` and expanded by Doconce.  The definitions of
newcommands in the `newcommands*.tex` files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

*Example.* Suppose we have the following commands in 
`newcommand_replace.tex`:
{{{
\newcommand{\beqa}{\begin{eqnarray}}
\newcommand{\eeqa}{\end{eqnarray}}
\newcommand{\ep}{\thinspace . }
\newcommand{\uvec}{\vec u}
\newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
\newcommand{\Q}{\mathbfx{Q}}
}}}

and these in `newcommands_keep.tex`:
{{{
\newcommand{\x}{\mathbfx{x}}
\newcommand{\normalvec}{\mathbfx{n}}
\newcommand{\Ddt}[1]{\frac{D#1}{dt}}
}}}

The LaTeX block
{{{
\beqa
\x\cdot\normalvec &=& 0,\label{my:eq1}\\
\Ddt{\uvec} &=& \Q \ep\label{my:eq2}
\eeqa
}}}
will then be rendered to
{{{
\begin{eqnarray}
\x\cdot\normalvec &=& 0,\label{my:eq1}\\
\Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
\end{eqnarray}
}}}
in the current format.

==== Missing Features ====

  * Footnotes
  * Citations and bibliography
  * Index

If these things are important, one should go with reStructuredText instead.

==== Troubleshooting ====

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running `doconce2format`, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving
{{{
\code{...}
}}}
the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the Section *Blocks of Verbatim Computer Code* above.  Start the
`!bc` and `!ec` tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

*LaTeX Code Blocks Inside Lists Look Ugly.* Same solution as for computer code blocks as described in the
previous paragraph. Make sure the `!bt` and `!et` tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

*Inconsistent Headings in reStructuredText.* The `rst2*.py` and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for `===`,
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

*Strange Nested Lists in gwiki.* Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the `.gwiki` file directly.

*Lists in gwiki Look Ugly in the Sourc.* Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
`_doconce_debugging.log`, if the third argument to `doconce2format`
is `debug`. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.

==== Header and Footer ====

Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if `TITLE:` or
`#TITLE:` is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.

==== Basic Parsing Ideas ====

<wiki:comment> avoid list here since we have code in between (never a good idea) </wiki:comment>

The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression
{{{
(?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?
}}}

That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.

==== A Glimpse of How to Write a New Translator ====

This is the HTML-specific part of the
source code of the HTML translator:
{{{
FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
    # keep math as is:
    'math': None,  # indicates no substitution
    'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
    'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
    'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
    'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
    'section':       r'<h1>\g<subst></h1>',
    'subsection':    r'<h3>\g<subst></h3>',
    'subsubsection': r'<h5>\g<subst></h5>',
    'paragraph':     r'<b>\g<subst></b>. ',
    'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
    'date':          r'<center><h3>\g<subst></h3></center>',
    'author':        r'<center><h3>\g<subst></h3></center>',
    }

# how to replace code and LaTeX blocks by HTML (<pre>) environment:
def HTML_code(filestr):
    c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
    filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
    filestr = re.sub(r'!ec\n',
                     r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
    c = re.compile(r'^!bt\n', re.MULTILINE)
    filestr = c.sub(r'<pre>\n', filestr)
    filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
    return filestr
CODE['HTML'] = HTML_code

# how to typeset lists and their items in HTML:
LIST['HTML'] = {
    'itemize':
    {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
    'enumerate':
    {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
    'description':
    {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
    }

# how to type set description lists for function arguments, return
# values, and module/class variables:
ARGLIST['HTML'] = {
    'parameter': '<b>argument</b>',
    'keyword': '<b>keyword argument</b>',
    'return': '<b>return value(s)</b>',
    'instance variable': '<b>instance variable</b>',
    'class variable': '<b>class variable</b>',
    'module variable': '<b>module variable</b>',
    }

# document start:
INTRO['HTML'] = """
<html>
<body bgcolor="white">
"""
# document ending:
OUTRO['HTML'] = """
</body>
</html>
"""
}}}

==== Typesetting of Function Arguments, Return Values, and Variables ====

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that `argument`, `keyword argument`, `return`,
`instance variable`, `class variable`, and `module variable` are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string). 
{{{
    - argument x: x value (float),
      which must be a positive number.
    - keyword argument tolerance: tolerance (float) for stopping
      the iterations.
    - return: the root of the equation (float), if found, otherwise None.
    - instance variable eta: surface elevation (array).
    - class variable items: the total number of MyClass objects (int).
    - module variable debug: True: debug mode is on; False: no debugging 
      (bool variable).
}}}

The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.



    * *module variable* x:  
      x value (float),      which must be a positive number.
    * *module variable* tolerance:  
      tolerance (float) for stopping      the iterations.


************** File: manual.st *****************
TITLE: Doconce Description
By: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
DATE: August 27, 2010
What Is Doconce?
Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).
 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce

  - can convert to plain *untagged* text, 
    more desirable for computer programs and email, 
  - has less cluttered tagging of text,
  - has better support for copying in computer code from other files,
  - has stronger support for mathematical typesetting,
  - works better as a complete or partial source for large LaTeX 
    documents (reports and books).
Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section "The Doconce Documentation Strategy" to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.
Motivation: Problems with Documenting Software
*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

*Different Tagging for Different Formats.* A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

*Solution.* Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

*A Common Format.* There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need

 1. A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.
 2. Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 
 3. Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).
One answer to these points is the Doconce markup language, its associated
tools, and the "http://code.google.com/p/preprocess/":C-style preprocessor tool.
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section "What Is Doconce?", but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).
Dependencies
Doconce needs the Python packages
"http://docutils.sourceforge.net/":docutils,
"http://code.google.com/p/preprocess/":preprocess, and
"http://code.google.com/p/ptex2tex/":ptex2tex. The latter is only
needed for the LaTeX formats.
The Doconce Documentation Strategy
   - Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   - Use '#include' statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program 'doconce2format' before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   - Run the preprocessor 'preprocess' on the files to produce native
     files for pure computer code and for various other documents.
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


Demos
The current text is generated from a Doconce format stored in the::

        docs/manual/doconce.do.txt


file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file 'make.sh' in the same directory as the 'doconce.do.txt' file
(the current text) shows how to run 'doconce2format' on the
'doconce.do.txt' file to obtain documents in various formats.  Running
this demo ('make.sh') and studying the various generated files and
comparing them with the original 'doconce.do.txt' file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in::

        docs/tutorial/tutorial.do.txt


In the 'tutorial' directory there is also a 'make.sh' file producing a
lot of formats.
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
        n
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


Google Code Wiki
There are several different wiki dialects, but Doconce only support the
one used by "http://code.google.com/p/support/wiki/WikiSyntax":Google Code.
The transformation to this format, called 'gwiki' to explicitly mark
it as the Google Code dialect, is done by::

        Unix/DOS> doconce2format gwiki mydoc.do.txt


You can then open a new wiki page for your Google Code project, copy
the 'mydoc.gwiki' output file from 'doconce2format' and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.
The Doconce Markup Language
The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.
Lists
An unordered bullet list makes use of the '*' as bullet sign
and is indented as follows::

           * item 1
        
           * item 2
        
             * subitem 1, if there are more
               lines, each line must
               be intended as shown here
        
             * subitem 2,
               also spans two lines
        
           * item 3



This list gets typeset as

   - item 1
   - item 2
     - subitem 1, if there are more
       lines, each line must
       be intended as shown here
     - subitem 2,
       also spans two lines
   - item 3
In an ordered list, each item starts with an 'o' (as the first letter 
in "ordered")::

           o item 1
        
           o item 2
        
             * subitem 1
        
             * subitem 2
        
           o item 3



resulting in

  1. item 1
  2. item 2
     - subitem 1
     - subitem 2
  3. item 3
Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon::

           - keyword1: explanation of keyword1
        
           - keyword2: explanation
             of keyword2 (remember to indent properly
             if there are multiple lines)



The result becomes

   keyword1: --  
     explanation of keyword1
   keyword2: --  
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
Special Lines
The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax 'name at institution(s)'.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example::

        TITLE: On The Ultimate Markup Language: Doconce
        AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        DATE: November 9, 2006


Note the 'at' with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):
   - 7 underscores or equal signs for sections
   - 5 for subsections
   - 3 for subsubsections
   - 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)
Headings can be surrounded by blanks if desired.

Here are some examples::

        ======= Example on a Section Heading ======= 
        
        The running text goes here. 
        
              ===== Example on a Subsection Heading ===== 
        The running text goes here.
        
                  ===Example on a Subsubsection Heading===
        
        The running text goes here.
        
        __A Paragraph.__ The running text goes here.



The result for the present format looks like this:
Example on a Section Heading
The running text goes here. 
Example on a Subsection Heading
The running text goes here.
Example on a Subsubsection Heading
The running text goes here.

*A Paragraph.* The running text goes here.

Figures are recognized by the special line syntax::

        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption


The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename 'mypic.eps' is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say 'mypic.png' for HTML output).

FIGURE:[figs/dinoimpact.gif, width=400] It can't get worse than this.... 



Another type of special lines starts with '@@@CODE' and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.
Inline Tagging
Doconce supports tags for *emphasized phrases*, **boldface phrases**,
and 'verbatim text' (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as v = sin(x).

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in::

        *emphasized words*



Boldface font is recognized by an underscore instead of an asterisk::

        _several words in boldface_ followed by *ephasized text*.


The line above gets typeset as
**several words in boldface** followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes::

        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.


The typesetting result looks like this:
'call myroutine(a, b)' looks like a Fortran call
while 'void myfunc(double *a, double *b)' must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and 'ptex2tex') will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as::

        some URL like http://my.place.in.space/src<MyPlace>


which appears as some URL like "http://my.place.in.space/src":MyPlace.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::

        URL:"doconce.do.txt"


This constructions results in the link "doconce.do.txt":doconce.do.txt.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII::

        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.


That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system Ax=b, where A 
is an nxn matrix, and x and b
are vectors of length n."
Cross-Referencing
References and labels are supported. The syntax is simple::

        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.


This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by 'doconce2format'. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections "LaTeX Blocks of Mathematical Text" and "Macros (Newcommands)" are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section "Inline Tagging".
Tables
A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

is built up of pipe symbols and dashes::

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).
Blocks of Verbatim Computer Code
Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" '!bc' keyword and an "end code" '!ec' keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the '!bc' tag to specify a
certain 'ptex2tex' environ (for instance, '!bc dat' corresponds to the
data file environment in 'ptex2tex'; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The '!ec' tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block::

        # regular expressions for inline tags:
        inline_tag_begin = r'(?P<begin>(^|\s+))'
        inline_tag_end = r'(?P<end>[.,?!;:)\s])'
        INLINE_TAGS = {
            'emphasize':
            r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
            (inline_tag_begin, inline_tag_end),
            'verbatim':
            r'%s`(?P<subst>[^ ][^`]*)`%s' % \
            (inline_tag_begin, inline_tag_end),
            'bold':
            r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
            (inline_tag_begin, inline_tag_end),
        }



Computer code can be copied directly from a file, if desired. The syntax
is then::

         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1


The first line implies that all lines in the file 'myfile.f' are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the '@' sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
'subroutine test' (with as many blanks as desired between the two words)
and the line matching 'C      END1' (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above)::

        C     a comment
        
              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        C     END1
        
              program testme
              call test()
              return



Let us then copy just a piece in the middle as indicated by the 'fromto:'
directive above::

              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return



(Remark for those familiar with 'ptex2tex': The from-to
syntax is slightly different from that used in 'ptex2tex'. When
transforming Doconce to LaTeX, one first transforms the document to a
'.p.tex' file to be treated by 'ptex2tex'. However, the '@@@CODE' line
is interpreted by Doconce and replaced by a *pro* or *cod* 'ptex2tex'
environment.)
LaTeX Blocks of Mathematical Text
Blocks of mathematical text are like computer code blocks, but
the opening tag is '!bt' (begin TeX) and the closing tag is
'!et'. It is important that '!bt' and '!et' appear on the beginning of the
line and followed by a newline. 

Here is the result of a '!bt' - '!et' block::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}


This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).
Macros (Newcommands)
Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
'newcommand_replace.tex' are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names 'newcommands.tex' and
'newcommands_keep.tex' are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
'!bt' and '!et' in 'newcommands_keep.tex' to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
'newcommands_replace.tex' and expanded by Doconce.  The definitions of
newcommands in the 'newcommands*.tex' files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

*Example.* Suppose we have the following commands in 
'newcommand_replace.tex':
!bc  
        \newcommand{\beqa}{\begin{eqnarray}}
        \newcommand{\eeqa}{\end{eqnarray}}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}



and these in 'newcommands_keep.tex':
!bc  
        \newcommand{\x}{\mathbfx{x}}
        \newcommand{\normalvec}{\mathbfx{n}}
        \newcommand{\Ddt}[1]{\frac{D#1}{dt}}



The LaTeX block::

        \beqa
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\uvec} &=& \Q \ep\label{my:eq2}
        \eeqa


will then be rendered to::

        \begin{eqnarray}
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
        \end{eqnarray}

in the current format.
Missing Features
  - Footnotes
  - Citations and bibliography
  - Index
If these things are important, one should go with reStructuredText instead.
Troubleshooting
*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running 'doconce2format', the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::

        \code{...}


the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the Section *Blocks of Verbatim Computer Code* above.  Start the
'!bc' and '!ec' tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

*LaTeX Code Blocks Inside Lists Look Ugly.* Same solution as for computer code blocks as described in the
previous paragraph. Make sure the '!bt' and '!et' tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

*Inconsistent Headings in reStructuredText.* The 'rst2*.py' and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for '===',
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

*Strange Nested Lists in gwiki.* Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the '.gwiki' file directly.

*Lists in gwiki Look Ugly in the Sourc.* Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
'_doconce_debugging.log', if the third argument to 'doconce2format'
is 'debug'. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.
Header and Footer
Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if 'TITLE:' or
'#TITLE:' is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.
Basic Parsing Ideas
The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression::

        (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?



That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.
A Glimpse of How to Write a New Translator
This is the HTML-specific part of the
source code of the HTML translator::

        FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
        BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
        INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
            # keep math as is:
            'math': None,  # indicates no substitution
            'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
            'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
            'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
            'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
            'section':       r'<h1>\g<subst></h1>',
            'subsection':    r'<h3>\g<subst></h3>',
            'subsubsection': r'<h5>\g<subst></h5>',
            'paragraph':     r'<b>\g<subst></b>. ',
            'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
            'date':          r'<center><h3>\g<subst></h3></center>',
            'author':        r'<center><h3>\g<subst></h3></center>',
            }
        
        # how to replace code and LaTeX blocks by HTML (<pre>) environment:
        def HTML_code(filestr):
            c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
            filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
            filestr = re.sub(r'!ec\n',
                             r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
            c = re.compile(r'^!bt\n', re.MULTILINE)
            filestr = c.sub(r'<pre>\n', filestr)
            filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
            return filestr
        CODE['HTML'] = HTML_code
        
        # how to typeset lists and their items in HTML:
        LIST['HTML'] = {
            'itemize':
            {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
            'enumerate':
            {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
            'description':
            {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
            }
        
        # how to type set description lists for function arguments, return
        # values, and module/class variables:
        ARGLIST['HTML'] = {
            'parameter': '<b>argument</b>',
            'keyword': '<b>keyword argument</b>',
            'return': '<b>return value(s)</b>',
            'instance variable': '<b>instance variable</b>',
            'class variable': '<b>class variable</b>',
            'module variable': '<b>module variable</b>',
            }
        
        # document start:
        INTRO['HTML'] = """
        <html>
        <body bgcolor="white">
        """
        # document ending:
        OUTRO['HTML'] = """
        </body>
        </html>
        """


Typesetting of Function Arguments, Return Values, and Variables
As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that 'argument', 'keyword argument', 'return',
'instance variable', 'class variable', and 'module variable' are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string)::

            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).



The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.

    module variable x: --  
      x value (float),
      which must be a positive number.
    module variable tolerance: --  
      tolerance (float) for stopping
      the iterations.
************** File: manual.epytext *****************
TITLE: Doconce Description
BY: Hans Petter Langtangen, Simula Research Laboratory and University of Oslo
DATE: August 27, 2010
What Is Doconce?
================


Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).
 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce

  - can convert to plain I{untagged} text, 
    more desirable for computer programs and email, 
  - has less cluttered tagging of text,
  - has better support for copying in computer code from other files,
  - has stronger support for mathematical typesetting,
  - works better as a complete or partial source for large LaTeX 
    documents (reports and books).
Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section "The Doconce Documentation Strategy" to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.


Motivation: Problems with Documenting Software
==============================================

I{Duplicated Information.} It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

I{Different Tagging for Different Formats.} A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

I{Solution.} Accurate information is crucial and can only be
maintained in a I{single physical} place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

I{A Common Format.} There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, I{and} plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need

 1. A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.
 2. Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 
 3. Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).
One answer to these points is the Doconce markup language, its associated
tools, and the U{C-style preprocessor tool<http://code.google.com/p/preprocess/>}.
Then we can I{write once, include anywhere}!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section "What Is Doconce?", but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).


Dependencies
------------

Doconce needs the Python packages
U{docutils<http://docutils.sourceforge.net/>},
U{preprocess<http://code.google.com/p/preprocess/>}, and
U{ptex2tex<http://code.google.com/p/ptex2tex/>}. The latter is only
needed for the LaTeX formats.


The Doconce Documentation Strategy
----------------------------------


   - Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   - Use C{#include} statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program C{doconce2format} before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   - Run the preprocessor C{preprocess} on the files to produce native
     files for pure computer code and for various other documents.
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






Demos
-----

The current text is generated from a Doconce format stored in the::

        docs/manual/doconce.do.txt


file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file C{make.sh} in the same directory as the C{doconce.do.txt} file
(the current text) shows how to run C{doconce2format} on the
C{doconce.do.txt} file to obtain documents in various formats.  Running
this demo (C{make.sh}) and studying the various generated files and
comparing them with the original C{doconce.do.txt} file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in::

        docs/tutorial/tutorial.do.txt


In the C{tutorial} directory there is also a C{make.sh} file producing a
lot of formats.



From Doconce to Other Formats
=============================

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
----

Making an HTML version of a Doconce file C{mydoc.do.txt}
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file C{mydoc.html} can be loaded into any web browser for viewing.

LaTeX
-----

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
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
----------------

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
------

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
        n
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



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by U{Google Code<http://code.google.com/p/support/wiki/WikiSyntax>}.
The transformation to this format, called C{gwiki} to explicitly mark
it as the Google Code dialect, is done by::

        Unix/DOS> doconce2format gwiki mydoc.do.txt


You can then open a new wiki page for your Google Code project, copy
the C{mydoc.gwiki} output file from C{doconce2format} and paste the
file contents into the wiki page. Press B{Preview} or B{Save Page} to
see the formatted result.




The Doconce Markup Language
===========================

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

Lists
-----

An unordered bullet list makes use of the C{*} as bullet sign
and is indented as follows::

           * item 1
        
           * item 2
        
             * subitem 1, if there are more
               lines, each line must
               be intended as shown here
        
             * subitem 2,
               also spans two lines
        
           * item 3



This list gets typeset as

   - item 1
   - item 2
     - subitem 1, if there are more
       lines, each line must
       be intended as shown here
     - subitem 2,
       also spans two lines
   - item 3
In an ordered list, each item starts with an C{o} (as the first letter 
in "ordered")::

           o item 1
        
           o item 2
        
             * subitem 1
        
             * subitem 2
        
           o item 3



resulting in

  1. item 1
  2. item 2
     - subitem 1
     - subitem 2
  3. item 3
Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon::

           - keyword1: explanation of keyword1
        
           - keyword2: explanation
             of keyword2 (remember to indent properly
             if there are multiple lines)



The result becomes

   - keyword1: 
     explanation of keyword1
   - keyword2: 
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
Special Lines
-------------

The Doconce markup language has a concept called I{special lines}.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax C{name at institution(s)}.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example::

        TITLE: On The Ultimate Markup Language: Doconce
        AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        DATE: November 9, 2006


Note the C{at} with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):
   - 7 underscores or equal signs for sections
   - 5 for subsections
   - 3 for subsubsections
   - 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)
Headings can be surrounded by blanks if desired.

Here are some examples::

        ======= Example on a Section Heading ======= 
        
        The running text goes here. 
        
              ===== Example on a Subsection Heading ===== 
        The running text goes here.
        
                  ===Example on a Subsubsection Heading===
        
        The running text goes here.
        
        __A Paragraph.__ The running text goes here.



The result for the present format looks like this:

Example on a Section Heading
============================

The running text goes here. 

Example on a Subsection Heading
-------------------------------
The running text goes here.

Example on a Subsubsection Heading
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The running text goes here.

I{A Paragraph.} The running text goes here.

Figures are recognized by the special line syntax::

        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption


The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename C{mypic.eps} is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say C{mypic.png} for HTML output).

FIGURE:[figs/dinoimpact.gif, width=400] It can't get worse than this.... 



Another type of special lines starts with C{@@@CODE} and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.


Inline Tagging
--------------


Doconce supports tags for I{emphasized phrases}, B{boldface phrases},
and C{verbatim text} (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as M{v = sin(x)}.

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in::

        *emphasized words*



Boldface font is recognized by an underscore instead of an asterisk::

        _several words in boldface_ followed by *ephasized text*.


The line above gets typeset as
B{several words in boldface} followed by I{ephasized text}.

Verbatim text, typically used for short inline code,
is typeset between backquotes::

        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.


The typesetting result looks like this:
C{call myroutine(a, b)} looks like a Fortran call
while C{void myfunc(double *a, double *b)} must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and C{ptex2tex}) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as::

        some URL like http://my.place.in.space/src<MyPlace>


which appears as some URL like U{MyPlace<http://my.place.in.space/src>}.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::

        URL:"doconce.do.txt"


This constructions results in the link U{doconce.do.txt<doconce.do.txt>}.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII::

        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.


That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system M{Ax=b}, where M{A} 
is an M{nxn} matrix, and M{x} and M{b}
are vectors of length M{n}."

Cross-Referencing
-----------------

References and labels are supported. The syntax is simple::

        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.


This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by C{doconce2format}. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections "LaTeX Blocks of Mathematical Text" and "Macros (Newcommands)" are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section "Inline Tagging".


Tables
------

A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

is built up of pipe symbols and dashes::

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" C{!bc} keyword and an "end code" C{!ec} keyword. Both
keywords must be on a single line and I{start at the beginning of the
line}.  There may be an argument after the C{!bc} tag to specify a
certain C{ptex2tex} environ (for instance, C{!bc dat} corresponds to the
data file environment in C{ptex2tex}; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The C{!ec} tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block::

        # regular expressions for inline tags:
        inline_tag_begin = r'(?P<begin>(^|\s+))'
        inline_tag_end = r'(?P<end>[.,?!;:)\s])'
        INLINE_TAGS = {
            'emphasize':
            r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
            (inline_tag_begin, inline_tag_end),
            'verbatim':
            r'%s`(?P<subst>[^ ][^`]*)`%s' % \
            (inline_tag_begin, inline_tag_end),
            'bold':
            r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
            (inline_tag_begin, inline_tag_end),
        }



Computer code can be copied directly from a file, if desired. The syntax
is then::

         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1


The first line implies that all lines in the file C{myfile.f} are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the C{@} sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
C{subroutine test} (with as many blanks as desired between the two words)
and the line matching C{C      END1} (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above)::

        C     a comment
        
              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        C     END1
        
              program testme
              call test()
              return



Let us then copy just a piece in the middle as indicated by the C{fromto:}
directive above::

              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return



(Remark for those familiar with C{ptex2tex}: The from-to
syntax is slightly different from that used in C{ptex2tex}. When
transforming Doconce to LaTeX, one first transforms the document to a
C{.p.tex} file to be treated by C{ptex2tex}. However, the C{@@@CODE} line
is interpreted by Doconce and replaced by a I{pro} or I{cod} C{ptex2tex}
environment.)


LaTeX Blocks of Mathematical Text
---------------------------------


Blocks of mathematical text are like computer code blocks, but
the opening tag is C{!bt} (begin TeX) and the closing tag is
C{!et}. It is important that C{!bt} and C{!et} appear on the beginning of the
line and followed by a newline. 

Here is the result of a C{!bt} - C{!et} block::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.



This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

Macros (Newcommands)
--------------------


Doconce supports a type of macros via a LaTeX-style I{newcommand}
construction.  The newcommands defined in a file with name
C{newcommand_replace.tex} are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names C{newcommands.tex} and
C{newcommands_keep.tex} are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by
C{!bt} and C{!et} in C{newcommands_keep.tex} to keep them unchanged, at
least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
C{newcommands_replace.tex} and expanded by Doconce.  The definitions of
newcommands in the C{newcommands*.tex} files I{must} appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

I{Example.} Suppose we have the following commands in 
C{newcommand_replace.tex}:
!bc  
            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.




and these in C{newcommands_keep.tex}:
!bc  
            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.




The LaTeX block::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.



will then be rendered to::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


in the current format.

Missing Features
----------------

  - Footnotes
  - Citations and bibliography
  - Index
If these things are important, one should go with reStructuredText instead.


Troubleshooting
---------------

I{Disclaimer.} First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running C{doconce2format}, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

I{The LaTeX File Does Not Compile.} If the problem is undefined control sequence involving::

        \code{...}


the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

I{Verbatim Code Blocks Inside Lists Look Ugly.} Read the Section I{Blocks of Verbatim Computer Code} above.  Start the
C{!bc} and C{!ec} tags in column 1 of the file, and be careful with
indenting the surrounding plain text of the list item correctly. If
you cannot resolve the problem this way, get rid of the list and use
paragraph headings instead. In fact, that is what is recommended:
avoid verbatim code blocks inside lists (it makes life easier).

I{LaTeX Code Blocks Inside Lists Look Ugly.} Same solution as for computer code blocks as described in the
previous paragraph. Make sure the C{!bt} and C{!et} tags are in column 1
and that the rest of the non-LaTeX surrounding text is correctly indented.
Using paragraphs instead of list items is a good idea also here.

I{Inconsistent Headings in reStructuredText.} The C{rst2*.py} and Sphinx converters abort if the headers of sections
are not consistent, i.e., a subsection must come under a section,
and a subsubsection must come under a subsection (you cannot have
a subsubsection directly under a section). Search for C{===},
count the number of equality signs (or underscores if you use that)
and make sure they decrease by two every time a lower level is encountered.

I{Strange Nested Lists in gwiki.} Doconce cannot handle nested lists correctly in the gwiki format.
Use nonnested lists or edit the C{.gwiki} file directly.

I{Lists in gwiki Look Ugly in the Sourc.} Because the Google Code wiki format requires all text of a list item to
be on one line, Doconce simply concatenates lines in that format,
and because of the indentation in the original Doconce text, the gwiki
output looks somewhat ugly. The good thing is that this gwiki source
is seldom to be looked at - it is the Doconce source that one edits
further.

I{Debugging.} Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
C{_doconce_debugging.log}, if the third argument to C{doconce2format}
is C{debug}. The logfile is inteded for the developers of Doconce, but
may still give some idea of what is wrong.  The section "Basic Parsing
Ideas" explains how the Doconce text is transformed into a specific
format, and you need to know these steps to make use of the logfile.


Header and Footer
-----------------

Some formats use a header and footer in the document. LaTeX and
HTML are two examples of such formats. When the document is to be
included in another document (which is often the case with
Doconce-based documents), the header and footer are not wanted, while
these are needed (at least in a LaTeX context) if the document is
stand-alone. We have introduce the convention that if C{TITLE:} or
C{#TITLE:} is found at the beginning of the line (i.e., the document
has, or has an intention have, a title), the header and footer
are included, otherwise not.


Basic Parsing Ideas
-------------------


The (parts of) files with computer code to be directly included in
the document are first copied into verbatim blocks.

All verbatim and TeX blocks are removed and stored elsewhere
to ensure that no formatting rules are not applied to these blocks.

The text is examined line by line for typesetting of lists, as well as
handling of blank lines and comment lines.
List parsing needs some awareness of the context.
Each line is interpreted by a regular expression::

        (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?



That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.


A Glimpse of How to Write a New Translator
------------------------------------------

This is the HTML-specific part of the
source code of the HTML translator:

Note that for Epytext, code or LaTeX blocks that contain a newline
character (for example as in C{\nabla} in LaTeX), will lead to an
effect of the newline and generate error messages. Our remedy is
to remove such code blocks and provide a notice about the removal.
Eight here we only displacy a smaller snippet that Epytext can
treat properly::

        INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
            # keep math as is:
            'math': None,  # indicates no substitution
            'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
            'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
            'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
            'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
            }




Typesetting of Function Arguments, Return Values, and Variables
---------------------------------------------------------------

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and I{placed at the end of
the doc string}. Note that C{argument}, C{keyword argument}, C{return},
C{instance variable}, C{class variable}, and C{module variable} are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using I{fields} in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string)::

            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).



The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.

    @var x: 
      x value (float),
      which must be a positive number.
    @var tolerance: 
      tolerance (float) for stopping
      the iterations.
************** File: manual.txt *****************
TITLE: Doconce Description
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: August 27, 2010




What Is Doconce?
================


Doconce is two things:

 1. Doconce is a working strategy for documenting software in a single
    place and avoiding duplication of information. The slogan is:
    "Write once, include anywhere". This requires that what you write
    can be transformed to many different formats for a variety of
    documents (manuals, tutorials, books, doc strings, source code
    documentation, etc.).
 2. Doconce is a simple and minimally tagged markup language that can
    be used for the above purpose. That is, the Doconce format look
    like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
The first point may be of interest even if you adopt a different
markup language than Doconce, e.g., reStructuredText or Sphinx.

So why not just use reStructuredText or Sphinx? Because Doconce

  * can convert to plain *untagged* text, 
    more desirable for computer programs and email, 
  * has less cluttered tagging of text,
  * has better support for copying in computer code from other files,
  * has stronger support for mathematical typesetting,
  * works better as a complete or partial source for large LaTeX 
    documents (reports and books).
Anyway, after having written an initial document in Doconce, you may
convert to reStructuredText or Sphinx and work with that version for
the future.

You can jump to the section "The Doconce Documentation Strategy" to see a recipe for
how to perform the two steps above, but first some more motivation for
the problem which Doconce tries to solve is presented.


Motivation: Problems with Documenting Software
==============================================

*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
the motivation for developing the Doconce concept and tool.

*Different Tagging for Different Formats.* A problem with doc
strings (in Python) is that they benefit greatly from some tagging,
Epytext or reStructuredText, when transformed to HTML or PDF
manuals. However, such tagging looks annoying in Pydoc, which just
shows the pure doc string. For Pydoc we should have more minimal (or
no) tagging (students and newbies are in particular annoyed by any
unfamiliar tagging of ASCII text). On the contrary, manuals or
tutorials in HTML and LaTeX need quite much tagging.

*Solution.* Accurate information is crucial and can only be
maintained in a *single physical* place (file), which must be
converted (filtered) to suitable formats and included in various
documents (HTML/LaTeX manuals/tutorials, Pydoc/Epydoc/HappyDoc
reference manuals).

*A Common Format.* There is no existing format and associated
conversion tools that allow a "singleton" documentation file to be
filtered to LaTeX, HTML, XML, PDF, Epydoc, HappyDoc, Pydoc, *and* plain
untagged text. As we are involved with mathematical software, the
LaTeX manuals should have nicely typeset mathematics, while Pydoc,
Epydoc, and HappyDoc must show LaTeX math in verbatim mode.
Unfortunately, Epytext is annoyed by even very simple LaTeX math (also
in verbatim environments). To summarize, we need

 1. A minimally tagged markup language with full support for 
    for mathematics and verbatim computer code.
 2. Filters for producing highly tagged formats (LaTeX, HTML, XML),
    medium tagged formats (reStructuredText, Epytext), and plain
    text with completely invivisble tagging. 
 3. Tools for inserting appropriately filtered versions of a "singleton"
    documentation file in other documents (doc strings, manuals, tutorials).
One answer to these points is the Doconce markup language, its associated
tools, and the C-style preprocessor tool (http://code.google.com/p/preprocess/).
Then we can *write once, include anywhere*!
And what we write is close to plain ASCII text.

But isn't reStructuredText exactly the format that fulfills the needs
above? Yes and no. Yes, because reStructuredText can be filtered to a
lot of the mentioned formats. No, because of the reasons listed
in the section "What Is Doconce?", but perhaps the strongest feature
of Doconce is that it integrates well with LaTeX: Large LaTeX documents (book)
can be made of many smaller Doconce units, typically describing examples
and computer codes, glued with mathematical pieces written entirely
in LaTeX and with heavy cross-referencing of equations, as is usual
in mathematical texts. All the Doconce units can then be available
also as stand-alone examples in wikis or Sphinx pages and thereby used
in other occasions (including software documentation and teaching material).
This is a promising way of composing future books of units that can
be reused in many contexts and formats, currently being explored by
the Doconce maintainer.

A final warning may be necessary: The Doconce format is a minimalistic
formatting language. It is ideal when you start a new project when you
are uncertain about which format to choose. At some later stage, when
you need quite some sophisticated formatting and layout, you can
perform the final filtering of Doconce into something more appropriate
for future demands. The convenient thing is that the format decision
can be posponed (maybe forever - which is the common experience of the
Doconce developer).


Dependencies
------------

Doconce needs the Python packages
docutils (http://docutils.sourceforge.net/),
preprocess (http://code.google.com/p/preprocess/), and
ptex2tex (http://code.google.com/p/ptex2tex/). The latter is only
needed for the LaTeX formats.


The Doconce Documentation Strategy
----------------------------------


   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   * Use #include statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program doconce2format before being
     included. In a Python context, this means plain text for computer
     source code (and Pydoc); Epytext for Epydoc API documentation, or
     the Sphinx dialect of reStructuredText for Sphinx API
     documentation; LaTeX for LaTeX manuals; and possibly
     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   * Run the preprocessor preprocess on the files to produce native
     files for pure computer code and for various other documents.
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






Demos
-----

The current text is generated from a Doconce format stored in the::

        docs/manual/doconce.do.txt


file in the Doconce source code tree. You should view that text and
compare with a formatted version (in HTML, LaTeX, plain text, etc.).

The file make.sh in the same directory as the doconce.do.txt file
(the current text) shows how to run doconce2format on the
doconce.do.txt file to obtain documents in various formats.  Running
this demo (make.sh) and studying the various generated files and
comparing them with the original doconce.do.txt file, gives a quick
introduction to how Doconce is used in a real case.

Another demo is found in::

        docs/tutorial/tutorial.do.txt


In the tutorial directory there is also a make.sh file producing a
lot of formats.



From Doconce to Other Formats
=============================

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
----

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::

        Unix/DOS> doconce2format HTML mydoc.do.txt


The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
-----

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
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::

        Unix/DOS> doconce2format plain mydoc.do.txt  # results in mydoc.txt



reStructuredText
----------------

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
------

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
        n
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



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by Google Code (http://code.google.com/p/support/wiki/WikiSyntax).
The transformation to this format, called gwiki to explicitly mark
it as the Google Code dialect, is done by::

        Unix/DOS> doconce2format gwiki mydoc.do.txt


You can then open a new wiki page for your Google Code project, copy
the mydoc.gwiki output file from doconce2format and paste the
file contents into the wiki page. Press _Preview_ or _Save Page_ to
see the formatted result.




The Doconce Markup Language
===========================

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

Lists
-----

An unordered bullet list makes use of the * as bullet sign
and is indented as follows::

           * item 1
        
           * item 2
        
             * subitem 1, if there are more
               lines, each line must
               be intended as shown here
        
             * subitem 2,
               also spans two lines
        
           * item 3



This list gets typeset as

   * item 1
   * item 2
     * subitem 1, if there are more
       lines, each line must
       be intended as shown here
     * subitem 2,
       also spans two lines
   * item 3
In an ordered list, each item starts with an o (as the first letter 
in "ordered")::

           o item 1
        
           o item 2
        
             * subitem 1
        
             * subitem 2
        
           o item 3



resulting in

  1. item 1
  2. item 2
     * subitem 1
     * subitem 2
  3. item 3
Ordered lists cannot have an ordered sublist, i.e., the ordering 
applies to the outer list only.

In a description list, each item is recognized by a dash followed
by a keyword followed by a colon::

           - keyword1: explanation of keyword1
        
           - keyword2: explanation
             of keyword2 (remember to indent properly
             if there are multiple lines)



The result becomes

   keyword1: 
     explanation of keyword1
   keyword2: 
     explanation
     of keyword2 (remember to indent properly
     if there are multiple lines)
Special Lines
-------------

The Doconce markup language has a concept called *special lines*.
Such lines starts with a markup at the very beginning of the
line and are used to mark document title, authors, date,
sections, subsections, paragraphs., figures, etc.

Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax name at institution(s).
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example::

        TITLE: On The Ultimate Markup Language: Doconce
        AUTHOR: H. P. Langtangen at Simula Research Laboratory and Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        DATE: November 9, 2006


Note the at with surrounding blanks for the AUTHOR: specification - without
these blanks the author will not be correctly interpreted.

Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):
   * 7 underscores or equal signs for sections
   * 5 for subsections
   * 3 for subsubsections
   * 2 underscrores (only! - it looks best) for paragraphs 
     (paragraph heading will be inlined)
Headings can be surrounded by blanks if desired.

Here are some examples::

        ======= Example on a Section Heading ======= 
        
        The running text goes here. 
        
              ===== Example on a Subsection Heading ===== 
        The running text goes here.
        
                  ===Example on a Subsubsection Heading===
        
        The running text goes here.
        
        __A Paragraph.__ The running text goes here.



The result for the present format looks like this:

Example on a Section Heading
============================

The running text goes here. 

Example on a Subsection Heading
-------------------------------
The running text goes here.

Example on a Subsubsection Heading
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The running text goes here.

*A Paragraph.* The running text goes here.

Figures are recognized by the special line syntax::

        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption


The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

The filename extension may not be compatible with the chosen output format.
For example, a filename mypic.eps is fine for LaTeX output but not for
HTML. In such cases, the Doconce translator will convert the file to
a suitable format (say mypic.png for HTML output).

FIGURE:[figs/dinoimpact.gif, width=400] It can't get worse than this.... 



Another type of special lines starts with @@@CODE and enables copying
of computer code from a file directly into a verbatim environment, see 
the section "Blocks of Verbatim Computer Code" below.


Inline Tagging
--------------


Doconce supports tags for *emphasized phrases*, _boldface phrases_,
and verbatim text (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as v = sin(x).

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in::

        *emphasized words*



Boldface font is recognized by an underscore instead of an asterisk::

        _several words in boldface_ followed by *ephasized text*.


The line above gets typeset as
_several words in boldface_ followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes::

        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.


The typesetting result looks like this:
call myroutine(a, b) looks like a Fortran call
while void myfunc(double *a, double *b) must be C.

It is recommended to have inline verbatim text on the same line in
the Doconce file, because some formats (LaTeX and ptex2tex) will have
problems with inline verbatim text that is split over two lines.

Watch out for mixing backquotes and asterisk (i.e., verbatim and
emphasized code): the Doconce interpreter is not very smart so inline
computer code can soon lead to problems in the final format. Go back to the
Doconce source and modify it so the format to which you want to go
becomes correct (sometimes a trial and error process - sticking to
very simple formatting usually avoids such problems).

Web addresses with links are typeset as::

        some URL like http://my.place.in.space/src<MyPlace>


which appears as some URL like MyPlace (http://my.place.in.space/src).
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::

        URL:"doconce.do.txt"


This constructions results in the link doconce.do.txt.


Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII::

        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.


That is, we provide two alternative expressions, both enclosed in
dollar signs and separated by a pipe symbol, the expression to the
left is used in LaTeX, while the expression to the right is used for
all other formats.  The above text is typeset as "Here is an example
on a linear system Ax=b, where A 
is an nxn matrix, and x and b
are vectors of length n."

Cross-Referencing
-----------------

References and labels are supported. The syntax is simple::

        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.


This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by doconce2format. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:impact}
(the label appears in the figure caption in the source code of this document).
Additional references to the sections "LaTeX Blocks of Mathematical Text" and "Macros (Newcommands)" are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section "Inline Tagging".


Tables
------

A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

is built up of pipe symbols and dashes::

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" !bc keyword and an "end code" !ec keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the !bc tag to specify a
certain ptex2tex environ (for instance::

data file environment in ptex2tex; if there is no argument, one
assumes the ccq environment, which is plain verbatim in LaTeX).  The
argument has effect only for the LaTeX format.  .  The !ec tag must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block::

        # regular expressions for inline tags:
        inline_tag_begin = r'(?P<begin>(^|\s+))'
        inline_tag_end = r'(?P<end>[.,?!;:)\s])'
        INLINE_TAGS = {
            'emphasize':
            r'%s\*(?P<subst>[^ `][^*`]*)\*%s' % \
            (inline_tag_begin, inline_tag_end),
            'verbatim':
            r'%s`(?P<subst>[^ ][^`]*)`%s' % \
            (inline_tag_begin, inline_tag_end),
            'bold':
            r'%s_(?P<subst>[^ `][^_`]*)_%s' % \
            (inline_tag_begin, inline_tag_end),
        }



Computer code can be copied directly from a file, if desired. The syntax
is then::

         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1


The first line implies that all lines in the file myfile.f are copied
into a verbatim block. The second line has a `fromto:' directive, which
implies copying code between two lines in the code. Two regular
expressions, separated by the @ sign, define the "from" and "to" lines.
The "from" line is included in the verbatim block, while the "to" line
is not. In the example above, we copy code from the line matching
subroutine test (with as many blanks as desired between the two words)
and the line matching C      END1 (C followed by 5 blanks and then
the text END1). The final line with the "to" text is not
included in the verbatim block. 

Let us copy a whole file (the first line above)::

        C     a comment
        
              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        C     END1
        
              program testme
              call test()
              return



Let us then copy just a piece in the middle as indicated by the fromto:
directive above::

              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return



(Remark for those familiar with ptex2tex: The from-to
syntax is slightly different from that used in ptex2tex. When
transforming Doconce to LaTeX, one first transforms the document to a
.p.tex file to be treated by ptex2tex. However, the @@@CODE line
is interpreted by Doconce and replaced by a *pro* or *cod* ptex2tex
environment.)


LaTeX Blocks of Mathematical Text
---------------------------------


Blocks of mathematical text are like computer code blocks, but
the opening tag is !bt (begin TeX) and the closing tag is
!et. It is important that !bt and !et appear on the beginning of the
line and followed by a newline. 

Here is the result of a !bt - !et block::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}


This text looks ugly in all Doconce supported formats, except from
LaTeX and Sphinx.  If HTML is desired, the best is to filter the Doconce text
first to LaTeX and then use the widely available tex4ht tool to
convert the dvi file to HTML, or one could just link a PDF file (made
from LaTeX) directly from HTML. For other textual formats, it is best
to avoid blocks of mathematics and instead use inline mathematics
where it is possible to write expressions both in native LaTeX format
(so it looks good in LaTeX) and in a pure text format (so it looks
okay in other formats).

Macros (Newcommands)
--------------------


Doconce supports a type of macros via a LaTeX-style *newcommand*
construction.  The newcommands defined in a file with name
newcommand_replace.tex are expanded when Doconce is filtered to
other formats, except for LaTeX (since LaTeX performs the expansion
itself).  Newcommands in files with names newcommands.tex and
newcommands_keep.tex are kept unaltered when Doconce text is
filtered to other formats, except for the Sphinx format. Since Sphinx
understands LaTeX math, but not newcommands if the Sphinx output is
HTML, it makes most sense to expand all newcommands.  Normally, a user
will put all newcommands that appear in math blocks surrounded by::

least if they contribute to make the raw LaTeX math text easier to
read in the formats that cannot render LaTeX.  Newcommands used
elsewhere throughout the text will usually be placed in
newcommands_replace.tex and expanded by Doconce.  The definitions of
newcommands in the newcommands*.tex files *must* appear on a single
line (multi-line newcommands are too hard to parse with regular
expressions).

*Example.* Suppose we have the following commands in 
newcommand_replace.tex::

        \newcommand{\beqa}{\begin{eqnarray}}
        \newcommand{\eeqa}{\end{eqnarray}}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}



and these in newcommands_keep.tex::

        \newcommand{\x}{\mathbfx{x}}
        \newcommand{\normalvec}{\mathbfx{n}}
        \newcommand{\Ddt}[1]{\frac{D#1}{dt}}



The LaTeX block::

        \beqa
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\uvec} &=& \Q \ep\label{my:eq2}
        \eeqa


will then be rendered to::

        \begin{eqnarray}
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
        \end{eqnarray}

in the current format.

Missing Features
----------------

  * Footnotes
  * Citations and bibliography
  * Index
If these things are important, one should go with reStructuredText instead.


Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running doconce2format, the reason for the error is most likely a
syntax problem in your Doconce source file. You have to track down
this syntax problem yourself.

However, the problem may well be a bug in Doconce. The Doconce
software is incomplete, and many special cases of syntax are not yet
discovered to give problems. Such special cases are also seldom easy to
fix, so one important way of "debugging" Doconce is simply to change
the formatting so that Doconce treats it properly. Doconce is very much
based on regular expressions, which are known to be non-trivial to
debug years after they are created. The main developer of Doconce has
hardly any time to work on debugging the code, but the software works
well for his diverse applications of it.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::

        \code{...}


the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the Section *Blocks of Verbatim Computer Code* above.  Start the::

        indenting the surrounding plain text of the list item correctly. If
        you cannot resolve the problem this way, get rid of the list and use
        paragraph headings instead. In fact, that is what is recommended:
        avoid verbatim code blocks inside lists (it makes life easier).
        
        *LaTeX Code Blocks Inside Lists Look Ugly.* Same solution as for computer code blocks as described in the
        previous paragraph. Make sure the !bt and !et tags are in column 1
        and that the rest of the non-LaTeX surrounding text is correctly indented.
        Using paragraphs instead of list items is a good idea also here.
        
        *Inconsistent Headings in reStructuredText.* The rst2*.py and Sphinx converters abort if the headers of sections
        are not consistent, i.e., a subsection must come under a section,
        and a subsubsection must come under a subsection (you cannot have
        a subsubsection directly under a section). Search for ===,
        count the number of equality signs (or underscores if you use that)
        and make sure they decrease by two every time a lower level is encountered.
        
        *Strange Nested Lists in gwiki.* Doconce cannot handle nested lists correctly in the gwiki format.
        Use nonnested lists or edit the .gwiki file directly.
        
        *Lists in gwiki Look Ugly in the Sourc.* Because the Google Code wiki format requires all text of a list item to
        be on one line, Doconce simply concatenates lines in that format,
        and because of the indentation in the original Doconce text, the gwiki
        output looks somewhat ugly. The good thing is that this gwiki source
        is seldom to be looked at - it is the Doconce source that one edits
        further.
        
        *Debugging.* Given a problem, extract a small portion of text surrounding the
        problematic area and debug that small piece of text. Doconce does a
        series of transformations of the text. The effect of each of these
        transformation steps are dumped to a logfile, named
        _doconce_debugging.log, if the third argument to doconce2format
        is debug. The logfile is inteded for the developers of Doconce, but
        may still give some idea of what is wrong.  The section "Basic Parsing
        Ideas" explains how the Doconce text is transformed into a specific
        format, and you need to know these steps to make use of the logfile.
        
        
        Header and Footer
        -----------------
        
        Some formats use a header and footer in the document. LaTeX and
        HTML are two examples of such formats. When the document is to be
        included in another document (which is often the case with
        Doconce-based documents), the header and footer are not wanted, while
        these are needed (at least in a LaTeX context) if the document is
        stand-alone. We have introduce the convention that if TITLE: or
        #TITLE: is found at the beginning of the line (i.e., the document
        has, or has an intention have, a title), the header and footer
        are included, otherwise not.
        
        
        Basic Parsing Ideas
        -------------------
        
        
        The (parts of) files with computer code to be directly included in
        the document are first copied into verbatim blocks.
        
        All verbatim and TeX blocks are removed and stored elsewhere
        to ensure that no formatting rules are not applied to these blocks.
        
        The text is examined line by line for typesetting of lists, as well as
        handling of blank lines and comment lines.
        List parsing needs some awareness of the context.
        Each line is interpreted by a regular expression::

        (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<text>.*)\s?



That is, a possible indent (which we measure), an optional list
item identifier, optional space, optional words ended by colon,
and optional text. All lines are of this form. However, some
ordinary (non-list) lines may contain a colon, and then the keyword
and text group must be added to get the line contents. Otherwise,
the text group will be the line.

When lists are typeset, the text is examined for sections, paragraphs,
title, author, date, plus all the inline tags for emphasized, boldface,
and verbatim text. Plain subsitutions based on regular expressions
are used for this purpose.

The final step is to insert the code and TeX blocks again (these should
be untouched and are therefore left out of the previous parsing).

It is important to keep the Doconce format and parsing simple.  When a
new format is needed and this format is not obtained by a simple edit
of the definition of existing formats, it might be better to convert
the document to reStructuredText and then to XML, parse the XML and
write out in the new format.  When the Doconce format is not
sufficient to getting the layout you want, it is suggested to filter
the document to another, more complex format, say reStructuredText or
LaTeX, and work further on the document in this format.


A Glimpse of How to Write a New Translator
------------------------------------------

This is the HTML-specific part of the
source code of the HTML translator::

        FILENAME_EXTENSION['HTML'] = '.html'  # output file extension
        BLANKLINE['HTML'] = '<p>\n'           # blank input line => new paragraph
        INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HTML tags
            # keep math as is:
            'math': None,  # indicates no substitution
            'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',
            'bold':          r'\g<begin><b>\g<subst></b>\g<end>',
            'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',
            'URL':           r'\g<begin><a href="\g<url>">\g<link></a>',
            'section':       r'<h1>\g<subst></h1>',
            'subsection':    r'<h3>\g<subst></h3>',
            'subsubsection': r'<h5>\g<subst></h5>',
            'paragraph':     r'<b>\g<subst></b>. ',
            'title':         r'<title>\g<subst></title>\n<center><h1>\g<subst></h1></center>',
            'date':          r'<center><h3>\g<subst></h3></center>',
            'author':        r'<center><h3>\g<subst></h3></center>',
            }
        
        # how to replace code and LaTeX blocks by HTML (<pre>) environment:
        def HTML_code(filestr):
            c = re.compile(r'^!bc(.*?)\n', re.MULTILINE)
            filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre>\n', filestr)
            filestr = re.sub(r'!ec\n',
                             r'</pre>\n<! -- END VERBATIM BLOCK -->\n', filestr)
            c = re.compile(r'^!bt\n', re.MULTILINE)
            filestr = c.sub(r'<pre>\n', filestr)
            filestr = re.sub(r'!et\n', r'</pre>\n', filestr)
            return filestr
        CODE['HTML'] = HTML_code
        
        # how to typeset lists and their items in HTML:
        LIST['HTML'] = {
            'itemize':
            {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
            'enumerate':
            {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
            'description':
            {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\n\n'},
            }
        
        # how to type set description lists for function arguments, return
        # values, and module/class variables:
        ARGLIST['HTML'] = {
            'parameter': '<b>argument</b>',
            'keyword': '<b>keyword argument</b>',
            'return': '<b>return value(s)</b>',
            'instance variable': '<b>instance variable</b>',
            'class variable': '<b>class variable</b>',
            'module variable': '<b>module variable</b>',
            }
        
        # document start:
        INTRO['HTML'] = """
        <html>
        <body bgcolor="white">
        """
        # document ending:
        OUTRO['HTML'] = """
        </body>
        </html>
        """




Typesetting of Function Arguments, Return Values, and Variables
---------------------------------------------------------------

As part of comments (or doc strings) in computer code one often wishes
to explain what a function takes of arguments and what the return
values are. Similarly, it is desired to document class, instance, and
module variables.  Such arguments/variables can be typeset as
description lists of the form listed below and *placed at the end of
the doc string*. Note that argument, keyword argument, return,
instance variable, class variable, and module variable are the
only legal keywords (descriptions) for the description list in this
context.  If the output format is Epytext (Epydoc), such lists of
arguments and variables are nicely formatted using *fields* in Epytext
(this formatting requires that the list of variables appear at the end
of the doc string)::

            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).



The result depends on the output format. Epytext has special constructs
for such lists, while in the other formats we simply typeset the variable
in verbatim and keep the keywords as is.

    module variable x: 
      x value (float),
      which must be a positive number.
    module variable tolerance: 
      tolerance (float) for stopping
      the iterations.