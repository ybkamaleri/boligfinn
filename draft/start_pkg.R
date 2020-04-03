## Package development
## -------------------
## OBS!! Make sure to run R from root package directory!
pkgs <- c("usethis", "devtools", "rmarkdown", "here", "fs", "data.table")
sapply(pkgs, require, character.only = TRUE)

## Looping
devtools::load_all()
devtools::document()

devtools::check()
devtools::test()

## Run in console
## devtools::test_file() #for a specific active file
## test_coverage()


usethis::edit_r_buildignore()



## STEP 1
## Create package from start
##--------------------------
library(usethis)
create_package("~/Git-personal/boligfinn")

library(devtools)
library(rmarkdown)

use_build_ignore("^draft$", escape = FALSE)

## Add package dependencies
pkgs <- c("robotstxt", "rvest",  "xml2", "data.table", "stringi", "ggplot2",)


sapply(pkgs, use_package)

usethis::use_description()

## Readme
use_readme_rmd()

## to use pipe %>%
use_pipe()

## create R file
## -------------
library(here)
library(fs)

fs::file_create(here("R", "get_finn.R"))


## add package to DESCRIPTION
usethis::use_package("fs")
usethis::use_package("DBI")
usethis::use_package("RSQLite")

## Test
##-----

usethis::use_test("Database_path")


## Pkgdown
## ---------
library(pkgdown)

# Run once to configure package to use pkgdown
usethis::use_pkgdown()

# Run to build the website
pkgdown::build_site()
