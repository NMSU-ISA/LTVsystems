path = "docs/src/assets/"

using LTVsystems
using Plots
tₚ = 1.0e-06 # in microseconds
𝐩ₛ =  [0.75e-06c, 0.0]
𝐩ᵣ =  [-3.0e-06c, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))


png(path*"scenarioB_signal.png")

scenePlot2D([q],[r],[z])

png(path*"scenarioB.png")
#-----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64})=(z(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#SPATIAL SIMULATION
inversePlot2D([q],[r],[z],f)
png(path*"scenarioB_simulation.png")
