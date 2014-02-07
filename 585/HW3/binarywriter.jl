#This function writes a binary file to an input filename, given an array.
function binarywriter(array,filename)
        file = open(filename,"w+")
        write(file,array)
        close(file)
end
