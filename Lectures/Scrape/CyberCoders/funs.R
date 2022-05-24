library(XML)
library(RCurl)

BaseURL = "https://www.cybercoders.com/search/"  # the final / is important.    

cyberCoders =
function(q, location = "",
         con = getCurlHandle(followlocation = TRUE, ssl.verifypeer = FALSE),
         maxNum = Inf)     
{
    tt = getForm(BaseURL, searchterms = q,
                 searchlocation = location, newsearch = "true", originalsearch = "true",
                 sorttype = "",
                 curl = con)

    doc = htmlParse(tt)
 
    ans = processJobs(doc, con)

    while(length(ans) < maxNum &&
          length(nxt <- getNextURL(doc)) > 0) {
              tt = getURLContent(nxt, curl = con)
              doc = htmlParse(tt)
              ans = c(ans, processJobs(doc, con))
    }
    
    do.call(rbind, ans)
    # ans
}

getNextURL =
function(doc)    
{
    nx = getNodeSet(doc, "//a[. = 'Next']/@href")
    if(length(nx) == 0)
       return(character())
       
    getRelativeURL(nx[[1]], BaseURL) 
}

processJobs =
function(doc, con)
{
  xpathApply(doc, "//div[@class = 'job-listing-item' and .//div[@class = 'job-title']]", processJobSummary, con)
}

processJobSummary =
function(node, con)
{
    a = getNodeSet(node, ".//div[@class='job-title']/a")

    full = getRelativeURL(xmlGetAttr(a[[1]], "href"), BaseURL)

    ans = data.frame(title = xmlValue(a[[1]]),
                     fullDescriptionURL = full,
                     date = xpathSApply(node, ".//div[starts-with(@class, 'job-posted')]/text()", xmlValue),
                     loc = xpathSApply(node, ".//div[@class='location']", xmlValue),
                     salary = xpathSApply(node, ".//div[@class='salary']", xmlValue),
                     salaryType = xpathSApply(node, ".//div[@class='salary-type']", xmlValue)
                     )

    skills = xpathSApply(node, ".//span[@class = 'skill-name']", xmlValue)
    ans$skills = list(skills)
    ans
}



procSalary =
function(x)
{
    isRange = grepl(" - ", x)

    low = high = rep(NA, length(x))

    els = strsplit(x[isRange], " - ")

    low[isRange] = convertDollarAmount(sapply(els, `[`, 1))
    high[isRange] = convertDollarAmount(sapply(els, `[`, 2))

    data.frame(low = low, high = high)
}

convertDollarAmount =
function(x)
{
    x = gsub("$", "", x, fixed = TRUE)
    as.integer(gsub("[Kk]$", "000", x))
    # Need to be more general for other cases.
}
