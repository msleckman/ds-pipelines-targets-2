## Sourcing fetch functions script
source("1_fetch/src/get_nwis_data.R")

## Define vars for fetch target script
site_1 <- "01427207"
site_2 <- '01432160'
site_3 <- "01436690"
site_4 <- '01466500'
parameterCd <- '00010'
startDate <- "2014-05-01"
endDate <- "2015-05-01"
fetch_out_folder <- "1_fetch/out"

## Fetch and save downloaded nwis data info
p1_targets_list <- list(
  tar_target(
    p1_site_data_01427207_csv,
    download_nwis_data(site_num = site_1,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_1,".csv"))),
    format = "file"
  ),
  
  tar_target(
    p1_site_data_01432160_csv,
    download_nwis_data(site_num = site_2,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_2,".csv"))),
    format = "file"
  ),
  
  tar_target(
    p1_site_data_01436690_csv,
    download_nwis_data(site_num = site_3,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_3,".csv"))),
    format = "file"
  ),
  
  tar_target(
    p1_site_data_01466500_csv,
    download_nwis_data(site_num =  site_4,
                       parameterCd = parameterCd,
                       startDate = startDate,
                       endDate = endDate,
                       fileout = file.path(fetch_out_folder,paste0('site_',site_4,".csv"))),
    format = "file"
  ),
  
  tar_target(
    p1_site_data,
    combine_nwis_data(list(p1_site_data_01427207_csv,
                           p1_site_data_01432160_csv,
                           p1_site_data_01436690_csv,
                           p1_site_data_01466500_csv))
  ),
  
  tar_target(
    p1_site_info,
    nwis_site_info(data = p1_site_data)
  ),
  
  # NOTE: This will save the combined site_data locally. This can be disabled by commenting out the target 
  tar_target(
    p1_site_data_csv,
    save_nwis_data_csv(fileout = file.path(fetch_out_folder,"nwis_data.csv"),
                       data = p1_site_data),
    format = "file"
  )

)
