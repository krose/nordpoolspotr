Introduction
------------

Not much.. Just a single function package that wraps the NordPool Spot API.

The package is just a pet project and in early beta. Changes can happen and I'm also very open for suggestions. The project was inspired by the [Python](https://github.com/kipe/nordpool) library.

Check out how it works below...

### Known Issues

-   The function doesn't work when DST start or end.

<!-- -->

    # This won't work

    # DST ends
    np_prices("hourly", "EUR", as.Date("2016-10-30"))

    # DST starts
    np_prices("hourly", "EUR", as.Date("2017-03-26"))

Installation
------------

Install the package using Hadley's devtools package.


    devtools::install_github("krose/nordpoolspotr")

Examples
--------

Here are a few examples of how to use the function. All date values are returned with the timezone CET (as they are from the API).

``` r
# Load the package.
library(nordpoolspotr)

# Get the prices for tommorow (if they are published).
np_prices("hourly", "EUR")
```

    ## # A tibble: 24 × 19
    ##              StartTime             EndTime Bergen   DK1   DK2    EE    FI
    ## *               <dttm>              <dttm>  <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1  2017-04-19 00:00:00 2017-04-19 01:00:00  30.35 30.35 30.35 30.35 30.35
    ## 2  2017-04-19 01:00:00 2017-04-19 02:00:00  30.02 30.02 30.02 30.02 30.02
    ## 3  2017-04-19 02:00:00 2017-04-19 03:00:00  29.94 29.94 29.94 29.94 29.94
    ## 4  2017-04-19 03:00:00 2017-04-19 04:00:00  30.25 30.25 30.25 30.25 30.25
    ## 5  2017-04-19 04:00:00 2017-04-19 05:00:00  30.83 30.83 30.83 30.83 30.83
    ## 6  2017-04-19 05:00:00 2017-04-19 06:00:00  31.80 31.81 31.81 31.81 31.81
    ## 7  2017-04-19 06:00:00 2017-04-19 07:00:00  34.61 38.90 38.90 38.90 38.90
    ## 8  2017-04-19 07:00:00 2017-04-19 08:00:00  45.38 46.88 46.88 46.88 46.88
    ## 9  2017-04-19 08:00:00 2017-04-19 09:00:00  48.38 48.38 48.38 48.38 48.38
    ## 10 2017-04-19 09:00:00 2017-04-19 10:00:00  43.67 43.67 43.67 43.67 43.67
    ## # ... with 14 more rows, and 12 more variables: Kr.sand <dbl>, LT <dbl>,
    ## #   LV <dbl>, Molde <dbl>, Oslo <dbl>, SE1 <dbl>, SE2 <dbl>, SE3 <dbl>,
    ## #   SE4 <dbl>, SYS <dbl>, Tr.heim <dbl>, Tromsø <dbl>

``` r
# Get the prices for today
np_prices("hourly", "EUR", Sys.Date())
```

    ## # A tibble: 24 × 19
    ##              StartTime             EndTime Bergen   DK1   DK2    EE    FI
    ## *               <dttm>              <dttm>  <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1  2017-04-18 00:00:00 2017-04-18 01:00:00  29.05 29.05 29.05 29.05 29.05
    ## 2  2017-04-18 01:00:00 2017-04-18 02:00:00  28.36 28.36 28.36 28.36 28.36
    ## 3  2017-04-18 02:00:00 2017-04-18 03:00:00  27.77 27.77 27.77 27.77 27.77
    ## 4  2017-04-18 03:00:00 2017-04-18 04:00:00  27.62 27.26 27.26 27.26 27.26
    ## 5  2017-04-18 04:00:00 2017-04-18 05:00:00  27.94 26.97 27.94 27.94 27.94
    ## 6  2017-04-18 05:00:00 2017-04-18 06:00:00  29.94 30.91 29.94 29.94 29.94
    ## 7  2017-04-18 06:00:00 2017-04-18 07:00:00  33.01 33.01 33.01 39.92 39.92
    ## 8  2017-04-18 07:00:00 2017-04-18 08:00:00  38.17 42.31 42.31 42.31 42.31
    ## 9  2017-04-18 08:00:00 2017-04-18 09:00:00  45.39 45.39 45.39 45.39 45.39
    ## 10 2017-04-18 09:00:00 2017-04-18 10:00:00  41.05 41.05 41.05 41.05 41.05
    ## # ... with 14 more rows, and 12 more variables: Kr.sand <dbl>, LT <dbl>,
    ## #   LV <dbl>, Molde <dbl>, Oslo <dbl>, SE1 <dbl>, SE2 <dbl>, SE3 <dbl>,
    ## #   SE4 <dbl>, SYS <dbl>, Tr.heim <dbl>, Tromsø <dbl>

``` r
# Get a long data frame
np_prices("hourly", "EUR", long_data = TRUE)
```

    ## # A tibble: 408 × 4
    ##     StartTime             EndTime   Areas Value
    ##        <dttm>              <dttm>   <chr> <dbl>
    ## 1  2017-04-19 2017-04-19 01:00:00     SYS 29.32
    ## 2  2017-04-19 2017-04-19 01:00:00     SE1 30.35
    ## 3  2017-04-19 2017-04-19 01:00:00     SE2 30.35
    ## 4  2017-04-19 2017-04-19 01:00:00     SE3 30.35
    ## 5  2017-04-19 2017-04-19 01:00:00     SE4 30.35
    ## 6  2017-04-19 2017-04-19 01:00:00      FI 30.35
    ## 7  2017-04-19 2017-04-19 01:00:00     DK1 30.35
    ## 8  2017-04-19 2017-04-19 01:00:00     DK2 30.35
    ## 9  2017-04-19 2017-04-19 01:00:00    Oslo 30.35
    ## 10 2017-04-19 2017-04-19 01:00:00 Kr.sand 30.35
    ## # ... with 398 more rows

``` r
# Get only the Danish prices in DKK
np_prices(time_unit = "hourly", currency = "DKK", areas = c("DK1", "DK2"))
```

    ## Warning in eval(substitute(expr), envir, enclos): NAs introduced by
    ## coercion

    ## Warning in eval(substitute(expr), envir, enclos): NAs introduced by
    ## coercion

    ## Warning in eval(substitute(expr), envir, enclos): NAs introduced by
    ## coercion

    ## # A tibble: 24 × 4
    ##              StartTime             EndTime    DK1    DK2
    ## *               <dttm>              <dttm>  <dbl>  <dbl>
    ## 1  2017-04-19 00:00:00 2017-04-19 01:00:00 225.75 225.75
    ## 2  2017-04-19 01:00:00 2017-04-19 02:00:00 223.30 223.30
    ## 3  2017-04-19 02:00:00 2017-04-19 03:00:00 222.70 222.70
    ## 4  2017-04-19 03:00:00 2017-04-19 04:00:00 225.01 225.01
    ## 5  2017-04-19 04:00:00 2017-04-19 05:00:00 229.32 229.32
    ## 6  2017-04-19 05:00:00 2017-04-19 06:00:00 236.61 236.61
    ## 7  2017-04-19 06:00:00 2017-04-19 07:00:00 289.35 289.35
    ## 8  2017-04-19 07:00:00 2017-04-19 08:00:00 348.71 348.71
    ## 9  2017-04-19 08:00:00 2017-04-19 09:00:00 359.86 359.86
    ## 10 2017-04-19 09:00:00 2017-04-19 10:00:00 324.83 324.83
    ## # ... with 14 more rows
