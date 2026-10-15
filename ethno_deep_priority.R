#' Deep Learning Priority for Medicinal Plants
#'
#' Uses a neural network (via \pkg{nnet}) to predict which medicinal plants
#' are most promising for pharmacological research. Automatically handles
#' categorical columns by converting them to numeric (dummy encoding).
#'
#' @param data Data frame with columns 'species' and other features.
#' @param target Character string specifying the target column (binary 0/1).
#' @param hidden Integer specifying number of hidden units (default: 5).
#' @param maxit Integer specifying maximum iterations (default: 500).
#'
#' @return A list containing the fitted model and predictions.
#'
#' @importFrom stats complete.cases predict as.formula
#' @importFrom nnet nnet
#'
#' @examples
#' \donttest{
#'   data(medicinal_data)
#'   medicinal_data$priority <- sample(0:1, nrow(medicinal_data), replace = TRUE)
#'   result <- ethno_deep_priority(medicinal_data, target = "priority")
#'   head(result$predictions)
#' }
#'
#' @export
ethno_deep_priority <- function(data, target, hidden = 5, maxit = 500) {
  if (!requireNamespace("nnet", quietly = TRUE)) {
    stop("Package 'nnet' needed. Please install it.", call. = FALSE)
  }
  
  if (!target %in% colnames(data)) {
    stop(paste("Target column", target, "not found in data."), call. = FALSE)
  }
  
  # Separate species column (identifier)
  species_col <- if ("species" %in% colnames(data)) data$species else NULL
  
  # Exclude target and species from features
  feature_data <- data[, setdiff(colnames(data), c(target, "species")), drop = FALSE]
  
  # Convert character/factor columns to dummy variables
  numeric_cols <- sapply(feature_data, is.numeric)
  cat_cols <- colnames(feature_data)[!numeric_cols]
  
  if (length(cat_cols) > 0) {
    # Convert categorical to numeric using factor encoding
    for (col in cat_cols) {
      feature_data[[col]] <- as.numeric(as.factor(feature_data[[col]]))
    }
  }
  
  # Add target
  feature_data[[target]] <- data[[target]]
  
  # Clean data
  feature_data <- feature_data[stats::complete.cases(feature_data), ]
  
  # Rename columns (avoid special characters)
  colnames(feature_data) <- make.names(colnames(feature_data))
  
  # Get feature names (exclude target)
  feature_names <- setdiff(colnames(feature_data), make.names(target))
  target_name <- make.names(target)
  
  if (length(feature_names) == 0) {
    stop("No feature columns available after preprocessing.", call. = FALSE)
  }
  
  # Build formula
  formula_str <- paste(target_name, "~", paste(feature_names, collapse = " + "))
  formula_obj <- stats::as.formula(formula_str)
  
  # Fit neural network
  fit <- nnet::nnet(
    formula_obj,
    data = feature_data,
    size = hidden,
    maxit = maxit,
    trace = FALSE
  )
  
  # Predictions
  preds <- stats::predict(fit, feature_data, type = "raw")
  
  # Build result
  n_valid <- nrow(feature_data)
  species_out <- if (!is.null(species_col)) {
    species_col[stats::complete.cases(data[, setdiff(colnames(data), c(target, "species")), drop = FALSE])]
  } else {
    seq_len(n_valid)
  }
  
  result <- list(
    model = fit,
    predictions = data.frame(
      species = species_out[1:n_valid],
      priority_score = as.numeric(preds),
      stringsAsFactors = FALSE
    ),
    features_used = feature_names
  )
  
  return(result)
}