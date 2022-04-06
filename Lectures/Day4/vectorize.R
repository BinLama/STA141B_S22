readData =
function(filename, ll = readLines(filename) )
{
    ll = removeComments(ll)

    parts = strsplit(ll, ";")

    ddevs = lapply(parts, `[`, -(1:4))
    nddev = sapply(ddevs, length)
    
    tmp = unlist(strsplit(unlist(ddevs), "[=,]"))
    ddev = matrix(tmp, , 4, byrow = TRUE)

    fixed = lapply(parts, `[`, 1:4)
    fx = matrix(unlist(strsplit(unlist(fixed), "[=,]")), , 10, byrow = TRUE)
    fx = fx[, c(2, 4, 6, 7, 8, 10)]

    i = rep(seq(along.with = parts), nddev)
    as.data.frame(cbind(fx[i,], ddev), stringsAsFactors = FALSE)
     # post process time, make signal, x, y, z, degree, into numbers.    
}

removeComments =
function(txt)    
{
   txt[substring(txt, 1, 1 ) != "#"]
}
