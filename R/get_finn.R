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
