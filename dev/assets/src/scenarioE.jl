path = "docs/src/assets/"

using LTVsystems
using Plots
tₚ = 1.0e-06 
𝐩ₛ₁ =  [-0.75e-06c, 0.0]
𝐩ᵣ₁ =  [-0.15e-06c, 0.0]
𝐩ₛ₂ =  [0.75e-06c, 0.0]
𝐩ᵣ₂ =  [1.5e-06c, 0.0]
𝐩ₛ₃ =  [2.1e-06c, 0.0]
𝐩ᵣ₃ =  [2.85e-06c, 0.0]
p(t) = δn(t-tₚ,1.5e-07)
q₁ = LTIsourceO(𝐩ₛ₁, p)
q₂ = LTIsourceO(𝐩ₛ₂, p)
q₃ = LTIsourceO(𝐩ₛ₃, p)
#Multiple Targets
α₁ = -0.7; 𝛏₁ = [3.6e-06c,3.6e-06c]
r₁ = pointReflector(𝛏₁,α₁,[q₁])
r₂ = pointReflector(𝛏₁,α₁,[q₂])
r₃ = pointReflector(𝛏₁,α₁,[q₃])

# Observed signal
z₁ = LTIreceiverO([r₁],𝐩ᵣ₁)
z₂ = LTIreceiverO([r₂],𝐩ᵣ₂)
z₃ = LTIreceiverO([r₃],𝐩ᵣ₃)

t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p2,t,z₂(t))
plot!(p2,t,z₃(t))
plot(p1,p2,layout=(2,1),size=(800,800))



png(path*"scenarioE_signal.png")

scenePlot2D([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃])

png(path*"scenarioE.png")

f₁(ξ::Vector{Float64})=(z₁(tₚ+(norm(ξ-𝐩ₛ₁) .+ norm(𝐩ᵣ₁-ξ))./c))./(A(norm(ξ-𝐩ₛ₁)./c).*A(norm(𝐩ᵣ₁-ξ)./c))
f₂(ξ::Vector{Float64})=(z₂(tₚ+(norm(ξ-𝐩ₛ₂) .+ norm(𝐩ᵣ₂-ξ))./c))./(A(norm(ξ-𝐩ₛ₂)./c).*A(norm(𝐩ᵣ₂-ξ)./c))
f₃(ξ::Vector{Float64})=(z₃(tₚ+(norm(ξ-𝐩ₛ₃) .+ norm(𝐩ᵣ₃-ξ))./c))./(A(norm(ξ-𝐩ₛ₃)./c).*A(norm(𝐩ᵣ₃-ξ)./c))


f(ξ::Vector{Float64})=f₁(ξ).+f₂(ξ).+f₃(ξ)
inversePlot2D([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃],f)

png(path*"scenarioE_simulation.png")

# Target estimation
f_new(ξ::Vector{Float64})=f₁(ξ).*f₂(ξ).*f₃(ξ)
#SPATIAL SIMULATION
inversefinalPlot2D([q₁,q₂,q₃],[z₁,z₂,z₃],f_new)

png(path*"scenarioE_target_estimation.png")


#Δpos = 0.01
#x_range = collect(-3:Δpos:3)
#y_range = collect(-3:Δpos:3)
#xyGrid = [[x, y] for x in x_range, y in y_range]
#val11 = [f_new(𝐮) for 𝐮 ∈ xyGrid]
#plot(x_range,y_range,transpose(val11),st=:surface,camera=(0,90),
#         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
