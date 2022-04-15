readData =
    function(variableFiles)
{
    # l.10 = lapply(x, function(x) x[2])
    sapply(variableFiles, function(f) readLines(f)[5])
    
}
