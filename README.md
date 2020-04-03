<!-- README.md is generated from README.Rmd. Please edit that file -->

boligfinn
=========

<!-- badges: start -->

[![Build
Status](https://travis-ci.org/ybkamaleri/boligfinn.svg?branch=master)](https://travis-ci.org/ybkamaleri/boligfinn)
[![Codecov test
coverage](https://codecov.io/gh/ybkamaleri/boligfinn/branch/master/graph/badge.svg)](https://codecov.io/gh/ybkamaleri/boligfinn?branch=master)
<!-- badges: end -->

The goal of `boligfinn` is to be able extract data from
[Finn.no](https://www.finn.no/) and create a database for current
appartments on sale. You can then just use your imagination on how to
use the data. The default areas are around **OSLO** but you can easily
adjust the code to whatever town in Norway you are interested in.

The documentation can be found here
(<a href="https://ybkamaleri.github.io/boligfinn" class="uri">https://ybkamaleri.github.io/boligfinn</a>)

Installation
------------

You can install the released version of boligfinn from
[CRAN](https://CRAN.R-project.org) when I’m ready to publish it in CRAN
with:

    install.packages("boligfinn")

but until that time comes, then you have to install it from **GitHub**.

    if(!require(remotes)) install.packages("remotes")
    remotes::install_github("ybkamaleri/boligfinn")

Example
-------

This is a basic example which shows you how to use the main function ie.
`finn()`:

    library(boligfinn)
    ## basic example code
    DF <- finn()
