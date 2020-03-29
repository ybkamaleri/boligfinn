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


## -----------------------------------------
## Gets all the finnkode for all the search
## -----------------------------------------

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

## OBS!! Here it is!!
## The best option to get all kodes for the specified search
kodeAlle <- html_nodes(boligAlle, css = c("div .ads__unit__content h2 a")) %>%
    html_attr("href") %>%
    stringi::stri_extract(regex = "[^.*\\=]\\d+")

kodeAlle

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

bolig1 <- xml2::read_html("https://www.finn.no/realestate/homes/ad.html?finnkode=171896820")

## Download search
finnHtml <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20507&location=1.20061.20511&location=1.20061.20508&location=1.20061.20509&location=1.20061.20531&ownership_type=3&price_collective_from=3400000&price_collective_to=5200000"

boligAlle <- xml2::read_html(finnHtml)

## Get finn koder
kodeAlle <- rvest::html_nodes(boligAlle, css = c("div .ads__unit__content h2 a")) %>%
    rvest::html_attr("href") %>%
    stringi::stri_extract(regex = "[^.*\\=]\\d+")

kodeAlle
boligHtml <- "https://www.finn.no/realestate/homes/ad.html?finnkode="
boKode <- paste0(boligHtml, kodeAlle[1])
boKode
## browseURL(boKode)
bolig1 <- xml2::read_html(boKode)


library(rvest)
## Adresse
dt <- html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[1]/p") %>%
    html_text()
dt2 <- stringi::stri_extract(dt, regex = "\\d{4}")
str(dt2)
## stringi::stri_replace(dt, " ", regex = "^.*,[^\\d+]")

## Prisantyding
prisHTML <- "/html/body/main/div/div[4]/div[1]/div/div[3]/span[2]"
pris <- html_nodes(bolig1, xpath = prisHTML) %>%
    html_text()
pris01 <- stringi::stri_replace_all(pris, "", regex = "\\s")
unlist(stringi::stri_extract_all(pris01, regex = "\\d+"))

html_nodes(bolig1,
           xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/span[2]") %>%
    html_text()

## Fellesgjeld
gjeldxml <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[1]"
html_nodes(bolig1, xpath = gjeldxml) %>%
    html_text()

html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[1]") %>%
    html_text()

## Omkosninger
omxml <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[2]"
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[2]") %>%
    html_text()

## Totalpris
totxml <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[3]"
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[3]") %>%
    html_text()

## Felleskost/Måned kosnad
felxml <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[4]"
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[4]") %>%
    html_text()



## Boligtype
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[1]") %>%
    html_text()

## Eieform
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[2]") %>%
    html_text()

## soverom
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[3]")

## Primærrom
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[4]")

## Bruksareal
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[5]")

## etasje
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[6]")

## Byggår
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[7]")

## Antall rom
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/div/dl[1]/dd[1]") %>%
    html_text()

## Første visning dato
datoHtml <-
    "/html/body/main/div/div[4]/div[2]/div/div[2]/div/div/div[1]/dl/div[1]/dd"
html_nodes(bolig1, xpath = datoHtml) %>%
    html_text()

## Status
html_nodes(bolig1, xpath = "/html/body/main/div/div[4]/div[1]/div/div[2]/span") %>%
    html_text()
## If missing means it's still active

## Balkong
htmlBK <- "/html/body/main/div/div[4]/div[1]/div/section[1]/h1"
txtBK <- html_nodes(bolig1, xpath = htmlBK) %>%
    html_text()

txtBK
grepl("balkong", txtBK) #TRUE finnes det

utBK <- sub("balkong", "", txtBK)
grepl("balkong", utBK)

## TEST

html <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20507&location=1.20061.20511&location=1.20061.20508&location=1.20061.20509&location=1.20061.20531&ownership_type=3&price_collective_from=3400000&price_collective_to=5200000"

get_finn <- function(html = NULL){

    if (!is.null(html)) {
        allFinn <- xml2::read_html(html)
    }

    ## Get finn koder
    allCode <- rvest::html_nodes(allFinn, css = c("div .ads__unit__content h2 a")) %>%
        rvest::html_attr("href") %>%
        stringi::stri_extract(regex = "[^.*\\=]\\d+")

    return(allCode)
}


## Area koder
frogne <-
    "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20507"
frogneKode <- "&location=1.20061.20507"


grnloke <-
    "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20511"
grnlokeKode <- "&location=1.20061.20511"

## sagene and torshov
sagene <-
    "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20510"
sageneode <- "&location=1.20061.20510"

sthaugen <-
    "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20509"
sthaugenKode <- "&location=1.20061.20509"

majorstua <-
    "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20508"
majorstuaKode <- "&location=1.20061.20508"

## Sagene / St. Hanshaugen / Majorstuen
area3 <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20508&location=1.20061.20509&location=1.20061.20510"

oslo <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061"






## Price
## --------
priceRange <- "&price_collective_from=3400000&price_collective_to=5200000"
priceMin <- 3000000
priceMax <- 5200000

## Check it's in million with 7 digits
stringi::stri_count_regex(format(priceMin, scientific = FALSE), "\\d")

x <- 5

add_mil <- function(x) {
    digitSum <- stringi::stri_count_regex(format(x, scientific = FALSE), "\\d")
    zeroSum <- 7 - digitSum
    ## make it as million ie. 7 digits
    priceMil <- format(paste0(format(x, scientific = FALSE),
                              paste0(rep(0, zeroSum), collapse = "")),
                       scientific = FALSE)

    price <- as.character(priceMil)
    return(priceMil)
}

add_mil(x)

add_mil(priceMin)

xMin = add_mil(32)
xMax = add_mil(5000000)
priceBase <- glue::glue("&price_collective_from={minPrice}",
           "&price_collective_to={maxPrice}",
           minPrice = format(xMin, scientific = FALSE),
           maxPrice = format(xMax, scientific = FALSE))

priceBase
