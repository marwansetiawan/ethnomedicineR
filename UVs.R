#' Use Value (UV)
#'
#' Calculates the Use Value of medicinal plants.
#' UV = sum of use reports for a species / number of informants.
#'
#' @param data Data frame with columns 'informant', 'species', and use categories.
#' @return Data frame with species and UV values.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom magrittr %>%
#' @export
UVs <- function(data) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  
  UV_data <- data %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      total_uses = dplyr::n(),
      informants = dplyr::n_distinct(informant),
      UV = total_uses / informants
    ) %>%
    dplyr::arrange(desc(UV))
  
  return(UV_data)
}