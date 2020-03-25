## Create package from start
library(usethis)
create_package("~/Git-personal/boligfinn")

use_build_ignore("^draft$", escape = FALSE)

## Add package dependencies
pkgs <- c("robotstxt", "rvest",  "xml2", "data.table", "stringi", "ggplot2",)

sapply(pkgs, use_package)

## Readme
use_readme_rmd()
