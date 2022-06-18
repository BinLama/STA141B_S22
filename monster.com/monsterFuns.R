library(RCurl)
library(RJSONIO)
MonsterQueryTemplate =
'{"jobQuery":{"query":"%s","locations":[{"country":"us","address":"","radius":{"unit":"mi","value":%d}}]},"jobAdsRequest":{"position":[1,2,3,4,5,6,7,8,9],"placement":{"component":"JSR_SPLIT_VIEW","appName":"monster"}},"fingerprintId":"254ceb345cfa1be165400078e73dc445","offset":%d,"pageSize":%d,"includeJobs":[]}'

monster =
function(q, radius = 3000, con = getCurlHandle( followlocation = TRUE, cookiejar = "", verbose = FALSE), maxNum = Inf, ...)
{

    tmp = monsterQuery(q, radius, offset = 0, con, ...)
    num = tmp$estimatedTotalSize
    if(num == 0) num = Inf #XXX
    ans = tmp$jobResults
    searchId = tmp$searchId

    offset = length(ans)    
    while(length(ans) < maxNum & length(ans) < num) {
        message(sprintf("%d of estimated %.0f", length(ans), as.numeric(num)))

        tmp = monsterQuery(q, radius, offset, con, searchId = searchId, ...)
        
        if(length(tmp$jobResults) == 0) {
            message("no additional results")
            break
        }
        
        ans = append(ans, tmp$jobResults)
        offset = length(ans)        
    }


    df = lapply(ans, procMonsterJob)
    nr = sapply(df, nrow)
    if(!all(nr == 1)) browser()
    
    invisible(do.call(rbind, df))
}

monsterQuery =
function(q, radius, offset,
         con = getCurlHandle( followlocation = TRUE, cookiejar = "", verbose = FALSE),
         body = MonsterQueryTemplate, searchId = NA, pageSize = 100,
         url = "https://appsapi.monster.io/jobs-svx-service/v2/monster/search-jobs/samsearch/en-US?apikey=ulBrClvGP6BGnOopklreIIPentd101O2")    
{
    body = sprintf(body, q, radius, offset, pageSize)

    if(!is.na(searchId)) {
        body = fromJSON(body)
        body[[6]] = searchId
        names(body)[6] = "searchId"
        body = toJSON(body)
    }

    
    tt = postForm(url, .opts = list(postfields = I(body),
                                  httpheader = c(Accept = "application/json",
                                                 'Content-Type' = "application/json; charset=utf-8",
                                                 referer = "https://www.monster.com/"
                                                 )),
                              curl = con, style = "POST")

    tmp = fromJSON(tt)

    tmp
}



procMonsterJob =
function(x)    
{
    #    addr = x$normalizedJobLocations[[1]]$postalAddress$address
    n = x$normalizedJobPosting
    addr = n$jobLocation[[1]]
    h = n$hiringOrganization
    data.frame(title = n$title,
               state = addr$address["addressRegion"],
               city = addr$address["addressLocality"],
               zip = addr$address["postalCode"],
               lat = addr$geo["latitude"],
               long = addr$geo["longitude"],
               industry = if("industry" %in% names(n)) n$industry else NA,
               occupation = n$occupationalCategory,
               createdDate = x$createdDate,
               postedDate = n$datePosted,
               fullURL = n$url,
               companyName = orNA(n$hiring[["name"]]), # ["name"]),
               numEmployees = numEmployees(h),
               whenFounded = if("foundingDate" %in% names(h)) orNA(h[["foundingDate"]]) else NA,
               employmentType = paste(n$employmentType, collapse = ";"),
               description = n$description,
               qualityScore = x$enrichments$qualityScores,
               row.names = NULL
               )
}

orNA =
function(x)
{
    if(is.null(x) || length(x) == 0)
        NA
    else
        unname(x)
}


numEmployees =
function(h)
{
    if(!("numberOfEmployees" %in% names(h)))
        return(NA)

    ne = h$numberOfEmployees
    if("unitText" %in% names(ne))
        return(ne["unitText"])

    if(all(c("minValue", "maxValue") %in% names(ne)))
        return(sprintf("between %d and %d", ne[["minValue"]], ne[["maxValue"]]))

    browser()
    return(NA)
}
