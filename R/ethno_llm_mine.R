#' LLM-Based Literature Mining for Ethnomedicine
#'
#' Uses a Large Language Model (LLM) via API to extract ethnomedicinal
#' information from scientific abstracts. Supports OpenAI-compatible APIs
#' (OpenAI, Ollama, Groq, etc.). Inspired by modern LLM-based drug discovery.
#'
#' @param query Character string. The search query (e.g., "medicinal plants malaria").
#' @param api_url Character string. API endpoint URL (default: Ollama local).
#' @param model Character string. Model name (default: "llama3").
#' @param max_results Integer. Maximum number of results (default: 5).
#'
#' @return A data frame with extracted information.
#'
#' @importFrom httr2 request req_body_json req_perform resp_body_json
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' \dontrun{
#'   # Requires Ollama running locally or API key
#'   result <- ethno_llm_mine("medicinal plants malaria")
#'   result
#' }
#'
#' @export
ethno_llm_mine <- function(query, 
                           api_url = "http://localhost:11434/api/generate",
                           model = "llama3",
                           max_results = 5) {
  if (!requireNamespace("httr2", quietly = TRUE)) {
    stop("Package 'httr2' needed. Please install it.", call. = FALSE)
  }
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' needed. Please install it.", call. = FALSE)
  }
  
  prompt <- paste0(
    "Extract ethnomedicinal information from this query: '", query, "'. ",
    "Return a JSON array with fields: species, disease, plant_part, preparation."
  )
  
  # Build request
  req <- httr2::request(api_url) |>
    httr2::req_body_json(list(
      model = model,
      prompt = prompt,
      stream = FALSE
    ))
  
  # Perform request with error handling
  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(e) {
      stop("API request failed: ", conditionMessage(e), call. = FALSE)
    }
  )
  
  # Parse response
  content <- httr2::resp_body_json(resp)
  
  result <- data.frame(
    query = query,
    response = content$response,
    model = model,
    timestamp = Sys.time(),
    stringsAsFactors = FALSE
  )
  
  return(result)
}