## @knitr load_data
#' @title load_data
#' @description Load .blotter and .global environment from strategy. If do not
#'   exist, run strategy, save objects, and load.
#' @param symbols List of symbols strategy was executed against.
load_data <- function() {
  #' Check for the portfolio, account and env objects saved from the strategy run.
  #' If the files do not exist, run the strategy (which saves the objects), clear
  #' out the environment then load the saved data files.

  rqd_files_exist <-
    purrr::map_lgl(
      .x = c("instruments", "results"),
      .f = ~file.exists(here::here(glue::glue("./output/{.x}.RData")))
    )

  if (!all(rqd_files_exist)) {
    source(here::here("./code/04_strategy.R"))
  }

  load(here::here("./output/results.RData"), envir = .GlobalEnv)
  blotter::put.account(account, a)
  blotter::put.account(bh_account, abh)
  blotter::put.account(bm_account, abm)
  blotter::put.portfolio(portfolio, p)
  blotter::put.portfolio(bh_portfolio, pbh)
  blotter::put.portfolio(bm_portfolio, pbm)

  FinancialInstrument::loadInstruments(
    file_name = "instruments.RData",
    dir = here::here("./output")
  )

}
