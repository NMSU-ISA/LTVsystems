using LTVsystems
using Plots
𝐩ₛ = [0.1, 0.0]
𝐩ᵣ = [0.4, 0.2]
T  = 20.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
α₂ = 0.6; 𝛏₂ = [1.1,1.1]
α₃ = 0.5; 𝛏₃ = [2.0,-0.2]
f₀ = 1/3T
𝐛(t) = [cos(2π*f₀*t), sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

function beam(t::Float64)
    return ifelse(0.0<t<T,𝐛(t) , ifelse(T<t<2T, 𝐛(T+t), 𝐛(2T+t)))
end


#Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
zₜ = PulseTrainReceivers(z,T)
f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)