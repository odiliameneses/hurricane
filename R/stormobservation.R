#' storm_observation
#'
#' Taking the dataset `stormdata`, this function creates a subset of a specific hurricane and a single observation time for that hurricane.
#'
#' @param data must use stormdata
#' @param hurricane_id a string, Hurricane-year. The first character uppercase.
#' @param date_time a string, in yyyy-mm-dd hh:mm:ss format
#'
#' @return a data frame
#'
#' @examples
#' \dontrun{
#' storm_observation("Ike-2008","2008-09-13 12:00:00")
#' storm_observation("Katrina-2005","2005-08-29 12:00:00")}
#'
#'
#' @export

storm_observation <- function(data,hurricane_id="Katrina-2005", date_time ="2005-08-29 12:00:00"){
  data %>%
    dplyr::filter(storm_id == hurricane_id, date == date_time)
}


#' Data on all storms in the Atlantic basin from 1988 to 2015.
#'
#' The dataset is based on the Extended Best Tract dataset and it was manipulated for the assignment "Build a New Geom" - part of Johns Hopkins University & Cousera Course "Building Data Visualization Tools".
#'
#' @format A data frame with 35 472 rows and 9 variables
#' \describe{
#'   \item{storm_id}{name of the hurricane and year (e.g. Katrina-2005)}
#'   \item{date}{date and time of the record (e.g. 2008-09-13 12:00:00)}
#'   \item{latitude}{latitudeof the center of the hurricane}
#'   \item{longitude}{longitude of the center of the hurricane}
#'   \item{wind_speed}{intensity of the wind in knots (34, 50, 60)}
#'   \item{ne}{distance (in meters) from the center of the storm of any location that experienced x-knot winds in the Northeast quadrant}
#'   \item{se}{distance (in meters) from the center of the storm of any location that experienced x-knot winds in the Southeast quadrant}
#'   \item{sw}{distance (in meters) from the center of the storm of any location that experienced x-knot winds in the Southwest quadrant}
#'   \item{nw}{distance (in meters) from the center of the storm of any location that experienced x-knot winds in the Northwest quadrant}
#' }
#' @source \url{<http://rammb.cira.colostate.edu/research/tropical_cyclones/tc_extended_best_track_dataset/>}
#' @usage data("stormdata")
"stormdata"

