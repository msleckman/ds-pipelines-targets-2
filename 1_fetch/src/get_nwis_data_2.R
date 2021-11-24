download_nwis_data_2 <- function(site_nums = c("01427207", "01432160", "01436690", "01466500"), Save_as_csv = TRUE){
  
  
  parameterCd <-  '00010'
  startDate <-"2014-05-01"
  endDate <- "2015-05-01"
  
  data_out <- data.frame()
  
  
  for(site_num in site_nums){
    
    download_file <- file.path(tempdir(), paste0('nwis_', site_num, '_data.csv'))
    print(site_num)
    
    data <- readNWISdata(sites=site_num, service="iv", parameterCd = parameterCd, startDate = startDate, endDate = endDate)

    print(nrow(data))
    print(data)
    print(head(data))
    
    # -- simulating a failure-prone web-service here, do not edit --
    set.seed(Sys.time())
    if (sample(c(T,F,F,F), 1)){
      stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
    }

    data_out <- bind_rows(data_out, data)
    print(nrow(data_out))
  }  
  
  print(nrow(data_out))  
  
  
  if(Save_as_csv == TRUE){
    dir <- getwd()
    file_path <- file.path(dir,"1_fetch/out","nwis_data.csv")
    print(file_path)
    write_csv(data_out, file_path)
  } 
  
  return(data_out)
  
}

data_out <- download_nwis_data_2()

nwis_site_info <- function(fileout, site_data){
  site_no <- unique(site_data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  write_csv(site_info, fileout)
  return(fileout)
}


nwis_site_info(data_out, "1_fetch/out/site_info_2.csv")


