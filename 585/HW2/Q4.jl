#4a) 4 GB divided by 8 bytes comes out to 536,870,912 double precision numbers, so this amount of memory could store is a 23170 x 23170 square matrix.

#4b) If we assume that LU decomposition requires (2/3)n^3 flops, and n = 23170, we find that it takes about 8.29x10^12 flops, or 8,290 gigaflops. If the processor runs at 20 Gflops/s, then it will take 414.5 seconds, or roughly 7 minutes.

#4c) For the modern, average laptop, which has approximately 4 GB of usable memory, the primary limiting factor would be the time it takes for a computation to be completed. A square matrix with 500 million entries is utterly massive, and not at all practical. This problem should be broken down into simpler parts. However, the fact remains that a single computation that takes 7 minutes (if this computation is done several times, then it would exacerbate the issue), is a lengthy amount of time.

#4d) In reality, another limitation is power consumption. Computers can consume an enormous amount of power that could heat up the physical components and hamper processing ability if not properly cooled, and age also tends to wear on the processing speed as well.

#4e) Practically speaking, the best way to solve even larger systems would be to hook up more computers (or to use one or many very powerful supercomputers). Two computers processing the information will easily double the computation speed, or lessen the load on either of them.
