

#' @Title Gallery Module UI
#'
#' @param id 
#' @param label 
#' @param gallery 
#'
#' @return tagList
#' @export
#'
#' @examples
galleryUI <- function(id, label = "Image Gallery") {
  
  ns <- NS(id)
  
  tagList(
    uiOutput(ns('gallery'))
  )
  
}



#' Gallery Module Server
#'
#' @param input 
#' @param output 
#' @param session 
#' @param images 
#' @param gallery 
#' @param ... 
#'
#' @importFrom tidyr separate
#' @importFrom dplyr rowwise mutate 
#' @importFrom lubridate ymd
#' @importFrom hashids encode hashid_settings
#' 
#' @return
#' @export
#'
#' @examples
gallery <- function(input, output, session, images, gallery = c('lightbox', 'photoswipe'), ...) {
  
  stopifnot(class(images) %in% c('character', 'data.frame'))
  
  print(images)
  
  # create df input if images is folder path
  if (is.character(class(images))) {
    img_files <<- list.files(images)
    images <- data.frame(src = img_files) %>%
      tidyr::separate(col = 'src', c('txt', 'date', 'time', 'msec'), sep = '_|\\.', remove = FALSE) %>%
      rowwise() %>%
      mutate(date = lubridate::ymd(date),
             uid = strtrim(digest::sha1(src), 5))
  }
  
  # render gallery
  glry <- do.call(paste0(gallery, '_gallery'), 
                  list(df = images,
                       gallery = gallery, # change later to have unique ids
                       display = TRUE))
  
  output$gallery <- renderUI(glry)
  
}