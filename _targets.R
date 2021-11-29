library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

## Define vars
site_1 <- "01427207"
site_2 <- '01432160'
site_3 <- "01436690"
site_4 <- '01466500'
parameterCd <- '00010'
startDate <- "2014-05-01"
endDate <- "2015-05-01"
fetch_out_folder <- "1_fetch/out"
process_out_folder <- '2_process/out'

## Fetch and save downloaded nwis data info
p1_targets_list <- list(
  tar_target(
    site_data_01427207_csv,
    download_nwis_data(site_num = site_1,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_1,".csv"))
                       ),
    
    ## Changed to file format
    format = "file"
  ),
  
  tar_target(
    site_data_01432160_csv,
    download_nwis_data(site_num = site_2,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_2,".csv"))),
    ## Changed to file format
    format = "file"
  ),

  tar_target(
    site_data_01436690_csv,
    download_nwis_data(site_num = site_3,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_3,".csv"))),
    ## Changed to file format
    format = "file"
  ),

  tar_target(
    site_data_01466500_csv,
    download_nwis_data(site_num =  site_4,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_4,".csv"))),
    ## Changed to file format
    format = "file"
  ),

  tar_target(
    site_data,
    combine_nwis_data(fetch_out_folder)
  ),
  
  ## changed to object format
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = file.path(fetch_out_folder, 'site_info.csv'),
                   data = site_data)
  ),

  # NOTE: This will save the combined site_data locally. This can be disabled by commenting out the target 
  tar_target(
    site_data_csv,
    save_nwis_data_csv(fileout = file.path(fetch_out_folder,"nwis_data.csv"),
                       data = site_data),
    format = "file"
  )
) 

## Process
p2_targets_list <- list(
  tar_target(
    site_data_clean, 
    process_data(site_data)
  ),
  
  tar_target(
    site_data_annotated,
    annotate_data(site_data_clean,
                  site_filename = site_info_csv)
  ),
  
  tar_target(
    site_data_styled,
    style_data(site_data_annotated)
  )
)

## Visualize

p3_targets_list <- list(
  tar_target(
    figure_1,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_styled),
  )
)

## Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
