
lightbox_gallery <- function(df, gallery, display = 'block'){
  
  tags$div(style = sprintf('display: %s;', display),
           tagList(tags$head(
                     tags$link(rel = "stylesheet", type = "text/css", href = "lightbox-2.10.0/lightbox.min.css"),
                     tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
                   ),
                   tags$div(class = 'card-deck',
                            lapply(seq_len(nrow(df)), function(i){
                              tags$div(`data-type`="template", class = 'card',
                                       tags$a(id = df$key[i],
                                              href = paste0('img/', df$src[i]),
                                              `data-lightbox` = gallery, # this identifies gallery group
                                              `data-title` = df$date[i],
                                              tags$img(class = 'card-img-top',
                                                       src = paste0("img/", df$src[i]),
                                                       width = '80px',
                                                       height = 'auto'))
                                       )
                            })
                   ),
                   includeScript("www/lightbox-2.10.0/lightbox.min.js")
           ))
  
}