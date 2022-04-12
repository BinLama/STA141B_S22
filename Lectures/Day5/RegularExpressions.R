
ff = list.files("~/Data/NASAWeather", pattern = "txt")

# Get the variable name from the file
# get rid of the numbers and .txt extension

varName = gsub("[0-9]+.txt", "", ff)

table(varName)



# remove the TIME from the TIME   : date 00:00
ff = list.files("~/Data/NASAWeather", pattern = "txt", full.names = TRUE)
tm = sapply(ff, function(x)  readLines(x)[5])
tm[1]
"             TIME     : 16-JAN-1995 00:00" 
gsub("^.*TIME +: ", "", tm[1])

"16-JAN-1995 00:00"

tm2 = gsub("^.*TIME +: ", "", tm)
tm3 = as.POSIXct(strptime(tm2, "%d-%b-%Y %H:%M"))

range(tm3)
[1] "1995-01-16 PST" "2000-12-16 PST"



#
remove the W in the longitude values

lon = strsplit(sapply(ff, function(f) readLines(f, n = 6)[6]), " +")

gsub("[WE]$", "", lon[[1]])


d = read.table(ff[1], skip = 7, stringsAsFactor = FALSE)
lat = d[,1]
latv = as.numeric(gsub("[NS]$", "", lat))
w = grepl("S", lat)
latv[w] = -latv[w]


#########################
geolocation data
Consider a line

x = "t=1139692477303;id=00:02:2D:21:0F:33;pos=0.0,0.05,0.0;degree=130.5;00:14:bf:b1:97:8a=-43,2437000000,3;00:0f:a3:39:e1:c0=-52,2462000000,3;00:14:bf:3b:c7:c6=-62,2432000000,3;00:14:bf:b1:97:81=-58,2422000000,3;00:14:bf:b1:97:8d=-62,2442000000,3;00:14:bf:b1:97:90=-57,2427000000,3;00:0f:a3:39:e0:4b=-79,2462000000,3;00:0f:a3:39:e2:10=-88,2437000000,3;00:0f:a3:39:dd:cd=-64,2412000000,3;02:64:fb:68:52:e6=-87,2447000000,1;02:00:42:55:31:00=-85,2457000000,1"


strsplit(x, "[=,;]")[[1]]
strsplit(x, "=|,|;")[[1]]

versus

unlist(strsplit(unlist(strsplit( unlist(strsplit(x, ";")), ",")), "="))





StackOverflow User location
Find zip codes

#/Volumes/T5/Data/Macbook17/StackOverflow/

u = xmlParse("Users.xml")

i = grep("\\b[0-9]{5}(-[0-9]+)?\\b", u.loc, perl = TRUE)

+ \\b  - word boundary

Matches  "Earth, 12.978715,77.59165"

i = grep("(^|[[:space:]]+)[0-9]{5}(-[0-9]+)?([[:space:]]+|$)", u.loc, perl = TRUE)



u.about = xmlSApply(xmlRoot(u), xmlGetAttr, "AboutMe", NA)

u.about.words = unlist(xpathApply(htmlParse(u.about[[10]]), "//text()", xmlValue, trim = TRUE))





