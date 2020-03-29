## Create package from start
library(usethis)
create_package("~/Git-personal/boligfinn")

library(devtools)
library(rmarkdown)

use_build_ignore("^draft$", escape = FALSE)

## Add package dependencies
pkgs <- c("robotstxt", "rvest",  "xml2", "data.table", "stringi", "ggplot2",)


sapply(pkgs, use_package)

## Readme
use_readme_rmd()

## to use pipe %>%
use_pipe()

## create R file
## -------------
library(here)
library(fs)

fs::file_create(here("R", "get_finn.R"))


## Pkgdown
## ---------
library(pkgdown)

# Run once to configure package to use pkgdown
usethis::use_pkgdown()

# Run to build the website
pkgdown::build_site()
