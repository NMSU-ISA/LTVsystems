path = "docs/src/assets/"

#---------------------------STATsourceD and LTIreceiverO-----------------------

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
T  = 15.0e-6 
𝐩ᵣ = 𝐩ₛ 
#𝐩ᵣ = [-0.08c*T, 0.0]
tₚ = 1.0e-06 # in microseconds
D = 4 
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.2c*T,0.0]
α₂ = -0.7; 𝛏₂ = [-0.2c*T,0.0]
α₃ = -0.7; 𝛏₃ = [0.0,0.2c*T]
α₄ = -0.7; 𝛏₄ = [0.0,-0.2c*T]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scenePlot2D([q],r,[z])


png(path*"scenarioE_STATD.png")

png(path*"scenarioESTAT_signal.png")


Dₛₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T), ξ.-𝐩ₛ))
fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛₖ(ξ,k))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))) 
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)


f(ξ::Vector{Float64}) = fₖ(ξ,2)
inversePlot2D([q],r,[z],f)




#---------------LTIsourceO AND STATreceiverD-----------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
T  = 15.0e-6 
𝐩ᵣ = 𝐩ₛ
#𝐩ᵣ = [0.15c*T, 0.0]
tₚ = 1.0e-06 # in microseconds
D = 4
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.2c*T,0.0]
α₂ = -0.7; 𝛏₂ = [-0.2c*T,0.0]
α₃ = -0.7; 𝛏₃ = [0.0,0.2c*T]
α₄ = -0.7; 𝛏₄ = [0.0,-0.2c*T]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/32)
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scenePlot2D([q],r,[z],T)


png(path*"scenarioE_STATD.png")

png(path*"scenarioESTAT_signal.png")

#.+((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c)/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)

Dᵣₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T), 𝐩ᵣ.-ξ))

fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dᵣₖ(ξ,k))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)


f(ξ::Vector{Float64}) = fₖ(ξ,2)
inversePlot2D([q],r,[z],f)

png(path*"scenarioESTAT_simulation.png")
























