# gallerier

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of gallerier is to provide a simple way to include image galleries in Shiny Applications. Initialy this was just a [repository](https://github.com/mrjoh3/shiny-gallery-example) with some example code. Simple `lightbox` and `photoswipe` galleries are available as functions and shiny modules. Evample applications can be found in the `inst` folder  and a live version is available on [shinyapps](https://mrjoh3.shinyapps.io/shiny-gallery-example/).

The package is under heavy development. The `lightbox` gallery is fully functional but `photoswipe` does not yet work as expected. 

 
## Installation

You can install the latest version of gallerier from [Github](https://github.com/mrjoh3/gallerier) with:

``` r
devtools::install_github('mrjoh3/gallerier)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(gallerier)

images <- data.frame(src = list.files('www/img')) %>%
  tidyr::separate(col = 'src', c('txt', 'date', 'time', 'msec'), sep = '_|\\.', remove = FALSE) %>%
  rowwise() %>%
  mutate(date = lubridate::ymd(date),
         key = hashids::encode(1e3 + as.integer(msec), hashid_settings(salt = 'this is my salt')))
         
         
## simple lightbox
lightbox_gallery(images[sample(1:nrow(images), 12, replace = FALSE),], 'gallery', display = TRUE)

```

