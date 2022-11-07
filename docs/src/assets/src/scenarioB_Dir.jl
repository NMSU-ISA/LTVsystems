path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.5e-06c, 0.0]
tₚ = 1.0e-06 # in microseconds
p(t) = δn(t-tₚ,1.0e-07)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
α₁ = -0.7; 𝛏₁ = [-3.75e-06c,0.0]
r = pointReflector([𝛏₀,𝛏₁],[α₀,α₁],[q])
z = LTIreceiverO(r,𝐩ᵣ)
#z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))

png(path*"scenarioB_LTIDirsignal.png")

scenePlot2D([q],[r],[z])

scenedirPlot2D([q],r,[z],𝐛)

png(path*"scenarioB_LTIDir.png")


# Inverse modeling

#Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))
#.*Dᵣ(ξ::Vector{Float64})
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#SPATIAL SIMULATION
inversePlot2D([q],r,[z],f)

png(path*"scenarioB_DirTIsimulation.png")
