#!/usr/bin/Rscript --vanilla
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1){
    stop("I think you forgot to input an image and output name? \n")
}

### cmdline testing
## take only name and return a bananagif with that name
banana <- magick::image_read("../images/banana.gif")
message("writing a banana to: ", args[1])
magick::image_write(image = banana, path = args[1])
