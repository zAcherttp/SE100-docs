# SE100 Documentation

## Quick LaTeX Guide

### File Organization

- **Images**: `assets/{sectionname}/*.png`
- **Section files**: `workspace/{sectionname}.tex`
- **Multi-file sections**: `workspace/{sectionname}/` (sub-files compile to main section)

### Common Syntax

```latex
% Comments start with %

\section{Title}           % Main section
\subsection{Subtitle}     % Subsection

\textbf{bold text}        % Bold
\textit{italic text}      % Italic
\code{code_text}          % Monospaced (for identifiers)

% Lists
\begin{itemize}
    \item First item
    \item Second item
\end{itemize}

\begin{enumerate}
    \item Numbered item
    \item[2a.] Custom label
\end{enumerate}

% Images
\begin{figure}[h]
    \centering
    \includegraphics[width=0.8\textwidth]{assets/sectionname/image.png}
    \caption{Image description}
    \label{fig:label}
\end{figure}

% Tables
\begin{table}[h]
    \centering
    \caption{Table title}
    \label{tab:label}
    \begin{tabular}{|p{4cm}|p{10cm}|}
        \hline
        \textbf{Header 1} & \textbf{Header 2} \\
        \hline
        Cell 1 & Cell 2 \\
        \hline
    \end{tabular}
\end{table}

% Dashes
-           % Hyphen (for compound words: well-known)
--          % En dash (for ranges: pages 10--20)
---         % Em dash (for breaks in thought --- like this)

% References
See Table~\ref{tab:label} or Figure~\ref{fig:label}
```
