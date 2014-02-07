#1)
function elapser(runs)
    N = 1000000;
    arr_rand = zeros(runs);
    arr_plus = zeros(runs);
    arr_mult = zeros(runs);
    arr_squa = zeros(runs);
    arr_sin = zeros(runs);
    arr_cos = zeros(runs);
    arr_log = zeros(runs);
    for i in 1:runs
        arr_rand[i] = 1./@elapsed x = rand(N);
        arr_plus[i] = 1./@elapsed x.+x;
        arr_mult[i] = 1./@elapsed x.*2;
        arr_squa[i] = 1./@elapsed x.*x;
        arr_sin[i] = 1./(@elapsed sin(x));
        arr_cos[i] = 1./(@elapsed cos(x));
        arr_log[i] = 1./(@elapsed log(x));
    end;
    println("rand: ",mean(arr_rand));
    println(".+2: ",mean(arr_plus));
    println(".*2: ",mean(arr_mult));
    println(".^2: ",mean(arr_squa));
    println(".sin: ",mean(arr_sin));
    println(".cos: ",mean(arr_cos));
    println(".log: ",mean(arr_log));
end

#Since the time it takes for an operation varies between runs, I decided to write a simple function (elapser) to average x number of trial runs together. For example, running elapser(100) is equivalent to running the @elapsed operation 100 times and averaging the result, outputting it to the buffer.
#For an elapser(100), the values we get for each operation are:
#rand: 327.68 times per second
#+:    184.67 times per second
#*2:   378.71 times per second
#^2:   186.51 times per second
#sin:  78.22 times per second
#cos:  65.42 times per second
#log:  48.53 times per second
#It's important to note that the plus operation and the square operation both use the x vector generated in the rand operation twice, whereas the multiplication operation only uses the x vector once (along with a hardcoded number). This has rather drastically affected the number per second of each operation. Using the x vector twice seems to slow down the results by nearly half. Overall, these numbers may seem low for a modern computer, but N is equal to a million here, so each number should be multiplied by 1,000,000 in order to accurately reflect the number of operations per second for each operation.
