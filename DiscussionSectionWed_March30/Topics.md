
Recap basics of R
+ Questions about assignment?

+ What did you learn in STA141A?
+ What do you have questions about?



























+ readRDS() and load() - RDS and RDA files

We will work with geolocation data we are discussing in lecture
yesterday and tomorrow.  We'll jump to where it is already read in.

```
d = readRDS("online.rds")
```

+ checking objects
  class(d)
  typeof(d)  
  length(d)
  dim(d)
  names(d)
  sapply(d, class)

+ vectors  and  lists
  + What's the difference?


+ Explore the datatable()
```
table(d$mac)
table(d$type)
table(d$mac, d$type)
```

+ x, y locations
```
length(unique(d$x))
length(unique(d$y))
table(d$x)
```

```
table(d$degree)
dotchart(table(d$degree))
```

```
table(d$x, d$y)
```

```
plot(d$x, d$y)
```

Color by the number of observations


+ subsetting
   + position
   + name
   + negative position
   + logical vector
   + empty
   + 1, 2, 3, ... dimensions
   + matrix
   + 2-column matrix of i, j pairs


+ Vectorized operations
   + Recycling rule.

+ apply functions
   + anonymous functions

+ writing simple functions



+ do.call()