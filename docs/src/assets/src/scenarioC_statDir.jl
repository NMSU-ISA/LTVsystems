path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/3)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
#Reflectors
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioC_STATDirsignal.png")

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#SPATIAL SIMULATION
inverse2Dplot([q],r,[z],f)

png(path*"scenarioC_STATDirsimulation.png")