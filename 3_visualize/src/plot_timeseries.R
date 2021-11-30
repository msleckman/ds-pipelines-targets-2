plot_nwis_timeseries <- function(site_data_styled){
  
  plt <- ggplot(data = site_data_styled, aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  
# CHANGE: Return plot so that target is an object
  return(plt)
  
}

# CHANGE: added new function to same plot - a file output in the targets pipeline
save_nwis_timeseries_plot <- function(plot_name, fileout, width = 12, height = 7, units = 'in'){
  
  ggsave(plot = plot_name, filename = fileout, width = width, height = height, units = units)
  return(fileout)
}