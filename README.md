#### Synopsis:
This project maps UFO sightings using publicly available data.

#### Motivation:
This project exists to document some experimentation with web scraping and using the ggmap mapping interface.

#### Dataset Details:
The UFO sightings are from "https://en.wikipedia.org/wiki/List_of_reported_UFO_sightings". I only include sightings in the contiguous United States from the 20th and 21st centuries. I also remove a few data points which don't play well with the mapping process. Finally, the given location for some of the sightings are quite general (for example, near a city or town) and so the latitude/longitude coordinates that are generated are only correct in a general sense.

#### Running Scripts:
The included R script can be run out of the box and outputs a map graphic with points representing UFO sightings. Next on the to-do list is a Shiny app.

#### License:
GNU General Public License

