test_that("Path to database", {

    sti <- "~/boligfinn/boligfinn.sqlite"
    expect_identical(get_db(), sti)
})
