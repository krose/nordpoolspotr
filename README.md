Introduction
------------

Not much.. Just a single function package that wraps the NordPool Spot API.

The package is just a pet project and in early beta. Changes can happen, but I'm also very open for suggestions.

Check out how it works...

Installation
------------

Install the package using Hadley's devtools package.


    devtools::install_github("krose/nordpoolspotr")

Examples
--------

Here are a few examples of how to use the function.

``` r
# Load the package.
library(nordpoolspotr)

# Get the prices for tommorow.
np_prices("hourly", "EUR")
```

    ## # A tibble: 24 × 19
    ##              StartTime             EndTime Bergen   DK1   DK2    EE    FI
    ## *               <dttm>              <dttm>  <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1  2016-09-20 00:00:00 2016-09-20 01:00:00  23.99 24.79 25.01 25.01 25.01
    ## 2  2016-09-20 01:00:00 2016-09-20 02:00:00  23.95 24.83 24.83 24.83 24.83
    ## 3  2016-09-20 02:00:00 2016-09-20 03:00:00  23.11 23.51 23.51 23.51 23.51
    ## 4  2016-09-20 03:00:00 2016-09-20 04:00:00  23.06 23.06 23.54 23.54 23.54
    ## 5  2016-09-20 04:00:00 2016-09-20 05:00:00  23.08 23.44 24.02 24.02 24.02
    ## 6  2016-09-20 05:00:00 2016-09-20 06:00:00  23.94 25.24 25.86 25.86 25.86
    ## 7  2016-09-20 06:00:00 2016-09-20 07:00:00  23.97 32.73 32.73 34.51 34.51
    ## 8  2016-09-20 07:00:00 2016-09-20 08:00:00  24.57 42.96 42.96 42.00 42.00
    ## 9  2016-09-20 08:00:00 2016-09-20 09:00:00  24.60 43.88 43.88 43.88 43.88
    ## 10 2016-09-20 09:00:00 2016-09-20 10:00:00  24.36 43.25 43.25 43.25 43.25
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
    ## 1  2016-09-19 00:00:00 2016-09-19 01:00:00  21.98 24.56 24.56 24.56 24.56
    ## 2  2016-09-19 01:00:00 2016-09-19 02:00:00  21.85 24.15 24.15 24.15 24.15
    ## 3  2016-09-19 02:00:00 2016-09-19 03:00:00  21.83 23.78 23.78 23.78 23.78
    ## 4  2016-09-19 03:00:00 2016-09-19 04:00:00  21.83 22.44 23.00 23.00 23.00
    ## 5  2016-09-19 04:00:00 2016-09-19 05:00:00  21.76 22.05 23.69 23.69 23.69
    ## 6  2016-09-19 05:00:00 2016-09-19 06:00:00  21.95 23.91 26.20 26.20 26.20
    ## 7  2016-09-19 06:00:00 2016-09-19 07:00:00  21.87 36.06 33.77 35.05 35.05
    ## 8  2016-09-19 07:00:00 2016-09-19 08:00:00  22.56 42.31 42.31 42.31 42.31
    ## 9  2016-09-19 08:00:00 2016-09-19 09:00:00  23.56 44.60 44.60 44.60 44.60
    ## 10 2016-09-19 09:00:00 2016-09-19 10:00:00  24.49 43.91 43.91 43.91 43.91
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
    ## 1  2016-09-20 2016-09-20 01:00:00     SYS 24.12
    ## 2  2016-09-20 2016-09-20 01:00:00     SE1 25.01
    ## 3  2016-09-20 2016-09-20 01:00:00     SE2 25.01
    ## 4  2016-09-20 2016-09-20 01:00:00     SE3 25.01
    ## 5  2016-09-20 2016-09-20 01:00:00     SE4 25.01
    ## 6  2016-09-20 2016-09-20 01:00:00      FI 25.01
    ## 7  2016-09-20 2016-09-20 01:00:00     DK1 24.79
    ## 8  2016-09-20 2016-09-20 01:00:00     DK2 25.01
    ## 9  2016-09-20 2016-09-20 01:00:00    Oslo 23.99
    ## 10 2016-09-20 2016-09-20 01:00:00 Kr.sand 23.99
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
    ## 1  2016-09-20 00:00:00 2016-09-20 01:00:00 184.71 186.35
    ## 2  2016-09-20 01:00:00 2016-09-20 02:00:00 185.01 185.01
    ## 3  2016-09-20 02:00:00 2016-09-20 03:00:00 175.17 175.17
    ## 4  2016-09-20 03:00:00 2016-09-20 04:00:00 171.82 175.40
    ## 5  2016-09-20 04:00:00 2016-09-20 05:00:00 174.65 178.97
    ## 6  2016-09-20 05:00:00 2016-09-20 06:00:00 188.06 192.68
    ## 7  2016-09-20 06:00:00 2016-09-20 07:00:00 243.87 243.87
    ## 8  2016-09-20 07:00:00 2016-09-20 08:00:00 320.09 320.09
    ## 9  2016-09-20 08:00:00 2016-09-20 09:00:00 326.95 326.95
    ## 10 2016-09-20 09:00:00 2016-09-20 10:00:00 322.26 322.26
    ## # ... with 14 more rows
