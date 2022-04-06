
+ Default value for readData() function
+ Breaking function into smaller, reusable, functions.
+ Debugging
+ Vectorized operations


Consider transforming the detected device "parts"
for a given line in the file into a data.frame/matrix.

+ We split by =
+ then got the mac address (`sapply(els, `[`, 1)
+ then got the second part - "signal, channel, type" as a string
+ then split this
+ then got the signal, then the channe, then the type.
+ combine into a data.frame via data.frame()/cbind() 

Instead, what if we could arrange the values into matrix/data.frame/tabular structure
"directly"

ddev = c("00:14:bf:b1:97:8a=-43,2437000000,3", "00:0f:a3:39:e1:c0=-52,2462000000,3", 
"00:14:bf:3b:c7:c6=-62,2432000000,3", "00:14:bf:b1:97:81=-58,2422000000,3", 
"00:14:bf:b1:97:8d=-62,2442000000,3", "00:14:bf:b1:97:90=-57,2427000000,3", 
"00:0f:a3:39:e0:4b=-79,2462000000,3", "00:0f:a3:39:e2:10=-88,2437000000,3", 
"00:0f:a3:39:dd:cd=-64,2412000000,3", "02:64:fb:68:52:e6=-87,2447000000,1", 
"02:00:42:55:31:00=-85,2457000000,1")


ivals = unlist(strsplit(unlist(strsplit(ddev, "=")), ","))

d = matrix(ivals, , 4, byrow = TRUE)
d = as.data.frame(d, stringsAsFactors = FALSE)


What if we could do this for all lines - only on the detected device parts.

ll = readLines("../Day3/online")
ll = ll[!grepl("^#", ll)]
parts = strsplit(ll, ";")

addev = lapply(parts, `[`, -(1:4))

     check result is meaningful/as we expect
nddev = sapply(addev, length)
table(nddev)

tmp = unlist(strsplit(unlist(strsplit(unlist(addev), "=")), ","))

  # Even better but using regular expressions.
tmp2 = unlist(strsplit(unlist(addev), "[=,]"))
identical(tmp, tmp2)

ddev = matrix(tmp, , 4, byrow = TRUE)

dim(ddev)
   Exactly the number of rows we got with our original function.
   

fixed = lapply(parts, `[`, 1:4)
fx = matrix(unlist(strsplit(unlist(fixed), "[=,]")), , 10, byrow = TRUE)

fx = fx[, c(2, 4, 6, 7, 8, 10)]

i = rep(seq(along.with = parts), nddev)

length(i)

ans = cbind(fx[i,], ddev)




```r
source("vectorize.R")
Rprof("tm.prof")
invisible(replicate(5, readData("../Day3/online")))
Rprof(NULL)
```

```r
head(summaryRprof("tm.prof")$by.self, 20)
            self.time self.pct total.time total.pct
"strsplit"       1.90    81.90       1.90     81.90
"lapply"         0.10     4.31       2.32    100.00
"readLines"      0.10     4.31       0.12      5.17
"unlist"         0.08     3.45       1.30     56.03
"as.vector"      0.06     2.59       0.06      2.59
"matrix"         0.04     1.72       0.34     14.66
"$"              0.02     0.86       0.02      0.86
"file"           0.02     0.86       0.02      0.86
```

+ So strsplit is taking 82% of the time.
+ 3 calls to strsplit






What if we split the fixed and detected devices in one call to strsplit?
Result is more complicated but can we then extract the pieces we want for
the two data.frames

Consider 3 sample lines  `ll[3]`.

What if we can  make one call to strsplit
+ split all values by ; = and , for each line
+ extract the fixed element values
+ extract and assemble the detected devices


