% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_finn.R
\name{get_finn}
\alias{get_finn}
\title{Get all the Finn kodes}
\usage{
get_finn(html)
}
\arguments{
\item{html}{A \code{HTML} URL for searching flats within specified parameters from
\href{https://www.finn.no/realestate/browse.html}{Finn.no} eg. area and price.}
}
\value{
A vector of all Finn codes for flats from the specified \code{HTML}
}
\description{
This function will list all the codes for flats found from the specified HTML search.
}
