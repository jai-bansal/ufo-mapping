#### Synopsis:
This project is a Shiny app that maps UFO sightings using publicly available data. The app can be found at *https://jai-bansal.shinyapps.io/ufo-mapping*.

#### Motivation:
This project exists to document some experimentation with web scraping, using the ggmap mapping interface, and building a Shiny app.

#### Dataset Details:
The UFO sightings are from *https://en.wikipedia.org/wiki/List_of_reported_UFO_sightings*. I only include sightings in the contiguous United States from the 20th and 21st centuries. I also remove a few data points which don't play well with the mapping process. Finally, the given location for some of the sightings are quite general (for example, near a city or town) and so the latitude/longitude coordinates that are generated are only correct in a general sense.

#### Output:
The output is a Shiny app which can be viewed at the web address above. The app shows UFO sightings on a map in a date ranged specified by user input.

#### Files:
Server and ui files for the app are in the 'shiny_files' folder and are called 'server.R' and 'ui.R', respectively.

Data-related files are in the 'data_files' folder. The script used to scrape and process the data is 'ufo_data_scrape_and_process.R'. The resulting scraped and processed data is saved in 'ufo_data.csv'.

#### License:
GNU General Public License
