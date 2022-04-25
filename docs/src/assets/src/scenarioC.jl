path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
#Reflectors
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
α₂ = 0.4; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioC_signal.png")

scene2Dplot([q],r,[z])

png(path*"scenarioC.png")
#-----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c)

#SPATIAL SIMULATION
inverse2Dplot([q],r,[z],f)
png(path*"scenarioC_simulation.png")
