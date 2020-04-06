test_that("Path to database", {

  if (.Platform$OS.type == "windows"){
    dirLocal <- "C:/boligfinn"
  } else {
    dirLocal <- "~/boligfinn"
  }

  sti <- paste(dirLocal, "boligfinn.sqlite", sep = "/")
  expect_identical(get_db(), sti)
})
