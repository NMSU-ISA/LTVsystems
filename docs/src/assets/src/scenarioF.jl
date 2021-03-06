path = "docs/src/assets/"

using LTVsystems
using QuadGK
using Plots

š©ā =  [0.1, 0.0]
š©įµ£ =  [0.6, 0.0]
p(t) = Ī“n(t,1.0e-10)
q = LTIsourceO(š©ā, p)
Ī±ā = 0.7; šā = [1.8,2.0]; š = [1.0,0.0]; len=1.0
r = lineSegment(šā,š,len,k->Ī±ā,[q])
z = LTIreceiverO([r],š©įµ£)

t = 0.0:1.0e-10:35.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioF_signal.png")


scene2Dplot([q],[r],[z])

png(path*"scenarioF.png")

f(Ī¾::Vector{Float64})=(z((norm(Ī¾-š©ā) .+norm(š©įµ£-Ī¾))./c))./(A(norm(Ī¾-š©ā)./c).*A(norm(š©įµ£-Ī¾)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioF_simulation.png")



#-----------------------------------------------------------------------
# Estimator function
aā(Ī¾::Vector{Float64}) = A(distBetween(Ī¾,š©ā)./lightSpeed).*A(distBetween(š©įµ£,Ī¾)./lightSpeed)
f(Ī¾::Vector{Float64})=(z((distBetween(Ī¾,š©ā) .+ distBetween(š©įµ£,Ī¾))./lightSpeed))./(aā(Ī¾::Vector{Float64}))
T_val1 = map(x->x[1],line_seg)
T_val2 = map(x->x[2],line_seg)
line = Any[collect(zip(T_val1,T_val2))]
#SPATIAL SIMULATION
Īpos = 0.01
x_range = collect(-3:Īpos:3)
y_range = collect(-3:Īpos:3)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(š®) for š® ā xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=true,zticks=false,bg = RGB(0.0, 0.0, 0.0))
plot!(p2,line[1],color = :red, lw=5,label='t')
scatter!(p2,[š©ā[1]], [š©ā[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[š©įµ£[1]], [š©įµ£[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
display(p2)

png(path*"scenarioF_simulation.png")
