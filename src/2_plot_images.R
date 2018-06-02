# Plot images

source("functions.R")

# Settings ----------------------------------------------------------------

# Load packages
pkgs <- c("tidyverse", "rbokeh", "htmlwidgets")
load_pkgs(pkgs)

# URL settings
url <- "https://raw.githubusercontent.com/phalt/pokeapi/master/data/v2/csv/pokemon.csv"

# Figure settings
fig_width <- 400
fig_height <- 400

# Create the saved directory
path_html <- "../html/"
dir.create(path_html, showWarnings = FALSE)

# Set the 'imgs/' directory
dir_imgs <- 
  str_c("file://", getwd()) %>%
  str_replace("src", "imgs/")

# Format data -------------------------------------------------------------

dat <- 
  read_csv(url) %>%  # read from the web page
  filter(id %in% c(152:160)) %>%  # only show the 2nd generation Gosankes
  mutate(img_path = str_c(dir_imgs, id, ".png"))

# Plot & Save -------------------------------------------------------------

p1 <- figure(width = fig_width, height = fig_height) %>%
  ly_points(weight, height, dat, lname = "points", 
            hover = "<div><div><img src=\"@img_path\"></div>")
p2 <- figure(width = fig_width, height = fig_height) %>%
  ly_points(base_experience, height, dat, lname = "points", 
            hover = "<div><div><img src=\"@img_path\"></div>")
p <- grid_plot(list(p1, p2), same_axes = c(FALSE, TRUE), link_data = TRUE)

saveWidget(p, str_c(path_html, "plot.html"))
