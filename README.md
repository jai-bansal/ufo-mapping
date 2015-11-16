#### Synopsis:
This project is a Shiny app that maps UFO sightings using publicly available data.

#### Motivation:
This project exists to document some experimentation with web scraping, using the ggmap mapping interface, and building a Shiny app.

#### Dataset Details:
The UFO sightings are from "https://en.wikipedia.org/wiki/List_of_reported_UFO_sightings". I only include sightings in the contiguous United States from the 20th and 21st centuries. I also remove a few data points which don't play well with the mapping process. Finally, the given location for some of the sightings are quite general (for example, near a city or town) and so the latitude/longitude coordinates that are generated are only correct in a general sense.

#### Output:
The output is a Shiny app.

#### License:
GNU General Public License

