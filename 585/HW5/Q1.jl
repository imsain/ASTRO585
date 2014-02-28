#This part done in conjunction with Henry Gebhardt
#1a)
#A simple function that takes a matrix A and a vector b and returns their multiplication.
function matrixmult(A::Array{Float64,2},b:: Array{Float64,1})
   return A*b
end

function AbCreate(dimensions)
N = dimensions[1]*dimensions[2]
A = reshape(1.:N, dimensions[1], dimensions[2])
b = [1.:dimensions[2]]
return A,b
end

A,b = AbCreate([3,3])
matrixmult(A,b)
#The answer should be [30,36,42], and it is!

#1b)
function loopcolmatrixmult(A::Array{Float64,2},b:: Array{Float64,1})
   x = size(A)[1]
   y = size(A)[2]
   @assert y == length(b)
   c = zeros(Float64,x)
   for i in 1:x
        for j in 1:y
           c[i] += A[i,j] * b[j]
        end
   end
   return c
end

loopcolmatrixmult(A,b)
#It works!
#1c)
function looprowmatrixmult(A::Array{Float64,2},b:: Array{Float64,1})
   x = size(A)[1]
   y = size(A)[2]
   @assert y == length(b)
   c = zeros(Float64,x)
   for i in 1:x
        for j in 1:y
           c[j] += A[j,i] * b[i]
        end
   end
   return c
end

looprowmatrixmult(A,b)
#It works!

#1d)
#We predict that going over the first index will be faster for larger matrices because going over the second will load the full column each time. Whichever loop is employed in the outer loop will dominate since that is the loop that is done the most; therefore, it makes sense to believe that the looprowmatrixmult() function will be faster.

#1e)
#The results will be negligible, but going down the columns (row by row) in the inner loop will still be faster.

#1f)
C,d = AbCreate([1024,1024])
E,f = AbCreate([8,8])
@elapsed looprowmatrixmult(C,d) #0.006042614 s
@elapsed loopcolmatrixmult(C,d) #0.019764998 s
@elapsed looprowmatrixmult(E,f) #4.908e-6 s
@elapsed loopcolmatrixmult(E,f) #8.478e-6 s

#1g)
#Indeed, this appears to be what happened.
