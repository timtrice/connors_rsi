# Variables ----
init_date <- "2004-12-31"

start_date <- "2005-01-01"

end_date <- "2014-12-31"

init_equity <- 1e6

symbols <- c("IWM", "QQQ", "SPY", "TLT")

#' strategy settings
strategy <- "connors_rsi"
portfolio <- strategy
account <- strategy

#' Buy/Hold strategy settings.
#' Buy/hold same symbols for test period.
bh_portfolio <- "bh_portfolio"
bh_account <- bh_portfolio

#' Benchmark strategy
#' Buy/Hold of benchmark symbol for testing period.
benchmark <- "SPY" #' As of now can't figure out how to do ^GSPC (with the caret)
bm_portfolio <- "benchmark"
bm_account <- bm_portfolio
