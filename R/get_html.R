#' Get HTML codes
#'
#' Collect all \code{HTML} code for further anaysis
#'
#' @inheritParams finn
#'
#' @export
get_html <- function(area, pmin, pmax, add){

    if (missing(area)) {area <- 1:5}

    if (missing(pmin)) {pmin = 3}

    if (missing(pmax)) {pmax = 5}

    if (missing(add)) {add = NULL}


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
