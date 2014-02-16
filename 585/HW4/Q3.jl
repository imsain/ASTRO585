function triad(b::Vector, c::Vector, d::Vector)
  assert(length(b)==length(c)==length(d))
  a = similar(b)
  for i in 1:length(a)
     a[i] = b[i] + c[i] * d[i]
  end
  return a
end

function triad_twist1(b::Vector, c::Vector, d::Vector)
  assert(length(b)==length(c)==length(d))
  a = similar(b)
  for i in 1:length(a)
     if c[i]<0.
       a[i] = b[i] - c[i] * d[i]
     else
       a[i] = b[i] + c[i] * d[i]
     end
  end
  return a
end

function triad_twist2(b::Vector, c::Vector, d::Vector)
  assert(length(b)==length(c)==length(d))
  a = similar(b)
  for i in 1:length(a)
     if c[i]<0.
       a[i] = b[i] - c[i] * d[i]
     end
  end
  for i in 1:length(a)
     if c[i]>0.
       a[i] = b[i] + c[i] * d[i]
     end
  end
  return a
end

function triad_twist3(b::Vector, c::Vector, d::Vector)
  assert(length(b)==length(c)==length(d))
  a = similar(b)
  for i in 1:length(a)
     cc = abs(c[i])
     a[i] = b[i] + cc * d[i]
  end
  return a
end

#3a)

