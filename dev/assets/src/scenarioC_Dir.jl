path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
T  = 15.0e-6
tₚ = 1.0e-06
p(t) = δn(mod(t-tₚ,T),1.0e-7)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/48)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
α₁ = -0.7; 𝛏₁ = [-3.75e-06c,0.0]
r = pointReflector([𝛏₀,𝛏₁],[α₀,α₁],[q])
z = LTIreceiverO(r,𝐩ᵣ)
#TEMPORAL SIMULATION
t=0.0:T/100:5T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))

png(path*"scenarioC_LTIDirsignal.png")

scenedirPlot2D([q],r,[z],𝐛)

png(path*"scenarioC_LTIDir.png")

Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ₛ))

f₁(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (0.75e-01randn(1)[1]+ z(tₚ+0*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2))
f₂(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (0.75e-01randn(1)[1]+z(tₚ+1*T+(2norm(ξ-𝐩ₛ))./c).*(Dₛ(ξ))^2 ./(A(norm(ξ-𝐩ₛ)/c))^2))
f₃(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (0.75e-01randn(1)[1]+ z(tₚ+2*T+(2norm(ξ-𝐩ₛ))./c).*(Dₛ(ξ))^2 ./(A(norm(ξ-𝐩ₛ)/c))^2))
f₄(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (0.75e-01randn(1)[1]+ z(tₚ+3*T+(2norm(ξ-𝐩ₛ))./c).*(Dₛ(ξ))^2 ./(A(norm(ξ-𝐩ₛ)/c))^2))
f₅(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, (0.75e-01randn(1)[1]+ z(tₚ+4*T+(2norm(ξ-𝐩ₛ))./c).*(Dₛ(ξ))^2 ./(A(norm(ξ-𝐩ₛ)/c))^2))
f(ξ::Vector{Float64}) = (f₁(ξ).+f₂(ξ).+f₃(ξ).+f₄(ξ).+f₅(ξ))/5

p11=inversePlot2D([q],r,[z],f₁)

png(path*"scenarioC_LTIDir_simulation1.png")

p12=inversePlot2D([q],r,[z],f₂)

png(path*"scenarioC_LTIDir_simulation2.png")

p13=inversePlot2D([q],r,[z],f₃)

png(path*"scenarioC_LTIDir_simulation3.png")

p14=inversePlot2D([q],r,[z],f₄)

png(path*"scenarioC_LTIDir_simulation4.png")

p15=inversePlot2D([q],r,[z],f₅)

png(path*"scenarioC_LTIDir_simulation5.png")

p6=inversePlot2D([q],r,[z],f)
#plot(p11,p12,p13,p14,p15,p6,layout=(3,2),size=(1000,1000))

png(path*"scenarioC_LTIDir_simulation.png")








#--------old example----------------------
using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/3)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
#Reflectors
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioC_LTIDirsignal.png")

scene2Dplot([q],r,[z])


scene2Ddirplot([q],r,[z],𝐛)
png(path*"scenarioC_LTIDir.png")

#Inverse modeling

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#SPATIAL SIMULATION
inverse2Dplot([q],r,[z],f)

png(path*"scenarioC_DirTIsimulation.png")
