#' Create table from Finn search
#'
#' @inheritParams get_html
#'
#' @export
finn <- function(area = 1:5, pmin = 3, pmax = 5, add = NULL, ...){

    ## Get html
    finnHTML <- get_html(area = area, pmin = pmin, pmax = pmax, add = add)

    ## Finn codes
    finnCodes <- get_finn(finnHTML)


}
