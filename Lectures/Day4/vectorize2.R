readData =
function(filename, ll = readLines(filename) )
{
    ll = removeComments(ll)

    # Split all the values on each line
    parts = strsplit(ll, "[;,=]")

    # Determine how many detected devices there are on each line
    # 10 elements for the fixed, and then 4 for each detected device
    nddev = (sapply(parts, length) - 10)/4

    # Arrange the detected devices into a 4 column matrix
    tmp = unlist(lapply(parts, `[`, -(1:10)))
    ddev = matrix(tmp, , 4, byrow = TRUE)    

    # Get the values of t, id, x, y, z and degree for each line
    #    fx = do.call(rbind, lapply(parts, `[`, c(2, 4, 6, 7, 8, 10)))
    # unlisting and creating a matrix is slightly faster than do.call(rbind, )
    fx = matrix(unlist( lapply(parts, `[`, c(2, 4, 6, 7, 8, 10))),  , 6, byrow = TRUE )

    # Repeat the fixed part for each line as many times as there are detected devices on that line.
    i = rep(seq(along.with = parts), nddev)
    as.data.frame(cbind(fx[i,], ddev), stringsAsFactors = FALSE)
     # post process time, make signal, x, y, z, degree, into numbers.    
}

removeComments =
function(txt)    
{
   txt[substring(txt, 1, 1 ) != "#"]
}
