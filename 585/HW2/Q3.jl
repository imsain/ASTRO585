#3a)
function integrate_euler!(state,dt, duration)
    fstate = state;
    steps = dt;
    rx = state[1];
    ry = state[2];
    vx = state[3];
    vy = state[4];
    while steps < duration
        r = sqrt(rx^2+ry^2);
        rx1 = rx + dt*vx;
        vx1 = vx + dt*-rx/r^3;
        ry1 = ry + dt*vy;
        vy1 = vy + dt*-ry/r^3;
        state2 = [rx1,ry1,vx1,vy1];
        fstate = hcat(fstate,state2);
        steps = steps + dt;
        rx = rx1;
        vx = vx1;
        ry = ry1;
        vy = vy1;
    end;
    tstate = transpose(fstate)
    return tstate;
end
#The above function uses the Euler method to integrate orbits given initial conditions of [rx,ry,vx,vy], a time step dt, and a total duration.

#3b)
#By calling the function integrate_euler!([1,0,0,1],0.03141526,3*2*3.141526), which is three orbits with 200 time steps per orbit, we get a final state of:  [1.34435   -0.00886893   0.00886893  1.34435]
#Apparently, the center of the orbit has shifted away from the origin, implying that this level of accuracy in the time step may not be accurate enough. Larger time steps will cause the particle to move at a constant velocity for longer, which discretizes the orbit, making it polygonal rather than circular.
#If we try a tenth of the step size, we get [1.03004   -0.0037117    0.0037117   1.03004] as the final result, which is closer to what we expect (all values being less than or equal to 1).

#3c)
using Winston
fullstate = integrate_euler!([1,0,0,1],0.03141526,3*2*3.141526)
rx = fullstate[1:end,1]
ry = fullstate[1:end,2]
p = FramedPlot(
        title="Three orbits for Euler Method of Integration",
        xlabel="x",
        ylabel="y")
add(p, Curve(rx, ry, color="red"))
file(p, "3c.png")
#3d)
function integrate_leapfrog!(state,dt, duration)
        fstate = state;
        steps = dt;
        rx = state[1];
        ry = state[2];
        vx = state[3];
        vy = state[4];
        while steps < duration
            r = sqrt(rx^2+ry^2);
            rxhalf = rx + dt*vx/2;
            vx1 = vx + dt*-rxhalf/r^3;
            rx1 = rxhalf + dt*vx1/2;
            ryhalf = ry + dt*vy/2;
            vy1 = vy + dt*-ryhalf/r^3;
            ry1 = ryhalf + dt*vy1/2;
            state2 = [rx1,ry1,vx1,vy1];
            fstate = hcat(fstate,state2);
            steps = steps + dt;
            rx = rx1;
            ry = ry1;
            vx = vx1;
            vy = vy1;
        end;
        tstate = transpose(fstate)
        return tstate;
end
#3e)  The final state is [1.0  0.000375226  -0.000375318  1.0], which is very close to what we expect ([1,0,0,1]), and far closer than the Euler's method in 3c). The leapfrog integration seems to be the best way to go about integrating this orbit, since it requires only one extra step per dimension, but improves the accuracy significantly, resulting in the best tradeoff between speed and accuracy.
using Winston
fullstate = integrate_leapfrog!([1,0,0,1],0.03141526,3*2*3.141526)
rx = fullstate[1:end,1]
ry = fullstate[1:end,2]
p = FramedPlot(
        title="Three orbits for Leapfrog Method of Integration",
        xlabel="x",
        ylabel="y")
add(p, Curve(rx, ry, color="red"))
file(p, "3e.png")
#Furthermore, as we study the two plots side by side, we can see that the Euler's method has some instability that causes this particle to spiral outwards, whereas the leapfrog method keeps the particle going in its orbit no problem. It only seems obvious that the leapfrog integrator is the best method.

#3f)
function intelapser(orbit)
eulertime = @elapsed integrate_euler!([1,0,0,1],0.03141526,orbit*2*3.141526);
leaptime = @elapsed integrate_leapfrog!([1,0,0,1],0.03141526,orbit*2*3.141526);
println("Euler: ",eulertime);
println("Leapfrog: ",leaptime);
end
#This function will give the elapsed time for the Euler and leapfrot methods given an input number of orbits.
#Euler method took 15.734 seconds. The leapfrog method took 15.816 seconds. The difference is nearly negligible, even over 100 orbits, so it is clear that the leapfrog method is best.
#However, if we were to run this simulation for the entirety of the Earth's lifetime (4.5*10^9 orbits), it would take nearly 22.5 years, and the amount of data it would produce would be staggering.

#3g)
#If we double the dt from 3e), the final result is  [0.998947   0.0305908  -0.0306267  1.00012], which, when compared to [1.0  0.000375226  -0.000375318  1.0] from 3e) is nearly two orders of magnitude less accurate.

#3h)
#If we say that the accuracy of the calculation (just leapfrog) is the 1 - error, with error being the root-mean-square of state (x,y,vx,vy), then we can generate a log-log plot of error vs. duration.
accuracy = zeros(50)
for i in 1:50
        laststate = integrate_leapfrog!([1,0,0,1],0.03141526,i*2*2*3.141526)[end,1:4];
        accuracy[i] = sqrt(((laststate[1]-1)^2 + laststate[2]^2 + laststate[3]^2 + (laststate[4]-1)^2)/4);
end
x = linspace(2,100,50);
p = FramedPlot(
        title="Accuracy vs. Duration",
        ylabel="Accuracy",
        xlabel="Duration (in orbits)",xlog=true,ylog=true)
add(p, Points(x, 1-accuracy, color="blue"))
file(p, "3h.png");
#From the plot for accuracy vs. duration, it's clear that as duration increases, the accuracy decreases exponentially. Thus, for a long-term integration, it's necessary to keep in mind that accuracy will drop very sharply.

#3i)
#One easy to way to acclerate the integration would be to make the step size dynamic. For instance, by implementing a function such that the number of points remains constant as duration changes would necessarily change the step size. This is of course not ideal since altering the stepsize will greatly affect the accuracy of the calculation.


