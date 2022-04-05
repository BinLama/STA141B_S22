# Reading geolocation data - again

+ Recall strategy.
  + remove comment lines 
     + starting with #
  + convert each row into a data.frame
     + as many rows as there are detected devices
	 + repeat the fixed part for each row
  + stack/combine the data.frames from each line of the file	 

+ Assume we write a function to process each line - `procLine()`

+ Combine with
```r
atmp = lapply(ll, procLine)
ans = do.call(rbind, tmp)
```

+  Need to write 
```r
procLine = 
  # return data.frame
function(x)
{
}
```

+ split each line by ; to get all the separate fields
   + `t, id, pos, degree`
   + detected devices - `mac=signal,channel,type`
```r
els = strsplit(line, ';')[[1]]
```

+ split the pos into x, y, z 
   + `strsplit(els[[3]], ",")`

+ So have fixed elements
   + as strings, not numbers
   
+  Detected devices 
   +  `dd = els[-(1:4)]`
   + split the vector of by = to split mac and "signal,channel,type"
      + ` els = strsplit(dd, '=')`
   + loop over results to get mac address.
      + `mac = sapply(els, \`[\`, 1)

   + Now the signal, channel, type
```r   
els2 = sapply(els, \`[\`, 2)
```
     + split by ,
```r	 
els3 = strsplit(els2, ',')
```
     + Can extract first, second and third elements
```r
signal = sapply(els3, `[`, 1)
channel = sapply(els3, `[`, 2)
type = sapply(els3, `[`, 3)
```
+ Can combine all of these
```r
dd = data.frame(mac, signal, channel, type)
```
  + as many rows as there are detected devices.
  
+ Need to add the fixed part for each row of `dd`
```
dd$t = els[[1]]  # single value is repeated for as many rows
dd$id = els[[2]]
dd$degree = els[[4]]
dd$x = sapply(els[[3]], `[`, 1)
dd$y = sapply(els[[3]], `[`, 2)
dd$z = sapply(els[[3]], `[`, 3)
```

## Check if Works

+ First line 
```r
ll = readLines("online")
a = procLine(ll[4])
a
```
+ verify results

+ sample some lines
```r
w = substring(ll, 1, 1) != "#"
ll = ll[w]
ll2 = sample(ll, 10)
lapply(ll2, procLine)
```
+ verify results
  + Harder as we don't want to check manually/visually.
  + write tests that should be true if correct.
     + id is the same across all rows? all data.frames?
	 + time increasing across rows?  
	    + no, sampling so random order
	 + range of time stamps?
	    + 
	 + all the x, y, z the same for each row?

+ Run on entire file and combine results
+ Validate results

## Improve Top-level Function

+ Write so can pass subset of lines
  + fewer so wait less time for an error
  + ones causing problems

Original
```r
readData = 
function(fileName)
{
   lines = readLines(fileName))
   lines = lines[substring(lines, 1, 1) != "#"]
   do.call(rbind, lapply(lines, procLine))	
}

```

More flexible
```r
readData =
function(fileName, lines = readLines(fileName))
{
   lines = lines[substring(lines, 1, 1) != "#"]
   do.call(rbind, lapply(lines, procLine))
}
```

The second allows us to call this with

```r
ll = readLines("online")
d = readData(lines = ll[4:20])
```

This allows us to check a few lines  to see if we get errors or wrong results.


## Improve `procLine()`
### Break into smaller functions

+ Split the elements
+ create the detected devices data.frame
+ compute the fixed elements
+ combine

## Make this Faster

+ Arrange the signal, channel and type into a matrix/data.frame directly
  + avoid 3 sapply() calls to get each

After getting the right-hand-side of the = for each detected device (in `els3`)
```
tmp = strsplit(els3, ",")
```

+ This is a list with as many elements as there were detected devices.
+ Each is a character vector of 3 elements - signal, channel and type
+ Want to stack them on top of each other into a matrix or data.frame
```r
tmp2 = do.call(rbind, tmp)
```

+ combine with mac address 
```r
tmp3 = cbind(mac, tmp2)
```

Is this simpler?  faster?


Not a data.frame, but a matrix.
Can convert 
```r
tmp4 = as.data.frame(tmp3)
```


## Debugging

Run this on onlineProblem

```r
ll3 = readLines("../Day3/onlineProblem")
ll3 = ll3[substring(ll3, 1, 1) != "#"]
```
It would be nice to have a function `removeComments()` to do the second step.

```r
procLine(ll3[1])
```
Fine

```r
procLine(ll3[2])
Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE,  : 
  duplicate row.names: 00:14:bf:b1:97:8a
```

```r
procLine(ll3[3])
Error in strsplit(vals, ",") : non-character argument
```

Enable interactive debugging when there is an error
```r
options(error = recover)
```




Do we subset parts to only those that have length >4
or do we do this in the anonymous function processing parts check the length.

## Making Faster

Can we make 
+ simpler
+ faster
+ both





## R Concepts

+ Vectorization
+ Recycling rule
