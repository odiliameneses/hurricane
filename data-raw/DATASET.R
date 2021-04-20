## code to prepare `DATASET` dataset goes here



usethis::use_pipe(export = TRUE)

setwd("~/R/hurricane/data-raw")

ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                       4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)
ext_tracks_colnames <- c("storm_id", "storm_name", "month", "day",
                         "hour", "year", "latitude", "longitude",
                         "max_wind", "min_pressure", "rad_max_wind",
                         "eye_diameter", "pressure_1", "pressure_2",
                         paste("radius_34", c("ne", "se", "sw", "nw"), sep = "_"),
                         paste("radius_50", c("ne", "se", "sw", "nw"), sep = "_"),
                         paste("radius_64", c("ne", "se", "sw", "nw"), sep = "_"),
                         "storm_type", "distance_to_land", "final")

ext_tracks <- readr::read_fwf("_7ed6a595f3e1ac944ccbb1f07db4caae_hurricanes_data.zip",
                              readr::fwf_widths(ext_tracks_widths, ext_tracks_colnames), na = "-99")

#########################
stormdata <- ext_tracks %>%
  dplyr::mutate(
    storm_id = paste(
      stringr::str_to_title(storm_name),year,sep = "-"), #the same storm name can be used in different years, so this will allow for the unique identification of a storm
    date = as.POSIXct(paste0(year, "-", month, "-", day," ", hour,":00:00")),
    longitude = -longitude) %>% # negative values for locations in the Western hemisphere
  dplyr::select(storm_id, date, latitude, longitude, starts_with("radius")) %>%
  tidyr::pivot_longer(starts_with("radius"),names_to = "quadrant",values_to = "radius") %>%
  tidyr::separate(quadrant,into = c(NA,"wind_speed","quadrant") ,sep = "_") %>%
  tidyr::pivot_wider(names_from = "quadrant",values_from = "radius")

readr::write_csv(stormdata,"stormdata.csv")

save(stormdata, file = "~/R/hurricane/data-raw/stormdata.rda")

usethis::use_data(stormdata, overwrite = TRUE)

