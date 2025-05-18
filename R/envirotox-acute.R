#' Acute Species Sensitivity Datasetsb
#' 
#' Envirotox (Connors et al. 2019) acute species sensitivity datasets that 
#' include those of Yanagihara et al. (2024).
#' As far as we are aware the only difference is that the current datasets
#' also include those with a bimodality coefficient (BC) > 0.555 as well as
#' those that fail to converge with the BurrIII distribution.
#' 
#' The columns are as follows:
#' 
#' \describe{ 
#'\item{Chemical}{The chemical name (chr).}
#'\item{Conc}{The chemical concentration in micrograms per litre (dbl).}
#'\item{Species}{The species name (chr).}
#'\item{Type}{'Acute' (chr).}
#'\item{Group}{Acute (chr).}
#'\item{Original_CAS}{Original CAS (chr).} 
#'\item{BC}{Bimodality Coefficient for the Original CAS (chr).} 
#' }
#' @references
#' Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to choose for deriving a species sensitivity distribution? Implications from analysis of acute and chronic ecotoxicity data. Ecotoxicology and environmental safety 278: 116379. doi:10.1016/j.ecoenv.2024.116379.
#' 
#' Connors, K.A., Beasley, A., Barron, M.G., Belanger, S.E., Bonnell, M., Brill, J.L., de Zwart, D., Kienzler, A., Krailler, J., Otter, R., Phillips, J.L., and Embry, M.R. 2019. Creation of a Curated Aquatic Toxicology Database: EnviroTox. Enviro Toxic and Chemistry 38(5): 1062–1073. doi:10.1002/etc.4382.
#' @name envirotox_acute
#' @docType data
#' @keywords datasets
#' @examples
#' 
#' head(envirotox_acute)
#' 
"envirotox_acute"
