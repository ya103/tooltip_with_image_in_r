# Download pokemon images from the web

source("functions.R")

# Settings ----------------------------------------------------------------

# Load a package
load_pkgs("tidyverse")

ids <- c(152:160)  # only the 2nd generation Gosankes
url_dir <- "https://github.com/PokeAPI/pokeapi/raw/master/data/Pokemon_XY_Sprites/"
dir_downloaded <- "../imgs/"
img_names <- str_c(ids, ".png")

# Download ----------------------------------------------------------------

img_names %>%
    walk_progress(download_img, url_dir)
