line2DF =
function(x)
{
    parts = strsplit(x, ";")[[1]]
    ans = mkDetectedDeviceDF(parts[ - (1:4) ])
    fxd = getFixed(parts[ 1:4 ])	
    ans[ names(fxd) ] = as.list(fxd)
    ans
}

mkDetectedDeviceDF =
function(ddev)
{
    els = strsplit(ddev, '=')
    mac = sapply(els, `[`, 1) # same as  sapply(els, function(x) x[1])

    els2 = sapply(els, `[`, 2)
    els3 = strsplit(els2, ",")

    signal = sapply(els3, `[`, 1)
    channel = sapply(els3, `[`, 2)
    type = sapply(els3, `[`, 3)

    data.frame(mac, signal, channel, type, stringsAsFactors = FALSE)
}


getFixed = 
function(fixed, devDF)
{
    fixed = substring(fixed, c(3, 4, 5, 8))
    pos.xyz = strsplit(fixed[3], ",")[[1]]
	
	structure(c(fixed[c(1, 3, 4)], pos.xyz), names = c("t", "id", "degree", "x", "y", "z"))
}
