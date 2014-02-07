#This function reads out a specific value from a square array in an ASCII file.
function asciireader2(filename,m,n)
    file = open(filename,"r")
    ind = m+(n-1)*sqrt(countlines(filename))
    seek(file,iround(ind))
    value = float64(readline(file))
    close(file)
    return value
end
