

#' @title Card Grid
#'
#' @param df 
#' @param width
#' @param height
#' @param id character unique id for card or grid of cards. This 
#' allows for muliple configurations on a single page
#' @param sass_options 
#' @param ... 
#' 
#' @import purrr
#' @import stringr
#' @import sass
#' @import htmltools
#'
#' @return
#' @export
#'
#' @examples
cards_grid <- function(df,
                       width,
                       height,
                       id = 'grid-cards',
                       sass_options = sass::sass_options(output_style = "compressed"), 
                       ...){
  
  if (missing(height)) {
    hn <- str_extract(width, "[[:digit:]]+") %>%
      as.numeric(.) * 1.33 
    height <- glue('{round(hn, 0)}px')
  }
  
  if (!('id' %in% colnames(df))) df$id <- 1:nrow(df)
  

  # check if css already exists (Need way to check if file has changed)
  css_file <- glue('www/{id}-grid.css')
  
  if (!file.exists(css_file)) {
    
    dir.create('www', showWarnings = FALSE)
    
    # read css template and check for updates
    css_template <- file.path(system.file('css', package = 'gallerier'), 
                          "grid_card.scss") 
    
    style <- sass_layer(
      #defaults = NULL,
      declarations = list("width" = width,
                          "height" = height),
      rules = sass_file(css_template)
    )
    
    # save css to file
    sass(
      style,
      output = css_file
    )
    
  }
  
  
  cards <- df %>%
      split(.$id) %>%
      map(~ card(.$title, description = .$description, img = .$img, id = id, width = width, height = height))
  
  
  div(class = 'cards',
      includeCSS(css_file),
      tagList(cards))
  
  
  
  
}