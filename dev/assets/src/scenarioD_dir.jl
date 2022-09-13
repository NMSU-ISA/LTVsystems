path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
#p(t) = δn(t,1.0e-10) + δn(t,2.0e-10) + δn(t,4.0e-10)
p₁(t) = δn(t,1.0e-10)
p₂(t) = δn(t+2.0,1.0e-10)
p₃(t) = δn(t+4.0,1.0e-10)
𝐛 = [2.0,0.0]
G₁(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/2)
G₂(θ) = 𝒩ᵤ(θ, μ=0.0, σ=2π/3)
G₃(θ) = 𝒩ᵤ(θ, μ=0.0, σ=2π/5)
#q = LTIsourceO(𝐩ₛ, p)
q₁ = LTIsourceDTI(𝐩ₛ,p₁,𝐛,G₁)
q₂ = LTIsourceDTI(𝐩ₛ,p₂,𝐛,G₂)
q₃ = LTIsourceDTI(𝐩ₛ,p₃,𝐛,G₃)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₁,q₂,q₃])
#r₁ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₁])
#r₂ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₂])
#r₃ = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q₃])

z₁ = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G₁)
z₂ = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G₂)
z₃ = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G₃)

t = collect(0.0:1.0e-10:25.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))

Dᵣ1(ξ::Vector{Float64}) = G₁(angleBetween(𝐛, ξ.-𝐩ᵣ))
Dₛ1(ξ::Vector{Float64}) = G₁(angleBetween(𝐛, ξ.-𝐩ₛ))

Dᵣ2(ξ::Vector{Float64}) = G₂(angleBetween(𝐛, ξ.-𝐩ᵣ))
Dₛ2(ξ::Vector{Float64}) = G₂(angleBetween(𝐛, ξ.-𝐩ₛ))

Dᵣ3(ξ::Vector{Float64}) = G₃(angleBetween(𝐛, ξ.-𝐩ᵣ))
Dₛ3(ξ::Vector{Float64}) = G₃(angleBetween(𝐛, ξ.-𝐩ₛ))


f₁(ξ::Vector{Float64}) = z₁((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c).*Dₛ1(ξ::Vector{Float64}).*Dᵣ1(ξ::Vector{Float64})
f₂(ξ::Vector{Float64}) = z₂((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c).*Dₛ2(ξ::Vector{Float64}).*Dᵣ2(ξ::Vector{Float64})
f₃(ξ::Vector{Float64}) = z₃((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c).*Dₛ3(ξ::Vector{Float64}).*Dᵣ3(ξ::Vector{Float64})

f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64})

inverse2Dplot([q₁,q₂,q₃],r,[z₁,z₂,z₃],f)


f_new(ξ::Vector{Float64})=(f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64}))^(1/3)
#SPATIAL SIMULATION
inverse2Dfinalplot([q],[z₁,z₂,z₃],f_new)
