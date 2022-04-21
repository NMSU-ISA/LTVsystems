using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₀, t->α₀*q(𝛏₀,t))
z = LTIreceiverO([R₁],𝐩ᵣ)

f(ξ::Vector{Float64}) = (z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./
                        ((A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2)

inverse2D([q],[R₁],[z],f)
