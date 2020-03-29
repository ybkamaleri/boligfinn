## Digits should be 7 for million
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
