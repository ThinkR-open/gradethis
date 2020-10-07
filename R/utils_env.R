#' merge two environments in one
#'
#' @param e1 an R environment
#' @param e2 an R environment
#'
#' @details in case of name conflict e2 win
#' @return an environment
#' @export
#' @examples
#' e1 <- new.env()
#' e1$a <- "a from e1"
#' e2 <- new.env()
#' e2$a <- "a from e2"
#' e2$b <- "b from e2"
#' 
#' new <- merge_environments(e1 = e1, e2 = e2)
#' 
#' merge_environments(e1, e2)$a # "a from e2"
#' merge_environments(e2, e1)$a # "a from e1"
merge_environments <- function(e1,e2){
  as.environment(c(as.list(e1,all.names = TRUE),as.list(e2,all.names = TRUE)))
}
# merge_environments <- function(...){
#   envs <- unname(c(...))
#   as.environment(as.list(unlist(sapply(envs,as.list, all.names = TRUE))))
# }


