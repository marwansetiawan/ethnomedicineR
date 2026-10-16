#' Medicinal Use Value (MUV)
#'
#' Calculates the Medicinal Use Value per species, which combines the number
#' of medicinal uses and the number of informants who report them.
#' MUV = (sum of medicinal use reports) / (number of informants).
#'
#' @param data Data frame with columns 'informant', 'species', 'disease'.
#' @return Data frame with species and MUV values.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom magrittr %>%
#' @examples
#' data(medicinal_data)
#' MUVs(medicinal_data)
#' @export
MUVs <- function(data) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  if (!all(c("informant", "species", "disease") %in% colnames(data))) {
    stop("Data must have columns: informant, species, disease")
  }
  MUV_data <- data %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      total_medicinal_uses = dplyr::n(),
      informants = dplyr::n_distinct(informant),
      MUV = total_medicinal_uses / informants
    ) %>%
    dplyr::arrange(desc(MUV))
  return(MUV_data)
}