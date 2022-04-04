procLine =
function(x)
{
    els = strsplit(x, ";")[[1]]
    fixed = substring(els[1:4], c(3, 4, 5, 8))    
    fixed = c(fixed[-3], strsplit(fixed[3], ",")[[1]])

    det = els[-(1:4)]
    tmp = strsplit(det, "=")

    mac = sapply(tmp, function(x) x[1])
    vals = sapply(tmp, function(x) x[2])
    vals = strsplit(vals, ",")

    m = t(mapply(function(m, v) c(m, v), mac, vals))

    m = as.data.frame(m)
    names(m) = c("MAC", "signal", "channel", "type")
    
    m$t = fixed[1]
    m$degree = fixed[3]
    m$x = fixed[4]
    m$y = fixed[5]
    m$z = fixed[4]
    
    m
}
