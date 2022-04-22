path = "docs/src/assets/"

using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
R₁ = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([R₁],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_signal.png")

#----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64}) = (z(2(norm(ξ-𝐩ₛ))./𝕔))./
                        (A(norm(ξ-𝐩ₛ)./𝕔))^2
#SPATIAL SIMULATION
inverse2D([q],[R₁],[z],f)
png(path*"scenarioA_simulation.png")
