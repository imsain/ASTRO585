function asciireader(filename)
    file = open(filename,"r")
    array = float64(readline(file))
    while !eof(file) == true
        array = vcat(array,float64(readline(file)))
    end
    close(file)
    return array
end
