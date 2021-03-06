% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_database.R
\name{finn-database}
\alias{finn-database}
\alias{make_db}
\alias{read_db}
\alias{path_db}
\title{Create database}
\usage{
make_db(x, ...)

read_db()

path_db()
}
\arguments{
\item{x}{Data table from \link{finn} function}

\item{...}{Extra arguments}
}
\value{
An SQLite database
}
\description{
\itemize{
  \item \code{make_db()} create database from downloaded data with \link{finn}
  \item \code{read_db()} create connection to the database
  \item \code{path_db()} display the path of the database file \emph{boligfinn.sqlite}.
}
}
\section{Create folder automatically}{

This function will create a \strong{boligfinn} folder in the HOME directory
if it isn't there and create a \emph{boligfinn.sqlite} database.
}

\section{Database file and path}{
 
This is standard and will be \code{~/boligfinn/boligfinn.sqlite}
}

