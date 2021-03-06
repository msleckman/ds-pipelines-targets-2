download_nwis_data <- function(site_num, parameterCd, startDate, endDate, fileout){

  data_out <- readNWISdata(sites = site_num, parameterCd = parameterCd, startDate = startDate, endDate = endDate, service="iv")
  
  # -- simulating a failure-prone web-service here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  
  # CHANGE: added a write csv to get file 
  write_csv(data_out, fileout)
  
  # CHANGE: returns file path vs object previously
  return(fileout)

}

## Combine nwis datasets 
combine_nwis_data <- function(downloaded_data_list){
  
  data_out <- data.frame()
  
  # CHANGE: loop through individual downloaded files to read in and combine
  for (downloaded_data in downloaded_data_list){
    
    # Read the downloaded data and append it to the existing data.frame
    site_data <- read_csv(downloaded_data, col_types = 'ccTdcc')
    
    data_out <- dplyr::bind_rows(data_out, site_data)
    
  }
  
  return(data_out)
  
}

## Save the full downloaded dataset if desired  
save_nwis_data_csv <- function(data, fileout = "1_fetch/out/nwis_data.csv"){
  write_csv(data, fileout)
  return(fileout)
}

## Export selected site info from nwis
nwis_site_info <- function(data){
  site_no <- unique(data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  
  # CHANGE: Returns the object now, versus the file path to the file
  return(site_info)
  
}

