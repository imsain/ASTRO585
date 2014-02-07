#This function reads out the value of an array from a binary file at a specific point.
function binaryreader2(filename,m,n,x,y)
        file = open(filename,"r")
        array = mmap_array(Float64, (1,1), file)
        close(file)
        return array
end
