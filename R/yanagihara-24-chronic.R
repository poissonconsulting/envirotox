#' Chronic Species Sensitivity Data as compiled by Yanagihara et al. (2024)
#' 
#' Chronic species sensitivity data from Envirotox as worked up by Yanagihara et al. (2024).
#' It is important to note that Yanagihara et al. (2024) 
#' exclude datasets with a bimodality coefficient (BC) > 0.555.
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
#' }
#' 
#' @name yanagihara_24_chronic
#' @docType data
#' @keywords datasets
#' @examples
#' 
#' head(yanagihara_24_chronic)
#' 
"yanagihara_24_chronic"
