path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p₁(t) = δn(t,1.0e-10)
p₂(t) = δn(t,2.0e-10)
p₃(t) = δn(t,4.0e-10)
𝐛 = [1.0,0.0]
G₁(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
G₂(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/2)
G₃(θ) = 𝒩ᵤ(θ, μ=0.0, σ=3π/4)
q₁ = LTIsourceDTI(𝐩ₛ,p₁,𝐛,G₁)
q₂ = LTIsourceDTI(𝐩ₛ,p₂,𝐛,G₂)
q₃ = LTIsourceDTI(𝐩ₛ,p₃,𝐛,G₃)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r₁ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₁])
r₂ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₂])
r₃ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₃])

z₁ = LTIreceiverDTI(r₁,𝐩ᵣ,𝐛,G₁)
z₂ = LTIreceiverDTI(r₂,𝐩ᵣ,𝐛,G₂)
z₃ = LTIreceiverDTI(r₃,𝐩ᵣ,𝐛,G₃)

t = collect(0.0:1.0e-10:25.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))
