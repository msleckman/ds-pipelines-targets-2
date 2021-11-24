download_nwis_data <- function(site_num, parameterCd = '00010', startDate = "2014-05-01", endDate = "2015-05-01"){
  
  data_out <- readNWISdata(sites = site_num, parameterCd = parameterCd, startDate = startDate, endDate = endDate, service="iv")
  
  # -- simulating a failure-prone web-service here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
    
  return(data_out)
  
}

## Combine nwis datasets and save the full dataset if desired  
combine_nwis_data <- function(..., Save_as_csv = F){
  
  site_data <- bind_rows(...)
  
  ## Added in case user wants the save the data extracted from NWIS to local dir, Default is False for now
  if(Save_as_csv == TRUE){
    dir <- getwd()
    file_path <- file.path(dir,"1_fetch/out","nwis_data.csv")
    print(file_path)
    write_csv(data_out, file_path)
    }
  return(site_data)
  
  }


## Export selected site info from nwis
nwis_site_info <- function(fileout, site_data){
  site_no <- unique(site_data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  write_csv(site_info, fileout)
  return(fileout)
}

