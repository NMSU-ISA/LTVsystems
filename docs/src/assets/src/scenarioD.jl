path = "docs/src/assets/"

using LTVsystems
using Plots
š©ā =  [0.0, 0.0]
š©įµ£ā =  [-0.3, 0.0]
š©įµ£ā =  [0.0, 0.3]
š©įµ£ā =  [0.3, 0.0]
š©įµ£ā =  [0.0, -0.3]
š©įµ£ā =  [0.0, 0.0]
p(t) = Ī“n(t,1.0e-10)
q = LTIsourceO(š©ā, p)
#Multiple Targets
Ī±ā = 0.7; šā = [0.4,0.7]
Ī±ā = 0.5; šā = [0.6,0.2]
Ī±ā = 0.4; šā = [0.6,1.0]
r = pointReflector([šā,šā,šā],[Ī±ā,Ī±ā,Ī±ā],[q])
# Observed signal
zā = LTIreceiverO(r,š©įµ£ā)
zā = LTIreceiverO(r,š©įµ£ā)
zā = LTIreceiverO(r,š©įµ£ā)
zā = LTIreceiverO(r,š©įµ£ā)
zā = LTIreceiverO(r,š©įµ£ā)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, zā(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, zā(t))
plot!(p1,t, zā(t))
plot!(p1,t, zā(t))
plot!(p1,t, zā(t))

png(path*"scenarioD_signal.png")

scene2Dplot([q],r,[zā,zā,zā,zā,zā])

png(path*"scenarioD.png")
#----------------------------------------------------
# Estimator function
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ norm(š©įµ£ā-Ī¾))./c))./(A(norm(Ī¾-š©ā)./c).*A(norm(š©įµ£ā-Ī¾)./c))
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ norm(š©įµ£ā-Ī¾))./c))./(A(norm(Ī¾-š©ā)./c).*A(norm(š©įµ£ā-Ī¾)./c))
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ norm(š©įµ£ā-Ī¾))./c))./(A(norm(Ī¾-š©ā)./c).*A(norm(š©įµ£ā-Ī¾)./c))
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ norm(š©įµ£ā-Ī¾))./c))./(A(norm(Ī¾-š©ā)./c).*A(norm(š©įµ£ā-Ī¾)./c))
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ norm(š©įµ£ā-Ī¾))./c))./(A(norm(Ī¾-š©ā)./c).*A(norm(š©įµ£ā-Ī¾)./c))

f(Ī¾::Vector{Float64})=fā(Ī¾::Vector{Float64}).+fā(Ī¾::Vector{Float64}).+fā(Ī¾::Vector{Float64}).+fā(Ī¾::Vector{Float64}).+fā(Ī¾::Vector{Float64})
#SPATIAL SIMULATION3
inverse2Dplot([q],r,[zā,zā,zā,zā,zā],f)

png(path*"scenarioD_simulation.png")

# Target estimation
f_new(Ī¾::Vector{Float64})=(fā(Ī¾::Vector{Float64}).*fā(Ī¾::Vector{Float64}).*fā(Ī¾::Vector{Float64}).*fā(Ī¾::Vector{Float64}).*fā(Ī¾::Vector{Float64}))^(1/3)
#SPATIAL SIMULATION
inverse2Dfinalplot([q],[zā,zā,zā,zā,zā],f_new)

png(path*"scenarioD_target_estimation.png")
#-----------------------------------------------------------------
# with 3 target and 3 receiver
using ISA, LTVsystems
using Plots
š©ā =  [0.0, 0.3]
š©įµ£1 =  [-0.3, 0.0]
š©įµ£2 =  [0.6, 0.0]
š©įµ£3 =  [1.2, 1.2]
p(t) = Ī“(t-1.0e-15,1.0e-10)
q = LTIsourceO(š©ā, p)
Ī±ā = 0.7; šā = [0.9,0.0]
Rā = LTIsourceO(šā, t->Ī±ā*q(šā,t))
Ī±ā = 0.3; šā = [1.8,1.8]
Rā = LTIsourceO(šā, t->Ī±ā*q(šā,t))
Ī±ā = 0.5; šā = [2.7,0.0]
Rā = LTIsourceO(šā, t->Ī±ā*q(šā,t))
zā = LTIreceiverO([Rā,Rā,Rā],š©įµ£1)
zā = LTIreceiverO([Rā,Rā,Rā],š©įµ£2)
zā = LTIreceiverO([Rā,Rā,Rā],š©įµ£3)
t = collect(0.0:1.0e-10:25.5e-9)
p1 = plot( t, zā(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, zā(t))
plot!(p1,t, zā(t))

#-----------------------------------------
aā(Ī¾::Vector{Float64}) = (Ī±ā.+Ī±ā.+Ī±ā).*A(norm(Ī¾-š©ā)./c).*A(distBetween(š©įµ£1,Ī¾)./c)
aā(Ī¾::Vector{Float64}) = (Ī±ā.+Ī±ā.+Ī±ā).*A(norm(Ī¾-š©ā)./c).*A(distBetween(š©įµ£2,Ī¾)./c)
aā(Ī¾::Vector{Float64}) = (Ī±ā.+Ī±ā.+Ī±ā).*A(norm(Ī¾-š©ā)./c).*A(distBetween(š©įµ£3,Ī¾)./c)
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ distBetween(š©įµ£1,Ī¾))./c))./(aā(Ī¾::Vector{Float64}))
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ distBetween(š©įµ£2,Ī¾))./c))./(aā(Ī¾::Vector{Float64}))
fā(Ī¾::Vector{Float64})=(zā((norm(Ī¾-š©ā) .+ distBetween(š©įµ£3,Ī¾))./c))./(aā(Ī¾::Vector{Float64}))
f(Ī¾::Vector{Float64})=fā(Ī¾::Vector{Float64}).+fā(Ī¾::Vector{Float64}).+
fā(Ī¾::Vector{Float64})
Īpos = 0.01
x_range = collect(-5:Īpos:5)
y_range = collect(-4:Īpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(š®) for š® ā xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         legend=false,zticks=false,title="Scenario D Simulation")
scatter!(p2,[š©ā[1]], [š©ā[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[š©įµ£1[1]], [š©įµ£1[2]],markersize = 5.5,color = :blue, marker=:square, label='r')
scatter!(p2,[š©įµ£2[1]], [š©įµ£2[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[š©įµ£3[1]], [š©įµ£3[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[šā[1]],[šā[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[šā[1]],[šā[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[šā[1]],[šā[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
