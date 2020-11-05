

#' @title Generate a Single Flip Card
#'
#' @param title character card title
#' @param subheading character card subheading
#' @param description character card description
#' @param img character filepath
#' @param img_alt character 
#' @param flip_axis character flip on X or Y plane, defaults to Y
#' @param id character unique id for card or grid of cards. This 
#' allows for muliple configurations on a single page
#' @param front taglist for more complex sides
#' @param back taglist for more complex sides
#' @param ... additional options passed to sass
#'
#' @import htmltools
#' @import sass
#' @import glue
#' @return
#' @export
#'
#' @examples
card <- function(title, 
                 subheading = NULL,
                 description = NULL, 
                 img = NULL, 
                 flip_axis= 'Y',
                 front = NULL, 
                 back = NULL, 
                 img_alt = NULL, 
                 id = 'flip-card',
                 sass_options = sass::sass_options(output_style = "compressed"), 
                 ...){
  
  defaults <- list(width = '300px',
                   height = '400px',
                   rotate = glue('rotate{flip_axis}(180deg)'))
  
  opts <- modifyList(defaults,
                     list(...)) 
  
  # check if css already exists (Need way to check if file has changed)
  css_file <- glue('www/{id}-card.css')
  if (!file.exists(css_file)) {
    
    dir.create('www', showWarnings = FALSE)
    
    # read css template and check for updates
    css_template <- file.path(system.file('css', package = 'gallerier'), 
                          "flipcard.scss") 
    
    style <- sass_layer(
      #defaults = NULL,
      declarations = list("width" = opts$width,
                          "height" = opts$height,
                          "flip" = opts$rotate),
      rules = sass_file(css_template)
    )
    
    # save css to file
    sass(
      style,
      output = css_file
    )
    
  }
  
  #htmltools::htmlDependencies(sas)
  
  if (is.null(front)){
    front <- div(class="flip-card-front",
                 img(src = img, alt = img_alt, style=glue("width:{opts$width};")),
                 h1(title),
                 span(subheading))
  }
  
  if (is.null(back)){
    back <- div(class="flip-card-back",
                p(description))
  }
  
  div(class="flip-card",
      includeCSS(css_file),
      div(class="flip-card-inner",
          front,
          back
          )
      )

          
          
}