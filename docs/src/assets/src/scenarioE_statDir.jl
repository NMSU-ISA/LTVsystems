path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)+ δn(t-0.5e-9-3T,1.0e-10)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.0,0.0]
α₂ = 0.6; 𝛏₂ = [-1.0,0.0]
α₃ = 0.6; 𝛏₃ = [0.0,1.0]
α₄ = 0.5; 𝛏₄ = [0.0,-1.0]

#ω = T/4
#𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]
#𝐛 = [1.0, 0.0]
#G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)

#q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
q = LTIsourceO(𝐩ₛ,p)
#q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector(𝛏₁,α₁,[q])
#r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
#z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
z = LTIreceiverO([r],𝐩ᵣ)
#z = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G)
#r = pointReflector(𝛏₁,α₁,q)
#z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

t = -5.0e-9:1.0e-10:75.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scene2Dplot([q],r,[z])



plot(t,abs.(z(t)))




png(path*"scenarioE_STATDirsignal.png")


#Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
#Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ₛ))

#znew = PulseTrainReceivers(z,T)
zₜ = PulseTrainReceivers(z,T)

f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dᵣ(ξ).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)



png(path*"scenarioE_STATDirsimulation.png")
