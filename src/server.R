server = function(input, output, session){
 
  data = reactive({
    x = df
  })
  ## rendering the map widget created in the ui.R file
  output$mymap = renderLeaflet({
    ## piping some functions together
    
    ## reactive dataframe assigned to local object, df and passed to leaflet
    m = leaflet(data = df) %>%  ## creating map
      addTiles() %>%  ## adding open street map (default)
      
      
      ##Shiny magic- adding pop-up info from df and specific lat/lons
      addMarkers(lng = ~routes.longitude, lat = ~routes.latitude,
                 
          ## cluster markers https://rstudio.github.io/leaflet/markers.html
          clusterOptions = markerClusterOptions(),
                popup = paste("Route Name: ", df$routes.name, "<br>", ## "<br>" is \n i think
			       "Grade: ", df$routes.rating, "<br>",
			       "Type: ", df$routes.type, "<br>",
			       "Pitches :", df$routes.pitches, "<br>", 
			       "Wall: ", df$Wall, "<br>", 
			       "Crag: ", df$Crag, "<br>",
			       "Area: ", df$Area, "<br>",
			       "State/Province: ", df$State))
      
      #setView(lng=-114.4701, lat=42.5558, zoom = 10)  ##Twin Falls Yalls
    m
  })
}


