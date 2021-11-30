## Sourcing visualize functions script
source("3_visualize/src/plot_timeseries.R")

## Visualize
p3_targets_list <- list(
  
  tar_target(
    p3_figure_1,
    plot_nwis_timeseries(p2_site_data_styled)
  ),
  
  tar_target(
    p3_figure_1_png,
    save_nwis_timeseries_plot(plot = p3_figure_1,
                              fileout = "3_visualize/out/figure_1.png",
                              width = 12, height = 7, units = 'in'),
    format = 'file'
  )
)