#### Synopsis:
This project maps UFO sightings using publicly available data. Outputs are an R script and a (currently in progress) Shiny app.

#### Motivation:
This project exists to document some experimentation with web scraping, the ggmap mapping interface, and creating Shiny apps.

#### Dataset Details:
The UFO sightings are from "https://en.wikipedia.org/wiki/List_of_reported_UFO_sightings". I only include sightings in the contiguous United States from the 20th and 21st centuries. I also remove a few data points which don't play well with the mapping process. Finally, the given location for some of the sightings are quite general (for example, near a city or town) and so the latitude/longitude coordinates that are generated are only correct in a general sense.

#### Output Details:
The included R script (ufo_mapping.R) can be run out of the box and outputs a map graphic with points representing UFO sightings. The Shiny app is in progress.

#### License:
GNU General Public License

