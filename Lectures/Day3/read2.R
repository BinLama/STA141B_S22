readData =
function(filename, n = -1, text = readLines(filename, n))
{
    text = removeCommentLines(text)
    parts = strsplit(text, ";")

    nfixed = getFixedPart(parts)
    
    info = lapply(parts, function(x)  do.call(rbind,  strsplit(x[-(1:4)], "[=,]")))
    i = rep(seq(along = info), sapply(info, nrow))

    info = do.call(rbind, info)
    colnames(info) = c("mac", "signal", "channel", "devType")

    ans = cbind(nfixed[i, ], info)
    ans = as.data.frame(ans, stringsAsFactors = FALSE)
  
    convertTypes(ans)
}

removeCommentLines =
function(text)
{
    i = substring(text, 1, 1) == "#"
    text[ ! i ]
}

getFixedPart =
function(parts)
{
    fixed = t( sapply(parts, function(x)  substring(x[c(1, 3, 4)], c(3, 5, 8))) )

    nfixed = cbind(fixed[, -2], do.call(rbind, strsplit(fixed[,2], ",")))
    colnames(nfixed) = c("t", "degree", "x", "y", "z")
    nfixed
}

convertTypes =
function(ans)
{
    ans[c("mac", "channel")] = lapply(ans[c("mac", "channel")], factor)

    numericVars =  c("t", "x", "y", "z", "degree", "signal")
    ans[ numericVars ] = lapply( ans[ numericVars ], as.numeric)

    deviceTypes = c("1" = "fixed", "3" =  "mobile")
    ans$devType = factor( deviceTypes[ ans$devType ]  )

    ans$t = structure(ans$t/1000, class = c("POSIXct", "POSIXt"))

    ans
}
