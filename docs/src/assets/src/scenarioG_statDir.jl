
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = 0.7; 𝛏₁ = [0.15c*T,0.11c*T]
α₂ = 0.7; 𝛏₂ = [0.12c*T,-0.12c*T] 
α₃ = 0.7; 𝛏₃ = [-0.15c*T,0.14c*T]
α₄ = 0.7; 𝛏₄ = [-0.12c*T,-0.15c*T]  
α₅ = 0.7; 𝛏₅ = [0.2c*T,0.0]
α₆ = 0.7; 𝛏₆ = [0.0,0.2c*T]
α₇ = 0.7; 𝛏₇ = [0.0,-0.2c*T]
α₈ = 0.7; 𝛏₈ = [-0.2c*T,0.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/12)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/100:4T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scene2Dplot([q],r,[z]) 



Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-0T), ξ.-𝐩ₛ))
Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-1T), ξ.-𝐩ₛ))
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))

f₁(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+0*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₁(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2))
f₂(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+1*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₂(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2))
f₃(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+2*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₃(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2))
f₄(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+3*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₄(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2))

f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)

p11 = inversePlot2D([q],r,[z],f₁,T)
p12 = inversePlot2D([q],r,[z],f₂,T)
p13 = inversePlot2D([q],r,[z],f₃,T)
p14 = inversePlot2D([q],r,[z],f₄,T)
plot(p11,p12,p13,p14,layout=(2,2),size=(1000,1000))

f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)
inversePlot2D([q],r,[z],f,T)



#-------------------------------------------------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = 0.7; 𝛏₁ = [0.15c*T,0.11c*T]
α₂ = 0.7; 𝛏₂ = [0.12c*T,-0.12c*T] 
α₃ = 0.7; 𝛏₃ = [-0.15c*T,0.14c*T]
α₄ = 0.7; 𝛏₄ = [-0.12c*T,-0.15c*T]  
α₅ = 0.7; 𝛏₅ = [0.2c*T,0.0]
α₆ = 0.7; 𝛏₆ = [0.0,0.2c*T]
α₇ = 0.7; 𝛏₇ = [0.0,-0.2c*T]
α₈ = 0.7; 𝛏₈ = [-0.2c*T,0.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/12)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/100:4T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
