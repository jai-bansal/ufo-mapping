# This script contains the server logic for the UFO mapping Shiny app:

# Load needed packages:
library(shiny)

# Define server logic:
shinyServer(function(input, output)
  {
  
  # Map object:
  output$plot1 = renderPlot({
    
    # This script creates a map plot of UFO sightings in the 20th and 21st centuries in 
    # the contiguous United States according to the Wikipedia page for reported UFO sightings:
    # The site used is below:
    # https://en.wikipedia.org/wiki/List_of_reported_UFO_sightings
    
    # Load needed packages:
    library(rvest)
    library(data.table)
    library(ggmap)
    
    #####
    # SCRAPE DATA:
    # Scrape 2 tables, 1 containing 20th century UFO sightings, and the other containing
    # 21st century UFO sightings:
    
      # Specify webpage:
      page = html('https://en.wikipedia.org/wiki/List_of_reported_UFO_sightings')
    
      # Get relevant xpaths:
      xpath_20 = html_nodes(page, xpath = '//*[@id="mw-content-text"]/table[4]')
      xpath_21 = html_nodes(page, xpath = '//*[@id="mw-content-text"]/table[5]')
      
      # Get tables:
      # 'html_table' returns a list containing a data frame, so the data frame is extracted
      # using '[[1]]':
      ufo_sightings_20 = html_table(xpath_20, fill = T)[[1]]
      ufo_sightings_21 = html_table(xpath_21, fill = T)[[1]]
      
      # Combine tables:
      ufo_data = rbind(ufo_sightings_20, ufo_sightings_21)
      ufo_data = data.table(ufo_data)
      rm(page, xpath_20, xpath_21, ufo_sightings_20, ufo_sightings_21)
    
    #####
    # CLEAN/TRANSFORM DATA:
    
      # Rename problematically named 'City, State' column:
      # The comma can interfere with R operations:
      ufo_data$location = ufo_data$`City, State`
      ufo_data$location = tolower(ufo_data$`City, State`)
      ufo_data$`City, State` = NULL
    
      # Remove incidents from outside the contiguous United States:
    
        # Remove international incidents:
        ufo_data = ufo_data[Country == 'United States']
        
        # Remove Alaska incidents:
        ufo_data = ufo_data[grepl('alaska', ufo_data$location) == F]
        
        # Add latitude/longitude coordinates for each 'location':
        
        # Remove rows where 'location' trips up the process for finding coordinates:
        ufo_data = ufo_data[!(location %in% c('', 'coast guard air station salem', 
                                              'vashon island, washington state', 
                                              'seen from agoura, california, and from aircraft flying over pacific ocean'))]
    
      # Get coordinates for each location:
      # This takes a little while:
      coordinates = data.table(geocode(ufo_data$location))
      ufo_data = cbind(ufo_data, coordinates)
      rm(coordinates)
      
      # Create 'date' column:
      # Data in the existing 'Date' column is inconsistent; the only date measurement
      # I can get for every incident is year:
      # I make the specific date for every sighting 'December 31st' for consistency:
      ufo_data$date = substr(ufo_data$Date, 1, 4)
      ufo_data$date = paste0('12-31-', ufo_data$date)
      ufo_data$date = as.Date(ufo_data$date, '%m-%d-%Y')
    
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
      map
          
                            }
                           )
  }
           )