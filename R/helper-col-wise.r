# Column-wise function
# Turn a function that operates on a vector into a function that operates column-wise on a data.frame
#
# \code{catcolwise} and \code{numcolwise} provide version that only operate
# on discrete and numeric variables respectively
# 
# @arguments function
# @arguments should the function with wrapped with \code{\link{failwith}(NA)} 
# @arguments function that tests columns for inclusion
# @alias catcolwise
# @alias numcolwise
colwise <- function(fun, .try = FALSE, .if = function(x) TRUE) {
  f <- if (.try) failwith(NA, fun) else fun
  function(df, ...) laply(Filter(.if, df), f, ...)  
}

catcolwise <- function(fun, .try = FALSE) {
  colwise(fun, .try = .try, .if = is.discrete)
}
numcolwise <- function(fun, .try = FALSE) {
  colwise(fun, .try = .try, .if = is.numeric)
}
