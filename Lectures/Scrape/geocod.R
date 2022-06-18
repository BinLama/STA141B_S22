library(RCurl)
library(RJSONIO)

u = "https://api.geocod.io/v1.7/"

GeocodKey = trimws(readLines("geocod.key", warn = FALSE))[1]

# https://www.geocod.io/docs/#geocoding

u = "https://api.geocod.io/v1.7/geocode"
j = getForm(u, q = "95616", api_key = GeocodKey)
a = fromJSON(j)


u2 = "https://api.geocod.io/v1.7/geocode"

addresses = '[ "95616", "94941"]'

addresses = '["1109 N Highland St, Arlington VA", "525 University Ave, Toronto, ON, Canada", "4410 S Highway 17 92, Casselberry FL", "15000 NE 24th Street, Redmond WA", "17015 Walnut Grove Drive, Morgan Hill CA"]'

j2 = postForm(paste0(u2, "?api_key=", GeocodKey),
              .opts = list(postfields = addresses,
                  httpheader = c('Content-type' = "application/json"),
                  verbose = TRUE))

fromJSON(j2)

#curl "https://api.geocod.io/v1.7/api_endpoint_here?api_key=YOUR_API_KEY"
