# ethnomedicineR <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/ethnomedicineR)](https://CRAN.R-project.org/package=ethnomedicineR)
[![R-CMD-check](https://github.com/marwansetiawan/ethnomedicineR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/marwansetiawan/ethnomedicineR/actions/workflows/R-CMD-check.yaml)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)
<!-- badges: end -->

## 💊 Accelerating Traditional Drug Discovery with Modern Computing

**`ethnomedicineR`** adalah toolkit R untuk analisis kuantitatif etnomedisin yang **menggabungkan indeks tradisional (UV, FL, ICF) dengan pendekatan komputasi modern**—terinspirasi oleh:

- 🧬 **Superkomputer Anton** dari D.E. Shaw Research (simulasi molekuler 100x lebih cepat)
- ⚛️ **Komputasi Kuantum** (RIKEN/IBM: simulasi protein 12.635 atom)
- 🧠 **AI Supercomputing** (NVIDIA DGX SuperPOD untuk penemuan obat)

Paket ini dirancang untuk membantu peneliti **menganalisis data etnomedisin secara lebih cepat, akurat, dan terintegrasi**—dari indeks dasar hingga prediksi AI dan visualisasi network pharmacology.

---

## ✨ Fitur Utama

| Fungsi | Deskripsi |
|--------|-----------|
| `UVs()` | Use Value (Phillips & Gentry) |
| `FLs()` | Fidelity Level (Friedman et al.) |
| `ICFs()` | Informant Consensus Factor (Trotter & Logan) |
| `ethno_parallel()` | **Komputasi paralel** untuk dataset besar (terinspirasi Anton/Frontier) |
| `ethno_ml_priority()` | **AI/ML** untuk memprediksi prioritas penelitian tanaman (terinspirasi NVIDIA DGX) |
| `ethno_network_plot()` | **Network pharmacology** (tanaman-senyawa-penyakit) terinspirasi quantum computing |

---

## 🔧 Instalasi

```r
# Dari CRAN (setelah rilis)
install.packages("ethnomedicineR")

# Dari GitHub (versi pengembangan)
devtools::install_github("marwansetiawan/ethnomedicineR")