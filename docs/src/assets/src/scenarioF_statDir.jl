
path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
tₚ = 1.0e-9
p(t) = δn(mod(t-0.5e-9,T),1.0e-10)
α₁ = 0.7; 𝛏₁ = [2.0,0.0]
α₂ = 0.7; 𝛏₂ = [-2.0,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,2.0]
α₄ = 0.7; 𝛏₄ = [0.0,-2.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/16)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
#r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅],[α₁,α₂,α₃,α₄,α₅],[q])
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = -5.0e-9:1.0e-10:90.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))




zₜ = PulseTrainReceivers(z,T)

Dₛ1(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f1(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ1(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Dₛ2(ξ::Vector{Float64}) = G(angleBetween(𝐛(T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f2(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ2(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Dₛ3(ξ::Vector{Float64}) = G(angleBetween(𝐛(2T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f3(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ3(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Dₛ4(ξ::Vector{Float64}) = G(angleBetween(𝐛(3T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f4(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ4(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Dₛ5(ξ::Vector{Float64}) = G(angleBetween(𝐛(4T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f5(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ5(ξ))/
                          (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))                        

f(ξ::Vector{Float64}) = f1(ξ).+ f2(ξ) .+f3(ξ).+f4(ξ).+f5(ξ)
inverse2Dplot([q],r,[z],f)




p11 = inverse2Dplot([q],r,[z],f1)
p12 = inverse2Dplot([q],r,[z],f2)
p13 = inverse2Dplot([q],r,[z],f3)
p14 = inverse2Dplot([q],r,[z],f4)
p15 = inverse2Dplot([q],r,[z],f5)
plot(p11,p12,p13,p14,p15,layout=(5,1))

scene2Dplot([q],r,[z])