#' Get all the Finn kodes
#'
#' @param html \code{HTML} search from
#' \url[Finn.no]{https://www.finn.no/realestate/browse.html}
#'
#' @export

get_finn <- function(html){

    if (missing(html)) {
        stop("'html' must be provided",
             call. = FALSE)
    }

    ## Get finn koder
    allCode <- rvest::html_nodes(allFinn, css = c("div .ads__unit__content h2 a")) %>%
        rvest::html_attr("href") %>%
        stringi::stri_extract(regex = "[^.*\\=]\\d+")

    return(allCode)
}


#' Get detail for a coded appartment
#'
#' @param code The code for a specific appartment or house
#'
#' @export

get_flat <- function(code){

    if (missing(x)) {
        stop("'code' must be provided",
             call. = FALSE)
    }

    boligHtml <- "https://www.finn.no/realestate/homes/ad.html?finnkode="
    boKode <- paste0(boligHtml, code)
    bolig <- xml2::read_html(boKode)

    return(bolig)

}
