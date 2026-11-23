% SPDX-License-Identifier: LPPL-1.3c
%
% Document class for the CX project.
% It extends the Article class to standarize the page format, cover page, back
% page and title page of all the ducuments of the CX project.
%
%% Copyright (c) 2026 Carlos Madrid
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Carlos Madrid.
%%
%% This work consists of the cxdoc.cls file.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cxdoc}[2026/11/22 v0.1.0 CX Project document class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base class and options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pass unknown options to the base class (e.g. draft, twoside)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Load base class
\LoadClass[a4paper,11pt, twoside]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package inclusion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Core and layout
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[
        top=2.5cm,
        bottom=2.5cm,
        left=2.5cm,
        right=2.5cm,
        headheight=14pt
]{geometry}

% Structure
\RequirePackage{titlesec}
\RequirePackage[titletoc]{appendix}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{booktabs}

% Graphics
\RequirePackage{graphicx}
\RequirePackage{xcolor}

% Fonts
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{libertine}
\RequirePackage{inconsolata}

% Code
\RequirePackage{listings}

% Captions
\RequirePackage{caption}
\RequirePackage{subcaption}

% Mathem
\RequirePackage{amsmath}

% PDF
\RequirePackage[final]{pdfpages}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project metadata definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\@project}{Project Name}
\newcommand{\project}[1]{\renewcommand{\@project}{#1}}

\newcommand{\@docid}{PRJ-DOC-001}
\newcommand{\docid}[1]{\renewcommand{\@docid}{#1}}

\newcommand{\@docversion}{v1.0}
\newcommand{\docversion}[1]{\renewcommand{\@docversion}{#1}}

\newcommand{\@client}{Client / Organization}
\newcommand{\client}[1]{\renewcommand{\@client}{#1}}

\newcommand{\@logo}{}
\newcommand{\logo}[1]{\renewcommand{\@logo}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Headers and footers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\pagestyle{fancy}
\fancyhf{} % Clear default header and footer

% Header:
%% L: Project
%% R: Document ID Version
\fancyhead[LO, RE]{\@project}
\fancyhead[RO, LE]{{\@docid} {\@docversion}}

% Footer:
%% L: Document title
%% R: pagination
\fancyfoot[LO, RE]{\@title}
\fancyfoot[RO, LE]{Page {\thepage} of \pageref{LastPage}}

\renewcommand{\headrulewidth}{0.4pt}
% \renewcommand{\footrulewidth}{0.4pt}

% Clean style without headers/footers for cover and back cover pages
\fancypagestyle{coverpage}{
        \fancyhf{}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cover and Title pages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\maketitle}{
        \begin{titlepage}
                \thispagestyle{coverpage}
                \sffamily

                % Optional logo in the top-right corner
                % \begin{flushright}
                %         \ifx\@logo\@empty
                %         \else
                %                 \includegraphics[height=1.8cm]{\@logo}
                %         \fi
                % \end{flushright}

                \vspace{2cm}

                % {\large\bfseries\MakeUppercase{\@project}\par}
                {\large\bfseries\@project\par}
                \vspace{0.5cm}
                {\Huge\bfseries\@title\par}
                \vspace{0.4cm}
                \rule{\textwidth}{1.5pt}

                \vfill

                % Metadata summary block on the cover page
                \begin{tabular}{@{}ll@{}}
                        \textbf{Document ID:} & \@docid \\
                        \textbf{Version:}     & \@docversion \\
                        \textbf{Client:}      & \@client \\
                        \textbf{Author:}      & \@author \\
                        \textbf{Date:}        & \@date \\
                \end{tabular}

                \vspace{1cm}
        \end{titlepage}
        \setcounter{page}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Back Cover
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\makebackcover}{%
        \clearpage
        \thispagestyle{coverpage}
        \sffamily
        \null
        \vfill
        \begin{center}
                \rule{0.6\textwidth}{0.5pt}\\[0.4cm]
                {\small\bfseries\@project}\\[0.2cm]
                {\footnotesize{{\@docid} {\@docversion} | {\@client}}}\\[0.2cm]
                {\footnotesize{Generated on {\@date}}}
        \end{center}
        \vspace{1cm}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Endload
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load hyperref near the end of the class to avoid package conflicts
\RequirePackage[hidelinks]{hyperref}

\endinput
