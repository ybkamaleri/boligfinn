
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
finn()

## or save as an object
DF = finn()

## specify the parameter
DF = finn(area = 1, pmin = 35, pmax = 5000000)
```

Currently these areas can be selected:

    1:Bygdøy/Frogner
    
    2:Grünerløkka/Sofienberg
    
    3:Sagene/Torshov
    
    4:St.Hanshaugen/Ullevål
    
    5:Uranienborg/Majorstuen

You could combine area during download such as `area = c(1,3)`, but
isn’t recommended. You could only get maximum 50 rows per download and
I haven’t figured it out how to solve this problem and still in the
*TODO* list. Please come with solution if you have it\!

For the minimum and maximum prices, it is in million. You can write it
the whole digits or exclude the zeros.

## Create database

If you are interested to save the extracted data to a database.

``` r
make_db(DF)
```

You know that it won’t be easy to remember things that you don’t use
frequently :smile:. At least I have that problem. Therefore if you want
to save the downloaded data as a database, this will be created
automatically and you don’t have to remember what the database is call\!
Therefore it is not necessary to specify the database name.

``` r
read_db()

#save the output
dt = read_db()
```

But if you are curious and want to check the path for database file, use
`path_db()` function.

Hope you will find this package is useful\! You are welcome to make pull
request to contribute.
