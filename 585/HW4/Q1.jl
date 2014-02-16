#1a)
#The leapfrog integrator code provided will be profiled for this question.

#1b)
#Upon looking through HW4_leapfrog.jl, I predict that the while loop at line 82 would take the longest time, simply because everything else in the various nested functions are simple arithmetic. In HW4_leapfrog_student.jl, the for loop in line 28 would take the longest time for similar reasons.

#1c)
#Here, we check the profile of both functions.
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW4\\HW4_leapfrog.jl")
@profile calc_end_distance_leapfrog(100)
Profile.print()
Profile.clear()

include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW4\\HW4_leapfrog_student.jl")
@profile calc_end_distance_leapfrog_student(100)
Profile.print()
Profile.clear()

#1d)
#According to the profile, the most time is actually spent on the deepcopy() function on line 95. Upon looking up what it does, there doesn't seem to be any reason we couldn't just use copy(), since I'm not certain what the difference is. Perhaps copy is even more time intensive? Regardless, the while loop still took a good number of samples, but the deepcopy portion seemed to dominate.

#In the student's case, according to the profile, the most time was spent on lines 31,36,37,38, and 39, with nearly 2000 backtraces originating here. It appears the vcat method is fairly time consuming, and one could attempt to optimize the function by changing this. Notably, the original leapfrog function had significantly less backtraces (and took significantly less time to call), so this student made function might be shorter in terms of line count, but is much less efficient/time consuming.

#1e)
#In the original leapfrog case, I don't think there's anything that can be done to improve the function besides taking a look at replacing the deepcopy() function mentioned above. Moreover, the function executes so quickly that perhaps any improvement in speed isn't worth the time it would take to implement.

#However, in the student function, the vcat() method takes a long time, but it serves a particular purpose in concatenating all of the sampled points of the execution into one variable. This makes it far easier to plot, for example. However, the same can be done externally by the original, so the entire vcat() section could afford to be rewritten to not collect and save all of the points together, since the ultimate function only uses the endpoints. This definitely worth doing and would probably speed up the function to be as fast as the original.

#1f)
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW4\\HW4_leapfrog_student2.jl")

#The modifications outlined in 1e) were made to HW4_leapfrog_student.jl in HW4_leapfrog_student2.jl. They weren't very extensive, but served to shorten the time significantly (and still produces the same answer, which is good).

@elapsed calc_end_distance_leapfrog_student2(100)
@elapsed calc_end_distance_leapfrog_student(100)

#To note, by running @elapsed, we get:
#0.034 seconds to run HW4_leapfrog_student2
#4.437 seconds to run HW4_leapfrog_student


#1g)
@profile calc_end_distance_leapfrog_student2(100)
Profile.print()
Profile.clear()
#It appears the most samples occurred at line 49, with the offset calculation (102 samples), but this isn't as bad as the 2000 samples that occurred with the vcat() methods. The difference is so vast that it's very much worth making the change in this case. When plotting is involved, the question changes because of the efficiency of concatenating everything into one array is more efficient inside the function rather than outside of it, but even then, perhaps it would be best to output line by line to an external file and read the plot from there separately.
