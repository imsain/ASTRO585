#2a)
#Although lookup_table_type is an abstract type, it is the parent of the two subtypes lookup_table_linear_type and lookup_table_quadratic_type, so a function that calls this parent type will be willing to accept either of the two subtypes.

#2b)
#
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW5\\HW5_Q2_lookup_table.jl")
lookup_table_lin = make_table_linear(x->log(x),1.,10.,50)
lookup_table_quad = make_table_quadratic(x->log(x),1.,10.,50)

#2c)
using Winston
x = linspace(1.,10.,50)
y = log(x)
ylin = lookup_table_lin.y+0.5
yquad = lookup_table_quad.y+1
p = FramedPlot(
        title="A plot of log(x) from 1 to 10 with three approaches",
        xlabel="x",
        ylabel="log(x)")
orig = Curve(x, y,color="red")
setattr(orig, label="Original")
lin = Curve(x, ylin,color="blue")
setattr(lin, label="Linear (Offset = +0.5)")
quad = Curve(x, yquad,color="green")
setattr(quad, label="Quadratic (Offset = +1.0)")
leg = Legend(.45, .15, {orig,lin,quad})
add(p, orig, lin, quad, leg)
file(p, "2c.png")
#It appears the approximations work fine.

#2d)
@elapsed log(x) #7.139e-6 s
@elapsed lookup_table_lin = make_table_linear(x->log(x),1.,10.,50) #0.003319823 s
@elapsed lookup_table_quad = make_table_quadratic(x->log(x),1.,10.,50) #0.003318039 s

#There is almost no difference between quadratic and linear, but they are both significantly more time-expensive than just using the regular log(x) function. Perhaps a more complicated function will do.

#x->integrate(x -> 1/(x*log(x)+1), 1., 10.)
@elapsed integrate(x -> 1/(x*log(x)+1), 1., 10.) #0.024254791 s
@elapsed lookup_table_lin = make_table_linear(x->integrate(x -> 1/(x*log(x)+1), 1., 10.),1.,10.,50) #0.071708634 s
@elapsed lookup_table_quad = make_table_quadratic(x->integrate(x -> 1/(x*log(x)+1), 1., 10.),1.,10.,50) #0.111109673 s

#The factor difference shrinks as the functions get more complex, and this is a fairly complex integration. That must mean the calculation must be even more complex than this in order for the lookup method to be efficient.

#2d (2)
include("C:\\Users\\Sai\\Documents\\GitHub\\ASTRO585\\585\\HW5\\HW5_Q2_ecc_anom.jl")
means = linspace(-2pi,4pi,100)
ecc = ecc_anom(means,0.25)
p = FramedPlot(
        title="Eccentric Anomalies vs. Mean Anomalies",
        xlabel="Mean Anomaly",
        ylabel="Eccentric Anomaly")
anom = Curve(means, ecc,color="red")
setattr(anom, label="Original")

add(p, anom)
file(p, "2d.png")
#Judging by the complexity of the function, it might be efficient to use a lookup table here.

#2e)
means2 = linspace(0.,2pi,128)
ecc2 = ecc_anom(means2,0.25)
lookup_table_anom = make_table_linear(x->ecc_anom(x,0.25),0.,2pi,128)
p = FramedPlot(
        title="Eccentric Anomalies vs. Mean Anomalies",
        xlabel="Mean Anomaly",
        ylabel="Eccentric Anomaly"
        #,xrange=(0,100),
        #yrange=(0,100)
        )
anom1 = Curve(means2, ecc2,color="red")
anom2 = Curve(means2, lookup_table_anom.y+0.25,color="blue")
setattr(anom1, label="Original")
setattr(anom2, label="Lin. Interpolation (Offset = +0.25)")

leg = Legend(.2, .15, {anom1,anom2})

add(p, anom1,anom2,leg)
file(p, "2e.png")
#I'm not sure, but the lookup_table seems to work fine. Using lookup(lookup_table_anom,means2) does not change the result.

#2f)
meansF = linspace(0.,2pi,128)
eccF = ecc_anom(meansF,0.25)
lookup_table_anomF = make_table_linear(x->ecc_anom(x,0.25),x->decc_anom_dM(x,0.25),0.,2pi,128)

p = FramedPlot(
        title="Eccentric Anomalies vs. Mean Anomalies (with derivative)",
        xlabel="Mean Anomaly",
        ylabel="Eccentric Anomaly"
        )
anom1 = Curve(meansF, eccF,color="red")
anom2 = Curve(meansF, lookup_table_anomF.y+0.25,color="blue")
setattr(anom1, label="Original")
setattr(anom2, label="Lin. Interpolation (Offset = +0.25)")

leg = Legend(.2, .15, {anom1,anom2})
add(p, anom1,anom2,leg)
file(p, "2f.png")
#Again, this seems to work fine, if not identically.

#2g)
#I can't see how the lookup table produces "bad quality" values in this case, because there didn't seem to be a problem. Higher quality interpolation would only produce more of the same.
