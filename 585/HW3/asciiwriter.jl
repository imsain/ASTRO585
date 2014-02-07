function asciiwriter(array,filename)
    file = open(filename,"w+")
    for i in 1:length(array)
        println(file,array[i])
    end
    close(file)
end
