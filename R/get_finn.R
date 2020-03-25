#' Get all the Finn kodes
#'
#' @param html \code{HTML} search from
#' \url[Finn.no]{https://www.finn.no/realestate/browse.html}
#'
#'

get_finn <- function(html = NULL){
    allFinn <- xml2::read_html(html)

    ## Get finn koder
    codeAll <- rvest::html_nodes(allFinn, css = c("div .ads__unit__content h2 a")) %>%
        rvest::html_attr("href") %>%
        stringi::stri_extract(regex = "[^.*\\=]\\d+")

    return(codeAll)
}
