path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
#p(t) = δn(t,1.0e-10) + δn(t+15e-10,2.0e-10) + δn(t+50e-10,4.0e-10)
p₁(t) = δn(t,2.0e-10)
p₂(t) = δn(t+25e-10,2.0e-10)
p₃(t) = δn(t+50e-10,2.0e-10)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]

𝐛₁ = 𝛏₁/norm(𝛏₁)
𝐛₂ = 𝛏₂/norm(𝛏₂)
𝐛₃ = 𝛏₃/norm(𝛏₃)

G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/3)

#q = LTIsourceO(𝐩ₛ, p)
q₁ = LTIsourceDTI(𝐩ₛ,p₁,𝐛₁,G)
q₂ = LTIsourceDTI(𝐩ₛ,p₂,𝐛₂,G)
q₃ = LTIsourceDTI(𝐩ₛ,p₃,𝐛₃,G)

r₁ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₁])
r₂ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₂])
r₃ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₃])

z₁ = LTIreceiverDTI(r₁,𝐩ᵣ,𝐛₁,G)
z₂ = LTIreceiverDTI(r₂,𝐩ᵣ,𝐛₂,G)
z₃ = LTIreceiverDTI(r₃,𝐩ᵣ,𝐛₃,G)

t = collect(0.0:1.0e-10:20.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))

png(path*"scenarioD_LTIDirsignal.png")

scene2Dplot([q₁],r₁,[z₁])

png(path*"scenarioD_LTIDir.png")


Dᵣ1(ξ::Vector{Float64}) = G(angleBetween(𝐛₁, ξ.-𝐩ᵣ))
Dₛ1(ξ::Vector{Float64}) = G(angleBetween(𝐛₁, ξ.-𝐩ₛ))

Dᵣ2(ξ::Vector{Float64}) = G(angleBetween(𝐛₂, ξ.-𝐩ᵣ))
Dₛ2(ξ::Vector{Float64}) = G(angleBetween(𝐛₂, ξ.-𝐩ₛ))

Dᵣ3(ξ::Vector{Float64}) = G(angleBetween(𝐛₃, ξ.-𝐩ᵣ))
Dₛ3(ξ::Vector{Float64}) = G(angleBetween(𝐛₃, ξ.-𝐩ₛ))


f₁(ξ::Vector{Float64}) = z₁((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c).*Dₛ1(ξ::Vector{Float64}).*Dᵣ1(ξ::Vector{Float64})
f₂(ξ::Vector{Float64}) = z₂((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c).*Dₛ2(ξ::Vector{Float64}).*Dᵣ2(ξ::Vector{Float64})
f₃(ξ::Vector{Float64}) = z₃((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c).*Dₛ3(ξ::Vector{Float64}).*Dᵣ3(ξ::Vector{Float64})

f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64})

inverse2Dplot([q₁],r₁,[z₁],f)

png(path*"scenarioD_DirTIsimulation.png")
