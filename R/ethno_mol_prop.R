#' Molecular Property Prediction for Medicinal Compounds
#'
#' Calculates molecular properties (Lipinski's Rule of Five) for chemical
#' compounds using the PubChem API. Inspired by computer-aided drug design.
#'
#' @param compound_names Character vector. Names of chemical compounds.
#' @param verbose Logical. Print progress messages (default: FALSE).
#'
#' @return Data frame with molecular properties.
#'
#' @importFrom httr2 request req_perform resp_body_json
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' \donttest{
#'   # Requires internet connection
#'   result <- ethno_mol_prop(c("quercetin", "curcumin"))
#'   result
#' }
#'
#' @export
ethno_mol_prop <- function(compound_names, verbose = FALSE) {
  if (!requireNamespace("httr2", quietly = TRUE)) {
    stop("Package 'httr2' needed. Please install it.", call. = FALSE)
  }
  
  results <- data.frame(
    compound = character(),
    molecular_weight = numeric(),
    logP = numeric(),
    h_donors = integer(),
    h_acceptors = integer(),
    stringsAsFactors = FALSE
  )
  
  for (compound in compound_names) {
    if (verbose) message("Processing: ", compound)
    
    # Get CID from PubChem
    url <- paste0(
      "https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/",
      utils::URLencode(compound),
      "/property/MolecularWeight,XLogP,HBondDonorCount,HBondAcceptorCount/JSON"
    )
    
    resp <- tryCatch(
      httr2::request(url) |> httr2::req_perform(),
      error = function(e) NULL
    )
    
    if (is.null(resp)) {
      if (verbose) message("  Failed to fetch: ", compound)
      next
    }
    
    content <- tryCatch(
      httr2::resp_body_json(resp),
      error = function(e) NULL
    )
    
    if (is.null(content) || is.null(content$PropertyTable$Properties)) next
    
    props <- content$PropertyTable$Properties[[1]]
    
    results <- rbind(results, data.frame(
      compound = compound,
      molecular_weight = ifelse(is.null(props$MolecularWeight), NA, props$MolecularWeight),
      logP = ifelse(is.null(props$XLogP), NA, props$XLogP),
      h_donors = ifelse(is.null(props$HBondDonorCount), NA, props$HBondDonorCount),
      h_acceptors = ifelse(is.null(props$HBondAcceptorCount), NA, props$HBondAcceptorCount),
      stringsAsFactors = FALSE
    ))
  }
  
  # Apply Lipinski's Rule of Five
  if (nrow(results) > 0) {
    results$lipinski_pass <- with(results,
                                  molecular_weight <= 500 &
                                    logP <= 5 &
                                    h_donors <= 5 &
                                    h_acceptors <= 10
    )
  }
  
  return(results)
}