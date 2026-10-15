#' Informant Agreement Ratio (IAR)
#'
#' Calculates the Informant Agreement Ratio per disease category.
#' IAR = (nur - nt) / (nur - 1), where nur = total use reports,
#' nt = number of species used.
#'
#' @param data Data frame with columns 'disease', 'species'.
#' @return Data frame with disease and IAR values.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom magrittr %>%
#' @examples
#' data(medicinal_data)
#' IARs(medicinal_data)
#' @export
IARs <- function(data) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  if (!all(c("disease", "species") %in% colnames(data))) {
    stop("Data must have columns: disease, species")
  }
  IAR_data <- data %>%
    dplyr::group_by(disease) %>%
    dplyr::summarize(
      nur = dplyr::n(),
      nt = dplyr::n_distinct(species),
      IAR = ifelse(nur > 1, (nur - nt) / (nur - 1), NA)
    ) %>%
    dplyr::arrange(desc(IAR))
  return(IAR_data)
}