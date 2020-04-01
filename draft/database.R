## Load data from Finn.no
library(boligfinn)

## Download search
finnHtml <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20507&location=1.20061.20511&location=1.20061.20508&location=1.20061.20509&location=1.20061.20531&ownership_type=3&price_collective_from=3400000&price_collective_to=5200000"

dt <- finn()
data.table::setDF(dt)

## Create database
## ---------------
library(DBI)

## Create database
dbName <- "finn.sqlite"
finnCon <- dbConnect(RSQLite::SQLite(), dbName)
## dbDisconnect(finnCon)
## unlink("finn.sqlite")

## Add data
DBI::dbWriteTable(finnCon, "finn", dt) #use overwrite or append

DBI::dbListTables(finnCon)

DF <- DBI::dbGetQuery(finnCon, "SELECT * FROM finn")

DBI::dbDisconnect(finnCon)

## From DB
library(data.table)
setDT(DF)
