
library(tibble)
library(nordpoolspotr)

test_that("The verified data.frame from the 2017-04-17 is identical to a new call to the API.",
          {
            expect_equivalent(np_prices(time_unit = "hourly", currency = "EUR", price_date = as.Date("2017-04-17"), areas = c("DK1", "DK2")),
                              structure(list(StartTime = structure(c(1492380000, 1492383600,
                                                                     1492387200, 1492390800, 1492394400, 1492398000, 1492401600, 1492405200,
                                                                     1492408800, 1492412400, 1492416000, 1492419600, 1492423200, 1492426800,
                                                                     1492430400, 1492434000, 1492437600, 1492441200, 1492444800, 1492448400,
                                                                     1492452000, 1492455600, 1492459200, 1492462800),
                                                                   class = c("POSIXct", "POSIXt"), tzone = "CET"),
                                             EndTime = structure(c(1492383600, 1492387200, 1492390800, 1492394400, 1492398000, 1492401600, 1492405200,
                                                                   1492408800, 1492412400, 1492416000, 1492419600, 1492423200, 1492426800,
                                                                   1492430400, 1492434000, 1492437600, 1492441200, 1492444800, 1492448400,
                                                                   1492452000, 1492455600, 1492459200, 1492462800, 1492466400), class = c("POSIXct", "POSIXt"), tzone = "CET"),
                                             DK1 = c(28.5, 24.01, 22.07, 21.08, 27.67, 27.95, 28.21, 27.44, 29.9, 30.17, 29.6, 29, 28.33, 28.16, 27.89, 28, 28.05, 27.95, 25.36, 32.15, 31.49, 30.85, 29.79, 29.34),
                                             DK2 = c(29.21,24.01, 22.07, 21.08, 27.67, 27.95, 28.21, 27.94, 29.4, 30.17,29.6, 29.06, 28.33, 28.16, 27.89, 28, 28.05, 27.95, 28.21, 29.8,31.49, 30.85, 29.79, 29.34)),
                                        .Names = c("StartTime", "EndTime", "DK1", "DK2"),
                                        class = c("tbl_df", "tbl", "data.frame"),
                                        row.names = c(NA, 24L)))
          })


test_that("That the function will fail when DST ends.",
          {
            expect_error(np_prices(time_unit = "hourly", currency = "EUR", price_date = as.Date("2016-10-30")))
          })


test_that("That the column EndTime contains NAs when DST starts.",
          {
            expect_equal(all(!is.na(np_prices(time_unit = "hourly", currency = "EUR", price_date = as.Date("2017-03-26"))$EndTime)), FALSE)
          })

