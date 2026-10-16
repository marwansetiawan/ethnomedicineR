#' Machine Learning Priority Index for Medicinal Plants
#'
#' Menggunakan Random Forest / XGBoost untuk memprediksi prioritas penelitian
#' tanaman berdasarkan indeks tradisional dan fitur tambahan.
#'
#' @param data Data frame dengan fitur (UV, FL, ICF, jumlah penyakit, status konservasi).
#' @param target Variabel target (misal: "research_priority" 0/1).
#' @param method "rf" (Random Forest) atau "xgb" (XGBoost).
#' @return Model object dan feature importance plot.
#' @importFrom caret train trainControl
#' @importFrom xgboost xgboost
#' @export
ethno_ml_priority <- function(data, target, method = "rf") {
  if (!requireNamespace("caret", quietly = TRUE)) {
    stop("Package 'caret' needed.", call. = FALSE)
  }
  
  # Pisahkan fitur dan target
  x <- data[, !names(data) %in% target]
  y <- data[, target]
  
  # Train model
  if (method == "rf") {
    model <- caret::train(x, y, method = "rf", trControl = caret::trainControl(method = "cv", number = 5))
  } else if (method == "xgb") {
    model <- caret::train(x, y, method = "xgbTree", trControl = caret::trainControl(method = "cv", number = 5))
  } else {
    stop("Method must be 'rf' or 'xgb'.")
  }
  
  return(model)
}