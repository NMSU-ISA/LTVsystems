path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ₁ =  [-0.8, 0.0]
𝐩ᵣ₁ =  [-0.4, 0.0]

𝐩ₛ₂ =  [0.1, 0.0]
𝐩ᵣ₂ =  [0.5, 0.0]

𝐩ₛ₃ =  [0.8, 0.0]
𝐩ᵣ₃ =  [1.2, 0.0]

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

t = 0.0:1.0e-10:15.5e-9
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))



png(path*"scenarioE_signal.png")

scene2Dplot([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃])

png(path*"scenarioE.png")

f₁(ξ::Vector{Float64})=(z₁((norm(ξ-𝐩ₛ₁) .+ norm(𝐩ᵣ₁-ξ))./c))./(A(norm(ξ-𝐩ₛ₁)./c).*A(norm(𝐩ᵣ₁-ξ)./c))
f₂(ξ::Vector{Float64})=(z₂((norm(ξ-𝐩ₛ₂) .+ norm(𝐩ᵣ₂-ξ))./c))./(A(norm(ξ-𝐩ₛ₂)./c).*A(norm(𝐩ᵣ₂-ξ)./c))
f₃(ξ::Vector{Float64})=(z₃((norm(ξ-𝐩ₛ₃) .+ norm(𝐩ᵣ₃-ξ))./c))./(A(norm(ξ-𝐩ₛ₃)./c).*A(norm(𝐩ᵣ₃-ξ)./c))


f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64})
inverse2Dplot([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃],f)

png(path*"scenarioE_simulation.png")

# Target estimation
f_new(ξ::Vector{Float64})=(f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64}))
#SPATIAL SIMULATION
inverse2Dfinalplot([q₁,q₂,q₃],[z₁,z₂,z₃],f_new)

png(path*"scenarioE_target_estimation.png")


#Δpos = 0.01
#x_range = collect(-3:Δpos:3)
#y_range = collect(-3:Δpos:3)
#xyGrid = [[x, y] for x in x_range, y in y_range]
#val11 = [f_new(𝐮) for 𝐮 ∈ xyGrid]
#plot(x_range,y_range,transpose(val11),st=:surface,camera=(0,90),
#         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
