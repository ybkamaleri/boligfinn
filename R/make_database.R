#' Create database
#' 
#' \itemize{
#'   \item \code{make_db()} create database from downloaded data with \link{finn}
#'   \item \code{read_db()} create connection to the database
#'   \item \code{path_db()} display the path of the database file \emph{boligfinn.sqlite}.
#' }
#' 
#' @param x Data table from \link{finn} function
#' @return An SQLite database
#' @import DBI
#' @name finn-database
NULL


#' @export
#' @section Create folder automatically:
#' This function will create a \strong{boligfinn} folder in the HOME directory
#' if it isn't there and create a \emph{boligfinn.sqlite} database.
#' 
#' @rdname finn-database
#' @param ... Extra arguments
make_db <- function(x, ...){

    ## Path to database
    dbPath <- path_db()

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



#' @export
#' @rdname finn-database
read_db <- function(){

    dbPath <- path_db()

    ## connect to database
    finnCon <- DBI::dbConnect(RSQLite::SQLite(), dbname = dbPath)

    DF <- DBI::dbGetQuery(finnCon, "SELECT * FROM finn")

    DBI::dbDisconnect(finnCon)

    data.table::setDT(DF)

    return(DF)
}



#' @export
#' @section Database file and path: 
#' This is standard and will be \code{~/boligfinn/boligfinn.sqlite}
#' @rdname finn-database
path_db <- function(){

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
