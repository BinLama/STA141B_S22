readData =
function(filename, text = readLines(filename))
{
    # remove any line starting with #
    i = substring(text, 1, 1) == "#"

    text = text[ ! i ]


    # Break each record by the ; which separates each of the fixed/meta elements
    # and each deteted device.
    parts = strsplit(text, ";")


    # Get the value after the = for each of the meta data elements t, pos, degree
    # Get back a matrix/array with 3 columns for t, pos and degree.
    fixed = t( sapply(parts, function(x)  substring(x[c(1, 3, 4)], c(3, 5, 8))) )

    # Get the t and degree elements and also split the pos elements into x, y, z
    nfixed = cbind(fixed[, -2], do.call(rbind, strsplit(fixed[,2], ",")))
    colnames(nfixed) = c("t", "degree", "x", "y", "z")


    # Now work on the detected device parts.
    # Process each record/line.
    # The following uses a regular expression. Can do without using this.
    # info = lapply(parts, function(x)  do.call(rbind,  strsplit(x[-(1:4)], "[=,]")))
    info = lapply(parts[sapply(parts, length) > 4], function(x)  matrix(unlist(strsplit(unlist(strsplit(x[-(1:4)], "=")), ",")), , 4, byrow = TRUE))
    i = rep(seq(along = info), sapply(info, nrow))    

    info = do.call(rbind, info)
    colnames(info) = c("mac", "signal", "channel", "devType")

    # Repeat
    ans = cbind(nfixed[i, ], info)

    ans = as.data.frame(ans, stringsAsFactors = FALSE)
    
    ans[c("mac", "channel")] = lapply(ans[c("mac", "channel")], factor)

    numericVars =  c("t", "x", "y", "z", "degree", "signal")
    ans[ numericVars ] = lapply( ans[ numericVars ], as.numeric)

    deviceTypes = c("1" = "fixed", "3" =  "mobile")
    ans$devType = factor( deviceTypes[ ans$devType ]  )

    ans$t = structure(ans$t/1000, class = c("POSIXct", "POSIXt"))
    
    ans
}
