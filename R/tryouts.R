library(magick)

banana <- image_read("images/banana.gif")

earth <- image_scale(earth, "200")
length(earth)
image_composite(fig, image_scale(logo, "x150"), offset = NULL)


add_banana <- function(image, offset = NULL, debug = FALSE){
    image_in <- magick::image_read(image)
    banana <- image_read("images/banana.gif") # 365w 360 h
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

    # img <- image_composite(image = c(image_in,image_in,image_in,image_in,image_in,image_in,image_in,image_in ) ,
    #                        composite_image = image_scale(banana, scaling),
    #                        offset = offset)
    # result <- image_animate(image_join(img), fps = 10)
    result <- image_animate(image_join(frames), fps = 10)
    result
}

add_banana("images/ggplotexample.png") %>% image_write("images/ggplot.gif")
add_banana("images/hilaRious R packages.jpg") %>% image_write("images/r-pkg.gif")
add_banana("images/spss_for_losers.jpg") %>% image_write("images/spss.gif")
# image_extract_info <- function(image_in){
#     stopifnot(class(image_in)== "magick-image")
#     image_info(image_in)
# }

### example
logo <- image_read("images/ggplotexample.png")
background <- image_scale(logo, "400")

# Foreground image
#banana <- image_read(system.file("banana.gif", package = "magick"))
front <- image_scale(banana, "300")

# Combine and flatten frames
frames <- lapply(as.list(front), function(x) image_flatten(c(background, x)))

# Turn frames into animation
animation <- image_animate(image_join(frames))
