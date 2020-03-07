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
            href="/realestate/homes/ad.html?finnkode=171369189"
            class="ads__unit__link"
            data-finnkode="171369189"


## Option 1: Fin finnkode
## but a bit long way
funker <- html_nodes(boligAlle, xpath =
                          ".//div[contains(@class, 'ads__unit__content')]/h2/a")%>%
    html_attr("href")

funker

gsub(".*[\\d]", "", funker)
gsub("e=", "", gsub(".*[\\d]", "", funker)) #works
gsub(".*\\=[^\\d+]", "", funker) #why first digit is missing :-)
stringi::stri_extract(funker, regex = "[^.*\\=]\\d+") #works

## Option2: Find finnkode
## from this HTML using xpath
"<article draggable="false" class="ads__unit">
<div aria-owns="ads__unit__content__title3"></div>
<div aria-owns="result-item-heading-172391627"></div>"

html_nodes(boligAlle, xpath = "//article[@class='ads__unit']/div[1]")


## Option 3: from html file extractBolig.html and use css nodes
html_nodes(boligAlle, css = c("div .ads__unit__content h2 a")) %>%
    html_attr("href")

html_nodes(boligAlle, css = c("div .ads__unit__content h2 a")) %>%
    html_attr("href") %>%
    stringi::stri_extract(regex = "[^.*\\=]\\d+")


## =========================================================

test <- boligAlle %>%
    html_nodes(xpath = "//div[@class='ads__unit__content']/h2/a[2]")

test

grep("finnkode(=\\d)", test, value = TRUE)
grep("(?<=finnkode=)\\d", test, value = TRUE, perl = TRUE)

## Use stringi
library(stringi)
href="/realestate/homes/ad.html?finnkode=171369189"

stri_extract(href, regex = "[^.*\\=]\\d+$")


##==================
## Selected flat
##==================
## Refer to file selectedFlat.html
bo2 <-
    xml2::read_html("https://www.finn.no/realestate/homes/ad.html?finnkode=172391627")


## Path to Prisantyding
## body > main > div > div.grid > div.grid__unit.u-r-size2of3 > div > div:nth-child(4) > div:nth-child(1) > span.u-t3

## Option 1: css style
## ---------------------
html_nodes(bo2,
           css = c("body > main > div > div.grid > div.grid__unit.u-r-size2of3 > div > div:nth-child(4) > div:nth-child(1) > span.u-t3")) %>%
    html_text()

## Xpath style
html_nodes(bo2, xpath =
                       "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/span[2]") %>%
    html_text()


## Option 2: xpath style
## --------------------------------
## Xpath example for prisantydning
## /html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/span[2]

bolig1 <- xml2::read_html("https://www.finn.no/realestate/homes/ad.html?finnkode=172306637")

## Adresse
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[1]/p") %>%
    html_text()

## Prisantyding
html_nodes(bolig1, xpath =
                       "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/span[2]") %>%
    html_text()

## Fellesgjeld
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[1]") %>%
    html_text()

## Felleskost/Måned kosnad
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[4]") %>%
    html_text()

## Totalpris
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[3]") %>%
    html_text()

## Boligtype
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[1]") %>%
    html_text()

## Eieform
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[2]")

## Bruksareal
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[5]")

## soverom
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[3]")

## etasje
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[6]")
