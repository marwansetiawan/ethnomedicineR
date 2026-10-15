#' Fidelity Level (FL) for Ethnomedicine
#'
#' Calculates the Fidelity Level (FL) for medicinal plants for a specific
#' disease. Works with long-format data where disease names are values in
#' the 'disease' column.
#'
#' FL = (number of informants mentioning the species for a specific disease /
#' total number of informants mentioning the species for any disease) * 100.
#'
#' @param data Data frame with columns 'informant', 'species', 'disease'.
#' @param disease_name Character string specifying the disease to analyze.
#'
#' @return Data frame with species and FL values.
#'
#' @importFrom dplyr group_by summarize n_distinct filter mutate arrange desc
#' @importFrom magrittr %>%
#'
#' @examples
#' data(medicinal_test_data)
#' FLs(medicinal_test_data, "Malaria")
#'
#' @export
FLs <- function(data, disease_name) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  if (!requireNamespace("magrittr", quietly = TRUE)) {
    stop("Package 'magrittr' needed.", call. = FALSE)
  }

  required_cols <- c("informant", "species", "disease")
  if (!all(required_cols %in% colnames(data))) {
    stop("Data must have columns: informant, species, disease", call. = FALSE)
  }

  if (!disease_name %in% unique(data$disease)) {
    stop(paste("Disease", disease_name, "not found in data."), call. = FALSE)
  }

  # Total informan yang menyebut spesies untuk penyakit APAPUN
  total_by_species <- data %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      total_informants = dplyr::n_distinct(informant)
    )

  # Informan yang menyebut spesies untuk penyakit SPESIFIK
  specific_by_species <- data %>%
    dplyr::filter(disease == disease_name) %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      specific_informants = dplyr::n_distinct(informant)
    )

  # Gabungkan dan hitung FL
  FL_data <- dplyr::full_join(total_by_species, specific_by_species, by = "species") %>%
    dplyr::mutate(
      specific_informants = ifelse(is.na(specific_informants), 0, specific_informants),
      FL = (specific_informants / total_informants) * 100
    ) %>%
    dplyr::arrange(desc(FL))

  return(FL_data)
}
