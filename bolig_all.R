## ----------------------------------------------------------------
## Analysis of price for houses in Norway published in Finn.no
## ----------------------------------------------------------------
if (!require(robotstxt)) install.packages("robotstxt")
## Required packages
pkgs <- c("robotstxt", "rvest", "selectr", "xml2", "dplyr", "stringr",
          "forcats", "magrittr", "tidyr", "ggplot2", "lubridate", "tibble", "purrr")

nypkg <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
if (length(nypkg)) install.packages(nypkg)

sapply(pkgs, require, character.only = TRUE)


## Download search
boligAlle <- xml2::read_html(
"https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20507&no_of_bedrooms_from=2&price_to=5000000")

## Downlaod info one of the search result i.e
## Selected house
bolig1 <- xml2::read_html("https://www.finn.no/realestate/homes/ad.html?finnkode=137950373")


html_children(boligAlle)
html_structure(boligAlle)

html_nodes(boligAlle, "div")
html_nodes(boligAlle, c("div .ads__unit__content"))
html_nodes(boligAlle, c("div .ads__unit__content h2 a"))


### Example
<div class="ads__unit__content">
    <h2 class="ads__unit__content__title ads__unit__content__title--fav-placeholder" id="result-item-heading-171369189">
        <a id="171369189"
            href="/realestate/homes/ad.html?finnkode&#61;171369189"
            class="ads__unit__link"
            data-finnkode="171369189"


## Funker ikke
boligAlle %>%
    html_nodes(c("div .ads__unit__content h2 a .ads__unit__link")) %>%
    html_text()

## Funker litt
funker <- html_nodes(boligAlle, xpath =
                          ".//div[contains(@class, 'ads__unit__content')]/h2/a")%>%
    html_attr("href")

gsub(".*[\\d]", "", funker)
gsub("e=", "", gsub(".*[\\d]", "", funker))


test <- boligAlle %>%
    html_nodes(xpath = "//div[@class='ads__unit__content']/h2/a[2]")

test

grep("finnkode(=\\d)", test, value = TRUE)
grep("(?<=finnkode=)\\d", test, value = TRUE, perl = TRUE)
