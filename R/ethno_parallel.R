#' High-Performance Parallel Processing for Ethnomedicine
#'
#' Mempercepat perhitungan indeks pada dataset besar menggunakan parallel
#' processing, terinspirasi oleh superkomputer Anton dan Frontier.
#'
#' @param data Data frame.
#' @param indices List of index functions to apply.
#' @param cores Number of cores to use (default: detectCores() - 1).
#' @return List of results.
#' @importFrom parallel detectCores makeCluster stopCluster
#' @importFrom doParallel registerDoParallel
#' @importFrom foreach foreach %dopar%
#' @export
ethno_parallel <- function(data, indices = list(UVs, FLs, ICFs), cores = NULL) {
  if (!requireNamespace("parallel", quietly = TRUE) ||
      !requireNamespace("doParallel", quietly = TRUE) ||
      !requireNamespace("foreach", quietly = TRUE)) {
    stop("Packages 'parallel', 'doParallel', and 'foreach' are required.")
  }
  
  if (is.null(cores)) {
    cores <- parallel::detectCores() - 1
    if (cores < 1) cores <- 1
  }
  
  cl <- parallel::makeCluster(cores)
  doParallel::registerDoParallel(cl)
  
  results <- foreach::foreach(i = 1:length(indices), .packages = c("dplyr", "ethnomedicineR")) %dopar% {
    func <- indices[[i]]
    func(data)
  }
  
  parallel::stopCluster(cl)
  names(results) <- names(indices)
  return(results)
}