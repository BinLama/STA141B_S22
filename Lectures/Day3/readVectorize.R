readData =
function(filename, ll = readLines(filename))    
{
    ll = removeComments(ll)

    parts = strsplit(ll, ";")

    nparts = sapply(parts, length) - 4

    fixed = sapply(parts, function(x) x[1:4])
    fixed = t(fixed)


    ddev = lapply(parts, function(x) x[-(1:4)])

    s1 = strsplit(unlist(ddev), "=")
    s2 = unlist(strsplit(unlist(s1), ","))

    b = matrix(s2, , 4, byrow = TRUE)

    #
    idx = rep(1:length(parts), nparts)
    ans = cbind(fixed[idx,], b)

    ans = as.data.frame(ans, stringsAsFactors = FALSE)
    names(ans) = c("t", "id", "pos", "degree", "mac", "signal", "channel", "type")

    ans$t = structure(as.numeric(substring(ans$t, 3))/1000, class = c("POSIXct", "POSIXt"))
    ans$id = substring(ans$id, 3)
    ans$degree = as.numeric(substring(ans$id, 8))  # XX


    pos = matrix(unlist(strsplit(substring(ans$pos, 5), ",")), , 3,  byrow = TRUE)
    ans2 = cbind(ans, pos)
    names(ans2)[9:11] = c("x", "y", "z")

    ans$signal = as.numeric(ans$signal)
    ans$channel = as.numeric(ans$channel)
    ans$type = factor(ifelse(ans$type == "1", "fixed", "mobile"))

    ans2
}

removeComments =
function(x)
{
    x[ substring(x, 1, 1) != "#" ]
}
