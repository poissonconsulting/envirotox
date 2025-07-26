#' Lists the datasets
#' 
#' Lists the names of the datasets in the package.
#'
#' @returns A character vector of the dataset names.
#' @export
#'
#' @examples
#' list_datasets()
list_datasets <- function() {
  data_info <- utils::data(package = "envirotox")$results
  data_info[, "Item"]
}
