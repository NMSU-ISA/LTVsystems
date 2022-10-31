path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 #pulse period
D = 30 #pulses per revolution

p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.18c*T,0.12c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.22c*T]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.18c*T]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [-0.10c*T,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


scenePlot2D([q],r,[z]) 



png(path*"scenarioD_STATDirsignal.png")




Dₛₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T), ξ.-𝐩ₛ))
fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T+(2norm(ξ-𝐩ₛ))./c).*Dₛₖ(ξ,k)./(A(norm(ξ-𝐩ₛ)/c))^2)) 
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)

png(path*"scenarioD_STATDsimulation.png")
