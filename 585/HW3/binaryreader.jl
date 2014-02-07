function binaryreader(filename,m,n)
        file = open(filename,"r")
        array = mmap_array(Float64, (m,n), file)
        close(file)
        return array
end
