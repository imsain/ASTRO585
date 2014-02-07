#This function writes a vertical text file of a given filename of an input array.
function asciiwriter(array,filename)
    file = open(filename,"w+")
    for i in 1:length(array)
        println(file,array[i])
    end
    close(file)
end
