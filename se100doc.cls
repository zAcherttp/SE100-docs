% ========= Config paper and font =============
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{se100doc}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
\LoadClass[14pt,a4paper]{memoir}

% ========== Require package to setup paper, link, language
\RequirePackage{anyfontsize,mathptmx}
\RequirePackage[T5]{fontenc}
\RequirePackage{geometry,graphicx,indentfirst,setspace}
\RequirePackage{tikz}
\RequirePackage[center]{caption}
\RequirePackage{fancyhdr,hyperref}
\RequirePackage[vietnamese,english]{babel}
\RequirePackage[utf8]{vietnam}
\RequirePackage{listings}
\RequirePackage{glossaries}
\RequirePackage[fontsize=13pt]{scrextend}
\RequirePackage{placeins}
\RequirePackage{amsfonts,amssymb}
\RequirePackage{textcomp}
\RequirePackage{dblfloatfix}
\RequirePackage{lineno}
\RequirePackage{tabularx,booktabs}
\RequirePackage{longtable}
\RequirePackage{amsmath,mathtools}
\RequirePackage{lscape}
\RequirePackage{lipsum,blindtext}
\RequirePackage{titlesec}
\RequirePackage{makecell}
\RequirePackage{subcaption}
\RequirePackage{adjustbox}
\RequirePackage{multirow}
\RequirePackage{rotating}
\RequirePackage[utf8]{inputenc}
\RequirePackage{tikz-uml}
\RequirePackage{underscore}
\RequirePackage{morefloats} % Increase float capacity
\usetikzlibrary{calc}

% Define color and column type
\hypersetup{urlcolor=blue,linkcolor=black,citecolor=black,colorlinks=true} 
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\newcolumntype{C}[1]{>{\centering\arraybackslash}m{#1}}

% Config figure path
\graphicspath{ {./assets/} }

% Define the desired distance from the top of the page
\newlength{\chaptertopmargin}
\setlength{\chaptertopmargin}{0cm} % Adjust the value as needed
\titlespacing*{\chapter}{0pt}{\chaptertopmargin}{0pt} % Adjust the second value for space before chapter titles

% Config for math in quantum computing
\DeclarePairedDelimiter\bra{\langle}{\rvert}
\DeclarePairedDelimiter\ket{\lvert}{\rangle}
\DeclarePairedDelimiterX\braket[2]{\langle}{\rangle}{#1 \delimsize\vert#2}

% Config listings 
\lstset{
  frame=tb,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=fullflexible,
  basicstyle={\small\ttfamily},
  numbers=left,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space},
  tabsize=4
}

% =========== Overwrite exist command to custom project ============
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\large}{\fontsize{15}{15}\selectfont}
\renewcommand{\Large}{\fontsize{20}{20}\selectfont}
\renewcommand{\arraystretch}{1.2}
\renewcommand*{\lstlistingname}{Đoạn mã}
\renewcommand\lstlistlistingname{Danh sách đoạn mã}

\renewcommand*{\glossarysection}[2][]{%
  \chapter*{Danh sách các từ viết tắt}
  \addcontentsline{toc}{chapter}{Danh sách các từ viết tắt}
}

% ==========Setup paper margin and footer==========
\geometry{
  paper=a4paper,
  left=3cm,
  right=2cm,
  vmargin=2cm,
  includeheadfoot=true,
  headheight=20pt
}
\OnehalfSpacing
\raggedbottom

% Set depth of numbering for sections and table of contents
\setsecnumdepth{subsection}
\settocdepth{subsection}

% Set numwidths
\setlength{\cfttablenumwidth}{3em}
\setlength{\cftfigurenumwidth}{3em}

% ==========Setup color for link and url==========
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=purple
}

% ========== Setup page style ==========
\pagestyle{fancy}
\fancyhf{}

% Configure default page headers and footers
\fancyfoot[C]{\thepage}
\fancyhead[R]{\bfseries\nouppercase\rightmark}

% Set depth for sections
\setcounter{secnumdepth}{3}

% Counter configuration
\counterwithin{equation}{chapter}
\counterwithin{table}{chapter}
\counterwithin{figure}{chapter}

% ========== Configure list spacing ==========
\RequirePackage{enumitem}
\setlist[itemize]{itemsep=0pt, parsep=0pt, topsep=5pt}
\setlist[enumerate]{itemsep=0pt, parsep=0pt, topsep=5pt}

% ========== Define command for code/keyword formatting ==========
\newcommand{\code}[1]{\texttt{#1}}
