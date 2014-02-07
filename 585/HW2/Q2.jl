srand(42);
Nobs = 100;
z = zeros(Nobs);
sigma = 2. * ones(Nobs);
y = z + sigma .* randn(Nobs);
normal_pdf(z, y, sigma) = exp(-0.5*((y-z)/sigma)^2)/(sqrt(2*pi)*sigma);

function log_likelihood(y::Array, sigma::Array, z::Array)
   n = length(y);
   sum = zero(y[1]);
   for i in 1:n
    sum = sum + log(normal_pdf(y[i],z[i],sigma[i]));
   end;
   return sum;
end


#2a)
function calc_time_log_likelihood(Nobs::Int, M::Int = 1)
        tic();
        z = zeros(Nobs);
        sigma = 2. * ones(Nobs);
        y = z + sigma .* randn(Nobs);
        total = 0;
        for i in 1:M
            total = total + @elapsed log_likelihood(y,sigma,z);
        end;
        toc();
        return total;
end
#A simple function was made that runs the log_likelihood function M number of times with a number of observations Nobs.

#2b)
#Calling calc_time_log_likelihood(100,1) once results in: 1.1602e-5. A second time, we get 1.8295e-5. This difference of 36.5% can be attributed to small fluctuations in the state of the processor magnified by Nobs.

#2c)
#PyPlot does not seem to work on Windows natively, and requires a lot of tinkering to work (as seen on Julia's forums), so I used Winston for plotting instead.
using Winston
n_list = [ 2^i for i=1:10 ];
elapsed_list = map(calc_time_log_likelihood,n_list);
plot(log10(n_list), log10(elapsed_list),"r+");
xlabel("log N");
ylabel("log (Time/s)");
file("2c.png")
#As seen in the plot, there is a linear relationship between the elapsed time and the number of calculations performed. This makes sense, as each calculation should take a fixed amount of time, and doing more of them should necessarily add more to the total amount of time by that fixed amount. Thus, it's important to keep in mind that the more calculations are done, the longer it'll take linearly.

#2d)
function calc_time_log_likelihood2(Nobs::Int, M::Int = 1)
        tic();
        z = zeros(Nobs);
        sigma = 2. * ones(Nobs);
        y = z + sigma .* randn(Nobs);
        @assert length(y) == length(z);
        @assert length(z) == length(sigma);
        @assert length(sigma) == length(y);
        total = 0;
        for i in 1:M
            total = total + @elapsed log_likelihood(y,sigma,z);
        end;
        toc();
        return total;
end
#When both functions are run, the elapsed time between the tic() and toc() functions are nearly identical. Multiple runs produce numbers along the lines of 0.0015 seconds for both functions. This means the @assert calls add almost nothing to the overall computation time, and should be used as liberally as necessary to proof code against potential errors.

#2e)
function log_likelihood_gen(y::Array, sigma::Array, z::Array,funct)
n = length(y);
sum = zero(y[1]);
for i in 1:n
 sum = sum + log(funct(y[i],z[i],sigma[i]));
end;
return sum;
end

function calc_time_log_likelihood_gen(funct, Nobs::Int, M::Int = 1)
        tic();
        z = zeros(Nobs);
        sigma = 2. * ones(Nobs);
        y = z + sigma .* randn(Nobs);
        total = 0;
        for i in 1:M
            total = total + @elapsed log_likelihood_gen(y,sigma,z,funct);
        end;
        toc();
        return total;
end
#These two functions are the same as the previous log-likelihood and calc_time functions, but work for generic functions rather than just the normal distribution. However, in ordre to test the timing, it would be useful to use the normal distribution for calc_time and calc_time_gen to see which is optimal.
#The total time for the original function is 0.0014899 s.
#The total time for the generic function is 0.0058343 s.
#We can see that generic functions tend to ake about 4 times longer than hard-coded functions. This is important to note. In tasks that don't necessarily require reusing a function for multiple instances, it may be better to not make the code as generic as possible in order to maximize speed and efficiency.


