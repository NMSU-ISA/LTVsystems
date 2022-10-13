path = "docs/src/assets/"

using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
tₚ = 1.0e-06 # in microseconds
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [2.0e03,0.0] #in meter
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = 0.0:0.001:15.5
t=0.0:1.0e-08:20.0e-06
#plot(t, z(t),ylims=(minimum(z(t)),maximum(z(t))),xlab="time (sec)", ylab="z(t)", legend=:false)
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

plot(t,z(t),ylims=(minimum(z(t)),maximum(z(t))))

#plot(t,A.(t))

#scene2Dplot([q],[r],[z];Δpos,x_min,x_max,y_min,y_max)
P=20.0e-06
Δpos = 0.01e03
x_min = -4.0e03
x_max = 4.0e03
y_min = -4.0e03
y_max = 4.0e03

scene2DRangeplot([q],[r],[z],P;Δpos,x_min,x_max,y_min,y_max)

png(path*"scenarioA_signal.png")



scene2Dplot([q],[r],[z];Δpos,x_min,x_max,y_min,y_max)

png(path*"scenarioA.png")
#----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64}) = z(tₚ.+ 2(norm(ξ-𝐩ₛ))/c)/
                        (A(norm(ξ-𝐩ₛ)/c))^2
                        
inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max) 

#


x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
                                 aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
                        
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max)

png(path*"scenarioA_simulation.png")

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