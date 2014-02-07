# 3a)
function onepass(y::Array)
        n = length(y);
        sum = zero(y[1]);
        sum2 = zero(y[1]);
        for i in 1:n
                sum = sum + y[i];
                sum2 = sum2 + y[i]^2;
        end;
        var = (sum2 - (sum^2)/n)/(n-1);
return var;
end

# 3b)
function twopass(y::Array)
        n = length(y);
        sum = zero(y[1]);
        sum2 = zero(y[1]);
        for i in 1:n
                sum = sum + y[i];
        end;
        mean = sum/n;
        for i in 1:n
                sum2 = sum2 + (y[i] - mean)^2;
        end;
        var = sum2/(n-1);
return var;
end

# 3c)
# For N = 10^6 and true_mean = 10^6, the one-pass and two-pass algorithms give var = 0.9734409734409735 and var = 0.9983816801280513 respectively. Using var(y) gives us a value of 0.9983816801280437, meaning we can be assured that the two-pass algorithm is more accurate to reality, assuming the var function in Julia is the most accurate among the three. The percent difference between the one-pass and two-pass algorithm is ~2.5%, so it's not significantly different, but the error remains extant.

# 3d)
# It seems that the two-pass algorithm should be used almost universally. The one-pass algorithm is slightly less accurate and does not offer any major advantages in terms of speed or efficiency. In the past, using two loops to calculate something when it could be done with one would have been less desirable and more open to errors because of floating point rounding, but processors in this day and age are able to perform fine without issue.

# 3e)
function var_online(y::Array)
    n = length(y);
    sum1 = zero(y[1]);
    mean = zero(y[1]);
    M2 = zero(y[1]);
    for i in 1:n
        diff_by_i = (y[i]-mean)/i;
        mean = mean +diff_by_i;
        M2 = M2 + (i-1)*diff_by_i*diff_by_i+(y[i]-mean)*(y[i]-mean);
    end;
    variance = M2/(n-1);
end

#Using this function on our test set gives a var = 0.9983816801261676, which is still remarkably close to the "real" variance even when this function only uses a one-pass algorithm. In this case, it would be preferable to use this function over the two-pass algorithm above since this using less loops in writing code is more efficient in terms of aesthetic and computing power. In this simple case, there's almost no difference, but this example can be expanded to more complicated algorithms and more massive datasets, in which the concept of less loops and less complexity would be best. It also makes debugging and reviewing less of a hassle, which in many ways can be more time efficient than the time that is saved during the actual computation. On the other hand, it is still almost imperceptibly less accurate, so it might be better to use the two-pass algorithm when extreme accuracy is a major concern.
