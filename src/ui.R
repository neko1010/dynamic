ui = fluidPage(print("Hello, shiny world!"),

  ## Creating a map widget to be used as input in server.R file
  leafletOutput("mymap", height = 1000)


    
  )
