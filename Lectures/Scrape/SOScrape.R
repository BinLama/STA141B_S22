
getStatsExchange =
function(baseURL = "https://stats.stackexchange.com/questions?tab=newest&pagesize=50",
         con = getCurlHandle(followlocation = TRUE), maxNum = Inf)
{

    txt = getURLContent(baseURL, curl = con)
    doc = htmlParse(txt)

    ans = processResults(doc, con, baseURL)
    
    while(length(ans) < maxNum & length(nxt <- getNextPage(doc, baseURL)) ) {

        txt = getURLContent(nxt, curl = con)
        doc = htmlParse(txt)

        tmp = processResults(doc, con, baseURL)
        ans = append(ans, tmp)

    }

    ans
}


processResults =
    #
    # For now just do the minimal which is 
    #
    #
function(doc, con, baseURL)
{
    urls = getNodeSet(doc, "//div[starts-with(@id, 'question-summary') and @data-post-id]//h3/a[@class='s-link']/@href")
}


getNextPage =
function(doc, baseURL)
{
    nxt = getNodeSet(doc, "//a[@rel  = 'next']/@href")
    if(length(nxt) == 0)
        return(character())
    
    getRelativeURL(nxt[[1]], baseURL)
}

