# This script sets up the user interface for the UFO mapping Shiny app:

# Load needed packages:
library(shiny)

# Define user interface:
shinyUI(fluidPage(
  
  # Title panel:
  titlePanel('UFO Mapping'),
  
  # Panels:
  sidebarLayout(position = 'right',
    
    # Filters panel:
    sidebarPanel(h4('Filters', align = 'center'),
    helpText('Choose date range for UFO sightings. The earliest (latest) sighting is in 1941 (2014).
             Dates are specified at the year level, so varying month and day within the same year does not change results.'),
    dateRangeInput('dates', label = h5('Dates'))
                ),
    
    # Map panel:
    mainPanel(h4('Map Panel', align = 'center'), 
              plotOutput('plot1')
             )
               )
  
))