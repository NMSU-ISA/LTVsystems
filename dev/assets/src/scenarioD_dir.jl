path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p₁(t) = δn(t,1.0e-10)
p₂(t) = δn(t,1.0e-12)
p₃(t) = δn(t,1.0e-8)
𝐛 = [1.0,0.0]
G₁(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/2)
G₂(θ) = 𝒩ᵤ(θ, μ=0.0, σ=3π/4)
G₃(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q₁ = LTIsourceDTI(𝐩ₛ,p₁,𝐛,G₁)
q₂ = LTIsourceDTI(𝐩ₛ,p₂,𝐛,G₂)
q₃ = LTIsourceDTI(𝐩ₛ,p₃,𝐛,G₃)
