#' Network Pharmacology Plot
#'
#' Membuat visualisasi network antara Tanaman, Senyawa, dan Penyakit.
#' Terinspirasi oleh pendekatan quantum-centric dalam penemuan obat.
#'
#' @param data Data frame dengan kolom 'species', 'compound', 'disease'.
#' @return Plot network interaktif (base R atau ggplot2).
#' @importFrom igraph graph_from_data_frame plot.igraph
#' @export
ethno_network_plot <- function(data) {
  if (!requireNamespace("igraph", quietly = TRUE)) {
    stop("Package 'igraph' needed.", call. = FALSE)
  }
  
  # Siapkan edges
  edges1 <- data[, c("species", "compound")]
  edges2 <- data[, c("compound", "disease")]
  edges <- rbind(edges1, edges2)
  colnames(edges) <- c("from", "to")
  
  # Buat graph
  g <- igraph::graph_from_data_frame(edges, directed = FALSE)
  
  # Plot
  plot(g, vertex.label.cex = 0.8, vertex.size = 15, 
       main = "Network: Plant-Compound-Disease (Quantum Inspired)")
}