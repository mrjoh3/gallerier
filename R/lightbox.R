

#' @title Create Lightbox Gallery
#' @param df data.frame containing
#' @param gallery character label identifying gallery
#' @param css character file path to css file. If missing default style is used
#' @param display character 
#'
#' @importFrom shiny tags includeScript includeCSS
#' @importFrom fs dir_copy
#' 
#' @return
#' @export
#'
#' @examples
lightbox_gallery <- function(df, gallery, css, display = 'block'){
  
  dir.create('www')
  
  if (missing(css)) {
    css <- file.path(system.file('css', package = 'gallerier'), 
                    "styles.css")
  }
  if (!(dir.exists('www/lightbox-2.10.0'))) {
    fs::dir_copy(system.file('js/lightbox-2.10.0', package = 'gallerier'), 
                 'www/lightbox-2.10.0')
  }
  
  # ensure all required columns exist in df
  #if (!('description' %in% colnames(df))) df$description <- NA
  if (!('uid' %in% colnames(df))) df$uid <- strtrim(digest::sha1(df$src), 5)
  
  tags$div(style = sprintf('display: %s;', display),
           tagList(tags$head(
                     tags$link(rel = "stylesheet", type = "text/css", href = "lightbox-2.10.0/lightbox.min.css")
                   ),
                   tags$div(class = 'card-deck',
                            lapply(seq_len(nrow(df)), function(i){
                              tags$div(`data-type`="template", class = 'card',
                                       tags$a(id = df$uid[i],
                                              href = paste0('img/', df$src[i]),
                                              `data-lightbox` = gallery, # this identifies gallery group
                                              `data-title` = glue_collapse(df[i,], sep = ' - '), # this is where complex title (glue) added
                                              tags$img(class = 'card-img-top',
                                                       src = paste0("img/", df$src[i]),
                                                       width = glue('{width}px'),
                                                       height = 'auto'))
                                       )
                            })
                   ),
                   includeScript("www/lightbox-2.10.0/lightbox.min.js"),
                   includeCSS(css)
           ))
  
}