#2a)
x = linspace(0,100,1024)
@time println(x)
#The elapsed time to print the 1024 entry array was 0.000973207 seconds.

#2b) Functions asciireader and asciiwriter were created.
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW3\\asciiwriter.jl")
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW3\\asciireader.jl")

#2c)
tic()
asciiwriter(x,"2c.dat")
toc()
tic()
asciireader("2c.dat")
toc()

#According to the tic() toc() time markers, it takes 0.013553504 seconds to write the file, but 0.03055451 seconds to read the file. It's clear from this comparison that writing to a file takes significantly longer by at least an order of magnitude than outputting to the Console, although that may just be because of suboptimal coding. Using a for loop may be the cause of this. Reading out the file takes an equivalently long time.

tic()
asciireader("2c.dat")
toc()
tic()
asciireader("2c.dat")
toc()
tic()
asciireader("2c.dat")
toc()

#When reading from the same file multiple times in a row, only the first read in takes a long time. Consecutive reads take less than half the amount of time. The 2nd, 3rd, and 4th reads are respectively: 0.010536607 s, 0.009930193 s, 0.010170259 s.

#y = reshape(linspace(1,1048576,1048576),1024,1024)
#tic()
#asciiwriter(y,"2c_2.dat")
#toc()
#tic()
#asciireader("2c_2.dat")
#toc()

#With a 1024x1024 array, the write took 0.285620452 seconds, but the read in took so long that the Console froze up. Upon checking, the file size was about 9 megabytes. I suspect this may be because my asciiwriter function is not optimized for anything but single dimension vectors. Thus, let us use a quarter of this size with a 512x512 array.

y = reshape(linspace(1,262144,262144),512,512)
#tic()
#asciiwriter(y,"2c_2.dat")
#toc()
#tic()
#asciireader("2c_2.dat")
#toc()

#This time, the write took 0.074687958 seconds seconds, but the read took 226.359976422 seconds. Assuming what we learned about processing times being linear, the 1024x1024 file would have taken something like 15 minutes to completely parse into an array.

#2d)
#Functions for the binary read/write were made and included below.
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW3\\binarywriter.jl")
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW3\\binaryreader.jl")

@printf("binary:")
tic()
binarywriter(y,"2d.bin")
toc()
tic()
binaryreader("2d.bin",512,512)
toc()

#Writing the binary file took

#2e)
#New functions aren't really necessary given these are just one line commands with the HDF5 package.
using HDF5, JLD

@printf("HDF5:")
tic()
@save "2e.jld" y
toc()
tic()
@load "2e.jld"
toc()
#Writing the HDF5 file took 0.57352243 seconds, and reading it took 0.400507977 seconds. The writing is slower, but the read is significantly faster, by nearly 3 orders of magnitude. The file size of 2e.jld is 2,051 kb, whereas the file size of 2c_2.dat is 2196 kb, so there is a slight improvement in memory efficiency in using an HDF5 file. Nonetheless, the improvement is most obviously in the read time.

#2f)

