#' My approach was to create a new Stat, following the explanations in
#' \url{https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html}."

StatHurricane <- ggplot2::ggproto("StatHurricane", ggplot2::Stat,

#' StatHurricane setup
#'
#' @import ggplot2
#'
#' @import geosphere
#'
#' @export
#'
#'
                                  compute_group = function(data, scales, scale_radii) {

                                    quadrant <- data[c("r_ne","r_se","r_sw","r_nw")]
                                    output<-list()
                                    for (i in 1:4){
                                      geosphere::destPoint(p = c(data$x,data$y),
                                                b = ((i-1)*90):(90*i),
                                                d = (quadrant[,i] * 1852 * scale_radii)) %>%
                                        tibble::as_tibble() %>%
                                        rbind(output)-> output
                                    }
                                    data <- data.frame(output)
                                    names(data) <- c("x", "y")
                                    data
                                  },
                                  required_aes = c("x", "y","r_ne","r_se","r_sw","r_nw")
)

#' geom_hurricane
#'
#' This function returns a wind radii chart.
#' You should provide a dataset for a specific hurricane and a single observation time for that hurricane using.
#'
#' @param mapping default
#' @param data default
#' @param geom default
#' @param position default
#' @param show.legend default
#' @param inherit.aes default
#' @param scale_radii allows the user to plot wind radii charts with the radii scaled back to a certain percent of the maximum radii
#' @param ... default
#'
#'
#'
#' @return a wind radii chart
#' @export
#'
#' @examples
#' \dontrun{
#' get_map("Louisiana", zoom = 6, maptype = "toner-background") %>%
#' ggmap(extent = "device") +
#' geom_hurricane(data = storm_observation,
#' aes(x = longitude, y = latitude,
#' r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
#' fill = wind_speed, color = wind_speed))
#' }

geom_hurricane <- function(mapping = NULL,
                           data = NULL,
                           geom = "polygon",
                           position = "identity",
                           show.legend = NA,
                           inherit.aes = TRUE,
                           scale_radii = 1,
                           ...)
{

  ggplot2::layer(
    stat = StatHurricane,
    data = data,
    mapping = mapping,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(scale_radii = scale_radii, ...)
  )
}
