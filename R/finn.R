#' Create table from Finn search
#'
#' @param area Areas in Oslo to choose from
#'  1:Bygdøy/Frogner 2:Grünerløkka/Sofienberg 3:Sagene/Torshov
#'  4:St.Hanshaugen/Ullevål 5:Uranienborg/Majorstuen
#' @param pmin Minimum price
#' @param pmax Maximum price
#' @param add Other areas to choose from which isn't included in the default
#' @param ... Extra arguments
#'
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @export

finn <- function(area = 1:5, pmin = 3, pmax = 5, add = NULL, ...){

    ## stop warnings
    oldw <- getOption("warn")
    options(warn = -1)

    ## Get html
    finnHTML <- get_html(area = area, pmin = pmin, pmax = pmax, add = add)

    ## List of Finn codes for the specified parameters
    finnCodes <- get_finn(finnHTML)

    ## Set progress bar
    pb <- txtProgressBar(min = 0, max = length(finnCodes), style = 3)

    finnTabel <- list()

    for (i in 2:length(finnCodes)){

        ## Progress bar
        setTxtProgressBar(pb, i)

        ## Detail info for a selected flat
        aptCode <- get_flat(finnCodes[i])

        ## Address
        aptAdd <- get_add(aptCode)

        ## price
        aptPrice <- get_price(aptCode)

        ## Total price
        aptTotal <- get_total(aptCode)

        ## Monthly rent
        aptMonth <- get_month(aptCode)

        ## Common dept
        aptDebt <- get_debt(aptCode)

        ## type
        aptType <- get_type(aptCode)

        ## primary size (primaærom)
        aptPrim <- get_primary(aptCode)

        ## size (bruksareal)
        aptSize <- get_size(aptCode)

        ## balcony
        aptBalcony <- get_balcony(aptCode)

        ## ownership
        aptForm <- get_form(aptCode)

        ## postcode
        aptPost <- get_add(aptCode, postcode = TRUE)

        ## visit date
        aptVisit <- get_date(aptCode)

        ## status
        aptStatus <- get_status(aptCode)


        ## Create Table
        tempTab <- list(price = aptPrice,
                        total = aptTotal,
                        month = aptMonth,
                        debt = aptDebt,
                        type = aptType,
                        use_size = aptSize,
                        balcony = aptBalcony,
                        form = aptForm,
                        address = aptAdd,
                        postcode = aptPost,
                        visit = aptVisit,
                        status = aptStatus,
                        code = finnCodes[i],
                        date = as.Date(Sys.time()))

        finnTabel[[i]] <- tempTab
    }

    ## stop Progress bar
    close(pb)

    ## Create table
    finnTabel <- data.table::rbindlist(finnTabel, fill = TRUE)

    ## Activate warning as it is
    options(warn = oldw)

    return(finnTabel)
}
