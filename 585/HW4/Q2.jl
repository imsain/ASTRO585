#2a)
#Integrand evaluation can be done simply by turning the integrand into a function via:
f(x) = exp(-0.5*x .^ 2)/sqrt(2*pi)

#2b)
#The function is called here:
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW4\\integrator.jl")
using Base.Test
@time testint = integrate(f,-1000,1000,.01)
@test_approx_eq_eps(testint, 1, 1e-6)
#Since this function equals 1 when integrated from negative infinity to infinity, we test it against the value 1 at an accuracy of 1e-6 to see if it works, which it seems to do just fine.
#The time it took to perform this calculation was 0.09462 seconds.

#2c)
#The integrator function was modified in order to take total function evaluations and not a dx increment value in the intvector() function.
@time testvec = intvector(f,-1000,1000,samples = 10000)
@test_approx_eq_eps(testvec, 1, 1e-6)
#The time it took to perform this calculation was .0065102 seconds. If we raise the samples to 1e8, then:
@time testvec = intvector(f,-1000,1000,samples = 100000000)
#The time it takes is 35.5 seconds.

#2d)
#Next, the function was modified to use map() and reduce() in intreduce().
@time testred = intreduce(f,-1000,1000,samples = 10000)
@test_approx_eq_eps(testred, 1, 1e-6)
#The time it took to perform this calculation was .003331 seconds. Again, by raising the sample size to 1e8, then:
@time testred = intreduce(f,-1000,1000,samples = 100000000)
#The time is now 19.79 seconds.

#2e)
#Finally, by combining map and reduce together into mapreduce(), we get intmapreduce().
@time testmapred = intmapreduce(f,-1000,1000,samples = 10000)
@test_approx_eq_eps(testmapred, 1, 1e-6)
#It took 0.003138 seconds. Raising the sample size to 1e8:
@time testmapred = intmapreduce(f,-1000,1000,samples = 100000000)
#16.745 seconds.

#2f)
#This time, the vector-style integrator was changed to use @devec.
using Devectorize
@time testdevec = intdevec(-1000,1000,samples = 10000)
@test_approx_eq_eps(testdevec, 1, 1e-6)
#It took 0.00116 seconds. Raising the sample size to 1e8:
@time testmapred = intdevec(-1000,1000,samples = 100000000)
#6.56409 seconds!

#2h)
@profile intmapreduce(f,-1000,1000,samples = 10000000)
Profile.print()
Profile.clear()
#The most time is spent on lines 38 and 39, the mapreduce() parts. This makes sense as the rest of the function is extremely simple.

@profile intdevec(-1000,1000,samples = 10000000)
Profile.print()
Profile.clear()
#Even less samples are produced with devec overall, but the most is spent on line 53, where the integrand evaluations are summed up. There's not much that can be done to further improve the code's performance, except to remove the for loop altogether and use the map functions instead.
