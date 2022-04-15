readOneFile =
    # returns a data.frame for one variable and one time
    # 24*24 4 columns  - lat, long, time values.
function(f)
{
  read.table(f, skip = 7)
}


ff = list.files(pattern = "txt")
fileVarNames = gsub("[0-9].*", "", ff)


readAllFilesForOneVar = 
function(files)
{
    tmp  = lapply(files, readOneFile)
    var1 = do.call(rbind, tmp)
}




dfsForEachVar = lapply(filesByVar, readAllFilesForOneVar)

#cbind(dfsForEachVar[[1]],

vals6 = lapply(dfsForEachVar[-1], function(x) x[,4])
tmp = do.call(cbind, vals6)
cbind(dfsForEachVar[[1]], tmp)
