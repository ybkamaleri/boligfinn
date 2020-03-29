#' Get all the Finn kodes
#'
#' This function will list all the codes for flats found from the specified HTML search.
#'
#' @param html A \code{HTML} URL for searching flats within specified parameters from
#' \href{https://www.finn.no/realestate/browse.html}{Finn.no} eg. area and price.
#'
#' @return A vector of all Finn codes for flats from the specified \code{HTML}
#' @export

get_finn <- function(html){

    if (missing(html)) {
        stop("'html' must be provided",
             call. = FALSE)
    }

    ## Get finn koder
    allCode <- rvest::html_nodes(html, css = c("div .ads__unit__content h2 a")) %>%
        rvest::html_attr("href") %>%
        stringi::stri_extract(regex = "[^.*\\=]\\d+")

    return(allCode)
}


#' Get detail for a coded appartment
#'
#' Gether all the detail information from the selected flat such as flat type,
#' size etc.
#'
#' @param code The code for a specific appartment or house
#'
#' @export

get_flat <- function(code){

    if (missing(code)) {
        stop("'code' must be provided",
             call. = FALSE)
    }

    boligHtml <- "https://www.finn.no/realestate/homes/ad.html?finnkode="
    boKode <- paste0(boligHtml, code)
    bolig <- xml2::read_html(boKode)

    return(bolig)

}
