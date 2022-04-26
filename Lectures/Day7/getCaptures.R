getCaptures =
function(pat, x, matches = gregexpr(pat, x, perl = TRUE, ...), ..., SIMPLIFY = FALSE,
          asDataFrame = TRUE)
{
    ans = mapply(getCapture, x, matches,
                 MoreArgs =  list(asDataFrame = asDataFrame),
                 SIMPLIFY = SIMPLIFY)

    if(asDataFrame)
        do.call(rbind, ans)
    else
        ans
}

getCapture =
function(str, m, asDataFrame = FALSE)
{
    st = attr(m, "capture.start");
    ans =  substring(str, st, st + attr(m, "capture.length") - 1L)
    if(asDataFrame)
        structure(as.data.frame(as.list(ans), stringsAsFactors = FALSE, make.names = FALSE),
                  names = attr(m, "capture.names"))
    else
        ans
}
