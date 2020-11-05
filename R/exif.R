

#' @title Image Exif Extraction
#'
#' @param file charater string including path to file
#' @param exiftool default location of exiftool
#' @param opt character options sent to exiftool
#'
#' @return data.frame
#' @export
#'
#'
get_exif <- function(file, exiftool=NULL, opt = '-common') {
  
  if (is.null(exiftool) & grepl('window', Sys.getenv('OS'), ignore.case = TRUE)) {
    exiftool <- system.file('src/exiftool(-k).exe', package = 'gallerier')
  }
  
  exif <- system2(exiftool, args=c(opt, file), stdout = TRUE)
  exif <- lapply(strsplit(exif, '  : '),
                 trimws
  )
  
  if (exif[[1]] == "-- press RETURN --") exif[[1]] <- NULL
  
  df <- rbind.data.frame(unlist(exif)[ c(FALSE,TRUE) ], stringsAsFactors = FALSE)
  names(df) <- unlist(exif)[ c(TRUE,FALSE) ]
  
  df
  
}