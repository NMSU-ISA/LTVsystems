path = "docs/src/assets/"

using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
tₚ = 1.0e-06 # in microseconds
T  = 15.0e-6
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.25c*T,0.0] #in meter
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = 0.0:0.001:15.5
t=0.0:T/100:2T
#plot(t, z(t),ylims=(minimum(z(t)),maximum(z(t))),xlab="time (sec)", ylab="z(t)", legend=:false)
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioA_signal.png")

scenePlot2D([q],[r],[z],T)

png(path*"scenarioA.png")
#----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64}) = z(tₚ.+ 2(norm(ξ-𝐩ₛ))/c)/
                        (A(norm(ξ-𝐩ₛ)/c))^2
                        
inversePlot2D([q],[r],[z],f,T) 

png(path*"scenarioA_simulation.png")













#plot( t, abs.(z(t)), xlab="time (sec)", ylab="z(t)", legend=:false)
#plot(t,z(t),ylims=(minimum(z(t)),maximum(z(t))))

#plot(t,A.(t))

#scene2Dplot([q],[r],[z];Δpos,x_min,x_max,y_min,y_max)

#Δpos = 0.01e03
#x_min = -0.5c*T
#x_max = 0.5c*T
#y_min = -0.5c*T
#y_max = 0.5c*T

#scene2DRangeplot([q],[r],[z],T;Δpos,x_min,x_max,y_min,y_max)

#sceneRangePlot2D([q],[r],[z],T)











#--------------------------------------------------------
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
    aspect_ratio=:equal,legend=:outertopright,colorbar=true,zticks=false)
                        
#SPATIAL SIMULATION
#inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max)

#png(path*"scenarioA_simulation.png")

#--------Plotting a Circle--------------------------------------
Δpos = 0.01
x_min = -4.0
x_max = 4.0
y_min = -4.0
y_max = 4.0
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
#range(start = 0.0, stop=1.0, step=0.01)
r = 5.0
m=range(0, 2π, length=100)
xₖ(m) = r.*cos.(m)-1.0
yₖ(m) = r.*sin.(m)-1.0
p2=plot(x_range,y_range,transpose([0.0]),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
plot!(p2,xₖ.(m),yₖ.(m))

#
