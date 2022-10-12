path = "docs/src/assets/"

using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
tₚ = 0.5 # in seconds
p(t) = δn(t-tₚ,0.1)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [20.0e03,0.0] #in meter
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
t = 0.0:0.01:15.5
#plot(t, z(t),ylims=(minimum(z(t)),maximum(z(t))),xlab="time (sec)", ylab="z(t)", legend=:false)
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


png(path*"scenarioA_signal.png")

Δpos = 0.01e03
x_min = -40.0e03
x_max = 40.0e03
y_min = -40.0e03
y_max = 40.0e03
scene2Dplot([q],[r],[z];Δpos,x_min,x_max,y_min,y_max)
png(path*"scenarioA.png")
#----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64}) = z(tₚ+2(norm(ξ-𝐩ₛ))/c)/
                        (A(norm(ξ-𝐩ₛ)/c))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max)
png(path*"scenarioA_simulation.png")
