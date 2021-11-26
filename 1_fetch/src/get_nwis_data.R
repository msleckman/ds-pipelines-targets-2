download_nwis_data <- function(site_num, parameterCd, startDate, endDate){

  data_out <- readNWISdata(sites = site_num, parameterCd = parameterCd, startDate = startDate, endDate = endDate, service="iv")

  # -- simulating a failure-prone web-service here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
    
  return(data_out)
  
}

## Combine nwis datasets 
combine_nwis_data <- function(...){
  
  site_data <- bind_rows(...)
  
  return(site_data)
  
}

## Save the full downloaded dataset if desired  
save_nwis_data_csv <- function(Save_as_csv, data, fileout = "1_fetch/out/nwis_data.csv"){

  # Added in case user wants the save the data extracted from NWIS to local dir, Default is False for now
  if(Save_as_csv == TRUE){
    write_csv(data, fileout)
  }

  return(fileout)
}

## Export selected site info from nwis
nwis_site_info <- function(fileout, data){
  site_no <- unique(data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  write_csv(site_info, fileout)
  return(fileout)
}

