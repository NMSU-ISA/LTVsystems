path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ₁ =  [-0.8, 0.0]
𝐩ᵣ₁ =  [-0.4, 0.0]

𝐩ₛ₂ =  [0.1, 0.0]
𝐩ᵣ₂ =  [0.5, 0.0]

𝐩ₛ₃ =  [0.9, 0.0]
𝐩ᵣ₃ =  [1.3, 0.0]

p(t) = δn(t,1.0e-10)
q₁ = LTIsourceO(𝐩ₛ₁, p)
q₂ = LTIsourceO(𝐩ₛ₂, p)
q₃ = LTIsourceO(𝐩ₛ₃, p)
#Multiple Targets
α₁ = 0.7; 𝛏₁ = [0.7,0.9]
#α₂ = 0.5; 𝛏₂ = [0.6,0.2]
#α₃ = 0.4; 𝛏₃ = [0.6,1.0]
r₁ = pointReflector(𝛏₁,α₁,[q₁])
r₂ = pointReflector(𝛏₁,α₁,[q₂])
r₃ = pointReflector(𝛏₁,α₁,[q₃])

# Observed signal
z₁ = LTIreceiverO([r₁],𝐩ᵣ₁)
z₂ = LTIreceiverO([r₂],𝐩ᵣ₂)
z₃ = LTIreceiverO([r₃],𝐩ᵣ₃)


#z₁ = LTIreceiverO([r₁,r₂,r₃],𝐩ᵣ₁)
#z₂ = LTIreceiverO([r₁,r₂,r₃],𝐩ᵣ₂)
#z₃ = LTIreceiverO([r₁,r₂,r₃],𝐩ᵣ₃)


png(path*"scenarioE_signal.png")

scene2Dplot([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃,z])

png(path*"scenarioE.png")

f₁(ξ::Vector{Float64})=(z₁((norm(ξ-𝐩ₛ₁) .+ norm(𝐩ᵣ₁-ξ))./c))./(A(norm(ξ-𝐩ₛ₁)./c).*A(norm(𝐩ᵣ₁-ξ)./c))
f₂(ξ::Vector{Float64})=(z₂((norm(ξ-𝐩ₛ₂) .+ norm(𝐩ᵣ₂-ξ))./c))./(A(norm(ξ-𝐩ₛ₂)./c).*A(norm(𝐩ᵣ₂-ξ)./c))
f₃(ξ::Vector{Float64})=(z₃((norm(ξ-𝐩ₛ₃) .+ norm(𝐩ᵣ₃-ξ))./c))./(A(norm(ξ-𝐩ₛ₃)./c).*A(norm(𝐩ᵣ₃-ξ)./c))


f₁(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ₁) .+ norm(𝐩ᵣ₁-ξ))./c))./(A(norm(ξ-𝐩ₛ₁)./c).*A(norm(𝐩ᵣ₁-ξ)./c))
f₂(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ₂) .+ norm(𝐩ᵣ₂-ξ))./c))./(A(norm(ξ-𝐩ₛ₂)./c).*A(norm(𝐩ᵣ₂-ξ)./c))
f₃(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ₃) .+ norm(𝐩ᵣ₃-ξ))./c))./(A(norm(ξ-𝐩ₛ₃)./c).*A(norm(𝐩ᵣ₃-ξ)./c))



f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64})
inverse2Dplot([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃,z],f;x_min = -3.0,x_max = 3.0,y_min = -2.0,y_max = 2.0)

png(path*"scenarioE_simulation.png")

# Target estimation
f_new(ξ::Vector{Float64})=(f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64}))^(1/3)
#SPATIAL SIMULATION
inverse2Dplot([q₁,q₂,q₃],r,[z₁,z₂,z₃],f_new;Δpos = 0.01,x_min = -3.0,x_max = 3.0,y_min = -2.0,y_max = 2.0,)

png(path*"scenarioD_target_estimation.png")
