#' Adresse or postcode
#'
#' @param x HTML code
#' @param postcode Get only postcode. Default is the whole address
#'
#' @export
get_add <- function(x, postcode = FALSE) {

    outAdd <- rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[1]/p") %>%
        rvest::html_text()

    outInfo <- outAdd


    if (postcode) {

        outPost <- stringi::stri_extract(outAdd, regex = "\\d{4}")
        outInfo <- outPost
    }

    return(outInfo)
}



#' Prisantyding
#'
#' @inheritParams get_add

get_price <- function(x) {

    prisHTML <- "/html/body/main/div/div[4]/div[1]/div/div[3]/span[2]"
    preOut <- rvest::html_nodes(x, xpath = prisHTML) %>%
        rvest::html_text()

    out <- stringi::stri_replace_all(preOut, "", regex = "\\s")
    unlist(stringi::stri_extract_all(out, regex = "\\d+"))

}


#' Fellesgjeld
#'
#' @inheritParams get_add

get_debt <- function(x){

    gjeldxml <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[1]"
    preOut <- rvest::html_nodes(x, xpath = gjeldxml) %>%
        rvest::html_text()

    out <- stringi::stri_replace_all(preOut, "", regex = "\\s")
    unlist(stringi::stri_extract_all(out, regex = "\\d+"))
}


## Omkosninger
get_cost <- function(x) {
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[2]") %>%
        rvest::html_text()
}

## Totalpris
get_total <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[3]") %>%
        rvest::html_text()
}


## Felleskost/Måned kosnad
get_common <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[4]") %>%
        rvest::html_text()
}


## Boligtype
get_type <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[1]") %>%
        rvest::html_text()
}


## Eieform
get_form <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[2]") %>%
        rvest::html_text()
}


## soverom
get_bed <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[3]")
}

## Primærrom
get_primary <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[4]")
}

## Bruksareal
get_area <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[5]")
}

## etasje
get_floor <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[6]")
}

## Byggår
get_build <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[7]")
}

## Antall rom
get_room <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/div/dl[1]/dd[1]") %>%
        rvest::html_text()
}


## Første visning dato
get_date <- function(x){
    datoHtml <-
        "/html/body/main/div/div[4]/div[2]/div/div[2]/div/div/div[1]/dl/div[1]/dd"
    rvest::html_nodes(x, xpath = datoHtml) %>%
        rvest::html_text()
}

## Status
get_status <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/div[2]/span") %>%
        rvest::html_text()
}

## Balkong
get_balcony <- function(x){
    htmlBK <- "/html/body/main/div/div[4]/div[1]/div/section[1]/h1"
    txtBK <-rvest::html_nodes(x, xpath = htmlBK) %>%
       rvest::html_text()

    medBalkong <- grepl("balkong", txtBK) #TRUE finnes det

    return(medBalkong)
}
