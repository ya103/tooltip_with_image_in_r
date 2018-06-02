# Functions

load_pkgs <- function(pkgs) {
  
  load_pkg_without_devtools <- function(pkg) {
    is_installed <- pkg %in% installed.packages()[, "Package"]
    if (!is_installed) {
      install.packages(pkg, dependency = TRUE)
    }
    library(pkg, character.only = TRUE)
  }
  
  load_pkg <- function(pkg) {
    if (pkg == "rbokeh") {
      load_pkg_without_devtools("devtools")
      suppressMessages(devtools::install_github("hafen/rbokeh"))
      library(rbokeh)
    } else {
      load_pkg_without_devtools(pkg)
    }
  }
  
  invisible(sapply(pkgs, load_pkg))
}

download_img <- function(img_name, url_dir) {
  url <- str_c(url_dir, img_name)
  path_downloaded <- str_c(dir_downloaded, img_name)
  download.file(url, path_downloaded, quiet = TRUE)
}

# Please refer to the following URL:
# https://github.com/hadley/vis-eda/blob/master/progress.R
walk_progress <- function(.x, .f, ...) {
  names <- names(.x)
  name_width <- 30L
  
  format <- "[:bar] :percent ETA: :eta"
  if (!is.null(names)) {
    format <- paste0(format, " - :name")
  }
  
  p <- progress::progress_bar$new(
    total = length(.x),
    format = format
  )
  
  i <- 1
  .f <- purrr::as_mapper(.f, ...)
  pf <- function(...) {
    out <- .f(...)
    if (!is.null(names)) {
      p$tick(tokens = list(name = str_align(names[[i]], name_width)))
    } else {
      p$tick()
    }
    i <<- i + 1
    out
  }
  
  purrr::walk(.x, pf, ...)
  
}