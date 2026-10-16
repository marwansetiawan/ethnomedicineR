#' Cultural Importance Index (CI) for Ethnomedicine
#'
#' Calculates the Cultural Importance Index, which is the sum of use reports
#' per species divided by the number of informants.
#' CI = sum(UR) / N, where UR = use reports, N = number of informants.
#'
#' @param data Data frame with columns 'informant', 'species'.
#' @return Data frame with species and CI values.
#' @importFrom dplyr group_by summarize n_distinct arrange desc
#' @importFrom magrittr %>%
#' @examples
#' data(medicinal_data)
#' CIs_med(medicinal_data)
#' @export
CIs_med <- function(data) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' needed.", call. = FALSE)
  }
  if (!all(c("informant", "species") %in% colnames(data))) {
    stop("Data must have columns: informant, species")
  }
  N <- dplyr::n_distinct(data$informant)
  CI_data <- data %>%
    dplyr::group_by(species) %>%
    dplyr::summarize(
      UR = dplyr::n(),
      CI = UR / N
    ) %>%
    dplyr::arrange(desc(CI))
  return(CI_data)
}