#' Informant Consensus Factor (ICF)
#'
#' Measures consensus among informants for specific diseases.
#' ICF = (nur - nt) / (nur - 1)
#'
#' @param data Data frame with 'disease' and 'species' columns.
#' @return Data frame with ICF per disease.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom parallel detectCores makeCluster stopCluster
#' @importFrom doParallel registerDoParallel
#' @importFrom foreach foreach %dopar%
#' @export

ICFs <- function(data) {
  # Hitung nur (total use reports per disease) dan nt (number of species per disease)
  ICF_data <- data %>%
    dplyr::group_by(disease) %>%
    dplyr::summarize(
      nur = dplyr::n(),
      nt = dplyr::n_distinct(species),
      ICF = (nur - nt) / (nur - 1)
    ) %>%
    dplyr::arrange(desc(ICF))
  return(ICF_data)
}