#' Relative Importance (RI)
#'
#' Calculates the Relative Importance of medicinal plants based on the
#' number of use categories and the number of diseases treated.
#' RI = (NT + NP) / 2, where NT = number of use categories,
#' NP = number of diseases treated.
#'
#' @param data Data frame with columns 'species', 'use_category', 'disease'.
#' @return Data frame with species and RI values.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom magrittr %>%
#' @examples
#' data(medicinal_data)
#' RIs(medicinal_data)
#' @export
RIs <- function(data) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  if (!all(c("species", "use_category", "disease") %in% colnames(data))) {
    stop("Data must have columns: species, use_category, disease")
  }
  RI_data <- data %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      NT = dplyr::n_distinct(use_category),
      NP = dplyr::n_distinct(disease),
      RI = (NT + NP) / 2
    ) %>%
    dplyr::arrange(desc(RI))
  return(RI_data)
}