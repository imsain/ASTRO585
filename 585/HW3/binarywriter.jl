function binarywriter(array,filename)
        file = open(filename,"w+")
        write(file,array)
        close(file)
end
