readData =
function(filename = "online")
{
    ll = readLines(filename)
    ll = ll[ substring(ll, 1, 1) != "#" ]

    tmp = lapply(ll, line2DF)
    do.call(rbind, tmp)
    # post process
}

line2DF =
function(x)
{
    parts = strsplit(x, ";")[[1]]
    fixed = parts[1:4]
    ddev = parts[-(1:4) ]
    els = strsplit(ddev, '=')
    mac = sapply(els, `[`, 1) # sapply(els, function(x) x[1])

    els2 = sapply(els, `[`, 2)
    els3 = strsplit(els2, ",")

    signal = sapply(els3, `[`, 1)
    channel = sapply(els3, `[`, 2)
    type = sapply(els3, `[`, 3)

    ans = data.frame(mac, signal, channel, type, stringsAsFactors = FALSE)

    fixed = substring(fixed, c(3, 4, 5, 8))
    pos.xyz = strsplit(fixed[3], ",")[[1]]
    ans$t = fixed[1]
    ans$id = fixed[2]
    ans$degree = fixed[4]
    ans$x = pos.xyz[1]
    ans$y = pos.xyz[2]
    ans$z = pos.xyz[3]
    ans
}
