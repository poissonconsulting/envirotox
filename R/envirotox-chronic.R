#' Chronic Species Sensitivity Datasets
#'
#' @format ## `envirotox_chronic`
#' A data frame with 1,721 rows and 6 columns:
#' \describe{
#'  \item{Chemical}{Chemical name (chr)}
#'  \item{Conc}{Concentration of chemical in micrograms per litre (dbl).}
#'  \item{Species}{Species name (chr).}
#'  \item{Group}{Taxonomic group of species (chr).}
#'  \item{Yanagihara24}{Whether the dataset fits the criteria of Yanagihara et al. (2024) (flag).}
#' }
#' @source <https://envirotoxdatabase.org/>
#' @references
#' Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to choose for deriving a species sensitivity distribution? Implications from analysis of acute and chronic ecotoxicity data. Ecotoxicology and environmental safety 278: 116379. doi:10.1016/j.ecoenv.2024.116379.
#' @examples
#'
#' head(envirotox_chronic)
#'
"envirotox_chronic"
