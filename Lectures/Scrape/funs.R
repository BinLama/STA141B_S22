procAnswer =
function(node)
{
    ats = xmlAttrs(node)

    body = xpathSApply(node, ".//div[starts-with(@class, 's-prose')]", xmlValue)

    tm = getNodeSet(node, ".//time[@itemprop='dateCreated']/@datetime")[[1]]

    tmp = ats["itemprop"]
    isAcceptedAnswer = !is.na(tmp) & tmp == "acceptedAnswer"


    # User information
    # div class="user-info
    #
    #   user-action-time - edits and original
    #   <span itemprop="name">
    #   badgecount  - different types gold, silver, bronze.
    #   reputation score
    
    data.frame(id = ats["data-answerid"],
               parentId = ats["data-parentid"],
               acceptedAnswer = isAcceptedAnswer,
               creationDate = as.POSIXct(strptime(tm, "%Y-%m-%dT%H:%M:%S")),
               body = body)
}





procComment =
function(node)
{

}
