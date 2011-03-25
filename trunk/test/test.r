
************** File: testdoc.do.txt *****************
<%doc>
This is a test on Doconce.
The Mako preprocessor is used.
</%doc>

TITLE: A Test Document
AUTHOR: Hans Petter Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Department of Informatics, University of Oslo
AUTHOR: Kaare Dump at Segfault Inc, Cyberspace
AUTHOR: A. Dummy Author

The format of this document is
% if FORMAT == 'HTML':
plain, homemade HTML.
  % elif FORMAT == 'LaTeX':
plan, homemade LaTeX.
  %else:
${FORMAT}
% endif


======= Section 1 =======
label{sec1}

Just a little bit of text
and then a list:

  * item1
  * item2
  * item3 which continues
    on the next line to test that feature
  * and a sublist
    * with indented subitem1
    * and a subitem2
  * and perhaps an ordered sublist
    o first item
    o second item,
      continuing on a new line

===== Subsection 1 =====

More text, with a reference back to Section ref{sec1} and further
to Section ref{subsubsec:ex}. idx{`somefunc` function}

===== Subsection 2 =====
label{subsec:ex}

What about a figure?
idx{figures are nice}

FIGURE:[../docs/manual/figs/dinoimpact.gif, width=200] It can't get worse than this.... label{fig:impact}

===== Table Demo =====
label{subsec:table}

Let us take this table from the manual:
idx{some `class X` which is convenient}

% if FORMAT == "LaTeX":
\begin{table}
\caption{
Table of velocity and acceleration.
label{mytab}
}
% endif

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
% if FORMAT == "LaTeX":
\end{table}
% endif

The Doconce source code reads
!bc cod
  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
!ec

===== URLs ======
label{subsubsec:ex}

Here are some nice URLs, e.g., hpl's home page "hpl":"http://folk.uio.no/hpl",
or the URL if desired, "URL": "http://folk.uio.no/hpl".
Here is a plain file link "URL": "testdoc.do.txt", or "url":"testdoc.do.txt",
or URL: "testdoc.do.txt" or url : "testdoc.do.txt". Can test spaces
with the link with word too: "hpl": "http://folk.uio.no/hpl" or
"hpl" : "http://folk.uio.no/hpl". The old syntax must also be
tested: http://folk.uio.no/hpl<hpl's homepage>. Now also `file:///`
works: "link to a file":"file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html"
is fine to have.

# Comments should be inserted outside paragraphs (because of reST):
# note that when there is no http: or file:, it can be a file link
# if the link name is URL, url, "URL", or "url".

% if FORMAT == "LaTeX":

===== Some LaTeX Constructs =====

Let's check abbr. of some common kind, e.g. the well-known i.e. 7-9
as an example. Moreover, Dr. Tang and Prof. Monsen, or maybe also prof. Ting,
will go to the Dept. of Science to test how Mr. Hansen is doing together
with Ms. Larsen. A sentence containing "refines lines" could easily
fool a regex substitution with only i.e. since the dot matches anything.
Also, look at Fig. 4 to see how the data compares with Tab. ref{mytab}.
% endif

Here is an equation without label:
!bt
\[ a = b + c \]
!et
or with number and label, as in (ref{my:eq1}):
!bt
\begin{equation}
{\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
\end{equation}
!et
We can refer to this equation by (ref{my:eq1}).
Or a system of equations with labels,
!bt
\begin{align}
a &= q + 4 + 5+ 6\label{eq1} \\
b &= \nabla^2 u + \nabla^4 x \label{eq2}
\end{align}
!et
We can refer to (ref{eq1})-(ref{eq2}).
Or align without eq numbers:
!bt
\begin{align*}
a &= q + 4 + 5+ 6 \\
b &= \nabla^2 u + \nabla^4 x
\end{align*}
!et

Or with multline?
!bt
\begin{multline}
a = b = q + \\
  f + \nabla\cdot\nabla u 
label{multiline:eq1}
\end{multline}
!et
Maybe split is better:
!bt
\begin{equation}
label{split:envir:eq}
\begin{split}
a = b = q &+ \\
  & f + \nabla\cdot\nabla u
\end{split}
\end{equation}
!et
And we can refer to the last equation by (ref{split:envir:eq}).

What about gather?
!bt
\begin{gather}
a = b \\
c = d + 7 + 9
\end{gather}
!et

And what about alignat?
!bt
\begin{alignat}{2}
a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\
b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
\end{alignat}
!et
Let us refer to (ref{eq1})-(ref{eq2}) again, and to the
alignat variant (ref{eq1a})-(ref{eq2a}), and to (ref{my:eq1}).

Here is eqnarray:
!bt
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
!et



************** File: testdoc.html *****************
<?xml version="1.0" encoding="utf-8" ?>
<!-- 
Automatically generated HTML file from Doconce source 
(http://code.google.com/p/doconce/) 
-->

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META name="generator" content="Doconce: http://code.google.com/p/doconce/" />
</HEAD>

<BODY BGCOLOR="white">
    
<P>

<P>
<TITLE>A Test Document</TITLE>
<CENTER><H1>A Test Document</H1></CENTER>
<CENTER>
<B>Hans Petter Langtangen</B> [1, 2]
</CENTER>

<CENTER>
<B>Kaare Dump</B> [3]
</CENTER>

<CENTER>
<B>A. Dummy Author</B> 
</CENTER>

<P>
<CENTER>[1] <B>Center for Biomedical Computing, Simula Research Laboratory</B></CENTER>
<CENTER>[2] <B>Department of Informatics, University of Oslo</B></CENTER>
<CENTER>[3] <B>Segfault Inc, Cyberspace</B></CENTER>



<P>
The format of this document is
plain, homemade HTML.

<P>

<P>
<H1>Section 1 <A NAME="sec1"></A></H1>
<P>

<P>
Just a little bit of text
and then a list:

<P>

<UL>
  <LI> item1
  <LI> item2
  <LI> item3 which continues
    on the next line to test that feature
  <LI> and a sublist

<UL>
    <LI> with indented subitem1
    <LI> and a subitem2
</UL>

  <LI> and perhaps an ordered sublist

<OL>
   <LI> first item
   <LI> second item,
      continuing on a new line
</OL>

</UL>
<H3>Subsection 1</H3>
<P>
More text, with a reference back to the section <A HREF="#sec1">Section 1</a> and further
to the section <A HREF="#subsubsec:ex">URLs</a>. 
<H3>Subsection 2 <A NAME="subsec:ex"></A></H3>
<P>

<P>
What about a figure?

<P>
<IMG SRC="../docs/manual/figs/dinoimpact.gif" ALIGN="bottom"  width=200> It can't get worse than this.... <A NAME="fig:impact"></A>

<P>
<H3>Table Demo <A NAME="subsec:table"></A></H3>
<P>

<P>
Let us take this table from the manual:

<P>

<P>
<TABLE border="1">
<TR><TD><B>    time    </B></TD> <TD><B>  velocity  </B></TD> <TD><B>acceleration</B></TD> </TR>
<TR><TD>   0.0             </TD> <TD>   1.4186          </TD> <TD>   -5.01           </TD> </TR>
<TR><TD>   2.0             </TD> <TD>   1.376512        </TD> <TD>   11.919          </TD> </TR>
<TR><TD>   4.0             </TD> <TD>   1.1E+1          </TD> <TD>   14.717624       </TD> </TR>
</TABLE>
<P>
The Doconce source code reads
<!-- BEGIN VERBATIM BLOCK   cod-->
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

<P>
<H3>URLs <A NAME="subsubsec:ex"></A></H3>
<P>

<P>
Here are some nice URLs, e.g., hpl's home page <A HREF="http://folk.uio.no/hpl">hpl</A>,
or the URL if desired, <A HREF="http://folk.uio.no/hpl"><TT>http://folk.uio.no/hpl</TT></A>.
Here is a plain file link <A HREF="testdoc.do.txt"><TT>testdoc.do.txt</TT></A>, or <A HREF="testdoc.do.txt"><TT>testdoc.do.txt</TT></A>,
or <A HREF="testdoc.do.txt"><TT>testdoc.do.txt</TT></A> or <A HREF="testdoc.do.txt"><TT>testdoc.do.txt</TT></A>. Can test spaces
with the link with word too: <A HREF="http://folk.uio.no/hpl">hpl</A> or
<A HREF="http://folk.uio.no/hpl">hpl</A>. The old syntax must also be
tested: <A HREF="http://folk.uio.no/hpl">hpl's homepage</A>. Now also <TT>file:///</TT>
works: <A HREF="file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html">link to a file</A>
is fine to have.

<P>
<!-- Comments should be inserted outside paragraphs (because of reST): -->
<!-- note that when there is no http: or file:, it can be a file link -->
<!-- if the link name is URL, url, "URL", or "url". -->

<P>

<P>
Here is an equation without label:
<BLOCKQUOTE><PRE>
\[ a = b + c \]
</PRE></BLOCKQUOTE>
or with number and label, as in (<A HREF="#my:eq1">my:eq1</a>):
<BLOCKQUOTE><PRE>
\begin{equation}
{\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
\end{equation}
</PRE></BLOCKQUOTE>
We can refer to this equation by (<A HREF="#my:eq1">my:eq1</a>).
Or a system of equations with labels,
<BLOCKQUOTE><PRE>
\begin{align}
a &= q + 4 + 5+ 6\label{eq1} \\ 
b &= \nabla^2 u + \nabla^4 x \label{eq2}
\end{align}
</PRE></BLOCKQUOTE>
We can refer to (<A HREF="#eq1">eq1</a>)-(<A HREF="#eq2">eq2</a>).
Or align without eq numbers:
<BLOCKQUOTE><PRE>
\begin{align*}
a &= q + 4 + 5+ 6 \\ 
b &= \nabla^2 u + \nabla^4 x
\end{align*}
</PRE></BLOCKQUOTE>

<P>
Or with multline?
<BLOCKQUOTE><PRE>
\begin{multline}
a = b = q + \\ 
  f + \nabla\cdot\nabla u 
label{multiline:eq1}
\end{multline}
</PRE></BLOCKQUOTE>
Maybe split is better:
<BLOCKQUOTE><PRE>
\begin{equation}
label{split:envir:eq}
\begin{split}
a = b = q &+ \\ 
  & f + \nabla\cdot\nabla u
\end{split}
\end{equation}
</PRE></BLOCKQUOTE>
And we can refer to the last equation by (<A HREF="#split:envir:eq">split:envir:eq</a>).

<P>
What about gather?
<BLOCKQUOTE><PRE>
\begin{gather}
a = b \\ 
c = d + 7 + 9
\end{gather}
</PRE></BLOCKQUOTE>

<P>
And what about alignat?
<BLOCKQUOTE><PRE>
\begin{alignat}{2}
a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\ 
b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
\end{alignat}
</PRE></BLOCKQUOTE>
Let us refer to (<A HREF="#eq1">eq1</a>)-(<A HREF="#eq2">eq2</a>) again, and to the
alignat variant (<A HREF="#eq1a">eq1a</a>)-(<A HREF="#eq2a">eq2a</a>), and to (<A HREF="#my:eq1">my:eq1</a>).

<P>
Here is eqnarray:
<BLOCKQUOTE><PRE>
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,label{myeq1}\\ 
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
</PRE></BLOCKQUOTE>

<P>

</BODY>
</HTML>
    
************** File: testdoc.p.tex *****************
%%
%% Automatically generated LaTeX file from Doconce source 
%% http://code.google.com/p/doconce/
%%
\documentclass{article}
\usepackage{hyperref,relsize,epsfig,makeidx,amsmath}
\usepackage[latin1]{inputenc}
\usepackage{ptex2tex}
% #ifdef MINTED
\usepackage{minted}  % requires latex -shell-escape (for Minted_* ptex2tex envirs)
% #endif

% #ifdef HELVETICA
% Set helvetica as the default font family:
\RequirePackage{helvet}
\renewcommand\familydefault{phv}
% #endif

\newcommand{\inlinecomment}[2]{  ({\bf #1}: \emph{#2})  }
%\newcommand{\inlinecomment}[2]{}  % turn off inline comments

\makeindex

\begin{document}





% #ifdef TRAD_LATEX_HEADING

\title{A Test Document}

% #else

\begin{center}
{\LARGE\bf A Test Document}
\end{center}

% #endif

% #ifdef TRAD_LATEX_HEADING

\author{Hans Petter Langtangen\footnote{Center for Biomedical Computing, Simula Research Laboratory and Department of Informatics, University of Oslo}
\and Kaare Dump\footnote{Segfault Inc, Cyberspace}
\and A. Dummy Author}

% #else

\begin{center}
{\bf Hans Petter Langtangen${}^{1, 2}$} \\ [0mm]
\end{center}

\begin{center}
{\bf Kaare Dump${}^{3}$} \\ [0mm]
\end{center}

\begin{center}
{\bf A. Dummy Author${}^{}$} \\ [0mm]
\end{center}

\begin{center}
{\small ${}^1$Center for Biomedical Computing, Simula Research Laboratory} \\ [-1.0mm]
\end{center}

\begin{center}
{\small ${}^2$Department of Informatics, University of Oslo} \\ [-1.0mm]
\end{center}

\begin{center}
{\small ${}^3$Segfault Inc, Cyberspace} \\ [-1.0mm]
\end{center}

%\vspace{4mm}

% #endif

The format of this document is
plan, homemade {\LaTeX}.


\section{Section 1}

\label{sec1}

Just a little bit of text
and then a list:

\begin{itemize}
  \item item1

  \item item2

  \item item3 which continues
    on the next line to test that feature

  \item and a sublist
\begin{itemize}

    \item with indented subitem1

    \item and a subitem2

\end{itemize}

\noindent
  \item and perhaps an ordered sublist
\begin{enumerate}

   \item first item

   \item second item,
      continuing on a new line
\end{enumerate}

\noindent
\end{itemize}

\noindent

\subsection{Subsection 1}

More text, with a reference back to Section~\ref{sec1} and further
to Section~\ref{subsubsec:ex}. \index{somefunc@{\rm\texttt{somefunc}} function}

\subsection{Subsection 2}

\label{subsec:ex}

What about a figure?
\index{figures are nice}


\begin{figure}
  \centerline{\includegraphics[width=0.9\linewidth]{../docs/manual/figs/dinoimpact.ps}}
  \caption{
  It can't get worse than this.... \label{fig:impact}
  % \label{fig:dinoimpact}  % (autogenerated label, not used anymore)
  }
\end{figure}

\subsection{Table Demo}

\label{subsec:table}

Let us take this table from the manual:
\index{some class X@some {\rm\texttt{class X}} which is convenient}

\begin{table}
\caption{
Table of velocity and acceleration.
\label{mytab}
}


\begin{quote}\begin{tabular}{ccc}
\hline
\multicolumn{1}{c}{time} & \multicolumn{1}{c}{velocity} & \multicolumn{1}{c}{acceleration} \\
\hline
0.0          & 1.4186       & -5.01        \\
2.0          & 1.376512     & 11.919       \\
4.0          & 1.1E+1       & 14.717624    \\
\hline
\end{tabular}\end{quote}

\noindent

The Doconce source code reads
\bcod
  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
\ecod

\subsection{URLs}

\label{subsubsec:ex}

Here are some nice URLs, e.g., hpl's home page \href{http://folk.uio.no/hpl}{hpl},
or the URL if desired, \href{http://folk.uio.no/hpl}{http://folk.uio.no/hpl}.
Here is a plain file link \href{testdoc.do.txt}{testdoc.do.txt}, or \href{testdoc.do.txt}{testdoc.do.txt},
or \href{testdoc.do.txt}{testdoc.do.txt} or \href{testdoc.do.txt}{testdoc.do.txt}. Can test spaces
with the link with word too: \href{http://folk.uio.no/hpl}{hpl} or
\href{http://folk.uio.no/hpl}{hpl}. The old syntax must also be
tested: \href{http://folk.uio.no/hpl}{hpl's homepage}. Now also \code{file:///}
works: \href{file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html}{link to a file}
is fine to have.

% Comments should be inserted outside paragraphs (because of reST):
% note that when there is no http: or file:, it can be a file link
% if the link name is URL, url, "URL", or "url".

\subsection{Some {\LaTeX} Constructs}

Let's check abbr.~of some common kind, e.g.~the well-known i.e.~7-9
as an example. Moreover, Dr.~Tang and Prof.~Monsen, or maybe also prof.~Ting,
will go to the Dept.~of Science to test how Mr.~Hansen is doing together
with Ms.~Larsen. A sentence containing "refines lines" could easily
fool a regex substitution with only i.e.~since the dot matches anything.
Also, look at Fig.~4 to see how the data compares with Tab.~\ref{mytab}.

Here is an equation without label:
\[ a = b + c \]
or with number and label, as in (\ref{my:eq1}):
\begin{equation}
{\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
\end{equation}
We can refer to this equation by (\ref{my:eq1}).
Or a system of equations with labels,
\begin{align}
a &= q + 4 + 5+ 6\label{eq1} \\ 
b &= \nabla^2 u + \nabla^4 x \label{eq2}
\end{align}
We can refer to (\ref{eq1})-(\ref{eq2}).
Or align without eq numbers:
\begin{align*}
a &= q + 4 + 5+ 6 \\ 
b &= \nabla^2 u + \nabla^4 x
\end{align*}

Or with multline?
\begin{multline}
a = b = q + \\ 
  f + \nabla\cdot\nabla u 
\label{multiline:eq1}
\end{multline}
Maybe split is better:
\begin{equation}
\label{split:envir:eq}
\begin{split}
a = b = q &+ \\ 
  & f + \nabla\cdot\nabla u
\end{split}
\end{equation}
And we can refer to the last equation by (\ref{split:envir:eq}).

What about gather?
\begin{gather}
a = b \\ 
c = d + 7 + 9
\end{gather}

And what about alignat?
\begin{alignat}{2}
a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\ 
b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
\end{alignat}
Let us refer to (\ref{eq1})-(\ref{eq2}) again, and to the
alignat variant (\ref{eq1a})-(\ref{eq2a}), and to (\ref{my:eq1}).

Here is eqnarray:
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\ 
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}


\printindex

\end{document}

************** File: testdoc.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)



A Test Document
===============

:Author: Hans Petter Langtangen, Kaare Dump, A. Dummy Author


The format of this document is
rst


.. _sec1:

Section 1
=========

Just a little bit of text
and then a list:

  * item1

  * item2

  * item3 which continues
    on the next line to test that feature

  * and a sublist

    * with indented subitem1

    * and a subitem2


  * and perhaps an ordered sublist

   1. first item

   2. second item,
      continuing on a new line


Subsection 1
------------

More text, with a reference back to the section `Section 1`_ and further
to the section `URLs`_. 
.. _subsec:ex:

Subsection 2
------------

What about a figure?


.. _fig:impact:

.. figure:: ../docs/manual/figs/dinoimpact.gif
   :width: 200

   It can't get worse than this...  (fig:impact)


.. _subsec:table:

Table Demo
----------

Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


.. _subsubsec:ex:

URLs
----

Here are some nice URLs, e.g., hpl's home page `hpl <http://folk.uio.no/hpl>`_,
or the URL if desired, `<http://folk.uio.no/hpl>`_.
Here is a plain file link `<testdoc.do.txt>`_, or `<testdoc.do.txt>`_,
or `<testdoc.do.txt>`_ or `<testdoc.do.txt>`_. Can test spaces
with the link with word too: `hpl <http://folk.uio.no/hpl>`_ or
`hpl <http://folk.uio.no/hpl>`_. The old syntax must also be
tested: `hpl's homepage <http://folk.uio.no/hpl>`_. Now also ``file:///``
works: `link to a file <file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html>`_
is fine to have.

.. Comments should be inserted outside paragraphs (because of reST):
.. note that when there is no http: or file:, it can be a file link
.. if the link name is URL, url, "URL", or "url".


Here is an equation without label::

        \[ a = b + c \]

or with number and label, as in Equation (my:eq1)::

        \begin{equation}
        {\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
        \end{equation}

We can refer to this equation by Equation (my:eq1).
Or a system of equations with labels::

        \begin{align}
        a &= q + 4 + 5+ 6\label{eq1} \\ 
        b &= \nabla^2 u + \nabla^4 x \label{eq2}
        \end{align}

We can refer to Equations (eq1)-(eq2).
Or align without eq numbers::

        \begin{align*}
        a &= q + 4 + 5+ 6 \\ 
        b &= \nabla^2 u + \nabla^4 x
        \end{align*}


Or with multline::

        \begin{multline}
        a = b = q + \\ 
          f + \nabla\cdot\nabla u 
        label{multiline:eq1}
        \end{multline}

Maybe split is better::

        \begin{equation}
        label{split:envir:eq}
        \begin{split}
        a = b = q &+ \\ 
          & f + \nabla\cdot\nabla u
        \end{split}
        \end{equation}

And we can refer to the last equation by Equation (split:envir:eq).

What about gather::

        \begin{gather}
        a = b \\ 
        c = d + 7 + 9
        \end{gather}


And what about alignat::

        \begin{alignat}{2}
        a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\ 
        b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
        \end{alignat}

Let us refer to Equations (eq1)-(eq2) again, and to the
alignat variant Equations (eq1a)-(eq2a), and to Equation (my:eq1).

Here is eqnarray::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,label{myeq1}\\ 
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}






************** File: testdoc.sphinx.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)



A Test Document
===============

:Author: Hans Petter Langtangen, Kaare Dump, A. Dummy Author


The format of this document is
sphinx


.. _sec1:

Section 1
=========

Just a little bit of text
and then a list:

  * item1

  * item2

  * item3 which continues
    on the next line to test that feature

  * and a sublist

    * with indented subitem1

    * and a subitem2


  * and perhaps an ordered sublist

   1. first item

   2. second item,
      continuing on a new line


Subsection 1
------------

More text, with a reference back to the section :ref:`sec1` and further
to the section :ref:`subsubsec:ex`. 
.. index:: somefunc function


.. _subsec:ex:

Subsection 2
------------

What about a figure?

.. index:: figures are nice



.. _fig:impact:

.. figure:: ../docs/manual/figs/dinoimpact.gif
   :width: 200

   It can't get worse than this...  


.. _subsec:table:

Table Demo
----------

Let us take this table from the manual:

.. index:: some class X which is convenient



============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

The Doconce source code reads

.. code-block:: python

          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


.. _subsubsec:ex:

URLs
----

Here are some nice URLs, e.g., hpl's home page `hpl <http://folk.uio.no/hpl>`_,
or the URL if desired, `<http://folk.uio.no/hpl>`_.
Here is a plain file link `<testdoc.do.txt>`_, or `<testdoc.do.txt>`_,
or `<testdoc.do.txt>`_ or `<testdoc.do.txt>`_. Can test spaces
with the link with word too: `hpl <http://folk.uio.no/hpl>`_ or
`hpl <http://folk.uio.no/hpl>`_. The old syntax must also be
tested: `hpl's homepage <http://folk.uio.no/hpl>`_. Now also ``file:///``
works: `link to a file <file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html>`_
is fine to have.

.. Comments should be inserted outside paragraphs (because of reST):
.. note that when there is no http: or file:, it can be a file link
.. if the link name is URL, url, "URL", or "url".


Here is an equation without label:

.. math::
         a = b + c 

or with number and label, as in :eq:`my:eq1`:

.. math::
   :label: my:eq1
        
        {\partial u\over\partial t} = \nabla^2 u
        

We can refer to this equation by :eq:`my:eq1`.
Or a system of equations with labels,

.. math::
        
        a &= q + 4 + 5+ 6 \\ 
        b &= \nabla^2 u + \nabla^4 x 
        

We can refer to (:ref:`eq1`)-(:ref:`eq2`).
Or align without eq numbers:

.. math::
        
        a &= q + 4 + 5+ 6 \\ 
        b &= \nabla^2 u + \nabla^4 x
        


Or with multline?

.. math::
   :label: multiline:eq1
        
        a = b = q + \\ 
          f + \nabla\cdot\nabla u 
        
        

Maybe split is better:

.. math::
   :label: split:envir:eq
        
        
        
        a = b = q &+ \\ 
          & f + \nabla\cdot\nabla u
        
        

And we can refer to the last equation by :eq:`split:envir:eq`.

What about gather?

.. math::
        
        a = b \\ 
        c = d + 7 + 9
        


And what about alignat?

.. math::
        \begin{alignat}{2}
        a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0 \\ 
        b &= \nabla^2 u + \nabla^4 x & x\in\Omega 
        \end{alignat}

Let us refer to (:ref:`eq1`)-(:ref:`eq2`) again, and to the
alignat variant (:ref:`eq1a`)-(:ref:`eq2a`), and to :eq:`my:eq1`.

Here is eqnarray:

.. math::
   :label: myeq1
        
        {\partial u\over\partial t}  &=  \nabla^2 u + f,\\ 
        {\partial v\over\partial t}  &=  \nabla\cdot(q(u)\nabla v) + g
        






************** File: testdoc.gwiki *****************


#summary A Test Document
<wiki:toc max_depth="2" />
By *Hans Petter Langtangen*, *Kaare Dump*, and *A. Dummy Author*


The format of this document is
gwiki



== Section 1 ==

Just a little bit of text
and then a list:


  * item1
  * item2
  * item3 which continues    on the next line to test that feature
  * and a sublist

    * with indented subitem1
    * and a subitem2


  * and perhaps an ordered sublist

   # first item
   # second item,      continuing on a new line

==== Subsection 1 ====

More text, with a reference back to the section [#Section_1] and further
to the section [#URLs]. 

==== Subsection 2 ====

What about a figure?



---------------------------------------------------------------

Figure: It can't get worse than this.... (fig:impact)

(the URL of the image file ../docs/manual/figs/dinoimpact.gif must be inserted here)

<wiki:comment> 
Put the figure file ../docs/manual/figs/dinoimpact.gif on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------

==== Table Demo ====

Let us take this table from the manual:



 ||      *time*       ||    *velocity*     ||  *acceleration*   ||
 ||  0.0              ||  1.4186           ||  -5.01            ||
 ||  2.0              ||  1.376512         ||  11.919           ||
 ||  4.0              ||  1.1E+1           ||  14.717624        ||


The Doconce source code reads
{{{
  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
}}}

==== URLs ====

Here are some nice URLs, e.g., hpl's home page [http://folk.uio.no/hpl hpl],
or the URL if desired, http://folk.uio.no/hpl.
Here is a plain file link testdoc.do.txt, or testdoc.do.txt,
or testdoc.do.txt or testdoc.do.txt. Can test spaces
with the link with word too: [http://folk.uio.no/hpl hpl] or
[http://folk.uio.no/hpl hpl]. The old syntax must also be
tested: [http://folk.uio.no/hpl hpl's homepage]. Now also `file:///`
works: [file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html link to a file]
is fine to have.

<wiki:comment> Comments should be inserted outside paragraphs (because of reST): </wiki:comment>
<wiki:comment> note that when there is no http: or file:, it can be a file link </wiki:comment>
<wiki:comment> if the link name is URL, url, "URL", or "url". </wiki:comment>


Here is an equation without label:
{{{
\[ a = b + c \]
}}}
or with number and label, as in Equation (my:eq1):
{{{
\begin{equation}
{\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
\end{equation}
}}}
We can refer to this equation by Equation (my:eq1).
Or a system of equations with labels,
{{{
\begin{align}
a &= q + 4 + 5+ 6\label{eq1} \\ 
b &= \nabla^2 u + \nabla^4 x \label{eq2}
\end{align}
}}}
We can refer to Equations (eq1)-(eq2).
Or align without eq numbers:
{{{
\begin{align*}
a &= q + 4 + 5+ 6 \\ 
b &= \nabla^2 u + \nabla^4 x
\end{align*}
}}}

Or with multline?
{{{
\begin{multline}
a = b = q + \\ 
  f + \nabla\cdot\nabla u 
label{multiline:eq1}
\end{multline}
}}}
Maybe split is better:
{{{
\begin{equation}
label{split:envir:eq}
\begin{split}
a = b = q &+ \\ 
  & f + \nabla\cdot\nabla u
\end{split}
\end{equation}
}}}
And we can refer to the last equation by Equation (split:envir:eq).

What about gather?
{{{
\begin{gather}
a = b \\ 
c = d + 7 + 9
\end{gather}
}}}

And what about alignat?
{{{
\begin{alignat}{2}
a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\ 
b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
\end{alignat}
}}}
Let us refer to Equations (eq1)-(eq2) again, and to the
alignat variant Equations (eq1a)-(eq2a), and to Equation (my:eq1).

Here is eqnarray:
{{{
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f,label{myeq1}\\ 
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
}}}


************** File: testdoc.st *****************


TITLE: A Test Document
BY: Hans Petter Langtangen (Center for Biomedical Computing, Simula Research Laboratory, and Department of Informatics, University of Oslo); Kaare Dump (Segfault Inc, Cyberspace); A. Dummy Author
The format of this document is
st
Section 1
Just a little bit of text
and then a list:

  - item1
  - item2
  - item3 which continues
    on the next line to test that feature
  - and a sublist
    - with indented subitem1
    - and a subitem2

  - and perhaps an ordered sublist
   1. first item
   2. second item,
      continuing on a new line
Subsection 1
More text, with a reference back to the section "Section 1" and further
to the section "URLs". 
Subsection 2
What about a figure?

FIGURE:[../docs/manual/figs/dinoimpact.gif, width=200] It can't get worse than this.... {fig:impact}
Table Demo
Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|

URLs
Here are some nice URLs, e.g., hpl's home page "http://folk.uio.no/hpl":hpl,
or the URL if desired, "http://folk.uio.no/hpl":http://folk.uio.no/hpl.
Here is a plain file link "testdoc.do.txt":testdoc.do.txt, or "testdoc.do.txt":testdoc.do.txt,
or "testdoc.do.txt":testdoc.do.txt or "testdoc.do.txt":testdoc.do.txt. Can test spaces
with the link with word too: "http://folk.uio.no/hpl":hpl or
"http://folk.uio.no/hpl":hpl. The old syntax must also be
tested: "http://folk.uio.no/hpl":hpl's homepage. Now also 'file:///'
works: "file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html":link to a file
is fine to have.



Here is an equation without label::

        \[ a = b + c \]

or with number and label, as in Equation (my:eq1)::

        \begin{equation}
        {\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
        \end{equation}

We can refer to this equation by Equation (my:eq1).
Or a system of equations with labels::

        \begin{align}
        a &= q + 4 + 5+ 6\label{eq1} \\ 
        b &= \nabla^2 u + \nabla^4 x \label{eq2}
        \end{align}

We can refer to Equations (eq1)-(eq2).
Or align without eq numbers::

        \begin{align*}
        a &= q + 4 + 5+ 6 \\ 
        b &= \nabla^2 u + \nabla^4 x
        \end{align*}


Or with multline::

        \begin{multline}
        a = b = q + \\ 
          f + \nabla\cdot\nabla u 
        label{multiline:eq1}
        \end{multline}

Maybe split is better::

        \begin{equation}
        label{split:envir:eq}
        \begin{split}
        a = b = q &+ \\ 
          & f + \nabla\cdot\nabla u
        \end{split}
        \end{equation}

And we can refer to the last equation by Equation (split:envir:eq).

What about gather::

        \begin{gather}
        a = b \\ 
        c = d + 7 + 9
        \end{gather}


And what about alignat::

        \begin{alignat}{2}
        a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\ 
        b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
        \end{alignat}

Let us refer to Equations (eq1)-(eq2) again, and to the
alignat variant Equations (eq1a)-(eq2a), and to Equation (my:eq1).

Here is eqnarray::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,label{myeq1}\\ 
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}









************** File: testdoc.epytext *****************


TITLE: A Test Document
BY: Hans Petter Langtangen (Center for Biomedical Computing, Simula Research Laboratory, and Department of Informatics, University of Oslo); Kaare Dump (Segfault Inc, Cyberspace); A. Dummy Author
The format of this document is
epytext


Section 1
=========

Just a little bit of text
and then a list:

  - item1
  - item2
  - item3 which continues
    on the next line to test that feature
  - and a sublist
    - with indented subitem1
    - and a subitem2

  - and perhaps an ordered sublist
   1. first item
   2. second item,
      continuing on a new line


Subsection 1
------------

More text, with a reference back to the section "Section 1" and further
to the section "URLs". 
Subsection 2
------------

What about a figure?

FIGURE:[../docs/manual/figs/dinoimpact.gif, width=200] It can't get worse than this.... {fig:impact}

Table Demo
----------

Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


URLs
----

Here are some nice URLs, e.g., hpl's home page U{hpl<http://folk.uio.no/hpl>},
or the URL if desired, U{http://folk.uio.no/hpl<http://folk.uio.no/hpl>}.
Here is a plain file link U{testdoc.do.txt<testdoc.do.txt>}, or U{testdoc.do.txt<testdoc.do.txt>},
or U{testdoc.do.txt<testdoc.do.txt>} or U{testdoc.do.txt<testdoc.do.txt>}. Can test spaces
with the link with word too: U{hpl<http://folk.uio.no/hpl>} or
U{hpl<http://folk.uio.no/hpl>}. The old syntax must also be
tested: U{hpl's homepage<http://folk.uio.no/hpl>}. Now also C{file:///}
works: U{link to a file<file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html>}
is fine to have.



Here is an equation without label::

        \[ a = b + c \]

or with number and label, as in Equation (my:eq1)::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


We can refer to this equation by Equation (my:eq1).
Or a system of equations with labels::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


We can refer to Equations (eq1)-(eq2).
Or align without eq numbers::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.



Or with multline::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


Maybe split is better::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


And we can refer to the last equation by Equation (split:envir:eq).

What about gather::

        \begin{gather}
        a = b \\ 
        c = d + 7 + 9
        \end{gather}


And what about alignat::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


Let us refer to Equations (eq1)-(eq2) again, and to the
alignat variant Equations (eq1a)-(eq2a), and to Equation (my:eq1).

Here is eqnarray::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.







************** File: testdoc.txt *****************


A Test Document
===============

Hans Petter Langtangen [1, 2]
Kaare Dump [3]
A. Dummy Author 

[1] Center for Biomedical Computing, Simula Research Laboratory
[2] Department of Informatics, University of Oslo
[3] Segfault Inc, Cyberspace


The format of this document is
plain


Section 1
=========

Just a little bit of text
and then a list:

  * item1

  * item2

  * item3 which continues
    on the next line to test that feature

  * and a sublist

    * with indented subitem1

    * and a subitem2


  * and perhaps an ordered sublist

   1. first item

   2. second item,
      continuing on a new line


Subsection 1
------------

More text, with a reference back to the section "Section 1" and further
to the section "URLs". 
Subsection 2
------------

What about a figure?

FIGURE:[../docs/manual/figs/dinoimpact.gif, width=200] It can't get worse than this.... {fig:impact}

Table Demo
----------

Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
2.0           1.376512      11.919        
4.0           1.1E+1        14.717624     
============  ============  ============  

The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


URLs
----

Here are some nice URLs, e.g., hpl's home page hpl (http://folk.uio.no/hpl),
or the URL if desired, http://folk.uio.no/hpl.
Here is a plain file link testdoc.do.txt, or testdoc.do.txt,
or testdoc.do.txt or testdoc.do.txt. Can test spaces
with the link with word too: hpl (http://folk.uio.no/hpl) or
hpl (http://folk.uio.no/hpl). The old syntax must also be
tested: hpl's homepage (http://folk.uio.no/hpl). Now also file:///
works: link to a file (file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html)
is fine to have.



Here is an equation without label::

        \[ a = b + c \]

or with number and label, as in Equation (my:eq1)::

        \begin{equation}
        {\partial u\over\partial t} = \nabla^2 u\label{my:eq1}
        \end{equation}

We can refer to this equation by Equation (my:eq1).
Or a system of equations with labels::

        \begin{align}
        a &= q + 4 + 5+ 6\label{eq1} \\ 
        b &= \nabla^2 u + \nabla^4 x \label{eq2}
        \end{align}

We can refer to Equations (eq1)-(eq2).
Or align without eq numbers::

        \begin{align*}
        a &= q + 4 + 5+ 6 \\ 
        b &= \nabla^2 u + \nabla^4 x
        \end{align*}


Or with multline::

        \begin{multline}
        a = b = q + \\ 
          f + \nabla\cdot\nabla u 
        label{multiline:eq1}
        \end{multline}

Maybe split is better::

        \begin{equation}
        label{split:envir:eq}
        \begin{split}
        a = b = q &+ \\ 
          & f + \nabla\cdot\nabla u
        \end{split}
        \end{equation}

And we can refer to the last equation by Equation (split:envir:eq).

What about gather::

        \begin{gather}
        a = b \\ 
        c = d + 7 + 9
        \end{gather}


And what about alignat::

        \begin{alignat}{2}
        a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0\label{eq1a} \\ 
        b &= \nabla^2 u + \nabla^4 x & x\in\Omega \label{eq2a}
        \end{alignat}

Let us refer to Equations (eq1)-(eq2) again, and to the
alignat variant Equations (eq1a)-(eq2a), and to Equation (my:eq1).

Here is eqnarray::

        \begin{eqnarray}
        {\partial u\over\partial t} &=& \nabla^2 u + f,label{myeq1}\\ 
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}






************** File: make.sh *****************
#!/bin/sh
# test multiple authors:
doconce format HTML testdoc.do.txt
doconce format LaTeX testdoc.do.txt
doconce format plain testdoc.do.txt
doconce format st testdoc.do.txt
doconce format sphinx testdoc.do.txt
mv -f testdoc.rst testdoc.sphinx.rst
doconce format rst testdoc.do.txt
doconce format epytext testdoc.do.txt
doconce format gwiki testdoc.do.txt

************** File: make.sh *****************
#!/bin/sh -x
./clean.sh

# HTML
doconce format HTML tutorial.do.txt

# LaTeX
doconce format LaTeX tutorial.do.txt
ptex2tex -DHELVETICA tutorial
latex tutorial.tex  # no -shell-escape since no -DMINTED to ptex2tex
latex tutorial.tex
dvipdf tutorial.dvi

# Sphinx
doconce format sphinx tutorial.do.txt
doconce sphinx_dir tutorial.do.txt
cp tutorial.rst tutorial.sphinx.rst
mv tutorial.rst sphinx-rootdir
# index-sphinx is a ready-made version of index.rst:
cp index-sphinx sphinx-rootdir/index.rst   # necessary?
cd sphinx-rootdir
make clean
make html
make latex
cd _build/latex
make clean
make all-pdf
cp DoconceDocumentOnceIncludeAnywhere.pdf ../../../tutorial.sphinx.pdf
cd ../../..
#firefox sphinx-rootdir/_build/html/index.html

# reStructuredText:
doconce format rst tutorial.do.txt
rst2xml.py tutorial.rst > tutorial.xml
rst2odt.py tutorial.rst > tutorial.odt
rst2html.py tutorial.rst > tutorial.rst.html
rst2latex.py tutorial.rst > tutorial.rst.tex
latex tutorial.rst.tex
dvipdf tutorial.rst.dvi

# Other formats:
doconce format plain tutorial.do.txt
doconce format gwiki tutorial.do.txt
doconce format st tutorial.do.txt
doconce format epytext tutorial.do.txt

# Make PDF of most of the above:
a2ps_plain='a2ps --left-title='\'''\'' --right-title='\'''\'' --left-footer='\'''\'' --right-footer='\'''\'' --footer='\'''\'''
$a2ps_plain -1 -o tutorial.do.ps tutorial.do.txt
ps2pdf tutorial.do.ps
$a2ps_plain -1 -o tutorial.epytext.ps tutorial.epytext
ps2pdf tutorial.epytext.ps
$a2ps_plain -1 -o tutorial.txt.ps tutorial.txt
ps2pdf tutorial.txt.ps
$a2ps_plain -1 -o tutorial.gwiki.ps tutorial.gwiki
ps2pdf tutorial.gwiki.ps
$a2ps_plain -1 -o tutorial.xml.ps tutorial.xml
ps2pdf tutorial.xml.ps

rm -f *.ps

#wkhtmltopdf tutorial.rst.html tutorial.rst.html.pdf
#wkhtmltopdf tutorial.html tutorial.html.pdf

pdftk tutorial.do.pdf tutorial.pdf tutorial.rst.pdf tutorial.sphinx.pdf tutorial.txt.pdf tutorial.epytext.pdf tutorial.gwiki.pdf tutorial.sphinx.pdf tutorial.xml.pdf  cat output collection_of_results.pdf

rm -rf demo
mkdir demo
cp -r tutorial.do.txt tutorial.html tutorial.tex tutorial.pdf tutorial.rst tutorial.sphinx.rst tutorial.sphinx.pdf tutorial.xml tutorial.rst.html tutorial.rst.tex tutorial.rst.pdf tutorial.gwiki tutorial.txt tutorial.epytext tutorial.st collection_of_results.pdf sphinx-rootdir/_build/html demo

cd demo
cat > index.html <<EOF
<HTML><BODY>
<TITLE>Demo of Doconce formats</TITLE>
<H3>Doconce demo</H3>

Doconce is a minimum tagged markup language. The file 
<a href="tutorial.do.txt">tutorial.do.txt</a> is the source of the
Doconce tutorial, written in the Doconce format.
Running
<pre>
doconce format HTML tutorial.do.txt
</pre>
produces the HTML file <a href="tutorial.html">tutorial.html</a>.
Going from Doconce to LaTeX is done by
<pre>
doconce format LaTeX tutorial.do.txt
</pre>
resulting in the file <a href="tutorial.tex">tutorial.tex</a>, which can
be compiled to a PDF file <a href="tutorial.pdf">tutorial.pdf</a>
by running <tt>latex</tt> and <tt>dvipdf</tt> the standard way.
<p>
The reStructuredText (reST) format is of particular interest:
<pre>
doconce format rst tutorial.do.txt
</pre>
The reST file <a href="tutorial.rst">tutorial.rst</a> is a starting point
for conversion to many other formats: OpenOffice, 
<a href="tutorial.xml">XML</a>, <a href="tutorial.rst.html">HTML</a>,
<a href="tutorial.rst.tex">LaTeX</a>, 
and from LaTeX to <a href="tutorial.rst.pdf">PDF</a>.
The <a href="tutorial.sphinx.rst">Sphinx</a> dialect of reST
can be translated to <a href="tutorial.sphinx.pdf">PDF</a>
and <a href="html/index.html">HTML</a>.
<p>
Doconce can also be converted to 
<a href="tutorial.gwiki">a (Google Code) wiki</a>,
<a href="tutorial.st">Structured Text</a>, 
<a href="tutorial.epytext">Epytext</a>,
and maybe the most important format of all:
<a href="tutorial.txt">plain untagged ASCII text</a>.
</BODY>
</HTML>
EOF

echo
echo "Go to the demo directory and load index.html into a web browser."

# update demo (recall that there is no .hg dir except in the top dir
# so we can just take an rm and cp)
cd ..
rm -rf ../demos/tutorial
cp -r demo ../demos/tutorial

************** File: tutorial.do.txt *****************
TITLE: Doconce: Document Once, Include Anywhere
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: today


 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.


======= The Doconce Concept  =======

Doconce is two things:

  o Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

  o Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
    

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.
  * Doconce has less cluttered tagging of text.
  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.


======= What Does Doconce Look Like? =======

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,
 
  * there is support for both LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,

  * with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format:
!bc
===== A Subsection with Sample Text =====
label{my:first:sec}

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

URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
If the word is URL, the URL itself becomes the link name,
as in "URL":"tutorial.do.txt".

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
Chapter ref{my:first:sec}. 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see Chapter ref{doconce2formats} for an example).

Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|

# lines beginning with # are comment lines
!ec
The Doconce text above results in the following little document:

===== A Subsection with Sample Text =====
label{my:first:sec}

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1
  * item 2
  * item 3

Lists can also have numbered items instead of bullets, just use an `o`
(for ordered) instead of the asterisk:

  o item 1
  o item 2
  o item 3

URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
If the word is URL, the URL itself becomes the link name,
as in "URL":"tutorial.do.txt".

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
Chapter ref{my:first:sec}. 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see Chapter ref{doconce2formats} for an example).

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
{\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
!et
Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
`!bc` and `!ec` instructions, respectively. Such blocks look like
!bc cod
from math import sin, pi
def myfunc(x):
    return sin(pi*x)

import integrate
I = integrate.trapezoidal(myfunc, 0, pi, 100)
!ec
It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., `!bc xxx`
where `xxx` is an identifier like `pycod` for code snippet in Python,
`sys` for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file `.ptext2tex.cfg`, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments):
!bc
# sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console
!ec
By default, `pro` and `cod` are `python`, `sys` is `console`,
while `xpro` and `xcod` are computer language specific for `x`
in `f` (Fortran), `c` (C), `cpp` (C++), and `py` (Python).
# `rb` (Ruby), `pl` (Perl), and `sh` (Unix shell).

# (Any sphinx code-block comment, whether inside verbatim code
# blocks or outside, yields a mapping between bc arguments
# and computer languages. In case of muliple definitions, the
# first one is used.)

One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with `!bc pro`, while a part of a file is copied into a `!bc cod`
environment. What `pro` and `cod` mean is then defined through
a `.ptex2tex.cfg` file for LaTeX and a `sphinx code-blocks`
comment for Sphinx.

Another document can be included by writing `#include "mynote.do.txt"`
on a line starting with (another) hash sign.  Doconce documents have
extension `do.txt`. The `do` part stands for doconce, while the
trailing `.txt` denotes a text document so that editors gives you the
right writing enviroment for plain text.


===== Macros (Newcommands), Cross-References, Index, and Bibliography =====
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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the `docs/manual/manual.do.txt` file (see the
https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html<demo
page> for various formats of this document).


# Example on including another Doconce file (using preprocess):

# #include "_doconce2anything.do.txt"


===== Demos =====

The current text is generated from a Doconce format stored in the file
!bc
docs/tutorial/tutorial.do.txt
!ec
The file `make.sh` in the `tutorial` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, `tutorial.do.txt` is the
starting point.  Running `make.sh` and studying the various generated
files and comparing them with the original `tutorial.do.txt` file,
gives a quick introduction to how Doconce is used in a real case.
https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html<Here> 
is a sample of how this tutorial looks in different formats.

There is another demo in the `docs/manual` directory which
translates the more comprehensive documentation, `manual.do.txt`, to
various formats. The `make.sh` script runs a set of translations.

===== Dependencies =====

If you make use of preprocessor directives in the Doconce source,
either "Preprocess": "http://code.google.com/p/preprocess" or "Mako":
"http://www.makotemplates.org" must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need "ptex2tex": "http://code.google.com/p/ptex2tex" and some style
files that `ptex2tex` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires "docutils": "http://docutils.sourceforge.net".  Making Sphinx
documents requires of course "Sphinx": "http://sphinx.pocoo.org".
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


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
<?xml version="1.0" encoding="utf-8" ?>
<!-- 
Automatically generated HTML file from Doconce source 
(http://code.google.com/p/doconce/) 
-->

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META name="generator" content="Doconce: http://code.google.com/p/doconce/" />
</HEAD>

<BODY BGCOLOR="white">
    <TITLE>Doconce: Document Once, Include Anywhere</TITLE>
<CENTER><H1>Doconce: Document Once, Include Anywhere</H1></CENTER>
<CENTER>
<B>Hans Petter Langtangen</B> [1, 2]
</CENTER>

<P>
<CENTER>[1] <B>Simula Research Laboratory</B></CENTER>
<CENTER>[2] <B>University of Oslo</B></CENTER>


<CENTER><H3>Feb 20, 2011</H3></CENTER>
<P>

<P>

<UL>
 <LI> When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?
 <LI> Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?
</UL>

If any of these questions are of interest, you should keep on reading.

<P>

<P>
<H1>The Doconce Concept</H1>
<P>
Doconce is two things:

<P>

<OL>
 <LI> Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
 <LI> Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
</OL>

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

<P>

<UL>
  <LI> Doconce can convert to plain <EM>untagged</EM> text, 
    more desirable for computer programs and email.
  <LI> Doconce has less cluttered tagging of text.
  <LI> Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  <LI> Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  <LI> Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.
</UL>

Doconce was particularly written for the following sample applications:

<P>

<UL>
  <LI> Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  <LI> Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  <LI> Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.
</UL>

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

<P>

<P>
<H1>What Does Doconce Look Like?</H1>
<P>
Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

<P>

<UL>
  <LI> bullet lists arise from lines starting with an asterisk,
  <LI> <EM>emphasized words</EM> are surrounded by asterisks, 
  <LI> <B>words in boldface</B> are surrounded by underscores, 
  <LI> words from computer code are enclosed in back quotes and 
    then typeset verbatim,
  <LI> blocks of computer code can easily be included, also from source files,
  <LI> blocks of LaTeX mathematics can easily be included,
  <LI> there is support for both LaTeX and text-like inline mathematics,
  <LI> figures with captions, URLs with links, labels and references
    are supported,
  <LI> comments can be inserted throughout the text,
  <LI> with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,
  <LI> with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.
</UL>

Here is an example of some simple text written in the Doconce format:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
===== A Subsection with Sample Text =====
label{my:first:sec}

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

URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
If the word is URL, the URL itself becomes the link name,
as in "URL":"tutorial.do.txt".

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
Chapter ref{my:first:sec}. 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see Chapter ref{doconce2formats} for an example).

Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|

# lines beginning with # are comment lines
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The Doconce text above results in the following little document:

<P>
<H3>A Subsection with Sample Text <A NAME="my:first:sec"></A></H3>
<P>

<P>
Ordinary text looks like ordinary text, and the tags used for
<B>boldface</B> words, <EM>emphasized</EM> words, and <TT>computer</TT> words look
natural in plain text.  Lists are typeset as you would do in an email,

<P>

<UL>
  <LI> item 1
  <LI> item 2
  <LI> item 3
</UL>

Lists can also have numbered items instead of bullets, just use an <TT>o</TT>
(for ordered) instead of the asterisk:

<P>

<OL>
 <LI> item 1
 <LI> item 2
 <LI> item 3
</OL>

URLs with a link word are possible, as in <A HREF="http://folk.uio.no/hpl">hpl</A>.
If the word is URL, the URL itself becomes the link name,
as in <A HREF="tutorial.do.txt"><TT>tutorial.do.txt</TT></A>.

<P>
References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter <A HREF="#my:first:sec">A Subsection with Sample Text</a>. 

<P>
Doconce also allows inline comments such as [<B>hpl</B>: <EM>here I will make
some remarks to the text</EM>] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter <A HREF="#doconce2formats">From Doconce to Other Formats</a> for an example).

<P>
Tables are also supperted, e.g.,

<P>
<TABLE border="1">
<TR><TD><B>    time    </B></TD> <TD><B>  velocity  </B></TD> <TD><B>acceleration</B></TD> </TR>
<TR><TD>   0.0             </TD> <TD>   1.4186          </TD> <TD>   -5.01           </TD> </TR>
<TR><TD>   2.0             </TD> <TD>   1.376512        </TD> <TD>   11.919          </TD> </TR>
<TR><TD>   4.0             </TD> <TD>   1.1E+1          </TD> <TD>   14.717624       </TD> </TR>
</TABLE>
<P>

<P>
<H3>Mathematics and Computer Code</H3>
<P>
Inline mathematics, such as v = sin(x),
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like v = sin(x) is
typeset as
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
$\nu = \sin(x)$|$v = sin(x)$
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

<P>
Blocks of mathematics are better typeset with raw LaTeX, inside
<TT>!bt</TT> and <TT>!et</TT> (begin tex / end tex) instructions. 
The result looks like this:
<BLOCKQUOTE><PRE>
\begin{eqnarray}
{\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
{\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
\end{eqnarray}
</PRE></BLOCKQUOTE>
Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

<P>
You can have blocks of computer code, starting and ending with
<TT>!bc</TT> and <TT>!ec</TT> instructions, respectively. Such blocks look like
<!-- BEGIN VERBATIM BLOCK   cod-->
<BLOCKQUOTE><PRE>
from math import sin, pi
def myfunc(x):
    return sin(pi*x)

import integrate
I = integrate.trapezoidal(myfunc, 0, pi, 100)
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., <TT>!bc xxx</TT>
where <TT>xxx</TT> is an identifier like <TT>pycod</TT> for code snippet in Python,
<TT>sys</TT> for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file <TT>.ptext2tex.cfg</TT>, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments):
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
# sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
By default, <TT>pro</TT> and <TT>cod</TT> are <TT>python</TT>, <TT>sys</TT> is <TT>console</TT>,
while <TT>xpro</TT> and <TT>xcod</TT> are computer language specific for <TT>x</TT>
in <TT>f</TT> (Fortran), <TT>c</TT> (C), <TT>cpp</TT> (C++), and <TT>py</TT> (Python).
<!-- <TT>rb</TT> (Ruby), <TT>pl</TT> (Perl), and <TT>sh</TT> (Unix shell). -->

<P>
<!-- (Any sphinx code-block comment, whether inside verbatim code -->
<!-- blocks or outside, yields a mapping between bc arguments -->
<!-- and computer languages. In case of muliple definitions, the -->
<!-- first one is used.) -->

<P>
One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with <TT>!bc pro</TT>, while a part of a file is copied into a <TT>!bc cod</TT>
environment. What <TT>pro</TT> and <TT>cod</TT> mean is then defined through
a <TT>.ptex2tex.cfg</TT> file for LaTeX and a <TT>sphinx code-blocks</TT>
comment for Sphinx.

<P>
Another document can be included by writing <TT>#include "mynote.do.txt"</TT>
on a line starting with (another) hash sign.  Doconce documents have
extension <TT>do.txt</TT>. The <TT>do</TT> part stands for doconce, while the
trailing <TT>.txt</TT> denotes a text document so that editors gives you the
right writing enviroment for plain text.

<P>

<P>
<H3>Macros (Newcommands), Cross-References, Index, and Bibliography <A NAME="newcommands"></A></H3>
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
Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the <TT>docs/manual/manual.do.txt</TT> file (see the
<A HREF="https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html">demo
page</A> for various formats of this document).

<P>

<P>
<!-- Example on including another Doconce file (using preprocess): -->

<P>

<P>
<H1>From Doconce to Other Formats <A NAME="doconce2formats"></A></H1>
<P>

<P>
Transformation of a Doconce document to various other
formats applies the script <TT>doconce format</TT>:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format format mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>preprocess</TT> program is always used to preprocess the file first,
and options to <TT>preprocess</TT> can be added after the filename. For example,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The variable <TT>FORMAT</TT> is always defined as the current format when
running <TT>preprocess</TT>. That is, in the last example, <TT>FORMAT</TT> is
defined as <TT>LaTeX</TT>. Inside the Doconce document one can then perform
format specific actions through tests like <TT>#if FORMAT == "LaTeX"</TT>.

<P>
Inline comments in the text are removed from the output by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
One can also remove such comments from the original Doconce file
by running a helper script in the <TT>bin</TT> folder of the Doconce
source code:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce remove_inline_comments mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
This action is convenient when a Doconce document reaches its final form.

<P>

<P>
<H3>HTML</H3>
<P>
Making an HTML version of a Doconce file <TT>mydoc.do.txt</TT>
is performed by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format HTML mydoc.do.txt
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
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format LaTeX mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files <TT>newcommands.tex</TT>, <TT>newcommands_keep.tex</TT>, or
<TT>newcommands_replace.tex</TT> (see the section <A HREF="#newcommands">Macros (Newcommands), Cross-References, Index, and Bibliography</a>). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

<P>
<B>Step 2.</B> Run <TT>ptex2tex</TT> (if you have it) to make a standard LaTeX file,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just perform a plain copy,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> cp mydoc.p.tex mydoc.tex
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Doconce generates a <TT>.p.tex</TT> file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex -DHELVETICA mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The <TT>ptex2tex</TT> tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any <TT>!bc sys</TT> command in the Doconce source you can
insert verbatim block styles as defined in your <TT>.ptex2tex.cfg</TT>
file, e.g., <TT>!bc sys cod</TT> for a code snippet, where <TT>cod</TT> is set to
a certain environment in <TT>.ptex2tex.cfg</TT> (e.g., <TT>CodeIntended</TT>).
There are over 30 styles to choose from.

<P>
<B>Step 3.</B> Compile <TT>mydoc.tex</TT>
and create the PDF file:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> latex mydoc
Unix/DOS> latex mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex mydoc
Unix/DOS> dvipdf mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
If one wishes to use the <TT>Minted_Python</TT>, <TT>Minted_Cpp</TT>, etc., environments
in <TT>ptex2tex</TT> for typesetting code, the <TT>minted</TT> LaTeX package is needed.
This package is included by running <TT>doconce format</TT> with the
<TT>-DMINTED</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex -DMINTED mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In this case, <TT>latex</TT> must be run with the
<TT>-shell-escape</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> dvipdf mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>-shell-escape</TT> option is required because the <TT>minted.sty</TT> style
file runs the <TT>pygments</TT> program to format code, and this program
cannot be run from <TT>latex</TT> without the <TT>-shell-escape</TT> option.

<P>

<P>
<H3>Plain ASCII Text</H3>
<P>
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<H3>reStructuredText</H3>
<P>
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file <TT>mydoc.rst</TT>:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format rst mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
We may now produce various other formats:
<!-- BEGIN VERBATIM BLOCK   sys-->
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
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format sphinx mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 2.</B> Create a Sphinx root directory with a <TT>conf.py</TT> file, 
either manually or by using the interactive <TT>sphinx-quickstart</TT>
program. Here is a scripted version of the steps with the latter:
<!-- BEGIN VERBATIM BLOCK   sys-->
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
These statements are automated by the command
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce sphinx_dir mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 3.</B> Move the <TT>tutorial.rst</TT> file to the Sphinx root directory:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> mv mydoc.rst sphinx-rootdir
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
If you have figures in your document, the relative paths to those will
be invalid when you work with <TT>mydoc.rst</TT> in the <TT>sphinx-rootdir</TT>
directory. Either edit <TT>mydoc.rst</TT> so that figure file paths are correct,
or simply copy your figure directory to <TT>sphinx-rootdir</TT> (if all figures
are located in a subdirectory).

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
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
make clean   # remove old versions
make html
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Many other formats are also possible.

<P>
<B>Step 6.</B> View the result:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> firefox _build/html/index.html
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows <TT>!bc</TT>: <TT>cod</TT> gives Python
(<TT>code-block:: python</TT> in Sphinx syntax) and <TT>cppcod</TT> gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

<P>
<!-- Desired extension: sphinx can utilize a "pycod" or "c++cod" -->
<!-- instruction as currently done in latex for ptex2tex and write -->
<!-- out the right code block name accordingly. -->

<P>

<P>
<H3>Google Code Wiki</H3>
<P>
There are several different wiki dialects, but Doconce only support the
one used by <A HREF="http://code.google.com/p/support/wiki/WikiSyntax">Google Code</A>.
The transformation to this format, called <TT>gwiki</TT> to explicitly mark
it as the Google Code dialect, is done by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format gwiki mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
You can then open a new wiki page for your Google Code project, copy
the <TT>mydoc.gwiki</TT> output file from <TT>doconce format</TT> and paste the
file contents into the wiki page. Press <B>Preview</B> or <B>Save Page</B> to
see the formatted result.

<P>
When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).

<P>

<P>
<H3>Tweaking the Doconce Output</H3>
<P>
Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
<TT>.rst</TT> file is going to be filtered to LaTeX or HTML, it cannot know
if <TT>.eps</TT> or <TT>.png</TT> is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The <TT>make.sh</TT> files in <TT>docs/manual</TT> and <TT>docs/tutorial</TT> 
constitute comprehensive examples on how such scripts can be made.

<P>

<P>
<H3>Demos</H3>
<P>
The current text is generated from a Doconce format stored in the file
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
docs/tutorial/tutorial.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The file <TT>make.sh</TT> in the <TT>tutorial</TT> directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, <TT>tutorial.do.txt</TT> is the
starting point.  Running <TT>make.sh</TT> and studying the various generated
files and comparing them with the original <TT>tutorial.do.txt</TT> file,
gives a quick introduction to how Doconce is used in a real case.
<A HREF="https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html">Here</A> 
is a sample of how this tutorial looks in different formats.

<P>
There is another demo in the <TT>docs/manual</TT> directory which
translates the more comprehensive documentation, <TT>manual.do.txt</TT>, to
various formats. The <TT>make.sh</TT> script runs a set of translations.

<P>
<H3>Dependencies</H3>
<P>
If you make use of preprocessor directives in the Doconce source,
either <A HREF="http://code.google.com/p/preprocess">Preprocess</A> or <A HREF="http://www.makotemplates.org">Mako</A> must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need <A HREF="http://code.google.com/p/ptex2tex">ptex2tex</A> and some style
files that <TT>ptex2tex</TT> potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires <A HREF="http://docutils.sourceforge.net">docutils</A>.  Making Sphinx
documents requires of course <A HREF="http://sphinx.pocoo.org">Sphinx</A>.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.

<P>

<P>
<H1>Warning/Disclaimer</H1>
<P>
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

</BODY>
</HTML>
    
************** File: tutorial.p.tex *****************
NOT FOUND!
************** File: tutorial.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)

Doconce: Document Once, Include Anywhere
========================================

:Author: Hans Petter Langtangen

:Date: Feb 20, 2011

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.

  * Doconce has less cluttered tagging of text.

  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.


What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * **words in boldface** are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support for both LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,

  * with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format::


        ===== A Subsection with Sample Text =====
        label{my:first:sec}
        
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
        
        URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
        If the word is URL, the URL itself becomes the link name,
        as in "URL":"tutorial.do.txt".
        
        References to sections may use logical names as labels (e.g., a
        "label" command right after the section title), as in the reference to
        Chapter ref{my:first:sec}. 
        
        Doconce also allows inline comments such as [hpl: here I will make
        some remarks to the text] for allowing authors to make notes. Inline
        comments can be removed from the output by a command-line argument
        (see Chapter ref{doconce2formats} for an example).
        
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|
        
        # lines beginning with # are comment lines

The Doconce text above results in the following little document:

.. _my:first:sec:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
**boldface** words, *emphasized* words, and ``computer`` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1

  * item 2

  * item 3

Lists can also have numbered items instead of bullets, just use an ``o``
(for ordered) instead of the asterisk:

 1. item 1

 2. item 2

 3. item 3

URLs with a link word are possible, as in `hpl <http://folk.uio.no/hpl>`_.
If the word is URL, the URL itself becomes the link name,
as in `<tutorial.do.txt>`_.

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter `A Subsection with Sample Text`_. 

Doconce also allows inline comments such as (**hpl**: here I will make
some remarks to the text) for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter `From Doconce to Other Formats`_ for an example).

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
        {\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
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

It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., ``!bc xxx``
where ``xxx`` is an identifier like ``pycod`` for code snippet in Python,
``sys`` for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file ``.ptext2tex.cfg``, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments)::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

By default, ``pro`` and ``cod`` are ``python``, ``sys`` is ``console``,
while ``xpro`` and ``xcod`` are computer language specific for ``x``
in ``f`` (Fortran), ``c`` (C), ``cpp`` (C++), and ``py`` (Python).
.. ``rb`` (Ruby), ``pl`` (Perl), and ``sh`` (Unix shell).

.. (Any sphinx code-block comment, whether inside verbatim code
.. blocks or outside, yields a mapping between bc arguments
.. and computer languages. In case of muliple definitions, the
.. first one is used.)

One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with ``!bc pro``, while a part of a file is copied into a ``!bc cod``
environment. What ``pro`` and ``cod`` mean is then defined through
a ``.ptex2tex.cfg`` file for LaTeX and a ``sphinx code-blocks``
comment for Sphinx.

Another document can be included by writing ``#include "mynote.do.txt"``
on a line starting with (another) hash sign.  Doconce documents have
extension ``do.txt``. The ``do`` part stands for doconce, while the
trailing ``.txt`` denotes a text document so that editors gives you the
right writing enviroment for plain text.


.. _newcommands:

Macros (Newcommands), Cross-References, Index, and Bibliography
---------------------------------------------------------------

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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the ``docs/manual/manual.do.txt`` file (see the
`demo
page <https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html>`_ for various formats of this document).


.. Example on including another Doconce file (using preprocess):


.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script ``doconce format``::


        Unix/DOS> doconce format format mydoc.do.txt

The ``preprocess`` program is always used to preprocess the file first,
and options to ``preprocess`` can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the ``bin`` folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many
.. formats - the text may be messed up. A better choice is a paragraph
.. environment, as used here.

*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``::


        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section `Macros (Newcommands), Cross-References, Index, and Bibliography`_). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any ``!bc sys`` command in the Doconce source you can
insert verbatim block styles as defined in your ``.ptex2tex.cfg``
file, e.g., ``!bc sys cod`` for a code snippet, where ``cod`` is set to
a certain environment in ``.ptex2tex.cfg`` (e.g., ``CodeIntended``).
There are over 30 styles to choose from.

*Step 3.* Compile ``mydoc.tex``
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``::


        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with ``mydoc.rst`` in the ``sphinx-rootdir``
directory. Either edit ``mydoc.rst`` so that figure file paths are correct,
or simply copy your figure directory to ``sphinx-rootdir`` (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows ``!bc``: ``cod`` gives Python
(``code-block:: python`` in Sphinx syntax) and ``cppcod`` gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

.. Desired extension: sphinx can utilize a "pycod" or "c++cod"
.. instruction as currently done in latex for ptex2tex and write
.. out the right code block name accordingly.


Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by `Google Code <http://code.google.com/p/support/wiki/WikiSyntax>`_.
The transformation to this format, called ``gwiki`` to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the ``mydoc.gwiki`` output file from ``doconce format`` and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
``.rst`` file is going to be filtered to LaTeX or HTML, it cannot know
if ``.eps`` or ``.png`` is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The ``make.sh`` files in ``docs/manual`` and ``docs/tutorial`` 
constitute comprehensive examples on how such scripts can be made.


Demos
-----

The current text is generated from a Doconce format stored in the file::


        docs/tutorial/tutorial.do.txt

The file ``make.sh`` in the ``tutorial`` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, ``tutorial.do.txt`` is the
starting point.  Running ``make.sh`` and studying the various generated
files and comparing them with the original ``tutorial.do.txt`` file,
gives a quick introduction to how Doconce is used in a real case.
`Here <https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html>`_ 
is a sample of how this tutorial looks in different formats.

There is another demo in the ``docs/manual`` directory which
translates the more comprehensive documentation, ``manual.do.txt``, to
various formats. The ``make.sh`` script runs a set of translations.

Dependencies
------------

If you make use of preprocessor directives in the Doconce source,
either `Preprocess <http://code.google.com/p/preprocess>`_ or `Mako <http://www.makotemplates.org>`_ must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need `ptex2tex <http://code.google.com/p/ptex2tex>`_ and some style
files that ``ptex2tex`` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires `docutils <http://docutils.sourceforge.net>`_.  Making Sphinx
documents requires of course `Sphinx <http://sphinx.pocoo.org>`_.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


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
************** File: tutorial.sphinx.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)

Doconce: Document Once, Include Anywhere
========================================

:Author: Hans Petter Langtangen

:Date: Feb 20, 2011

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.

  * Doconce has less cluttered tagging of text.

  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.


What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * **words in boldface** are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support for both LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,

  * with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format:

.. code-block:: py


        ===== A Subsection with Sample Text =====
        label{my:first:sec}
        
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
        
        URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
        If the word is URL, the URL itself becomes the link name,
        as in "URL":"tutorial.do.txt".
        
        References to sections may use logical names as labels (e.g., a
        "label" command right after the section title), as in the reference to
        Chapter ref{my:first:sec}. 
        
        Doconce also allows inline comments such as [hpl: here I will make
        some remarks to the text] for allowing authors to make notes. Inline
        comments can be removed from the output by a command-line argument
        (see Chapter ref{doconce2formats} for an example).
        
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|
        
        # lines beginning with # are comment lines

The Doconce text above results in the following little document:

.. _my:first:sec:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
**boldface** words, *emphasized* words, and ``computer`` words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1

  * item 2

  * item 3

Lists can also have numbered items instead of bullets, just use an ``o``
(for ordered) instead of the asterisk:

 1. item 1

 2. item 2

 3. item 3

URLs with a link word are possible, as in `hpl <http://folk.uio.no/hpl>`_.
If the word is URL, the URL itself becomes the link name,
as in `<tutorial.do.txt>`_.

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter :ref:`my:first:sec`. 

Doconce also allows inline comments such as (**hpl**: here I will make
some remarks to the text) for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter :ref:`doconce2formats` for an example).

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

Inline mathematics, such as :math:`\nu = \sin(x)`,
allows the formula to be specified both as LaTeX and as plain text.
This results in a professional LaTeX typesetting, but in other formats
the text version normally looks better than raw LaTeX mathematics with
backslashes. An inline formula like :math:`\nu = \sin(x)` is
typeset as

.. code-block:: py


        $\nu = \sin(x)$|$v = sin(x)$

The pipe symbol acts as a delimiter between LaTeX code and the plain text
version of the formula.

Blocks of mathematics are better typeset with raw LaTeX, inside
``!bt`` and ``!et`` (begin tex / end tex) instructions. 
The result looks like this:

.. math::
   :label: myeq1
        
        {\partial u\over\partial t}  &=  \nabla^2 u + f, \\
        {\partial v\over\partial t}  &=  \nabla\cdot(q(u)\nabla v) + g
        

Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with
``!bc`` and ``!ec`` instructions, respectively. Such blocks look like

.. code-block:: py

        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)

It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., ``!bc xxx``
where ``xxx`` is an identifier like ``pycod`` for code snippet in Python,
``sys`` for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file ``.ptext2tex.cfg``, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments):

.. code-block:: py


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

By default, ``pro`` and ``cod`` are ``python``, ``sys`` is ``console``,
while ``xpro`` and ``xcod`` are computer language specific for ``x``
in ``f`` (Fortran), ``c`` (C), ``cpp`` (C++), and ``py`` (Python).
.. ``rb`` (Ruby), ``pl`` (Perl), and ``sh`` (Unix shell).

.. (Any sphinx code-block comment, whether inside verbatim code
.. blocks or outside, yields a mapping between bc arguments
.. and computer languages. In case of muliple definitions, the
.. first one is used.)

One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with ``!bc pro``, while a part of a file is copied into a ``!bc cod``
environment. What ``pro`` and ``cod`` mean is then defined through
a ``.ptex2tex.cfg`` file for LaTeX and a ``sphinx code-blocks``
comment for Sphinx.

Another document can be included by writing ``#include "mynote.do.txt"``
on a line starting with (another) hash sign.  Doconce documents have
extension ``do.txt``. The ``do`` part stands for doconce, while the
trailing ``.txt`` denotes a text document so that editors gives you the
right writing enviroment for plain text.


.. _newcommands:

Macros (Newcommands), Cross-References, Index, and Bibliography
---------------------------------------------------------------

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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the ``docs/manual/manual.do.txt`` file (see the
`demo
page <https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html>`_ for various formats of this document).


.. Example on including another Doconce file (using preprocess):


.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script ``doconce format``:

.. code-block:: console

        Unix/DOS> doconce format format mydoc.do.txt

The ``preprocess`` program is always used to preprocess the file first,
and options to ``preprocess`` can be added after the filename. For example,

.. code-block:: console

        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by

.. code-block:: console

        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the ``bin`` folder of the Doconce
source code:

.. code-block:: py


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by

.. code-block:: console

        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many
.. formats - the text may be messed up. A better choice is a paragraph
.. environment, as used here.

*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``:

.. code-block:: console

        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section :ref:`newcommands`). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file,

.. code-block:: console

        Unix/DOS> ptex2tex mydoc

or just perform a plain copy,

.. code-block:: console

        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font,

.. code-block:: console

        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through

.. code-block:: console

        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any ``!bc sys`` command in the Doconce source you can
insert verbatim block styles as defined in your ``.ptex2tex.cfg``
file, e.g., ``!bc sys cod`` for a code snippet, where ``cod`` is set to
a certain environment in ``.ptex2tex.cfg`` (e.g., ``CodeIntended``).
There are over 30 styles to choose from.

*Step 3.* Compile ``mydoc.tex``
and create the PDF file:

.. code-block:: console

        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option:

.. code-block:: console

        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option:

.. code-block:: console

        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:

.. code-block:: console

        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``:

.. code-block:: console

        Unix/DOS> doconce format rst mydoc.do.txt

We may now produce various other formats:

.. code-block:: console

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

.. code-block:: console

        Unix/DOS> doconce format sphinx mydoc.do.txt


*Step 2.* Create a Sphinx root directory with a ``conf.py`` file, 
either manually or by using the interactive ``sphinx-quickstart``
program. Here is a scripted version of the steps with the latter:

.. code-block:: console

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

These statements are automated by the command

.. code-block:: console

        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory:

.. code-block:: console

        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with ``mydoc.rst`` in the ``sphinx-rootdir``
directory. Either edit ``mydoc.rst`` so that figure file paths are correct,
or simply copy your figure directory to ``sphinx-rootdir`` (if all figures
are located in a subdirectory).

*Step 4.* Edit the generated ``index.rst`` file so that ``mydoc.rst``
is included, i.e., add ``mydoc`` to the ``toctree`` section so that it becomes

.. code-block:: py


        .. toctree::
           :maxdepth: 2
        
           mydoc

(The spaces before ``mydoc`` are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source:

.. code-block:: console

        make clean   # remove old versions
        make html

Many other formats are also possible.

*Step 6.* View the result:

.. code-block:: console

        Unix/DOS> firefox _build/html/index.html


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows ``!bc``: ``cod`` gives Python
(``code-block:: python`` in Sphinx syntax) and ``cppcod`` gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

.. Desired extension: sphinx can utilize a "pycod" or "c++cod"
.. instruction as currently done in latex for ptex2tex and write
.. out the right code block name accordingly.


Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by `Google Code <http://code.google.com/p/support/wiki/WikiSyntax>`_.
The transformation to this format, called ``gwiki`` to explicitly mark
it as the Google Code dialect, is done by

.. code-block:: console

        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the ``mydoc.gwiki`` output file from ``doconce format`` and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
``.rst`` file is going to be filtered to LaTeX or HTML, it cannot know
if ``.eps`` or ``.png`` is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The ``make.sh`` files in ``docs/manual`` and ``docs/tutorial`` 
constitute comprehensive examples on how such scripts can be made.


Demos
-----

The current text is generated from a Doconce format stored in the file

.. code-block:: py


        docs/tutorial/tutorial.do.txt

The file ``make.sh`` in the ``tutorial`` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, ``tutorial.do.txt`` is the
starting point.  Running ``make.sh`` and studying the various generated
files and comparing them with the original ``tutorial.do.txt`` file,
gives a quick introduction to how Doconce is used in a real case.
`Here <https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html>`_ 
is a sample of how this tutorial looks in different formats.

There is another demo in the ``docs/manual`` directory which
translates the more comprehensive documentation, ``manual.do.txt``, to
various formats. The ``make.sh`` script runs a set of translations.

Dependencies
------------

If you make use of preprocessor directives in the Doconce source,
either `Preprocess <http://code.google.com/p/preprocess>`_ or `Mako <http://www.makotemplates.org>`_ must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need `ptex2tex <http://code.google.com/p/ptex2tex>`_ and some style
files that ``ptex2tex`` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires `docutils <http://docutils.sourceforge.net>`_.  Making Sphinx
documents requires of course `Sphinx <http://sphinx.pocoo.org>`_.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


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
************** File: tutorial.gwiki *****************
#summary Doconce: Document Once, Include Anywhere
<wiki:toc max_depth="2" />
By *Hans Petter Langtangen*

==== Feb 20, 2011 ====

 * When writing a note, report, manual, etc., do you find it difficult   to choose the typesetting format? That is, to choose between plain   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,   reStructuredText, Sphinx, XML, etc.  Would it be convenient to   start with some very simple text-like format that easily converts   to the formats listed above, and then at some later stage eventually go   with a particular format?
 * Do you find it problematic that you have the same information   scattered around in different documents in different typesetting   formats? Would it be a good idea to write things once, in one   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.



== The Doconce Concept ==

Doconce is two things:


 # Doconce is a very simple and minimally tagged markup language that    look like ordinary ASCII text (much like what you would use in an    email), but the text can be transformed to numerous other formats,    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,    Epytext, and also plain text (where non-obvious formatting/tags are    removed for clear reading in, e.g., emails). From reStructuredText    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the    latter to RTF and MS Word.
 # Doconce is a working strategy for never duplicating information.    Text is written in a single place and then transformed to    a number of different destinations of diverse type (software    source code, manuals, tutorials, books, wikis, memos, emails, etc.).    The Doconce markup language support this working strategy.    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?


  * Doconce can convert to plain *untagged* text,     more desirable for computer programs and email.
  * Doconce has less cluttered tagging of text.
  * Doconce has better support for copying in parts of computer code,    say in examples, directly from the source code files.
  * Doconce has stronger support for mathematical typesetting, and    has many features for being integrated with (big) LaTeX projects.
  * Doconce is almost self-explanatory and is a handy starting point    for generating documents in more complicated markup languages, such    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:


  * Large books written in LaTeX, but where many pieces (computer demos,    projects, examples) can be written in Doconce to appear in other    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  * Software documentation, primarily Python doc strings, which one wants    to appear as plain untagged text for viewing in Pydoc, as reStructuredText    for use with Sphinx, as wiki text when publishing the software at    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  * Quick memos, which start as plain text in email, then some small    amount of Doconce tagging is added, before the memos can appear as    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.



== What Does Doconce Look Like? ==

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,


  * bullet lists arise from lines starting with an asterisk,
  * *emphasized words* are surrounded by asterisks, 
  * *words in boldface* are surrounded by underscores, 
  * words from computer code are enclosed in back quotes and     then typeset verbatim,
  * blocks of computer code can easily be included, also from source files,
  * blocks of LaTeX mathematics can easily be included,
  * there is support for both LaTeX and text-like inline mathematics,
  * figures with captions, URLs with links, labels and references    are supported,
  * comments can be inserted throughout the text,
  * with a simple preprocessor, which is integrated, one can include    other documents (files) and large portions of text can be defined    in or out of the text,
  * with the Mako preprocessor one can even embed Python    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format:
{{{
===== A Subsection with Sample Text =====
label{my:first:sec}

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

URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
If the word is URL, the URL itself becomes the link name,
as in "URL":"tutorial.do.txt".

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
Chapter ref{my:first:sec}. 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see Chapter ref{doconce2formats} for an example).

Tables are also supperted, e.g.,

  |--------------------------------|
  |time  | velocity | acceleration |
  |--------------------------------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|

# lines beginning with # are comment lines
}}}
The Doconce text above results in the following little document:

==== A Subsection with Sample Text ====

Ordinary text looks like ordinary text, and the tags used for
*boldface* words, *emphasized* words, and `computer` words look
natural in plain text.  Lists are typeset as you would do in an email,


  * item 1
  * item 2
  * item 3

Lists can also have numbered items instead of bullets, just use an `o`
(for ordered) instead of the asterisk:


 # item 1
 # item 2
 # item 3

URLs with a link word are possible, as in [http://folk.uio.no/hpl hpl].
If the word is URL, the URL itself becomes the link name,
as in tutorial.do.txt.

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter [#A_Subsection_with_Sample_Text]. 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter [#From_Doconce_to_Other_Formats] for an example).

Tables are also supperted, e.g.,


 ||      *time*       ||    *velocity*     ||  *acceleration*   ||
 ||  0.0              ||  1.4186           ||  -5.01            ||
 ||  2.0              ||  1.376512         ||  11.919           ||
 ||  4.0              ||  1.1E+1           ||  14.717624        ||

==== Mathematics and Computer Code ====

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
{\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
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
It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., `!bc xxx`
where `xxx` is an identifier like `pycod` for code snippet in Python,
`sys` for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file `.ptext2tex.cfg`, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments):
{{{
# sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console
}}}
By default, `pro` and `cod` are `python`, `sys` is `console`,
while `xpro` and `xcod` are computer language specific for `x`
in `f` (Fortran), `c` (C), `cpp` (C++), and `py` (Python).
<wiki:comment> `rb` (Ruby), `pl` (Perl), and `sh` (Unix shell). </wiki:comment>

<wiki:comment> (Any sphinx code-block comment, whether inside verbatim code </wiki:comment>
<wiki:comment> blocks or outside, yields a mapping between bc arguments </wiki:comment>
<wiki:comment> and computer languages. In case of muliple definitions, the </wiki:comment>
<wiki:comment> first one is used.) </wiki:comment>

One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with `!bc pro`, while a part of a file is copied into a `!bc cod`
environment. What `pro` and `cod` mean is then defined through
a `.ptex2tex.cfg` file for LaTeX and a `sphinx code-blocks`
comment for Sphinx.

Another document can be included by writing `#include "mynote.do.txt"`
on a line starting with (another) hash sign.  Doconce documents have
extension `do.txt`. The `do` part stands for doconce, while the
trailing `.txt` denotes a text document so that editors gives you the
right writing enviroment for plain text.

==== Macros (Newcommands), Cross-References, Index, and Bibliography ====

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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the `docs/manual/manual.do.txt` file (see the
[https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html demo
page] for various formats of this document).


<wiki:comment> Example on including another Doconce file (using preprocess): </wiki:comment>



== From Doconce to Other Formats ==

Transformation of a Doconce document to various other
formats applies the script `doconce format`:
{{{
Unix/DOS> doconce format format mydoc.do.txt
}}}
The `preprocess` program is always used to preprocess the file first,
and options to `preprocess` can be added after the filename. For example,
{{{
Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections
}}}
The variable `FORMAT` is always defined as the current format when
running `preprocess`. That is, in the last example, `FORMAT` is
defined as `LaTeX`. Inside the Doconce document one can then perform
format specific actions through tests like `#if FORMAT == "LaTeX"`.

Inline comments in the text are removed from the output by
{{{
Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments
}}}
One can also remove such comments from the original Doconce file
by running a helper script in the `bin` folder of the Doconce
source code:
{{{
Unix/DOS> doconce remove_inline_comments mydoc.do.txt
}}}
This action is convenient when a Doconce document reaches its final form.

==== HTML ====

Making an HTML version of a Doconce file `mydoc.do.txt`
is performed by
{{{
Unix/DOS> doconce format HTML mydoc.do.txt
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
Unix/DOS> doconce format LaTeX mydoc.do.txt
}}}
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files `newcommands.tex`, `newcommands_keep.tex`, or
`newcommands_replace.tex` (see the section [#Macros_(Newcommands),_Cross-References,_Index,_and_Bibliography]). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run `ptex2tex` (if you have it) to make a standard LaTeX file,
{{{
Unix/DOS> ptex2tex mydoc
}}}
or just perform a plain copy,
{{{
Unix/DOS> cp mydoc.p.tex mydoc.tex
}}}
Doconce generates a `.p.tex` file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font,
{{{
Unix/DOS> ptex2tex -DHELVETICA mydoc
}}}
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through
{{{
Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc
}}}

The `ptex2tex` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any `!bc sys` command in the Doconce source you can
insert verbatim block styles as defined in your `.ptex2tex.cfg`
file, e.g., `!bc sys cod` for a code snippet, where `cod` is set to
a certain environment in `.ptex2tex.cfg` (e.g., `CodeIntended`).
There are over 30 styles to choose from.

*Step 3.* Compile `mydoc.tex`
and create the PDF file:
{{{
Unix/DOS> latex mydoc
Unix/DOS> latex mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex mydoc
Unix/DOS> dvipdf mydoc
}}}
If one wishes to use the `Minted_Python`, `Minted_Cpp`, etc., environments
in `ptex2tex` for typesetting code, the `minted` LaTeX package is needed.
This package is included by running `doconce format` with the
`-DMINTED` option:
{{{
Unix/DOS> ptex2tex -DMINTED mydoc
}}}
In this case, `latex` must be run with the
`-shell-escape` option:
{{{
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> dvipdf mydoc
}}}
The `-shell-escape` option is required because the `minted.sty` style
file runs the `pygments` program to format code, and this program
cannot be run from `latex` without the `-shell-escape` option.

==== Plain ASCII Text ====

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
{{{
Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt
}}}

==== reStructuredText ====

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file `mydoc.rst`:
{{{
Unix/DOS> doconce format rst mydoc.do.txt
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
Unix/DOS> doconce format sphinx mydoc.do.txt
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
These statements are automated by the command
{{{
Unix/DOS> doconce sphinx_dir mydoc.do.txt
}}}

*Step 3.* Move the `tutorial.rst` file to the Sphinx root directory:
{{{
Unix/DOS> mv mydoc.rst sphinx-rootdir
}}}
If you have figures in your document, the relative paths to those will
be invalid when you work with `mydoc.rst` in the `sphinx-rootdir`
directory. Either edit `mydoc.rst` so that figure file paths are correct,
or simply copy your figure directory to `sphinx-rootdir` (if all figures
are located in a subdirectory).

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

Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows `!bc`: `cod` gives Python
(`code-block:: python` in Sphinx syntax) and `cppcod` gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

<wiki:comment> Desired extension: sphinx can utilize a "pycod" or "c++cod" </wiki:comment>
<wiki:comment> instruction as currently done in latex for ptex2tex and write </wiki:comment>
<wiki:comment> out the right code block name accordingly. </wiki:comment>

==== Google Code Wiki ====

There are several different wiki dialects, but Doconce only support the
one used by [http://code.google.com/p/support/wiki/WikiSyntax Google Code].
The transformation to this format, called `gwiki` to explicitly mark
it as the Google Code dialect, is done by
{{{
Unix/DOS> doconce format gwiki mydoc.do.txt
}}}
You can then open a new wiki page for your Google Code project, copy
the `mydoc.gwiki` output file from `doconce format` and paste the
file contents into the wiki page. Press *Preview* or *Save Page* to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).

==== Tweaking the Doconce Output ====

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
`.rst` file is going to be filtered to LaTeX or HTML, it cannot know
if `.eps` or `.png` is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The `make.sh` files in `docs/manual` and `docs/tutorial` 
constitute comprehensive examples on how such scripts can be made.

==== Demos ====

The current text is generated from a Doconce format stored in the file
{{{
docs/tutorial/tutorial.do.txt
}}}
The file `make.sh` in the `tutorial` directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, `tutorial.do.txt` is the
starting point.  Running `make.sh` and studying the various generated
files and comparing them with the original `tutorial.do.txt` file,
gives a quick introduction to how Doconce is used in a real case.
[https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html Here] 
is a sample of how this tutorial looks in different formats.

There is another demo in the `docs/manual` directory which
translates the more comprehensive documentation, `manual.do.txt`, to
various formats. The `make.sh` script runs a set of translations.

==== Dependencies ====

If you make use of preprocessor directives in the Doconce source,
either [http://code.google.com/p/preprocess Preprocess] or [http://www.makotemplates.org Mako] must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need [http://code.google.com/p/ptex2tex ptex2tex] and some style
files that `ptex2tex` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires [http://docutils.sourceforge.net docutils].  Making Sphinx
documents requires of course [http://sphinx.pocoo.org Sphinx].
All of the mentioned potential dependencies are pure Python packages
which are easily installed.



== Warning/Disclaimer ==

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
TITLE: Doconce: Document Once, Include Anywhere
BY: Hans Petter Langtangen (Simula Research Laboratory, and University of Oslo)DATE: today


 - When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?
 - Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.
The Doconce Concept
Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  - Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.
  - Doconce has less cluttered tagging of text.
  - Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.
What Does Doconce Look Like?
Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  - bullet lists arise from lines starting with an asterisk,
  - *emphasized words* are surrounded by asterisks, 
  - **words in boldface** are surrounded by underscores, 
  - words from computer code are enclosed in back quotes and 
    then typeset verbatim,
  - blocks of computer code can easily be included, also from source files,
  - blocks of LaTeX mathematics can easily be included,
  - there is support for both LaTeX and text-like inline mathematics,
  - figures with captions, URLs with links, labels and references
    are supported,
  - comments can be inserted throughout the text,
  - with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,
  - with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format::


        ===== A Subsection with Sample Text =====
        label{my:first:sec}
        
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
        
        URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
        If the word is URL, the URL itself becomes the link name,
        as in "URL":"tutorial.do.txt".
        
        References to sections may use logical names as labels (e.g., a
        "label" command right after the section title), as in the reference to
        Chapter ref{my:first:sec}. 
        
        Doconce also allows inline comments such as [hpl: here I will make
        some remarks to the text] for allowing authors to make notes. Inline
        comments can be removed from the output by a command-line argument
        (see Chapter ref{doconce2formats} for an example).
        
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|
        
        # lines beginning with # are comment lines

The Doconce text above results in the following little document:
A Subsection with Sample Text
Ordinary text looks like ordinary text, and the tags used for
**boldface** words, *emphasized* words, and 'computer' words look
natural in plain text.  Lists are typeset as you would do in an email,

  - item 1
  - item 2
  - item 3

Lists can also have numbered items instead of bullets, just use an 'o'
(for ordered) instead of the asterisk:

 1. item 1
 2. item 2
 3. item 3

URLs with a link word are possible, as in "http://folk.uio.no/hpl":hpl.
If the word is URL, the URL itself becomes the link name,
as in "tutorial.do.txt":tutorial.do.txt.

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter "A Subsection with Sample Text". 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter "From Doconce to Other Formats" for an example).

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
        {\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
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

It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., '!bc xxx'
where 'xxx' is an identifier like 'pycod' for code snippet in Python,
'sys' for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file '.ptext2tex.cfg', while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments)::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

By default, 'pro' and 'cod' are 'python', 'sys' is 'console',
while 'xpro' and 'xcod' are computer language specific for 'x'
in 'f' (Fortran), 'c' (C), 'cpp' (C++), and 'py' (Python).


One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with '!bc pro', while a part of a file is copied into a '!bc cod'
environment. What 'pro' and 'cod' mean is then defined through
a '.ptex2tex.cfg' file for LaTeX and a 'sphinx code-blocks'
comment for Sphinx.

Another document can be included by writing '#include "mynote.do.txt"'
on a line starting with (another) hash sign.  Doconce documents have
extension 'do.txt'. The 'do' part stands for doconce, while the
trailing '.txt' denotes a text document so that editors gives you the
right writing enviroment for plain text.
Macros (Newcommands), Cross-References, Index, and Bibliography
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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the 'docs/manual/manual.do.txt' file (see the
"https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html":demo
page for various formats of this document).
From Doconce to Other Formats
Transformation of a Doconce document to various other
formats applies the script 'doconce format':
!bc   sys
        Unix/DOS> doconce format format mydoc.do.txt

The 'preprocess' program is always used to preprocess the file first,
and options to 'preprocess' can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable 'FORMAT' is always defined as the current format when
running 'preprocess'. That is, in the last example, 'FORMAT' is
defined as 'LaTeX'. Inside the Doconce document one can then perform
format specific actions through tests like '#if FORMAT == "LaTeX"'.

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the 'bin' folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.
HTML
Making an HTML version of a Doconce file 'mydoc.do.txt'
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file 'mydoc.html' can be loaded into any web browser for viewing.
LaTeX
Making a LaTeX file 'mydoc.tex' from 'mydoc.do.txt' is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form 'mydoc.p.tex' for
     'ptex2tex':
!bc   sys
        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files 'newcommands.tex', 'newcommands_keep.tex', or
'newcommands_replace.tex' (see the section "Macros (Newcommands), Cross-References, Index, and Bibliography"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run 'ptex2tex' (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a '.p.tex' file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The 'ptex2tex' tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any '!bc sys' command in the Doconce source you can
insert verbatim block styles as defined in your '.ptex2tex.cfg'
file, e.g., '!bc sys cod' for a code snippet, where 'cod' is set to
a certain environment in '.ptex2tex.cfg' (e.g., 'CodeIntended').
There are over 30 styles to choose from.

*Step 3.* Compile 'mydoc.tex'
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the 'Minted_Python', 'Minted_Cpp', etc., environments
in 'ptex2tex' for typesetting code, the 'minted' LaTeX package is needed.
This package is included by running 'doconce format' with the
'-DMINTED' option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, 'latex' must be run with the
'-shell-escape' option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The '-shell-escape' option is required because the 'minted.sty' style
file runs the 'pygments' program to format code, and this program
cannot be run from 'latex' without the '-shell-escape' option.
Plain ASCII Text
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt

reStructuredText
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file 'mydoc.rst':
!bc   sys
        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the 'tutorial.rst' file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with 'mydoc.rst' in the 'sphinx-rootdir'
directory. Either edit 'mydoc.rst' so that figure file paths are correct,
or simply copy your figure directory to 'sphinx-rootdir' (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows '!bc': 'cod' gives Python
('code-block:: python' in Sphinx syntax) and 'cppcod' gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.
Google Code Wiki
There are several different wiki dialects, but Doconce only support the
one used by "http://code.google.com/p/support/wiki/WikiSyntax":Google Code.
The transformation to this format, called 'gwiki' to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the 'mydoc.gwiki' output file from 'doconce format' and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).
Tweaking the Doconce Output
Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
'.rst' file is going to be filtered to LaTeX or HTML, it cannot know
if '.eps' or '.png' is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The 'make.sh' files in 'docs/manual' and 'docs/tutorial' 
constitute comprehensive examples on how such scripts can be made.
Demos
The current text is generated from a Doconce format stored in the file::


        docs/tutorial/tutorial.do.txt

The file 'make.sh' in the 'tutorial' directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, 'tutorial.do.txt' is the
starting point.  Running 'make.sh' and studying the various generated
files and comparing them with the original 'tutorial.do.txt' file,
gives a quick introduction to how Doconce is used in a real case.
"https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html":Here 
is a sample of how this tutorial looks in different formats.

There is another demo in the 'docs/manual' directory which
translates the more comprehensive documentation, 'manual.do.txt', to
various formats. The 'make.sh' script runs a set of translations.
Dependencies
If you make use of preprocessor directives in the Doconce source,
either "http://code.google.com/p/preprocess":Preprocess or "http://www.makotemplates.org":Mako must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need "http://code.google.com/p/ptex2tex":ptex2tex and some style
files that 'ptex2tex' potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires "http://docutils.sourceforge.net":docutils.  Making Sphinx
documents requires of course "http://sphinx.pocoo.org":Sphinx.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.
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
TITLE: Doconce: Document Once, Include Anywhere
BY: Hans Petter Langtangen (Simula Research Laboratory, and University of Oslo)DATE: today


 - When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?
 - Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  - Doconce can convert to plain I{untagged} text, 
    more desirable for computer programs and email.
  - Doconce has less cluttered tagging of text.
  - Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.


What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  - bullet lists arise from lines starting with an asterisk,
  - I{emphasized words} are surrounded by asterisks, 
  - B{words in boldface} are surrounded by underscores, 
  - words from computer code are enclosed in back quotes and 
    then typeset verbatim,
  - blocks of computer code can easily be included, also from source files,
  - blocks of LaTeX mathematics can easily be included,
  - there is support for both LaTeX and text-like inline mathematics,
  - figures with captions, URLs with links, labels and references
    are supported,
  - comments can be inserted throughout the text,
  - with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,
  - with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format::


        ===== A Subsection with Sample Text =====
        label{my:first:sec}
        
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
        
        URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
        If the word is URL, the URL itself becomes the link name,
        as in "URL":"tutorial.do.txt".
        
        References to sections may use logical names as labels (e.g., a
        "label" command right after the section title), as in the reference to
        Chapter ref{my:first:sec}. 
        
        Doconce also allows inline comments such as [hpl: here I will make
        some remarks to the text] for allowing authors to make notes. Inline
        comments can be removed from the output by a command-line argument
        (see Chapter ref{doconce2formats} for an example).
        
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|
        
        # lines beginning with # are comment lines

The Doconce text above results in the following little document:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
B{boldface} words, I{emphasized} words, and C{computer} words look
natural in plain text.  Lists are typeset as you would do in an email,

  - item 1
  - item 2
  - item 3

Lists can also have numbered items instead of bullets, just use an C{o}
(for ordered) instead of the asterisk:

 1. item 1
 2. item 2
 3. item 3

URLs with a link word are possible, as in U{hpl<http://folk.uio.no/hpl>}.
If the word is URL, the URL itself becomes the link name,
as in U{tutorial.do.txt<tutorial.do.txt>}.

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter "A Subsection with Sample Text". 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter "From Doconce to Other Formats" for an example).

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

It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., C{!bc xxx}
where C{xxx} is an identifier like C{pycod} for code snippet in Python,
C{sys} for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file C{.ptext2tex.cfg}, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments)::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

By default, C{pro} and C{cod} are C{python}, C{sys} is C{console},
while C{xpro} and C{xcod} are computer language specific for C{x}
in C{f} (Fortran), C{c} (C), C{cpp} (C++), and C{py} (Python).


One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with C{!bc pro}, while a part of a file is copied into a C{!bc cod}
environment. What C{pro} and C{cod} mean is then defined through
a C{.ptex2tex.cfg} file for LaTeX and a C{sphinx code-blocks}
comment for Sphinx.

Another document can be included by writing C{#include "mynote.do.txt"}
on a line starting with (another) hash sign.  Doconce documents have
extension C{do.txt}. The C{do} part stands for doconce, while the
trailing C{.txt} denotes a text document so that editors gives you the
right writing enviroment for plain text.


Macros (Newcommands), Cross-References, Index, and Bibliography
---------------------------------------------------------------

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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the C{docs/manual/manual.do.txt} file (see the
U{demo
page<https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html>} for various formats of this document).




From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script C{doconce format}::


        Unix/DOS> doconce format format mydoc.do.txt

The C{preprocess} program is always used to preprocess the file first,
and options to C{preprocess} can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable C{FORMAT} is always defined as the current format when
running C{preprocess}. That is, in the last example, C{FORMAT} is
defined as C{LaTeX}. Inside the Doconce document one can then perform
format specific actions through tests like C{#if FORMAT == "LaTeX"}.

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the C{bin} folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file C{mydoc.do.txt}
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file C{mydoc.html} can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file C{mydoc.tex} from C{mydoc.do.txt} is done in two steps:

I{Step 1.} Filter the doconce text to a pre-LaTeX form C{mydoc.p.tex} for
     C{ptex2tex}::


        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files C{newcommands.tex}, C{newcommands_keep.tex}, or
C{newcommands_replace.tex} (see the section "Macros (Newcommands), Cross-References, Index, and Bibliography"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

I{Step 2.} Run C{ptex2tex} (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a C{.p.tex} file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The C{ptex2tex} tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any C{!bc sys} command in the Doconce source you can
insert verbatim block styles as defined in your C{.ptex2tex.cfg}
file, e.g., C{!bc sys cod} for a code snippet, where C{cod} is set to
a certain environment in C{.ptex2tex.cfg} (e.g., C{CodeIntended}).
There are over 30 styles to choose from.

I{Step 3.} Compile C{mydoc.tex}
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the C{Minted_Python}, C{Minted_Cpp}, etc., environments
in C{ptex2tex} for typesetting code, the C{minted} LaTeX package is needed.
This package is included by running C{doconce format} with the
C{-DMINTED} option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, C{latex} must be run with the
C{-shell-escape} option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The C{-shell-escape} option is required because the C{minted.sty} style
file runs the C{pygments} program to format code, and this program
cannot be run from C{latex} without the C{-shell-escape} option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file C{mydoc.rst}::


        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


I{Step 3.} Move the C{tutorial.rst} file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with C{mydoc.rst} in the C{sphinx-rootdir}
directory. Either edit C{mydoc.rst} so that figure file paths are correct,
or simply copy your figure directory to C{sphinx-rootdir} (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows C{!bc}: C{cod} gives Python
(C{code-block:: python} in Sphinx syntax) and C{cppcod} gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by U{Google Code<http://code.google.com/p/support/wiki/WikiSyntax>}.
The transformation to this format, called C{gwiki} to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the C{mydoc.gwiki} output file from C{doconce format} and paste the
file contents into the wiki page. Press B{Preview} or B{Save Page} to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
C{.rst} file is going to be filtered to LaTeX or HTML, it cannot know
if C{.eps} or C{.png} is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The C{make.sh} files in C{docs/manual} and C{docs/tutorial} 
constitute comprehensive examples on how such scripts can be made.


Demos
-----

The current text is generated from a Doconce format stored in the file::


        docs/tutorial/tutorial.do.txt

The file C{make.sh} in the C{tutorial} directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, C{tutorial.do.txt} is the
starting point.  Running C{make.sh} and studying the various generated
files and comparing them with the original C{tutorial.do.txt} file,
gives a quick introduction to how Doconce is used in a real case.
U{Here<https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html>} 
is a sample of how this tutorial looks in different formats.

There is another demo in the C{docs/manual} directory which
translates the more comprehensive documentation, C{manual.do.txt}, to
various formats. The C{make.sh} script runs a set of translations.

Dependencies
------------

If you make use of preprocessor directives in the Doconce source,
either U{Preprocess<http://code.google.com/p/preprocess>} or U{Mako<http://www.makotemplates.org>} must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need U{ptex2tex<http://code.google.com/p/ptex2tex>} and some style
files that C{ptex2tex} potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires U{docutils<http://docutils.sourceforge.net>}.  Making Sphinx
documents requires of course U{Sphinx<http://sphinx.pocoo.org>}.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


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
Doconce: Document Once, Include Anywhere
========================================

Hans Petter Langtangen [1, 2]

[1] Simula Research Laboratory
[2] University of Oslo


Date: Feb 20, 2011

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, Wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage eventually go
   with a particular format?

 * Do you find it problematic that you have the same information
   scattered around in different documents in different typesetting
   formats? Would it be a good idea to write things once, in one
   place, and include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.

  * Doconce has less cluttered tagging of text.

  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.


What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim,

  * blocks of computer code can easily be included, also from source files,

  * blocks of LaTeX mathematics can easily be included,

  * there is support for both LaTeX and text-like inline mathematics,

  * figures with captions, URLs with links, labels and references
    are supported,

  * comments can be inserted throughout the text,

  * with a simple preprocessor, which is integrated, one can include
    other documents (files) and large portions of text can be defined
    in or out of the text,

  * with the Mako preprocessor one can even embed Python
    code and use this to steer generation of Doconce text.

Here is an example of some simple text written in the Doconce format::


        ===== A Subsection with Sample Text =====
        label{my:first:sec}
        
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
        
        URLs with a link word are possible, as in "hpl":"http://folk.uio.no/hpl".
        If the word is URL, the URL itself becomes the link name,
        as in "URL":"tutorial.do.txt".
        
        References to sections may use logical names as labels (e.g., a
        "label" command right after the section title), as in the reference to
        Chapter ref{my:first:sec}. 
        
        Doconce also allows inline comments such as [hpl: here I will make
        some remarks to the text] for allowing authors to make notes. Inline
        comments can be removed from the output by a command-line argument
        (see Chapter ref{doconce2formats} for an example).
        
        Tables are also supperted, e.g.,
        
          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|
        
        # lines beginning with # are comment lines

The Doconce text above results in the following little document:

A Subsection with Sample Text
-----------------------------

Ordinary text looks like ordinary text, and the tags used for
_boldface_ words, *emphasized* words, and computer words look
natural in plain text.  Lists are typeset as you would do in an email,

  * item 1

  * item 2

  * item 3

Lists can also have numbered items instead of bullets, just use an o
(for ordered) instead of the asterisk:

 1. item 1

 2. item 2

 3. item 3

URLs with a link word are possible, as in hpl (http://folk.uio.no/hpl).
If the word is URL, the URL itself becomes the link name,
as in tutorial.do.txt.

References to sections may use logical names as labels (e.g., a
"label" command right after the section title), as in the reference to
the chapter "A Subsection with Sample Text". 

Doconce also allows inline comments such as [hpl: here I will make
some remarks to the text] for allowing authors to make notes. Inline
comments can be removed from the output by a command-line argument
(see the chapter "From Doconce to Other Formats" for an example).

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
        {\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
        {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g
        \end{eqnarray}

Of course, such blocks only looks nice in LaTeX. The raw
LaTeX syntax appears in all other formats (but can still be useful
for those who can read LaTeX syntax).

You can have blocks of computer code, starting and ending with::


        !bc  cod
        from math import sin, pi
        def myfunc(x):
            return sin(pi*x)
        
        import integrate
        I = integrate.trapezoidal(myfunc, 0, pi, 100)

It is possible to add a specification of a (ptex2tex-style)
environment for typesetting the verbatim code block, e.g., !bc xxx
where xxx is an identifier like pycod for code snippet in Python,
sys for terminal session, etc. When Doconce is filtered to LaTeX,
these identifiers are used as in ptex2tex and defined in a
configuration file .ptext2tex.cfg, while when filtering
to Sphinx, one can have a comment line in the Doconce file for
mapping the identifiers to legal language names for Sphinx (which equals
the legal language names for Pygments)::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

By default, pro and cod are python, sys is console,
while xpro and xcod are computer language specific for x
in f (Fortran), c (C), cpp (C++), and py (Python).


One can also copy computer code directly from files, either the
complete file or specified parts.  Computer code is then never
duplicated in the documentation (important for the principle of
avoiding copying information!). A complete file is typeset 
with !bc pro, while a part of a file is copied into a !bc cod
environment. What pro and cod mean is then defined through
a .ptex2tex.cfg file for LaTeX and a sphinx code-blocks
comment for Sphinx.

Another document can be included by writing #include "mynote.do.txt"
on a line starting with (another) hash sign.  Doconce documents have
extension do.txt. The do part stands for doconce, while the
trailing .txt denotes a text document so that editors gives you the
right writing enviroment for plain text.


Macros (Newcommands), Cross-References, Index, and Bibliography
---------------------------------------------------------------

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

Recent versions of Doconce also offer cross referencing, typically one
can define labels below (sub)sections, in figure captions, or in
equations, and then refer to these later. Entries in an index can be
defined and result in an index at the end for the LaTeX and Sphinx
formats. Citations to literature, with an accompanying bibliography in
a file, are also supported. The syntax of labels, references,
citations, and the bibliography closely resembles that of LaTeX,
making it easy for Doconce documents to be integrated in LaTeX
projects (manuals, books). For further details on functionality and
syntax we refer to the docs/manual/manual.do.txt file (see the
demo
page (https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html) for various formats of this document).




From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script doconce format::


        Unix/DOS> doconce format format mydoc.do.txt

The preprocess program is always used to preprocess the file first,
and options to preprocess can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable FORMAT is always defined as the current format when
running preprocess. That is, in the last example, FORMAT is
defined as LaTeX. Inside the Doconce document one can then perform
format specific actions through tests like #if FORMAT == "LaTeX".

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the bin folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file mydoc.tex from mydoc.do.txt is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form mydoc.p.tex for
     ptex2tex::


        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files newcommands.tex, newcommands_keep.tex, or
newcommands_replace.tex (see the section "Macros (Newcommands), Cross-References, Index, and Bibliography"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ptex2tex (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a .p.tex file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ptex2tex tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any !bc sys command in the Doconce source you can
insert verbatim block styles as defined in your .ptex2tex.cfg
file, e.g., !bc sys cod for a code snippet, where cod is set to
a certain environment in .ptex2tex.cfg (e.g., CodeIntended).
There are over 30 styles to choose from.

*Step 3.* Compile mydoc.tex
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the Minted_Python, Minted_Cpp, etc., environments
in ptex2tex for typesetting code, the minted LaTeX package is needed.
This package is included by running doconce format with the
-DMINTED option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, latex must be run with the
-shell-escape option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The -shell-escape option is required because the minted.sty style
file runs the pygments program to format code, and this program
cannot be run from latex without the -shell-escape option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file mydoc.rst::


        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the tutorial.rst file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with mydoc.rst in the sphinx-rootdir
directory. Either edit mydoc.rst so that figure file paths are correct,
or simply copy your figure directory to sphinx-rootdir (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows !bc: cod gives Python
(code-block:: python in Sphinx syntax) and cppcod gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by Google Code (http://code.google.com/p/support/wiki/WikiSyntax).
The transformation to this format, called gwiki to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the mydoc.gwiki output file from doconce format and paste the
file contents into the wiki page. Press _Preview_ or _Save Page_ to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
.rst file is going to be filtered to LaTeX or HTML, it cannot know
if .eps or .png is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The make.sh files in docs/manual and docs/tutorial 
constitute comprehensive examples on how such scripts can be made.


Demos
-----

The current text is generated from a Doconce format stored in the file::


        docs/tutorial/tutorial.do.txt

The file make.sh in the tutorial directory of the
Doconce source code contains a demo of how to produce a variety of
formats.  The source of this tutorial, tutorial.do.txt is the
starting point.  Running make.sh and studying the various generated
files and comparing them with the original tutorial.do.txt file,
gives a quick introduction to how Doconce is used in a real case.
Here (https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html) 
is a sample of how this tutorial looks in different formats.

There is another demo in the docs/manual directory which
translates the more comprehensive documentation, manual.do.txt, to
various formats. The make.sh script runs a set of translations.

Dependencies
------------

If you make use of preprocessor directives in the Doconce source,
either Preprocess (http://code.google.com/p/preprocess) or Mako (http://www.makotemplates.org) must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need ptex2tex (http://code.google.com/p/ptex2tex) and some style
files that ptex2tex potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires docutils (http://docutils.sourceforge.net).  Making Sphinx
documents requires of course Sphinx (http://sphinx.pocoo.org).
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


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
DATE: Sun, 20 Feb 2011 (22:42)



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
DATE: Sun, 20 Feb 2011 (22:42)



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

<CENTER>Sun, 20 Feb 2011 (22:42)</CENTER>



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

<CENTER>Sun, 20 Feb 2011 (22:42)</CENTER>



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

************** File: make.sh *****************
#!/bin/sh -x
# Compile the Doconce manual, manual.do.txt, in a variety of
# formats to exemplify how different formats may look like.
# This is both a test of Doconce and an example.

./clean.sh

# The following packages must be installed for this script to run: 
# doconce, ptex2tex, docutils, preprocess, sphinx, scitools

d2f="doconce format"
# doconce HTML format:
$d2f HTML manual.do.txt

# Sphinx
$d2f sphinx manual.do.txt
doconce sphinx_dir manual.do.txt
cp manual.rst manual.sphinx.rst
cp manual.rst sphinx-rootdir
# index-sphinx is a ready-made version of index.rst:
cp index-sphinx sphinx-rootdir/index.rst
cp -r figs sphinx-rootdir
# run sphinx:
cd sphinx-rootdir
make clean
make html
make latex
scitools subst '\.\*' '.pdf' _build/latex/DoconceDescription.tex  # .* doesn't work
ln -s `pwd`/../figs _build/latex/figs
cd _build/latex
make clean
# encounter some strange error with labels...
make all-pdf <<EOF
r
EOF
cp DoconceDescription.pdf ../../../manual.sphinx.pdf
cd ../../..


# rst:
$d2f rst manual.do.txt

rst2html.py manual.rst > manual.rst.html
rst2xml.py manual.rst > manual.xml

rst2latex.py manual.rst > manual.rst.tex

# fix figure extension:
# lookahead don't work: scitools subst '(?=includegraphics.+)\.gif' '.ps' manual.rst.tex
scitools subst '\.gif' '' manual.rst.tex   # no extension in graphics file
latex manual.rst.tex   # pdflatex works too
latex manual.rst.tex
dvipdf manual.rst.dvi
rst2newlatex.py manual.rst > manual.rst_new.tex


# plain text:
$d2f plain manual.do.txt remove_inline_comments 

$d2f epytext manual.do.txt
$d2f st manual.do.txt

# doconce LaTeX:
$d2f LaTeX manual.do.txt    # produces ptex2tex: manual.p.tex
ptex2tex -DMINTED manual    # turn ptex2tex format into plain latex
rm -f manual.p.tex
latex -shell-escape manual
latex -shell-escape manual
bibtex manual
makeindex manual
latex -shell-escape manual
latex -shell-escape manual
dvipdf manual.dvi

# Google Code wiki:
$d2f gwiki manual.do.txt

# fix figure in wiki: (can also by done by doconce gwiki_figsubst)
scitools subst "\(the URL of the image file figs/dinoimpact.gif must be inserted here\)" "https://doconce.googlecode.com/hg/trunk/docs/manual/figs/dinoimpact.gif" manual.gwiki

rm -f *.ps

rm -rf demo
mkdir demo
cp -r manual.do.txt manual.html figs manual.tex manual.pdf manual.rst manual.sphinx.rst manual.sphinx.pdf manual.xml manual.rst.html manual.rst.tex manual.rst.pdf manual.gwiki manual.txt manual.epytext manual.st sphinx-rootdir/_build/html demo

cd demo
cat > index.html <<EOF
<HTML><BODY>
<TITLE>Demo of Doconce formats</TITLE>
<H3>Doconce demo</H3>

Doconce is a minimum tagged markup language. The file 
<a href="manual.do.txt">manual.do.txt</a> is the source of
a Doconce Description, written in the Doconce format.
Running
<pre>
doconce format HTML manual.do.txt
</pre>
produces the HTML file <a href="manual.html">manual.html</a>.
Going from Doconce to LaTeX is done by
<pre>
doconce format LaTeX manual.do.txt
</pre>
resulting in the file <a href="manual.tex">manual.tex</a>, which can
be compiled to a PDF file <a href="manual.pdf">manual.pdf</a>
by running <tt>latex</tt> and <tt>dvipdf</tt> the standard way.
<p>
The reStructuredText (reST) format is of particular interest:
<pre>
doconce format rst manual.do.txt
</pre>
The reST file <a href="manual.rst">manual.rst</a> is a starting point
for conversion to many other formats: OpenOffice, 
<a href="manual.xml">XML</a>, <a href="manual.rst.html">HTML</a>,
<a href="manual.rst.tex">LaTeX</a>, 
and from LaTeX to <a href="manual.rst.pdf">PDF</a>.
The <a href="manual.sphinx.rst">Sphinx</a> dialect of reST
can be translated to <a href="manual.sphinx.pdf">PDF</a>
and <a href="html/index.html">HTML</a>.
<p>
Doconce can also be converted to 
<a href="manual.gwiki">a (Google Code) wiki</a>,
<a href="manual.st">Structured Text</a>, 
<a href="manual.epytext">Epytext</a>,
and maybe the most important format of all:
<a href="manual.txt">plain untagged ASCII text</a>.
</BODY>
</HTML>
EOF

cd ..
rm -rf ../demos/manual
cp -r demo ../demos/manual
echo
echo "Go to the demo directory and load index.html into a web browser."




************** File: manual.do.txt *****************
TITLE: Doconce Description
AUTHOR: Hans Petter Langtangen at Simula Research Laboratory and University of Oslo
DATE: today


# lines beginning with # are comment lines


======= What Is Doconce? ======= 
label{what:is:doconce}
idx{doconce!short explanation}

Doconce is two things:

  o Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

  o Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
    

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.
  * Doconce has less cluttered tagging of text.
  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to Section ref{doconce:strategy} to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.


======= Motivation: Problems with Documenting Software =======
idx{doconce!motivation}

__Duplicated Information.__ It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
one motivation for developing the Doconce concept and tool.

__Tagging Issues in Python Documentation.__ A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a "C-style preprocessor tool":
"http://code.google.com/p/preprocess" or the "Mako template system":
"http://www.makotemplates.org/".  Then we can *write once, include
anywhere*!  And what we write is close to plain ASCII text.

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

If you make use of preprocessor directives in the Doconce source,
either "Preprocess": "http://code.google.com/p/preprocess" or "Mako":
"http://www.makotemplates.org" must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need "ptex2tex": "http://code.google.com/p/ptex2tex" and some style
files that `ptex2tex` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires "docutils": "http://docutils.sourceforge.net".  Making Sphinx
documents requires of course "Sphinx": "http://sphinx.pocoo.org".
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


===== The Doconce Software Documentation Strategy ===== 
label{doconce:strategy}

   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use `#include` statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program `doconce` before being
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
in a comment line, say (use triple quotes in the doc string in case
the `doc1` documentation includes code snippets with doc strings
with the usual triple double quotes)
!bc
'''
#    #include "docstrings/doc1.dst.txt
'''
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

!bc sys
# make Epydoc API manual of basename module:
cd docstrings
doconce format epytext doc1.do.txt
mv doc1.epytext doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
epydoc basename

# make Sphinx API manual of basename module:
cd doc
doconce format sphinx doc1.do.txt
mv doc1.rst doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
cd docstrings/sphinx-rootdir  # sphinx directory for API source
make clean
make html
cd ../..

# make ordinary Python module files with doc strings:
cd docstrings
doconce format plain doc1.do.txt
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

idx{demos}

The current text is generated from a Doconce format stored in the
!bc sys
docs/manual/manual.do.txt
!ec
file in the Doconce source code tree. We have made a 
https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html<demo web page>
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file `make.sh` in the same directory as the `manual.do.txt` file
(the current text) shows how to run `doconce format` on the
Doconce file to obtain documents in various formats.

Another demo is found in
!bc sys
docs/tutorial/tutorial.do.txt
!ec
In the `tutorial` directory there is also a `make.sh` file producing a
lot of formats, with a corresponding
https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html<web demo>
of the results.

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

idx{`TITLE` keyword} idx{`AUTHOR` keyword} idx{`DATE` keyword}

Lines starting with `TITLE:`, `AUTHOR:`, and `DATE:` are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax 
!bc
name at institution1 and institution2 and institution3
!ec
The `at` with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the `and` with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple `AUTHOR:` lines. All information
associated with `TITLE:` and `AUTHOR:` keywords must appear on a single
line.  Here is an example:
!bc
TITLE: On an Ultimate Markup Language
AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
AUTHOR: A. Dummy Author
DATE: November 9, 2016
!ec
Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format:
!bc
Hans Petter Langtangen [1, 2]
Kaare Dump [3]
A. Dummy Author 

[1] Center for Biomedical Computing, Simula Research Laboratory
[2] Department of Informatics, University of Oslo
[3] Segfault, Cyberspace Inc.
!ec
Similar typesetting is done for LaTeX and HTML formats.

idx{headlines} idx{section headings}
   
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
The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say `.eps` when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's `convert` utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for `TITLE:` and `AUTHOR:` lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as `FIGURE:` will be
included in the formatted caption).

FIGURE:[figs/dinoimpact, width=400] It can't get worse than this.... label{fig:impact}


Another type of special lines starts with `@@@CODE` and enables copying
of computer code from a file directly into a verbatim environment, see 
Section ref{sec:verbatim:blocks} below.


===== Inline Tagging =====
label{inline:tagging}
idx{inline tagging} idx{emphasized words} idx{boldface words} idx{verbatim text}
idx{inline comments}

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
some URL like "MyPlace": "http://my.place.in.space/src"
!ec
which appears as some URL like "MyPlace": "http://my.place.in.space/src".
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:
!bc
URL:"manual.do.txt"
"URL": "manual.do.txt"
url: "manual.do.txt"
"url":"manual.do.txt"
!ec
All these constructions result in the link URL: "manual.do.txt".
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes:
!bc
Click on this link: URL:"http://some.where.net".
!ec

Doconce also supports inline comments in the text:
!bc
[name: comment]
!ec
where `name` is the name of the author of the command, and `comment` is a 
plain text text. [hpl: Note that there must be a space after the colon,
otherwise the comment is not recognized.]
The name and comment are visible in the output unless `doconce format`
is run with a command-line specification of removing such comments
(see Chapter ref{doconce2formats} for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the `.do.txt` file
(see Chapter ref{doconce2formats}).

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
idx{cross referencing} idx{labels} idx{references}

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
reStructuredText commands by `doconce format`. In the HTML and (Google
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

===== Index and Bibliography =====
idx{index} idx{citations} idx{bibliography}

An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the `idx` keyword, following a LaTeX-inspired syntax:
!bc
idx{some index entry}
idx{main entry!subentry}
idx{`verbatim_text` and more}
!ec
The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to
!bc
\index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}
!ec
Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: `idx` commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style:
!bc
as found in cite{Larsen:86,Nielsen:99}.
!ec
Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding `cite` command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like
!bc
as found in [3][14]
!ec
if `Larsen:86` has already appeared in the 3rd citation in the document
and `Nielsen:99` is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword `BIBFILE:`,
which is optionally followed by a BibTeX file, having extension `.bib`,
a corresponding reStructuredText bibliography, having extension `.rst`,
or simply a Python dictionary written in a file with extension `.py`.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.,
!bc
{
'Nielsen:99': """
K. Nielsen. *Some Comments on Markup Languages*. 
URL:"http://some.where.net/nielsen/comments", 1999.
""",
'Larsen:86': 
"""
O. B. Larsen. On Markup and Generality.
*Personal Press*. 1986.
"""
}
!ec
In the LaTeX format, the `.bib` file will be used in the standard way,
in the reStructuredText and Sphinx formats, the `.rst` file will be
copied into the document at the place where the `BIBFILE:` keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the `BIBFILE:` line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book cite{Python:Primer:09}, a paper cite{Osnes:98},
and both of them simultaneously cite{Python:Primer:09,Osnes:98}.

[somereader: comments, citations, and references in the latex style
is a special feature of doconce :-) ]


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
label{sec:verbatim:blocks}

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" `!bc` keyword and an "end code" `!ec` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the `!bc` tag to specify a
certain `ptex2tex` environment (for instance, `!bc dat` corresponds to
the data file environment in `ptex2tex`, and `!bc cod` is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default `.ptex2tex.cfg`. However, all these arguments
can be redefined in the `.ptex2tex.cfg` file.

The argument after `!bc` is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.,
!bc
# sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console
!ec
Here, three arguments are defined: `pycod` for Python code,
`cod` also for Python code, `cppcod` for C++ code, and `sys`
for terminal sessions. The same arguments would be defined
in `.ptex2tex.cfg` for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, `pro` is used for complete programs in Python, `cod`
is for a code snippet in Python, while `xcod` and `xpro` implies
computer language specific typesetting where `x` can be
`f` for Fortran, `c` for C, `cpp` for C++, and `py` for Python.
The argument `sys` means by default `console` for Sphinx and
`CodeTerminal` (ptex2tex environent) for LaTeX. All these definitions
of the arguments after `!bc` can be redefined in the `.ptex2tex.cfg`
configuration file for ptex2tex/LaTeX and in the `sphinx code-blocks`
comments for Sphinx. Support for other languages is easily added.

# (Any sphinx code-block comment, whether inside verbatim code
# blocks or outside, yields a mapping between bc arguments
# and computer languages. In case of muliple definitions, the
# first one is used.)

The enclosing `!ec` tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code (`pycod` style):
!bc pycod
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
And here is a C++ code snippet (`cppcod` style):
!bc cppcod
void myfunc(double* x, const double& myarr) {
    for (int i = 1; i < myarr.size(); i++) {
        myarr[i] = myarr[i] - x[i]*myarr[i-1]
    }
}
!ec    

Computer code can be copied directly from a file, if desired. The syntax
is then
!bc
 @@@CODE myfile.f
 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1
!ec
The first line implies that all lines in the file `myfile.f` are
copied into a verbatim block, typset in a `!bc pro` environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The `pro` and `cod` arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain `!bc` environment.) Two regular expressions, separated by the
`@` sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching `subroutine test`
(with as many blanks as desired between the two words) and the line
matching `C END1` (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

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

===== Preprocessing Steps =====

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(URL:"http://code.google.com/p/preprocess") and Mako
(URL:"http://www.makotemplates.org/"). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of `name=value` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable `FORMAT` to be the desired
output format of Doconce. It is then easy to test on the value of `FORMAT`
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.


===== Missing Features ===== 

  * Footnotes

===== Troubleshooting =====

__Disclaimer.__ First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running `doconce format`, the reason for the error is most likely a
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

__Code or TeX Block Errors in reST.__
Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a `!bc`, which should
have been removed by `doconce format`, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then `!bc` will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

__Strange Errors Around Code or TeX Blocks in reST.__
If `idx` commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

__Error Message "Undefined substitution..." from reST.__
This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

__Preprocessor Directives Do Not Work.__
Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

__The LaTeX File Does Not Compile.__ 
If the problem is undefined control sequence involving
!bc
\code{...}
!ec
the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

__Verbatim Code Blocks Inside Lists Look Ugly.__ 
Read the Section ref{sec:verbatim:blocks} above.  Start the
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

__Problems with Boldface and Emphasize.__
Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

__Strange Non-English Characters.__
Check the encoding of the `.do.txt` file with the Unix `file` command.
If UTF-8, convert to latin-1 using the Unix command
!bc
Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile
!ec
(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

__Debugging.__
Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
`_doconce_debugging.log`, if the to `doconce format` after the filename
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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted. 

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

The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

    - module variable x: x value (float),
      which must be a positive number.
    - module variable tolerance: tolerance (float) for stopping
      the iterations.

BIBFILE: manual_bib.bib, manual_bib.rst, manual_bib.py


************** File: manual.html *****************
<?xml version="1.0" encoding="utf-8" ?>
<!-- 
Automatically generated HTML file from Doconce source 
(http://code.google.com/p/doconce/) 
-->

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META name="generator" content="Doconce: http://code.google.com/p/doconce/" />
</HEAD>

<BODY BGCOLOR="white">
    <TITLE>Doconce Description</TITLE>
<CENTER><H1>Doconce Description</H1></CENTER>
<CENTER>
<B>Hans Petter Langtangen</B> [1, 2]
</CENTER>

<P>
<CENTER>[1] <B>Simula Research Laboratory</B></CENTER>
<CENTER>[2] <B>University of Oslo</B></CENTER>


<CENTER><H3>Feb 20, 2011</H3></CENTER>
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
 <LI> Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
 <LI> Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
</OL>

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

<P>

<UL>
  <LI> Doconce can convert to plain <EM>untagged</EM> text, 
    more desirable for computer programs and email.
  <LI> Doconce has less cluttered tagging of text.
  <LI> Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  <LI> Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  <LI> Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.
</UL>

Doconce was particularly written for the following sample applications:

<P>

<UL>
  <LI> Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  <LI> Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  <LI> Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.
</UL>

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

<P>
You can jump to the section <A HREF="#doconce:strategy">The Doconce Software Documentation Strategy</a> to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.

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
one motivation for developing the Doconce concept and tool.

<P>
<B>Tagging Issues in Python Documentation.</B> A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).
</OL>

One answer to these points is the Doconce markup language, its
associated tools, and a <A HREF="http://code.google.com/p/preprocess">C-style preprocessor tool</A> or the <A HREF="http://www.makotemplates.org/">Mako template system</A>.  Then we can <EM>write once, include
anywhere</EM>!  And what we write is close to plain ASCII text.

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
If you make use of preprocessor directives in the Doconce source,
either <A HREF="http://code.google.com/p/preprocess">Preprocess</A> or <A HREF="http://www.makotemplates.org">Mako</A> must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need <A HREF="http://code.google.com/p/ptex2tex">ptex2tex</A> and some style
files that <TT>ptex2tex</TT> potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires <A HREF="http://docutils.sourceforge.net">docutils</A>.  Making Sphinx
documents requires of course <A HREF="http://sphinx.pocoo.org">Sphinx</A>.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.

<P>

<P>
<H3>The Doconce Software Documentation Strategy <A NAME="doconce:strategy"></A></H3>
<P>

<P>

<UL>
   <LI> Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   <LI> Use <TT>#include</TT> statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program <TT>doconce</TT> before being
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
in a comment line, say (use triple quotes in the doc string in case
the <TT>doc1</TT> documentation includes code snippets with doc strings
with the usual triple double quotes)
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
'''
#    #include "docstrings/doc1.dst.txt
'''
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

<P>
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
# make Epydoc API manual of basename module:
cd docstrings
doconce format epytext doc1.do.txt
mv doc1.epytext doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
epydoc basename

# make Sphinx API manual of basename module:
cd doc
doconce format sphinx doc1.do.txt
mv doc1.rst doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
cd docstrings/sphinx-rootdir  # sphinx directory for API source
make clean
make html
cd ../..

# make ordinary Python module files with doc strings:
cd docstrings
doconce format plain doc1.do.txt
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

<P>
The current text is generated from a Doconce format stored in the
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
docs/manual/manual.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
file in the Doconce source code tree. We have made a 
<A HREF="https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html">demo web page</A>
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

<P>
The file <TT>make.sh</TT> in the same directory as the <TT>manual.do.txt</TT> file
(the current text) shows how to run <TT>doconce format</TT> on the
Doconce file to obtain documents in various formats.

<P>
Another demo is found in
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
docs/tutorial/tutorial.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In the <TT>tutorial</TT> directory there is also a <TT>make.sh</TT> file producing a
lot of formats, with a corresponding
<A HREF="https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html">web demo</A>
of the results.

<P>
<!-- Example on including another Doconce file: -->

<P>

<P>
<H1>From Doconce to Other Formats <A NAME="doconce2formats"></A></H1>
<P>

<P>
Transformation of a Doconce document to various other
formats applies the script <TT>doconce format</TT>:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format format mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>preprocess</TT> program is always used to preprocess the file first,
and options to <TT>preprocess</TT> can be added after the filename. For example,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The variable <TT>FORMAT</TT> is always defined as the current format when
running <TT>preprocess</TT>. That is, in the last example, <TT>FORMAT</TT> is
defined as <TT>LaTeX</TT>. Inside the Doconce document one can then perform
format specific actions through tests like <TT>#if FORMAT == "LaTeX"</TT>.

<P>
Inline comments in the text are removed from the output by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
One can also remove such comments from the original Doconce file
by running a helper script in the <TT>bin</TT> folder of the Doconce
source code:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce remove_inline_comments mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
This action is convenient when a Doconce document reaches its final form.

<P>

<P>
<H3>HTML</H3>
<P>
Making an HTML version of a Doconce file <TT>mydoc.do.txt</TT>
is performed by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format HTML mydoc.do.txt
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
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format LaTeX mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files <TT>newcommands.tex</TT>, <TT>newcommands_keep.tex</TT>, or
<TT>newcommands_replace.tex</TT> (see the section <A HREF="#newcommands">Macros (Newcommands)</a>). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

<P>
<B>Step 2.</B> Run <TT>ptex2tex</TT> (if you have it) to make a standard LaTeX file,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just perform a plain copy,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> cp mydoc.p.tex mydoc.tex
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Doconce generates a <TT>.p.tex</TT> file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex -DHELVETICA mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The <TT>ptex2tex</TT> tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any <TT>!bc sys</TT> command in the Doconce source you can
insert verbatim block styles as defined in your <TT>.ptex2tex.cfg</TT>
file, e.g., <TT>!bc sys cod</TT> for a code snippet, where <TT>cod</TT> is set to
a certain environment in <TT>.ptex2tex.cfg</TT> (e.g., <TT>CodeIntended</TT>).
There are over 30 styles to choose from.

<P>
<B>Step 3.</B> Compile <TT>mydoc.tex</TT>
and create the PDF file:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> latex mydoc
Unix/DOS> latex mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex mydoc
Unix/DOS> dvipdf mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
If one wishes to use the <TT>Minted_Python</TT>, <TT>Minted_Cpp</TT>, etc., environments
in <TT>ptex2tex</TT> for typesetting code, the <TT>minted</TT> LaTeX package is needed.
This package is included by running <TT>doconce format</TT> with the
<TT>-DMINTED</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> ptex2tex -DMINTED mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In this case, <TT>latex</TT> must be run with the
<TT>-shell-escape</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> dvipdf mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>-shell-escape</TT> option is required because the <TT>minted.sty</TT> style
file runs the <TT>pygments</TT> program to format code, and this program
cannot be run from <TT>latex</TT> without the <TT>-shell-escape</TT> option.

<P>

<P>
<H3>Plain ASCII Text</H3>
<P>
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<H3>reStructuredText</H3>
<P>
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file <TT>mydoc.rst</TT>:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format rst mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
We may now produce various other formats:
<!-- BEGIN VERBATIM BLOCK   sys-->
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
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format sphinx mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 2.</B> Create a Sphinx root directory with a <TT>conf.py</TT> file, 
either manually or by using the interactive <TT>sphinx-quickstart</TT>
program. Here is a scripted version of the steps with the latter:
<!-- BEGIN VERBATIM BLOCK   sys-->
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
These statements are automated by the command
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce sphinx_dir mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<B>Step 3.</B> Move the <TT>tutorial.rst</TT> file to the Sphinx root directory:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> mv mydoc.rst sphinx-rootdir
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
If you have figures in your document, the relative paths to those will
be invalid when you work with <TT>mydoc.rst</TT> in the <TT>sphinx-rootdir</TT>
directory. Either edit <TT>mydoc.rst</TT> so that figure file paths are correct,
or simply copy your figure directory to <TT>sphinx-rootdir</TT> (if all figures
are located in a subdirectory).

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
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
make clean   # remove old versions
make html
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Many other formats are also possible.

<P>
<B>Step 6.</B> View the result:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> firefox _build/html/index.html
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows <TT>!bc</TT>: <TT>cod</TT> gives Python
(<TT>code-block:: python</TT> in Sphinx syntax) and <TT>cppcod</TT> gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

<P>
<!-- Desired extension: sphinx can utilize a "pycod" or "c++cod" -->
<!-- instruction as currently done in latex for ptex2tex and write -->
<!-- out the right code block name accordingly. -->

<P>

<P>
<H3>Google Code Wiki</H3>
<P>
There are several different wiki dialects, but Doconce only support the
one used by <A HREF="http://code.google.com/p/support/wiki/WikiSyntax">Google Code</A>.
The transformation to this format, called <TT>gwiki</TT> to explicitly mark
it as the Google Code dialect, is done by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Unix/DOS> doconce format gwiki mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
You can then open a new wiki page for your Google Code project, copy
the <TT>mydoc.gwiki</TT> output file from <TT>doconce format</TT> and paste the
file contents into the wiki page. Press <B>Preview</B> or <B>Save Page</B> to
see the formatted result.

<P>
When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).

<P>

<P>
<H3>Tweaking the Doconce Output</H3>
<P>
Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
<TT>.rst</TT> file is going to be filtered to LaTeX or HTML, it cannot know
if <TT>.eps</TT> or <TT>.png</TT> is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The <TT>make.sh</TT> files in <TT>docs/manual</TT> and <TT>docs/tutorial</TT> 
constitute comprehensive examples on how such scripts can be made.

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

<P>
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

<P>
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

<P>
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

<P>
Lines starting with <TT>TITLE:</TT>, <TT>AUTHOR:</TT>, and <TT>DATE:</TT> are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax 
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
name at institution1 and institution2 and institution3
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>at</TT> with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the <TT>and</TT> with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple <TT>AUTHOR:</TT> lines. All information
associated with <TT>TITLE:</TT> and <TT>AUTHOR:</TT> keywords must appear on a single
line.  Here is an example:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
TITLE: On an Ultimate Markup Language
AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
AUTHOR: A. Dummy Author
DATE: November 9, 2016
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Hans Petter Langtangen [1, 2]
Kaare Dump [3]
A. Dummy Author 

[1] Center for Biomedical Computing, Simula Research Laboratory
[2] Department of Informatics, University of Oslo
[3] Segfault, Cyberspace Inc.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Similar typesetting is done for LaTeX and HTML formats.

<P>

<P>
Headlines are recognized by being surrounded by equal signs (=) or
underscores before and after the text of the headline. Different
section levels are recognized by the associated number of underscores
or equal signs (=):

<P>

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
The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say <TT>.eps</TT> when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's <TT>convert</TT> utility).

<P>
The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

<P>
Note also that, like for <TT>TITLE:</TT> and <TT>AUTHOR:</TT> lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as <TT>FIGURE:</TT> will be
included in the formatted caption).

<P>
<IMG SRC="figs/dinoimpact.gif" ALIGN="bottom"  width=400> It can't get worse than this.... <A NAME="fig:impact"></A>

<P>

<P>
Another type of special lines starts with <TT>@@@CODE</TT> and enables copying
of computer code from a file directly into a verbatim environment, see 
the section <A HREF="#sec:verbatim:blocks">Blocks of Verbatim Computer Code</a> below.

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
some URL like "MyPlace": "http://my.place.in.space/src"
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
which appears as some URL like <A HREF="http://my.place.in.space/src">MyPlace</A>.
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
URL:"manual.do.txt"
"URL": "manual.do.txt"
url: "manual.do.txt"
"url":"manual.do.txt"
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
All these constructions result in the link <A HREF="manual.do.txt"><TT>manual.do.txt</TT></A>.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Click on this link: URL:"http://some.where.net".
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Doconce also supports inline comments in the text:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
[name: comment]
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
where <TT>name</TT> is the name of the author of the command, and <TT>comment</TT> is a 
plain text text. [<B>hpl</B>: <EM>Note that there must be a space after the colon,
otherwise the comment is not recognized.</EM>]
The name and comment are visible in the output unless <TT>doconce format</TT>
is run with a command-line specification of removing such comments
(see the chapter <A HREF="#doconce2formats">From Doconce to Other Formats</a> for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the <TT>.do.txt</TT> file
(see the chapter <A HREF="#doconce2formats">From Doconce to Other Formats</a>).

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
reStructuredText commands by <TT>doconce format</TT>. In the HTML and (Google
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
<H3>Index and Bibliography</H3>
<P>
An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the <TT>idx</TT> keyword, following a LaTeX-inspired syntax:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
idx{some index entry}
idx{main entry!subentry}
idx{`verbatim_text` and more}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
\index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: <TT>idx</TT> commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

<P>
Literature citations also follow a LaTeX-inspired style:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
as found in cite{Larsen:86,Nielsen:99}.
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding <TT>cite</TT> command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
as found in [3][14]
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
if <TT>Larsen:86</TT> has already appeared in the 3rd citation in the document
and <TT>Nielsen:99</TT> is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

<P>
The bibliography itself is specified by the special keyword <TT>BIBFILE:</TT>,
which is optionally followed by a BibTeX file, having extension <TT>.bib</TT>,
a corresponding reStructuredText bibliography, having extension <TT>.rst</TT>,
or simply a Python dictionary written in a file with extension <TT>.py</TT>.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.,
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
{
'Nielsen:99': """
K. Nielsen. *Some Comments on Markup Languages*. 
URL:"http://some.where.net/nielsen/comments", 1999.
""",
'Larsen:86': 
"""
O. B. Larsen. On Markup and Generality.
*Personal Press*. 1986.
"""
}
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In the LaTeX format, the <TT>.bib</TT> file will be used in the standard way,
in the reStructuredText and Sphinx formats, the <TT>.rst</TT> file will be
copied into the document at the place where the <TT>BIBFILE:</TT> keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the <TT>BIBFILE:</TT> line
in the document.

<P>
Finally, we must test the citation command and bibliography by 
citing a book <A HREF="#Python:Primer:09">[1]</A>, a paper <A HREF="#Osnes:98">[2]</A>,
and both of them simultaneously <A HREF="#Python:Primer:09">[1]</A> <A HREF="#Osnes:98">[2]</A>.

<P>
[<B>somereader</B>: <EM>comments, citations, and references in the latex style
is a special feature of doconce :-) </EM>]

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
<H3>Blocks of Verbatim Computer Code <A NAME="sec:verbatim:blocks"></A></H3>
<P>

<P>
Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" <TT>!bc</TT> keyword and an "end code" <TT>!ec</TT> keyword. Both
keywords must be on a single line and <EM>start at the beginning of the
line</EM>.  There may be an argument after the <TT>!bc</TT> tag to specify a
certain <TT>ptex2tex</TT> environment (for instance, <TT>!bc dat</TT> corresponds to
the data file environment in <TT>ptex2tex</TT>, and <TT>!bc cod</TT> is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default <TT>.ptex2tex.cfg</TT>. However, all these arguments
can be redefined in the <TT>.ptex2tex.cfg</TT> file.

<P>
The argument after <TT>!bc</TT> is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.,
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
# sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Here, three arguments are defined: <TT>pycod</TT> for Python code,
<TT>cod</TT> also for Python code, <TT>cppcod</TT> for C++ code, and <TT>sys</TT>
for terminal sessions. The same arguments would be defined
in <TT>.ptex2tex.cfg</TT> for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

<P>
By default, <TT>pro</TT> is used for complete programs in Python, <TT>cod</TT>
is for a code snippet in Python, while <TT>xcod</TT> and <TT>xpro</TT> implies
computer language specific typesetting where <TT>x</TT> can be
<TT>f</TT> for Fortran, <TT>c</TT> for C, <TT>cpp</TT> for C++, and <TT>py</TT> for Python.
The argument <TT>sys</TT> means by default <TT>console</TT> for Sphinx and
<TT>CodeTerminal</TT> (ptex2tex environent) for LaTeX. All these definitions
of the arguments after <TT>!bc</TT> can be redefined in the <TT>.ptex2tex.cfg</TT>
configuration file for ptex2tex/LaTeX and in the <TT>sphinx code-blocks</TT>
comments for Sphinx. Support for other languages is easily added.

<P>
<!-- (Any sphinx code-block comment, whether inside verbatim code -->
<!-- blocks or outside, yields a mapping between bc arguments -->
<!-- and computer languages. In case of muliple definitions, the -->
<!-- first one is used.) -->

<P>
The enclosing <TT>!ec</TT> tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

<P>
Here is a verbatim code block with Python code (<TT>pycod</TT> style):
<!-- BEGIN VERBATIM BLOCK   pycod-->
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
And here is a C++ code snippet (<TT>cppcod</TT> style):
<!-- BEGIN VERBATIM BLOCK   cppcod-->
<BLOCKQUOTE><PRE>
void myfunc(double* x, const double& myarr) {
    for (int i = 1; i < myarr.size(); i++) {
        myarr[i] = myarr[i] - x[i]*myarr[i-1]
    }
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
The first line implies that all lines in the file <TT>myfile.f</TT> are
copied into a verbatim block, typset in a <TT>!bc pro</TT> environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The <TT>pro</TT> and <TT>cod</TT> arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain <TT>!bc</TT> environment.) Two regular expressions, separated by the
<TT>@</TT> sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching <TT>subroutine test</TT>
(with as many blanks as desired between the two words) and the line
matching <TT>C END1</TT> (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

<P>
Let us copy a whole file (the first line above):

<P>
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

<P>
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

<P>
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

<P>
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
<H3>Preprocessing Steps</H3>
<P>
Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(<A HREF="http://code.google.com/p/preprocess"><TT>http://code.google.com/p/preprocess</TT></A>) and Mako
(<A HREF="http://www.makotemplates.org/"><TT>http://www.makotemplates.org/</TT></A>). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of <TT>name=value</TT> command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

<P>
Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

<P>
Preprocess and Mako always have the variable <TT>FORMAT</TT> to be the desired
output format of Doconce. It is then easy to test on the value of <TT>FORMAT</TT>
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.

<P>

<P>
<H3>Missing Features</H3>
<P>

<UL>
  <LI> Footnotes
</UL>
<H3>Troubleshooting</H3>
<P>
<B>Disclaimer.</B> First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running <TT>doconce format</TT>, the reason for the error is most likely a
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
<B>Code or TeX Block Errors in reST.</B> Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a <TT>!bc</TT>, which should
have been removed by <TT>doconce format</TT>, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then <TT>!bc</TT> will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

<P>
<B>Strange Errors Around Code or TeX Blocks in reST.</B> If <TT>idx</TT> commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

<P>
<B>Error Message "Undefined substitution..." from reST.</B> This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

<P>
<B>Preprocessor Directives Do Not Work.</B> Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

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
<B>Verbatim Code Blocks Inside Lists Look Ugly.</B> Read the the section <A HREF="#sec:verbatim:blocks">Blocks of Verbatim Computer Code</a> above.  Start the
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
<B>Problems with Boldface and Emphasize.</B> Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

<P>
<B>Strange Non-English Characters.</B> Check the encoding of the <TT>.do.txt</TT> file with the Unix <TT>file</TT> command.
If UTF-8, convert to latin-1 using the Unix command
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

<P>
<B>Debugging.</B> Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
<TT>_doconce_debugging.log</TT>, if the to <TT>doconce format</TT> after the filename
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

<P>
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

<P>

<P>
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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted. 

<P>
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
The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

<P>

<DL>
    <DT><B>module variable</B> x:<DD> 
      x value (float),
      which must be a positive number.
    <DT><B>module variable</B> tolerance:<DD> 
      tolerance (float) for stopping
      the iterations.
</DL>

<H1>Bibliography</H1>

<P>
<OL>
  <P><LI><A NAME="Python:Primer:09">  H. P. Langtangen. <EM>A Primer on Scientific Programming with Python</EM>. Springer, 2009.
  <P><LI><A NAME="Osnes:98">  H. Osnes and H. P. Langtangen. An efficient probabilistic finite element method for stochastic  groundwater flow. <EM>Advances in Water Resources</EM>, vol 22, 185-195, 1998.
</OL>

<P>

<P>

</BODY>
</HTML>
    
************** File: manual.p.tex *****************
NOT FOUND!
************** File: manual.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)

Doconce Description
===================

:Author: Hans Petter Langtangen

:Date: Feb 20, 2011

.. lines beginning with # are comment lines


.. _what:is:doconce:

What Is Doconce?
================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.

  * Doconce has less cluttered tagging of text.

  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to the section `The Doconce Software Documentation Strategy`_ to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.


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
one motivation for developing the Doconce concept and tool.

*Tagging Issues in Python Documentation.* A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a `C-style preprocessor tool <http://code.google.com/p/preprocess>`_ or the `Mako template system <http://www.makotemplates.org/>`_.  Then we can *write once, include
anywhere*!  And what we write is close to plain ASCII text.

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

If you make use of preprocessor directives in the Doconce source,
either `Preprocess <http://code.google.com/p/preprocess>`_ or `Mako <http://www.makotemplates.org>`_ must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need `ptex2tex <http://code.google.com/p/ptex2tex>`_ and some style
files that ``ptex2tex`` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires `docutils <http://docutils.sourceforge.net>`_.  Making Sphinx
documents requires of course `Sphinx <http://sphinx.pocoo.org>`_.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


.. _doconce:strategy:

The Doconce Software Documentation Strategy
-------------------------------------------

   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use ``#include`` statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program ``doconce`` before being
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
in a comment line, say (use triple quotes in the doc string in case
the ``doc1`` documentation includes code snippets with doc strings
with the usual triple double quotes)::


        '''
        #    #include "docstrings/doc1.dst.txt
        '''


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
        doconce format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce format plain doc1.do.txt
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


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
`demo web page <https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html>`_
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file ``make.sh`` in the same directory as the ``manual.do.txt`` file
(the current text) shows how to run ``doconce format`` on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the ``tutorial`` directory there is also a ``make.sh`` file producing a
lot of formats, with a corresponding
`web demo <https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html>`_
of the results.

.. Example on including another Doconce file:


.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script ``doconce format``::


        Unix/DOS> doconce format format mydoc.do.txt

The ``preprocess`` program is always used to preprocess the file first,
and options to ``preprocess`` can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the ``bin`` folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many
.. formats - the text may be messed up. A better choice is a paragraph
.. environment, as used here.

*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``::


        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section `Macros (Newcommands)`_). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any ``!bc sys`` command in the Doconce source you can
insert verbatim block styles as defined in your ``.ptex2tex.cfg``
file, e.g., ``!bc sys cod`` for a code snippet, where ``cod`` is set to
a certain environment in ``.ptex2tex.cfg`` (e.g., ``CodeIntended``).
There are over 30 styles to choose from.

*Step 3.* Compile ``mydoc.tex``
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``::


        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with ``mydoc.rst`` in the ``sphinx-rootdir``
directory. Either edit ``mydoc.rst`` so that figure file paths are correct,
or simply copy your figure directory to ``sphinx-rootdir`` (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows ``!bc``: ``cod`` gives Python
(``code-block:: python`` in Sphinx syntax) and ``cppcod`` gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

.. Desired extension: sphinx can utilize a "pycod" or "c++cod"
.. instruction as currently done in latex for ptex2tex and write
.. out the right code block name accordingly.


Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by `Google Code <http://code.google.com/p/support/wiki/WikiSyntax>`_.
The transformation to this format, called ``gwiki`` to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the ``mydoc.gwiki`` output file from ``doconce format`` and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
``.rst`` file is going to be filtered to LaTeX or HTML, it cannot know
if ``.eps`` or ``.png`` is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The ``make.sh`` files in ``docs/manual`` and ``docs/tutorial`` 
constitute comprehensive examples on how such scripts can be made.



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


Lines starting with ``TITLE:``, ``AUTHOR:``, and ``DATE:`` are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax::


        name at institution1 and institution2 and institution3

The ``at`` with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the ``and`` with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple ``AUTHOR:`` lines. All information
associated with ``TITLE:`` and ``AUTHOR:`` keywords must appear on a single
line.  Here is an example::


        TITLE: On an Ultimate Markup Language
        AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        AUTHOR: A. Dummy Author
        DATE: November 9, 2016

Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format::


        Hans Petter Langtangen [1, 2]
        Kaare Dump [3]
        A. Dummy Author 
        
        [1] Center for Biomedical Computing, Simula Research Laboratory
        [2] Department of Informatics, University of Oslo
        [3] Segfault, Cyberspace Inc.

Similar typesetting is done for LaTeX and HTML formats.


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

The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say ``.eps`` when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's ``convert`` utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for ``TITLE:`` and ``AUTHOR:`` lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as ``FIGURE:`` will be
included in the formatted caption).


.. _fig:impact:

.. figure:: figs/dinoimpact.ps
   :width: 400

   It can't get worse than this...  (fig:impact)



Another type of special lines starts with ``@@@CODE`` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section `Blocks of Verbatim Computer Code`_ below.


.. _inline:tagging:

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


        some URL like "MyPlace": "http://my.place.in.space/src"

which appears as some URL like `MyPlace <http://my.place.in.space/src>`_.
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::


        URL:"manual.do.txt"
        "URL": "manual.do.txt"
        url: "manual.do.txt"
        "url":"manual.do.txt"

All these constructions result in the link `<manual.do.txt>`_.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes::


        Click on this link: URL:"http://some.where.net".


Doconce also supports inline comments in the text::


        [name: comment]

where ``name`` is the name of the author of the command, and ``comment`` is a 
plain text text. (**hpl**: Note that there must be a space after the colon,
otherwise the comment is not recognized.)
The name and comment are visible in the output unless ``doconce format``
is run with a command-line specification of removing such comments
(see the chapter `From Doconce to Other Formats`_ for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the ``.do.txt`` file
(see the chapter `From Doconce to Other Formats`_).

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
reStructuredText commands by ``doconce format``. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure `fig:impact`_
(the label appears in the figure caption in the source code of this document).
Additional references to the sections `LaTeX Blocks of Mathematical Text`_ and `Macros (Newcommands)`_ are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section `Inline Tagging`_.

Index and Bibliography
----------------------

An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the ``idx`` keyword, following a LaTeX-inspired syntax::


        idx{some index entry}
        idx{main entry!subentry}
        idx{`verbatim_text` and more}

The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to::


        \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}

Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: ``idx`` commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style::


        as found in cite{Larsen:86,Nielsen:99}.

Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding ``cite`` command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like::


        as found in [3][14]

if ``Larsen:86`` has already appeared in the 3rd citation in the document
and ``Nielsen:99`` is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword ``BIBFILE:``,
which is optionally followed by a BibTeX file, having extension ``.bib``,
a corresponding reStructuredText bibliography, having extension ``.rst``,
or simply a Python dictionary written in a file with extension ``.py``.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.::


        {
        'Nielsen:99': """
        K. Nielsen. *Some Comments on Markup Languages*. 
        URL:"http://some.where.net/nielsen/comments", 1999.
        """,
        'Larsen:86': 
        """
        O. B. Larsen. On Markup and Generality.
        *Personal Press*. 1986.
        """
        }

In the LaTeX format, the ``.bib`` file will be used in the standard way,
in the reStructuredText and Sphinx formats, the ``.rst`` file will be
copied into the document at the place where the ``BIBFILE:`` keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the ``BIBFILE:`` line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book [Python:Primer:09]_, a paper [Osnes:98]_,
and both of them simultaneously [Python:Primer:09]_ [Osnes:98]_.

(**somereader**: comments, citations, and references in the latex style
is a special feature of doconce :-) )


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


.. _sec:verbatim:blocks:

Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" ``!bc`` keyword and an "end code" ``!ec`` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the ``!bc`` tag to specify a
certain ``ptex2tex`` environment (for instance, ``!bc dat`` corresponds to
the data file environment in ``ptex2tex``, and ``!bc cod`` is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default ``.ptex2tex.cfg``. However, all these arguments
can be redefined in the ``.ptex2tex.cfg`` file.

The argument after ``!bc`` is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

Here, three arguments are defined: ``pycod`` for Python code,
``cod`` also for Python code, ``cppcod`` for C++ code, and ``sys``
for terminal sessions. The same arguments would be defined
in ``.ptex2tex.cfg`` for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, ``pro`` is used for complete programs in Python, ``cod``
is for a code snippet in Python, while ``xcod`` and ``xpro`` implies
computer language specific typesetting where ``x`` can be
``f`` for Fortran, ``c`` for C, ``cpp`` for C++, and ``py`` for Python.
The argument ``sys`` means by default ``console`` for Sphinx and
``CodeTerminal`` (ptex2tex environent) for LaTeX. All these definitions
of the arguments after ``!bc`` can be redefined in the ``.ptex2tex.cfg``
configuration file for ptex2tex/LaTeX and in the ``sphinx code-blocks``
comments for Sphinx. Support for other languages is easily added.

.. (Any sphinx code-block comment, whether inside verbatim code
.. blocks or outside, yields a mapping between bc arguments
.. and computer languages. In case of muliple definitions, the
.. first one is used.)

The enclosing ``!ec`` tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code (``pycod`` style)::


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

And here is a C++ code snippet (``cppcod`` style)::


        void myfunc(double* x, const double& myarr) {
            for (int i = 1; i < myarr.size(); i++) {
                myarr[i] = myarr[i] - x[i]*myarr[i-1]
            }
        }


Computer code can be copied directly from a file, if desired. The syntax
is then::


         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1

The first line implies that all lines in the file ``myfile.f`` are
copied into a verbatim block, typset in a ``!bc pro`` environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The ``pro`` and ``cod`` arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain ``!bc`` environment.) Two regular expressions, separated by the
``@`` sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching ``subroutine test``
(with as many blanks as desired between the two words) and the line
matching ``C END1`` (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

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


.. _mathtext:

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

.. _newcommands:

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

Preprocessing Steps
-------------------

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(`<http://code.google.com/p/preprocess>`_) and Mako
(`<http://www.makotemplates.org/>`_). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of ``name=value`` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable ``FORMAT`` to be the desired
output format of Doconce. It is then easy to test on the value of ``FORMAT``
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.


Missing Features
----------------

  * Footnotes

Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running ``doconce format``, the reason for the error is most likely a
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

*Code or TeX Block Errors in reST.* Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a ``!bc``, which should
have been removed by ``doconce format``, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then ``!bc`` will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

*Strange Errors Around Code or TeX Blocks in reST.* If ``idx`` commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

*Error Message "Undefined substitution..." from reST.* This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

*Preprocessor Directives Do Not Work.* Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::


        \code{...}

the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the the section `Blocks of Verbatim Computer Code`_ above.  Start the
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

*Problems with Boldface and Emphasize.* Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

*Strange Non-English Characters.* Check the encoding of the ``.do.txt`` file with the Unix ``file`` command.
If UTF-8, convert to latin-1 using the Unix command::


        Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile

(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
``_doconce_debugging.log``, if the to ``doconce format`` after the filename
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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted::


            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).


The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

    module variable x: 
      x value (float),
      which must be a positive number.

    module variable tolerance: 
      tolerance (float) for stopping
      the iterations.

.. [Python:Primer:09] H. P. Langtangen.
   *A Primer on Scientific Programming with Python*.
   Springer, 2009.

.. [Osnes:98] H. Osnes and H. P. Langtangen.
   An efficient probabilistic finite element method for stochastic 
   groundwater flow.
   *Advances in Water Resources*, vol 22, 185-195, 1998.
************** File: manual.sphinx.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)

Doconce Description
===================

:Author: Hans Petter Langtangen

:Date: Feb 20, 2011

.. lines beginning with # are comment lines


.. _what:is:doconce:

What Is Doconce?
================

.. index::
   pair: doconce; short explanation


Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.

  * Doconce has less cluttered tagging of text.

  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to the section :ref:`doconce:strategy` to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.


Motivation: Problems with Documenting Software
==============================================

.. index::
   pair: doconce; motivation


*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
one motivation for developing the Doconce concept and tool.

*Tagging Issues in Python Documentation.* A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a `C-style preprocessor tool <http://code.google.com/p/preprocess>`_ or the `Mako template system <http://www.makotemplates.org/>`_.  Then we can *write once, include
anywhere*!  And what we write is close to plain ASCII text.

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

If you make use of preprocessor directives in the Doconce source,
either `Preprocess <http://code.google.com/p/preprocess>`_ or `Mako <http://www.makotemplates.org>`_ must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need `ptex2tex <http://code.google.com/p/ptex2tex>`_ and some style
files that ``ptex2tex`` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires `docutils <http://docutils.sourceforge.net>`_.  Making Sphinx
documents requires of course `Sphinx <http://sphinx.pocoo.org>`_.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


.. _doconce:strategy:

The Doconce Software Documentation Strategy
-------------------------------------------

   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use ``#include`` statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program ``doconce`` before being
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
in a comment line, say (use triple quotes in the doc string in case
the ``doc1`` documentation includes code snippets with doc strings
with the usual triple double quotes)

.. code-block:: py


        '''
        #    #include "docstrings/doc1.dst.txt
        '''


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


.. code-block:: console

        # make Epydoc API manual of basename module:
        cd docstrings
        doconce format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce format plain doc1.do.txt
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


.. index:: demos


The current text is generated from a Doconce format stored in the

.. code-block:: console

        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
`demo web page <https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html>`_
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file ``make.sh`` in the same directory as the ``manual.do.txt`` file
(the current text) shows how to run ``doconce format`` on the
Doconce file to obtain documents in various formats.

Another demo is found in

.. code-block:: console

        docs/tutorial/tutorial.do.txt

In the ``tutorial`` directory there is also a ``make.sh`` file producing a
lot of formats, with a corresponding
`web demo <https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html>`_
of the results.

.. Example on including another Doconce file:


.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script ``doconce format``:

.. code-block:: console

        Unix/DOS> doconce format format mydoc.do.txt

The ``preprocess`` program is always used to preprocess the file first,
and options to ``preprocess`` can be added after the filename. For example,

.. code-block:: console

        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by

.. code-block:: console

        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the ``bin`` folder of the Doconce
source code:

.. code-block:: py


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by

.. code-block:: console

        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many
.. formats - the text may be messed up. A better choice is a paragraph
.. environment, as used here.

*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``:

.. code-block:: console

        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section :ref:`newcommands`). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file,

.. code-block:: console

        Unix/DOS> ptex2tex mydoc

or just perform a plain copy,

.. code-block:: console

        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font,

.. code-block:: console

        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through

.. code-block:: console

        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any ``!bc sys`` command in the Doconce source you can
insert verbatim block styles as defined in your ``.ptex2tex.cfg``
file, e.g., ``!bc sys cod`` for a code snippet, where ``cod`` is set to
a certain environment in ``.ptex2tex.cfg`` (e.g., ``CodeIntended``).
There are over 30 styles to choose from.

*Step 3.* Compile ``mydoc.tex``
and create the PDF file:

.. code-block:: console

        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option:

.. code-block:: console

        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option:

.. code-block:: console

        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:

.. code-block:: console

        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``:

.. code-block:: console

        Unix/DOS> doconce format rst mydoc.do.txt

We may now produce various other formats:

.. code-block:: console

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

.. code-block:: console

        Unix/DOS> doconce format sphinx mydoc.do.txt


*Step 2.* Create a Sphinx root directory with a ``conf.py`` file, 
either manually or by using the interactive ``sphinx-quickstart``
program. Here is a scripted version of the steps with the latter:

.. code-block:: console

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

These statements are automated by the command

.. code-block:: console

        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory:

.. code-block:: console

        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with ``mydoc.rst`` in the ``sphinx-rootdir``
directory. Either edit ``mydoc.rst`` so that figure file paths are correct,
or simply copy your figure directory to ``sphinx-rootdir`` (if all figures
are located in a subdirectory).

*Step 4.* Edit the generated ``index.rst`` file so that ``mydoc.rst``
is included, i.e., add ``mydoc`` to the ``toctree`` section so that it becomes

.. code-block:: py


        .. toctree::
           :maxdepth: 2
        
           mydoc

(The spaces before ``mydoc`` are important!)

*Step 5.* Generate, for instance, an HTML version of the Sphinx source:

.. code-block:: console

        make clean   # remove old versions
        make html

Many other formats are also possible.

*Step 6.* View the result:

.. code-block:: console

        Unix/DOS> firefox _build/html/index.html


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows ``!bc``: ``cod`` gives Python
(``code-block:: python`` in Sphinx syntax) and ``cppcod`` gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

.. Desired extension: sphinx can utilize a "pycod" or "c++cod"
.. instruction as currently done in latex for ptex2tex and write
.. out the right code block name accordingly.


Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by `Google Code <http://code.google.com/p/support/wiki/WikiSyntax>`_.
The transformation to this format, called ``gwiki`` to explicitly mark
it as the Google Code dialect, is done by

.. code-block:: console

        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the ``mydoc.gwiki`` output file from ``doconce format`` and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
``.rst`` file is going to be filtered to LaTeX or HTML, it cannot know
if ``.eps`` or ``.png`` is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The ``make.sh`` files in ``docs/manual`` and ``docs/tutorial`` 
constitute comprehensive examples on how such scripts can be made.



The Doconce Markup Language
===========================

The Doconce format introduces four constructs to markup text:
lists, special lines, inline tags, and environments.

Lists
-----

An unordered bullet list makes use of the ``*`` as bullet sign
and is indented as follows


.. code-block:: py


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


.. code-block:: py


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


.. code-block:: py


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


.. index:: TITLE keyword

.. index:: AUTHOR keyword

.. index:: DATE keyword


Lines starting with ``TITLE:``, ``AUTHOR:``, and ``DATE:`` are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax 

.. code-block:: py


        name at institution1 and institution2 and institution3

The ``at`` with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the ``and`` with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple ``AUTHOR:`` lines. All information
associated with ``TITLE:`` and ``AUTHOR:`` keywords must appear on a single
line.  Here is an example:

.. code-block:: py


        TITLE: On an Ultimate Markup Language
        AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        AUTHOR: A. Dummy Author
        DATE: November 9, 2016

Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format:

.. code-block:: py


        Hans Petter Langtangen [1, 2]
        Kaare Dump [3]
        A. Dummy Author 
        
        [1] Center for Biomedical Computing, Simula Research Laboratory
        [2] Department of Informatics, University of Oslo
        [3] Segfault, Cyberspace Inc.

Similar typesetting is done for LaTeX and HTML formats.


.. index:: headlines

.. index:: section headings


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

.. code-block:: py


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

.. code-block:: py


        FIGURE:[filename, height=xxx width=yyy scale=zzz] caption

The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say ``.eps`` when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's ``convert`` utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for ``TITLE:`` and ``AUTHOR:`` lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as ``FIGURE:`` will be
included in the formatted caption).


.. _fig:impact:

.. figure:: figs/dinoimpact.gif
   :width: 400

   It can't get worse than this...  



Another type of special lines starts with ``@@@CODE`` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section :ref:`sec:verbatim:blocks` below.


.. _inline:tagging:

Inline Tagging
--------------

.. index:: inline tagging

.. index:: emphasized words

.. index:: boldface words

.. index:: verbatim text


.. index:: inline comments


Doconce supports tags for *emphasized phrases*, **boldface phrases**,
and ``verbatim text`` (also called type writer text, for inline code)
plus LaTeX/TeX inline mathematics, such as :math:`\nu = \sin(x)`.

Emphasized text is typeset inside a pair of asterisk, and there should
be no spaces between an asterisk and the emphasized text, as in

.. code-block:: py


        *emphasized words*


Boldface font is recognized by an underscore instead of an asterisk:

.. code-block:: py


        _several words in boldface_ followed by *ephasized text*.

The line above gets typeset as
**several words in boldface** followed by *ephasized text*.

Verbatim text, typically used for short inline code,
is typeset between backquotes:

.. code-block:: py


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

.. code-block:: py


        some URL like "MyPlace": "http://my.place.in.space/src"

which appears as some URL like `MyPlace <http://my.place.in.space/src>`_.
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:

.. code-block:: py


        URL:"manual.do.txt"
        "URL": "manual.do.txt"
        url: "manual.do.txt"
        "url":"manual.do.txt"

All these constructions result in the link `<manual.do.txt>`_.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes:

.. code-block:: py


        Click on this link: URL:"http://some.where.net".


Doconce also supports inline comments in the text:

.. code-block:: py


        [name: comment]

where ``name`` is the name of the author of the command, and ``comment`` is a 
plain text text. (**hpl**: Note that there must be a space after the colon,
otherwise the comment is not recognized.)
The name and comment are visible in the output unless ``doconce format``
is run with a command-line specification of removing such comments
(see the chapter :ref:`doconce2formats` for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the ``.do.txt`` file
(see the chapter :ref:`doconce2formats`).

Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII:

.. code-block:: py


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

.. index:: cross referencing

.. index:: labels

.. index:: references


References and labels are supported. The syntax is simple:

.. code-block:: py


        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.

This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by ``doconce format``. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure :ref:`fig:impact`
(the label appears in the figure caption in the source code of this document).
Additional references to the sections :ref:`mathtext` and :ref:`newcommands` are
nice to demonstrate, as well as a reference to equations,
say (:ref:`my:eq1`)--(:ref:`my:eq2`). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section :ref:`inline:tagging`.

Index and Bibliography
----------------------

.. index:: index

.. index:: citations

.. index:: bibliography


An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the ``idx`` keyword, following a LaTeX-inspired syntax:

.. code-block:: py


        idx{some index entry}
        idx{main entry!subentry}
        idx{`verbatim_text` and more}

The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to

.. code-block:: py


        \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}

Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: ``idx`` commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style:

.. code-block:: py


        as found in cite{Larsen:86,Nielsen:99}.

Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding ``cite`` command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like

.. code-block:: py


        as found in [3][14]

if ``Larsen:86`` has already appeared in the 3rd citation in the document
and ``Nielsen:99`` is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword ``BIBFILE:``,
which is optionally followed by a BibTeX file, having extension ``.bib``,
a corresponding reStructuredText bibliography, having extension ``.rst``,
or simply a Python dictionary written in a file with extension ``.py``.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.,

.. code-block:: py


        {
        'Nielsen:99': """
        K. Nielsen. *Some Comments on Markup Languages*. 
        URL:"http://some.where.net/nielsen/comments", 1999.
        """,
        'Larsen:86': 
        """
        O. B. Larsen. On Markup and Generality.
        *Personal Press*. 1986.
        """
        }

In the LaTeX format, the ``.bib`` file will be used in the standard way,
in the reStructuredText and Sphinx formats, the ``.rst`` file will be
copied into the document at the place where the ``BIBFILE:`` keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the ``BIBFILE:`` line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book [Python:Primer:09]_, a paper [Osnes:98]_,
and both of them simultaneously [Python:Primer:09]_ [Osnes:98]_.

(**somereader**: comments, citations, and references in the latex style
is a special feature of doconce :-) )


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

.. code-block:: py


          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|

The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


.. _sec:verbatim:blocks:

Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" ``!bc`` keyword and an "end code" ``!ec`` keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the ``!bc`` tag to specify a
certain ``ptex2tex`` environment (for instance, ``!bc dat`` corresponds to
the data file environment in ``ptex2tex``, and ``!bc cod`` is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default ``.ptex2tex.cfg``. However, all these arguments
can be redefined in the ``.ptex2tex.cfg`` file.

The argument after ``!bc`` is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.,

.. code-block:: py


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

Here, three arguments are defined: ``pycod`` for Python code,
``cod`` also for Python code, ``cppcod`` for C++ code, and ``sys``
for terminal sessions. The same arguments would be defined
in ``.ptex2tex.cfg`` for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, ``pro`` is used for complete programs in Python, ``cod``
is for a code snippet in Python, while ``xcod`` and ``xpro`` implies
computer language specific typesetting where ``x`` can be
``f`` for Fortran, ``c`` for C, ``cpp`` for C++, and ``py`` for Python.
The argument ``sys`` means by default ``console`` for Sphinx and
``CodeTerminal`` (ptex2tex environent) for LaTeX. All these definitions
of the arguments after ``!bc`` can be redefined in the ``.ptex2tex.cfg``
configuration file for ptex2tex/LaTeX and in the ``sphinx code-blocks``
comments for Sphinx. Support for other languages is easily added.

.. (Any sphinx code-block comment, whether inside verbatim code
.. blocks or outside, yields a mapping between bc arguments
.. and computer languages. In case of muliple definitions, the
.. first one is used.)

The enclosing ``!ec`` tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code (``pycod`` style):

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

And here is a C++ code snippet (``cppcod`` style):

.. code-block:: c++

        void myfunc(double* x, const double& myarr) {
            for (int i = 1; i < myarr.size(); i++) {
                myarr[i] = myarr[i] - x[i]*myarr[i-1]
            }
        }


Computer code can be copied directly from a file, if desired. The syntax
is then

.. code-block:: py


         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1

The first line implies that all lines in the file ``myfile.f`` are
copied into a verbatim block, typset in a ``!bc pro`` environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The ``pro`` and ``cod`` arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain ``!bc`` environment.) Two regular expressions, separated by the
``@`` sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching ``subroutine test``
(with as many blanks as desired between the two words) and the line
matching ``C END1`` (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

Let us copy a whole file (the first line above):


.. code-block:: py


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


.. code-block:: py

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


.. _mathtext:

LaTeX Blocks of Mathematical Text
---------------------------------

Blocks of mathematical text are like computer code blocks, but
the opening tag is ``!bt`` (begin TeX) and the closing tag is
``!et``. It is important that ``!bt`` and ``!et`` appear on the beginning of the
line and followed by a newline. 

Here is the result of a ``!bt`` - ``!et`` block:

.. math::
   :label: myeq1
        
        {\partial u\over\partial t}  &=  \nabla^2 u + f,\\
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

.. _newcommands:

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


.. code-block:: py


        \newcommand{\beqa}{\begin{eqnarray}}
        \newcommand{\eeqa}{\end{eqnarray}}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}
        


and these in ``newcommands_keep.tex``:


.. code-block:: py


        \newcommand{\x}{\mathbfx{x}}
        \newcommand{\normalvec}{\mathbfx{n}}
        \newcommand{\Ddt}[1]{\frac{D#1}{dt}}
        


The LaTeX block

.. code-block:: py


        \beqa
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\uvec} &=& \Q \ep\label{my:eq2}
        \eeqa

will then be rendered to

.. math::
        
        {\mbox{\boldmath $x$}}\cdot{\mbox{\boldmath $n$}}  &=  0,\\
        \frac{D\vec u}{dt}  &=  {\mbox{\boldmath $Q$}} \thinspace . 
        

in the current format.

Preprocessing Steps
-------------------

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(`<http://code.google.com/p/preprocess>`_) and Mako
(`<http://www.makotemplates.org/>`_). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of ``name=value`` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable ``FORMAT`` to be the desired
output format of Doconce. It is then easy to test on the value of ``FORMAT``
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.


Missing Features
----------------

  * Footnotes

Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running ``doconce format``, the reason for the error is most likely a
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

*Code or TeX Block Errors in reST.* Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a ``!bc``, which should
have been removed by ``doconce format``, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then ``!bc`` will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

*Strange Errors Around Code or TeX Blocks in reST.* If ``idx`` commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

*Error Message "Undefined substitution..." from reST.* This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

*Preprocessor Directives Do Not Work.* Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving

.. code-block:: py


        \code{...}

the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the the section :ref:`sec:verbatim:blocks` above.  Start the
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

*Problems with Boldface and Emphasize.* Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

*Strange Non-English Characters.* Check the encoding of the ``.do.txt`` file with the Unix ``file`` command.
If UTF-8, convert to latin-1 using the Unix command

.. code-block:: py


        Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile

(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
``_doconce_debugging.log``, if the to ``doconce format`` after the filename
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


.. code-block:: py


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



.. code-block:: py


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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted. 


.. code-block:: py


            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).


The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

    :var x: 
      x value (float),
      which must be a positive number.

    :var tolerance: 
      tolerance (float) for stopping
      the iterations.

.. [Python:Primer:09] H. P. Langtangen.
   *A Primer on Scientific Programming with Python*.
   Springer, 2009.

.. [Osnes:98] H. Osnes and H. P. Langtangen.
   An efficient probabilistic finite element method for stochastic 
   groundwater flow.
   *Advances in Water Resources*, vol 22, 185-195, 1998.
************** File: manual.gwiki *****************
#summary Doconce Description
<wiki:toc max_depth="2" />
By *Hans Petter Langtangen*

==== Feb 20, 2011 ====

<wiki:comment> lines beginning with # are comment lines </wiki:comment>



== What Is Doconce? ==

Doconce is two things:


 # Doconce is a very simple and minimally tagged markup language that    look like ordinary ASCII text (much like what you would use in an    email), but the text can be transformed to numerous other formats,    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,    Epytext, and also plain text (where non-obvious formatting/tags are    removed for clear reading in, e.g., emails). From reStructuredText    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the    latter to RTF and MS Word.
 # Doconce is a working strategy for never duplicating information.    Text is written in a single place and then transformed to    a number of different destinations of diverse type (software    source code, manuals, tutorials, books, wikis, memos, emails, etc.).    The Doconce markup language support this working strategy.    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?


  * Doconce can convert to plain *untagged* text,     more desirable for computer programs and email.
  * Doconce has less cluttered tagging of text.
  * Doconce has better support for copying in parts of computer code,    say in examples, directly from the source code files.
  * Doconce has stronger support for mathematical typesetting, and    has many features for being integrated with (big) LaTeX projects.
  * Doconce is almost self-explanatory and is a handy starting point    for generating documents in more complicated markup languages, such    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:


  * Large books written in LaTeX, but where many pieces (computer demos,    projects, examples) can be written in Doconce to appear in other    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  * Software documentation, primarily Python doc strings, which one wants    to appear as plain untagged text for viewing in Pydoc, as reStructuredText    for use with Sphinx, as wiki text when publishing the software at    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  * Quick memos, which start as plain text in email, then some small    amount of Doconce tagging is added, before the memos can appear as    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to the section [#The_Doconce_Software_Documentation_Strategy] to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.



== Motivation: Problems with Documenting Software ==

*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
one motivation for developing the Doconce concept and tool.

*Tagging Issues in Python Documentation.* A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
 # Tools for inserting appropriately filtered versions of a "singleton"    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a [http://code.google.com/p/preprocess C-style preprocessor tool] or the [http://www.makotemplates.org/ Mako template system].  Then we can *write once, include
anywhere*!  And what we write is close to plain ASCII text.

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

If you make use of preprocessor directives in the Doconce source,
either [http://code.google.com/p/preprocess Preprocess] or [http://www.makotemplates.org Mako] must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need [http://code.google.com/p/ptex2tex ptex2tex] and some style
files that `ptex2tex` potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires [http://docutils.sourceforge.net docutils].  Making Sphinx
documents requires of course [http://sphinx.pocoo.org Sphinx].
All of the mentioned potential dependencies are pure Python packages
which are easily installed.

==== The Doconce Software Documentation Strategy ====

   * Write software documentation, both tutorials and manuals, in     the Doconce format. Use many files - and never duplicate information!
   * Use `#include` statements in source code (especially in doc     strings) and in LaTeX documents for including documentation     files.  These documentation files must be filtered to an     appropriate format by the program `doconce` before being     included. In a Python context, this means plain text for computer     source code (and Pydoc); Epytext for Epydoc API documentation, or     the Sphinx dialect of reStructuredText for Sphinx API     documentation; LaTeX for LaTeX manuals; and possibly     reStructuredText for XML, Docbook, OpenOffice, RTF, Word.
   * Run the preprocessor `preprocess` on the files to produce native     files for pure computer code and for various other documents.

Consider an example involving a Python module in a `basename.p.py` file.
The `.p.py` extension identifies this as a file that has to be
preprocessed) by the `preprocess` program. 
In a doc string in `basename.p.py` we do a preprocessor include
in a comment line, say (use triple quotes in the doc string in case
the `doc1` documentation includes code snippets with doc strings
with the usual triple double quotes)
{{{
'''
#    #include "docstrings/doc1.dst.txt
'''
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
doconce format epytext doc1.do.txt
mv doc1.epytext doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
epydoc basename

# make Sphinx API manual of basename module:
cd doc
doconce format sphinx doc1.do.txt
mv doc1.rst doc1.dst.txt
cd ..
preprocess basename.p.py > basename.py
cd docstrings/sphinx-rootdir  # sphinx directory for API source
make clean
make html
cd ../..

# make ordinary Python module files with doc strings:
cd docstrings
doconce format plain doc1.do.txt
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
docs/manual/manual.do.txt
}}}
file in the Doconce source code tree. We have made a 
[https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html demo web page]
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file `make.sh` in the same directory as the `manual.do.txt` file
(the current text) shows how to run `doconce format` on the
Doconce file to obtain documents in various formats.

Another demo is found in
{{{
docs/tutorial/tutorial.do.txt
}}}
In the `tutorial` directory there is also a `make.sh` file producing a
lot of formats, with a corresponding
[https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html web demo]
of the results.

<wiki:comment> Example on including another Doconce file: </wiki:comment>



== From Doconce to Other Formats ==

Transformation of a Doconce document to various other
formats applies the script `doconce format`:
{{{
Unix/DOS> doconce format format mydoc.do.txt
}}}
The `preprocess` program is always used to preprocess the file first,
and options to `preprocess` can be added after the filename. For example,
{{{
Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections
}}}
The variable `FORMAT` is always defined as the current format when
running `preprocess`. That is, in the last example, `FORMAT` is
defined as `LaTeX`. Inside the Doconce document one can then perform
format specific actions through tests like `#if FORMAT == "LaTeX"`.

Inline comments in the text are removed from the output by
{{{
Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments
}}}
One can also remove such comments from the original Doconce file
by running a helper script in the `bin` folder of the Doconce
source code:
{{{
Unix/DOS> doconce remove_inline_comments mydoc.do.txt
}}}
This action is convenient when a Doconce document reaches its final form.

==== HTML ====

Making an HTML version of a Doconce file `mydoc.do.txt`
is performed by
{{{
Unix/DOS> doconce format HTML mydoc.do.txt
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
Unix/DOS> doconce format LaTeX mydoc.do.txt
}}}
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files `newcommands.tex`, `newcommands_keep.tex`, or
`newcommands_replace.tex` (see the section [#Macros_(Newcommands)]). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run `ptex2tex` (if you have it) to make a standard LaTeX file,
{{{
Unix/DOS> ptex2tex mydoc
}}}
or just perform a plain copy,
{{{
Unix/DOS> cp mydoc.p.tex mydoc.tex
}}}
Doconce generates a `.p.tex` file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font,
{{{
Unix/DOS> ptex2tex -DHELVETICA mydoc
}}}
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through
{{{
Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc
}}}

The `ptex2tex` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any `!bc sys` command in the Doconce source you can
insert verbatim block styles as defined in your `.ptex2tex.cfg`
file, e.g., `!bc sys cod` for a code snippet, where `cod` is set to
a certain environment in `.ptex2tex.cfg` (e.g., `CodeIntended`).
There are over 30 styles to choose from.

*Step 3.* Compile `mydoc.tex`
and create the PDF file:
{{{
Unix/DOS> latex mydoc
Unix/DOS> latex mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex mydoc
Unix/DOS> dvipdf mydoc
}}}
If one wishes to use the `Minted_Python`, `Minted_Cpp`, etc., environments
in `ptex2tex` for typesetting code, the `minted` LaTeX package is needed.
This package is included by running `doconce format` with the
`-DMINTED` option:
{{{
Unix/DOS> ptex2tex -DMINTED mydoc
}}}
In this case, `latex` must be run with the
`-shell-escape` option:
{{{
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> makeindex mydoc   # if index
Unix/DOS> bibitem mydoc     # if bibliography
Unix/DOS> latex -shell-escape mydoc
Unix/DOS> dvipdf mydoc
}}}
The `-shell-escape` option is required because the `minted.sty` style
file runs the `pygments` program to format code, and this program
cannot be run from `latex` without the `-shell-escape` option.

==== Plain ASCII Text ====

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
{{{
Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt
}}}

==== reStructuredText ====

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file `mydoc.rst`:
{{{
Unix/DOS> doconce format rst mydoc.do.txt
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
Unix/DOS> doconce format sphinx mydoc.do.txt
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
These statements are automated by the command
{{{
Unix/DOS> doconce sphinx_dir mydoc.do.txt
}}}

*Step 3.* Move the `tutorial.rst` file to the Sphinx root directory:
{{{
Unix/DOS> mv mydoc.rst sphinx-rootdir
}}}
If you have figures in your document, the relative paths to those will
be invalid when you work with `mydoc.rst` in the `sphinx-rootdir`
directory. Either edit `mydoc.rst` so that figure file paths are correct,
or simply copy your figure directory to `sphinx-rootdir` (if all figures
are located in a subdirectory).

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

Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows `!bc`: `cod` gives Python
(`code-block:: python` in Sphinx syntax) and `cppcod` gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.

<wiki:comment> Desired extension: sphinx can utilize a "pycod" or "c++cod" </wiki:comment>
<wiki:comment> instruction as currently done in latex for ptex2tex and write </wiki:comment>
<wiki:comment> out the right code block name accordingly. </wiki:comment>

==== Google Code Wiki ====

There are several different wiki dialects, but Doconce only support the
one used by [http://code.google.com/p/support/wiki/WikiSyntax Google Code].
The transformation to this format, called `gwiki` to explicitly mark
it as the Google Code dialect, is done by
{{{
Unix/DOS> doconce format gwiki mydoc.do.txt
}}}
You can then open a new wiki page for your Google Code project, copy
the `mydoc.gwiki` output file from `doconce format` and paste the
file contents into the wiki page. Press *Preview* or *Save Page* to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).

==== Tweaking the Doconce Output ====

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
`.rst` file is going to be filtered to LaTeX or HTML, it cannot know
if `.eps` or `.png` is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The `make.sh` files in `docs/manual` and `docs/tutorial` 
constitute comprehensive examples on how such scripts can be made.



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


Lines starting with `TITLE:`, `AUTHOR:`, and `DATE:` are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax 
{{{
name at institution1 and institution2 and institution3
}}}
The `at` with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the `and` with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple `AUTHOR:` lines. All information
associated with `TITLE:` and `AUTHOR:` keywords must appear on a single
line.  Here is an example:
{{{
TITLE: On an Ultimate Markup Language
AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
AUTHOR: A. Dummy Author
DATE: November 9, 2016
}}}
Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format:
{{{
Hans Petter Langtangen [1, 2]
Kaare Dump [3]
A. Dummy Author 

[1] Center for Biomedical Computing, Simula Research Laboratory
[2] Department of Informatics, University of Oslo
[3] Segfault, Cyberspace Inc.
}}}
Similar typesetting is done for LaTeX and HTML formats.


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
The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say `.eps` when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's `convert` utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for `TITLE:` and `AUTHOR:` lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as `FIGURE:` will be
included in the formatted caption).



---------------------------------------------------------------

Figure: It can't get worse than this.... (fig:impact)

https://doconce.googlecode.com/hg/trunk/docs/manual/figs/dinoimpact.gif

<wiki:comment> 
Put the figure file figs/dinoimpact.gif on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------




Another type of special lines starts with `@@@CODE` and enables copying
of computer code from a file directly into a verbatim environment, see 
the section [#Blocks_of_Verbatim_Computer_Code] below.

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
some URL like "MyPlace": "http://my.place.in.space/src"
}}}
which appears as some URL like [http://my.place.in.space/src MyPlace].
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes:
{{{
URL:"manual.do.txt"
"URL": "manual.do.txt"
url: "manual.do.txt"
"url":"manual.do.txt"
}}}
All these constructions result in the link manual.do.txt.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes:
{{{
Click on this link: URL:"http://some.where.net".
}}}

Doconce also supports inline comments in the text:
{{{
[name: comment]
}}}
where `name` is the name of the author of the command, and `comment` is a 
plain text text. [hpl: Note that there must be a space after the colon,
otherwise the comment is not recognized.]
The name and comment are visible in the output unless `doconce format`
is run with a command-line specification of removing such comments
(see the chapter [#From_Doconce_to_Other_Formats] for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the `.do.txt` file
(see the chapter [#From_Doconce_to_Other_Formats]).

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
reStructuredText commands by `doconce format`. In the HTML and (Google
Code) Wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure fig:impact
(the label appears in the figure caption in the source code of this document).
Additional references to the sections [#LaTeX_Blocks_of_Mathematical_Text] and [#Macros_(Newcommands)] are
nice to demonstrate, as well as a reference to equations,
say Equation (my:eq1)--Equation (my:eq2). A comparison of the output and
the source of this document illustrates how labels and references
are handled by the format in question.

Hyperlinks to files or web addresses are handled as explained
in the section [#Inline_Tagging].

==== Index and Bibliography ====

An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the `idx` keyword, following a LaTeX-inspired syntax:
{{{
idx{some index entry}
idx{main entry!subentry}
idx{`verbatim_text` and more}
}}}
The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to
{{{
\index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}
}}}
Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: `idx` commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style:
{{{
as found in cite{Larsen:86,Nielsen:99}.
}}}
Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding `cite` command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like
{{{
as found in [3][14]
}}}
if `Larsen:86` has already appeared in the 3rd citation in the document
and `Nielsen:99` is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword `BIBFILE:`,
which is optionally followed by a BibTeX file, having extension `.bib`,
a corresponding reStructuredText bibliography, having extension `.rst`,
or simply a Python dictionary written in a file with extension `.py`.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.,
{{{
{
'Nielsen:99': """
K. Nielsen. *Some Comments on Markup Languages*. 
URL:"http://some.where.net/nielsen/comments", 1999.
""",
'Larsen:86': 
"""
O. B. Larsen. On Markup and Generality.
*Personal Press*. 1986.
"""
}
}}}
In the LaTeX format, the `.bib` file will be used in the standard way,
in the reStructuredText and Sphinx formats, the `.rst` file will be
copied into the document at the place where the `BIBFILE:` keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the `BIBFILE:` line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book [1], a paper [2],
and both of them simultaneously [1] [2].

[somereader: comments, citations, and references in the latex style
is a special feature of doconce :-) ]

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
certain `ptex2tex` environment (for instance, `!bc dat` corresponds to
the data file environment in `ptex2tex`, and `!bc cod` is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default `.ptex2tex.cfg`. However, all these arguments
can be redefined in the `.ptex2tex.cfg` file.

The argument after `!bc` is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.,
{{{
# sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console
}}}
Here, three arguments are defined: `pycod` for Python code,
`cod` also for Python code, `cppcod` for C++ code, and `sys`
for terminal sessions. The same arguments would be defined
in `.ptex2tex.cfg` for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, `pro` is used for complete programs in Python, `cod`
is for a code snippet in Python, while `xcod` and `xpro` implies
computer language specific typesetting where `x` can be
`f` for Fortran, `c` for C, `cpp` for C++, and `py` for Python.
The argument `sys` means by default `console` for Sphinx and
`CodeTerminal` (ptex2tex environent) for LaTeX. All these definitions
of the arguments after `!bc` can be redefined in the `.ptex2tex.cfg`
configuration file for ptex2tex/LaTeX and in the `sphinx code-blocks`
comments for Sphinx. Support for other languages is easily added.

<wiki:comment> (Any sphinx code-block comment, whether inside verbatim code </wiki:comment>
<wiki:comment> blocks or outside, yields a mapping between bc arguments </wiki:comment>
<wiki:comment> and computer languages. In case of muliple definitions, the </wiki:comment>
<wiki:comment> first one is used.) </wiki:comment>

The enclosing `!ec` tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code (`pycod` style):
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
And here is a C++ code snippet (`cppcod` style):
{{{
void myfunc(double* x, const double& myarr) {
    for (int i = 1; i < myarr.size(); i++) {
        myarr[i] = myarr[i] - x[i]*myarr[i-1]
    }
}
}}}

Computer code can be copied directly from a file, if desired. The syntax
is then
{{{
 @@@CODE myfile.f
 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1
}}}
The first line implies that all lines in the file `myfile.f` are
copied into a verbatim block, typset in a `!bc pro` environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The `pro` and `cod` arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain `!bc` environment.) Two regular expressions, separated by the
`@` sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching `subroutine test`
(with as many blanks as desired between the two words) and the line
matching `C END1` (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

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

==== Preprocessing Steps ====

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(http://code.google.com/p/preprocess) and Mako
(http://www.makotemplates.org/). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of `name=value` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable `FORMAT` to be the desired
output format of Doconce. It is then easy to test on the value of `FORMAT`
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.

==== Missing Features ====

  * Footnotes

==== Troubleshooting ====

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running `doconce format`, the reason for the error is most likely a
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

*Code or TeX Block Errors in reST.* Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a `!bc`, which should
have been removed by `doconce format`, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then `!bc` will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

*Strange Errors Around Code or TeX Blocks in reST.* If `idx` commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

*Error Message "Undefined substitution..." from reST.* This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

*Preprocessor Directives Do Not Work.* Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving
{{{
\code{...}
}}}
the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the the section [#Blocks_of_Verbatim_Computer_Code] above.  Start the
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

*Problems with Boldface and Emphasize.* Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

*Strange Non-English Characters.* Check the encoding of the `.do.txt` file with the Unix `file` command.
If UTF-8, convert to latin-1 using the Unix command
{{{
Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile
}}}
(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
`_doconce_debugging.log`, if the to `doconce format` after the filename
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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted. 

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

The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.


    * *module variable* x:  
      x value (float),      which must be a positive number.
    * *module variable* tolerance:  
      tolerance (float) for stopping      the iterations.



== Bibliography ==

  # H. P. Langtangen. *A Primer on Scientific Programming with Python*. Springer, 2009.
  # H. Osnes and H. P. Langtangen. An efficient probabilistic finite element method for stochastic  groundwater flow. *Advances in Water Resources*, vol 22, 185-195, 1998.


************** File: manual.st *****************
TITLE: Doconce Description
BY: Hans Petter Langtangen (Simula Research Laboratory, and University of Oslo)DATE: today
What Is Doconce?
Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  - Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.
  - Doconce has less cluttered tagging of text.
  - Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to the section "The Doconce Software Documentation Strategy" to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.
Motivation: Problems with Documenting Software
*Duplicated Information.* It is common to write some software
documentation in the code (doc strings in Python, doxygen in C++,
javadoc in Java) while similar documentation is often also included in
a LaTeX or HTML manual or tutorial. Although the various types of
documentation may start out to be the same, different physical files
must be used since very different tagging is required for different
output formats. Over time the duplicated information starts to
diverge. Severe problems with such unsynchronized documentation was
one motivation for developing the Doconce concept and tool.

*Tagging Issues in Python Documentation.* A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a "http://code.google.com/p/preprocess":C-style preprocessor tool or the "http://www.makotemplates.org/":Mako template system.  Then we can *write once, include
anywhere*!  And what we write is close to plain ASCII text.

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
If you make use of preprocessor directives in the Doconce source,
either "http://code.google.com/p/preprocess":Preprocess or "http://www.makotemplates.org":Mako must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need "http://code.google.com/p/ptex2tex":ptex2tex and some style
files that 'ptex2tex' potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires "http://docutils.sourceforge.net":docutils.  Making Sphinx
documents requires of course "http://sphinx.pocoo.org":Sphinx.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.
The Doconce Software Documentation Strategy
   - Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   - Use '#include' statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program 'doconce' before being
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
in a comment line, say (use triple quotes in the doc string in case
the 'doc1' documentation includes code snippets with doc strings
with the usual triple double quotes)::


        '''
        #    #include "docstrings/doc1.dst.txt
        '''

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
        doconce format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce format plain doc1.do.txt
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


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
"https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html":demo web page
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file 'make.sh' in the same directory as the 'manual.do.txt' file
(the current text) shows how to run 'doconce format' on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the 'tutorial' directory there is also a 'make.sh' file producing a
lot of formats, with a corresponding
"https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html":web demo
of the results.
From Doconce to Other Formats
Transformation of a Doconce document to various other
formats applies the script 'doconce format':
!bc   sys
        Unix/DOS> doconce format format mydoc.do.txt

The 'preprocess' program is always used to preprocess the file first,
and options to 'preprocess' can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable 'FORMAT' is always defined as the current format when
running 'preprocess'. That is, in the last example, 'FORMAT' is
defined as 'LaTeX'. Inside the Doconce document one can then perform
format specific actions through tests like '#if FORMAT == "LaTeX"'.

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the 'bin' folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.
HTML
Making an HTML version of a Doconce file 'mydoc.do.txt'
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file 'mydoc.html' can be loaded into any web browser for viewing.
LaTeX
Making a LaTeX file 'mydoc.tex' from 'mydoc.do.txt' is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form 'mydoc.p.tex' for
     'ptex2tex':
!bc   sys
        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files 'newcommands.tex', 'newcommands_keep.tex', or
'newcommands_replace.tex' (see the section "Macros (Newcommands)"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run 'ptex2tex' (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a '.p.tex' file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The 'ptex2tex' tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any '!bc sys' command in the Doconce source you can
insert verbatim block styles as defined in your '.ptex2tex.cfg'
file, e.g., '!bc sys cod' for a code snippet, where 'cod' is set to
a certain environment in '.ptex2tex.cfg' (e.g., 'CodeIntended').
There are over 30 styles to choose from.

*Step 3.* Compile 'mydoc.tex'
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the 'Minted_Python', 'Minted_Cpp', etc., environments
in 'ptex2tex' for typesetting code, the 'minted' LaTeX package is needed.
This package is included by running 'doconce format' with the
'-DMINTED' option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, 'latex' must be run with the
'-shell-escape' option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The '-shell-escape' option is required because the 'minted.sty' style
file runs the 'pygments' program to format code, and this program
cannot be run from 'latex' without the '-shell-escape' option.
Plain ASCII Text
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt

reStructuredText
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file 'mydoc.rst':
!bc   sys
        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the 'tutorial.rst' file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with 'mydoc.rst' in the 'sphinx-rootdir'
directory. Either edit 'mydoc.rst' so that figure file paths are correct,
or simply copy your figure directory to 'sphinx-rootdir' (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows '!bc': 'cod' gives Python
('code-block:: python' in Sphinx syntax) and 'cppcod' gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.
Google Code Wiki
There are several different wiki dialects, but Doconce only support the
one used by "http://code.google.com/p/support/wiki/WikiSyntax":Google Code.
The transformation to this format, called 'gwiki' to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the 'mydoc.gwiki' output file from 'doconce format' and paste the
file contents into the wiki page. Press **Preview** or **Save Page** to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).
Tweaking the Doconce Output
Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
'.rst' file is going to be filtered to LaTeX or HTML, it cannot know
if '.eps' or '.png' is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The 'make.sh' files in 'docs/manual' and 'docs/tutorial' 
constitute comprehensive examples on how such scripts can be made.
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


Lines starting with 'TITLE:', 'AUTHOR:', and 'DATE:' are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax::


        name at institution1 and institution2 and institution3

The 'at' with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the 'and' with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple 'AUTHOR:' lines. All information
associated with 'TITLE:' and 'AUTHOR:' keywords must appear on a single
line.  Here is an example::


        TITLE: On an Ultimate Markup Language
        AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        AUTHOR: A. Dummy Author
        DATE: November 9, 2016

Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format::


        Hans Petter Langtangen [1, 2]
        Kaare Dump [3]
        A. Dummy Author 
        
        [1] Center for Biomedical Computing, Simula Research Laboratory
        [2] Department of Informatics, University of Oslo
        [3] Segfault, Cyberspace Inc.

Similar typesetting is done for LaTeX and HTML formats.


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

The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say '.eps' when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's 'convert' utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for 'TITLE:' and 'AUTHOR:' lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as 'FIGURE:' will be
included in the formatted caption).

FIGURE:[figs/dinoimpact, width=400] It can't get worse than this.... {fig:impact}


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


        some URL like "MyPlace": "http://my.place.in.space/src"

which appears as some URL like "http://my.place.in.space/src":MyPlace.
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::


        URL:"manual.do.txt"
        "URL": "manual.do.txt"
        url: "manual.do.txt"
        "url":"manual.do.txt"

All these constructions result in the link "manual.do.txt":manual.do.txt.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes::


        Click on this link: URL:"http://some.where.net".


Doconce also supports inline comments in the text::


        [name: comment]

where 'name' is the name of the author of the command, and 'comment' is a 
plain text text. [hpl: Note that there must be a space after the colon,
otherwise the comment is not recognized.]
The name and comment are visible in the output unless 'doconce format'
is run with a command-line specification of removing such comments
(see the chapter "From Doconce to Other Formats" for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the '.do.txt' file
(see the chapter "From Doconce to Other Formats").

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
reStructuredText commands by 'doconce format'. In the HTML and (Google
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
Index and Bibliography
An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the 'idx' keyword, following a LaTeX-inspired syntax::


        idx{some index entry}
        idx{main entry!subentry}
        idx{`verbatim_text` and more}

The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to::


        \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}

Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: 'idx' commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style::


        as found in cite{Larsen:86,Nielsen:99}.

Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding 'cite' command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like::


        as found in [3][14]

if 'Larsen:86' has already appeared in the 3rd citation in the document
and 'Nielsen:99' is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword 'BIBFILE:',
which is optionally followed by a BibTeX file, having extension '.bib',
a corresponding reStructuredText bibliography, having extension '.rst',
or simply a Python dictionary written in a file with extension '.py'.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.::


        {
        'Nielsen:99': """
        K. Nielsen. *Some Comments on Markup Languages*. 
        URL:"http://some.where.net/nielsen/comments", 1999.
        """,
        'Larsen:86': 
        """
        O. B. Larsen. On Markup and Generality.
        *Personal Press*. 1986.
        """
        }

In the LaTeX format, the '.bib' file will be used in the standard way,
in the reStructuredText and Sphinx formats, the '.rst' file will be
copied into the document at the place where the 'BIBFILE:' keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the 'BIBFILE:' line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book [1], a paper [2],
and both of them simultaneously [1] [2].

[somereader: comments, citations, and references in the latex style
is a special feature of doconce :-) ]
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
certain 'ptex2tex' environment (for instance, '!bc dat' corresponds to
the data file environment in 'ptex2tex', and '!bc cod' is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default '.ptex2tex.cfg'. However, all these arguments
can be redefined in the '.ptex2tex.cfg' file.

The argument after '!bc' is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

Here, three arguments are defined: 'pycod' for Python code,
'cod' also for Python code, 'cppcod' for C++ code, and 'sys'
for terminal sessions. The same arguments would be defined
in '.ptex2tex.cfg' for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, 'pro' is used for complete programs in Python, 'cod'
is for a code snippet in Python, while 'xcod' and 'xpro' implies
computer language specific typesetting where 'x' can be
'f' for Fortran, 'c' for C, 'cpp' for C++, and 'py' for Python.
The argument 'sys' means by default 'console' for Sphinx and
'CodeTerminal' (ptex2tex environent) for LaTeX. All these definitions
of the arguments after '!bc' can be redefined in the '.ptex2tex.cfg'
configuration file for ptex2tex/LaTeX and in the 'sphinx code-blocks'
comments for Sphinx. Support for other languages is easily added.


The enclosing '!ec' tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code ('pycod' style)::


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

And here is a C++ code snippet ('cppcod' style)::


        void myfunc(double* x, const double& myarr) {
            for (int i = 1; i < myarr.size(); i++) {
                myarr[i] = myarr[i] - x[i]*myarr[i-1]
            }
        }


Computer code can be copied directly from a file, if desired. The syntax
is then::


         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1

The first line implies that all lines in the file 'myfile.f' are
copied into a verbatim block, typset in a '!bc pro' environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The 'pro' and 'cod' arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain '!bc' environment.) Two regular expressions, separated by the
'@' sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching 'subroutine test'
(with as many blanks as desired between the two words) and the line
matching 'C END1' (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

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
Preprocessing Steps
Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
("http://code.google.com/p/preprocess":http://code.google.com/p/preprocess) and Mako
("http://www.makotemplates.org/":http://www.makotemplates.org/). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of 'name=value' command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable 'FORMAT' to be the desired
output format of Doconce. It is then easy to test on the value of 'FORMAT'
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.
Missing Features
  - Footnotes
Troubleshooting
*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running 'doconce format', the reason for the error is most likely a
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

*Code or TeX Block Errors in reST.* Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a '!bc', which should
have been removed by 'doconce format', it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then '!bc' will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

*Strange Errors Around Code or TeX Blocks in reST.* If 'idx' commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

*Error Message "Undefined substitution..." from reST.* This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

*Preprocessor Directives Do Not Work.* Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::


        \code{...}

the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the the section "Blocks of Verbatim Computer Code" above.  Start the
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

*Problems with Boldface and Emphasize.* Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

*Strange Non-English Characters.* Check the encoding of the '.do.txt' file with the Unix 'file' command.
If UTF-8, convert to latin-1 using the Unix command::


        Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile

(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
'_doconce_debugging.log', if the to 'doconce format' after the filename
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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted::


            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).


The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

    module variable x: --  
      x value (float),
      which must be a positive number.
    module variable tolerance: --  
      tolerance (float) for stopping
      the iterations.
Bibliography
  1. H. P. Langtangen. *A Primer on Scientific Programming with Python*. Springer, 2009.
  2. H. Osnes and H. P. Langtangen. An efficient probabilistic finite element method for stochastic  groundwater flow. *Advances in Water Resources*, vol 22, 185-195, 1998.

************** File: manual.epytext *****************
TITLE: Doconce Description
BY: Hans Petter Langtangen (Simula Research Laboratory, and University of Oslo)DATE: today




What Is Doconce?
================


Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  - Doconce can convert to plain I{untagged} text, 
    more desirable for computer programs and email.
  - Doconce has less cluttered tagging of text.
  - Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to the section "The Doconce Software Documentation Strategy" to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.


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
one motivation for developing the Doconce concept and tool.

I{Tagging Issues in Python Documentation.} A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a U{C-style preprocessor tool<http://code.google.com/p/preprocess>} or the U{Mako template system<http://www.makotemplates.org/>}.  Then we can I{write once, include
anywhere}!  And what we write is close to plain ASCII text.

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

If you make use of preprocessor directives in the Doconce source,
either U{Preprocess<http://code.google.com/p/preprocess>} or U{Mako<http://www.makotemplates.org>} must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need U{ptex2tex<http://code.google.com/p/ptex2tex>} and some style
files that C{ptex2tex} potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires U{docutils<http://docutils.sourceforge.net>}.  Making Sphinx
documents requires of course U{Sphinx<http://sphinx.pocoo.org>}.
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


The Doconce Software Documentation Strategy
-------------------------------------------

   - Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!
   - Use C{#include} statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program C{doconce} before being
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
in a comment line, say (use triple quotes in the doc string in case
the C{doc1} documentation includes code snippets with doc strings
with the usual triple double quotes)::


        '''
        #    #include "docstrings/doc1.dst.txt
        '''

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
        doconce format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce format plain doc1.do.txt
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


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
U{demo web page<https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html>}
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file C{make.sh} in the same directory as the C{manual.do.txt} file
(the current text) shows how to run C{doconce format} on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the C{tutorial} directory there is also a C{make.sh} file producing a
lot of formats, with a corresponding
U{web demo<https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html>}
of the results.



From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script C{doconce format}::


        Unix/DOS> doconce format format mydoc.do.txt

The C{preprocess} program is always used to preprocess the file first,
and options to C{preprocess} can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable C{FORMAT} is always defined as the current format when
running C{preprocess}. That is, in the last example, C{FORMAT} is
defined as C{LaTeX}. Inside the Doconce document one can then perform
format specific actions through tests like C{#if FORMAT == "LaTeX"}.

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the C{bin} folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file C{mydoc.do.txt}
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file C{mydoc.html} can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file C{mydoc.tex} from C{mydoc.do.txt} is done in two steps:

I{Step 1.} Filter the doconce text to a pre-LaTeX form C{mydoc.p.tex} for
     C{ptex2tex}::


        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files C{newcommands.tex}, C{newcommands_keep.tex}, or
C{newcommands_replace.tex} (see the section "Macros (Newcommands)"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

I{Step 2.} Run C{ptex2tex} (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a C{.p.tex} file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The C{ptex2tex} tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any C{!bc sys} command in the Doconce source you can
insert verbatim block styles as defined in your C{.ptex2tex.cfg}
file, e.g., C{!bc sys cod} for a code snippet, where C{cod} is set to
a certain environment in C{.ptex2tex.cfg} (e.g., C{CodeIntended}).
There are over 30 styles to choose from.

I{Step 3.} Compile C{mydoc.tex}
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the C{Minted_Python}, C{Minted_Cpp}, etc., environments
in C{ptex2tex} for typesetting code, the C{minted} LaTeX package is needed.
This package is included by running C{doconce format} with the
C{-DMINTED} option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, C{latex} must be run with the
C{-shell-escape} option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The C{-shell-escape} option is required because the C{minted.sty} style
file runs the C{pygments} program to format code, and this program
cannot be run from C{latex} without the C{-shell-escape} option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file C{mydoc.rst}::


        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


I{Step 3.} Move the C{tutorial.rst} file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with C{mydoc.rst} in the C{sphinx-rootdir}
directory. Either edit C{mydoc.rst} so that figure file paths are correct,
or simply copy your figure directory to C{sphinx-rootdir} (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows C{!bc}: C{cod} gives Python
(C{code-block:: python} in Sphinx syntax) and C{cppcod} gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by U{Google Code<http://code.google.com/p/support/wiki/WikiSyntax>}.
The transformation to this format, called C{gwiki} to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the C{mydoc.gwiki} output file from C{doconce format} and paste the
file contents into the wiki page. Press B{Preview} or B{Save Page} to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
C{.rst} file is going to be filtered to LaTeX or HTML, it cannot know
if C{.eps} or C{.png} is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The C{make.sh} files in C{docs/manual} and C{docs/tutorial} 
constitute comprehensive examples on how such scripts can be made.



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


Lines starting with C{TITLE:}, C{AUTHOR:}, and C{DATE:} are optional and used
to identify a title of the document, the authors, and the date. The
title is treated as the rest of the line, so is the date, but the
author text consists of the name and associated institution(s) with
the syntax::


        name at institution1 and institution2 and institution3

The C{at} with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the C{and} with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple C{AUTHOR:} lines. All information
associated with C{TITLE:} and C{AUTHOR:} keywords must appear on a single
line.  Here is an example::


        TITLE: On an Ultimate Markup Language
        AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        AUTHOR: A. Dummy Author
        DATE: November 9, 2016

Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format::


        Hans Petter Langtangen [1, 2]
        Kaare Dump [3]
        A. Dummy Author 
        
        [1] Center for Biomedical Computing, Simula Research Laboratory
        [2] Department of Informatics, University of Oslo
        [3] Segfault, Cyberspace Inc.

Similar typesetting is done for LaTeX and HTML formats.


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

The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say C{.eps} when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's C{convert} utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for C{TITLE:} and C{AUTHOR:} lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as C{FIGURE:} will be
included in the formatted caption).

FIGURE:[figs/dinoimpact, width=400] It can't get worse than this.... {fig:impact}


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


        some URL like "MyPlace": "http://my.place.in.space/src"

which appears as some URL like U{MyPlace<http://my.place.in.space/src>}.
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::


        URL:"manual.do.txt"
        "URL": "manual.do.txt"
        url: "manual.do.txt"
        "url":"manual.do.txt"

All these constructions result in the link U{manual.do.txt<manual.do.txt>}.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes::


        Click on this link: URL:"http://some.where.net".


Doconce also supports inline comments in the text::


        [name: comment]

where C{name} is the name of the author of the command, and C{comment} is a 
plain text text. [hpl: Note that there must be a space after the colon,
otherwise the comment is not recognized.]
The name and comment are visible in the output unless C{doconce format}
is run with a command-line specification of removing such comments
(see the chapter "From Doconce to Other Formats" for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the C{.do.txt} file
(see the chapter "From Doconce to Other Formats").

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
reStructuredText commands by C{doconce format}. In the HTML and (Google
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

Index and Bibliography
----------------------

An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the C{idx} keyword, following a LaTeX-inspired syntax::


        idx{some index entry}
        idx{main entry!subentry}
        idx{`verbatim_text` and more}

The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to::


        \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}

Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: C{idx} commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style::


        as found in cite{Larsen:86,Nielsen:99}.

Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding C{cite} command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like::


        as found in [3][14]

if C{Larsen:86} has already appeared in the 3rd citation in the document
and C{Nielsen:99} is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword C{BIBFILE:},
which is optionally followed by a BibTeX file, having extension C{.bib},
a corresponding reStructuredText bibliography, having extension C{.rst},
or simply a Python dictionary written in a file with extension C{.py}.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.::


        {
        'Nielsen:99': """
        K. Nielsen. *Some Comments on Markup Languages*. 
        URL:"http://some.where.net/nielsen/comments", 1999.
        """,
        'Larsen:86': 
        """
        O. B. Larsen. On Markup and Generality.
        *Personal Press*. 1986.
        """
        }

In the LaTeX format, the C{.bib} file will be used in the standard way,
in the reStructuredText and Sphinx formats, the C{.rst} file will be
copied into the document at the place where the C{BIBFILE:} keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the C{BIBFILE:} line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book [1], a paper [2],
and both of them simultaneously [1] [2].

[somereader: comments, citations, and references in the latex style
is a special feature of doconce :-) ]


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
certain C{ptex2tex} environment (for instance, C{!bc dat} corresponds to
the data file environment in C{ptex2tex}, and C{!bc cod} is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default C{.ptex2tex.cfg}. However, all these arguments
can be redefined in the C{.ptex2tex.cfg} file.

The argument after C{!bc} is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

Here, three arguments are defined: C{pycod} for Python code,
C{cod} also for Python code, C{cppcod} for C++ code, and C{sys}
for terminal sessions. The same arguments would be defined
in C{.ptex2tex.cfg} for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, C{pro} is used for complete programs in Python, C{cod}
is for a code snippet in Python, while C{xcod} and C{xpro} implies
computer language specific typesetting where C{x} can be
C{f} for Fortran, C{c} for C, C{cpp} for C++, and C{py} for Python.
The argument C{sys} means by default C{console} for Sphinx and
C{CodeTerminal} (ptex2tex environent) for LaTeX. All these definitions
of the arguments after C{!bc} can be redefined in the C{.ptex2tex.cfg}
configuration file for ptex2tex/LaTeX and in the C{sphinx code-blocks}
comments for Sphinx. Support for other languages is easily added.


The enclosing C{!ec} tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code (C{pycod} style)::


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

And here is a C++ code snippet (C{cppcod} style)::


        void myfunc(double* x, const double& myarr) {
            for (int i = 1; i < myarr.size(); i++) {
                myarr[i] = myarr[i] - x[i]*myarr[i-1]
            }
        }


Computer code can be copied directly from a file, if desired. The syntax
is then::


         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1

The first line implies that all lines in the file C{myfile.f} are
copied into a verbatim block, typset in a C{!bc pro} environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The C{pro} and C{cod} arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain C{!bc} environment.) Two regular expressions, separated by the
C{@} sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching C{subroutine test}
(with as many blanks as desired between the two words) and the line
matching C{C END1} (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

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
C{newcommand_replace.tex}::


            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.



and these in C{newcommands_keep.tex}::


            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.



The LaTeX block::


            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


will then be rendered to::

            
            NOTE: A verbatim block has been removed because
                  it causes problems for Epytext.


in the current format.

Preprocessing Steps
-------------------

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(U{http://code.google.com/p/preprocess<http://code.google.com/p/preprocess>}) and Mako
(U{http://www.makotemplates.org/<http://www.makotemplates.org/>}). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of C{name=value} command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable C{FORMAT} to be the desired
output format of Doconce. It is then easy to test on the value of C{FORMAT}
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.


Missing Features
----------------

  - Footnotes

Troubleshooting
---------------

I{Disclaimer.} First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running C{doconce format}, the reason for the error is most likely a
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

I{Code or TeX Block Errors in reST.} Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a C{!bc}, which should
have been removed by C{doconce format}, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then C{!bc} will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

I{Strange Errors Around Code or TeX Blocks in reST.} If C{idx} commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

I{Error Message "Undefined substitution..." from reST.} This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

I{Preprocessor Directives Do Not Work.} Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

I{The LaTeX File Does Not Compile.} If the problem is undefined control sequence involving::


        \code{...}

the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

I{Verbatim Code Blocks Inside Lists Look Ugly.} Read the the section "Blocks of Verbatim Computer Code" above.  Start the
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

I{Problems with Boldface and Emphasize.} Two boldface or emphasize expressions after each other are not rendered
correctly. Merge them into one common expression.

I{Strange Non-English Characters.} Check the encoding of the C{.do.txt} file with the Unix C{file} command.
If UTF-8, convert to latin-1 using the Unix command::


        Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile

(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

I{Debugging.} Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
C{_doconce_debugging.log}, if the to C{doconce format} after the filename
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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted::


            - argument x: x value (float),
              which must be a positive number.
            - keyword argument tolerance: tolerance (float) for stopping
              the iterations.
            - return: the root of the equation (float), if found, otherwise None.
            - instance variable eta: surface elevation (array).
            - class variable items: the total number of MyClass objects (int).
            - module variable debug: True: debug mode is on; False: no debugging 
              (bool variable).


The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

    @var x: 
      x value (float),
      which must be a positive number.
    @var tolerance: 
      tolerance (float) for stopping
      the iterations.

Bibliography
============

  1. H. P. Langtangen. I{A Primer on Scientific Programming with Python}. Springer, 2009.
  2. H. Osnes and H. P. Langtangen. An efficient probabilistic finite element method for stochastic  groundwater flow. I{Advances in Water Resources}, vol 22, 185-195, 1998.
************** File: manual.txt *****************
Doconce Description
===================

Hans Petter Langtangen [1, 2]

[1] Simula Research Laboratory
[2] University of Oslo


Date: Feb 20, 2011

What Is Doconce?
================


Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    look like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, Wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

A wide range of markup languages exist. For example, reStructuredText and Sphinx
have recently become popular. So why another one?

  * Doconce can convert to plain *untagged* text, 
    more desirable for computer programs and email.

  * Doconce has less cluttered tagging of text.

  * Doconce has better support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has stronger support for mathematical typesetting, and
    has many features for being integrated with (big) LaTeX projects.

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google Wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or Wiki document.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    googlecode.com, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats.

You can jump to the section "The Doconce Software Documentation Strategy" to see a recipe for
how to use Doconce, unless you need some more motivation for
the problem which Doconce tries to solve.


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
one motivation for developing the Doconce concept and tool.

*Tagging Issues in Python Documentation.* A problem with doc
strings in Python is that they benefit greatly from some tagging,
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
    documentation file in other documents (manuals, tutorials, doc strings).

One answer to these points is the Doconce markup language, its
associated tools, and a C-style preprocessor tool (http://code.google.com/p/preprocess) or the Mako template system (http://www.makotemplates.org/).  Then we can *write once, include
anywhere*!  And what we write is close to plain ASCII text.

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

If you make use of preprocessor directives in the Doconce source,
either Preprocess (http://code.google.com/p/preprocess) or Mako (http://www.makotemplates.org) must be installed.  To make LaTeX
documents (without going through the reStructuredText format) you also
need ptex2tex (http://code.google.com/p/ptex2tex) and some style
files that ptex2tex potentially makes use of.  Going from
reStructuredText to formats such as XML, OpenOffice, HTML, and LaTeX
requires docutils (http://docutils.sourceforge.net).  Making Sphinx
documents requires of course Sphinx (http://sphinx.pocoo.org).
All of the mentioned potential dependencies are pure Python packages
which are easily installed.


The Doconce Software Documentation Strategy
-------------------------------------------

   * Write software documentation, both tutorials and manuals, in
     the Doconce format. Use many files - and never duplicate information!

   * Use #include statements in source code (especially in doc
     strings) and in LaTeX documents for including documentation
     files.  These documentation files must be filtered to an
     appropriate format by the program doconce before being
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
in a comment line, say (use triple quotes in the doc string in case
the doc1 documentation includes code snippets with doc strings
with the usual triple double quotes)::


        '''
        #    #include "docstrings/doc1.dst.txt
        '''

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
        doconce format epytext doc1.do.txt
        mv doc1.epytext doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        epydoc basename
        
        # make Sphinx API manual of basename module:
        cd doc
        doconce format sphinx doc1.do.txt
        mv doc1.rst doc1.dst.txt
        cd ..
        preprocess basename.p.py > basename.py
        cd docstrings/sphinx-rootdir  # sphinx directory for API source
        make clean
        make html
        cd ../..
        
        # make ordinary Python module files with doc strings:
        cd docstrings
        doconce format plain doc1.do.txt
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


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
demo web page (https://doconce.googlecode.com/hg/trunk/docs/demos/manual/index.html)
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file make.sh in the same directory as the manual.do.txt file
(the current text) shows how to run doconce format on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the tutorial directory there is also a make.sh file producing a
lot of formats, with a corresponding
web demo (https://doconce.googlecode.com/hg/trunk/docs/demos/tutorial/index.html)
of the results.



From Doconce to Other Formats
=============================

Transformation of a Doconce document to various other
formats applies the script doconce format::


        Unix/DOS> doconce format format mydoc.do.txt

The preprocess program is always used to preprocess the file first,
and options to preprocess can be added after the filename. For example::


        Unix/DOS> doconce format LaTeX mydoc.do.txt -Dextra_sections

The variable FORMAT is always defined as the current format when
running preprocess. That is, in the last example, FORMAT is
defined as LaTeX. Inside the Doconce document one can then perform
format specific actions through tests like #if FORMAT == "LaTeX".

Inline comments in the text are removed from the output by::


        Unix/DOS> doconce format LaTeX mydoc.do.txt remove_inline_comments

One can also remove such comments from the original Doconce file
by running a helper script in the bin folder of the Doconce
source code::


        Unix/DOS> doconce remove_inline_comments mydoc.do.txt

This action is convenient when a Doconce document reaches its final form.


HTML
----

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::


        Unix/DOS> doconce format HTML mydoc.do.txt

The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file mydoc.tex from mydoc.do.txt is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form mydoc.p.tex for
     ptex2tex::


        Unix/DOS> doconce format LaTeX mydoc.do.txt

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files newcommands.tex, newcommands_keep.tex, or
newcommands_replace.tex (see the section "Macros (Newcommands)"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ptex2tex (if you have it) to make a standard LaTeX file::


        Unix/DOS> ptex2tex mydoc

or just perform a plain copy::


        Unix/DOS> cp mydoc.p.tex mydoc.tex

Doconce generates a .p.tex file with some preprocessor macros.
For example, to enable font Helvetica instead of the standard
Computer Modern font::


        Unix/DOS> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. The standard LaTeX "maketitle" heading
is also available through::


        Unix/DOS> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ptex2tex tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any !bc sys command in the Doconce source you can
insert verbatim block styles as defined in your .ptex2tex.cfg
file, e.g., !bc sys cod for a code snippet, where cod is set to
a certain environment in .ptex2tex.cfg (e.g., CodeIntended).
There are over 30 styles to choose from.

*Step 3.* Compile mydoc.tex
and create the PDF file::


        Unix/DOS> latex mydoc
        Unix/DOS> latex mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex mydoc
        Unix/DOS> dvipdf mydoc

If one wishes to use the Minted_Python, Minted_Cpp, etc., environments
in ptex2tex for typesetting code, the minted LaTeX package is needed.
This package is included by running doconce format with the
-DMINTED option::


        Unix/DOS> ptex2tex -DMINTED mydoc

In this case, latex must be run with the
-shell-escape option::


        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> makeindex mydoc   # if index
        Unix/DOS> bibitem mydoc     # if bibliography
        Unix/DOS> latex -shell-escape mydoc
        Unix/DOS> dvipdf mydoc

The -shell-escape option is required because the minted.sty style
file runs the pygments program to format code, and this program
cannot be run from latex without the -shell-escape option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Unix/DOS> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file mydoc.rst::


        Unix/DOS> doconce format rst mydoc.do.txt

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


        Unix/DOS> doconce format sphinx mydoc.do.txt


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

These statements are automated by the command::


        Unix/DOS> doconce sphinx_dir mydoc.do.txt


*Step 3.* Move the tutorial.rst file to the Sphinx root directory::


        Unix/DOS> mv mydoc.rst sphinx-rootdir

If you have figures in your document, the relative paths to those will
be invalid when you work with mydoc.rst in the sphinx-rootdir
directory. Either edit mydoc.rst so that figure file paths are correct,
or simply copy your figure directory to sphinx-rootdir (if all figures
are located in a subdirectory).

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


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows !bc: cod gives Python
(code-block:: python in Sphinx syntax) and cppcod gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.



Google Code Wiki
----------------

There are several different wiki dialects, but Doconce only support the
one used by Google Code (http://code.google.com/p/support/wiki/WikiSyntax).
The transformation to this format, called gwiki to explicitly mark
it as the Google Code dialect, is done by::


        Unix/DOS> doconce format gwiki mydoc.do.txt

You can then open a new wiki page for your Google Code project, copy
the mydoc.gwiki output file from doconce format and paste the
file contents into the wiki page. Press _Preview_ or _Save Page_ to
see the formatted result.

When the Doconce file contains figures, each figure filename must be
replaced by a URL where the figure is available. There are instructions
in the file for doing this. Usually, one performs this substitution
automatically (see next section).


Tweaking the Doconce Output
---------------------------

Occasionally, one would like to tweak the output in a certain format
from Doconce. One example is figure filenames when transforming
Doconce to reStructuredText. Since Doconce does not know if the
.rst file is going to be filtered to LaTeX or HTML, it cannot know
if .eps or .png is the most appropriate image filename.
The solution is to use a text substitution command or code with, e.g., sed,
perl, python, or scitools subst, to automatically edit the output file
from Doconce. It is then wise to run Doconce and the editing commands
from a script to automate all steps in going from Doconce to the final
format(s). The make.sh files in docs/manual and docs/tutorial 
constitute comprehensive examples on how such scripts can be made.



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
the syntax::


        name at institution1 and institution2 and institution3

The at with surrounding spaces
is essential for adding information about institution(s)
to the author name, and the and with surrounding spaces is
essential as delimiter between different institutions.
Multiple authors require multiple AUTHOR: lines. All information
associated with TITLE: and AUTHOR: keywords must appear on a single
line.  Here is an example::


        TITLE: On an Ultimate Markup Language
        AUTHOR: H. P. Langtangen at Center for Biomedical Computing, Simula Research Laboratory and Dept. of Informatics, Univ. of Oslo
        AUTHOR: Kaare Dump at Segfault, Cyberspace Inc.
        AUTHOR: A. Dummy Author
        DATE: November 9, 2016

Note the how one can specify a single institution, multiple institutions,
and no institution. In some formats (including reStructuredText and Sphinx)
only the author names appear. Some formats have
"intelligence" in listing authors and institutions, e.g., the plain text
format::


        Hans Petter Langtangen [1, 2]
        Kaare Dump [3]
        A. Dummy Author 
        
        [1] Center for Biomedical Computing, Simula Research Laboratory
        [2] Department of Informatics, University of Oslo
        [3] Segfault, Cyberspace Inc.

Similar typesetting is done for LaTeX and HTML formats.


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

The filename can be without extension, and Doconce will search for an
appropriate file with the right extension. If the extension is wrong,
say .eps when requesting an HTML format, Doconce tries to find another
file, and if not, the given file is converted to a proper format
(using ImageMagick's convert utility).

The height, width, and scale keywords (and others) can be included
if desired and may have effect for some formats. Note the comma
between the sespecifications and that there should be no space
around the = sign.

Note also that, like for TITLE: and AUTHOR: lines, all information
related to a figure line must be written on the same line. Introducing
newlines in a long caption will destroy the formatting (only the
part of the caption appearing on the same line as FIGURE: will be
included in the formatted caption).

FIGURE:
The name and comment are visible in the output unless doconce format
is run with a command-line specification of removing such comments
(see the chapter "From Doconce to Other Formats" for an example). Inline comments
are helpful during development of a document since different authors
and readers can comment on formulations, missing points, etc.
All such comments can easily be removed from the .do.txt file
(see the chapter "From Doconce to Other Formats").

Inline mathematics is written as in LaTeX, i.e., inside dollar signs.
Most formats leave this syntax as it is (including to dollar signs),
hence nice math formatting is only obtained in LaTeX (Epytext has some
inline math support that is utilized).  However, mathematical
expressions in LaTeX syntax often contains special formatting
commands, which may appear annoying in plain text. Doconce therefore
supports an extended inline math syntax where the writer can provide
an alternative syntax suited for formats close to plain ASCII::


        *emphasized words*

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


        _several words in boldface_ followed by *ephasized text*.

This syntax is close that that of labels and cross-references in
LaTeX. When the label is placed after a section or subsection heading,
the plain text, Epytext, and StructuredText formats will simply
replace the reference by the title of the (sub)section.  All labels
will become invisible, except those in math environments.  In the
reStructuredText and Sphinx formats, the end effect is the same, but
the "label" and "ref" commands are first translated to the proper
reStructuredText commands by doconce format. In the HTML and (Google
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
in the section ref{inline:tagging}.

Index and Bibliography
----------------------

An index can be created for the LaTeX and the reStructuredText or
Sphinx formats by the idx keyword, following a LaTeX-inspired syntax::


        `call myroutine(a, b)` looks like a Fortran call
        while `void myfunc(double *a, double *b)` must be C.

The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to::


        some URL like "MyPlace": "http://my.place.in.space/src"

Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and Wiki formats.
Note: idx commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style::


        URL:"manual.do.txt"
        "URL": "manual.do.txt"
        url: "manual.do.txt"
        "url":"manual.do.txt"

Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding cite command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like::


        Click on this link: URL:"http://some.where.net".

if Larsen:86 has already appeared in the 3rd citation in the document
and Nielsen:99 is a new (the 14th) citation. The citation labels
can be any sequence of characters, except for curly braces and comma.

The bibliography itself is specified by the special keyword BIBFILE:,
which is optionally followed by a BibTeX file, having extension .bib,
a corresponding reStructuredText bibliography, having extension .rst,
or simply a Python dictionary written in a file with extension .py.
The dictionary in the latter file should have the citation labels as
keys, with corresponding values as the full reference text for an item
in the bibliography. Doconce markup can be used in this text, e.g.::


        [name: comment]

In the LaTeX format, the .bib file will be used in the standard way,
in the reStructuredText and Sphinx formats, the .rst file will be
copied into the document at the place where the BIBFILE: keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the BIBFILE: line
in the document.

Finally, we must test the citation command and bibliography by 
citing a book [1], a paper [2],
and both of them simultaneously [1] [2].




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


        Here is an example on a linear system 
        ${\bf A}{\bf x} = {\bf b}$|$Ax=b$, 
        where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and 
        $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$.

The pipes and column values do not need to be aligned (but why write
the Doconce source in an ugly way?).


Blocks of Verbatim Computer Code
--------------------------------

Blocks of computer code, to be typeset verbatim, must appear inside a
"begin code" !bc keyword and an "end code" !ec keyword. Both
keywords must be on a single line and *start at the beginning of the
line*.  There may be an argument after the !bc tag to specify a
certain ptex2tex environment (for instance, !bc dat corresponds to
the data file environment in ptex2tex, and !bc cod is typically
used for a code snippet, but any argument can be defined). If there is
no argument, one assumes the ccq environment, which is plain LaTeX
verbatim in the default .ptex2tex.cfg. However, all these arguments
can be redefined in the .ptex2tex.cfg file.

The argument after !bc is also used
in a Sphinx context. Then argument is mapped onto a valid Pygments
language for typesetting of the verbatim block by Pygments. This
mapping takes place in an optional comment to be inserted in the Doconce
source file, e.g.::


        label{section:verbatim}   # defines a label
        For more information we refer to Section ref{section:verbatim}.

Here, three arguments are defined: pycod for Python code,
cod also for Python code, cppcod for C++ code, and sys
for terminal sessions. The same arguments would be defined
in .ptex2tex.cfg for how to typeset the blocks in LaTeX using
various verbatim styles (Pygments can also be used in a LaTeX
context).

By default, pro is used for complete programs in Python, cod
is for a code snippet in Python, while xcod and xpro implies
computer language specific typesetting where x can be
f for Fortran, c for C, cpp for C++, and py for Python.
The argument sys means by default console for Sphinx and
CodeTerminal (ptex2tex environent) for LaTeX. All these definitions
of the arguments after !bc can be redefined in the .ptex2tex.cfg
configuration file for ptex2tex/LaTeX and in the sphinx code-blocks
comments for Sphinx. Support for other languages is easily added.


The enclosing !ec tag of verbatim computer code blocks must
be followed by a newline.  A common error in list environments is to
forget to indent the plain text surrounding the code blocks. In
general, we recommend to use paragraph headings instead of list items
in combination with code blocks (it usually looks better, and some
common errors are naturally avoided).

Here is a verbatim code block with Python code (pycod style)::


        idx{some index entry}
        idx{main entry!subentry}
        idx{`verbatim_text` and more}

And here is a C++ code snippet (cppcod style)::


        \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}


Computer code can be copied directly from a file, if desired. The syntax
is then::


        as found in cite{Larsen:86,Nielsen:99}.

The first line implies that all lines in the file myfile.f are
copied into a verbatim block, typset in a !bc pro environment.  The
second line has a `fromto:' directive, which implies copying code
between two lines in the code, typset within a !`bc cod`
environment. (The pro and cod arguments are only used for LaTeX
and Sphinx output, all other formats will have the code typeset within
a plain !bc environment.) Two regular expressions, separated by the
@ sign, define the "from" and "to" lines.  The "from" line is
included in the verbatim block, while the "to" line is not. In the
example above, we copy code from the line matching subroutine test
(with as many blanks as desired between the two words) and the line
matching C END1 (C followed by 5 blanks and then the text END1). The
final line with the "to" text is not included in the verbatim block.

Let us copy a whole file (the first line above)::


        as found in [3][14]


Let us then copy just a piece in the middle as indicated by the fromto:
directive above::


        {
        'Nielsen:99': """
        K. Nielsen. *Some Comments on Markup Languages*. 
        URL:"http://some.where.net/nielsen/comments", 1999.
        """,
        'Larsen:86': 
        """
        O. B. Larsen. On Markup and Generality.
        *Personal Press*. 1986.
        """
        }


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


          |--------------------------------|
          |time  | velocity | acceleration |
          |--------------------------------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


and these in newcommands_keep.tex::


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console


The LaTeX block::


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

will then be rendered to::

        \begin{eqnarray}
        \x\cdot\normalvec &=& 0,\label{my:eq1}\\
        \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my:eq2}
        \end{eqnarray}

in the current format.

Preprocessing Steps
-------------------

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: Preprocess 
(http://code.google.com/p/preprocess) and Mako
(http://www.makotemplates.org/). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of name=value command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if Preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

Preprocess and Mako always have the variable FORMAT to be the desired
output format of Doconce. It is then easy to test on the value of FORMAT
and take different actions for different formats. For example, one may
create special LaTeX output for figures, say with multiple plots within
a figure, while other formats may apply a separate figure for each plot.


Missing Features
----------------

  * Footnotes

Troubleshooting
---------------

*Disclaimer.* First of all, Doconce has hardly any support for
syntax checking. This means that if you encounter Python errors while
running doconce format, the reason for the error is most likely a
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

*Code or TeX Block Errors in reST.* Sometimes reStructuredText (reST) reports an "Unexpected indentation"
at the beginning of a code block. If you see a !bc, which should
have been removed by doconce format, it is usually an error in the
Doconce source, or a problem with the rst/sphinx translator.  Check if
the line before the code block ends in one colon (not two!), a
question mark, an exclamation mark, a comma, a period, or just a
newline/space after text. If not, make sure that the ending is among
the mentioned. Then !bc will most likely be replaced and a double
colon at the preceding line will appear (which is the right way in
reST to indicate a verbatim block of text).

*Strange Errors Around Code or TeX Blocks in reST.* If idx commands for defining indices are placed inside paragraphs,
and especially right before a code block, the reST translator
(rst and sphinx formats) may get confused and produce strange
code blocks that cause errors when the reST text is transformed to
other formats. The remedy is to define items for the index outside
paragraphs.

*Error Message "Undefined substitution..." from reST.* This may happen if there is much inline math in the text. reST cannot
understand inline LaTeX commands and interprets them as illegal code.
Just ignore these error messages.

*Preprocessor Directives Do Not Work.* Make sure the preprocessor instructions, in Preprocess or Mako, have
correct syntax. Also make sure that you do not mix Preprocess and Mako
instructions. Doconce will then only run Preprocess.

*The LaTeX File Does Not Compile.* If the problem is undefined control sequence involving::


        void myfunc(double* x, const double& myarr) {
            for (int i = 1; i < myarr.size(); i++) {
                myarr[i] = myarr[i] - x[i]*myarr[i-1]
            }
        }

the cause is usually a verbatim inline text (in backquotes in the
Doconce file) spans more than one line. Make sure, in the Doconce source,
that all inline verbatim text appears on the same line.

*Verbatim Code Blocks Inside Lists Look Ugly.* Read the the section "Blocks of Verbatim Computer Code" above.  Start the::


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
        
        *Problems with Boldface and Emphasize.* Two boldface or emphasize expressions after each other are not rendered
        correctly. Merge them into one common expression.
        
        *Strange Non-English Characters.* Check the encoding of the .do.txt file with the Unix file command.
        If UTF-8, convert to latin-1 using the Unix command
        !bc 
         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1

(Doconce has a feature to detect the encoding, but it is not reliable and
therefore turned off.)

*Debugging.* Given a problem, extract a small portion of text surrounding the
problematic area and debug that small piece of text. Doconce does a
series of transformations of the text. The effect of each of these
transformation steps are dumped to a logfile, named
_doconce_debugging.log, if the to doconce format after the filename
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


              subroutine    test()
              integer i
              real*8 r
              r = 0
              do i = 1, i
                 r = r + i
              end do
              return
        



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
context.  If the output format is Epytext (Epydoc) or Sphinx, such lists of
arguments and variables are nicely formatted::


        \newcommand{\beqa}{\begin{eqnarray}}
        \newcommand{\eeqa}{\end{eqnarray}}
        \newcommand{\ep}{\thinspace . }
        \newcommand{\uvec}{\vec u}
        \newcommand{\mathbfx}[1]{{\mbox{\boldmath $#1$}}}
        \newcommand{\Q}{\mathbfx{Q}}
        


The result depends on the output format: all formats except Epytext 
and Sphinx just typeset the list as a list with keywords.

    module variable x: 
      x value (float),
      which must be a positive number.

    module variable tolerance: 
      tolerance (float) for stopping
      the iterations.

Bibliography
============

  1. H. P. Langtangen. *A Primer on Scientific Programming with Python*. Springer, 2009.

  2. H. Osnes and H. P. Langtangen. An efficient probabilistic finite element method for stochastic  groundwater flow. *Advances in Water Resources*, vol 22, 185-195, 1998.