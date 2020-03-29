test_that("Test boligfinn:::add_mil for 7 digits", {

    numDigit <- boligfinn::add_mil(75)

    expect_equal(numDigit, "7500000")
})
