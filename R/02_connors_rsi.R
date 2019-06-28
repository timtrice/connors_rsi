# Libraries ----
library(quantstrat)
library(TTR)

source(here::here("./code/settings.R"))

# Settings ----
Sys.setenv(TZ = "UTC")

currency("USD")

getSymbols(
  Symbols = c(symbols, benchmark),
  src = "yahoo",
  index.class = "POSIXct",
  from = start_date,
  to = end_date,
  adjust = TRUE
)

stock(c(symbols, benchmark), currency = "USD", multiplier = 1)

#' Remove all strategies
rm.strat(portfolio)
rm.strat(bh_portfolio)
rm.strat(bm_portfolio)

#' Initiate all portfolios
initPortf(name = portfolio, symbols = symbols, initDate = init_date)
initPortf(name = bh_portfolio, symbols = symbols, initDate = init_date)
initPortf(name = bm_portfolio, symbols = symbols, initDate = init_date)

#' Initiate all accounts
initAcct(
  name = account,
  portfolios = portfolio,
  initDate = init_date,
  initEq = init_equity
)

initAcct(
  name = bh_account,
  portfolios = bh_portfolio,
  initDate = init_date,
  initEq = init_equity
)

initAcct(
  name = bm_account,
  portfolios = bm_portfolio,
  initDate = init_date,
  initEq = init_equity
)

#' Initiate orders
initOrders(portfolio = portfolio, symbols = symbols, initDate = init_date)
initOrders(portfolio = bh_portfolio, symbols = symbols, initDate = init_date)
initOrders(portfolio = bm_portfolio, symbols = benchmark, initDate = init_date)

strategy(portfolio, store = TRUE)
strategy(bh_portfolio, store = TRUE)
strategy(bm_portfolio, store = TRUE)

# Indicators ----

# * RSI(2) ----
add.indicator(
  strategy  = strategy,
  name      = "RSI",
  arguments = list(
    price     = quote(getPrice(mktdata)),
    n         = 2,
    maType    = "SMA"
  ),
  label     = "RSI2"
)

# * SMA(5) ----
add.indicator(
  strategy  = strategy,
  name      = "SMA",
  arguments = list(
    x         = quote(Cl(mktdata)),
    n         = 5
  ),
  label     = "SMA5"
)

# * SMA(200) ----
add.indicator(
  strategy  = strategy,
  name      = "SMA",
  arguments = list(
    x         = quote(Cl(mktdata)),
    n         = 200
  ),
  label     = "SMA200"
)

# Signals ----

# * rsi2_lt_5 ----
add.signal(
  strategy  = strategy,
  name      = "sigThreshold",
  arguments = list(
    threshold    = 5,
    column       = "RSI2",
    relationship = "lt",
    cross        = FALSE
  ),
  label     = "rsi2_lt_5"
)

# * cl_gte_sma5 ----
add.signal(
  strategy  = strategy,
  name      = "sigCrossover",
  arguments = list(
    columns      = c("Close", "SMA5"),
    relationship = "gte"
  ),
  label     = "cl_gte_sma5"
)

# * cl_lt_sma200 ----
add.signal(
  strategy  = strategy,
  name      = "sigComparison",
  arguments = list(
    columns      = c("Close", "SMA200"),
    relationship = "lt"
  ),
  label     = "cl_lt_sma200"
)

# * bto ----
add.signal(
  strategy  = strategy,
  name      = "sigFormula",
  arguments = list(
    columns   = c("rsi2_lt_5", "cl_lt_sma200"),
    formula   = "rsi2_lt_5 == TRUE & cl_lt_sma200 == FALSE",
    label     = "trigger",
    cross     = TRUE
  ),
  label     = "bto"
)

# Rules ----

# * Enter ----
add.rule(
  strategy  = strategy,
  name      = "ruleSignal",
  arguments = list(
    sigcol    = "bto",
    sigval    = TRUE,
    orderqty  = 100,
    ordertype = "market",
    orderside = "long"
  ),
  type      = "enter"
)

# * Exit ----
add.rule(
  strategy  = strategy,
  name      = "ruleSignal",
  arguments = list(
    sigcol    = "cl_lt_sma200",
    sigval    = TRUE,
    orderqty  = "all",
    ordertype = "market",
    orderside = "long"
  ),
  type      = "exit"
)

# * Exit ----
add.rule(
  strategy  = strategy,
  name      = "ruleSignal",
  arguments = list(
    sigcol    = "cl_gte_sma5",
    sigval    = TRUE,
    orderqty  = "all",
    ordertype = "market",
    orderside = "long"
  ),
  type      = "exit"
)

# Apply Strategy ----
applyStrategy(strategy = strategy, portfolios = portfolio)

#' Add buy and hold transactions
#' buy
purrr::walk(
  .x = symbols,
  .f = ~addTxn(
    Portfolio = bh_portfolio,
    Symbol = .x,
    TxnDate = strftime(first(time(get(.x))), format = "%Y-%m-%d"),
    TxnQty = 100,
    TxnPrice = first(Ad(get(.x)))
  )
)

#' sell
purrr::walk(
  .x = symbols,
  .f = ~addTxn(
    Portfolio = bh_portfolio,
    Symbol = .x,
    TxnDate = strftime(last(time(get(.x))), format = "%Y-%m-%d"),
    TxnQty = -100,
    TxnPrice = last(Ad(get(.x)))
  )
)

#' Add benchmark transaction
#' buy
addTxn(
  Portfolio = bm_portfolio,
  Symbol = benchmark,
  TxnDate = strftime(first(time(get(benchmark))), format = "%Y-%m-%d"),
  TxnQty = 100,
  TxnPrice = first(Ad(get(benchmark)))
)

#' sell
addTxn(
  Portfolio = bm_portfolio,
  Symbol = benchmark,
  TxnDate = strftime(last(time(get(benchmark))), format = "%Y-%m-%d"),
  TxnQty = -100,
  TxnPrice = last(Ad(get(benchmark)))
)

# Update ----
#' ...portfolios
purrr::walk(.x = c(portfolio, bh_portfolio, bm_portfolio), .f = updatePortf)

#' ...accounts
purrr::walk(.x = c(account, bh_account, bm_account), .f = updateAcct)

#' ...ending equity
purrr::walk(.x = c(account, bh_account, bm_account), .f = updateEndEq)

## Save ----

#' Save Instruments from FinancialInstruments environment
saveInstruments(file_name = "instruments.RData", dir = here::here("./output"))

#' Save accounts
a <- getAccount(Account = account)
abh <- getAccount(Account = bh_account)
abm <- getAccount(Account = bm_account)

#' Save portfolios
p <- getPortfolio(Portfolio = portfolio)
pbh <- getPortfolio(Portfolio = bh_portfolio)
pbm <- getPortfolio(Portfolio = bm_portfolio)

save(list = ls(), file = here::here("./output/results.RData"))
