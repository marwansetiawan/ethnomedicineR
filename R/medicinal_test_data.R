#' Dataset Uji Coba untuk ethnomedicineR
#'
#' Dataset sintetis untuk menguji fungsi-fungsi dalam paket ethnomedicineR.
#' Berisi 20 informan, 25 spesies tanaman obat, 8 penyakit, dan 5 kategori
#' penggunaan.
#'
#' @format Data frame dengan 40 baris dan 7 kolom:
#' \describe{
#'   \item{informant}{ID informan (karakter)}
#'   \item{species}{Nama spesies tanaman obat (karakter)}
#'   \item{disease}{Nama penyakit (karakter)}
#'   \item{use_category}{Kategori penggunaan (karakter)}
#'   \item{plant_part}{Bagian tanaman yang digunakan (karakter)}
#'   \item{preparation}{Metode pengolahan (karakter)}
#'   \item{research_priority}{Target untuk ML/DL (0/1)}
#' }
#' @source Data sintetis buatan.
"medicinal_test_data"