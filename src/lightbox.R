
lightbox_gallery <- function(df, display = 'block'){
  
  tags$div(style = sprintf('display: %s;', display),
           tagList(h2('Image Gallery'),
                   includeCSS("www/lightbox.min.css"),
                   tags$div(class = 'card-deck',
                            lapply(seq_len(nrow(img_gal)), function(i){
                              tags$div(`data-type`="template", class = 'card',
                                       tags$a(id = img_gal$key[i],
                                              href = img_gal$url[i],
                                              `data-lightbox` = img_gal$geohash[i],
                                              `data-title` = img_gal$date[i],
                                              tags$img(class = 'card-img-top',
                                                       src = paste0("http://sp13intranet", img_gal$FileRef[i]),
                                                       width = '80px',
                                                       height = 'auto'),
                                              tags$h3(sprintf('%s - %s', img_gal$geohash[i], ymd(img_gal$date[i])))
                                       ))
                            })
                   ),
                   includeScript("www/lightbox.min.js")
           ))
  
}