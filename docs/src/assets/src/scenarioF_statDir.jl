
path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)+ δn(t-0.5e-9-3T,1.0e-10) + δn(t-0.5e-9-4T,1.0e-10)+ δn(t-0.5e-9-5T,1.0e-10) + δn(t-0.5e-9-6T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.8,1.0]
α₂ = 0.7; 𝛏₂ = [0.4,1.0]
α₃ = 0.7; 𝛏₃ = [1.4,-0.8]
α₄ = 0.7; 𝛏₄ = [-1.5,0.5]
#α₅ = 0.7; 𝛏₅ = [0.0,-2.0]
#α₆ = 0.7; 𝛏₆ = [0.0,2.2]
f₀ = 1/6T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/24)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
#r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆],[α₁,α₂,α₃,α₄,α₅,α₆],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = -5.0e-9:1.0e-10:95.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scene2Dplot([q],r,[z])