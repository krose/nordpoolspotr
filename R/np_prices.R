
#' Get the spot prices for a specified price_date.
#'
#' The function will return hourly, daily, weekly,
#' monthly or yearly spot prices. The hourly prices
#' are the prices the Nordic end users pay and the price
#' which the producers get. The daily,
#' weekly, monthly and yearly prices are base (mean over a period)
#' and not necessarily equal to the price the end user pays
#' or the price the producer gets, as the consumption and
#' production is not flat. Learn more at the website.
#'
#' @param time_unit The time unit to return the data in.
#' @param currency Price currency. EUR, NOK, DKK or SEK.
#' @param price_date Date class object. The default is for tomorrow.
#' @param areas A character vector with the areas you are interested in. Defaults to all.
#' @param long_data Boolean. Do you want the data returned as a long or wide data.frame?
#' @importFrom dplyr %>%
#' @export
#' @references \url{http://nordpoolspot.com/How-does-it-work/}
#' @examples
#'   # Get the prices for tommorow.
#'   np_prices("hourly", "EUR")
#'
#'   # Get the prices for today
#'   np_prices("hourly", "EUR", Sys.Date())
#'
#'   # Get a long data frame
#'   np_prices("hourly", "EUR", long_data = TRUE)
#'
#'   # Get only the Danish prices in DKK
#'   np_prices(time_unit = "hourly", currency = "DKK", areas = c("DK1", "DK2"))
np_prices <- function(time_unit = c("hourly", "daily", "weekly", "monthly", "yearly"),
                      currency = c("EUR", "NOK", "DKK", "SEK"),
                      price_date = Sys.Date() + lubridate::days(1),
                      areas = NULL,
                      long_data = FALSE){

  ## Checks and balances
  # is prices_date a date object
  # is time_unit one of the correct values
  # is currency one of the correct values
  if(!lubridate::is.Date(price_date)) stop("The price_date param needs to be an object of the class Date.")

  if(time_unit[1] == "hourly"){
    page <- 10
  } else if(time_unit[1] == "daily"){
    page <- 11
  } else if(time_unit[1] == "weekly"){
    page <- 12
  } else if(time_unit[1] == "monthly"){
    page <- 13
  } else if(time_unit[1] == "yearly"){
    page <- 14
  } else {stop("time_unit can only be one of the following: hourly, daily, weekly, monthly, yearly")}

  if(currency[1] != "EUR" & currency[1] != "DKK" & currency[1] != "NOK" & currency[1] != "SEK"){
    stop("time_unit can only be one of the following: hourly, daily, weekly, monthly, yearly")
  }

  ## Get the data.
  np <-
    httr::GET(paste0("http://www.nordpoolspot.com/api/marketdata/page/", page,
                     "?currency=", currency,
                     "&endDate=", paste(lubridate::day(price_date), lubridate::month(price_date), lubridate::year(price_date), sep = "-")))

  ## Get the content
  # The list is rather nasty and we need date, area and spot prices
  # from two places in the list. We'll create a data.frame with
  # the dates and then nest a list with the area name and spot
  # prices. The procedure is a two part proces. In the end the
  # nested lists will be unnested using tidyr.

  # subset until rows and get the start and end time.
  # The IsExtraRow variable is TRUE for summary data,
  # wich I'm not interested in.
  np_data <-
    np %>%
    httr::content() %>%
    .[["data"]] %>%
    .[["Rows"]] %>%
    purrr::map_df(`[`, c("StartTime", "EndTime", "IsExtraRow")) %>%
    # Insert a nested list with the name price list.
    # Subset until the rows data and
    # extract the Name (which is the area), Value (which is the spot price)
    # and IsAdditionalData.
    dplyr::mutate(price_lists = np %>%
                    httr::content() %>%
                    .[["data"]] %>%
                    .[["Rows"]] %>%
                    purrr::map("Columns") %>%
                    purrr::map(function(x){x %>%
                        purrr::map_df(`[`, c("Name", "Value", "IsAdditionalData")) %>%
                        dplyr::mutate(Value = as.numeric(stringr::str_replace(Value, ",", ".")))})) %>%
    # Unnest the data.frame with the nested list. This creates a long data.frame.
    tidyr::unnest() %>%
    dplyr::mutate(StartTime = lubridate::ymd_hms(StartTime, tz = "UTC"),
                  EndTime = lubridate::ymd_hms(EndTime, tz = "UTC")) %>%
    # Remove the unwanted summary data.
    dplyr::filter(!IsExtraRow) %>%
    dplyr::select(-IsExtraRow, -IsAdditionalData) %>%
    # Rename the variable Name to Areas as this is a better name.
    dplyr::rename(Areas = Name)

  # subset areas
  if(!is.null(areas)){
    np_data <-
      np_data %>%
      dplyr::filter(Areas %in% areas)
  }

  # Make data wide
  if(!long_data){
    np_data <-
      np_data %>%
      tidyr::spread(Areas, Value)
  }

  np_data
}


