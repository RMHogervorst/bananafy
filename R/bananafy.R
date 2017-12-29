#!/usr/bin/Rscript --vanilla
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1){
    stop("I think you forgot to input an image and output name? \n")
}

library(magick)
## Commandline version of add banana
#banana <- image_read("images/banana.gif") # this assumes you have a project with the folder /images/ inside.

#add_banana <- function(, offset = NULL, debug = FALSE){
offset <- NULL
debug <- FALSE
image_in <- magick::image_read(args[[1]])
banana <- image_read("../images/banana.gif") # 365w 360 h
image_info <- image_info(image_in)
if("gif" %in% image_info$format ){stop("gifs are to difficult for  me now")}
stopifnot(nrow(image_info)==1)
# scale banana to correct size:
# take smallest dimension.
target_height <- min(image_info$width, image_info$height)
# scale banana to 1/3 of the size
scaling <-  (target_height /3)
front <- image_scale(banana, scaling)
# place in lower right corner
# offset is width and hieight minus dimensions picutre?
scaled_dims <- image_info(front)
x_c <- image_info$width - scaled_dims$width
y_c <- image_info$height - scaled_dims$height
offset_value <- ifelse(is.null(offset), paste0("+",x_c,"+",y_c), offset)
if(debug) print(offset_value)
frames <- lapply(as.list(front), function(x) image_composite(image_in, x, offset = offset_value))

result <- image_animate(image_join(frames), fps = 10)
image_write(image = result, path = args[[2]])
