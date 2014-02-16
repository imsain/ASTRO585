#A simple trapezoid rule was used to create this numerical integrator.
function integrate(f,min,max,dx)
    N = iceil((max-min)/dx)
    x = min
    sum = 0
    for i in 0:(N-1)
       sum += (f(x) + f(x+dx))*dx/2
       x += dx
    end
    return sum
end

#Modified to take total samples and vectorized.
function intvector(f,min,max;samples=1e4)
    sum = 0
    xvector = linspace(min,max,samples)
    yvector = f(xvector)
    dx = xvector[2] - xvector[1]
    for i in 2:length(xvector)
       sum += (yvector[i] + yvector[i-1])*dx/2
    end
    return sum
end

#Modified to use reduce().
function intreduce(f,min,max;samples=1e4)
    xvector = linspace(min,max,samples)
    yvector = map(f,xvector)
    dx = xvector[2] - xvector[1]
    sum = (reduce(+,yvector[2:end]) + reduce(+,yvector[1:end-1]))*dx/2
    return sum
end


#Modified to use mapreduce().
function intmapreduce(f,min,max;samples=1e4)
    xvector = linspace(min,max,samples)
    part1 = mapreduce(f,+,xvector[2:end])
    part2 = mapreduce(f,+,xvector[1:end-1])
    dx = xvector[2] - xvector[1]
    sum = (part1+part2)*dx/2
    return sum
end

#Modified to use @devec.
function intdevec(min,max;samples=1e4)
        #f(x) = exp(-0.5 * x .^ 2)/sqrt(2*pi)
        sum = 0
        xvector = linspace(min,max,samples)
        @devec yvector = exp(-0.5 .* xvector .^ 2) ./ sqrt(2 .* pi)
        dx = xvector[2] - xvector[1]
        for i in 2:length(xvector)
           sum += (yvector[i] + yvector[i-1])*dx/2
        end
        return sum
end
