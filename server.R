# This script contains the server logic for the UFO mapping Shiny app:

# Load needed packages:
library(data.table)
library(shiny)
library(ggmap)

# Load data:
ufo_data = data.table(read.csv('ufo_data.csv', header = T, stringsAsFactors = F))

# Define server logic:
shinyServer(function(input, output)
  {
  
  # Map object:
  output$plot1 = renderPlot({
    
    #####
    # CREATE MAP:
    
      # Get map of United States:
      # The specified longitude/latitude coordinates are roughly the geographic center
      # of the United States:
      map = ggmap(get_googlemap(center = c(longitude = -96.35, latitude = 39.5), zoom = 4, 
                                maptype = 'terrain'))
    
      # Limit 'ufo_data' to the dates specified by user:
      # Recall the month/day for all UFO sightings is artificially set to '12/31':
      # Thus, when searching for UFO sightings after a given date, all UFO sightings
      # from the relevant year will be included:
      # However, when searching for UFO sightings before a given date, the sightings
      # from that year will probably not be included because they all 'occurred' on 
      # the last day of the year:
      # Thus, for the upper limit of the date range, I need to increase the user input
      # year by 1:
      
        # Modify upper bound of user input date range:
        upper_bound_year = as.numeric(substr(as.character(input$dates[2]), 1, 4))
        new_upper_bound_year = upper_bound_year + 1
        new_upper_bound = paste0(new_upper_bound_year, substr(as.character(input$dates[2]), 5, 10))
        new_upper_bound = as.Date(new_upper_bound, '%Y-%m-%d')
    
      # Limit 'ufo_data' to relevant dates:
      rel_data = ufo_data[(date >= input$dates[1]) & (date < new_upper_bound)]
      
      # Add UFO sightings to map:
      map = map + geom_point(data = rel_data, aes(x = lon, y = lat), pch = 19, size = 2, 
                             col = 'red') + xlab('') + ylab('') + theme(axis.text.y = element_blank(), 
                                                                        axis.text.x = element_blank(), 
                                                                        axis.ticks = element_blank())
      
      # View map:
      map
          
                            }
                           )
  }
           )