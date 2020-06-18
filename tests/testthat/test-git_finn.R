test_that("Finn codes has 9 digits", {

    ## Sagene / St. Hanshaugen / Majorstuen
    areas <- "https://www.finn.no/realestate/homes/search.html?filters=&location=0.20061&location=1.20061.20508&location=1.20061.20509&location=1.20061.20510"

    finnKode <- get_finn(areas)

    expect_equal(nchar(finnKode[1]), 9)
})
