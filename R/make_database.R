#' Create SQLite database
#'
#' This function will create a \strong{boligfinn} folder in the HOME directory
#' if it isn't there and create a \emph{boligfinn.sqlite} database.
#'
#' @param x Data table from \link{finn} function
#' @param ... Extra arguments
#'
#' @import DBI
#'
#' @export

make_db <- function(x, ...){

    ## Path to database
    dbPath <- get_db()

    ## Check if file exist
    fileOpt <- ifelse(isTRUE(fs::file_exists(dbPath)), 1, 0)

    finnCon <- DBI::dbConnect(RSQLite::SQLite(), dbname = dbPath)

    ## Add data
    if(fileOpt == 0){
        DBI::dbWriteTable(finnCon, "finn", x) #use overwrite or append
    } else {
        DBI::dbWriteTable(finnCon, "finn", x, append = TRUE) #use overwrite or append
    }

    DBI::dbDisconnect(finnCon)
}


#' Read database
#'
#' @export
read_db <- function(){

    dbPath <- get_db()

    ## connect to database
    finnCon <- DBI::dbConnect(RSQLite::SQLite(), dbname = dbPath)

    DF <- DBI::dbGetQuery(finnCon, "SELECT * FROM finn")

    DBI::dbDisconnect(finnCon)

    data.table::setDT(DF)

    return(DF)
}


#' Get database folder and name
#'
#' This is standard and will be \code{~/boligfinn/boligfinn.sqlite}
#'
#' @export
get_db <- function(){

  if (.Platform$OS.type == "windows"){
    dirLocal <- "C:/boligfinn"
  } else {
    dirLocal <- "~/boligfinn"
  }

  ## Check if folder exists
  if (isFALSE(fs::dir_exists(dirLocal))) fs::dir_create(dirLocal)
  ## Create database
  dbName <- "boligfinn.sqlite"
  dbPath <- paste(dirLocal, dbName, sep = "/")

  return(dbPath)
}
