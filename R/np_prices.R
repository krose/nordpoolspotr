
#' Get the spot prices for a specified price_date.
#'
#' @param time_unit The time unit to return the data in.
#' @param currency Price currency. EUR, NOK, DKK or SEK.
#' @param price_date Date class object.
#' @param areas Vector with listed areas.
#' @param long_data Boolean. Do you want the data returned as a long or wide data.frame?
#' @importFrom dplyr %>%
#' @export
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

  # Checks and balances
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


  np <-
    httr::GET(paste0("http://www.nordpoolspot.com/api/marketdata/page/", page,
                     "?currency=", currency,
                     "&endDate=", paste(lubridate::day(price_date), lubridate::month(price_date), lubridate::year(price_date), sep = "-")))

  np_data <-
    np %>%
    httr::content() %>%
    .[["data"]] %>%
    .[["Rows"]] %>%
    purrr::map_df(`[`, c("StartTime", "EndTime", "IsExtraRow")) %>%
    dplyr::mutate(price_lists = np %>%
                    httr::content() %>%
                    .[["data"]] %>%
                    .[["Rows"]] %>%
                    purrr::map("Columns") %>%
                    purrr::map(function(x){x %>%
                        purrr::map_df(`[`, c("Name", "Value", "IsAdditionalData")) %>%
                        dplyr::mutate(Value = as.numeric(stringr::str_replace(Value, ",", ".")))})) %>%
    tidyr::unnest() %>%
    dplyr::mutate(StartTime = lubridate::ymd_hms(StartTime, tz = "UTC"),
                  EndTime = lubridate::ymd_hms(EndTime, tz = "UTC")) %>%
    dplyr::filter(!IsExtraRow) %>%
    dplyr::select(-IsExtraRow, -IsAdditionalData) %>%
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


