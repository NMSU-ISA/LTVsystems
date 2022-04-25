path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


png(path*"scenarioB_signal.png")

scene2Dplot([q],[r],[z])

png(path*"scenarioB.png")
#-----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c)

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioB_simulation.png")
