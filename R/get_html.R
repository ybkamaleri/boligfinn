#' Get HTML codes
#'
#' Collect all \code{HTML} code for further anaysis
#'
#' @param area Areas to choose in Oslo
#' @param pmin Minimum price
#' @param pmax Maximum price
#' @param add Other areas code which isn't included in the default
#'
#'
#' @export
get_html <- function(area = 1:5, pmin = 3, pmax = 5, add = NULL, ...){

    ## Default areas if not selected
    ## Sagene / St. Hanshaugen / Majorstuen
    areas <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20508&location=1.20061.20509&location=1.20061.20510"

    oslo <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061"

    ## Area koder
    frogneKode <- "&location=1.20061.20507"
    grnlokeKode <- "&location=1.20061.20511"
    sageneKode <- "&location=1.20061.20510" # sagene and torshov
    sthaugenKode <- "&location=1.20061.20509"
    majorstuaKode <- "&location=1.20061.20508"

    areaCodes <- c(frogneKode,
                   grnlokeKode,
                   sageneKode,
                   sthaugenKode,
                   majorstuaKode)



    ## Selected area codes
    ## area = c(2:4)
    selCodes <- paste0(areaCodes[area], collapse = "")

    ## Select price
    pmin <- add_mil(pmin)
    pmax <- add_mil(pmax)

    selPrice <- glue::glue("&price_collective_from={minPrice}",
                            "&price_collective_to={maxPrice}",
                            minPrice = format(pmin, scientific = FALSE),
                            maxPrice = format(pmax, scientific = FALSE))


    ## Get html
    htmlOut <- paste0(oslo, selCodes, selPrice, collapse = "")

    return(htmlOut)

}
