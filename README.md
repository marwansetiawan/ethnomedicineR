# ethnomedicineR <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![R-CMD-check](https://img.shields.io/badge/R--CMD--check-passing-brightgreen.svg)]()
<!-- badges: end -->

## 💊 Accelerating Traditional Drug Discovery with Modern Computing

**`ethnomedicineR`** is a comprehensive R toolkit for quantitative ethnomedicine analysis and traditional drug discovery. It bridges traditional knowledge with modern high-performance computing approaches inspired by:

- 🧬 **Anton Supercomputer** (D.E. Shaw Research) for accelerated molecular simulations.
- ⚛️ **Quantum-Centric Supercomputing** (RIKEN/IBM) for complex molecular interaction mapping.
- 🧠 **NVIDIA DGX SuperPOD** for AI-driven drug discovery.

The package is designed to help researchers analyze ethnomedicinal data faster, more accurately, and with an integrated pipeline—from classic indices to deep learning predictions, network pharmacology, and interactive visualizations.

---

## ✨ Key Features

### 1. Core Ethnomedicine Indices
| Function | Description |
| :--- | :--- |
| `UVs()` | Use Value (Phillips & Gentry) |
| `FLs()` | Fidelity Level (Friedman et al.) |
| `ICFs()` | Informant Consensus Factor (Trotter & Logan) |
| `RIs()` | Relative Importance (Bennett & Prance) |
| `CIs_med()` | Cultural Importance Index (Tardío) |
| `MUVs()` | Medicinal Use Value (Silva et al.) |
| `IARs()` | Informant Agreement Ratio |
| `BEIs()` | Botanical Ethnoknowledge Index |

### 2. High-Performance & AI/ML
| Function | Description |
| :--- | :--- |
| `ethno_parallel()` | Parallel processing for large datasets (Anton-inspired) |
| `ethno_ml_priority()` | Machine Learning for plant prioritization (NVIDIA DGX-inspired) |
| `ethno_deep_priority()` | Deep Learning (Neural Network) priority prediction |
| `ethno_llm_mine()` | Literature mining using Large Language Models |
| `ethno_mol_prop()` | Molecular property prediction (PubChem API) |
| `ethno_admet()` | ADMET prediction (Rule-based drug-likeness) |

### 3. Network Pharmacology & Database Integration
| Function | Description |
| :--- | :--- |
| `ethno_network_plot()` | Static network visualization (ggplot2/ggraph) |
| `ethno_network_interactive()` | **Interactive VOSviewer-style network (visNetwork)** |
| `ethno_ppi_network()` | Protein-Protein Interaction network (STRING API) |
| `ethno_pathway_enrich()` | Pathway enrichment analysis (KEGG API) |
| `ethno_target_predict()` | Target prediction for compounds |
| `ethno_compound_target()` | Compound-Target-Disease network |
| `ethno_pubchem()` | Query chemical data from PubChem |
| `ethno_chembl()` | Query bioactivity data from ChEMBL |
| `ethno_kegg()` | Query pathways & diseases from KEGG |
| `ethno_npass()` | Query natural product activity from NPASS |

---

## 🎨 Visualization Showcase

`ethnomedicineR` provides publication-ready static plots and interactive graphs to explore complex ethnomedicinal data.

```r
library(ethnomedicineR)
data(medicinal_test_data)

# Generate an interactive VOSviewer-style network
ethno_network_interactive(medicinal_test_data)
