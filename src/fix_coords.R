#########################
### Coordinate Fixing ###
#########################

# load in data used as bad_data object
bad_data <- sample_data
str(bad_data)

# load in shapefile of Idaho boundaries
library(rgdal)
id <- readOGR(dsn = "H:/WRWP_GIS/tl_2013_16_cousub", layer = "tl_2013_16_cousub")
id <- spTransform(id, CRS("+proj=longlat +datum=WGS84"))
id <- fortify(id)

# for every route, check that its longitude is within the range of longitudes of Idaho for its latitude,
                    #and that its latitude is within the range of latitudes of Idaho for its longitude.
violators<- bad_data[1,]
violators<- violators[!1,]

for(i in 1:nrow(bad_data)){
  ln <- bad_data[i,15]
  lt <- bad_data[i,16]
  ln_range <- id[which(between(id$long, lower = (ln - .1), upper = (ln + .1))),]
  lt_range <- id[which(between(id$lat, lower = (lt - .1), upper = (lt + .1))),]
  if(nrow(ln_range) == 0 | nrow(lt_range) == 0){
    violators <- rbind(violators, bad_data[i,])
  } else {
    if((ln < min(lt_range$long) | ln > max(lt_range$long)) | (lt < min(ln_range$lat) | lt > max(ln_range$lat))){
      violators <- rbind(violators, bad_data[i,])
    }
  }
}

#Check violators object- it contains all three wrong GPS'd routes, and two "Idaho" routes that are in Wyoming
View(violators)

# Look up actual GPS coordinates of each Crag for the outliers https://www.mountainproject.com/area/105708958/idaho
# Replace the coordinates for each outlier

# I've Got Gall
bad_data[133,16] <- 42.066
bad_data[133,15] <- -113.709

#Cowboy
bad_data[1421,16] <- 42.076
bad_data[1421,15] <- -113.722

#soul power
bad_data[1647,16] <- 43.258
bad_data[1647,15] <- -112.036


# check again
violators<- bad_data[1,]
violators<- violators[!1,]

for(i in 1:nrow(bad_data)){
  ln <- bad_data[i,15]
  lt <- bad_data[i,16]
  ln_range <- id[which(between(id$long, lower = (ln - .1), upper = (ln + .1))),]
  lt_range <- id[which(between(id$lat, lower = (lt - .1), upper = (lt + .1))),]
  if(nrow(ln_range) == 0 | nrow(lt_range) == 0){
    violators <- rbind(violators, bad_data[i,])
  } else {
    if((ln < min(lt_range$long) | ln > max(lt_range$long)) | (lt < min(ln_range$lat) | lt > max(ln_range$lat))){
      violators <- rbind(violators, bad_data[i,])
    }
  }
}

# violators should only contain 2 Darby Canyon routes
View(violators)

#re-enter bad_data into good_data, use this for creating app
good_data <- bad_data
saveRDS(good_data, "../data/good_data.rds")
