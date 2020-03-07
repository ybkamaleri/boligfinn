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

## Check if website can be extracted
## If it's TRUE then it's extractable
## For Bygdøy and Majorsuten area
robotstxt::paths_allowed(paths = c("https://www.finn.no/realestate/homes/search.html?location=0.20061&location=1.20061.20507&location=1.20061.20508"))
## And only those with price between 3.3 - 5.5
robotstxt::paths_allowed(paths = c("https://www.finn.no/realestate/homes/search.html?is_new_property=false&location=0.20061&location=1.20061.20507&location=1.20061.20508&price_collective_from=3300000&price_collective_to=5500000"))

## Download the site
bolig <- xml2::read_html("https://www.finn.no/realestate/homes/search.html?is_new_property=false&location=0.20061&location=1.20061.20507&location=1.20061.20508&price_collective_from=3300000&price_collective_to=5500000")

## In the 6th floor and gives only 2 flats (For working example)
bolig6 <- xml2::read_html("https://www.finn.no/realestate/homes/search.html?floor_navigator=6&is_new_property=false&location=0.20061&location=1.20061.20507&location=1.20061.20508&price_collective_from=3300000&price_collective_to=5500000")

bolig66 <- xml2::download_html("https://www.finn.no/realestate/homes/search.html?floor_navigator=6&is_new_property=false&location=0.20061&location=1.20061.20507&location=1.20061.20508&price_collective_from=3300000&price_collective_to=5500000")

## Some options to explore the html file
bolig <- bolig6
xml_root(bolig)
xml_structure(bolig)
html_structure(bolig)

xml_name(bolig)
xml_children(bolig)
xml_parent(bolig)
xml_path(bolig)

finnList <- as_list(bolig)

## Proper work start here
## Explore nodes
boNodes <- bolig %>%
    html_node("body") %>%
    html_children()

bolig %>%
    rvest::html_nodes("div")


## Find info from extracted html file:
## extractedHTML.htm

## General info
boInfo <- bolig %>%
    html_nodes(".ads__unit__content h2 a") %>%
    html_text()

## address
boAdd <- bolig %>%
    rvest::html_nodes(".ads__unit__content__details div")
    ## xml2::xml_find_all("//div")

## same output with xpath and css
html_nodes(bolig, xpath = "//div[@class ='ads__unit__content__keys']/div")
html_nodes(bolig, xpath = "//div[contains(@class, 'ads__unit__content__keys')]/div")
html_nodes(bolig, css = ".ads__unit__content__keys div")

boSizePris <- bolig %>%
    html_nodes(".ads__unit__content__keys div")

boSP <- as_list(boSizePris)
## Size
boSize <- boSP[1:length(boSP) %% 2 == 1] #Odd number row

boSize2 <- bolig %>%
    html_nodes(xpath = "//div[@class='ads__unit__content__keys']") %>%
    html_node(css = "div")


## Price
boPris <- boSP[1:length(boSP) %% 2 == 0] #Even number row

boPris2 <- bolig %>%
    html_nodes(xpath = "//div[@class='ads__unit__content__keys']/div") %>%
    as_list()

boPris2[lapply(1:length(boPris2), "%%", 2) == 0]


## Total price but not all is accessable
xml2::xml_find_all(bolig, xpath = "//div[contains(@class,'ads__unit__content__list truncate')]")
html_nodes(bolig, css = ".ads__unit__content__list")

boToPris <- bolig %>%
    xml2::xml_find_all(xpath = "//div[contains(@class,'ads__unit__content__list truncate')]")

## Total found
boFound <- bolig %>%
    #extract only first node i.e html_node
    html_node(xpath = "//span[@class='current-hit-count']/b") %>%
    html_attr("data-count")


## Get Finnkkode
## Funker litt
funker <- html_nodes(bolig, xpath =
                          ".//div[contains(@class, 'ads__unit__content')]/h2/a")%>%
    html_attr("href")

gsub(".*[\\d]", "", funker)
gsub("e=", "", gsub(".*[\\d]", "", funker))
