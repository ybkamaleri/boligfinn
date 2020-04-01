#' Create table from Finn search
#'
#' @param ... Extra arguments
#' @inheritParams get_html
#'
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @export

finn <- function(area = 1:5, pmin = 3, pmax = 5, add = NULL, ...){

    ## Get html
    finnHTML <- get_html(area = area, pmin = pmin, pmax = pmax, add = add)

    ## List of Finn codes for the specified parameters
    finnCodes <- get_finn(finnHTML)


    ## Set progress bar
    pb <- txtProgressBar(min = 0, max = length(finnCodes), style = 3)

    finnTabel <- list()

    for (i in 1:length(finnCodes)){

        ## Progress bar
        setTxtProgressBar(pb, i)

        ## Detail info for a selected flat
        aptCode <- get_flat(finnCodes[i])

        ## Address
        aptAdd <- get_add(aptCode)

        ## price
        aptPrice <- get_price(aptCode)

        ## type
        aptType <- get_type(aptCode)

        ## ownership
        aptForm <- get_form(aptCode)

        ## postcode
        aptPost <- get_add(aptCode, postcode = TRUE)

        tempTab <- list(price = aptPrice,
                        type = aptType,
                        form = aptForm,
                        address = aptAdd,
                        postcode = aptPost)

        finnTabel[[i]] <- tempTab
    }

    ## stop Progress bar
    close(pb)

    ## Create table
    finnTabel <- data.table::rbindlist(finnTabel)

    return(finnTabel)
}
