read_cloudlow <- function(x) {
  cloudlow =list.files(x, pattern = "cloudlow", full = TRUE) #get all cloudlow.text so that I can extract the data
  require ('gtools') #rearrange the files in order 
  cloudlow = mixedsort (cloudlow)
  
  cloudlow_data = sapply(cloudlow, function(x) readLines(x)[8:31]) #extract data
  
  
  cloudlow_data = lapply(cloudlow_data, function(x) strsplit(x, ":\\s+")[[1]][2]) #get the data
  
  
  cloudlow_data = sapply(cloudlow_data, function(x) strsplit(x, "\\s+")) # get the data
  
  cloudlow_data = suppressWarnings(as.numeric(unlist(cloudlow_data))) # turn it to numeric
  
  
  NASAWeather = as.data.frame(cloudlow_data)# save as dataframe
}

read_cloudmid <- function(x) {
  cloudmid =list.files(x, pattern = "cloudmid", full = TRUE) #get all cloudmid.text so that I can extract the data
  require ('gtools')
  cloudmid = mixedsort (cloudmid)#rearrange the files in order 
  
  cloudmid_data = sapply(cloudmid, function(x) readLines(x)[8:31])#extract data
  
  
  cloudmid_data = lapply(cloudmid_data, function(x) strsplit(x, ":\\s+")[[1]][2])
  
  
  cloudmid_data = sapply(cloudmid_data, function(x) strsplit(x, "\\s+")) #get the data
  cloudmid_data = as.numeric(unlist(cloudmid_data)) # turn it to numeric
  
  
  NASAWeather = as.data.frame(cloudmid_data) # save as dataframe
}

read_ozone <- function(x) {
  ozone =list.files(x, pattern = "ozone", full = TRUE) #get all ozone.text so that I can extract the data
  
  require ('gtools')
  ozone = mixedsort (ozone) #rearrange the files in order
  
  ozone_data = sapply(ozone, function(x) readLines(x)[8:31])
  
  
  ozone_data = lapply(ozone_data, function(x) strsplit(x, ":\\s+")[[1]][2])

  
  ozone_data = sapply(ozone_data, function(x) strsplit(x, "\\s+")) #get the data
  ozone_data = as.numeric(unlist(ozone_data))  # turn it to numeric

  
  
  NASAWeather  = as.data.frame(ozone_data)  # save as dataframe
}
