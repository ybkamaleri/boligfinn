
<!-- README.md is generated from README.Rmd. Please edit that file -->

# boligfinn

<!-- badges: start -->

[![Build
Status](https://travis-ci.org/ybkamaleri/boligfinn.svg?branch=master)](https://travis-ci.org/ybkamaleri/boligfinn)
[![Codecov test
coverage](https://codecov.io/gh/ybkamaleri/boligfinn/branch/master/graph/badge.svg)](https://codecov.io/gh/ybkamaleri/boligfinn?branch=master)
<!-- badges: end -->

The goal of `boligfinn` is to be able to extract data from
[Finn.no](https://www.finn.no/) and create a database for current
appartments on sale. You can then just use your imagination on how to
use the data. The default areas are around **OSLO** but you can easily
adjust the code to whatever town in Norway you are interested in.

The documentation can be found here
(<https://ybkamaleri.github.io/boligfinn>)

## Installation

You can install the released version of boligfinn from
[CRAN](https://CRAN.R-project.org) when I am ready to publish it in CRAN
with:

``` r
install.packages("boligfinn")
```

but until that time comes, then you have to install it from **GitHub**.

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("ybkamaleri/boligfinn")
```

## Extract data

This is a basic example which shows you how to use the main function ie.
`finn()`:

``` r
library(boligfinn)
## basic example code
DF <- finn()

## specify the parameter
DF <- finn(area = c(1, 3), pmin = 35, pmax = 5000000)
```

For the minimum and maximum prices, it is in million. You can write it
the whole digits or exclude the zeros.

## Create database

If you are interested to save the extracted data to a database.

``` r
make_db(DF)
```

Database will be created automatically. Therefore it is not necessary to
specify the database name.

``` r
outData <- read_db()
#get the file path
get_db()
```

Hope you fine the package :package: useful\! You are welcome to make
pull request to contribute.
