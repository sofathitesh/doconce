
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
idx{figures}

Test of figures.

FIGURE:[../doc/manual/figs/streamtubes, width=200] Visualization of flow by streamtubes. label{fig:impact}

idx{movies}
Test of movies.

MOVIE: [../doc/manual/figs/mjolnir.mpeg, width=700 height=400] Mjolnir tsunami (by Sylfest Glimsdal).

# Empty caption:

MOVIE: [../doc/manual/figs/wavepacket.mpeg, width=700 height=400]

MOVIE: [../doc/manual/figs/wavepacket_*.png, width=700 height=400] Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie).

# Check out the correct with and height of YouTube movies from the
# embed command that the YouTube page can generate

MOVIE: [http://www.youtube.com/embed/7cC-_-aqx18, width=420 height=315] Movies can be uploaded to YouTube and embedded as HTML or as a link.

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
  |--l--------r-----------r--------|
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
  |--l--------r-----------r--------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
!ec

Here is yet another table to test that we can handle more than
one table:

  |--l-------l----------l----------|
  |time  | velocity | acceleration |
  |--l-------l----------l----------|
  | 0.0  | 1.4186   | -5.01        |
  | 1.0  | 1.376512 | 11.919       |
  | 3.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|

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

Let's check abbr. of some common kind, e.g. the well-known i.e. 
7-9 as an example. Moreover, Dr. Tang and Prof. Monsen, 
or maybe also prof. Ting,
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
Test of figures.

<P>
<IMG SRC="../doc/manual/figs/streamtubes.png" ALIGN="bottom"  width=200> <P><EM> Visualization of flow by streamtubes. <A NAME="fig:impact"></A></EM></P>

<P>
Test of movies.

<P>

<EMBED SRC="../doc/manual/figs/mjolnir.mpeg" width=700 height=400 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
<P>
<EM> Mjolnir tsunami (by Sylfest Glimsdal).</EM>
</P>


<P>
<!-- Empty caption: -->

<P>

<EMBED SRC="../doc/manual/figs/wavepacket.mpeg" width=700 height=400 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
<P>
<EM></EM>
</P>


<P>

<P><A HREF="wavepacket_0001.html">Movie of files <TT>../doc/manual/figs/wavepacket_*.png</TT></A>
<EM> Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie).</EM></P>

<P>
<!-- Check out the correct with and height of YouTube movies from the -->
<!-- embed command that the YouTube page can generate -->

<P>

<iframe width="420" height="315" src="http://www.youtube.com/embed/7cC-_-aqx18" frameborder="0" allowfullscreen></iframe>


<P>
<H3>Table Demo <A NAME="subsec:table"></A></H3>
<P>

<P>
Let us take this table from the manual:

<P>

<P>
<TABLE border="1">
<TR><TD align="center"><B>    time    </B></TD> <TD align="center"><B>  velocity  </B></TD> <TD align="center"><B>acceleration</B></TD> </TR>
<TR><TD align="left">   0.0             </TD> <TD align="right">   1.4186          </TD> <TD align="right">   -5.01           </TD> </TR>
<TR><TD align="left">   2.0             </TD> <TD align="right">   1.376512        </TD> <TD align="right">   11.919          </TD> </TR>
<TR><TD align="left">   4.0             </TD> <TD align="right">   1.1E+1          </TD> <TD align="right">   14.717624       </TD> </TR>
</TABLE>
<P>

<P>
The Doconce source code reads
<!-- BEGIN VERBATIM BLOCK   cod-->
<BLOCKQUOTE><PRE>
  |--------------------------------|
  |time  | velocity | acceleration |
  |--l--------r-----------r--------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
Here is yet another table to test that we can handle more than
one table:

<P>
<TABLE border="1">
<TR><TD align="center"><B>    time    </B></TD> <TD align="center"><B>  velocity  </B></TD> <TD align="center"><B>acceleration</B></TD> </TR>
<TR><TD align="left">   0.0             </TD> <TD align="left">   1.4186          </TD> <TD align="left">   -5.01           </TD> </TR>
<TR><TD align="left">   1.0             </TD> <TD align="left">   1.376512        </TD> <TD align="left">   11.919          </TD> </TR>
<TR><TD align="left">   3.0             </TD> <TD align="left">   1.1E+1          </TD> <TD align="left">   14.717624       </TD> </TR>
</TABLE>
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
\usepackage{relsize,epsfig,makeidx,amsmath,amsfonts}
\usepackage[colorlinks=true,linkcolor=blue,citecolor=black,filecolor=blue,urlcolor=blue]{hyperref}
\usepackage[latin1]{inputenc}
\usepackage{ptex2tex}
% #ifdef MOVIE15
\usepackage{movie15}
% #endif
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
\index{figures}

Test of figures.


\begin{figure}
  \centerline{\includegraphics[width=0.9\linewidth]{../doc/manual/figs/streamtubes.eps}}  
  \caption{
  Visualization of flow by streamtubes. \label{fig:impact}
  % \label{fig:streamtubes}  % (autogenerated label, not used anymore)
  }
\end{figure}


\index{movies}
Test of movies.


\begin{figure}[ht]
\begin{center}

% #ifdef MOVIE15
\includemovie[poster,
label=../doc/manual/figs/mjolnir.mpeg,
autoplay,
%controls,
%toolbar,
% #ifdef EXTERNAL_MOVIE_VIEWER
externalviewer,
% #endif
text={\small (Loading ../doc/manual/figs/mjolnir.mpeg)},
repeat,
]{0.9\linewidth}{0.9\linewidth}{../doc/manual/figs/mjolnir.mpeg}    % requires \usepackage{movie15}
% #ifndef EXTERNAL_MOVIE_VIEWER
\movieref[rate=0.5]{../doc/manual/figs/mjolnir.mpeg}{Slower}
\movieref[rate=2]{../doc/manual/figs/mjolnir.mpeg}{Faster}
\movieref[default]{../doc/manual/figs/mjolnir.mpeg}{Normal}
\movieref[pause]{../doc/manual/figs/mjolnir.mpeg}{Play/Pause}
\movieref[stop]{../doc/manual/figs/mjolnir.mpeg}{Stop}
% #else
\href{run:../doc/manual/figs/mjolnir.mpeg}{../doc/manual/figs/mjolnir.mpeg}
% #endif

% #else
\href{run:../doc/manual/figs/mjolnir.mpeg}{../doc/manual/figs/mjolnir.mpeg}

% alternative: \movie command that comes with beamer
% \movie[options]{../doc/manual/figs/mjolnir.mpeg}{../doc/manual/figs/mjolnir.mpeg}
% #endif
\end{center}
\caption{ Mjolnir tsunami (by Sylfest Glimsdal).}
\end{figure}


% Empty caption:


\begin{figure}[ht]
\begin{center}

% #ifdef MOVIE15
\includemovie[poster,
label=../doc/manual/figs/wavepacket.mpeg,
autoplay,
%controls,
%toolbar,
% #ifdef EXTERNAL_MOVIE_VIEWER
externalviewer,
% #endif
text={\small (Loading ../doc/manual/figs/wavepacket.mpeg)},
repeat,
]{0.9\linewidth}{0.9\linewidth}{../doc/manual/figs/wavepacket.mpeg}    % requires \usepackage{movie15}
% #ifndef EXTERNAL_MOVIE_VIEWER
\movieref[rate=0.5]{../doc/manual/figs/wavepacket.mpeg}{Slower}
\movieref[rate=2]{../doc/manual/figs/wavepacket.mpeg}{Faster}
\movieref[default]{../doc/manual/figs/wavepacket.mpeg}{Normal}
\movieref[pause]{../doc/manual/figs/wavepacket.mpeg}{Play/Pause}
\movieref[stop]{../doc/manual/figs/wavepacket.mpeg}{Stop}
% #else
\href{run:../doc/manual/figs/wavepacket.mpeg}{../doc/manual/figs/wavepacket.mpeg}
% #endif

% #else
\href{run:../doc/manual/figs/wavepacket.mpeg}{../doc/manual/figs/wavepacket.mpeg}

% alternative: \movie command that comes with beamer
% \movie[options]{../doc/manual/figs/wavepacket.mpeg}{../doc/manual/figs/wavepacket.mpeg}
% #endif
\end{center}
\caption{}
\end{figure}



 Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie). (Movie of files \code{../doc/manual/figs/wavepacket_*.png} in \href{file:///home/hpl/vc/doconce/test/wavepacket_0001.html}{\nolinkurl{file:///home/hpl/vc/doconce/test/wavepacket_0001.html}})


% Check out the correct with and height of YouTube movies from the
% embed command that the YouTube page can generate

 Movies can be uploaded to YouTube and embedded as HTML or as a link.: \href{http://www.youtube.com/watch?v=7cC-_-aqx18}{\nolinkurl{http://www.youtube.com/watch?v=7cC-_-aqx18}}

\subsection{Table Demo}

\label{subsec:table}

Let us take this table from the manual:
\index{some class X@some {\rm\texttt{class X}} which is convenient}

\begin{table}
\caption{
Table of velocity and acceleration.
\label{mytab}
}


\begin{quote}\begin{tabular}{lrr}
\hline
\multicolumn{1}{c}{time} & \multicolumn{1}{c}{velocity} & \multicolumn{1}{c}{acceleration} \\
\hline
0.0          & 1.4186       & -5.01        \\
2.0          & 1.376512     & 11.919       \\
4.0          & 1.1E+1       & 14.717624    \\
\hline
\end{tabular}\end{quote}

\noindent
\end{table}

The Doconce source code reads
\bcod
  |--------------------------------|
  |time  | velocity | acceleration |
  |--l--------r-----------r--------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
\ecod

Here is yet another table to test that we can handle more than
one table:


\begin{quote}\begin{tabular}{lll}
\hline
\multicolumn{1}{c}{time} & \multicolumn{1}{c}{velocity} & \multicolumn{1}{c}{acceleration} \\
\hline
0.0          & 1.4186       & -5.01        \\
1.0          & 1.376512     & 11.919       \\
3.0          & 1.1E+1       & 14.717624    \\
\hline
\end{tabular}\end{quote}

\noindent

\subsection{URLs}

\label{subsubsec:ex}

Here are some nice URLs, e.g., hpl's home page \href{http://folk.uio.no/hpl}{hpl},
or the URL if desired, \href{http://folk.uio.no/hpl}{\nolinkurl{http://folk.uio.no/hpl}}.
Here is a plain file link \href{testdoc.do.txt}{\nolinkurl{testdoc.do.txt}}, or \href{testdoc.do.txt}{\nolinkurl{testdoc.do.txt}},
or \href{testdoc.do.txt}{\nolinkurl{testdoc.do.txt}} or \href{testdoc.do.txt}{\nolinkurl{testdoc.do.txt}}. Can test spaces
with the link with word too: \href{http://folk.uio.no/hpl}{hpl} or
\href{http://folk.uio.no/hpl}{hpl}. The old syntax must also be
tested: \href{http://folk.uio.no/hpl}{hpl's homepage}. Now also \code{file:///}
works: \href{file:///home/hpl/vc/doconce/trunk/test/tmp_HTML.html}{link to a file}
is fine to have.

% Comments should be inserted outside paragraphs (because of reST):
% note that when there is no http: or file:, it can be a file link
% if the link name is URL, url, "URL", or "url".

\subsection{Some {\LaTeX} Constructs}

Let's check abbr.~of some common kind, e.g.~the well-known i.e. 
7-9 as an example. Moreover, Dr.~Tang and Prof.~Monsen, 
or maybe also prof.~Ting,
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
!et

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

Test of figures.


.. _fig:impact:

.. figure:: ../doc/manual/figs/streamtubes.png
   :width: 200

   Visualization of flow by streamtubes  (fig:impact)


Test of movies.

.. raw:: html
        
        <EMBED SRC="../doc/manual/figs/mjolnir.mpeg" width=700 height=400 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
        <P>
        <EM> Mjolnir tsunami (by Sylfest Glimsdal).</EM>
        </P>



.. Empty caption:


.. raw:: html
        
        <EMBED SRC="../doc/manual/figs/wavepacket.mpeg" width=700 height=400 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
        <P>
        <EM></EM>
        </P>



.. raw:: html
        
        <P><A HREF="wavepacket_0001.html">Movie of files <TT>../doc/manual/figs/wavepacket_*.png</TT></A>
        <EM> Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie).</EM></P>



.. Check out the correct with and height of YouTube movies from the

.. embed command that the YouTube page can generate


.. raw:: html
        
        <iframe width="420" height="315" src="http://www.youtube.com/embed/7cC-_-aqx18" frameborder="0" allowfullscreen></iframe>



.. _subsec:table:

Table Demo
----------

Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0                 1.4186         -5.01  
2.0               1.376512        11.919  
4.0                 1.1E+1     14.717624  
============  ============  ============  


The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--l--------r-----------r--------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


Here is yet another table to test that we can handle more than
one table:

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
1.0           1.376512      11.919        
3.0           1.1E+1        14.717624     
============  ============  ============  

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

.. index:: figures


Test of figures.


.. _fig:impact:

.. figure:: ../doc/manual/figs/streamtubes.png
   :width: 200

   Visualization of flow by streamtubes  



.. index:: movies

Test of movies.

.. raw:: html
        
        <EMBED SRC="../doc/manual/figs/mjolnir.mpeg" width=700 height=400 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
        <P>
        <EM> Mjolnir tsunami (by Sylfest Glimsdal).</EM>
        </P>



.. Empty caption:


.. raw:: html
        
        <EMBED SRC="../doc/manual/figs/wavepacket.mpeg" width=700 height=400 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
        <P>
        <EM></EM>
        </P>



.. raw:: html
        
        <P><A HREF="wavepacket_0001.html">Movie of files <TT>../doc/manual/figs/wavepacket_*.png</TT></A>
        <EM> Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie).</EM></P>



.. Check out the correct with and height of YouTube movies from the

.. embed command that the YouTube page can generate


.. raw:: html
        
        <iframe width="420" height="315" src="http://www.youtube.com/embed/7cC-_-aqx18" frameborder="0" allowfullscreen></iframe>



.. _subsec:table:

Table Demo
----------

Let us take this table from the manual:

.. index:: some class X which is convenient



============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0                 1.4186         -5.01  
2.0               1.376512        11.919  
4.0                 1.1E+1     14.717624  
============  ============  ============  


The Doconce source code reads

.. code-block:: python

          |--------------------------------|
          |time  | velocity | acceleration |
          |--l--------r-----------r--------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


Here is yet another table to test that we can handle more than
one table:

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
1.0           1.376512      11.919        
3.0           1.1E+1        14.717624     
============  ============  ============  

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

Test of figures.



---------------------------------------------------------------

Figure:  Visualization of flow by streamtubes. (fig:impact)

(the URL of the image file ../doc/manual/figs/streamtubes.png must be inserted here)

<wiki:comment> 
Put the figure file ../doc/manual/figs/streamtubes.png on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------



Test of movies.

 Mjolnir tsunami (by Sylfest Glimsdal). (Movie ../doc/manual/figs/mjolnir.mpeg: play mjolnir.html)

<wiki:comment> Empty caption: </wiki:comment>

 (Movie ../doc/manual/figs/wavepacket.mpeg: play wavepacket.html)


 Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie). (Movie of files `../doc/manual/figs/wavepacket_*.png` in wavepacket_0001.html)


<wiki:comment> Check out the correct with and height of YouTube movies from the </wiki:comment>
<wiki:comment> embed command that the YouTube page can generate </wiki:comment>

MOVIE: Movies can be uploaded to YouTube and embedded as HTML or as a link.

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
  |--l--------r-----------r--------|
  | 0.0  | 1.4186   | -5.01        |
  | 2.0  | 1.376512 | 11.919       |
  | 4.0  | 1.1E+1   | 14.717624    |
  |--------------------------------|
}}}

Here is yet another table to test that we can handle more than
one table:


 ||      *time*       ||    *velocity*     ||  *acceleration*   ||
 ||  0.0              ||  1.4186           ||  -5.01            ||
 ||  1.0              ||  1.376512         ||  11.919           ||
 ||  3.0              ||  1.1E+1           ||  14.717624        ||

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
Test of figures.

FIGURE:[../doc/manual/figs/streamtubes, width=200] Visualization of flow by streamtubes. {fig:impact}

Test of movies.

 Mjolnir tsunami (by Sylfest Glimsdal). (Movie ../doc/manual/figs/mjolnir.mpeg: play "mjolnir.html":mjolnir.html)


 (Movie ../doc/manual/figs/wavepacket.mpeg: play "wavepacket.html":wavepacket.html)


 Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie). (Movie of files '../doc/manual/figs/wavepacket_*.png' in "wavepacket_0001.html":wavepacket_0001.html)



 Movies can be uploaded to YouTube and embedded as HTML or as a link.: "http://www.youtube.com/watch?v=7cC-_-aqx18":http://www.youtube.com/watch?v=7cC-_-aqx18
Table Demo
Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0                 1.4186         -5.01  
2.0               1.376512        11.919  
4.0                 1.1E+1     14.717624  
============  ============  ============  


The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--l--------r-----------r--------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


Here is yet another table to test that we can handle more than
one table:

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
1.0           1.376512      11.919        
3.0           1.1E+1        14.717624     
============  ============  ============  
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


Test of figures.

FIGURE:[../doc/manual/figs/streamtubes, width=200] Visualization of flow by streamtubes. {fig:impact}

Test of movies.

 Mjolnir tsunami (by Sylfest Glimsdal). (Movie ../doc/manual/figs/mjolnir.mpeg: play U{mjolnir.html<mjolnir.html>})


 (Movie ../doc/manual/figs/wavepacket.mpeg: play U{wavepacket.html<wavepacket.html>})


 Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie). (Movie of files C{../doc/manual/figs/wavepacket_*.png} in U{wavepacket_0001.html<wavepacket_0001.html>})



 Movies can be uploaded to YouTube and embedded as HTML or as a link.: U{http://www.youtube.com/watch?v=7cC-_-aqx18<http://www.youtube.com/watch?v=7cC-_-aqx18>}

Table Demo
----------

Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0                 1.4186         -5.01  
2.0               1.376512        11.919  
4.0                 1.1E+1     14.717624  
============  ============  ============  


The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--l--------r-----------r--------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


Here is yet another table to test that we can handle more than
one table:

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
1.0           1.376512      11.919        
3.0           1.1E+1        14.717624     
============  ============  ============  

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


Test of figures.

FIGURE:[../doc/manual/figs/streamtubes, width=200] Visualization of flow by streamtubes. {fig:impact}

Test of movies.

 Mjolnir tsunami (by Sylfest Glimsdal). (Movie ../doc/manual/figs/mjolnir.mpeg: play mjolnir.html)


 (Movie ../doc/manual/figs/wavepacket.mpeg: play wavepacket.html)


 Movie based on collection of frames (here just a few frames compared with the full wavepacket.mpeg movie). (Movie of files ../doc/manual/figs/wavepacket_*.png in wavepacket_0001.html)



 Movies can be uploaded to YouTube and embedded as HTML or as a link.: http://www.youtube.com/watch?v=7cC-_-aqx18

Table Demo
----------

Let us take this table from the manual:


============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0                 1.4186         -5.01  
2.0               1.376512        11.919  
4.0                 1.1E+1     14.717624  
============  ============  ============  


The Doconce source code reads::


          |--------------------------------|
          |time  | velocity | acceleration |
          |--l--------r-----------r--------|
          | 0.0  | 1.4186   | -5.01        |
          | 2.0  | 1.376512 | 11.919       |
          | 4.0  | 1.1E+1   | 14.717624    |
          |--------------------------------|


Here is yet another table to test that we can handle more than
one table:

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
0.0           1.4186        -5.01         
1.0           1.376512      11.919        
3.0           1.1E+1        14.717624     
============  ============  ============  

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





************** File: tmp_encoding.txt *****************
NOT FOUND!
************** File: make.sh *****************
#!/bin/sh -x
# Test multiple authors
doconce format HTML testdoc.do.txt
doconce format LaTeX testdoc.do.txt
doconce format plain testdoc.do.txt
doconce format st testdoc.do.txt
doconce format sphinx testdoc.do.txt
mv -f testdoc.rst testdoc.sphinx.rst
doconce format rst testdoc.do.txt
doconce format epytext testdoc.do.txt
# Test mako variables too
doconce format gwiki testdoc.do.txt remove_inline_comments MYVAR1=3 MYVAR2='a string'

# Test encoding
doconce guess_encoding encoding1.do.txt > tmp_encodings.txt
cp encoding1.do.txt tmp1.do.txt
doconce change_encoding utf-8 latin1 tmp1.do.txt
doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt
doconce change_encoding latin1 utf-8 tmp1.do.txt
doconce guess_encoding tmp1.do.txt >> tmp_encodings.txt

doconce guess_encoding encoding2.do.txt >> tmp_encodings.txt
cp encoding1.do.txt tmp2.do.txt
doconce change_encoding utf-8 latin1 tmp2.do.txt
doconce guess_encoding tmp2.do.txt >> tmp_encodings.txt


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
ps2pdf tutorial.do.ps tutorial.do.pdf
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
doconce format rst    tutorial.do.txt  # standard reST
doconce format sphinx tutorial.do.txt  # Sphinx extension of reST
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
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?

 * Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?

 * Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?

If any of these questions are of interest, you should keep on reading.


======= The Doconce Concept  =======

Doconce is two things:

  o Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
    

  o Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
    


Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.
  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 



======= What Does Doconce Look Like? =======

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim (monospace font),

  * section headings are recognied by equality (`=`) signs before 
    and after the text, and the number of `=` signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),

  * paragraph headings are recognized by a double underscore
    before and after the heading,

  * blocks of computer code can easily be included by placing 
    `!bc` (begin code) and `!ec` (end code) commands at separate lines
    before and after the code block,

  * blocks of computer code can also be imported from source files,

  * blocks of LaTeX mathematics can easily be included by placing
    `!bt` (begin TeX) and `!et` (end TeX) commands at separate lines
    before and after the math block,
 
  * there is support for both LaTeX and text-like inline mathematics,

  * figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,

  * comments can be inserted throughout the text (`#` at the beginning
    of a line),

  * with a simple preprocessor, Preprocess or Mako, one can include
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
  |---r-------r-----------r--------|
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
  |---r-------r-----------r--------|
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
syntax we refer to the `doc/manual/manual.do.txt` file (see the
"demo page": "https://doconce.googlecode.com/hg/doc/demos/manual/index.html"
for various formats of this document).


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
"Here": "https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html"
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
If translation to "Pandoc": "http://johnmacfarlane.net/pandoc/" is desired, 
the Pandoc Haskell program must of course be installed.



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


<CENTER><H3>Oct 22, 2011</H3></CENTER>
<P>

<P>

<UL>
 <LI> When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?
 <LI> Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?
 <LI> Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?
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
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 <LI> Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
</OL>

Here are some Doconce features:

<P>

<UL>
  <LI> Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  <LI> Doconce can be converted to plain <EM>untagged</EM> text, 
    often desirable for computer programs and email.
  <LI> Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  <LI> Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  <LI> Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  <LI> Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.
</UL>

Doconce was particularly written for the following sample applications:

<P>

<UL>
  <LI> Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.
  <LI> Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.
  <LI> Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.
</UL>

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

<P>
Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 

<P>

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
    then typeset verbatim (monospace font),
  <LI> section headings are recognied by equality (<TT>=</TT>) signs before 
    and after the text, and the number of <TT>=</TT> signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),
  <LI> paragraph headings are recognized by a double underscore
    before and after the heading,
  <LI> blocks of computer code can easily be included by placing 
    <TT>!bc</TT> (begin code) and <TT>!ec</TT> (end code) commands at separate lines
    before and after the code block,
  <LI> blocks of computer code can also be imported from source files,
  <LI> blocks of LaTeX mathematics can easily be included by placing
    <TT>!bt</TT> (begin TeX) and <TT>!et</TT> (end TeX) commands at separate lines
    before and after the math block,
  <LI> there is support for both LaTeX and text-like inline mathematics,
  <LI> figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,
  <LI> comments can be inserted throughout the text (<TT>#</TT> at the beginning
    of a line),
  <LI> with a simple preprocessor, Preprocess or Mako, one can include
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
  |---r-------r-----------r--------|
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
<TR><TD align="center"><B>    time    </B></TD> <TD align="center"><B>  velocity  </B></TD> <TD align="center"><B>acceleration</B></TD> </TR>
<TR><TD align="right">   0.0             </TD> <TD align="right">   1.4186          </TD> <TD align="right">   -5.01           </TD> </TR>
<TR><TD align="right">   2.0             </TD> <TD align="right">   1.376512        </TD> <TD align="right">   11.919          </TD> </TR>
<TR><TD align="right">   4.0             </TD> <TD align="right">   1.1E+1          </TD> <TD align="right">   14.717624       </TD> </TR>
</TABLE>
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
syntax we refer to the <TT>doc/manual/manual.do.txt</TT> file (see the
<A HREF="https://doconce.googlecode.com/hg/doc/demos/manual/index.html">demo page</A>
for various formats of this document).

<P>

<P>
<!-- Example on including another Doconce file (using preprocess): -->

<P>

<P>
<H1>From Doconce to Other Formats <A NAME="doconce2formats"></A></H1>
<P>

<P>
Transformation of a Doconce document <TT>mydoc.do.txt</TT> to various other
formats applies the script <TT>doconce format</TT>:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format format mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format format mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>mako</TT> or <TT>preprocess</TT> programs are always used to preprocess the
file first, and options to <TT>mako</TT> or <TT>preprocess</TT> can be added after the
filename. For example,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako
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
Terminal> doconce format LaTeX mydoc remove_inline_comments
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
One can also remove such comments from the original Doconce file
by running 
source code:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Terminal> doconce remove_inline_comments mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.

<P>

<P>
<H3>HTML</H3>
<P>
Making an HTML version of a Doconce file <TT>mydoc.do.txt</TT>
is performed by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format HTML mydoc
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
Terminal> doconce format LaTeX mydoc
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
Terminal> ptex2tex mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just perform a plain copy,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> cp mydoc.p.tex mydoc.tex
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Doconce generates a <TT>.p.tex</TT> file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DHELVETICA mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc
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
Terminal> latex mydoc
Terminal> latex mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex mydoc
Terminal> dvipdf mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
If one wishes to use the <TT>Minted_Python</TT>, <TT>Minted_Cpp</TT>, etc., environments
in <TT>ptex2tex</TT> for typesetting code, the <TT>minted</TT> LaTeX package is needed.
This package is included by running <TT>doconce format</TT> with the
<TT>-DMINTED</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DMINTED mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In this case, <TT>latex</TT> must be run with the
<TT>-shell-escape</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> latex -shell-escape mydoc
Terminal> latex -shell-escape mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex -shell-escape mydoc
Terminal> dvipdf mydoc
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
Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt
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
Terminal> doconce format rst mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
We may now produce various other formats:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
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
Terminal> doconce format sphinx mydoc.do.txt
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
These statements as well as points 3-5 can be automated by the command
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce sphinx_dir mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
More precisely, in addition to making the <TT>sphinx-rootdir</TT>,
this command generates a script <TT>tmp_make_sphinx.sh</TT> which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

<P>
<B>Step 3.</B> Move the <TT>tutorial.rst</TT> file to the Sphinx root directory:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> mv mydoc.rst sphinx-rootdir
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
Terminal> firefox _build/html/index.html
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
Terminal> doconce format gwiki mydoc.do.txt
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
<A HREF="https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html">Here</A>
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
If translation to <A HREF="http://johnmacfarlane.net/pandoc/">Pandoc</A> is desired, 
the Pandoc Haskell program must of course be installed.

<P>

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

:Date: Oct 22, 2011

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?

 * Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?

 * Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 

  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.

  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.

  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 



What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * **words in boldface** are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim (monospace font),

  * section headings are recognied by equality (``=``) signs before 
    and after the text, and the number of ``=`` signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),

  * paragraph headings are recognized by a double underscore
    before and after the heading,

  * blocks of computer code can easily be included by placing 
    ``!bc`` (begin code) and ``!ec`` (end code) commands at separate lines
    before and after the code block,

  * blocks of computer code can also be imported from source files,

  * blocks of LaTeX mathematics can easily be included by placing
    ``!bt`` (begin TeX) and ``!et`` (end TeX) commands at separate lines
    before and after the math block,

  * there is support for both LaTeX and text-like inline mathematics,

  * figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,

  * comments can be inserted throughout the text (``#`` at the beginning
    of a line),

  * with a simple preprocessor, Preprocess or Mako, one can include
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
          |---r-------r-----------r--------|
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
syntax we refer to the ``doc/manual/manual.do.txt`` file (see the
`demo page <https://doconce.googlecode.com/hg/doc/demos/manual/index.html>`_
for various formats of this document).


.. Example on including another Doconce file (using preprocess):



.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document ``mydoc.do.txt`` to various other
formats applies the script ``doconce format``::


        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The ``mako`` or ``preprocess`` programs are always used to preprocess the
file first, and options to ``mako`` or ``preprocess`` can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many

.. formats - the text may be messed up. A better choice is a paragraph

.. environment, as used here.


*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``::


        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section `Macros (Newcommands), Cross-References, Index, and Bibliography`_). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any ``!bc sys`` command in the Doconce source you can
insert verbatim block styles as defined in your ``.ptex2tex.cfg``
file, e.g., ``!bc sys cod`` for a code snippet, where ``cod`` is set to
a certain environment in ``.ptex2tex.cfg`` (e.g., ``CodeIntended``).
There are over 30 styles to choose from.

*Step 3.* Compile ``mydoc.tex``
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``::


        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file ``mydoc.odt`` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the ``sphinx-rootdir``,
this command generates a script ``tmp_make_sphinx.sh`` which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


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


        Terminal> doconce format gwiki mydoc.do.txt

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
`Here <https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html>`_
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
If translation to `Pandoc <http://johnmacfarlane.net/pandoc/>`_ is desired, 
the Pandoc Haskell program must of course be installed.
************** File: tutorial.sphinx.rst *****************
.. Automatically generated reST file from Doconce source 
   (http://code.google.com/p/doconce/)

Doconce: Document Once, Include Anywhere
========================================

:Author: Hans Petter Langtangen

:Date: Oct 22, 2011

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?

 * Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?

 * Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 

  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.

  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.

  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 



What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * **words in boldface** are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim (monospace font),

  * section headings are recognied by equality (``=``) signs before 
    and after the text, and the number of ``=`` signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),

  * paragraph headings are recognized by a double underscore
    before and after the heading,

  * blocks of computer code can easily be included by placing 
    ``!bc`` (begin code) and ``!ec`` (end code) commands at separate lines
    before and after the code block,

  * blocks of computer code can also be imported from source files,

  * blocks of LaTeX mathematics can easily be included by placing
    ``!bt`` (begin TeX) and ``!et`` (end TeX) commands at separate lines
    before and after the math block,

  * there is support for both LaTeX and text-like inline mathematics,

  * figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,

  * comments can be inserted throughout the text (``#`` at the beginning
    of a line),

  * with a simple preprocessor, Preprocess or Mako, one can include
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
          |---r-------r-----------r--------|
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
syntax we refer to the ``doc/manual/manual.do.txt`` file (see the
`demo page <https://doconce.googlecode.com/hg/doc/demos/manual/index.html>`_
for various formats of this document).


.. Example on including another Doconce file (using preprocess):



.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document ``mydoc.do.txt`` to various other
formats applies the script ``doconce format``:

.. code-block:: console

        Terminal> doconce format format mydoc.do.txt

or just

.. code-block:: console

        Terminal> doconce format format mydoc

The ``mako`` or ``preprocess`` programs are always used to preprocess the
file first, and options to ``mako`` or ``preprocess`` can be added after the
filename. For example,

.. code-block:: console

        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by

.. code-block:: console

        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code:

.. code-block:: py


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by

.. code-block:: console

        Terminal> doconce format HTML mydoc

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

        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section :ref:`newcommands`). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file,

.. code-block:: console

        Terminal> ptex2tex mydoc

or just perform a plain copy,

.. code-block:: console

        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run

.. code-block:: console

        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through

.. code-block:: console

        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


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

        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option:

.. code-block:: console

        Terminal> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option:

.. code-block:: console

        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:

.. code-block:: console

        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``:

.. code-block:: console

        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats:

.. code-block:: console

        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file ``mydoc.odt`` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format:

.. code-block:: console

        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command

.. code-block:: console

        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the ``sphinx-rootdir``,
this command generates a script ``tmp_make_sphinx.sh`` which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory:

.. code-block:: console

        Terminal> mv mydoc.rst sphinx-rootdir

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

        Terminal> firefox _build/html/index.html


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

        Terminal> doconce format gwiki mydoc.do.txt

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
`Here <https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html>`_
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
If translation to `Pandoc <http://johnmacfarlane.net/pandoc/>`_ is desired, 
the Pandoc Haskell program must of course be installed.
************** File: tutorial.gwiki *****************
#summary Doconce: Document Once, Include Anywhere
<wiki:toc max_depth="2" />
By *Hans Petter Langtangen*

==== Oct 22, 2011 ====

 * When writing a note, report, manual, etc., do you find it difficult   to choose the typesetting format? That is, to choose between plain   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,   reStructuredText, Sphinx, XML, etc.  Would it be convenient to   start with some very simple text-like format that easily converts   to the formats listed above, and then at some later stage   eventually go with a particular format?
 * Do you need to write documents in varying formats but find it   difficult to remember all the typesetting details of various   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient   to generate the typesetting details of a particular format from a   very simple text-like format with minimal tagging?
 * Do you have the same information scattered around in different   documents in different typesetting formats? Would it be a good idea   to write things once, in one format, stored in one place, and   include it anywhere?

If any of these questions are of interest, you should keep on reading.



== The Doconce Concept ==

Doconce is two things:


 # Doconce is a very simple and minimally tagged markup language that    looks like ordinary ASCII text (much like what you would use in an    email), but the text can be transformed to numerous other formats,    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,    Epytext, and also plain text (where non-obvious formatting/tags are    removed for clear reading in, e.g., emails). From reStructuredText    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the    latter to RTF and MS Word.    (An experimental translator to Pandoc is under development, and from    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 # Doconce is a working strategy for never duplicating information.    Text is written in a single place and then transformed to    a number of different destinations of diverse type (software    source code, manuals, tutorials, books, wikis, memos, emails, etc.).    The Doconce markup language support this working strategy.    The slogan is: "Write once, include anywhere".

Here are some Doconce features:


  * Doconce markup does include tags, so the format is more tagged than     Markdown and Pandoc, but less than reST, and very much less than     LaTeX and HTML. 
  * Doconce can be converted to plain *untagged* text,     often desirable for computer programs and email.
  * Doconce has good support for copying in parts of computer code,    say in examples, directly from the source code files.
  * Doconce has full support for LaTeX math, and integrates very well    with big LaTeX projects (books).
  * Doconce is almost self-explanatory and is a handy starting point    for generating documents in more complicated markup languages, such    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce    is just to make the initial versions of a Sphinx or wiki document.
  * Contrary to the similar Pandoc translator, Doconce integrates with    Sphinx and Google wiki. However, if these formats are not of interest,    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:


  * Large books written in LaTeX, but where many pieces (computer demos,    projects, examples) can be written in Doconce to appear in other    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.
  * Software documentation, primarily Python doc strings, which one wants    to appear as plain untagged text for viewing in Pydoc, as reStructuredText    for use with Sphinx, as wiki text when publishing the software at    web sites, and as LaTeX integrated in, e.g., a thesis.
  * Quick memos, which start as plain text in email, then some small    amount of Doconce tagging is added, before the memos can appear as    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 



== What Does Doconce Look Like? ==

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,


  * bullet lists arise from lines starting with an asterisk,
  * *emphasized words* are surrounded by asterisks, 
  * *words in boldface* are surrounded by underscores, 
  * words from computer code are enclosed in back quotes and     then typeset verbatim (monospace font),
  * section headings are recognied by equality (`=`) signs before     and after the text, and the number of `=` signs indicates the     level of the section (7 for main section, 5 for subsection,    3 for subsubsection),
  * paragraph headings are recognized by a double underscore    before and after the heading,
  * blocks of computer code can easily be included by placing     `!bc` (begin code) and `!ec` (end code) commands at separate lines    before and after the code block,
  * blocks of computer code can also be imported from source files,
  * blocks of LaTeX mathematics can easily be included by placing    `!bt` (begin TeX) and `!et` (end TeX) commands at separate lines    before and after the math block,
  * there is support for both LaTeX and text-like inline mathematics,
  * figures and movies with captions, simple tables,    URLs with links, index list, labels and references are supported,
  * comments can be inserted throughout the text (`#` at the beginning    of a line),
  * with a simple preprocessor, Preprocess or Mako, one can include    other documents (files) and large portions of text can be defined    in or out of the text,
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
  |---r-------r-----------r--------|
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
syntax we refer to the `doc/manual/manual.do.txt` file (see the
[https://doconce.googlecode.com/hg/doc/demos/manual/index.html demo page]
for various formats of this document).


<wiki:comment> Example on including another Doconce file (using preprocess): </wiki:comment>



== From Doconce to Other Formats ==

Transformation of a Doconce document `mydoc.do.txt` to various other
formats applies the script `doconce format`:
{{{
Terminal> doconce format format mydoc.do.txt
}}}
or just
{{{
Terminal> doconce format format mydoc
}}}
The `mako` or `preprocess` programs are always used to preprocess the
file first, and options to `mako` or `preprocess` can be added after the
filename. For example,
{{{
Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako
}}}
The variable `FORMAT` is always defined as the current format when
running `preprocess`. That is, in the last example, `FORMAT` is
defined as `LaTeX`. Inside the Doconce document one can then perform
format specific actions through tests like `#if FORMAT == "LaTeX"`.

Inline comments in the text are removed from the output by
{{{
Terminal> doconce format LaTeX mydoc remove_inline_comments
}}}
One can also remove such comments from the original Doconce file
by running 
source code:
{{{
Terminal> doconce remove_inline_comments mydoc
}}}
This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.

==== HTML ====

Making an HTML version of a Doconce file `mydoc.do.txt`
is performed by
{{{
Terminal> doconce format HTML mydoc
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
Terminal> doconce format LaTeX mydoc
}}}
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files `newcommands.tex`, `newcommands_keep.tex`, or
`newcommands_replace.tex` (see the section [#Macros_(Newcommands),_Cross-References,_Index,_and_Bibliography]). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run `ptex2tex` (if you have it) to make a standard LaTeX file,
{{{
Terminal> ptex2tex mydoc
}}}
or just perform a plain copy,
{{{
Terminal> cp mydoc.p.tex mydoc.tex
}}}
Doconce generates a `.p.tex` file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run
{{{
Terminal> ptex2tex -DHELVETICA mydoc
}}}
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through
{{{
Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc
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
Terminal> latex mydoc
Terminal> latex mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex mydoc
Terminal> dvipdf mydoc
}}}
If one wishes to use the `Minted_Python`, `Minted_Cpp`, etc., environments
in `ptex2tex` for typesetting code, the `minted` LaTeX package is needed.
This package is included by running `doconce format` with the
`-DMINTED` option:
{{{
Terminal> ptex2tex -DMINTED mydoc
}}}
In this case, `latex` must be run with the
`-shell-escape` option:
{{{
Terminal> latex -shell-escape mydoc
Terminal> latex -shell-escape mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex -shell-escape mydoc
Terminal> dvipdf mydoc
}}}
The `-shell-escape` option is required because the `minted.sty` style
file runs the `pygments` program to format code, and this program
cannot be run from `latex` without the `-shell-escape` option.

==== Plain ASCII Text ====

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
{{{
Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt
}}}

==== reStructuredText ====

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file `mydoc.rst`:
{{{
Terminal> doconce format rst mydoc.do.txt
}}}
We may now produce various other formats:
{{{
Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
}}}
The OpenOffice file `mydoc.odt` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

==== Sphinx ====

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format:
{{{
Terminal> doconce format sphinx mydoc.do.txt
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
These statements as well as points 3-5 can be automated by the command
{{{
Terminal> doconce sphinx_dir mydoc.do.txt
}}}
More precisely, in addition to making the `sphinx-rootdir`,
this command generates a script `tmp_make_sphinx.sh` which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the `tutorial.rst` file to the Sphinx root directory:
{{{
Terminal> mv mydoc.rst sphinx-rootdir
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
Terminal> firefox _build/html/index.html
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
Terminal> doconce format gwiki mydoc.do.txt
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
[https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html Here]
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
If translation to [http://johnmacfarlane.net/pandoc/ Pandoc] is desired, 
the Pandoc Haskell program must of course be installed.

************** File: tutorial.st *****************
TITLE: Doconce: Document Once, Include Anywhere
BY: Hans Petter Langtangen (Simula Research Laboratory, and University of Oslo)DATE: today


 - When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?
 - Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?
 - Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?

If any of these questions are of interest, you should keep on reading.
The Doconce Concept
Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  - Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  - Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.
  - Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  - Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 
What Does Doconce Look Like?
Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  - bullet lists arise from lines starting with an asterisk,
  - *emphasized words* are surrounded by asterisks, 
  - **words in boldface** are surrounded by underscores, 
  - words from computer code are enclosed in back quotes and 
    then typeset verbatim (monospace font),
  - section headings are recognied by equality ('=') signs before 
    and after the text, and the number of '=' signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),
  - paragraph headings are recognized by a double underscore
    before and after the heading,
  - blocks of computer code can easily be included by placing 
    '!bc' (begin code) and '!ec' (end code) commands at separate lines
    before and after the code block,
  - blocks of computer code can also be imported from source files,
  - blocks of LaTeX mathematics can easily be included by placing
    '!bt' (begin TeX) and '!et' (end TeX) commands at separate lines
    before and after the math block,
  - there is support for both LaTeX and text-like inline mathematics,
  - figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,
  - comments can be inserted throughout the text ('#' at the beginning
    of a line),
  - with a simple preprocessor, Preprocess or Mako, one can include
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
          |---r-------r-----------r--------|
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
syntax we refer to the 'doc/manual/manual.do.txt' file (see the
"https://doconce.googlecode.com/hg/doc/demos/manual/index.html":demo page
for various formats of this document).
From Doconce to Other Formats
Transformation of a Doconce document 'mydoc.do.txt' to various other
formats applies the script 'doconce format':
!bc   sys
        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The 'mako' or 'preprocess' programs are always used to preprocess the
file first, and options to 'mako' or 'preprocess' can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable 'FORMAT' is always defined as the current format when
running 'preprocess'. That is, in the last example, 'FORMAT' is
defined as 'LaTeX'. Inside the Doconce document one can then perform
format specific actions through tests like '#if FORMAT == "LaTeX"'.

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.
HTML
Making an HTML version of a Doconce file 'mydoc.do.txt'
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file 'mydoc.html' can be loaded into any web browser for viewing.
LaTeX
Making a LaTeX file 'mydoc.tex' from 'mydoc.do.txt' is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form 'mydoc.p.tex' for
     'ptex2tex':
!bc   sys
        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files 'newcommands.tex', 'newcommands_keep.tex', or
'newcommands_replace.tex' (see the section "Macros (Newcommands), Cross-References, Index, and Bibliography"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run 'ptex2tex' (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a '.p.tex' file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The 'ptex2tex' tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any '!bc sys' command in the Doconce source you can
insert verbatim block styles as defined in your '.ptex2tex.cfg'
file, e.g., '!bc sys cod' for a code snippet, where 'cod' is set to
a certain environment in '.ptex2tex.cfg' (e.g., 'CodeIntended').
There are over 30 styles to choose from.

*Step 3.* Compile 'mydoc.tex'
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the 'Minted_Python', 'Minted_Cpp', etc., environments
in 'ptex2tex' for typesetting code, the 'minted' LaTeX package is needed.
This package is included by running 'doconce format' with the
'-DMINTED' option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, 'latex' must be run with the
'-shell-escape' option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The '-shell-escape' option is required because the 'minted.sty' style
file runs the 'pygments' program to format code, and this program
cannot be run from 'latex' without the '-shell-escape' option.
Plain ASCII Text
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt

reStructuredText
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file 'mydoc.rst':
!bc   sys
        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file 'mydoc.odt' can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.
Sphinx
Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the 'sphinx-rootdir',
this command generates a script 'tmp_make_sphinx.sh' which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the 'tutorial.rst' file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows '!bc': 'cod' gives Python
('code-block:: python' in Sphinx syntax) and 'cppcod' gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.
Google Code Wiki
There are several different wiki dialects, but Doconce only support the
one used by "http://code.google.com/p/support/wiki/WikiSyntax":Google Code.
The transformation to this format, called 'gwiki' to explicitly mark
it as the Google Code dialect, is done by::


        Terminal> doconce format gwiki mydoc.do.txt

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
"https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html":Here
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
If translation to "http://johnmacfarlane.net/pandoc/":Pandoc is desired, 
the Pandoc Haskell program must of course be installed.
************** File: tutorial.epytext *****************
TITLE: Doconce: Document Once, Include Anywhere
BY: Hans Petter Langtangen (Simula Research Laboratory, and University of Oslo)DATE: today


 - When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?
 - Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?
 - Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  - Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  - Doconce can be converted to plain I{untagged} text, 
    often desirable for computer programs and email.
  - Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  - Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 



What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  - bullet lists arise from lines starting with an asterisk,
  - I{emphasized words} are surrounded by asterisks, 
  - B{words in boldface} are surrounded by underscores, 
  - words from computer code are enclosed in back quotes and 
    then typeset verbatim (monospace font),
  - section headings are recognied by equality (C{=}) signs before 
    and after the text, and the number of C{=} signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),
  - paragraph headings are recognized by a double underscore
    before and after the heading,
  - blocks of computer code can easily be included by placing 
    C{!bc} (begin code) and C{!ec} (end code) commands at separate lines
    before and after the code block,
  - blocks of computer code can also be imported from source files,
  - blocks of LaTeX mathematics can easily be included by placing
    C{!bt} (begin TeX) and C{!et} (end TeX) commands at separate lines
    before and after the math block,
  - there is support for both LaTeX and text-like inline mathematics,
  - figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,
  - comments can be inserted throughout the text (C{#} at the beginning
    of a line),
  - with a simple preprocessor, Preprocess or Mako, one can include
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
          |---r-------r-----------r--------|
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
syntax we refer to the C{doc/manual/manual.do.txt} file (see the
U{demo page<https://doconce.googlecode.com/hg/doc/demos/manual/index.html>}
for various formats of this document).




From Doconce to Other Formats
=============================

Transformation of a Doconce document C{mydoc.do.txt} to various other
formats applies the script C{doconce format}::


        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The C{mako} or C{preprocess} programs are always used to preprocess the
file first, and options to C{mako} or C{preprocess} can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable C{FORMAT} is always defined as the current format when
running C{preprocess}. That is, in the last example, C{FORMAT} is
defined as C{LaTeX}. Inside the Doconce document one can then perform
format specific actions through tests like C{#if FORMAT == "LaTeX"}.

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file C{mydoc.do.txt}
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file C{mydoc.html} can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file C{mydoc.tex} from C{mydoc.do.txt} is done in two steps:

I{Step 1.} Filter the doconce text to a pre-LaTeX form C{mydoc.p.tex} for
     C{ptex2tex}::


        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files C{newcommands.tex}, C{newcommands_keep.tex}, or
C{newcommands_replace.tex} (see the section "Macros (Newcommands), Cross-References, Index, and Bibliography"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

I{Step 2.} Run C{ptex2tex} (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a C{.p.tex} file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The C{ptex2tex} tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any C{!bc sys} command in the Doconce source you can
insert verbatim block styles as defined in your C{.ptex2tex.cfg}
file, e.g., C{!bc sys cod} for a code snippet, where C{cod} is set to
a certain environment in C{.ptex2tex.cfg} (e.g., C{CodeIntended}).
There are over 30 styles to choose from.

I{Step 3.} Compile C{mydoc.tex}
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the C{Minted_Python}, C{Minted_Cpp}, etc., environments
in C{ptex2tex} for typesetting code, the C{minted} LaTeX package is needed.
This package is included by running C{doconce format} with the
C{-DMINTED} option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, C{latex} must be run with the
C{-shell-escape} option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The C{-shell-escape} option is required because the C{minted.sty} style
file runs the C{pygments} program to format code, and this program
cannot be run from C{latex} without the C{-shell-escape} option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file C{mydoc.rst}::


        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file C{mydoc.odt} can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

I{Step 1.} Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the C{sphinx-rootdir},
this command generates a script C{tmp_make_sphinx.sh} which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

I{Step 3.} Move the C{tutorial.rst} file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


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


        Terminal> doconce format gwiki mydoc.do.txt

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
U{Here<https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html>}
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
If translation to U{Pandoc<http://johnmacfarlane.net/pandoc/>} is desired, 
the Pandoc Haskell program must of course be installed.
************** File: tutorial.txt *****************
Doconce: Document Once, Include Anywhere
========================================

Hans Petter Langtangen [1, 2]

[1] Simula Research Laboratory
[2] University of Oslo


Date: Oct 22, 2011

 * When writing a note, report, manual, etc., do you find it difficult
   to choose the typesetting format? That is, to choose between plain
   (email-like) text, wiki, Word/OpenOffice, LaTeX, HTML,
   reStructuredText, Sphinx, XML, etc.  Would it be convenient to
   start with some very simple text-like format that easily converts
   to the formats listed above, and then at some later stage
   eventually go with a particular format?

 * Do you need to write documents in varying formats but find it
   difficult to remember all the typesetting details of various
   formats like LaTeX, HTML, Sphinx, and wiki? Would it be convenient
   to generate the typesetting details of a particular format from a
   very simple text-like format with minimal tagging?

 * Do you have the same information scattered around in different
   documents in different typesetting formats? Would it be a good idea
   to write things once, in one format, stored in one place, and
   include it anywhere?

If any of these questions are of interest, you should keep on reading.


The Doconce Concept
===================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 

  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.

  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.

  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, wiki, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    Sphinx web pages, MS Word documents, or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting of Doconce syntax
may face problems when transformed to HTML, LaTeX, Sphinx, and similar
formats. 



What Does Doconce Look Like?
============================

Doconce text looks like ordinary text, but there are some almost invisible
text constructions that allow you to control the formating. For example,

  * bullet lists arise from lines starting with an asterisk,

  * *emphasized words* are surrounded by asterisks, 

  * _words in boldface_ are surrounded by underscores, 

  * words from computer code are enclosed in back quotes and 
    then typeset verbatim (monospace font),

  * section headings are recognied by equality (=) signs before 
    and after the text, and the number of = signs indicates the 
    level of the section (7 for main section, 5 for subsection,
    3 for subsubsection),

  * paragraph headings are recognized by a double underscore
    before and after the heading,

  * blocks of computer code can easily be included by placing 
    !bc (begin code) and !ec (end code) commands at separate lines
    before and after the code block,

  * blocks of computer code can also be imported from source files,

  * blocks of LaTeX mathematics can easily be included by placing
    !bt (begin TeX) and !et (end TeX) commands at separate lines
    before and after the math block,

  * there is support for both LaTeX and text-like inline mathematics,

  * figures and movies with captions, simple tables,
    URLs with links, index list, labels and references are supported,

  * comments can be inserted throughout the text (# at the beginning
    of a line),

  * with a simple preprocessor, Preprocess or Mako, one can include
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
          |---r-------r-----------r--------|
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
syntax we refer to the doc/manual/manual.do.txt file (see the
demo page (https://doconce.googlecode.com/hg/doc/demos/manual/index.html)
for various formats of this document).




From Doconce to Other Formats
=============================

Transformation of a Doconce document mydoc.do.txt to various other
formats applies the script doconce format::


        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The mako or preprocess programs are always used to preprocess the
file first, and options to mako or preprocess can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable FORMAT is always defined as the current format when
running preprocess. That is, in the last example, FORMAT is
defined as LaTeX. Inside the Doconce document one can then perform
format specific actions through tests like #if FORMAT == "LaTeX".

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file mydoc.tex from mydoc.do.txt is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form mydoc.p.tex for
     ptex2tex::


        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files newcommands.tex, newcommands_keep.tex, or
newcommands_replace.tex (see the section "Macros (Newcommands), Cross-References, Index, and Bibliography"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ptex2tex (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a .p.tex file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ptex2tex tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any !bc sys command in the Doconce source you can
insert verbatim block styles as defined in your .ptex2tex.cfg
file, e.g., !bc sys cod for a code snippet, where cod is set to
a certain environment in .ptex2tex.cfg (e.g., CodeIntended).
There are over 30 styles to choose from.

*Step 3.* Compile mydoc.tex
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the Minted_Python, Minted_Cpp, etc., environments
in ptex2tex for typesetting code, the minted LaTeX package is needed.
This package is included by running doconce format with the
-DMINTED option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, latex must be run with the
-shell-escape option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The -shell-escape option is required because the minted.sty style
file runs the pygments program to format code, and this program
cannot be run from latex without the -shell-escape option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file mydoc.rst::


        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file mydoc.odt can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the sphinx-rootdir,
this command generates a script tmp_make_sphinx.sh which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the tutorial.rst file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


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


        Terminal> doconce format gwiki mydoc.do.txt

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
Here (https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html)
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
If translation to Pandoc (http://johnmacfarlane.net/pandoc/) is desired, 
the Pandoc Haskell program must of course be installed.
************** File: tmp_Doconce.do.txt *****************

TITLE: My Test of Class Doconce
AUTHOR: Hans Petter Langtangen; Simula Research Laboratory; Dept. of Informatics, Univ. of Oslo
DATE: Sat, 22 Oct 2011 (14:48)



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
DATE: Sat, 22 Oct 2011 (14:48)



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

<CENTER>Sat, 22 Oct 2011 (14:48)</CENTER>



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

<CENTER>Sat, 22 Oct 2011 (14:48)</CENTER>



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
# doconce, ptex2tex, docutils, preprocess, sphinx

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
doconce subst '\.\*' '.pdf' _build/latex/DoconceDescription.tex  # .* doesn't work
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
# lookahead don't work: doconce subst '(?=includegraphics.+)\.png' '.eps' manual.rst.tex
doconce subst '\.png' '' manual.rst.tex   # no extension in graphics file
latex manual.rst.tex   # pdflatex works too
latex manual.rst.tex
dvipdf manual.rst.dvi

# plain text:
$d2f plain manual.do.txt remove_inline_comments 

$d2f epytext manual.do.txt
$d2f st manual.do.txt

# doconce LaTeX:
$d2f LaTeX manual.do.txt    # produces ptex2tex: manual.p.tex
doconce replace 'usepackage{ptex2tex' 'usepackage{ptex2tex,subfigure' manual.p.tex  # need subfigure LaTeX package
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
doconce subst "\(the URL of the image file figs/streamtubes.png must be inserted here\)" "https://doconce.googlecode.com/hg/doc/manual/figs/streamtubes.png" manual.gwiki

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
doconce format rst    manual.do.txt  # standard reST
doconce format sphinx manual.do.txt  # Sphinx extension of reST
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
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
    

  o Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
    


Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.
  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 



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
If translation to "Pandoc": "http://johnmacfarlane.net/pandoc/" is desired, 
the Pandoc Haskell program must of course be installed.


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
https://doconce.googlecode.com/hg/doc/demos/manual/index.html<demo web page>
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
"web demo": "https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html"
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
sections, subsections, paragraphs., figures, movies, etc.

idx{`TITLE` keyword} idx{`AUTHOR` keyword} idx{`DATE` keyword}

__Heading with Title and Author(s).__
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
  
__Section Headings.__
Section headings are recognized by being surrounded by equal signs (=) or
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

=== Example on a Subsubsection Heading ===

The running text goes here.

__A Paragraph.__ The running text goes here.

======= Special Lines =======

===== Figures =====

Figures are recognized by the special line syntax
!bc
FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption
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

FIGURE:[figs/streamtubes, width=400] Streamtube visualization of a fluid flow. label{fig:viz}

===== Movies =====

Here is an example on the `MOVIE:` keyword for embedding movies. This
feature works well for the `LaTeX`, `HTML`, `rst`, and `sphinx` formats.
Other formats try to generate some HTML file and link to that file
for showing the movie.
!bc
MOVIE: [filename, height=xxx width=yyy] possible caption
!ec

# LaTeX/PDF format can make use of the movie15 package for displaying movies,
# or just plain \href{run: ...}{...}

MOVIE: [figs/mjolnir.mpeg, width=600 height=470]

#MOVIE: [figs/wavepacket.gif, width=600 height=470]

#MOVIE: [figs/wavepacket2.mpeg, width=600 height=470]

The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the `movie15` package wanted, one has to turn on the preprocessor
variable `MOVIE15`. There is an associated variable
`EXTERNAL_MOVIE_VIEWER` which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader):
!bc sys
Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc
!ec

The HTML, reST, and Sphinx formats can also treat filenames of the form
`myframes*.png`. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the `MOVIE:` command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).



===== Copying Computer Code =====

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
[hpl: Here is a specific example on an inline comment. It can
span several lines.]
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:viz}
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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

# see ketch/tex2rst for nice bibtex to rst converter which could
# be used here

Conversion of BibTeX databases to reStructuredText format can be
done by the "bibliograph.parsing":"http://pypi.python.org/pypi/bibliograph.parsing/" tool.

Finally, we here test the citation command and bibliography by 
citing a book cite{Python:Primer:09}, a paper cite{Osnes:98},
and both of them simultaneously cite{Python:Primer:09,Osnes:98}.

[somereader: comments, citations, and references in the latex style
is a special feature of doconce :-) ]


===== Tables =====

A table like

  |--------------------------------|
  |time  | velocity | acceleration |
  |--r--------r-----------r--------|
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters `c`, `r`, or `l` to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes `|` can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.



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
Two preprocessors are supported: preprocess 
(URL:"http://code.google.com/p/preprocess") and mako
(URL:"http://www.makotemplates.org/"). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of `name=value` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable `FORMAT`
defined as the desired output format of Doconce (`HTML`, `LaTeX`,
`plain`, `rst`, `sphinx`, `epydoc`, `st`).  It is then easy to test on
the value of `FORMAT` and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).

# If PNGFIGS is defined, PNG files are used, otherwise Encapsulated 
# PostScript files are used.

# #if FORMAT == "LaTeX"
# Use LaTeX with subfigures (a) and (b)
\begin{figure}
label{fig:wavepackets}
  \begin{center}
#  #ifdef PNGFIGS
\subfigure[]{\includegraphics[width=0.49\linewidth]{figs/wavepacket_0001.png}}
#  #else
\subfigure[]{\includegraphics[width=0.49\linewidth]{figs/wavepacket_0001.eps}}
#  #endif

#  #ifdef PNGFIGS
\subfigure[]{\includegraphics[width=0.49\linewidth]{figs/wavepacket_0010.png}}
#  #else
\subfigure[]{\includegraphics[width=0.49\linewidth]{figs/wavepacket_0010.eps}}
#  #endif
  \end{center}
  \caption{
  Wavepackets at time (a) 0.1 s and (b) 0.2 s.
  }
\end{figure}

# #else

# Use default Doconce figure handling for all other formats

FIGURE:[figs/wavepacket_0001.png, width=400] Wavepacket at time 0.1 s.

FIGURE:[figs/wavepacket_0010.png, width=400] Wavepacket at time 0.2 s.

# #endif

Other user-defined variables for the preprocessor can be set at 
the command line as explained in Section ref{doconce2formats}.

More advanced use of mako can include Python code that may automate
the writing of parts of the document.



===== Missing Features ===== 

  * Footnotes

===== Troubleshooting =====

__Disclaimer.__ Doconce has some support for syntax checking.
If you encounter Python errors while running `doconce format`, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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


<CENTER><H3>Oct 22, 2011</H3></CENTER>
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
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 <LI> Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".
</OL>

Here are some Doconce features:

<P>

<UL>
  <LI> Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  <LI> Doconce can be converted to plain <EM>untagged</EM> text, 
    often desirable for computer programs and email.
  <LI> Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  <LI> Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  <LI> Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  <LI> Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.
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
    web sites, and as LaTeX integrated in, e.g., a thesis.
  <LI> Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.
</UL>

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

<P>
Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 

<P>

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
If translation to <A HREF="http://johnmacfarlane.net/pandoc/">Pandoc</A> is desired, 
the Pandoc Haskell program must of course be installed.

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
<A HREF="https://doconce.googlecode.com/hg/doc/demos/manual/index.html">demo web page</A>
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
<A HREF="https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html">web demo</A>
of the results.

<P>
<!-- Example on including another Doconce file: -->

<P>

<P>
<H1>From Doconce to Other Formats <A NAME="doconce2formats"></A></H1>
<P>

<P>
Transformation of a Doconce document <TT>mydoc.do.txt</TT> to various other
formats applies the script <TT>doconce format</TT>:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format format mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format format mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The <TT>mako</TT> or <TT>preprocess</TT> programs are always used to preprocess the
file first, and options to <TT>mako</TT> or <TT>preprocess</TT> can be added after the
filename. For example,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako
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
Terminal> doconce format LaTeX mydoc remove_inline_comments
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
One can also remove such comments from the original Doconce file
by running 
source code:
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
Terminal> doconce remove_inline_comments mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.

<P>

<P>
<H3>HTML</H3>
<P>
Making an HTML version of a Doconce file <TT>mydoc.do.txt</TT>
is performed by
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce format HTML mydoc
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
Terminal> doconce format LaTeX mydoc
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
Terminal> ptex2tex mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
or just perform a plain copy,
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> cp mydoc.p.tex mydoc.tex
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
Doconce generates a <TT>.p.tex</TT> file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DHELVETICA mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc
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
Terminal> latex mydoc
Terminal> latex mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex mydoc
Terminal> dvipdf mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
If one wishes to use the <TT>Minted_Python</TT>, <TT>Minted_Cpp</TT>, etc., environments
in <TT>ptex2tex</TT> for typesetting code, the <TT>minted</TT> LaTeX package is needed.
This package is included by running <TT>doconce format</TT> with the
<TT>-DMINTED</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DMINTED mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
In this case, <TT>latex</TT> must be run with the
<TT>-shell-escape</TT> option:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> latex -shell-escape mydoc
Terminal> latex -shell-escape mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex -shell-escape mydoc
Terminal> dvipdf mydoc
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
Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt
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
Terminal> doconce format rst mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
We may now produce various other formats:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
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
Terminal> doconce format sphinx mydoc.do.txt
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
These statements as well as points 3-5 can be automated by the command
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> doconce sphinx_dir mydoc.do.txt
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->
More precisely, in addition to making the <TT>sphinx-rootdir</TT>,
this command generates a script <TT>tmp_make_sphinx.sh</TT> which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

<P>
<B>Step 3.</B> Move the <TT>tutorial.rst</TT> file to the Sphinx root directory:
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> mv mydoc.rst sphinx-rootdir
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
Terminal> firefox _build/html/index.html
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
Terminal> doconce format gwiki mydoc.do.txt
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
sections, subsections, paragraphs., figures, movies, etc.

<P>

<P>
<B>Heading with Title and Author(s).</B> Lines starting with <TT>TITLE:</TT>, <TT>AUTHOR:</TT>, and <TT>DATE:</TT> are optional and used
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
<B>Section Headings.</B> Section headings are recognized by being surrounded by equal signs (=) or
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
<H1>Special Lines</H1>
<P>
<H3>Figures</H3>
<P>
Figures are recognized by the special line syntax
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption
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
<IMG SRC="figs/streamtubes.png" ALIGN="bottom"  width=400> <P><EM> Streamtube visualization of a fluid flow. <A NAME="fig:viz"></A></EM></P>

<P>
<H3>Movies</H3>
<P>
Here is an example on the <TT>MOVIE:</TT> keyword for embedding movies. This
feature works well for the <TT>LaTeX</TT>, <TT>HTML</TT>, <TT>rst</TT>, and <TT>sphinx</TT> formats.
Other formats try to generate some HTML file and link to that file
for showing the movie.
<!-- BEGIN VERBATIM BLOCK  -->
<BLOCKQUOTE><PRE>
MOVIE: [filename, height=xxx width=yyy] possible caption
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
<!-- LaTeX/PDF format can make use of the movie15 package for displaying movies, -->
<!-- or just plain \h<A HREF="#run: ...">run: ...</a>{...} -->

<P>

<EMBED SRC="figs/mjolnir.mpeg" width=600 height=470 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
<P>
<EM></EM>
</P>


<P>
<!-- MOVIE: [figs/wavepacket.gif, width=600 height=470] -->

<P>
<!-- MOVIE: [figs/wavepacket2.mpeg, width=600 height=470] -->

<P>
The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

<P>
When movies are embedded in the PDF file via LaTeX and
the <TT>movie15</TT> package wanted, one has to turn on the preprocessor
variable <TT>MOVIE15</TT>. There is an associated variable
<TT>EXTERNAL_MOVIE_VIEWER</TT> which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader):
<!-- BEGIN VERBATIM BLOCK   sys-->
<BLOCKQUOTE><PRE>
Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc
</PRE></BLOCKQUOTE>
<! -- END VERBATIM BLOCK -->

<P>
The HTML, reST, and Sphinx formats can also treat filenames of the form
<TT>myframes*.png</TT>. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

<P>
Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the <TT>MOVIE:</TT> command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).

<P>

<P>

<P>
<H3>Copying Computer Code</H3>
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
[<B>hpl</B>: <EM>Here is a specific example on an inline comment. It can
span several lines.</EM>]
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

<P>
It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure <A HREF="#fig:viz">fig:viz</a>
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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
<!-- see ketch/tex2rst for nice bibtex to rst converter which could -->
<!-- be used here -->

<P>
Conversion of BibTeX databases to reStructuredText format can be
done by the <A HREF="http://pypi.python.org/pypi/bibliograph.parsing/">bibliograph.parsing</A> tool.

<P>
Finally, we here test the citation command and bibliography by 
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
<TR><TD align="center"><B>    time    </B></TD> <TD align="center"><B>  velocity  </B></TD> <TD align="center"><B>acceleration</B></TD> </TR>
<TR><TD align="right">   0.0             </TD> <TD align="right">   1.4186          </TD> <TD align="right">   -5.01           </TD> </TR>
<TR><TD align="right">   2.0             </TD> <TD align="right">   1.376512        </TD> <TD align="right">   11.919          </TD> </TR>
<TR><TD align="right">   4.0             </TD> <TD align="right">   1.1E+1          </TD> <TD align="right">   14.717624       </TD> </TR>
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters <TT>c</TT>, <TT>r</TT>, or <TT>l</TT> to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes <TT>|</TT> can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.

<P>

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
Two preprocessors are supported: preprocess 
(<A HREF="http://code.google.com/p/preprocess"><TT>http://code.google.com/p/preprocess</TT></A>) and mako
(<A HREF="http://www.makotemplates.org/"><TT>http://www.makotemplates.org/</TT></A>). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of <TT>name=value</TT> command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

<P>
Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

<P>
The preprocess and mako programs always have the variable <TT>FORMAT</TT>
defined as the desired output format of Doconce (<TT>HTML</TT>, <TT>LaTeX</TT>,
<TT>plain</TT>, <TT>rst</TT>, <TT>sphinx</TT>, <TT>epydoc</TT>, <TT>st</TT>).  It is then easy to test on
the value of <TT>FORMAT</TT> and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).

<P>
<!-- If PNGFIGS is defined, PNG files are used, otherwise Encapsulated -->
<!-- PostScript files are used. -->

<P>

<P>
<!-- Use default Doconce figure handling for all other formats -->

<P>
<IMG SRC="figs/wavepacket_0001.png" ALIGN="bottom"  width=400> <P><EM> Wavepacket at time 0.1 s.</EM></P>

<P>
<IMG SRC="figs/wavepacket_0010.png" ALIGN="bottom"  width=400> <P><EM> Wavepacket at time 0.2 s.</EM></P>

<P>

<P>
Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section <A HREF="#doconce2formats">From Doconce to Other Formats</a>.

<P>
More advanced use of mako can include Python code that may automate
the writing of parts of the document.

<P>

<P>

<P>
<H3>Missing Features</H3>
<P>

<UL>
  <LI> Footnotes
</UL>
<H3>Troubleshooting</H3>
<P>
<B>Disclaimer.</B> Doconce has some support for syntax checking.
If you encounter Python errors while running <TT>doconce format</TT>, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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

:Date: Oct 22, 2011

.. lines beginning with # are comment lines



.. _what:is:doconce:

What Is Doconce?
================

Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 

  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.

  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.

  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 



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
If translation to `Pandoc <http://johnmacfarlane.net/pandoc/>`_ is desired, 
the Pandoc Haskell program must of course be installed.



.. some comment lines that do not affect any formatting

.. these lines are simply removed








Demos
-----


The current text is generated from a Doconce format stored in the::


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
`demo web page <https://doconce.googlecode.com/hg/doc/demos/manual/index.html>`_
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file ``make.sh`` in the same directory as the ``manual.do.txt`` file
(the current text) shows how to run ``doconce format`` on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the ``tutorial`` directory there is also a ``make.sh`` file producing a
lot of formats, with a corresponding
`web demo <https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html>`_
of the results.

.. Example on including another Doconce file:



.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document ``mydoc.do.txt`` to various other
formats applies the script ``doconce format``::


        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The ``mako`` or ``preprocess`` programs are always used to preprocess the
file first, and options to ``mako`` or ``preprocess`` can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file ``mydoc.html`` can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file ``mydoc.tex`` from ``mydoc.do.txt`` is done in two steps:
.. Note: putting code blocks inside a list is not successful in many

.. formats - the text may be messed up. A better choice is a paragraph

.. environment, as used here.


*Step 1.* Filter the doconce text to a pre-LaTeX form ``mydoc.p.tex`` for
     ``ptex2tex``::


        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section `Macros (Newcommands)`_). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ``ptex2tex`` tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any ``!bc sys`` command in the Doconce source you can
insert verbatim block styles as defined in your ``.ptex2tex.cfg``
file, e.g., ``!bc sys cod`` for a code snippet, where ``cod`` is set to
a certain environment in ``.ptex2tex.cfg`` (e.g., ``CodeIntended``).
There are over 30 styles to choose from.

*Step 3.* Compile ``mydoc.tex``
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``::


        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file ``mydoc.odt`` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the ``sphinx-rootdir``,
this command generates a script ``tmp_make_sphinx.sh`` which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


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


        Terminal> doconce format gwiki mydoc.do.txt

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
sections, subsections, paragraphs., figures, movies, etc.


*Heading with Title and Author(s).* Lines starting with ``TITLE:``, ``AUTHOR:``, and ``DATE:`` are optional and used
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


*Section Headings.* Section headings are recognized by being surrounded by equal signs (=) or
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

Special Lines
=============

Figures
-------

Figures are recognized by the special line syntax::


        FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption

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


.. _fig:viz:

.. figure:: figs/streamtubes.png
   :width: 400

   Streamtube visualization of a fluid flow  (fig:viz)


Movies
------

Here is an example on the ``MOVIE:`` keyword for embedding movies. This
feature works well for the ``LaTeX``, ``HTML``, ``rst``, and ``sphinx`` formats.
Other formats try to generate some HTML file and link to that file
for showing the movie::


        MOVIE: [filename, height=xxx width=yyy] possible caption


.. LaTeX/PDF format can make use of the movie15 package for displaying movies,

.. or just plain \h`run: ...`_{...}


.. raw:: html
        
        <EMBED SRC="figs/mjolnir.mpeg" width=600 height=470 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
        <P>
        <EM></EM>
        </P>



.. MOVIE: [figs/wavepacket.gif, width=600 height=470]


.. MOVIE: [figs/wavepacket2.mpeg, width=600 height=470]


The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the ``movie15`` package wanted, one has to turn on the preprocessor
variable ``MOVIE15``. There is an associated variable
``EXTERNAL_MOVIE_VIEWER`` which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader)::


        Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc


The HTML, reST, and Sphinx formats can also treat filenames of the form
``myframes*.png``. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the ``MOVIE:`` command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).



Copying Computer Code
---------------------

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
(**hpl**: Here is a specific example on an inline comment. It can
span several lines.)
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure `fig:viz`_
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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

.. see ketch/tex2rst for nice bibtex to rst converter which could

.. be used here


Conversion of BibTeX databases to reStructuredText format can be
done by the `bibliograph.parsing <http://pypi.python.org/pypi/bibliograph.parsing/>`_ tool.

Finally, we here test the citation command and bibliography by 
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters ``c``, ``r``, or ``l`` to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes ``|`` can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.



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
Two preprocessors are supported: preprocess 
(`<http://code.google.com/p/preprocess>`_) and mako
(`<http://www.makotemplates.org/>`_). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of ``name=value`` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable ``FORMAT``
defined as the desired output format of Doconce (``HTML``, ``LaTeX``,
``plain``, ``rst``, ``sphinx``, ``epydoc``, ``st``).  It is then easy to test on
the value of ``FORMAT`` and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).

.. If PNGFIGS is defined, PNG files are used, otherwise Encapsulated

.. PostScript files are used.



.. Use default Doconce figure handling for all other formats



.. figure:: figs/wavepacket_0001.png
   :width: 400

   Wavepacket at time 0.1 s



.. figure:: figs/wavepacket_0010.png
   :width: 400

   Wavepacket at time 0.2 s



Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section `From Doconce to Other Formats`_.

More advanced use of mako can include Python code that may automate
the writing of parts of the document.



Missing Features
----------------

  * Footnotes

Troubleshooting
---------------

*Disclaimer.* Doconce has some support for syntax checking.
If you encounter Python errors while running ``doconce format``, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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

:Date: Oct 22, 2011

.. lines beginning with # are comment lines



.. _what:is:doconce:

What Is Doconce?
================

.. index::
   pair: doconce; short explanation


Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 

  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.

  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.

  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 



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
If translation to `Pandoc <http://johnmacfarlane.net/pandoc/>`_ is desired, 
the Pandoc Haskell program must of course be installed.



.. some comment lines that do not affect any formatting

.. these lines are simply removed








Demos
-----


.. index:: demos


The current text is generated from a Doconce format stored in the

.. code-block:: console

        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
`demo web page <https://doconce.googlecode.com/hg/doc/demos/manual/index.html>`_
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
`web demo <https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html>`_
of the results.

.. Example on including another Doconce file:



.. _doconce2formats:

From Doconce to Other Formats
=============================

Transformation of a Doconce document ``mydoc.do.txt`` to various other
formats applies the script ``doconce format``:

.. code-block:: console

        Terminal> doconce format format mydoc.do.txt

or just

.. code-block:: console

        Terminal> doconce format format mydoc

The ``mako`` or ``preprocess`` programs are always used to preprocess the
file first, and options to ``mako`` or ``preprocess`` can be added after the
filename. For example,

.. code-block:: console

        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable ``FORMAT`` is always defined as the current format when
running ``preprocess``. That is, in the last example, ``FORMAT`` is
defined as ``LaTeX``. Inside the Doconce document one can then perform
format specific actions through tests like ``#if FORMAT == "LaTeX"``.

Inline comments in the text are removed from the output by

.. code-block:: console

        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code:

.. code-block:: py


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file ``mydoc.do.txt``
is performed by

.. code-block:: console

        Terminal> doconce format HTML mydoc

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

        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files ``newcommands.tex``, ``newcommands_keep.tex``, or
``newcommands_replace.tex`` (see the section :ref:`newcommands`). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ``ptex2tex`` (if you have it) to make a standard LaTeX file,

.. code-block:: console

        Terminal> ptex2tex mydoc

or just perform a plain copy,

.. code-block:: console

        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a ``.p.tex`` file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run

.. code-block:: console

        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through

.. code-block:: console

        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


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

        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the ``Minted_Python``, ``Minted_Cpp``, etc., environments
in ``ptex2tex`` for typesetting code, the ``minted`` LaTeX package is needed.
This package is included by running ``doconce format`` with the
``-DMINTED`` option:

.. code-block:: console

        Terminal> ptex2tex -DMINTED mydoc

In this case, ``latex`` must be run with the
``-shell-escape`` option:

.. code-block:: console

        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The ``-shell-escape`` option is required because the ``minted.sty`` style
file runs the ``pygments`` program to format code, and this program
cannot be run from ``latex`` without the ``-shell-escape`` option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:

.. code-block:: console

        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file ``mydoc.rst``:

.. code-block:: console

        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats:

.. code-block:: console

        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file ``mydoc.odt`` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format:

.. code-block:: console

        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command

.. code-block:: console

        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the ``sphinx-rootdir``,
this command generates a script ``tmp_make_sphinx.sh`` which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the ``tutorial.rst`` file to the Sphinx root directory:

.. code-block:: console

        Terminal> mv mydoc.rst sphinx-rootdir

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

        Terminal> firefox _build/html/index.html


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

        Terminal> doconce format gwiki mydoc.do.txt

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
sections, subsections, paragraphs., figures, movies, etc.


.. index:: TITLE keyword

.. index:: AUTHOR keyword

.. index:: DATE keyword


*Heading with Title and Author(s).* Lines starting with ``TITLE:``, ``AUTHOR:``, and ``DATE:`` are optional and used
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


*Section Headings.* Section headings are recognized by being surrounded by equal signs (=) or
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

Special Lines
=============

Figures
-------

Figures are recognized by the special line syntax

.. code-block:: py


        FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption

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


.. _fig:viz:

.. figure:: figs/streamtubes.png
   :width: 400

   Streamtube visualization of a fluid flow  


Movies
------

Here is an example on the ``MOVIE:`` keyword for embedding movies. This
feature works well for the ``LaTeX``, ``HTML``, ``rst``, and ``sphinx`` formats.
Other formats try to generate some HTML file and link to that file
for showing the movie.

.. code-block:: py


        MOVIE: [filename, height=xxx width=yyy] possible caption


.. LaTeX/PDF format can make use of the movie15 package for displaying movies,

.. or just plain \h:ref:`run: ...`{...}


.. raw:: html
        
        <EMBED SRC="figs/mjolnir.mpeg" width=600 height=470 AUTOPLAY="TRUE" LOOP="TRUE"></EMBED>
        <P>
        <EM></EM>
        </P>



.. MOVIE: [figs/wavepacket.gif, width=600 height=470]


.. MOVIE: [figs/wavepacket2.mpeg, width=600 height=470]


The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the ``movie15`` package wanted, one has to turn on the preprocessor
variable ``MOVIE15``. There is an associated variable
``EXTERNAL_MOVIE_VIEWER`` which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader):

.. code-block:: console

        Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc


The HTML, reST, and Sphinx formats can also treat filenames of the form
``myframes*.png``. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the ``MOVIE:`` command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).



Copying Computer Code
---------------------

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
(**hpl**: Here is a specific example on an inline comment. It can
span several lines.)
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure :ref:`fig:viz`
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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

.. see ketch/tex2rst for nice bibtex to rst converter which could

.. be used here


Conversion of BibTeX databases to reStructuredText format can be
done by the `bibliograph.parsing <http://pypi.python.org/pypi/bibliograph.parsing/>`_ tool.

Finally, we here test the citation command and bibliography by 
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters ``c``, ``r``, or ``l`` to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes ``|`` can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.



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
Two preprocessors are supported: preprocess 
(`<http://code.google.com/p/preprocess>`_) and mako
(`<http://www.makotemplates.org/>`_). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of ``name=value`` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable ``FORMAT``
defined as the desired output format of Doconce (``HTML``, ``LaTeX``,
``plain``, ``rst``, ``sphinx``, ``epydoc``, ``st``).  It is then easy to test on
the value of ``FORMAT`` and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).

.. If PNGFIGS is defined, PNG files are used, otherwise Encapsulated

.. PostScript files are used.



.. Use default Doconce figure handling for all other formats



.. figure:: figs/wavepacket_0001.png
   :width: 400

   Wavepacket at time 0.1 s



.. figure:: figs/wavepacket_0010.png
   :width: 400

   Wavepacket at time 0.2 s



Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section :ref:`doconce2formats`.

More advanced use of mako can include Python code that may automate
the writing of parts of the document.



Missing Features
----------------

  * Footnotes

Troubleshooting
---------------

*Disclaimer.* Doconce has some support for syntax checking.
If you encounter Python errors while running ``doconce format``, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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

==== Oct 22, 2011 ====

<wiki:comment> lines beginning with # are comment lines </wiki:comment>



== What Is Doconce? ==

Doconce is two things:


 # Doconce is a very simple and minimally tagged markup language that    looks like ordinary ASCII text (much like what you would use in an    email), but the text can be transformed to numerous other formats,    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,    Epytext, and also plain text (where non-obvious formatting/tags are    removed for clear reading in, e.g., emails). From reStructuredText    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the    latter to RTF and MS Word.    (An experimental translator to Pandoc is under development, and from    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 # Doconce is a working strategy for never duplicating information.    Text is written in a single place and then transformed to    a number of different destinations of diverse type (software    source code, manuals, tutorials, books, wikis, memos, emails, etc.).    The Doconce markup language support this working strategy.    The slogan is: "Write once, include anywhere".

Here are some Doconce features:


  * Doconce markup does include tags, so the format is more tagged than     Markdown and Pandoc, but less than reST, and very much less than     LaTeX and HTML. 
  * Doconce can be converted to plain *untagged* text,     often desirable for computer programs and email.
  * Doconce has good support for copying in parts of computer code,    say in examples, directly from the source code files.
  * Doconce has full support for LaTeX math, and integrates very well    with big LaTeX projects (books).
  * Doconce is almost self-explanatory and is a handy starting point    for generating documents in more complicated markup languages, such    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce    is just to make the initial versions of a Sphinx or wiki document.
  * Contrary to the similar Pandoc translator, Doconce integrates with    Sphinx and Google wiki. However, if these formats are not of interest,    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:


  * Large books written in LaTeX, but where many pieces (computer demos,    projects, examples) can be written in Doconce to appear in other    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  * Software documentation, primarily Python doc strings, which one wants    to appear as plain untagged text for viewing in Pydoc, as reStructuredText    for use with Sphinx, as wiki text when publishing the software at    web sites, and as LaTeX integrated in, e.g., a thesis.
  * Quick memos, which start as plain text in email, then some small    amount of Doconce tagging is added, before the memos can appear as    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 

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
If translation to [http://johnmacfarlane.net/pandoc/ Pandoc] is desired, 
the Pandoc Haskell program must of course be installed.


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
[https://doconce.googlecode.com/hg/doc/demos/manual/index.html demo web page]
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
[https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html web demo]
of the results.

<wiki:comment> Example on including another Doconce file: </wiki:comment>



== From Doconce to Other Formats ==

Transformation of a Doconce document `mydoc.do.txt` to various other
formats applies the script `doconce format`:
{{{
Terminal> doconce format format mydoc.do.txt
}}}
or just
{{{
Terminal> doconce format format mydoc
}}}
The `mako` or `preprocess` programs are always used to preprocess the
file first, and options to `mako` or `preprocess` can be added after the
filename. For example,
{{{
Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako
}}}
The variable `FORMAT` is always defined as the current format when
running `preprocess`. That is, in the last example, `FORMAT` is
defined as `LaTeX`. Inside the Doconce document one can then perform
format specific actions through tests like `#if FORMAT == "LaTeX"`.

Inline comments in the text are removed from the output by
{{{
Terminal> doconce format LaTeX mydoc remove_inline_comments
}}}
One can also remove such comments from the original Doconce file
by running 
source code:
{{{
Terminal> doconce remove_inline_comments mydoc
}}}
This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.

==== HTML ====

Making an HTML version of a Doconce file `mydoc.do.txt`
is performed by
{{{
Terminal> doconce format HTML mydoc
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
Terminal> doconce format LaTeX mydoc
}}}
LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files `newcommands.tex`, `newcommands_keep.tex`, or
`newcommands_replace.tex` (see the section [#Macros_(Newcommands)]). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run `ptex2tex` (if you have it) to make a standard LaTeX file,
{{{
Terminal> ptex2tex mydoc
}}}
or just perform a plain copy,
{{{
Terminal> cp mydoc.p.tex mydoc.tex
}}}
Doconce generates a `.p.tex` file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run
{{{
Terminal> ptex2tex -DHELVETICA mydoc
}}}
The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through
{{{
Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc
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
Terminal> latex mydoc
Terminal> latex mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex mydoc
Terminal> dvipdf mydoc
}}}
If one wishes to use the `Minted_Python`, `Minted_Cpp`, etc., environments
in `ptex2tex` for typesetting code, the `minted` LaTeX package is needed.
This package is included by running `doconce format` with the
`-DMINTED` option:
{{{
Terminal> ptex2tex -DMINTED mydoc
}}}
In this case, `latex` must be run with the
`-shell-escape` option:
{{{
Terminal> latex -shell-escape mydoc
Terminal> latex -shell-escape mydoc
Terminal> makeindex mydoc   # if index
Terminal> bibitem mydoc     # if bibliography
Terminal> latex -shell-escape mydoc
Terminal> dvipdf mydoc
}}}
The `-shell-escape` option is required because the `minted.sty` style
file runs the `pygments` program to format code, and this program
cannot be run from `latex` without the `-shell-escape` option.

==== Plain ASCII Text ====

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code:
{{{
Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt
}}}

==== reStructuredText ====

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file `mydoc.rst`:
{{{
Terminal> doconce format rst mydoc.do.txt
}}}
We may now produce various other formats:
{{{
Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice
}}}
The OpenOffice file `mydoc.odt` can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

==== Sphinx ====

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format:
{{{
Terminal> doconce format sphinx mydoc.do.txt
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
These statements as well as points 3-5 can be automated by the command
{{{
Terminal> doconce sphinx_dir mydoc.do.txt
}}}
More precisely, in addition to making the `sphinx-rootdir`,
this command generates a script `tmp_make_sphinx.sh` which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the `tutorial.rst` file to the Sphinx root directory:
{{{
Terminal> mv mydoc.rst sphinx-rootdir
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
Terminal> firefox _build/html/index.html
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
Terminal> doconce format gwiki mydoc.do.txt
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
sections, subsections, paragraphs., figures, movies, etc.


*Heading with Title and Author(s).* Lines starting with `TITLE:`, `AUTHOR:`, and `DATE:` are optional and used
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


*Section Headings.* Section headings are recognized by being surrounded by equal signs (=) or
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



== Special Lines ==

==== Figures ====

Figures are recognized by the special line syntax
{{{
FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption
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

Figure:  Streamtube visualization of a fluid flow. (fig:viz)

https://doconce.googlecode.com/hg/doc/manual/figs/streamtubes.png

<wiki:comment> 
Put the figure file figs/streamtubes.png on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------

==== Movies ====

Here is an example on the `MOVIE:` keyword for embedding movies. This
feature works well for the `LaTeX`, `HTML`, `rst`, and `sphinx` formats.
Other formats try to generate some HTML file and link to that file
for showing the movie.
{{{
MOVIE: [filename, height=xxx width=yyy] possible caption
}}}

<wiki:comment> LaTeX/PDF format can make use of the movie15 package for displaying movies, </wiki:comment>
<wiki:comment> or just plain \hrun: ...{...} </wiki:comment>

 (Movie figs/mjolnir.mpeg: play mjolnir.html)

<wiki:comment> MOVIE: [figs/wavepacket.gif, width=600 height=470] </wiki:comment>

<wiki:comment> MOVIE: [figs/wavepacket2.mpeg, width=600 height=470] </wiki:comment>

The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the `movie15` package wanted, one has to turn on the preprocessor
variable `MOVIE15`. There is an associated variable
`EXTERNAL_MOVIE_VIEWER` which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader):
{{{
Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc
}}}

The HTML, reST, and Sphinx formats can also treat filenames of the form
`myframes*.png`. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the `MOVIE:` command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).

==== Copying Computer Code ====

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
[hpl: Here is a specific example on an inline comment. It can
span several lines.]
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure fig:viz
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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

<wiki:comment> see ketch/tex2rst for nice bibtex to rst converter which could </wiki:comment>
<wiki:comment> be used here </wiki:comment>

Conversion of BibTeX databases to reStructuredText format can be
done by the [http://pypi.python.org/pypi/bibliograph.parsing/ bibliograph.parsing] tool.

Finally, we here test the citation command and bibliography by 
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters `c`, `r`, or `l` to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes `|` can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.

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
Two preprocessors are supported: preprocess 
(http://code.google.com/p/preprocess) and mako
(http://www.makotemplates.org/). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of `name=value` command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable `FORMAT`
defined as the desired output format of Doconce (`HTML`, `LaTeX`,
`plain`, `rst`, `sphinx`, `epydoc`, `st`).  It is then easy to test on
the value of `FORMAT` and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).

<wiki:comment> If PNGFIGS is defined, PNG files are used, otherwise Encapsulated </wiki:comment>
<wiki:comment> PostScript files are used. </wiki:comment>


<wiki:comment> Use default Doconce figure handling for all other formats </wiki:comment>



---------------------------------------------------------------

Figure:  Wavepacket at time 0.1 s.

(the URL of the image file figs/wavepacket_0001.png must be inserted here)

<wiki:comment> 
Put the figure file figs/wavepacket_0001.png on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------





---------------------------------------------------------------

Figure:  Wavepacket at time 0.2 s.

(the URL of the image file figs/wavepacket_0010.png must be inserted here)

<wiki:comment> 
Put the figure file figs/wavepacket_0010.png on the web (e.g., as part of the
googlecode repository) and substitute the line above with the URL.
</wiki:comment>
---------------------------------------------------------------




Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section [#From_Doconce_to_Other_Formats].

More advanced use of mako can include Python code that may automate
the writing of parts of the document.

==== Missing Features ====

  * Footnotes

==== Troubleshooting ====

*Disclaimer.* Doconce has some support for syntax checking.
If you encounter Python errors while running `doconce format`, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  - Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  - Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.
  - Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  - Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 
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
If translation to "http://johnmacfarlane.net/pandoc/":Pandoc is desired, 
the Pandoc Haskell program must of course be installed.
Demos
The current text is generated from a Doconce format stored in the::


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
"https://doconce.googlecode.com/hg/doc/demos/manual/index.html":demo web page
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file 'make.sh' in the same directory as the 'manual.do.txt' file
(the current text) shows how to run 'doconce format' on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the 'tutorial' directory there is also a 'make.sh' file producing a
lot of formats, with a corresponding
"https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html":web demo
of the results.
From Doconce to Other Formats
Transformation of a Doconce document 'mydoc.do.txt' to various other
formats applies the script 'doconce format':
!bc   sys
        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The 'mako' or 'preprocess' programs are always used to preprocess the
file first, and options to 'mako' or 'preprocess' can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable 'FORMAT' is always defined as the current format when
running 'preprocess'. That is, in the last example, 'FORMAT' is
defined as 'LaTeX'. Inside the Doconce document one can then perform
format specific actions through tests like '#if FORMAT == "LaTeX"'.

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.
HTML
Making an HTML version of a Doconce file 'mydoc.do.txt'
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file 'mydoc.html' can be loaded into any web browser for viewing.
LaTeX
Making a LaTeX file 'mydoc.tex' from 'mydoc.do.txt' is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form 'mydoc.p.tex' for
     'ptex2tex':
!bc   sys
        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files 'newcommands.tex', 'newcommands_keep.tex', or
'newcommands_replace.tex' (see the section "Macros (Newcommands)"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run 'ptex2tex' (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a '.p.tex' file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The 'ptex2tex' tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any '!bc sys' command in the Doconce source you can
insert verbatim block styles as defined in your '.ptex2tex.cfg'
file, e.g., '!bc sys cod' for a code snippet, where 'cod' is set to
a certain environment in '.ptex2tex.cfg' (e.g., 'CodeIntended').
There are over 30 styles to choose from.

*Step 3.* Compile 'mydoc.tex'
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the 'Minted_Python', 'Minted_Cpp', etc., environments
in 'ptex2tex' for typesetting code, the 'minted' LaTeX package is needed.
This package is included by running 'doconce format' with the
'-DMINTED' option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, 'latex' must be run with the
'-shell-escape' option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The '-shell-escape' option is required because the 'minted.sty' style
file runs the 'pygments' program to format code, and this program
cannot be run from 'latex' without the '-shell-escape' option.
Plain ASCII Text
We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt

reStructuredText
Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file 'mydoc.rst':
!bc   sys
        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file 'mydoc.odt' can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.
Sphinx
Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the 'sphinx-rootdir',
this command generates a script 'tmp_make_sphinx.sh' which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the 'tutorial.rst' file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


Note that verbatim code blocks can be typeset in a variety of ways
depending the argument that follows '!bc': 'cod' gives Python
('code-block:: python' in Sphinx syntax) and 'cppcod' gives C++, but
all such arguments can be customized both for Sphinx and LaTeX output.
Google Code Wiki
There are several different wiki dialects, but Doconce only support the
one used by "http://code.google.com/p/support/wiki/WikiSyntax":Google Code.
The transformation to this format, called 'gwiki' to explicitly mark
it as the Google Code dialect, is done by::


        Terminal> doconce format gwiki mydoc.do.txt

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
sections, subsections, paragraphs., figures, movies, etc.


*Heading with Title and Author(s).* Lines starting with 'TITLE:', 'AUTHOR:', and 'DATE:' are optional and used
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


*Section Headings.* Section headings are recognized by being surrounded by equal signs (=) or
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
Special Lines
Figures
Figures are recognized by the special line syntax::


        FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption

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

FIGURE:[figs/streamtubes, width=400] Streamtube visualization of a fluid flow. {fig:viz}
Movies
Here is an example on the 'MOVIE:' keyword for embedding movies. This
feature works well for the 'LaTeX', 'HTML', 'rst', and 'sphinx' formats.
Other formats try to generate some HTML file and link to that file
for showing the movie::


        MOVIE: [filename, height=xxx width=yyy] possible caption



 (Movie figs/mjolnir.mpeg: play "mjolnir.html":mjolnir.html)



The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the 'movie15' package wanted, one has to turn on the preprocessor
variable 'MOVIE15'. There is an associated variable
'EXTERNAL_MOVIE_VIEWER' which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader)::


        Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc


The HTML, reST, and Sphinx formats can also treat filenames of the form
'myframes*.png'. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the 'MOVIE:' command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).
Copying Computer Code
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
[hpl: Here is a specific example on an inline comment. It can
span several lines.]
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:viz}
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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


Conversion of BibTeX databases to reStructuredText format can be
done by the "http://pypi.python.org/pypi/bibliograph.parsing/":bibliograph.parsing tool.

Finally, we here test the citation command and bibliography by 
citing a book [1], a paper [2],
and both of them simultaneously [1] [2].

[somereader: comments, citations, and references in the latex style
is a special feature of doconce :-) ]
Tables
A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters 'c', 'r', or 'l' to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes '|' can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.
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
Two preprocessors are supported: preprocess 
("http://code.google.com/p/preprocess":http://code.google.com/p/preprocess) and mako
("http://www.makotemplates.org/":http://www.makotemplates.org/). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of 'name=value' command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable 'FORMAT'
defined as the desired output format of Doconce ('HTML', 'LaTeX',
'plain', 'rst', 'sphinx', 'epydoc', 'st').  It is then easy to test on
the value of 'FORMAT' and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).




FIGURE:[figs/wavepacket_0001.png, width=400] Wavepacket at time 0.1 s.

FIGURE:[figs/wavepacket_0010.png, width=400] Wavepacket at time 0.2 s.


Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section "From Doconce to Other Formats".

More advanced use of mako can include Python code that may automate
the writing of parts of the document.
Missing Features
  - Footnotes
Troubleshooting
*Disclaimer.* Doconce has some support for syntax checking.
If you encounter Python errors while running 'doconce format', the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)
 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  - Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 
  - Doconce can be converted to plain I{untagged} text, 
    often desirable for computer programs and email.
  - Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.
  - Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).
  - Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.
  - Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  - Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.
  - Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.
  - Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 



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
If translation to U{Pandoc<http://johnmacfarlane.net/pandoc/>} is desired, 
the Pandoc Haskell program must of course be installed.




Demos
-----


The current text is generated from a Doconce format stored in the::


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
U{demo web page<https://doconce.googlecode.com/hg/doc/demos/manual/index.html>}
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file C{make.sh} in the same directory as the C{manual.do.txt} file
(the current text) shows how to run C{doconce format} on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the C{tutorial} directory there is also a C{make.sh} file producing a
lot of formats, with a corresponding
U{web demo<https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html>}
of the results.



From Doconce to Other Formats
=============================

Transformation of a Doconce document C{mydoc.do.txt} to various other
formats applies the script C{doconce format}::


        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The C{mako} or C{preprocess} programs are always used to preprocess the
file first, and options to C{mako} or C{preprocess} can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable C{FORMAT} is always defined as the current format when
running C{preprocess}. That is, in the last example, C{FORMAT} is
defined as C{LaTeX}. Inside the Doconce document one can then perform
format specific actions through tests like C{#if FORMAT == "LaTeX"}.

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file C{mydoc.do.txt}
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file C{mydoc.html} can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file C{mydoc.tex} from C{mydoc.do.txt} is done in two steps:

I{Step 1.} Filter the doconce text to a pre-LaTeX form C{mydoc.p.tex} for
     C{ptex2tex}::


        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files C{newcommands.tex}, C{newcommands_keep.tex}, or
C{newcommands_replace.tex} (see the section "Macros (Newcommands)"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

I{Step 2.} Run C{ptex2tex} (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a C{.p.tex} file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The C{ptex2tex} tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any C{!bc sys} command in the Doconce source you can
insert verbatim block styles as defined in your C{.ptex2tex.cfg}
file, e.g., C{!bc sys cod} for a code snippet, where C{cod} is set to
a certain environment in C{.ptex2tex.cfg} (e.g., C{CodeIntended}).
There are over 30 styles to choose from.

I{Step 3.} Compile C{mydoc.tex}
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the C{Minted_Python}, C{Minted_Cpp}, etc., environments
in C{ptex2tex} for typesetting code, the C{minted} LaTeX package is needed.
This package is included by running C{doconce format} with the
C{-DMINTED} option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, C{latex} must be run with the
C{-shell-escape} option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The C{-shell-escape} option is required because the C{minted.sty} style
file runs the C{pygments} program to format code, and this program
cannot be run from C{latex} without the C{-shell-escape} option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file C{mydoc.rst}::


        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file C{mydoc.odt} can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

I{Step 1.} Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the C{sphinx-rootdir},
this command generates a script C{tmp_make_sphinx.sh} which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

I{Step 3.} Move the C{tutorial.rst} file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


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


        Terminal> doconce format gwiki mydoc.do.txt

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
sections, subsections, paragraphs., figures, movies, etc.


I{Heading with Title and Author(s).} Lines starting with C{TITLE:}, C{AUTHOR:}, and C{DATE:} are optional and used
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


I{Section Headings.} Section headings are recognized by being surrounded by equal signs (=) or
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

Special Lines
=============

Figures
-------

Figures are recognized by the special line syntax::


        FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption

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

FIGURE:[figs/streamtubes, width=400] Streamtube visualization of a fluid flow. {fig:viz}

Movies
------

Here is an example on the C{MOVIE:} keyword for embedding movies. This
feature works well for the C{LaTeX}, C{HTML}, C{rst}, and C{sphinx} formats.
Other formats try to generate some HTML file and link to that file
for showing the movie::


        MOVIE: [filename, height=xxx width=yyy] possible caption



 (Movie figs/mjolnir.mpeg: play U{mjolnir.html<mjolnir.html>})



The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the C{movie15} package wanted, one has to turn on the preprocessor
variable C{MOVIE15}. There is an associated variable
C{EXTERNAL_MOVIE_VIEWER} which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader)::


        Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc


The HTML, reST, and Sphinx formats can also treat filenames of the form
C{myframes*.png}. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the C{MOVIE:} command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).



Copying Computer Code
---------------------

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
[hpl: Here is a specific example on an inline comment. It can
span several lines.]
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
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:viz}
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
plain text, Epytext, StructuredText, HTML, and wiki formats.
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


Conversion of BibTeX databases to reStructuredText format can be
done by the U{bibliograph.parsing<http://pypi.python.org/pypi/bibliograph.parsing/>} tool.

Finally, we here test the citation command and bibliography by 
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
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters C{c}, C{r}, or C{l} to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes C{|} can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.



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
Two preprocessors are supported: preprocess 
(U{http://code.google.com/p/preprocess<http://code.google.com/p/preprocess>}) and mako
(U{http://www.makotemplates.org/<http://www.makotemplates.org/>}). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of C{name=value} command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable C{FORMAT}
defined as the desired output format of Doconce (C{HTML}, C{LaTeX},
C{plain}, C{rst}, C{sphinx}, C{epydoc}, C{st}).  It is then easy to test on
the value of C{FORMAT} and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).




FIGURE:[figs/wavepacket_0001.png, width=400] Wavepacket at time 0.1 s.

FIGURE:[figs/wavepacket_0010.png, width=400] Wavepacket at time 0.2 s.


Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section "From Doconce to Other Formats".

More advanced use of mako can include Python code that may automate
the writing of parts of the document.



Missing Features
----------------

  - Footnotes

Troubleshooting
---------------

I{Disclaimer.} Doconce has some support for syntax checking.
If you encounter Python errors while running C{doconce format}, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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


Date: Oct 22, 2011

What Is Doconce?
================


Doconce is two things:

 1. Doconce is a very simple and minimally tagged markup language that
    looks like ordinary ASCII text (much like what you would use in an
    email), but the text can be transformed to numerous other formats,
    including HTML, wiki, LaTeX, PDF, reStructuredText (reST), Sphinx,
    Epytext, and also plain text (where non-obvious formatting/tags are
    removed for clear reading in, e.g., emails). From reStructuredText
    you can go to XML, HTML, LaTeX, PDF, OpenOffice, and from the
    latter to RTF and MS Word.
    (An experimental translator to Pandoc is under development, and from
    Pandoc one can generate Markdown, reST, LaTeX, HTML, PDF, DocBook XML,
    OpenOffice, GNU Texinfo, MediaWiki, RTF, Groff, and other formats.)

 2. Doconce is a working strategy for never duplicating information.
    Text is written in a single place and then transformed to
    a number of different destinations of diverse type (software
    source code, manuals, tutorials, books, wikis, memos, emails, etc.).
    The Doconce markup language support this working strategy.
    The slogan is: "Write once, include anywhere".

Here are some Doconce features:

  * Doconce markup does include tags, so the format is more tagged than 
    Markdown and Pandoc, but less than reST, and very much less than 
    LaTeX and HTML. 

  * Doconce can be converted to plain *untagged* text, 
    often desirable for computer programs and email.

  * Doconce has good support for copying in parts of computer code,
    say in examples, directly from the source code files.

  * Doconce has full support for LaTeX math, and integrates very well
    with big LaTeX projects (books).

  * Doconce is almost self-explanatory and is a handy starting point
    for generating documents in more complicated markup languages, such
    as Google wiki, LaTeX, and Sphinx. A primary application of Doconce
    is just to make the initial versions of a Sphinx or wiki document.

  * Contrary to the similar Pandoc translator, Doconce integrates with
    Sphinx and Google wiki. However, if these formats are not of interest,
    Pandoc is obviously a superior tool.

Doconce was particularly written for the following sample applications:

  * Large books written in LaTeX, but where many pieces (computer demos,
    projects, examples) can be written in Doconce to appear in other
    contexts in other formats, including plain HTML, Sphinx, or MS Word.

  * Software documentation, primarily Python doc strings, which one wants
    to appear as plain untagged text for viewing in Pydoc, as reStructuredText
    for use with Sphinx, as wiki text when publishing the software at
    web sites, and as LaTeX integrated in, e.g., a thesis.

  * Quick memos, which start as plain text in email, then some small
    amount of Doconce tagging is added, before the memos can appear as
    MS Word documents or in wikis.

History: Doconce was developed in 2006 at a time when most popular
markup languages used quite some tagging.  Later, almost untagged
markup languages like Markdown and Pandoc became popular. Doconce is
not a replacement of Pandoc, which is a considerably more
sophisticated project. Moreover, Doconce was developed mainly to
fulfill the needs for a flexible source code base for books with much
mathematics and computer code.

Disclaimer: Doconce is a simple tool, largely based on interpreting
and handling text through regular expressions. The possibility for
tweaking the layout is obviously limited since the text can go to
all sorts of sophisticated markup languages. Moreover, because of
limitations of regular expressions, some formatting may face problems 
when transformed to other formats. 



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
If translation to Pandoc (http://johnmacfarlane.net/pandoc/) is desired, 
the Pandoc Haskell program must of course be installed.




Demos
-----


The current text is generated from a Doconce format stored in the::


        docs/manual/manual.do.txt

file in the Doconce source code tree. We have made a 
demo web page (https://doconce.googlecode.com/hg/doc/demos/manual/index.html)
where you can compare the Doconce source with the output in many
different formats: HTML, LaTeX, plain text, etc.

The file make.sh in the same directory as the manual.do.txt file
(the current text) shows how to run doconce format on the
Doconce file to obtain documents in various formats.

Another demo is found in::


        docs/tutorial/tutorial.do.txt

In the tutorial directory there is also a make.sh file producing a
lot of formats, with a corresponding
web demo (https://doconce.googlecode.com/hg/doc/demos/tutorial/index.html)
of the results.



From Doconce to Other Formats
=============================

Transformation of a Doconce document mydoc.do.txt to various other
formats applies the script doconce format::


        Terminal> doconce format format mydoc.do.txt

or just::


        Terminal> doconce format format mydoc

The mako or preprocess programs are always used to preprocess the
file first, and options to mako or preprocess can be added after the
filename. For example::


        Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5     # preprocess
        Terminal> doconce format LaTeX yourdoc extra_sections=True VAR1=5  # mako

The variable FORMAT is always defined as the current format when
running preprocess. That is, in the last example, FORMAT is
defined as LaTeX. Inside the Doconce document one can then perform
format specific actions through tests like #if FORMAT == "LaTeX".

Inline comments in the text are removed from the output by::


        Terminal> doconce format LaTeX mydoc remove_inline_comments

One can also remove such comments from the original Doconce file
by running 
source code::


        Terminal> doconce remove_inline_comments mydoc

This action is convenient when a Doconce document reaches its final form
and comments by different authors should be removed.


HTML
----

Making an HTML version of a Doconce file mydoc.do.txt
is performed by::


        Terminal> doconce format HTML mydoc

The resulting file mydoc.html can be loaded into any web browser for viewing.

LaTeX
-----

Making a LaTeX file mydoc.tex from mydoc.do.txt is done in two steps:

*Step 1.* Filter the doconce text to a pre-LaTeX form mydoc.p.tex for
     ptex2tex::


        Terminal> doconce format LaTeX mydoc

LaTeX-specific commands ("newcommands") in math formulas and similar
can be placed in files newcommands.tex, newcommands_keep.tex, or
newcommands_replace.tex (see the section "Macros (Newcommands)"). 
If these files are present, they are included in the LaTeX document 
so that your commands are defined.

*Step 2.* Run ptex2tex (if you have it) to make a standard LaTeX file::


        Terminal> ptex2tex mydoc

or just perform a plain copy::


        Terminal> cp mydoc.p.tex mydoc.tex

Doconce generates a .p.tex file with some preprocessor macros
that can be used to steer certain properties of the LaTeX document.
For example, to turn on the Helvetica font instead of the standard
Computer Modern font, run::


        Terminal> ptex2tex -DHELVETICA mydoc

The title, authors, and date are by default typeset in a non-standard
way to enable a nicer treatment of multiple authors having
institutions in common. However, the standard LaTeX "maketitle" heading
is also available through::


        Terminal> ptex2tex -DTRAD_LATEX_HEADING mydoc


The ptex2tex tool makes it possible to easily switch between many
different fancy formattings of computer or verbatim code in LaTeX
documents. After any !bc sys command in the Doconce source you can
insert verbatim block styles as defined in your .ptex2tex.cfg
file, e.g., !bc sys cod for a code snippet, where cod is set to
a certain environment in .ptex2tex.cfg (e.g., CodeIntended).
There are over 30 styles to choose from.

*Step 3.* Compile mydoc.tex
and create the PDF file::


        Terminal> latex mydoc
        Terminal> latex mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex mydoc
        Terminal> dvipdf mydoc

If one wishes to use the Minted_Python, Minted_Cpp, etc., environments
in ptex2tex for typesetting code, the minted LaTeX package is needed.
This package is included by running doconce format with the
-DMINTED option::


        Terminal> ptex2tex -DMINTED mydoc

In this case, latex must be run with the
-shell-escape option::


        Terminal> latex -shell-escape mydoc
        Terminal> latex -shell-escape mydoc
        Terminal> makeindex mydoc   # if index
        Terminal> bibitem mydoc     # if bibliography
        Terminal> latex -shell-escape mydoc
        Terminal> dvipdf mydoc

The -shell-escape option is required because the minted.sty style
file runs the pygments program to format code, and this program
cannot be run from latex without the -shell-escape option.


Plain ASCII Text
----------------

We can go from Doconce "back to" plain untagged text suitable for viewing
in terminal windows, inclusion in email text, or for insertion in
computer source code::


        Terminal> doconce format plain mydoc.do.txt  # results in mydoc.txt


reStructuredText
----------------

Going from Doconce to reStructuredText gives a lot of possibilities to
go to other formats. First we filter the Doconce text to a
reStructuredText file mydoc.rst::


        Terminal> doconce format rst mydoc.do.txt

We may now produce various other formats::


        Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML
        Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX
        Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML
        Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice

The OpenOffice file mydoc.odt can be loaded into OpenOffice and
saved in, among other things, the RTF format or the Microsoft Word format.
That is, one can easily go from Doconce to Microsoft Word.

Sphinx
------

Sphinx documents can be created from a Doconce source in a few steps.

*Step 1.* Translate Doconce into the Sphinx dialect of
the reStructuredText format::


        Terminal> doconce format sphinx mydoc.do.txt


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

These statements as well as points 3-5 can be automated by the command::


        Terminal> doconce sphinx_dir mydoc.do.txt

More precisely, in addition to making the sphinx-rootdir,
this command generates a script tmp_make_sphinx.sh which
can be run to carry out steps 3-5, and later to remake the
sphinx document.

*Step 3.* Move the tutorial.rst file to the Sphinx root directory::


        Terminal> mv mydoc.rst sphinx-rootdir

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


        Terminal> firefox _build/html/index.html


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


        Terminal> doconce format gwiki mydoc.do.txt

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
sections, subsections, paragraphs., figures, movies, etc.


*Heading with Title and Author(s).* Lines starting with TITLE:, AUTHOR:, and DATE: are optional and used
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


*Section Headings.* Section headings are recognized by being surrounded by equal signs (=) or
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

Special Lines
=============

Figures
-------

Figures are recognized by the special line syntax::


        FIGURE:[filename, height=xxx width=yyy scale=zzz] possible caption

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

FIGURE:[figs/streamtubes, width=400] Streamtube visualization of a fluid flow. {fig:viz}

Movies
------

Here is an example on the MOVIE: keyword for embedding movies. This
feature works well for the LaTeX, HTML, rst, and sphinx formats.
Other formats try to generate some HTML file and link to that file
for showing the movie::


        MOVIE: [filename, height=xxx width=yyy] possible caption



 (Movie figs/mjolnir.mpeg: play mjolnir.html)



The LaTeX format results in a file that can either make use of
the movie15 package (requires the PDF to be shown in Acrobat Reader)
or just a plain address to the movie. The HTML, reST, and
Sphinx formats will play
the movie right away by embedding the file in a standard HTML code,
provided the output format is HTML.
For all other formats a URL to an HTML file, which can play the code,
is inserted in the output document.

When movies are embedded in the PDF file via LaTeX and
the movie15 package wanted, one has to turn on the preprocessor
variable MOVIE15. There is an associated variable
EXTERNAL_MOVIE_VIEWER which can be defined to launch an external
viewer when displaying the PDF file (in Acrobat Reader)::


        Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc


The HTML, reST, and Sphinx formats can also treat filenames of the form
myframes*.png. In that case, an HTML file for showing the sequence of frames
is generated, and a link to this file is inserted in the output document.
That is, a simple "movie viewer" for the frames is made. 

Many publish their scientific movies on YouTube, and Doconce recognizes
YouTube URLs as movies. When the output is an HTML file, the movie will
be embedded, otherwise a URL to the YouTube page is inserted.
You should equip the MOVIE: command with the right width and height
of embedded YouTube movies (the parameters appear when you request
the embedded HTML code for the movie on the YouTube page).



Copying Computer Code
---------------------

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


        some URL like "MyPlace": "http://my.place.in.space/src"

which appears as some URL like MyPlace (http://my.place.in.space/src).
The space after colon is optional.
Link to a file is done by the URL keyword, a colon, and enclosing the
filename in double quotes::


        URL:"manual.do.txt"
        "URL": "manual.do.txt"
        url: "manual.do.txt"
        "url":"manual.do.txt"

All these constructions result in the link manual.do.txt.
To make the URL itself appear as link name, put an "URL", URL, or
the lower case version, before the text of the URL enclosed in double
quotes::


        Click on this link: URL:"http://some.where.net".


Doconce also supports inline comments in the text::


        [name: comment]

where name is the name of the author of the command, and comment is a 
plain text text. The name and comment are visible in the output unless doconce format
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
reStructuredText commands by doconce format. In the HTML and (Google
Code) wiki formats, labels become anchors and references become links,
and with LaTeX "label" and "ref" are just equipped with backslashes so
these commands work as usual in LaTeX.

It is, in general, recommended to use labels and references for
(sub)sections, equations, and figures only.
By the way, here is an example on referencing Figure ref{fig:viz}
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
Sphinx formats by the idx keyword, following a LaTeX-inspired syntax::


        idx{some index entry}
        idx{main entry!subentry}
        idx{`verbatim_text` and more}

The exclamation mark divides a main entry and a subentry. Backquotes
surround verbatim text, which is correctly transformed in a LaTeX setting to::


        \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and more}}

Everything related to the index simply becomes invisible in 
plain text, Epytext, StructuredText, HTML, and wiki formats.
Note: idx commands should be inserted outside paragraphs, not in between
the text as this may cause some strange behaviour of the formatting.
Index items are naturally placed right after section headings, before the
text begins. Index items related to the heading of a paragraph, however,
should be placed above the paragraph heading and not in between the
heading and the text.

Literature citations also follow a LaTeX-inspired style::


        as found in cite{Larsen:86,Nielsen:99}.

Citation labels can be separated by comma. In LaTeX, this is directly
translated to the corresponding cite command; in reStructuredText
and Sphinx the labels can be clicked, while in all the other text
formats the labels are consecutively numbered so the above citation
will typically look like::


        as found in [3][14]

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

In the LaTeX format, the .bib file will be used in the standard way,
in the reStructuredText and Sphinx formats, the .rst file will be
copied into the document at the place where the BIBFILE: keyword
appears, while all other formats will make use of the Python dictionary
typeset as an ordered Doconce list, replacing the BIBFILE: line
in the document.


Conversion of BibTeX databases to reStructuredText format can be
done by the bibliograph.parsing (http://pypi.python.org/pypi/bibliograph.parsing/) tool.

Finally, we here test the citation command and bibliography by 
citing a book [1], a paper [2],
and both of them simultaneously [1] [2].

Tables
------

A table like

============  ============  ============  
    time        velocity    acceleration  
============  ============  ============  
         0.0        1.4186         -5.01  
         2.0      1.376512        11.919  
         4.0        1.1E+1     14.717624  
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
the Doconce source in an ugly way?). In the line below the heading,
one can insert the characters c, r, or l to specify the
alignment of the columns (centered, right, or left, respectively).
Similar character can be inserted in the line above the header to
algn the headings. Pipes | can also be inserted to indicate
vertical rules in LaTeX tables (they are ignored for other formats).
Note that not all formats offer alignment of heading or entries
in tables (reStructuredText and Sphinx are examples). Also note that
Doconce tables are very simple: neither entries nor
headings can span several columns or rows. When that functionality
is needed, one can make use of the preprocessor and if-tests on
the format and insert format-specific code for tables.



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


        # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=console

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

And here is a C++ code snippet (cppcod style)::


        void myfunc(double* x, const double& myarr) {
            for (int i = 1; i < myarr.size(); i++) {
                myarr[i] = myarr[i] - x[i]*myarr[i-1]
            }
        }


Computer code can be copied directly from a file, if desired. The syntax
is then::


         @@@CODE myfile.f
         @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1

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

Preprocessing Steps
-------------------

Doconce allows preprocessor commands for, e.g., including files,
leaving out text, or inserting special text depending on the format.
Two preprocessors are supported: preprocess 
(http://code.google.com/p/preprocess) and mako
(http://www.makotemplates.org/). The former allows include and if-else
statements much like the well-known preprocessor in C and C++ (but it
does not allow sophisticated macro substitutions). The latter
preprocessor is a very powerful template system.  With Mako you can
automatically generate various type of text and steer the generation
through Python code embedded in the Doconce document. An arbitrary set
of name=value command-line arguments (at the end of the command line)
automatically define Mako variables that are substituted in the document.

Doconce will detect if preprocess or Mako commands are used and run
the relevant preprocessor prior to translating the Doconce source to a
specific format.

The preprocess and mako programs always have the variable FORMAT
defined as the desired output format of Doconce (HTML, LaTeX,
plain, rst, sphinx, epydoc, st).  It is then easy to test on
the value of FORMAT and take different actions for different
formats. For example, one may create special LaTeX output for figures,
say with multiple plots within a figure, while other formats may apply
a separate figure for each plot. Below is an example (see the Doconce
source code of this document to understand how preprocess is used to
create the example).




FIGURE:[figs/wavepacket_0001.png, width=400] Wavepacket at time 0.1 s.

FIGURE:[figs/wavepacket_0010.png, width=400] Wavepacket at time 0.2 s.


Other user-defined variables for the preprocessor can be set at 
the command line as explained in the section "From Doconce to Other Formats".

More advanced use of mako can include Python code that may automate
the writing of parts of the document.



Missing Features
----------------

  * Footnotes

Troubleshooting
---------------

*Disclaimer.* Doconce has some support for syntax checking.
If you encounter Python errors while running doconce format, the
reason for the error is most likely a syntax problem in your Doconce
source file. You have to track down this syntax problem yourself.

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


        \code{...}

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
        Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile

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

Bibliography
============

  1. H. P. Langtangen. *A Primer on Scientific Programming with Python*. Springer, 2009.

  2. H. Osnes and H. P. Langtangen. An efficient probabilistic finite element method for stochastic  groundwater flow. *Advances in Water Resources*, vol 22, 185-195, 1998.
************** File: /home/hpl/vc/doconce/test/test.output *****************
+ doconce format HTML testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in testdoc.html
+ doconce format LaTeX testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
latex: /home/hpl/vc/doconce/test/wavepacket_0001.html
output in testdoc.p.tex
+ doconce format plain testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in testdoc.txt
+ doconce format st testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in testdoc.st
+ doconce format sphinx testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt

Warning: the "alignat" environment will give errors in Sphinx:

        \begin{alignat}{2}
        a &= q + 4 + 5+ 6\qquad & \mbox{for } q\geq 0 \\ 
        b &= \nabla^2 u + \nabla^4 x & x\in\Omega 
        \end{alignat} 

output in testdoc.rst
+ mv -f testdoc.rst testdoc.sphinx.rst
+ doconce format rst testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in testdoc.rst
+ doconce format epytext testdoc.do.txt
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in testdoc.epytext
+ doconce format gwiki testdoc.do.txt remove_inline_comments MYVAR1=3 MYVAR2=a string
run mako preprocessor on testdoc.do.txt to make __tmp.do.txt
mako variables: {'MYVAR1': 3, 'MYVAR2': 'a string', 'FORMAT': 'gwiki'}
translate preprocessed Doconce text in __tmp.do.txt

NOTE: Place ../doc/manual/figs/streamtubes.png at some place on the web and edit the
      .gwiki page, either manually (seach for 'Figure: ')
      or use the doconce script:
      doconce gwiki_figsubst.py mydoc.gwiki URL

output in testdoc.gwiki
+ doconce guess_encoding encoding1.do.txt
+ cp encoding1.do.txt tmp1.do.txt
+ doconce change_encoding utf-8 latin1 tmp1.do.txt
+ doconce guess_encoding tmp1.do.txt
+ doconce change_encoding latin1 utf-8 tmp1.do.txt
+ doconce guess_encoding tmp1.do.txt
+ doconce guess_encoding encoding2.do.txt
+ cp encoding1.do.txt tmp2.do.txt
+ doconce change_encoding utf-8 latin1 tmp2.do.txt
+ doconce guess_encoding tmp2.do.txt+ ./clean.sh
Removing in /home/hpl/vc/doconce/doc/tutorial:
+ doconce format HTML tutorial.do.txt
run preprocess -DFORMAT=HTML  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.html
+ doconce format LaTeX tutorial.do.txt
run preprocess -DFORMAT=LaTeX  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.p.tex
+ ptex2tex -DHELVETICA tutorial
running preprocessor on tutorial.p.tex...  defines: 'HELVETICA'  done
done tutorial.p.tex -> tutorial.tex
+ latex tutorial.tex
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./tutorial.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/relsize.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def))))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/latin1.def))
(/home/hpl/texmf/tex/latex/misc/ptex2tex.sty
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz)) (/usr/share/texmf-texlive/tex/latex/moreverb/moreverb.sty
(/usr/share/texmf-texlive/tex/latex/tools/verbatim.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/home/hpl/texmf/tex/latex/misc/listings2.sty
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty)
(/usr/share/texmf-texlive/tex/latex/listings/listings.cfg))
(/home/hpl/texmf/tex/latex/misc/codehighlight.sty
(/usr/share/texmf/tex/latex/xcolor/xcolor.sty
(/etc/texmf/tex/latex/config/color.cfg)))
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty))
(/usr/share/texmf-texlive/tex/latex/psnfss/helvet.sty)
Writing index file tutorial.idx
No file tutorial.aux.
(/usr/share/texmf-texlive/tex/latex/psnfss/ot1phv.fd)
(/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))

Package hyperref Warning: Rerun to get /PageLabels entry.

(/usr/share/texmf-texlive/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omsphv.fd) [1]
Overfull \hbox (8.67865pt too wide) in paragraph at lines 120--124
\OT1/phv/m/n/10 er-at-ing doc-u-ments in more com-pli-cated markup lan-guages, 
such as Google
[2] [3] [4]

LaTeX Warning: Reference `my:first:sec' on page 5 undefined on input line 299.


LaTeX Warning: Reference `doconce2formats' on page 5 undefined on input line 30
4.


Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 341.

[5]
Overfull \hbox (45.00818pt too wide) in paragraph at lines 418--436
\OT1/phv/m/n/10 L[]T[]X per-forms the ex-pan-sion it-self). New-com-mands in fi
les with names []\OT1/cmtt/m/n/10 newcommands.tex

Overfull \hbox (11.08636pt too wide) in paragraph at lines 418--436
\OT1/phv/m/n/10 else-where through-out the text will usu-ally be placed in []\O
T1/cmtt/m/n/10 newcommands_replace.tex

Overfull \hbox (33.35646pt too wide) in paragraph at lines 418--436
\OT1/phv/m/n/10 and ex-panded by Do-conce. The def-i-ni-tions of new-com-mands 
in the []\OT1/cmtt/m/n/10 newcommands*.tex
[6] [7]

LaTeX Warning: Reference `newcommands' on page 8 undefined on input line 530.


Overfull \hbox (55.19026pt too wide) in paragraph at lines 528--533
\OT1/phv/m/n/10 be placed in files []\OT1/cmtt/m/n/10 newcommands.tex\OT1/phv/m
/n/10 , []\OT1/cmtt/m/n/10 newcommands_keep.tex\OT1/phv/m/n/10 , or []\OT1/cmtt
/m/n/10 newcommands_replace.tex
[8] [9] [10] [11] [12]
Overfull \hbox (20.44847pt too wide) in paragraph at lines 813--825
\OT1/phv/m/n/10 If you make use of pre-pro-ces-sor di-rec-tives in the Do-conce
 source, ei-ther [][][][][][]
No file tutorial.ind.
[13] (./tutorial.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on tutorial.dvi (13 pages, 56608 bytes).
Transcript written on tutorial.log.
+ latex tutorial.tex
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./tutorial.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/relsize.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def))))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/latin1.def))
(/home/hpl/texmf/tex/latex/misc/ptex2tex.sty
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz)) (/usr/share/texmf-texlive/tex/latex/moreverb/moreverb.sty
(/usr/share/texmf-texlive/tex/latex/tools/verbatim.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/home/hpl/texmf/tex/latex/misc/listings2.sty
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty)
(/usr/share/texmf-texlive/tex/latex/listings/listings.cfg))
(/home/hpl/texmf/tex/latex/misc/codehighlight.sty
(/usr/share/texmf/tex/latex/xcolor/xcolor.sty
(/etc/texmf/tex/latex/config/color.cfg)))
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty))
(/usr/share/texmf-texlive/tex/latex/psnfss/helvet.sty)
Writing index file tutorial.idx
(./tutorial.aux) (/usr/share/texmf-texlive/tex/latex/psnfss/ot1phv.fd)
(/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty)) (./tutorial.out)
(./tutorial.out) (/usr/share/texmf-texlive/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omsphv.fd) [1]
Overfull \hbox (8.67865pt too wide) in paragraph at lines 120--124
\OT1/phv/m/n/10 er-at-ing doc-u-ments in more com-pli-cated markup lan-guages, 
such as Google
[2] [3] [4]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 341.

[5]
Overfull \hbox (45.00818pt too wide) in paragraph at lines 418--436
\OT1/phv/m/n/10 L[]T[]X per-forms the ex-pan-sion it-self). New-com-mands in fi
les with names []\OT1/cmtt/m/n/10 newcommands.tex

Overfull \hbox (11.08636pt too wide) in paragraph at lines 418--436
\OT1/phv/m/n/10 else-where through-out the text will usu-ally be placed in []\O
T1/cmtt/m/n/10 newcommands_replace.tex

Overfull \hbox (33.35646pt too wide) in paragraph at lines 418--436
\OT1/phv/m/n/10 and ex-panded by Do-conce. The def-i-ni-tions of new-com-mands 
in the []\OT1/cmtt/m/n/10 newcommands*.tex
[6] [7]
Overfull \hbox (55.19026pt too wide) in paragraph at lines 528--533
\OT1/phv/m/n/10 be placed in files []\OT1/cmtt/m/n/10 newcommands.tex\OT1/phv/m
/n/10 , []\OT1/cmtt/m/n/10 newcommands_keep.tex\OT1/phv/m/n/10 , or []\OT1/cmtt
/m/n/10 newcommands_replace.tex
[8] [9] [10] [11] [12]
Overfull \hbox (20.44847pt too wide) in paragraph at lines 813--825
\OT1/phv/m/n/10 If you make use of pre-pro-ces-sor di-rec-tives in the Do-conce
 source, ei-ther [][][][][][]
No file tutorial.ind.
[13] (./tutorial.aux) )
(see the transcript file for additional information)
Output written on tutorial.dvi (13 pages, 58840 bytes).
Transcript written on tutorial.log.
+ dvipdf tutorial.dvi
+ doconce format sphinx tutorial.do.txt
run preprocess -DFORMAT=sphinx  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.rst
+ doconce sphinx_dir tutorial.do.txt
Making sphinx-rootdir
Welcome to the Sphinx 1.1pre quickstart utility.

Please enter values for the following settings (just press Enter to
accept a default value, if one is given in brackets).

Enter the root path for documentation.
> Root path for the documentation [.]: 
You have two options for placing the build directory for Sphinx output.
Either, you use a directory "_build" within the root path, or you separate
"source" and "build" directories within the root path.
> Separate source and build directories (y/N) [n]: 
Inside the root directory, two more directories will be created; "_templates"
for custom HTML templates and "_static" for custom stylesheets and other static
files. You can enter another prefix (such as ".") to replace the underscore.
> Name prefix for templates and static dir [_]: 
The project name will occur in several places in the built documentation.
> Project name: > Author name(s): 
Sphinx has the notion of a "version" and a "release" for the
software. Each version can have multiple releases. For example, for
Python the version is something like 2.5 or 3.0, while the release is
something like 2.5.1 or 3.0a1.  If you don't need this dual structure,
just set both to the same value.
> Project version: > Project release [1.0]: 
The file name suffix for source files. Commonly, this is either ".txt"
or ".rst".  Only files with this suffix are considered documents.
> Source file suffix [.rst]: 
One document is special in that it is considered the top node of the
"contents tree", that is, it is the root of the hierarchical structure
of the documents. Normally, this is "index", but if your "index"
document is a custom template, you can also set this to another filename.
> Name of your master document (without suffix) [index]: 
Sphinx can also add configuration for epub output:
> Do you want to use the epub builder (y/N) [n]: 
Please indicate if you want to use one of the following Sphinx extensions:
> autodoc: automatically insert docstrings from modules (y/N) [n]: > doctest: automatically test code snippets in doctest blocks (y/N) [n]: > intersphinx: link between Sphinx documentation of different projects (y/N) [n]: > todo: write "todo" entries that can be shown or hidden on build (y/N) [n]: > coverage: checks for documentation coverage (y/N) [n]: > pngmath: include math, rendered as PNG images (y/N) [n]: > jsmath: include math, rendered in the browser by JSMath (y/N) [n]: > ifconfig: conditional inclusion of content based on config values (y/N) [n]: > viewcode: include links to the source code of documented Python objects (y/N) [n]: 
A Makefile and a Windows command file can be generated for you so that you
only have to run e.g. `make html' instead of invoking sphinx-build
directly.
> Create Makefile? (Y/n) [y]: > Create Windows command file? (Y/n) [y]: 
Finished: An initial directory structure has been created.

You should now populate your master file sphinx-rootdir/index.rst and create other documentation
source files. Use the Makefile to build the docs, like so:
   make builder
where "builder" is one of the supported builders, e.g. html, latex or linkcheck.

'tmp_make_sphinx.sh' contains the steps to (re)compile the sphinx version.
You may want to rename this file for repeated reuse.
+ cp tutorial.rst tutorial.sphinx.rst
+ mv tutorial.rst sphinx-rootdir
+ cp index-sphinx sphinx-rootdir/index.rst
+ cd sphinx-rootdir
+ make clean
rm -rf _build/*
+ make html
sphinx-build -b html -d _build/doctrees   . _build/html
Making output directory...
Running Sphinx v1.1pre
loading pickled environment... not yet created
building [html]: targets for 2 source files that are out of date
updating environment: 2 added, 0 changed, 0 removed
reading sources... [ 50%] index
reading sources... [100%] tutorial

looking for now-outdated files... none found
pickling environment... done
checking consistency... done
preparing documents... done
writing output... [ 50%] index
writing output... [100%] tutorial

writing additional files... (0 module code pages) genindex search
copying static files... done
dumping search index... done
dumping object inventory... done
build succeeded.

Build finished. The HTML pages are in _build/html.
+ make latex
sphinx-build -b latex -d _build/doctrees   . _build/latex
Making output directory...
Running Sphinx v1.1pre
loading pickled environment... done
building [latex]: all documents
updating environment: 0 added, 0 changed, 0 removed
looking for now-outdated files... none found
processing DoconceDocumentOnceIncludeAnywhere.tex... index tutorial 
resolving references...
writing... /home/hpl/vc/doconce/doc/tutorial/sphinx-rootdir/tutorial.rst:: WARNING: unusable reference target found: tutorial.do.txt
done
copying TeX support files... done
build succeeded, 1 warning.

Build finished; the LaTeX files are in _build/latex.
Run `make' in that directory to run these through (pdf)latex (use `make latexpdf' here to do that automatically).
+ cd _build/latex
+ make clean
rm -f *.dvi *.log *.ind *.aux *.toc *.syn *.idx *.out *.ilg *.pla
+ make all-pdf
pdflatex  'DoconceDocumentOnceIncludeAnywhere.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDocumentOnceIncludeAnywhere.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDocumentOnceIncludeAnywhere.idx
No file DoconceDocumentOnceIncludeAnywhere.aux.
(/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2]
Adding blank page after the table of contents.
pdfTeX warning (ext4): destination with the same identifier (name{page.i}) has 
been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [1]pdfTeX warning (ext4): destination with the same iden
tifier (name{page.ii}) has been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [3] [4]
Chapter 2.
[5] [6]
Chapter 3.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [7]

LaTeX Warning: Hyper reference `tutorial:my-first-sec' on page 8 undefined on i
nput line 401.


LaTeX Warning: Hyper reference `tutorial:doconce2formats' on page 8 undefined o
n input line 406.

[8]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 466.

[9] [10]
Chapter 4.
[11]

LaTeX Warning: Hyper reference `tutorial:newcommands' on page 12 undefined on i
nput line 628.


Underfull \hbox (badness 10000) in paragraph at lines 626--631
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 626--631
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[12] [13]
Underfull \hbox (badness 10000) in paragraph at lines 791--795
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[14] [15] [16]
Chapter 5.
No file DoconceDocumentOnceIncludeAnywhere.ind.
[17] (./DoconceDocumentOnceIncludeAnywhere.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)pdfTeX warning (dest): name
{??} has been referenced but does not exist, replaced by a fixed one

{/usr/share/texmf-texlive/fonts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive
/fonts/type1/public/amsfonts/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type
1/public/amsfonts/cm/cmr10.pfb></usr/share/texmf-texlive/fonts/type1/public/ams
fonts/cm/cmr7.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy
10.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share
/texmf-texlive/fonts/type1/urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fon
ts/type1/urw/courier/ucrro8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helv
etic/uhvb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb>
</usr/share/texmf-texlive/fonts/type1/urw/times/utmb8a.pfb></usr/share/texmf-te
xlive/fonts/type1/urw/times/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/u
rw/times/utmr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb
>
Output written on DoconceDocumentOnceIncludeAnywhere.pdf (21 pages, 191497 byte
s).
Transcript written on DoconceDocumentOnceIncludeAnywhere.log.
pdflatex  'DoconceDocumentOnceIncludeAnywhere.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDocumentOnceIncludeAnywhere.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDocumentOnceIncludeAnywhere.idx
(./DoconceDocumentOnceIncludeAnywhere.aux)
(/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDocumentOnceIncludeAnywhere.out)
(./DoconceDocumentOnceIncludeAnywhere.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDocumentOnceIncludeAnywhere.toc)
Adding blank page after the table of contents.
pdfTeX warning (ext4): destination with the same identifier (name{page.i}) has 
been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [1]pdfTeX warning (ext4): destination with the same iden
tifier (name{page.ii}) has been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [3] [4]
Chapter 2.
[5] [6]
Chapter 3.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [7] [8]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 466.

[9] [10]
Chapter 4.
[11]
Underfull \hbox (badness 10000) in paragraph at lines 626--631
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 626--631
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[12] [13]
Underfull \hbox (badness 10000) in paragraph at lines 791--795
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[14] [15] [16]
Chapter 5.
No file DoconceDocumentOnceIncludeAnywhere.ind.
[17] (./DoconceDocumentOnceIncludeAnywhere.aux) )
(see the transcript file for additional information){/usr/share/texmf-texlive/f
onts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive/fonts/type1/public/amsfont
s/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr10.
pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></usr/sha
re/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/texmf-te
xlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/type1/
urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/ucrro8
a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr/share
/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-texlive/f
onts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times
/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb></usr/s
hare/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDocumentOnceIncludeAnywhere.pdf (21 pages, 202272 byte
s).
Transcript written on DoconceDocumentOnceIncludeAnywhere.log.
pdflatex  'DoconceDocumentOnceIncludeAnywhere.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDocumentOnceIncludeAnywhere.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDocumentOnceIncludeAnywhere.idx
(./DoconceDocumentOnceIncludeAnywhere.aux)
(/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDocumentOnceIncludeAnywhere.out)
(./DoconceDocumentOnceIncludeAnywhere.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDocumentOnceIncludeAnywhere.toc)
Adding blank page after the table of contents.
pdfTeX warning (ext4): destination with the same identifier (name{page.i}) has 
been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [1]pdfTeX warning (ext4): destination with the same iden
tifier (name{page.ii}) has been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [3] [4]
Chapter 2.
[5] [6]
Chapter 3.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [7] [8]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 466.

[9] [10]
Chapter 4.
[11]
Underfull \hbox (badness 10000) in paragraph at lines 626--631
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 626--631
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[12] [13]
Underfull \hbox (badness 10000) in paragraph at lines 791--795
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[14] [15] [16]
Chapter 5.
No file DoconceDocumentOnceIncludeAnywhere.ind.
[17] (./DoconceDocumentOnceIncludeAnywhere.aux) )
(see the transcript file for additional information){/usr/share/texmf-texlive/f
onts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive/fonts/type1/public/amsfont
s/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr10.
pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></usr/sha
re/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/texmf-te
xlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/type1/
urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/ucrro8
a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr/share
/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-texlive/f
onts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times
/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb></usr/s
hare/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDocumentOnceIncludeAnywhere.pdf (21 pages, 202272 byte
s).
Transcript written on DoconceDocumentOnceIncludeAnywhere.log.
makeindex -s python.ist 'DoconceDocumentOnceIncludeAnywhere.idx'
This is makeindex, version 2.15 [TeX Live 2009] (kpathsea + Thai support).
Scanning style file ./python.ist......done (6 attributes redefined, 0 ignored).
Scanning input file DoconceDocumentOnceIncludeAnywhere.idx...done (0 entries accepted, 0 rejected).
Nothing written in DoconceDocumentOnceIncludeAnywhere.ind.
Transcript written in DoconceDocumentOnceIncludeAnywhere.ilg.
pdflatex  'DoconceDocumentOnceIncludeAnywhere.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDocumentOnceIncludeAnywhere.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDocumentOnceIncludeAnywhere.idx
(./DoconceDocumentOnceIncludeAnywhere.aux)
(/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDocumentOnceIncludeAnywhere.out)
(./DoconceDocumentOnceIncludeAnywhere.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDocumentOnceIncludeAnywhere.toc)
Adding blank page after the table of contents.
pdfTeX warning (ext4): destination with the same identifier (name{page.i}) has 
been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [1]pdfTeX warning (ext4): destination with the same iden
tifier (name{page.ii}) has been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [3] [4]
Chapter 2.
[5] [6]
Chapter 3.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [7] [8]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 466.

[9] [10]
Chapter 4.
[11]
Underfull \hbox (badness 10000) in paragraph at lines 626--631
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 626--631
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[12] [13]
Underfull \hbox (badness 10000) in paragraph at lines 791--795
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[14] [15] [16]
Chapter 5.
(./DoconceDocumentOnceIncludeAnywhere.ind) [17]
(./DoconceDocumentOnceIncludeAnywhere.aux) )
(see the transcript file for additional information){/usr/share/texmf-texlive/f
onts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive/fonts/type1/public/amsfont
s/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr10.
pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></usr/sha
re/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/texmf-te
xlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/type1/
urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/ucrro8
a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr/share
/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-texlive/f
onts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times
/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb></usr/s
hare/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDocumentOnceIncludeAnywhere.pdf (21 pages, 202272 byte
s).
Transcript written on DoconceDocumentOnceIncludeAnywhere.log.
pdflatex  'DoconceDocumentOnceIncludeAnywhere.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDocumentOnceIncludeAnywhere.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDocumentOnceIncludeAnywhere.idx
(./DoconceDocumentOnceIncludeAnywhere.aux)
(/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDocumentOnceIncludeAnywhere.out)
(./DoconceDocumentOnceIncludeAnywhere.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDocumentOnceIncludeAnywhere.toc)
Adding blank page after the table of contents.
pdfTeX warning (ext4): destination with the same identifier (name{page.i}) has 
been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [1]pdfTeX warning (ext4): destination with the same iden
tifier (name{page.ii}) has been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [3] [4]
Chapter 2.
[5] [6]
Chapter 3.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [7] [8]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 466.

[9] [10]
Chapter 4.
[11]
Underfull \hbox (badness 10000) in paragraph at lines 626--631
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 626--631
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[12] [13]
Underfull \hbox (badness 10000) in paragraph at lines 791--795
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[14] [15] [16]
Chapter 5.
(./DoconceDocumentOnceIncludeAnywhere.ind) [17]
(./DoconceDocumentOnceIncludeAnywhere.aux) )
(see the transcript file for additional information){/usr/share/texmf-texlive/f
onts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive/fonts/type1/public/amsfont
s/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr10.
pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></usr/sha
re/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/texmf-te
xlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/type1/
urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/ucrro8
a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr/share
/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-texlive/f
onts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times
/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb></usr/s
hare/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDocumentOnceIncludeAnywhere.pdf (21 pages, 202272 byte
s).
Transcript written on DoconceDocumentOnceIncludeAnywhere.log.
+ cp DoconceDocumentOnceIncludeAnywhere.pdf ../../../tutorial.sphinx.pdf
+ cd ../../..
+ doconce format rst tutorial.do.txt
run preprocess -DFORMAT=rst  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.rst
+ rst2xml.py tutorial.rst
+ rst2odt.py tutorial.rst
+ rst2html.py tutorial.rst
+ rst2latex.py tutorial.rst
+ latex tutorial.rst.tex
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./tutorial.rst.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/base/fixltx2e.sty)
(/usr/share/texmf-texlive/tex/latex/cmap/cmap.sty

Package cmap Warning: pdftex in DVI mode - exiting.

) (/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty)
(/usr/share/texmf-texlive/tex/latex/caption/ltcaption.sty)
(/usr/share/texmf-texlive/tex/latex/tools/array.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/mathptmx.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/helvet.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/psnfss/courier.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
No file tutorial.rst.aux.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))

Package hyperref Warning: Rerun to get /PageLabels entry.

(/usr/share/texmf-texlive/tex/latex/psnfss/omsptm.fd)
Overfull \hbox (1.15796pt too wide) in paragraph at lines 116--122
\T1/ptm/m/n/10 etc.). The Do-conce markup lan-guage sup-port this work-ing stra
t-
[1] [2] (/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd)
Overfull \hbox (71.00006pt too wide) in paragraph at lines 265--265
[]\T1/pcr/m/n/10 Ordinary text looks like ordinary text, and the tags used for 
 

Overfull \hbox (83.00006pt too wide) in paragraph at lines 266--266
[]\T1/pcr/m/n/10 _boldface_ words, *emphasized* words, and `computer` words loo
k  

Overfull \hbox (125.00006pt too wide) in paragraph at lines 267--267
[]\T1/pcr/m/n/10 natural in plain text.  Lists are typeset as you would do in a
n email,  

Overfull \hbox (113.00006pt too wide) in paragraph at lines 273--273
[]\T1/pcr/m/n/10 Lists can also have automatically numbered items instead of bu
llets,  

Overfull \hbox (143.00006pt too wide) in paragraph at lines 279--279
[]\T1/pcr/m/n/10 URLs with a link word are possible, as in "hpl":"http://folk.u
io.no/hpl".  

Overfull \hbox (47.00006pt too wide) in paragraph at lines 280--280
[]\T1/pcr/m/n/10 If the word is URL, the URL itself becomes the link name,  

Overfull \hbox (83.00006pt too wide) in paragraph at lines 283--283
[]\T1/pcr/m/n/10 References to sections may use logical names as labels (e.g., 
a  
[3]
Overfull \hbox (125.00006pt too wide) in paragraph at lines 284--284
[]\T1/pcr/m/n/10 "label" command right after the section title), as in the refe
rence to  

Overfull \hbox (101.00006pt too wide) in paragraph at lines 287--287
[]\T1/pcr/m/n/10 Doconce also allows inline comments such as [hpl: here I will 
make  

Overfull \hbox (113.00006pt too wide) in paragraph at lines 288--288
[]\T1/pcr/m/n/10 some remarks to the text] for allowing authors to make notes. 
Inline  

Overfull \hbox (101.00006pt too wide) in paragraph at lines 289--289
[]\T1/pcr/m/n/10 comments can be removed from the output by a command-line argu
ment  

Overfull \hbox (5.00006pt too wide) in paragraph at lines 290--290
[]\T1/pcr/m/n/10 (see Chapter ref{doconce2formats} for an example).  
(/usr/share/texmf-texlive/tex/latex/psnfss/ot1ztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omlztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omsztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omxztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/ot1ptm.fd)

LaTeX Warning: Hyper reference `a-subsection-with-sample-text' on page 4 undefi
ned on input line 362.


Overfull \hbox (20.8859pt too wide) in paragraph at lines 360--363
\T1/ptm/m/n/10 right af-ter the sec-tion ti-tle), as in the ref-er-ence to the 
chap-ter [][][][][][]. 

LaTeX Warning: Hyper reference `from-doconce-to-other-formats' on page 4 undefi
ned on input line 367.


Overfull \hbox (7.8169pt too wide) in paragraph at lines 364--368
\T1/ptm/m/n/10 the out-put by a command-line ar-gu-ment (see the chap-ter [][][
][][][]
[4]
Overfull \hbox (77.00006pt too wide) in paragraph at lines 452--452
[]\T1/pcr/m/n/10 {\partial u\over\partial t} &=& \nabla^2 u + f, label{myeq1}\\
  

Overfull \hbox (71.00006pt too wide) in paragraph at lines 453--453
[]\T1/pcr/m/n/10 {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g 
 

Overfull \hbox (89.00006pt too wide) in paragraph at lines 485--488
[]\T1/pcr/m/n/10 # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=conso
le 

Overfull \hbox (1.13771pt too wide) in paragraph at lines 490--494
\T1/ptm/m/n/10 are com-puter lan-guage spe-cific for \T1/pcr/m/n/10 x \T1/ptm/m
/n/10 in \T1/pcr/m/n/10 f \T1/ptm/m/n/10 (For-tran), \T1/pcr/m/n/10 c \T1/ptm/m
/n/10 (C), \T1/pcr/m/n/10 cpp \T1/ptm/m/n/10 (C++), and \T1/pcr/m/n/10 py \T1/p
tm/m/n/10 (Python).
[5]
Overfull \hbox (4.24745pt too wide) in paragraph at lines 512--517
\T1/ptm/m/n/10 on a line start-ing with (an-other) hash sign. Do-conce doc-u-me
nts have ex-ten-sion \T1/pcr/m/n/10 do.txt\T1/ptm/m/n/10 .

Overfull \hbox (179.00006pt too wide) in paragraph at lines 591--592
\T1/pcr/m/n/10 Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5  
   # preprocess  

Overfull \hbox (143.00006pt too wide) in paragraph at lines 593--595
[]\T1/pcr/m/n/10 Terminal> doconce format LaTeX yourdoc extra_sections=True VAR
1=5  # mako 
[6]
Overfull \hbox (30.7872pt too wide) in paragraph at lines 597--601
[]\T1/ptm/m/n/10 The vari-able \T1/pcr/m/n/10 FORMAT \T1/ptm/m/n/10 is al-ways 
de-fined as the cur-rent for-mat when run-ning \T1/pcr/m/n/10 preprocess\T1/ptm
/m/n/10 .

Overfull \hbox (59.00006pt too wide) in paragraph at lines 604--607
[]\T1/pcr/m/n/10 Terminal> doconce format LaTeX mydoc remove_inline_comments 

Overfull \hbox (11.278pt too wide) in paragraph at lines 657--660
[]\T1/pcr/m/n/10 ptex2tex\T1/ptm/m/n/10 : 

LaTeX Warning: Hyper reference `macros-newcommands-cross-references-index-and-b
ibliography' on page 7 undefined on input line 669.


Overfull \hbox (78.51936pt too wide) in paragraph at lines 667--672
\T1/ptm/m/n/10 placed in files \T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \
T1/pcr/m/n/10 newcommands_keep.tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommand
s_replace.tex

Overfull \hbox (2.10667pt too wide) in paragraph at lines 667--672
\T1/ptm/m/n/10 (see the sec-tion [][][][][][]).
[7]
Overfull \hbox (107.00006pt too wide) in paragraph at lines 768--771
[]\T1/pcr/m/n/10 Terminal> doconce format plain mydoc.do.txt  # results in mydo
c.txt 

Overfull \hbox (17.00006pt too wide) in paragraph at lines 793--794
\T1/pcr/m/n/10 Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML  

Overfull \hbox (23.00006pt too wide) in paragraph at lines 795--795
[]\T1/pcr/m/n/10 Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX  
[8]
Overfull \hbox (11.00006pt too wide) in paragraph at lines 796--796
[]\T1/pcr/m/n/10 Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML  

Overfull \hbox (53.00006pt too wide) in paragraph at lines 797--799
[]\T1/pcr/m/n/10 Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice 
[9]
Overfull \hbox (31.15843pt too wide) in paragraph at lines 941--945
[]\T1/ptm/m/n/10 You can then open a new wiki page for your Google Code project
, copy the \T1/pcr/m/n/10 mydoc.gwiki

Overfull \hbox (1.98695pt too wide) in paragraph at lines 960--971
\T1/ptm/m/n/10 One ex-am-ple is fig-ure file-names when trans-form-ing Do-conce
 to re-Struc-tured-Text. Since
[10] [11] (./tutorial.rst.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on tutorial.rst.dvi (11 pages, 51684 bytes).
Transcript written on tutorial.rst.log.
+ dvipdf tutorial.rst.dvi
+ doconce format plain tutorial.do.txt
run preprocess -DFORMAT=plain  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.txt
+ doconce format gwiki tutorial.do.txt
run preprocess -DFORMAT=gwiki  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.gwiki
+ doconce format st tutorial.do.txt
run preprocess -DFORMAT=st  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.st
+ doconce format epytext tutorial.do.txt
run preprocess -DFORMAT=epytext  tutorial.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in tutorial.epytext
+ a2ps_plain=a2ps --left-title='' --right-title='' --left-footer='' --right-footer='' --footer=''
+ a2ps --left-title='' --right-title='' --left-footer='' --right-footer='' --footer='' -1 -o tutorial.do.ps tutorial.do.txt
[tutorial.do.txt (plain): 7 pages on 7 sheets]
[Total: 7 pages on 7 sheets] saved into the file `tutorial.do.ps'
[1 line wrapped]
+ ps2pdf tutorial.do.ps tutorial.do.pdf
+ a2ps --left-title='' --right-title='' --left-footer='' --right-footer='' --footer='' -1 -o tutorial.epytext.ps tutorial.epytext
[tutorial.epytext (plain): 12 pages on 12 sheets]
[Total: 12 pages on 12 sheets] saved into the file `tutorial.epytext.ps'
[6 lines wrapped]
+ ps2pdf tutorial.epytext.ps
+ a2ps --left-title='' --right-title='' --left-footer='' --right-footer='' --footer='' -1 -o tutorial.txt.ps tutorial.txt
[tutorial.txt (plain): 13 pages on 13 sheets]
[Total: 13 pages on 13 sheets] saved into the file `tutorial.txt.ps'
[5 lines wrapped]
+ ps2pdf tutorial.txt.ps
+ a2ps --left-title='' --right-title='' --left-footer='' --right-footer='' --footer='' -1 -o tutorial.gwiki.ps tutorial.gwiki
[tutorial.gwiki (plain): 11 pages on 11 sheets]
[Total: 11 pages on 11 sheets] saved into the file `tutorial.gwiki.ps'
[63 lines wrapped]
+ ps2pdf tutorial.gwiki.ps
+ a2ps --left-title='' --right-title='' --left-footer='' --right-footer='' --footer='' -1 -o tutorial.xml.ps tutorial.xml
[tutorial.xml (plain): 11 pages on 11 sheets]
[Total: 11 pages on 11 sheets] saved into the file `tutorial.xml.ps'
[300 lines wrapped]
+ ps2pdf tutorial.xml.ps
+ rm -f tutorial.do.ps tutorial.epytext.ps tutorial.gwiki.ps tutorial.txt.ps tutorial.xml.ps
+ pdftk tutorial.do.pdf tutorial.pdf tutorial.rst.pdf tutorial.sphinx.pdf tutorial.txt.pdf tutorial.epytext.pdf tutorial.gwiki.pdf tutorial.sphinx.pdf tutorial.xml.pdf cat output collection_of_results.pdf
+ rm -rf demo
+ mkdir demo
+ cp -r tutorial.do.txt tutorial.html tutorial.tex tutorial.pdf tutorial.rst tutorial.sphinx.rst tutorial.sphinx.pdf tutorial.xml tutorial.rst.html tutorial.rst.tex tutorial.rst.pdf tutorial.gwiki tutorial.txt tutorial.epytext tutorial.st collection_of_results.pdf sphinx-rootdir/_build/html demo
+ cd demo
+ cat
+ echo

+ echo Go to the demo directory and load index.html into a web browser.
Go to the demo directory and load index.html into a web browser.
+ cd ..
+ rm -rf ../demos/tutorial
+ cp -r demo ../demos/tutorial+ ./clean.sh
Removing in /home/hpl/vc/doconce/doc/manual:
+ d2f=doconce format
+ doconce format HTML manual.do.txt
run preprocess -DFORMAT=HTML  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.html
+ doconce format sphinx manual.do.txt
run preprocess -DFORMAT=sphinx  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.rst
+ doconce sphinx_dir manual.do.txt
Making sphinx-rootdir
Welcome to the Sphinx 1.1pre quickstart utility.

Please enter values for the following settings (just press Enter to
accept a default value, if one is given in brackets).

Enter the root path for documentation.
> Root path for the documentation [.]: 
You have two options for placing the build directory for Sphinx output.
Either, you use a directory "_build" within the root path, or you separate
"source" and "build" directories within the root path.
> Separate source and build directories (y/N) [n]: 
Inside the root directory, two more directories will be created; "_templates"
for custom HTML templates and "_static" for custom stylesheets and other static
files. You can enter another prefix (such as ".") to replace the underscore.
> Name prefix for templates and static dir [_]: 
The project name will occur in several places in the built documentation.
> Project name: > Author name(s): 
Sphinx has the notion of a "version" and a "release" for the
software. Each version can have multiple releases. For example, for
Python the version is something like 2.5 or 3.0, while the release is
something like 2.5.1 or 3.0a1.  If you don't need this dual structure,
just set both to the same value.
> Project version: > Project release [1.0]: 
The file name suffix for source files. Commonly, this is either ".txt"
or ".rst".  Only files with this suffix are considered documents.
> Source file suffix [.rst]: 
One document is special in that it is considered the top node of the
"contents tree", that is, it is the root of the hierarchical structure
of the documents. Normally, this is "index", but if your "index"
document is a custom template, you can also set this to another filename.
> Name of your master document (without suffix) [index]: 
Sphinx can also add configuration for epub output:
> Do you want to use the epub builder (y/N) [n]: 
Please indicate if you want to use one of the following Sphinx extensions:
> autodoc: automatically insert docstrings from modules (y/N) [n]: > doctest: automatically test code snippets in doctest blocks (y/N) [n]: > intersphinx: link between Sphinx documentation of different projects (y/N) [n]: > todo: write "todo" entries that can be shown or hidden on build (y/N) [n]: > coverage: checks for documentation coverage (y/N) [n]: > pngmath: include math, rendered as PNG images (y/N) [n]: > jsmath: include math, rendered in the browser by JSMath (y/N) [n]: > ifconfig: conditional inclusion of content based on config values (y/N) [n]: > viewcode: include links to the source code of documented Python objects (y/N) [n]: 
A Makefile and a Windows command file can be generated for you so that you
only have to run e.g. `make html' instead of invoking sphinx-build
directly.
> Create Makefile? (Y/n) [y]: > Create Windows command file? (Y/n) [y]: 
Finished: An initial directory structure has been created.

You should now populate your master file sphinx-rootdir/index.rst and create other documentation
source files. Use the Makefile to build the docs, like so:
   make builder
where "builder" is one of the supported builders, e.g. html, latex or linkcheck.

'tmp_make_sphinx.sh' contains the steps to (re)compile the sphinx version.
You may want to rename this file for repeated reuse.
+ cp manual.rst manual.sphinx.rst
+ cp manual.rst sphinx-rootdir
+ cp index-sphinx sphinx-rootdir/index.rst
+ cp -r figs sphinx-rootdir
+ cd sphinx-rootdir
+ make clean
rm -rf _build/*
+ make html
sphinx-build -b html -d _build/doctrees   . _build/html
Making output directory...
Running Sphinx v1.1pre
loading pickled environment... not yet created
building [html]: targets for 2 source files that are out of date
updating environment: 2 added, 0 changed, 0 removed
reading sources... [ 50%] index
reading sources... [100%] manual

looking for now-outdated files... none found
pickling environment... done
checking consistency... done
preparing documents... done
writing output... [ 50%] index
writing output... [100%] manual

/home/hpl/vc/doconce/doc/manual/sphinx-rootdir/manual.rst:1027: WARNING: undefined label: my:eq1 (if the link has no caption the label must precede a section header)
/home/hpl/vc/doconce/doc/manual/sphinx-rootdir/manual.rst:1027: WARNING: undefined label: my:eq2 (if the link has no caption the label must precede a section header)
writing additional files... (0 module code pages) genindex search
copying images... [ 33%] figs/wavepacket_0001.png
copying images... [ 66%] figs/wavepacket_0010.png
copying images... [100%] figs/streamtubes.png

copying static files... done
dumping search index... done
dumping object inventory... done
build succeeded, 2 warnings.

Build finished. The HTML pages are in _build/html.
+ make latex
sphinx-build -b latex -d _build/doctrees   . _build/latex
Making output directory...
Running Sphinx v1.1pre
loading pickled environment... done
building [latex]: all documents
updating environment: 0 added, 0 changed, 0 removed
looking for now-outdated files... none found
processing DoconceDescription.tex... index manual 
resolving references...
/home/hpl/vc/doconce/doc/manual/sphinx-rootdir/manual.rst:: WARNING: undefined label: my:eq1 (if the link has no caption the label must precede a section header)
/home/hpl/vc/doconce/doc/manual/sphinx-rootdir/manual.rst:: WARNING: undefined label: my:eq2 (if the link has no caption the label must precede a section header)
writing... /home/hpl/vc/doconce/doc/manual/sphinx-rootdir/manual.rst:: WARNING: unusable reference target found: manual.do.txt
done
copying images... figs/wavepacket_0001.png figs/wavepacket_0010.png figs/streamtubes.png
copying TeX support files... done
build succeeded, 3 warnings.

Build finished; the LaTeX files are in _build/latex.
Run `make' in that directory to run these through (pdf)latex (use `make latexpdf' here to do that automatically).
+ doconce subst \.\* .pdf _build/latex/DoconceDescription.tex
\.\* replaced by .pdf in _build/latex/DoconceDescription.tex
+ pwd
+ ln -s /home/hpl/vc/doconce/doc/manual/sphinx-rootdir/../figs _build/latex/figs
+ cd _build/latex
+ make clean
rm -f *.dvi *.log *.ind *.aux *.toc *.syn *.idx *.out *.ilg *.pla
+ make all-pdf
pdflatex  'DoconceDescription.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDescription.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDescription.idx
No file DoconceDescription.aux.
(/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2]
Adding blank page after the table of contents.
pdfTeX warning (ext4): destination with the same identifier (name{page.i}) has 
been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [1]pdfTeX warning (ext4): destination with the same iden
tifier (name{page.ii}) has been already used, duplicate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
[3] [4]
Chapter 2.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [5]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [6]
Chapter 3.
[7]

LaTeX Warning: Hyper reference `manual:newcommands' on page 8 undefined on inpu
t line 347.


Underfull \hbox (badness 10000) in paragraph at lines 345--350
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 345--350
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[8] [9]
Underfull \hbox (badness 10000) in paragraph at lines 510--514
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[10] [11] [12]
Chapter 4.
[13] [14] [15] [16]
Chapter 5.
[17] [18]
Chapter 6.
<streamtubes.png, id=137, 583.17876pt x 437.635pt> <use streamtubes.png>
<use streamtubes.png> [19] [20 <./streamtubes.png>]

LaTeX Warning: Hyper reference `manual:sec-verbatim-blocks' on page 21 undefine
d on input line 909.

[21]

LaTeX Warning: Hyper reference `manual:doconce2formats' on page 22 undefined on
 input line 1000.


LaTeX Warning: Hyper reference `manual:doconce2formats' on page 22 undefined on
 input line 1006.


LaTeX Warning: Hyper reference `manual:fig-viz' on page 22 undefined on input l
ine 1059.


LaTeX Warning: Hyper reference `manual:mathtext' on page 22 undefined on input 
line 1061.


LaTeX Warning: Hyper reference `manual:newcommands' on page 22 undefined on inp
ut line 1061.


LaTeX Warning: Hyper reference `manual:inline-tagging' on page 22 undefined on 
input line 1068.

[22]

LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1154.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1154.


LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1155.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1155.

[23] [24] [25]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1376.

[26] <wavepacket_0001.png, id=209, 642.4pt x 481.8pt>
<use wavepacket_0001.png> <use wavepacket_0001.png>
<wavepacket_0010.png, id=210, 642.4pt x 481.8pt> <use wavepacket_0010.png>
<use wavepacket_0010.png>

LaTeX Warning: Hyper reference `manual:doconce2formats' on page 27 undefined on
 input line 1488.

[27] [28 <./wavepacket_0001.png (PNG copy)>] [29 <./wavepacket_0010.png (PNG co
py)>]

LaTeX Warning: Hyper reference `manual:sec-verbatim-blocks' on page 30 undefine
d on input line 1555.

[30] [31] [32] [33] [34]
Chapter 7.
[35] [36]
No file DoconceDescription.ind.
[37] (./DoconceDescription.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)pdfTeX warning (dest): name
{??} has been referenced but does not exist, replaced by a fixed one

{/usr/share/texmf-texlive/fonts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive
/fonts/type1/public/amsfonts/cm/cmbx10.pfb></usr/share/texmf-texlive/fonts/type
1/public/amsfonts/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/am
sfonts/cm/cmmib10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/
cmr10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></u
sr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/te
xmf-texlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/
type1/urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/
ucrro8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr
/share/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-tex
live/fonts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw
/times/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb><
/usr/share/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDescription.pdf (41 pages, 342298 bytes).
Transcript written on DoconceDescription.log.
pdflatex  'DoconceDescription.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDescription.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDescription.idx
(./DoconceDescription.aux) (/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDescription.out) (./DoconceDescription.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDescription.tocpdfTeX warning (ext4)
: destination with the same identifier (name{page.i}) has been already used, du
plicate ignored
<to be read again> 
                   \relax 
l.38 ...line {7}Indices and tables}{35}{chapter.7}
                                                   [1])pdfTeX warning (ext4): d
estination with the same identifier (name{page.ii}) has been already used, dupl
icate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
[3] [4]
Chapter 2.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [5]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [6]
Chapter 3.
[7]
Underfull \hbox (badness 10000) in paragraph at lines 345--350
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 345--350
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[8] [9]
Underfull \hbox (badness 10000) in paragraph at lines 510--514
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[10] [11] [12]
Chapter 4.
[13] [14] [15] [16]
Chapter 5.
[17] [18]
Chapter 6.
<streamtubes.png, id=304, 583.17876pt x 437.635pt> <use streamtubes.png>
<use streamtubes.png> [19] [20 <./streamtubes.png>] [21] [22]

LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1154.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1154.


LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1155.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1155.

[23] [24] [25]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1376.

[26] <wavepacket_0001.png, id=366, 642.4pt x 481.8pt>
<use wavepacket_0001.png> <use wavepacket_0001.png>
<wavepacket_0010.png, id=367, 642.4pt x 481.8pt> <use wavepacket_0010.png>
<use wavepacket_0010.png> [27] [28 <./wavepacket_0001.png (PNG copy)>] [29 <./w
avepacket_0010.png (PNG copy)>] [30] [31] [32] [33] [34]
Chapter 7.
[35] [36]
No file DoconceDescription.ind.
[37] (./DoconceDescription.aux)

LaTeX Warning: There were undefined references.

 )
(see the transcript file for additional information)pdfTeX warning (dest): name
{??} has been referenced but does not exist, replaced by a fixed one

{/usr/share/texmf-texlive/fonts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive
/fonts/type1/public/amsfonts/cm/cmbx10.pfb></usr/share/texmf-texlive/fonts/type
1/public/amsfonts/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/am
sfonts/cm/cmmib10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/
cmr10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></u
sr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/te
xmf-texlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/
type1/urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/
ucrro8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr
/share/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-tex
live/fonts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw
/times/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb><
/usr/share/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDescription.pdf (41 pages, 362584 bytes).
Transcript written on DoconceDescription.log.
pdflatex  'DoconceDescription.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDescription.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDescription.idx
(./DoconceDescription.aux) (/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDescription.out) (./DoconceDescription.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDescription.tocpdfTeX warning (ext4)
: destination with the same identifier (name{page.i}) has been already used, du
plicate ignored
<to be read again> 
                   \relax 
l.38 ...line {7}Indices and tables}{35}{chapter.7}
                                                   [1])pdfTeX warning (ext4): d
estination with the same identifier (name{page.ii}) has been already used, dupl
icate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
[3] [4]
Chapter 2.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [5]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [6]
Chapter 3.
[7]
Underfull \hbox (badness 10000) in paragraph at lines 345--350
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 345--350
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[8] [9]
Underfull \hbox (badness 10000) in paragraph at lines 510--514
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[10] [11] [12]
Chapter 4.
[13] [14] [15] [16]
Chapter 5.
[17] [18]
Chapter 6.
<streamtubes.png, id=304, 583.17876pt x 437.635pt> <use streamtubes.png>
<use streamtubes.png> [19] [20 <./streamtubes.png>] [21] [22]

LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1154.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1154.


LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1155.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1155.

[23] [24] [25]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1376.

[26] <wavepacket_0001.png, id=366, 642.4pt x 481.8pt>
<use wavepacket_0001.png> <use wavepacket_0001.png>
<wavepacket_0010.png, id=367, 642.4pt x 481.8pt> <use wavepacket_0010.png>
<use wavepacket_0010.png> [27] [28 <./wavepacket_0001.png (PNG copy)>] [29 <./w
avepacket_0010.png (PNG copy)>] [30] [31] [32] [33] [34]
Chapter 7.
[35] [36]
No file DoconceDescription.ind.
[37] (./DoconceDescription.aux)

LaTeX Warning: There were undefined references.

 )
(see the transcript file for additional information)pdfTeX warning (dest): name
{??} has been referenced but does not exist, replaced by a fixed one

{/usr/share/texmf-texlive/fonts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive
/fonts/type1/public/amsfonts/cm/cmbx10.pfb></usr/share/texmf-texlive/fonts/type
1/public/amsfonts/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/am
sfonts/cm/cmmib10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/
cmr10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></u
sr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/te
xmf-texlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/
type1/urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/
ucrro8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr
/share/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-tex
live/fonts/type1/urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw
/times/utmbi8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb><
/usr/share/texmf-texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDescription.pdf (41 pages, 362584 bytes).
Transcript written on DoconceDescription.log.
makeindex -s python.ist 'DoconceDescription.idx'
This is makeindex, version 2.15 [TeX Live 2009] (kpathsea + Thai support).
Scanning style file ./python.ist......done (6 attributes redefined, 0 ignored).
Scanning input file DoconceDescription.idx....done (19 entries accepted, 0 rejected).
Sorting entries....done (82 comparisons).
Generating output file DoconceDescription.ind....done (60 lines written, 0 warnings).
Output written in DoconceDescription.ind.
Transcript written in DoconceDescription.ilg.
pdflatex  'DoconceDescription.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDescription.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDescription.idx
(./DoconceDescription.aux) (/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDescription.out) (./DoconceDescription.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDescription.tocpdfTeX warning (ext4)
: destination with the same identifier (name{page.i}) has been already used, du
plicate ignored
<to be read again> 
                   \relax 
l.38 ...line {7}Indices and tables}{35}{chapter.7}
                                                   [1])pdfTeX warning (ext4): d
estination with the same identifier (name{page.ii}) has been already used, dupl
icate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
[3] [4]
Chapter 2.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [5]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [6]
Chapter 3.
[7]
Underfull \hbox (badness 10000) in paragraph at lines 345--350
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 345--350
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[8] [9]
Underfull \hbox (badness 10000) in paragraph at lines 510--514
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[10] [11] [12]
Chapter 4.
[13] [14] [15] [16]
Chapter 5.
[17] [18]
Chapter 6.
<streamtubes.png, id=304, 583.17876pt x 437.635pt> <use streamtubes.png>
<use streamtubes.png> [19] [20 <./streamtubes.png>] [21] [22]

LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1154.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1154.


LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1155.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1155.

[23] [24] [25]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1376.

[26] <wavepacket_0001.png, id=366, 642.4pt x 481.8pt>
<use wavepacket_0001.png> <use wavepacket_0001.png>
<wavepacket_0010.png, id=367, 642.4pt x 481.8pt> <use wavepacket_0010.png>
<use wavepacket_0010.png> [27] [28 <./wavepacket_0001.png (PNG copy)>] [29 <./w
avepacket_0010.png (PNG copy)>] [30] [31] [32] [33] [34]
Chapter 7.
[35] [36] (./DoconceDescription.ind [37] [38] [39]) (./DoconceDescription.aux)

LaTeX Warning: There were undefined references.

 )
(see the transcript file for additional information)pdfTeX warning (dest): name
{??} has been referenced but does not exist, replaced by a fixed one

{/usr/share/texmf-texlive/fonts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive
/fonts/type1/public/amsfonts/cm/cmbx10.pfb></usr/share/texmf-texlive/fonts/type
1/public/amsfonts/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/am
sfonts/cm/cmmib10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/
cmr10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></u
sr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/te
xmf-texlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/
type1/urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/
ucrro8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr
/share/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-tex
live/fonts/type1/urw/helvetic/uhvr8a.pfb></usr/share/texmf-texlive/fonts/type1/
urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmbi8a.pf
b></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb></usr/share/texmf-
texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDescription.pdf (43 pages, 372381 bytes).
Transcript written on DoconceDescription.log.
pdflatex  'DoconceDescription.tex'
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./DoconceDescription.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(./sphinxmanual.cls
Document Class: sphinxmanual 2009/06/02 Document class (Sphinx manual)
(/usr/share/texmf-texlive/tex/latex/base/report.cls
Document Class: report 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo)))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/generic/babel/babel.sty
(/usr/share/texmf-texlive/tex/generic/babel/english.ldf
(/usr/share/texmf-texlive/tex/generic/babel/babel.def)))
(/usr/share/texmf-texlive/tex/latex/psnfss/times.sty) (./fncychap.sty)
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty) (./sphinx.sty
(/usr/share/texmf-texlive/tex/latex/base/textcomp.sty
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.def
(/usr/share/texmf-texlive/tex/latex/base/ts1enc.dfu)))
(/usr/share/texmf-texlive/tex/latex/fancyhdr/fancyhdr.sty)
(/usr/share/texmf-texlive/tex/latex/fancybox/fancybox.sty
Style option: `fancybox' v1.3 <2000/09/19> (tvz)
) (/usr/share/texmf-texlive/tex/latex/titlesec/titlesec.sty) (./tabulary.sty
(/usr/share/texmf-texlive/tex/latex/tools/array.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/pdftex-def/pdftex.def))
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz) (/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/threeparttable.sty)
(/usr/share/texmf-texlive/tex/latex/mdwtools/footnote.sty)
(/usr/share/texmf-texlive/tex/latex/wrapfig/wrapfig.sty)
(/usr/share/texmf-texlive/tex/latex/ltxmisc/parskip.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)))
(/usr/share/texmf-texlive/tex/plain/misc/pdfcolor.tex)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hpdftex*
(/usr/share/texmf-texlive/tex/latex/hyperref/hpdftex.def)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hypcap.sty))
Writing index file DoconceDescription.idx
(./DoconceDescription.aux) (/home/hpl/texmf/tex/latex/misc/ts1cmr.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/context/base/supp-pdf.mkii
[Loading MPS to PDF converter (version 2006.09.02).]
) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))
(./DoconceDescription.out) (./DoconceDescription.out)
Underfull \hbox (badness 10000) in paragraph at lines 112--112

(/usr/share/texmf-texlive/tex/latex/psnfss/t1phv.fd) [1{/var/lib/texmf/fonts/ma
p/pdftex/updmap/pdftex.map}] [2] (./DoconceDescription.tocpdfTeX warning (ext4)
: destination with the same identifier (name{page.i}) has been already used, du
plicate ignored
<to be read again> 
                   \relax 
l.38 ...line {7}Indices and tables}{35}{chapter.7}
                                                   [1])pdfTeX warning (ext4): d
estination with the same identifier (name{page.ii}) has been already used, dupl
icate ignored
<to be read again> 
                   \relax 
l.112 \tableofcontents
                       [2] [1] [2]
Chapter 1.
[3] [4]
Chapter 2.
(/usr/share/texmf-texlive/tex/latex/psnfss/ts1ptm.fd) [5]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [6]
Chapter 3.
[7]
Underfull \hbox (badness 10000) in paragraph at lines 345--350
[]\T1/ptm/m/n/10 LaTeX-specific com-mands (``new-com-mands'') in math for-mu-la
s and sim-i-lar can be placed in files

Underfull \hbox (badness 5359) in paragraph at lines 345--350
\T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \T1/pcr/m/n/10 newcommands_keep.
tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommands_replace.tex \T1/ptm/m/n/10 (s
ee the sec-tion
[8] [9]
Underfull \hbox (badness 10000) in paragraph at lines 510--514
[]\T1/ptm/m/n/10 More pre-cisely, in ad-di-tion to mak-ing the \T1/pcr/m/n/10 s
phinx-rootdir\T1/ptm/m/n/10 , this com-mand gen-er-ates a script
[10] [11] [12]
Chapter 4.
[13] [14] [15] [16]
Chapter 5.
[17] [18]
Chapter 6.
<streamtubes.png, id=309, 583.17876pt x 437.635pt> <use streamtubes.png>
<use streamtubes.png> [19] [20 <./streamtubes.png>] [21] [22]

LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1154.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1154.


LaTeX Warning: Hyper reference `manual:python-primer-09' on page 23 undefined o
n input line 1155.


LaTeX Warning: Hyper reference `manual:osnes-98' on page 23 undefined on input 
line 1155.

[23] [24] [25]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1376.

[26] <wavepacket_0001.png, id=371, 642.4pt x 481.8pt>
<use wavepacket_0001.png> <use wavepacket_0001.png>
<wavepacket_0010.png, id=372, 642.4pt x 481.8pt> <use wavepacket_0010.png>
<use wavepacket_0010.png> [27] [28 <./wavepacket_0001.png (PNG copy)>] [29 <./w
avepacket_0010.png (PNG copy)>] [30] [31] [32] [33] [34]
Chapter 7.
[35] [36] (./DoconceDescription.ind [37] [38] [39]) (./DoconceDescription.aux)

LaTeX Warning: There were undefined references.

 )
(see the transcript file for additional information)pdfTeX warning (dest): name
{??} has been referenced but does not exist, replaced by a fixed one

{/usr/share/texmf-texlive/fonts/enc/dvips/base/8r.enc}</usr/share/texmf-texlive
/fonts/type1/public/amsfonts/cm/cmbx10.pfb></usr/share/texmf-texlive/fonts/type
1/public/amsfonts/cm/cmmi10.pfb></usr/share/texmf-texlive/fonts/type1/public/am
sfonts/cm/cmmib10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/
cmr10.pfb></usr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmr7.pfb></u
sr/share/texmf-texlive/fonts/type1/public/amsfonts/cm/cmsy10.pfb></usr/share/te
xmf-texlive/fonts/type1/urw/courier/ucrb8a.pfb></usr/share/texmf-texlive/fonts/
type1/urw/courier/ucrr8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/courier/
ucrro8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/helvetic/uhvb8a.pfb></usr
/share/texmf-texlive/fonts/type1/urw/helvetic/uhvbo8a.pfb></usr/share/texmf-tex
live/fonts/type1/urw/helvetic/uhvr8a.pfb></usr/share/texmf-texlive/fonts/type1/
urw/times/utmb8a.pfb></usr/share/texmf-texlive/fonts/type1/urw/times/utmbi8a.pf
b></usr/share/texmf-texlive/fonts/type1/urw/times/utmr8a.pfb></usr/share/texmf-
texlive/fonts/type1/urw/times/utmri8a.pfb>
Output written on DoconceDescription.pdf (43 pages, 372800 bytes).
Transcript written on DoconceDescription.log.
+ cp DoconceDescription.pdf ../../../manual.sphinx.pdf
+ cd ../../..
+ doconce format rst manual.do.txt
run preprocess -DFORMAT=rst  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.rst
+ rst2html.py manual.rst
+ rst2xml.py manual.rst
+ rst2latex.py manual.rst
+ doconce subst \.png  manual.rst.tex
\.png replaced by  in manual.rst.tex
+ latex manual.rst.tex
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./manual.rst.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/base/fixltx2e.sty)
(/usr/share/texmf-texlive/tex/latex/cmap/cmap.sty

Package cmap Warning: pdftex in DVI mode - exiting.

) (/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/float/float.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def)))
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty)
(/usr/share/texmf-texlive/tex/latex/caption/ltcaption.sty)
(/usr/share/texmf-texlive/tex/latex/tools/array.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/mathptmx.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/helvet.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/courier.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
No file manual.rst.aux.
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))

Package hyperref Warning: Rerun to get /PageLabels entry.


Overfull \hbox (1.15796pt too wide) in paragraph at lines 100--106
\T1/ptm/m/n/10 etc.). The Do-conce markup lan-guage sup-port this work-ing stra
t-
(/usr/share/texmf-texlive/tex/latex/psnfss/omsptm.fd) [1]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [2]
Overfull \hbox (179.00006pt too wide) in paragraph at lines 274--275
\T1/pcr/m/n/10 Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5  
   # preprocess  

Overfull \hbox (143.00006pt too wide) in paragraph at lines 276--278
[]\T1/pcr/m/n/10 Terminal> doconce format LaTeX yourdoc extra_sections=True VAR
1=5  # mako 

Overfull \hbox (30.7872pt too wide) in paragraph at lines 280--284
[]\T1/ptm/m/n/10 The vari-able \T1/pcr/m/n/10 FORMAT \T1/ptm/m/n/10 is al-ways 
de-fined as the cur-rent for-mat when run-ning \T1/pcr/m/n/10 preprocess\T1/ptm
/m/n/10 .

Overfull \hbox (59.00006pt too wide) in paragraph at lines 287--290
[]\T1/pcr/m/n/10 Terminal> doconce format LaTeX mydoc remove_inline_comments 

Overfull \hbox (11.278pt too wide) in paragraph at lines 340--343
[]\T1/pcr/m/n/10 ptex2tex\T1/ptm/m/n/10 : 

LaTeX Warning: Hyper reference `macros-newcommands' on page 3 undefined on inpu
t line 352.


Overfull \hbox (78.51936pt too wide) in paragraph at lines 350--355
\T1/ptm/m/n/10 placed in files \T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \
T1/pcr/m/n/10 newcommands_keep.tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommand
s_replace.tex
[3]
Overfull \hbox (107.00006pt too wide) in paragraph at lines 451--454
[]\T1/pcr/m/n/10 Terminal> doconce format plain mydoc.do.txt  # results in mydo
c.txt 
[4]
Overfull \hbox (17.00006pt too wide) in paragraph at lines 476--477
\T1/pcr/m/n/10 Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML  

Overfull \hbox (23.00006pt too wide) in paragraph at lines 478--478
[]\T1/pcr/m/n/10 Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX  

Overfull \hbox (11.00006pt too wide) in paragraph at lines 479--479
[]\T1/pcr/m/n/10 Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML  

Overfull \hbox (53.00006pt too wide) in paragraph at lines 480--482
[]\T1/pcr/m/n/10 Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice 
[5]
Overfull \hbox (31.15843pt too wide) in paragraph at lines 624--628
[]\T1/ptm/m/n/10 You can then open a new wiki page for your Google Code project
, copy the \T1/pcr/m/n/10 mydoc.gwiki

Overfull \hbox (1.98695pt too wide) in paragraph at lines 643--654
\T1/ptm/m/n/10 One ex-am-ple is fig-ure file-names when trans-form-ing Do-conce
 to re-Struc-tured-Text. Since
[6] [7]
Overfull \hbox (1.65791pt too wide) in paragraph at lines 788--792
[]\T1/ptm/m/n/10 explanation of key-word2 (re-mem-ber to in-dent prop-erly if t
here

Overfull \hbox (29.00006pt too wide) in paragraph at lines 817--820
[]\T1/pcr/m/n/10 name at institution1 and institution2 and institution3 

Overfull \hbox (467.00006pt too wide) in paragraph at lines 832--832
[]\T1/pcr/m/n/10 AUTHOR: H. P. Langtangen at Center for Biomedical Computing, S
imula Research Laboratory and Dept. of Informatics, Univ. of Oslo  
[8]
Overfull \hbox (83.00006pt too wide) in paragraph at lines 850--850
[]\T1/pcr/m/n/10 [1] Center for Biomedical Computing, Simula Research Laborator
y  

Overfull \hbox (5.00006pt too wide) in paragraph at lines 892--892
[]          \T1/pcr/m/n/10 ===Example on a Subsubsection Heading===  
[9]
Overfull \hbox (101.00006pt too wide) in paragraph at lines 957--960
[]\T1/pcr/m/n/10 FIGURE:[filename, height=xxx width=yyy scale=zzz] possible cap
tion 
<figs/streamtubes.eps> [10]
Overfull \hbox (41.00006pt too wide) in paragraph at lines 998--1001
[]\T1/pcr/m/n/10 MOVIE: [filename, height=xxx width=yyy] possible caption 

Overfull \hbox (53.00006pt too wide) in paragraph at lines 1026--1029
[]\T1/pcr/m/n/10 Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc 

Overfull \hbox (18.18745pt too wide) in paragraph at lines 1031--1035
[]\T1/ptm/m/n/10 The HTML, reST, and Sphinx for-mats can also treat file-names 
of the form \T1/pcr/m/n/10 myframes*\T1/ptm/m/n/10 .
[11]
Overfull \hbox (2.6077pt too wide) in paragraph at lines 1036--1042
[]\T1/ptm/m/n/10 Many pub-lish their sci-en-tific movies on YouTube, and Do-con
ce rec-og-nizes YouTube

LaTeX Warning: Hyper reference `blocks-of-verbatim-computer-code' on page 12 un
defined on input line 1054.


Overfull \hbox (69.25586pt too wide) in paragraph at lines 1052--1055
\T1/ptm/m/n/10 code from a file di-rectly into a ver-ba-tim en-vi-ron-ment, see
 the sec-tion [][][][][][]

Overfull \hbox (47.00006pt too wide) in paragraph at lines 1080--1083
[]\T1/pcr/m/n/10 _several words in boldface_ followed by *ephasized text*. 

Overfull \hbox (17.00006pt too wide) in paragraph at lines 1093--1095
[]\T1/pcr/m/n/10 while `void myfunc(double *a, double *b)` must be C. 

Overfull \hbox (35.00006pt too wide) in paragraph at lines 1114--1117
[]\T1/pcr/m/n/10 some URL like "MyPlace": "http://my.place.in.space/src" 
[12] (/usr/share/texmf-texlive/tex/latex/psnfss/ot1ztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omlztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omsztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omxztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/ot1ptm.fd)

LaTeX Warning: Hyper reference `from-doconce-to-other-formats' on page 13 undef
ined on input line 1154.


LaTeX Warning: Hyper reference `from-doconce-to-other-formats' on page 13 undef
ined on input line 1160.


Overfull \hbox (23.00006pt too wide) in paragraph at lines 1174--1174
[]\T1/pcr/m/n/10 where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and  

Overfull \hbox (53.00006pt too wide) in paragraph at lines 1175--1177
[]\T1/pcr/m/n/10 $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$. 

Overfull \hbox (83.00006pt too wide) in paragraph at lines 1200--1202
[]\T1/pcr/m/n/10 For more information we refer to Section ref{section:verbatim}
. 
[13]

LaTeX Warning: Hyper reference `fig-viz' on page 14 undefined on input line 121
8.


LaTeX Warning: Hyper reference `latex-blocks-of-mathematical-text' on page 14 u
ndefined on input line 1220.


LaTeX Warning: Hyper reference `macros-newcommands' on page 14 undefined on inp
ut line 1220.


Overfull \hbox (21.44621pt too wide) in paragraph at lines 1216--1225
\T1/ptm/m/n/10 ref-er-ences to the sec-tions [][][][][][] and [][][][][][]

LaTeX Warning: Hyper reference `id4' on page 14 undefined on input line 1227.


Overfull \hbox (27.01674pt too wide) in paragraph at lines 1226--1228
[]\T1/ptm/m/n/10 Hyperlinks to files or web ad-dresses are han-dled as ex-plain
ed in the sec-tion [][][][][][]. 

Overfull \hbox (107.00006pt too wide) in paragraph at lines 1251--1254
[]\T1/pcr/m/n/10 \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and m
ore}} 

Overfull \hbox (30.86786pt too wide) in paragraph at lines 1283--1286
[]\T1/ptm/m/n/10 if \T1/pcr/m/n/10 Larsen:86 \T1/ptm/m/n/10 has al-ready ap-pea
red in the 3rd ci-ta-tion in the doc-u-ment and \T1/pcr/m/n/10 Nielsen:99
[14]
Overfull \hbox (11.00006pt too wide) in paragraph at lines 1299--1299
[]\T1/pcr/m/n/10 URL:"http://some.where.net/nielsen/comments", 1999.  

Overfull \hbox (24.53633pt too wide) in paragraph at lines 1324--1327
[][][][][][]\T1/ptm/m/n/10 , a pa-per [][][][][][], and both of them si-mul-ta-
ne-ously [][][][][][]
[15]
Overfull \hbox (89.00006pt too wide) in paragraph at lines 1447--1450
[]\T1/pcr/m/n/10 # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=conso
le 
[16]
Overfull \hbox (23.00006pt too wide) in paragraph at lines 1520--1522
[]\T1/pcr/m/n/10 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1 
[17]
Overfull \hbox (77.00006pt too wide) in paragraph at lines 1600--1600
[]\T1/pcr/m/n/10 {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
  

Overfull \hbox (71.00006pt too wide) in paragraph at lines 1601--1601
[]\T1/pcr/m/n/10 {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g 
 

Overfull \hbox (24.36848pt too wide) in paragraph at lines 1645--1648
[]\T1/ptm/m/it/10 Example. \T1/ptm/m/n/10 Sup-pose we have the fol-low-ing com-
mands in \T1/pcr/m/n/10 newcommand_replace.tex\T1/ptm/m/n/10 : 
[18]
Overfull \hbox (107.00006pt too wide) in paragraph at lines 1682--1682
[]\T1/pcr/m/n/10 \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my
:eq2}  

Overfull \hbox (16.79616pt too wide) in paragraph at lines 1698--1710
\T1/ptm/m/n/10 pro-cess ([][][][][][]) and mako ([][][][][][]).
<figs/wavepacket_0001.eps> <figs/wavepacket_0010.eps> [19] [20]

LaTeX Warning: Hyper reference `from-doconce-to-other-formats' on page 21 undef
ined on input line 1740.

[21]

LaTeX Warning: Hyper reference `blocks-of-verbatim-computer-code' on page 22 un
defined on input line 1825.


Overfull \hbox (77.5059pt too wide) in paragraph at lines 1825--1831
[]\T1/ptm/m/it/10 Verbatim Code Blocks In-side Lists Look Ugly. \T1/ptm/m/n/10 
Read the the sec-tion [][][][][][]
[22]
Overfull \hbox (71.00006pt too wide) in paragraph at lines 1860--1863
[]\T1/pcr/m/n/10 Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile 


Overfull \hbox (143.00006pt too wide) in paragraph at lines 1919--1922
[]\T1/pcr/m/n/10 (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<
text>.*)\s? 
[23]
Overfull \hbox (71.00006pt too wide) in paragraph at lines 1960--1961
\T1/pcr/m/n/10 FILENAME_EXTENSION['HTML'] = '.html'  # output file extension  

Overfull \hbox (143.00006pt too wide) in paragraph at lines 1962--1962
[]\T1/pcr/m/n/10 BLANKLINE['HTML'] = '<p>\n'           # blank input line => ne
w paragraph  

Overfull \hbox (119.00006pt too wide) in paragraph at lines 1963--1963
[]\T1/pcr/m/n/10 INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HT
ML tags  

Overfull \hbox (59.00006pt too wide) in paragraph at lines 1966--1966
[]    \T1/pcr/m/n/10 'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',  

Overfull \hbox (47.00006pt too wide) in paragraph at lines 1967--1967
[]    \T1/pcr/m/n/10 'bold':          r'\g<begin><b>\g<subst></b>\g<end>',  

Overfull \hbox (59.00006pt too wide) in paragraph at lines 1968--1968
[]    \T1/pcr/m/n/10 'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',  

Overfull \hbox (89.00006pt too wide) in paragraph at lines 1969--1969
[]    \T1/pcr/m/n/10 'URL':           r'\g<begin><a href="\g<url>">\g<link></a>
',  

Overfull \hbox (221.00006pt too wide) in paragraph at lines 1974--1974
[]    \T1/pcr/m/n/10 'title':         r'<title>\g<subst></title>\n<center><h1>\
g<subst></h1></center>',  

Overfull \hbox (65.00006pt too wide) in paragraph at lines 1975--1975
[]    \T1/pcr/m/n/10 'date':          r'<center><h3>\g<subst></h3></center>',  


Overfull \hbox (65.00006pt too wide) in paragraph at lines 1976--1976
[]    \T1/pcr/m/n/10 'author':        r'<center><h3>\g<subst></h3></center>',  


Overfull \hbox (107.00006pt too wide) in paragraph at lines 1979--1979
[]\T1/pcr/m/n/10 # how to replace code and LaTeX blocks by HTML (<pre>) environ
ment:  

Overfull \hbox (161.00006pt too wide) in paragraph at lines 1982--1982
[]    \T1/pcr/m/n/10 filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre
>\n', filestr)  

Overfull \hbox (137.00006pt too wide) in paragraph at lines 1984--1984
[]                     \T1/pcr/m/n/10 r'</pre>\n<! -- END VERBATIM BLOCK -->\n'
, filestr)  

Overfull \hbox (17.00006pt too wide) in paragraph at lines 1987--1987
[]    \T1/pcr/m/n/10 filestr = re.sub(r'!et\n', r'</pre>\n', filestr)  

Overfull \hbox (77.00006pt too wide) in paragraph at lines 1994--1994
[]    \T1/pcr/m/n/10 {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
  

Overfull \hbox (77.00006pt too wide) in paragraph at lines 1996--1996
[]    \T1/pcr/m/n/10 {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
  

Overfull \hbox (113.00006pt too wide) in paragraph at lines 1998--1998
[]    \T1/pcr/m/n/10 {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\
n\n'},  
[24]
Overfull \hbox (101.00006pt too wide) in paragraph at lines 2001--2001
[]\T1/pcr/m/n/10 # how to type set description lists for function arguments, re
turn  

Overfull \hbox (17.00006pt too wide) in paragraph at lines 2007--2007
[]    \T1/pcr/m/n/10 'instance variable': '<b>instance variable</b>',  

Overfull \hbox (65.00006pt too wide) in paragraph at lines 2048--2048
[]\T1/pcr/m/n/10 - keyword argument tolerance: tolerance (float) for stopping  


Overfull \hbox (119.00006pt too wide) in paragraph at lines 2050--2050
[]\T1/pcr/m/n/10 - return: the root of the equation (float), if found, otherwis
e None.  

Overfull \hbox (11.00006pt too wide) in paragraph at lines 2051--2051
[]\T1/pcr/m/n/10 - instance variable eta: surface elevation (array).  

Overfull \hbox (101.00006pt too wide) in paragraph at lines 2052--2052
[]\T1/pcr/m/n/10 - class variable items: the total number of MyClass objects (i
nt).  

Overfull \hbox (113.00006pt too wide) in paragraph at lines 2053--2053
[]\T1/pcr/m/n/10 - module variable debug: True: debug mode is on; False: no deb
ugging  
[25] [26] (./manual.rst.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on manual.rst.dvi (26 pages, 108784 bytes).
Transcript written on manual.rst.log.
+ latex manual.rst.tex
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
entering extended mode
(./manual.rst.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/base/fixltx2e.sty)
(/usr/share/texmf-texlive/tex/latex/cmap/cmap.sty

Package cmap Warning: pdftex in DVI mode - exiting.

) (/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/base/fontenc.sty
(/usr/share/texmf-texlive/tex/latex/base/t1enc.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/utf8.def
(/usr/share/texmf-texlive/tex/latex/base/t1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/ot1enc.dfu)
(/usr/share/texmf-texlive/tex/latex/base/omsenc.dfu)))
(/usr/share/texmf-texlive/tex/latex/float/float.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def)))
(/usr/share/texmf-texlive/tex/latex/tools/longtable.sty)
(/usr/share/texmf-texlive/tex/latex/caption/ltcaption.sty)
(/usr/share/texmf-texlive/tex/latex/tools/array.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/mathptmx.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/helvet.sty)
(/usr/share/texmf-texlive/tex/latex/psnfss/courier.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def)) (./manual.rst.aux)
(/usr/share/texmf-texlive/tex/latex/psnfss/t1ptm.fd)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty)) (./manual.rst.out)
(./manual.rst.out)
Overfull \hbox (1.15796pt too wide) in paragraph at lines 100--106
\T1/ptm/m/n/10 etc.). The Do-conce markup lan-guage sup-port this work-ing stra
t-
(/usr/share/texmf-texlive/tex/latex/psnfss/omsptm.fd) [1]
(/usr/share/texmf-texlive/tex/latex/psnfss/t1pcr.fd) [2]
Overfull \hbox (179.00006pt too wide) in paragraph at lines 274--275
\T1/pcr/m/n/10 Terminal> doconce format LaTeX mydoc -Dextra_sections -DVAR1=5  
   # preprocess  

Overfull \hbox (143.00006pt too wide) in paragraph at lines 276--278
[]\T1/pcr/m/n/10 Terminal> doconce format LaTeX yourdoc extra_sections=True VAR
1=5  # mako 

Overfull \hbox (30.7872pt too wide) in paragraph at lines 280--284
[]\T1/ptm/m/n/10 The vari-able \T1/pcr/m/n/10 FORMAT \T1/ptm/m/n/10 is al-ways 
de-fined as the cur-rent for-mat when run-ning \T1/pcr/m/n/10 preprocess\T1/ptm
/m/n/10 .

Overfull \hbox (59.00006pt too wide) in paragraph at lines 287--290
[]\T1/pcr/m/n/10 Terminal> doconce format LaTeX mydoc remove_inline_comments 

Overfull \hbox (11.278pt too wide) in paragraph at lines 340--343
[]\T1/pcr/m/n/10 ptex2tex\T1/ptm/m/n/10 : 

Overfull \hbox (78.51936pt too wide) in paragraph at lines 350--355
\T1/ptm/m/n/10 placed in files \T1/pcr/m/n/10 newcommands.tex\T1/ptm/m/n/10 , \
T1/pcr/m/n/10 newcommands_keep.tex\T1/ptm/m/n/10 , or \T1/pcr/m/n/10 newcommand
s_replace.tex
[3]
Overfull \hbox (107.00006pt too wide) in paragraph at lines 451--454
[]\T1/pcr/m/n/10 Terminal> doconce format plain mydoc.do.txt  # results in mydo
c.txt 
[4]
Overfull \hbox (17.00006pt too wide) in paragraph at lines 476--477
\T1/pcr/m/n/10 Terminal> rst2html.py  mydoc.rst > mydoc.html # HTML  

Overfull \hbox (23.00006pt too wide) in paragraph at lines 478--478
[]\T1/pcr/m/n/10 Terminal> rst2latex.py mydoc.rst > mydoc.tex  # LaTeX  

Overfull \hbox (11.00006pt too wide) in paragraph at lines 479--479
[]\T1/pcr/m/n/10 Terminal> rst2xml.py   mydoc.rst > mydoc.xml  # XML  

Overfull \hbox (53.00006pt too wide) in paragraph at lines 480--482
[]\T1/pcr/m/n/10 Terminal> rst2odt.py   mydoc.rst > mydoc.odt  # OpenOffice 
[5]
Overfull \hbox (31.15843pt too wide) in paragraph at lines 624--628
[]\T1/ptm/m/n/10 You can then open a new wiki page for your Google Code project
, copy the \T1/pcr/m/n/10 mydoc.gwiki

Overfull \hbox (1.98695pt too wide) in paragraph at lines 643--654
\T1/ptm/m/n/10 One ex-am-ple is fig-ure file-names when trans-form-ing Do-conce
 to re-Struc-tured-Text. Since
[6] [7]
Overfull \hbox (1.65791pt too wide) in paragraph at lines 788--792
[]\T1/ptm/m/n/10 explanation of key-word2 (re-mem-ber to in-dent prop-erly if t
here

Overfull \hbox (29.00006pt too wide) in paragraph at lines 817--820
[]\T1/pcr/m/n/10 name at institution1 and institution2 and institution3 

Overfull \hbox (467.00006pt too wide) in paragraph at lines 832--832
[]\T1/pcr/m/n/10 AUTHOR: H. P. Langtangen at Center for Biomedical Computing, S
imula Research Laboratory and Dept. of Informatics, Univ. of Oslo  
[8]
Overfull \hbox (83.00006pt too wide) in paragraph at lines 850--850
[]\T1/pcr/m/n/10 [1] Center for Biomedical Computing, Simula Research Laborator
y  

Overfull \hbox (5.00006pt too wide) in paragraph at lines 892--892
[]          \T1/pcr/m/n/10 ===Example on a Subsubsection Heading===  
[9]
Overfull \hbox (101.00006pt too wide) in paragraph at lines 957--960
[]\T1/pcr/m/n/10 FIGURE:[filename, height=xxx width=yyy scale=zzz] possible cap
tion 
<figs/streamtubes.eps> [10]
Overfull \hbox (41.00006pt too wide) in paragraph at lines 998--1001
[]\T1/pcr/m/n/10 MOVIE: [filename, height=xxx width=yyy] possible caption 

Overfull \hbox (53.00006pt too wide) in paragraph at lines 1026--1029
[]\T1/pcr/m/n/10 Terminal> ptex2tex -DMOVIE15 -DEXTERNAL_MOVIE_VIEWER mydoc 

Overfull \hbox (18.18745pt too wide) in paragraph at lines 1031--1035
[]\T1/ptm/m/n/10 The HTML, reST, and Sphinx for-mats can also treat file-names 
of the form \T1/pcr/m/n/10 myframes*\T1/ptm/m/n/10 .
[11]
Overfull \hbox (2.6077pt too wide) in paragraph at lines 1036--1042
[]\T1/ptm/m/n/10 Many pub-lish their sci-en-tific movies on YouTube, and Do-con
ce rec-og-nizes YouTube

Overfull \hbox (69.25586pt too wide) in paragraph at lines 1052--1055
\T1/ptm/m/n/10 code from a file di-rectly into a ver-ba-tim en-vi-ron-ment, see
 the sec-tion [][][][][][]

Overfull \hbox (47.00006pt too wide) in paragraph at lines 1080--1083
[]\T1/pcr/m/n/10 _several words in boldface_ followed by *ephasized text*. 

Overfull \hbox (17.00006pt too wide) in paragraph at lines 1093--1095
[]\T1/pcr/m/n/10 while `void myfunc(double *a, double *b)` must be C. 

Overfull \hbox (35.00006pt too wide) in paragraph at lines 1114--1117
[]\T1/pcr/m/n/10 some URL like "MyPlace": "http://my.place.in.space/src" 
[12] (/usr/share/texmf-texlive/tex/latex/psnfss/ot1ztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omlztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omsztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/omxztmcm.fd)
(/usr/share/texmf-texlive/tex/latex/psnfss/ot1ptm.fd)
Overfull \hbox (23.00006pt too wide) in paragraph at lines 1174--1174
[]\T1/pcr/m/n/10 where $\bf A$|$A$ is an $n\times n$|$nxn$ matrix, and  

Overfull \hbox (53.00006pt too wide) in paragraph at lines 1175--1177
[]\T1/pcr/m/n/10 $\bf x$|$x$ and $\bf b$|$b$ are vectors of length $n$|$n$. 

Overfull \hbox (83.00006pt too wide) in paragraph at lines 1200--1202
[]\T1/pcr/m/n/10 For more information we refer to Section ref{section:verbatim}
. 
[13]
Overfull \hbox (21.44621pt too wide) in paragraph at lines 1216--1225
\T1/ptm/m/n/10 ref-er-ences to the sec-tions [][][][][][] and [][][][][][]

Overfull \hbox (27.01674pt too wide) in paragraph at lines 1226--1228
[]\T1/ptm/m/n/10 Hyperlinks to files or web ad-dresses are han-dled as ex-plain
ed in the sec-tion [][][][][][]. 

Overfull \hbox (107.00006pt too wide) in paragraph at lines 1251--1254
[]\T1/pcr/m/n/10 \index{verbatim\_text@\texttt{\rm\smaller verbatim\_text and m
ore}} 

Overfull \hbox (30.86786pt too wide) in paragraph at lines 1283--1286
[]\T1/ptm/m/n/10 if \T1/pcr/m/n/10 Larsen:86 \T1/ptm/m/n/10 has al-ready ap-pea
red in the 3rd ci-ta-tion in the doc-u-ment and \T1/pcr/m/n/10 Nielsen:99
[14]
Overfull \hbox (11.00006pt too wide) in paragraph at lines 1299--1299
[]\T1/pcr/m/n/10 URL:"http://some.where.net/nielsen/comments", 1999.  

Overfull \hbox (24.53633pt too wide) in paragraph at lines 1324--1327
[][][][][][]\T1/ptm/m/n/10 , a pa-per [][][][][][], and both of them si-mul-ta-
ne-ously [][][][][][]
[15]
Overfull \hbox (89.00006pt too wide) in paragraph at lines 1447--1450
[]\T1/pcr/m/n/10 # sphinx code-blocks: pycod=python cod=py cppcod=c++ sys=conso
le 
[16]
Overfull \hbox (23.00006pt too wide) in paragraph at lines 1520--1522
[]\T1/pcr/m/n/10 @@@CODE myfile.f fromto:subroutine\s+test@^C\s{5}END1 
[17]
Overfull \hbox (77.00006pt too wide) in paragraph at lines 1600--1600
[]\T1/pcr/m/n/10 {\partial u\over\partial t} &=& \nabla^2 u + f,\label{myeq1}\\
  

Overfull \hbox (71.00006pt too wide) in paragraph at lines 1601--1601
[]\T1/pcr/m/n/10 {\partial v\over\partial t} &=& \nabla\cdot(q(u)\nabla v) + g 
 

Overfull \hbox (24.36848pt too wide) in paragraph at lines 1645--1648
[]\T1/ptm/m/it/10 Example. \T1/ptm/m/n/10 Sup-pose we have the fol-low-ing com-
mands in \T1/pcr/m/n/10 newcommand_replace.tex\T1/ptm/m/n/10 : 
[18]
Overfull \hbox (107.00006pt too wide) in paragraph at lines 1682--1682
[]\T1/pcr/m/n/10 \Ddt{\vec u} &=& {\mbox{\boldmath $Q$}} \thinspace . \label{my
:eq2}  

Overfull \hbox (16.79616pt too wide) in paragraph at lines 1698--1710
\T1/ptm/m/n/10 pro-cess ([][][][][][]) and mako ([][][][][][]).
<figs/wavepacket_0001.eps> <figs/wavepacket_0010.eps> [19] [20] [21]
Overfull \hbox (77.5059pt too wide) in paragraph at lines 1825--1831
[]\T1/ptm/m/it/10 Verbatim Code Blocks In-side Lists Look Ugly. \T1/ptm/m/n/10 
Read the the sec-tion [][][][][][]
[22]
Overfull \hbox (71.00006pt too wide) in paragraph at lines 1860--1863
[]\T1/pcr/m/n/10 Unix> iconv -f utf-8 -t LATIN1 myfile.do.txt --output newfile 


Overfull \hbox (143.00006pt too wide) in paragraph at lines 1919--1922
[]\T1/pcr/m/n/10 (?P<indent> *(?P<listtype>[*o-] )? *)(?P<keyword>[^:]+?:)?(?P<
text>.*)\s? 
[23]
Overfull \hbox (71.00006pt too wide) in paragraph at lines 1960--1961
\T1/pcr/m/n/10 FILENAME_EXTENSION['HTML'] = '.html'  # output file extension  

Overfull \hbox (143.00006pt too wide) in paragraph at lines 1962--1962
[]\T1/pcr/m/n/10 BLANKLINE['HTML'] = '<p>\n'           # blank input line => ne
w paragraph  

Overfull \hbox (119.00006pt too wide) in paragraph at lines 1963--1963
[]\T1/pcr/m/n/10 INLINE_TAGS_SUBST['HTML'] = {         # from inline tags to HT
ML tags  

Overfull \hbox (59.00006pt too wide) in paragraph at lines 1966--1966
[]    \T1/pcr/m/n/10 'emphasize':     r'\g<begin><em>\g<subst></em>\g<end>',  

Overfull \hbox (47.00006pt too wide) in paragraph at lines 1967--1967
[]    \T1/pcr/m/n/10 'bold':          r'\g<begin><b>\g<subst></b>\g<end>',  

Overfull \hbox (59.00006pt too wide) in paragraph at lines 1968--1968
[]    \T1/pcr/m/n/10 'verbatim':      r'\g<begin><tt>\g<subst></tt>\g<end>',  

Overfull \hbox (89.00006pt too wide) in paragraph at lines 1969--1969
[]    \T1/pcr/m/n/10 'URL':           r'\g<begin><a href="\g<url>">\g<link></a>
',  

Overfull \hbox (221.00006pt too wide) in paragraph at lines 1974--1974
[]    \T1/pcr/m/n/10 'title':         r'<title>\g<subst></title>\n<center><h1>\
g<subst></h1></center>',  

Overfull \hbox (65.00006pt too wide) in paragraph at lines 1975--1975
[]    \T1/pcr/m/n/10 'date':          r'<center><h3>\g<subst></h3></center>',  


Overfull \hbox (65.00006pt too wide) in paragraph at lines 1976--1976
[]    \T1/pcr/m/n/10 'author':        r'<center><h3>\g<subst></h3></center>',  


Overfull \hbox (107.00006pt too wide) in paragraph at lines 1979--1979
[]\T1/pcr/m/n/10 # how to replace code and LaTeX blocks by HTML (<pre>) environ
ment:  

Overfull \hbox (161.00006pt too wide) in paragraph at lines 1982--1982
[]    \T1/pcr/m/n/10 filestr = c.sub(r'<!-- BEGIN VERBATIM BLOCK \g<1>-->\n<pre
>\n', filestr)  

Overfull \hbox (137.00006pt too wide) in paragraph at lines 1984--1984
[]                     \T1/pcr/m/n/10 r'</pre>\n<! -- END VERBATIM BLOCK -->\n'
, filestr)  

Overfull \hbox (17.00006pt too wide) in paragraph at lines 1987--1987
[]    \T1/pcr/m/n/10 filestr = re.sub(r'!et\n', r'</pre>\n', filestr)  

Overfull \hbox (77.00006pt too wide) in paragraph at lines 1994--1994
[]    \T1/pcr/m/n/10 {'begin': '\n<ul>\n', 'item': '<li>', 'end': '</ul>\n\n'},
  

Overfull \hbox (77.00006pt too wide) in paragraph at lines 1996--1996
[]    \T1/pcr/m/n/10 {'begin': '\n<ol>\n', 'item': '<li>', 'end': '</ol>\n\n'},
  

Overfull \hbox (113.00006pt too wide) in paragraph at lines 1998--1998
[]    \T1/pcr/m/n/10 {'begin': '\n<dl>\n', 'item': '<dt>%s<dd>', 'end': '</dl>\
n\n'},  
[24]
Overfull \hbox (101.00006pt too wide) in paragraph at lines 2001--2001
[]\T1/pcr/m/n/10 # how to type set description lists for function arguments, re
turn  

Overfull \hbox (17.00006pt too wide) in paragraph at lines 2007--2007
[]    \T1/pcr/m/n/10 'instance variable': '<b>instance variable</b>',  

Overfull \hbox (65.00006pt too wide) in paragraph at lines 2048--2048
[]\T1/pcr/m/n/10 - keyword argument tolerance: tolerance (float) for stopping  


Overfull \hbox (119.00006pt too wide) in paragraph at lines 2050--2050
[]\T1/pcr/m/n/10 - return: the root of the equation (float), if found, otherwis
e None.  

Overfull \hbox (11.00006pt too wide) in paragraph at lines 2051--2051
[]\T1/pcr/m/n/10 - instance variable eta: surface elevation (array).  

Overfull \hbox (101.00006pt too wide) in paragraph at lines 2052--2052
[]\T1/pcr/m/n/10 - class variable items: the total number of MyClass objects (i
nt).  

Overfull \hbox (113.00006pt too wide) in paragraph at lines 2053--2053
[]\T1/pcr/m/n/10 - module variable debug: True: debug mode is on; False: no deb
ugging  
[25] [26] (./manual.rst.aux) )
(see the transcript file for additional information)
Output written on manual.rst.dvi (26 pages, 112296 bytes).
Transcript written on manual.rst.log.
+ dvipdf manual.rst.dvi
+ doconce format plain manual.do.txt remove_inline_comments
run preprocess -DFORMAT=plain  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.txt
+ doconce format epytext manual.do.txt
run preprocess -DFORMAT=epytext  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.epytext
+ doconce format st manual.do.txt
run preprocess -DFORMAT=st  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.st
+ doconce format LaTeX manual.do.txt
run preprocess -DFORMAT=LaTeX  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt
output in manual.p.tex
+ doconce replace usepackage{ptex2tex usepackage{ptex2tex,subfigure manual.p.tex
replacing usepackage{ptex2tex by usepackage{ptex2tex,subfigure in manual.p.tex
+ ptex2tex -DMINTED manual
running preprocessor on manual.p.tex...  defines: 'MINTED'  done
done manual.p.tex -> manual.tex
+ rm -f manual.p.tex
+ latex -shell-escape manual
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
 \write18 enabled.
entering extended mode
(./manual.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/relsize.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def))))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/latin1.def))
(/home/hpl/texmf/tex/latex/misc/ptex2tex.sty
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz)) (/usr/share/texmf-texlive/tex/latex/moreverb/moreverb.sty
(/usr/share/texmf-texlive/tex/latex/tools/verbatim.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/home/hpl/texmf/tex/latex/misc/listings2.sty
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty)
(/usr/share/texmf-texlive/tex/latex/listings/listings.cfg))
(/home/hpl/texmf/tex/latex/misc/codehighlight.sty
(/usr/share/texmf/tex/latex/xcolor/xcolor.sty
(/etc/texmf/tex/latex/config/color.cfg)))
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty))
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.sty
****************************************
* Local config file subfigure.cfg used *
****************************************
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.cfg))
(/home/hpl/texmf/tex/latex/misc/minted.sty
(/usr/share/texmf-texlive/tex/latex/float/float.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/tools/calc.sty)
(/usr/share/texmf-texlive/tex/latex/ifplatform/ifplatform.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/catchfile.sty) (./manual.w18))/usr/bin/pygmentize
)
Writing index file manual.idx
No file manual.aux.
(/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty))

Package hyperref Warning: Rerun to get /PageLabels entry.

(./manual.pyg) (./newcommands_replace.tex) (./newcommands_keep.tex)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf-texlive/tex/latex/base/omscmr.fd) [1]
Overfull \hbox (5.27824pt too wide) in paragraph at lines 147--159
\OT1/cmr/m/n/10 If you make use of pre-pro-ces-sor di-rec-tives in the Do-conce
 source, ei-ther [][][][][][]
[2] [3]
Overfull \hbox (3.29488pt too wide) in paragraph at lines 270--274
 \OT1/cmr/bx/n/10 Step 1.[] \OT1/cmr/m/n/10 Fil-ter the do-conce text to a pre-
L[]T[]X form []\OT1/cmtt/m/n/10 mydoc.p.tex \OT1/cmr/m/n/10 for []\OT1/cmtt/m/n
/10 ptex2tex\OT1/cmr/m/n/10 :

LaTeX Warning: Reference `newcommands' on page 4 undefined on input line 279.


Overfull \hbox (53.0808pt too wide) in paragraph at lines 277--282
\OT1/cmr/m/n/10 be placed in files []\OT1/cmtt/m/n/10 newcommands.tex\OT1/cmr/m
/n/10 , []\OT1/cmtt/m/n/10 newcommands_keep.tex\OT1/cmr/m/n/10 , or []\OT1/cmtt
/m/n/10 newcommands_replace.tex
[4] [5] [6] [7] [8] [9] [10] [11] <figs/streamtubes.eps> [12]

LaTeX Warning: Reference `sec:verbatim:blocks' on page 13 undefined on input li
ne 871.


Overfull \hbox (29.62364pt too wide) in paragraph at lines 879--882
\OT1/cmr/m/n/10 Doconce sup-ports tags for \OT1/cmr/m/it/10 em-pha-sized phrase
s\OT1/cmr/m/n/10 , \OT1/cmr/bx/n/10 bold-face phrases\OT1/cmr/m/n/10 , and []\O
T1/cmtt/m/n/10 verbatim text
[13]

LaTeX Warning: Reference `doconce2formats' on page 14 undefined on input line 9
62.


LaTeX Warning: Reference `doconce2formats' on page 14 undefined on input line 9
68.

[14]

LaTeX Warning: Reference `fig:viz' on page 15 undefined on input line 1019.


LaTeX Warning: Reference `mathtext' on page 15 undefined on input line 1021.


LaTeX Warning: Reference `newcommands' on page 15 undefined on input line 1021.



LaTeX Warning: Reference `my:eq1' on page 15 undefined on input line 1023.


LaTeX Warning: Reference `my:eq2' on page 15 undefined on input line 1023.

[15]

LaTeX Warning: Reference `inline:tagging' on page 16 undefined on input line 10
28.

[16]

LaTeX Warning: Citation `Python:Primer:09' on page 17 undefined on input line 1
115.


LaTeX Warning: Citation `Osnes:98' on page 17 undefined on input line 1115.


LaTeX Warning: Citation `Python:Primer:09' on page 17 undefined on input line 1
116.


LaTeX Warning: Citation `Osnes:98' on page 17 undefined on input line 1116.

[17] (./manual.out.pyg) (./manual.out.pyg [18]) [19]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1356.


Overfull \hbox (19.95741pt too wide) in paragraph at lines 1394--1396
 \OT1/cmr/bx/n/10 Ex-am-ple.[] \OT1/cmr/m/n/10 Sup-pose we have the fol-low-ing
 com-mands in []\OT1/cmtt/m/n/10 newcommand_replace.tex\OT1/cmr/m/n/10 : 
[20] <figs/wavepacket_0001.eps> <figs/wavepacket_0010.eps> [21]

LaTeX Warning: Reference `doconce2formats' on page 22 undefined on input line 1
487.

[22]

LaTeX Warning: Reference `sec:verbatim:blocks' on page 23 undefined on input li
ne 1560.

[23] [24] [25] [26]
No file manual.bbl.
No file manual.ind.
[27] (./manual.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on manual.dvi (27 pages, 113516 bytes).
Transcript written on manual.log.
+ latex -shell-escape manual
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
 \write18 enabled.
entering extended mode
(./manual.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/relsize.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def))))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/latin1.def))
(/home/hpl/texmf/tex/latex/misc/ptex2tex.sty
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz)) (/usr/share/texmf-texlive/tex/latex/moreverb/moreverb.sty
(/usr/share/texmf-texlive/tex/latex/tools/verbatim.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/home/hpl/texmf/tex/latex/misc/listings2.sty
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty)
(/usr/share/texmf-texlive/tex/latex/listings/listings.cfg))
(/home/hpl/texmf/tex/latex/misc/codehighlight.sty
(/usr/share/texmf/tex/latex/xcolor/xcolor.sty
(/etc/texmf/tex/latex/config/color.cfg)))
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty))
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.sty
****************************************
* Local config file subfigure.cfg used *
****************************************
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.cfg))
(/home/hpl/texmf/tex/latex/misc/minted.sty
(/usr/share/texmf-texlive/tex/latex/float/float.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/tools/calc.sty)
(/usr/share/texmf-texlive/tex/latex/ifplatform/ifplatform.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/catchfile.sty) (./manual.w18))/usr/bin/pygmentize
)
Writing index file manual.idx
(./manual.aux) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty)) (./manual.out)
(./manual.out) (./manual.pyg) (./newcommands_replace.tex)
(./newcommands_keep.tex) (/usr/share/texmf-texlive/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf-texlive/tex/latex/base/omscmr.fd) [1]
Overfull \hbox (5.27824pt too wide) in paragraph at lines 147--159
\OT1/cmr/m/n/10 If you make use of pre-pro-ces-sor di-rec-tives in the Do-conce
 source, ei-ther [][][][][][]
[2] [3]
Overfull \hbox (3.29488pt too wide) in paragraph at lines 270--274
 \OT1/cmr/bx/n/10 Step 1.[] \OT1/cmr/m/n/10 Fil-ter the do-conce text to a pre-
L[]T[]X form []\OT1/cmtt/m/n/10 mydoc.p.tex \OT1/cmr/m/n/10 for []\OT1/cmtt/m/n
/10 ptex2tex\OT1/cmr/m/n/10 :

Overfull \hbox (53.0808pt too wide) in paragraph at lines 277--282
\OT1/cmr/m/n/10 be placed in files []\OT1/cmtt/m/n/10 newcommands.tex\OT1/cmr/m
/n/10 , []\OT1/cmtt/m/n/10 newcommands_keep.tex\OT1/cmr/m/n/10 , or []\OT1/cmtt
/m/n/10 newcommands_replace.tex
[4] [5] [6] [7] [8] [9] [10] [11] <figs/streamtubes.eps> [12]
Overfull \hbox (29.62364pt too wide) in paragraph at lines 879--882
\OT1/cmr/m/n/10 Doconce sup-ports tags for \OT1/cmr/m/it/10 em-pha-sized phrase
s\OT1/cmr/m/n/10 , \OT1/cmr/bx/n/10 bold-face phrases\OT1/cmr/m/n/10 , and []\O
T1/cmtt/m/n/10 verbatim text
[13] [14] [15] [16]

LaTeX Warning: Citation `Python:Primer:09' on page 17 undefined on input line 1
115.


LaTeX Warning: Citation `Osnes:98' on page 17 undefined on input line 1115.


LaTeX Warning: Citation `Python:Primer:09' on page 17 undefined on input line 1
116.


LaTeX Warning: Citation `Osnes:98' on page 17 undefined on input line 1116.

[17] (./manual.out.pyg) (./manual.out.pyg [18]) [19]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1356.


Overfull \hbox (19.95741pt too wide) in paragraph at lines 1394--1396
 \OT1/cmr/bx/n/10 Ex-am-ple.[] \OT1/cmr/m/n/10 Sup-pose we have the fol-low-ing
 com-mands in []\OT1/cmtt/m/n/10 newcommand_replace.tex\OT1/cmr/m/n/10 : 
[20] <figs/wavepacket_0001.eps> <figs/wavepacket_0010.eps> [21] [22] [23]
[24] [25] [26]
No file manual.bbl.
No file manual.ind.
[27] (./manual.aux)

LaTeX Warning: There were undefined references.

 )
(see the transcript file for additional information)
Output written on manual.dvi (27 pages, 119828 bytes).
Transcript written on manual.log.
+ bibtex manual
This is BibTeX, Version 0.99c (TeX Live 2009/Debian)
The top-level auxiliary file: manual.aux
The style file: plain.bst
Database file #1: manual_bib.bib
+ makeindex manual
This is makeindex, version 2.15 [TeX Live 2009] (kpathsea + Thai support).
Scanning input file manual.idx....done (18 entries accepted, 0 rejected).
Sorting entries....done (91 comparisons).
Generating output file manual.ind....done (56 lines written, 0 warnings).
Output written in manual.ind.
Transcript written in manual.ilg.
+ latex -shell-escape manual
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
 \write18 enabled.
entering extended mode
(./manual.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/relsize.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def))))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/latin1.def))
(/home/hpl/texmf/tex/latex/misc/ptex2tex.sty
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz)) (/usr/share/texmf-texlive/tex/latex/moreverb/moreverb.sty
(/usr/share/texmf-texlive/tex/latex/tools/verbatim.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/home/hpl/texmf/tex/latex/misc/listings2.sty
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty)
(/usr/share/texmf-texlive/tex/latex/listings/listings.cfg))
(/home/hpl/texmf/tex/latex/misc/codehighlight.sty
(/usr/share/texmf/tex/latex/xcolor/xcolor.sty
(/etc/texmf/tex/latex/config/color.cfg)))
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty))
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.sty
****************************************
* Local config file subfigure.cfg used *
****************************************
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.cfg))
(/home/hpl/texmf/tex/latex/misc/minted.sty
(/usr/share/texmf-texlive/tex/latex/float/float.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/tools/calc.sty)
(/usr/share/texmf-texlive/tex/latex/ifplatform/ifplatform.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/catchfile.sty) (./manual.w18))/usr/bin/pygmentize
)
Writing index file manual.idx
(./manual.aux) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty)) (./manual.out)
(./manual.out) (./manual.pyg) (./newcommands_replace.tex)
(./newcommands_keep.tex) (/usr/share/texmf-texlive/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf-texlive/tex/latex/base/omscmr.fd) [1]
Overfull \hbox (5.27824pt too wide) in paragraph at lines 147--159
\OT1/cmr/m/n/10 If you make use of pre-pro-ces-sor di-rec-tives in the Do-conce
 source, ei-ther [][][][][][]
[2] [3]
Overfull \hbox (3.29488pt too wide) in paragraph at lines 270--274
 \OT1/cmr/bx/n/10 Step 1.[] \OT1/cmr/m/n/10 Fil-ter the do-conce text to a pre-
L[]T[]X form []\OT1/cmtt/m/n/10 mydoc.p.tex \OT1/cmr/m/n/10 for []\OT1/cmtt/m/n
/10 ptex2tex\OT1/cmr/m/n/10 :

Overfull \hbox (53.0808pt too wide) in paragraph at lines 277--282
\OT1/cmr/m/n/10 be placed in files []\OT1/cmtt/m/n/10 newcommands.tex\OT1/cmr/m
/n/10 , []\OT1/cmtt/m/n/10 newcommands_keep.tex\OT1/cmr/m/n/10 , or []\OT1/cmtt
/m/n/10 newcommands_replace.tex
[4] [5] [6] [7] [8] [9] [10] [11] <figs/streamtubes.eps> [12]
Overfull \hbox (29.62364pt too wide) in paragraph at lines 879--882
\OT1/cmr/m/n/10 Doconce sup-ports tags for \OT1/cmr/m/it/10 em-pha-sized phrase
s\OT1/cmr/m/n/10 , \OT1/cmr/bx/n/10 bold-face phrases\OT1/cmr/m/n/10 , and []\O
T1/cmtt/m/n/10 verbatim text
[13] [14] [15] [16]

LaTeX Warning: Citation `Python:Primer:09' on page 17 undefined on input line 1
115.


LaTeX Warning: Citation `Osnes:98' on page 17 undefined on input line 1115.


LaTeX Warning: Citation `Python:Primer:09' on page 17 undefined on input line 1
116.


LaTeX Warning: Citation `Osnes:98' on page 17 undefined on input line 1116.

[17] (./manual.out.pyg) (./manual.out.pyg [18]) [19]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1356.


Overfull \hbox (19.95741pt too wide) in paragraph at lines 1394--1396
 \OT1/cmr/bx/n/10 Ex-am-ple.[] \OT1/cmr/m/n/10 Sup-pose we have the fol-low-ing
 com-mands in []\OT1/cmtt/m/n/10 newcommand_replace.tex\OT1/cmr/m/n/10 : 
[20] <figs/wavepacket_0001.eps> <figs/wavepacket_0010.eps> [21] [22] [23]
[24] [25] [26] (./manual.bbl) (./manual.ind [27] [28]) (./manual.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on manual.dvi (28 pages, 126608 bytes).
Transcript written on manual.log.
+ latex -shell-escape manual
This is pdfTeX, Version 3.1415926-1.40.10 (TeX Live 2009/Debian)
 \write18 enabled.
entering extended mode
(./manual.tex
LaTeX2e <2009/09/24>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, loaded.
(/usr/share/texmf-texlive/tex/latex/base/article.cls
Document Class: article 2007/10/19 v1.4h Standard LaTeX document class
(/usr/share/texmf-texlive/tex/latex/base/size10.clo))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/relsize.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty
(/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty
(/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty
(/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
(/etc/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvips.def))))
(/usr/share/texmf-texlive/tex/latex/base/makeidx.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty
(/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty))
(/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
(/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty))
(/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
(/usr/share/texmf-texlive/tex/latex/hyperref/hyperref.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifpdf.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifvtex.sty)
(/usr/share/texmf-texlive/tex/generic/ifxetex/ifxetex.sty)
(/usr/share/texmf-texlive/tex/latex/oberdiek/hycolor.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/xcolor-patch.sty))
(/usr/share/texmf-texlive/tex/latex/hyperref/pd1enc.def)
(/usr/share/texmf-texlive/tex/generic/oberdiek/etexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/infwarerr.sty))
(/usr/share/texmf-texlive/tex/latex/latexconfig/hyperref.cfg)
(/usr/share/texmf-texlive/tex/latex/oberdiek/kvoptions.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/kvsetkeys.sty))
Implicit mode ON; LaTeX internals redefined
(/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bitset.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/intcalc.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/bigintcalc.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/pdftexcmds.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/ifluatex.sty)
(/usr/share/texmf-texlive/tex/generic/oberdiek/ltxcmds.sty))))
(/usr/share/texmf-texlive/tex/generic/oberdiek/atbegshi.sty))
*hyperref using default driver hdvips*
(/usr/share/texmf-texlive/tex/latex/hyperref/hdvips.def
(/usr/share/texmf-texlive/tex/latex/hyperref/pdfmark.def))
(/usr/share/texmf-texlive/tex/latex/base/inputenc.sty
(/usr/share/texmf-texlive/tex/latex/base/latin1.def))
(/home/hpl/texmf/tex/latex/misc/ptex2tex.sty
(/usr/share/texmf-texlive/tex/latex/fancyvrb/fancyvrb.sty
Style option: `fancyvrb' v2.7a, with DG/SPQR fixes, and firstline=lastline fix 
<2008/02/07> (tvz)) (/usr/share/texmf-texlive/tex/latex/moreverb/moreverb.sty
(/usr/share/texmf-texlive/tex/latex/tools/verbatim.sty))
(/usr/share/texmf-texlive/tex/latex/ltxmisc/framed.sty)
(/usr/share/texmf-texlive/tex/latex/graphics/color.sty
(/etc/texmf/tex/latex/config/color.cfg)
(/usr/share/texmf-texlive/tex/latex/graphics/dvipsnam.def))
(/home/hpl/texmf/tex/latex/misc/listings2.sty
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty)
(/usr/share/texmf-texlive/tex/latex/listings/listings.cfg))
(/home/hpl/texmf/tex/latex/misc/codehighlight.sty
(/usr/share/texmf/tex/latex/xcolor/xcolor.sty
(/etc/texmf/tex/latex/config/color.cfg)))
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstlang1.sty)
(/usr/share/texmf-texlive/tex/latex/listings/lstmisc.sty))
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.sty
****************************************
* Local config file subfigure.cfg used *
****************************************
(/usr/share/texmf-texlive/tex/latex/subfigure/subfigure.cfg))
(/home/hpl/texmf/tex/latex/misc/minted.sty
(/usr/share/texmf-texlive/tex/latex/float/float.sty)
(/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
(/usr/share/texmf-texlive/tex/latex/tools/calc.sty)
(/usr/share/texmf-texlive/tex/latex/ifplatform/ifplatform.sty
(/usr/share/texmf-texlive/tex/generic/oberdiek/catchfile.sty) (./manual.w18))/usr/bin/pygmentize
)
Writing index file manual.idx
(./manual.aux) (/usr/share/texmf-texlive/tex/latex/hyperref/nameref.sty
(/usr/share/texmf-texlive/tex/latex/oberdiek/refcount.sty)) (./manual.out)
(./manual.out) (./manual.pyg) (./newcommands_replace.tex)
(./newcommands_keep.tex) (/usr/share/texmf-texlive/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf-texlive/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf-texlive/tex/latex/base/omscmr.fd) [1]
Overfull \hbox (5.27824pt too wide) in paragraph at lines 147--159
\OT1/cmr/m/n/10 If you make use of pre-pro-ces-sor di-rec-tives in the Do-conce
 source, ei-ther [][][][][][]
[2] [3]
Overfull \hbox (3.29488pt too wide) in paragraph at lines 270--274
 \OT1/cmr/bx/n/10 Step 1.[] \OT1/cmr/m/n/10 Fil-ter the do-conce text to a pre-
L[]T[]X form []\OT1/cmtt/m/n/10 mydoc.p.tex \OT1/cmr/m/n/10 for []\OT1/cmtt/m/n
/10 ptex2tex\OT1/cmr/m/n/10 :

Overfull \hbox (53.0808pt too wide) in paragraph at lines 277--282
\OT1/cmr/m/n/10 be placed in files []\OT1/cmtt/m/n/10 newcommands.tex\OT1/cmr/m
/n/10 , []\OT1/cmtt/m/n/10 newcommands_keep.tex\OT1/cmr/m/n/10 , or []\OT1/cmtt
/m/n/10 newcommands_replace.tex
[4] [5] [6] [7] [8] [9] [10] [11] <figs/streamtubes.eps> [12]
Overfull \hbox (29.62364pt too wide) in paragraph at lines 879--882
\OT1/cmr/m/n/10 Doconce sup-ports tags for \OT1/cmr/m/it/10 em-pha-sized phrase
s\OT1/cmr/m/n/10 , \OT1/cmr/bx/n/10 bold-face phrases\OT1/cmr/m/n/10 , and []\O
T1/cmtt/m/n/10 verbatim text
[13] [14] [15] [16] [17] (./manual.out.pyg) (./manual.out.pyg [18]) [19]

Package amsmath Warning: Foreign command \over;
(amsmath)                \frac or \genfrac should be used instead
(amsmath)                 on input line 1356.


Overfull \hbox (19.95741pt too wide) in paragraph at lines 1394--1396
 \OT1/cmr/bx/n/10 Ex-am-ple.[] \OT1/cmr/m/n/10 Sup-pose we have the fol-low-ing
 com-mands in []\OT1/cmtt/m/n/10 newcommand_replace.tex\OT1/cmr/m/n/10 : 
[20] <figs/wavepacket_0001.eps> <figs/wavepacket_0010.eps> [21] [22] [23]
[24] [25] [26] (./manual.bbl) (./manual.ind [27] [28]) (./manual.aux) )
(see the transcript file for additional information)
Output written on manual.dvi (28 pages, 127604 bytes).
Transcript written on manual.log.
+ dvipdf manual.dvi
+ doconce format gwiki manual.do.txt
run preprocess -DFORMAT=gwiki  manual.do.txt > __tmp.do.txt
translate preprocessed Doconce text in __tmp.do.txt

NOTE: Place figs/streamtubes.png at some place on the web and edit the
      .gwiki page, either manually (seach for 'Figure: ')
      or use the doconce script:
      doconce gwiki_figsubst.py mydoc.gwiki URL


NOTE: Place figs/wavepacket_0001.png at some place on the web and edit the
      .gwiki page, either manually (seach for 'Figure: ')
      or use the doconce script:
      doconce gwiki_figsubst.py mydoc.gwiki URL


NOTE: Place figs/wavepacket_0010.png at some place on the web and edit the
      .gwiki page, either manually (seach for 'Figure: ')
      or use the doconce script:
      doconce gwiki_figsubst.py mydoc.gwiki URL

output in manual.gwiki
+ doconce subst \(the URL of the image file figs/streamtubes.png must be inserted here\) https://doconce.googlecode.com/hg/doc/manual/figs/streamtubes.png manual.gwiki
\(the URL of the image file figs/streamtubes.png must be inserted here\) replaced by https://doconce.googlecode.com/hg/doc/manual/figs/streamtubes.png in manual.gwiki
+ rm -f *.ps
+ rm -rf demo
+ mkdir demo
+ cp -r manual.do.txt manual.html figs manual.tex manual.pdf manual.rst manual.sphinx.rst manual.sphinx.pdf manual.xml manual.rst.html manual.rst.tex manual.rst.pdf manual.gwiki manual.txt manual.epytext manual.st sphinx-rootdir/_build/html demo
+ cd demo
+ cat
+ cd ..
+ rm -rf ../demos/manual
+ cp -r demo ../demos/manual
+ echo

+ echo Go to the demo directory and load index.html into a web browser.
Go to the demo directory and load index.html into a web browser.