# install.packages('weatherData')
library(weatherData)

# set up data frame for weather data
w_set <- data.frame(date=as.Date(character()), TempHighC=numeric(), TempAvgC=numeric(), TempLowC=numeric(), Team=character())

# station_list, holding details of all weather centre codes for each team in league
station_list <- list(Barnsley="IHOYLAND2", 'Aston Villa'="IBIRMING24", Birmingham="IBIRMING24",
                     Newcastle="IGATESHE7", 'Norwich City'="INORWICH39", 'Derby'="IDERBY108", 
                     'Sheffield Wednesday'="ISHEFFIE50", 'Brighton & Hove Albion'="IBRIGHTO6",
                     'Fulham'="ILONDON278", 'Wolves'="IWOLVERH11", 'Leeds United'="ILEEDS30",
                     'QPR'="ILONDON876", 'Cardiff'="IWALESCA18", 'Nottm Forest'='INOTTING28',
                     'Reading'="IREADING14", 'Huddersfield'="IWESTYOR32", 'Ipswich'="IUNITEDK35",
                     'Bristol City'="IENGLAND726", 'Wigan Athletic'="IWIGAN6", 'Blackburn'="IENGLAND1080",
                     'Preston'="I90580303", 'Rotherham'="IROTHERH10", 'Burton Albion'="IBURTONO11", Brentford="ILONDON216")

# start and end date parameters
st_date <- "2016-08-01"
e_date <- "2017-06-01"

j=1

# loop through station list and utilise getSummarizedWeather function for each station, passing
# in the start and end dates as parameters, will get weather for each day between dates
for (i in station_list) {
  ds <- getSummarizedWeather(i, st_date, end_date = e_date,
                                       station_type = "ID", opt_temperature_columns = TRUE,
                                       opt_all_columns = FALSE, opt_custom_columns = FALSE,
                                       custom_columns = NULL, opt_verbose = FALSE)
  ds$team <- names(station_list[j])
  j=j+1
    
  w_set <- rbind(w_set,ds)
  rm(ds)
}

# creation of csv file for weather data set
write.csv(file="weather_dataset.csv", x=w_set)