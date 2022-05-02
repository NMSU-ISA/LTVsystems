path = "docs/src/assets/"

using LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.1, 0.0]
𝐩ᵣ =  [0.6, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.2,1.0]; 𝐮₁ = [1.0,0.0]; L₁=1.0
α₂ = 0.5; 𝛏₂ = [1.2,1.0]; 𝐮₂ = [0.0,1.0]; L₂=1.0
α₃ = 0.3; 𝛏₃ = [2.2,1.0]; 𝐮₃ = [-1/√2,1/√2]; L₃=1.35
r₁ = lineSegment(𝛏₁,𝐮₁,L₁,k->α₁,[q])
r₂ = lineSegment(𝛏₂,𝐮₂,L₂,k->α₂,[q])
r₃ = lineSegment(𝛏₃,𝐮₃,L₃,k->α₃,[q])
z = LTIreceiverO([r₁,r₂,r₃],𝐩ᵣ)

t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioG_signal.png")


scene2Dplot([q],[r₀,r₁,r₂],[z])

png(path*"scenarioG.png")

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r₁,r₂,r₃],[z],f)
png(path*"scenarioG_simulation.png")
