using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
tₚ = 1.0e-9

p(t) = δn(t-tₚ,1.0e-10) + δn(t-T-tₚ,1.0e-10) + δn(t-2T-tₚ,1.0e-10)+ δn(t-3T-tₚ,1.0e-10)
α₁ = 0.7; 𝛏₁ = [2.0,0.0]
α₂ = 0.7; 𝛏₂ = [-2.0,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,2.0]
α₄ = 0.7; 𝛏₄ = [0.0,-2.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/16)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
zₜ = PulseTrainReceivers(z,T)



t = collect(0.0:T/100:5T)
plot(t,p.(t))

plot(t,z.(t))




Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f₁(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₁(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
p11 = inverse2Dplot([q],r,[z],f₁, )

plot!(size= (800,800))



Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-T), ξ.-𝐩ₛ))
f₂(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₂(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
f₃(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₃(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))
f₄(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₄(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)
p11 = inverse2Dplot([q],r,[z],f₁)
p12 = inverse2Dplot([q],r,[z],f₂)
p13 = inverse2Dplot([q],r,[z],f₃)
p14 = inverse2Dplot([q],r,[z],f₄)
plot(p11,p12,p13,p14,layout=(2,2),size=(1000,1000))