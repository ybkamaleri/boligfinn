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


#' Common debt
#'
#' @inheritParams get_add

get_debt <- function(x){

    gjeldxml <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[1]"
    preOut <- rvest::html_nodes(x, xpath = gjeldxml) %>%
        rvest::html_text()

    out <- stringi::stri_replace_all(preOut, "", regex = "\\s")
    unlist(stringi::stri_extract_all(out, regex = "\\d+"))
}



#' Other cost
#'
#' @inheritParams get_add

get_cost <- function(x) {
    out <- rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/div[3]/div[1]/dl[2]/dd[2]") %>%
        rvest::html_text()

    unlist(stringi::stri_extract_all(out, regex = "\\d+"))
}



#' Total price
#'
#' @inheritParams get_add

get_total <- function(x){
    fromPath <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[3]"
    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

    paste(unlist(stringi::stri_extract_all(out, regex = "\\d")), collapse = "")

}


## Felleskost/Måned kosnad
#' Monthly cost
#'
#' @inheritParams get_add

get_month <- function(x){

    fromPath <- "/html/body/main/div/div[4]/div[1]/div/div[3]/dl[2]/dd[4]"
    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

   paste(unlist(stringi::stri_extract_all(out, regex = "\\d+")), collapse = "")
}


## Boligtype
#' Appartment type
#'
#' @inheritParams get_add

get_type <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[1]") %>%
        rvest::html_text()
}


## Eieform
#' Type of owership
#'
#' @inheritParams get_add

get_form <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[2]") %>%
        rvest::html_text()
}


## soverom
#' Number of bedrooms
#'
#' @inheritParams get_add
get_bed <- function(x){

    fromPath <- "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[3]"
    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

    unlist(stringi::stri_extract_all(out, regex = "\\d+"))
}


## Primærrom
#' Primary room size (primærrom)
#'
#' @inheritParams get_add

get_primary <- function(x){

    fromPath <- "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[4]"
    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

    paste(unlist(stringi::stri_extract_all(out, regex = "\\d+")), collapse = "")
}

## Bruksareal
#' Size of appartment (bruksareal)
#'
#' @inheritParams get_add

get_size <- function(x){

    fromPath <- "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[5]"
    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

    paste(unlist(stringi::stri_extract_all(out, regex = "\\d+")), collapse = "")
}

## etasje
#' Floor
#'
#' @inheritParams get_add

get_floor <- function(x){

    fromPath <- "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[6]"

    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

    unlist(stringi::stri_extract_all(out, regex = "\\d+"))

}

## Byggår
#' Year of build
#'
#' @inheritParams get_add

get_build <- function(x){

    fromPath <- "/html/body/main/div/div[4]/div[1]/div/section[2]/dl/dd[7]"

    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()

    unlist(stringi::stri_extract_all(out, regex = "\\d+"))

}

## Antall rom
#' Number of rooms
#'
#' @inheritParams get_add

get_room <- function(x){
    rvest::html_nodes(x, xpath = "/html/body/main/div/div[4]/div[1]/div/section[2]/div/dl[1]/dd[1]") %>%
        rvest::html_text()
}


## Første visning dato
#' Visit date
#'
#' @inheritParams get_add

get_date <- function(x){
    datoHtml <-
        "/html/body/main/div/div[4]/div[2]/div/div[2]/div/div/div[1]/dl/div[1]/dd"
    out <- rvest::html_nodes(x, xpath = datoHtml) %>%
        rvest::html_text()
}

## Status
#' Current status
#'
#' @inheritParams get_add

get_status <- function(x){
    fromPath <- "/html/body/main/div/div[4]/div[1]/div/div[2]/span"

    out <- rvest::html_nodes(x, xpath = fromPath) %>%
        rvest::html_text()


}

## Balkong
#' Balcony
#'
#' @inheritParams get_add

get_balcony <- function(x){
    htmlBK <- "/html/body/main/div/div[4]/div[1]/div/section[1]/h1"
    txtBK <-rvest::html_nodes(x, xpath = htmlBK) %>%
       rvest::html_text()

    medBalkong <- grepl("balkong", txtBK) #TRUE finnes det

    return(medBalkong)
}
