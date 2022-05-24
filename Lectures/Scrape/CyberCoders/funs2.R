splitNodeByBr =
function(node, asText = FALSE)
{
    k = xmlChildren(node)
    k = k[ names(k) != "comment"]
    g = split(k, cumsum( names(k) == "br" ) )
    g = lapply(g, function(x) x[ names(x) != "br"])
    g = g[sapply(g, length) > 0 ]

    if(asText) 
        return(lapply(g, function(x) sapply(x, xmlValue, trim = TRUE)))

    g
}


getSections =
    # H4 followed by div
function(doc)
{
    divs = getNodeSet(doc, "//h4/following-sibling::div[1]")
    # Not guaranteed to work robust, but probably okay for use in this context.
    names(divs) = xpathSApply(doc, "//h4[following-sibling::div]", xmlValue)
    divs
}

