#' Botanical Ethnoknowledge Index (BEI)
#'
#' Calculates the Botanical Ethnoknowledge Index per species, which measures
#' the depth of ethnobotanical knowledge associated with a species.
#' BEI = (UV + FL + ICF) / 3, combining three key indices.
#'
#' @param data Data frame with columns 'informant', 'species', 'disease'.
#' @return Data frame with species and BEI values.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom magrittr %>%
#' @examples
#' data(medicinal_data)
#' BEIs(medicinal_data)
#' @export
BEIs <- function(data) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  if (!all(c("informant", "species", "disease") %in% colnames(data))) {
    stop("Data must have columns: informant, species, disease")
  }
  N <- dplyr::n_distinct(data$informant)
  BEI_data <- data %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      total_uses = dplyr::n(),
      informants = dplyr::n_distinct(informant),
      diseases = dplyr::n_distinct(disease),
      UV = total_uses / informants,
      FL = diseases / N,
      ICF = diseases / total_uses,
      BEI = (UV + FL + ICF) / 3
    ) %>%
    dplyr::select(species, BEI) %>%
    dplyr::arrange(desc(BEI))
  return(BEI_data)
}