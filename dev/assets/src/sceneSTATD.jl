path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
T  = 10.0e-09
p(t) = δn(t,1.0e-10) + δn(t-T,1.0e-10) + δn(t-2T,1.0e-10) + δn(t-3T,1.0e-10)
#Reflectors
α₁ = 0.7; 𝛏₁ = [1.0,0.0]
α₂ = 0.6; 𝛏₂ = [-1.0,0.0]
α₃ = 0.5; 𝛏₃ = [0.0,1.0]
α₄ = 0.6; 𝛏₄ = [0.0,-1.0]

ω = 10.0e-09/4
𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]

G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/3)

q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

t = collect(0.0:1.0e-10:40.5e-9)
p1 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


png(path*"scenarioD_STATDsignal.png")
# Inverse modeling

#Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
#Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

#x_range = collect(-4.0:0.01:4.0)
#y_range = collect(-4.0:0.01:4.0)
#xyGrid = [[x, y] for x in x_range, y in y_range]
#tᵢ = 0.0
#for ξ ∈ xyGrid
#      tᵢ = (norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c
#end
#if tᵢ<T
#      td=0.0
#elseif T<tᵢ<2T
#      td=T
#elseif 2T<tᵢ<3T
#      td=2T
#else tᵢ>3T
#      td=3T
#end

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                            (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))


inverse2Dplot([q],r,[z],f)

png(path*"scenarioD_STATDsimulation.png")
