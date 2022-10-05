#' @export
cache_tutorials <- function() {
  folder <- system.file("tutorials/", package = "rlernen.de")
  rmds <- dir(folder, recursive = T, full.names = T, pattern = ".Rmd")
  lapply(rmds, rmarkdown::render)
}

#' @export
uncache_tutorials <- function() {
  folder <- system.file("tutorials/", package = "rlernen.de")
  system(paste0("rm -r ", folder, "/*/*_files"))
  system(paste0("rm -r ", folder, "/*/*_cache"))
  system(paste0("rm -r ", folder, "/*/*.html"))
}