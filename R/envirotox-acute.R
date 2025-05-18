#' Acute Species Sensitivity Datasets
#'
#' @format ## `envirotox_acute`
#' A data frame with 14,949 rows and 6 columns:
#' \describe{
#'  \item{Chemical}{Chemical name (chr)}
#'  \item{Conc}{Concentration of chemical in micrograms per litre (dbl).}
#'  \item{Species}{Species name (chr).}
#'  \item{Group}{Taxonomic group of species (chr).}
#'  \item{Yanagihara24}{Whether the dataset fits the criteria of Yanagihara et al. (2024) (flag).}
#'  \item{Iwasaki25}{Whether the dataset was included in Iwasaki et al. (2025) (flag).}
#' }
#' @source <https://envirotoxdatabase.org/>
#' @references
#' Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to choose for deriving a species sensitivity distribution? Implications from analysis of acute and chronic ecotoxicity data. Ecotoxicology and environmental safety 278: 116379. doi:10.1016/j.ecoenv.2024.116379.
#' 
#' Iwasaki, Y., and Yanagihara, M. 2025. Comparison of model-averaging and single-distribution approaches to estimating species sensitivity distributions and hazardous concentrations for 5% of species. Environmental Toxicology and Chemistry 44(3): 834–840. doi:10.1093/etojnl/vgae060.
#' @examples
#'
#' head(envirotox_acute)
#'
"envirotox_acute"
