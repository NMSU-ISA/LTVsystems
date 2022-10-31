path = "docs/src/assets/"

using LTVsystems
using Plots
tₚ = 1.0e-06 # in microseconds
𝐩ₛ =  [0.1c*T, 0.0]
𝐩ᵣ =  [-0.1c*T, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)

#TEMPORAL SIMULATION
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioB_STATDirsignal.png")

Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ.+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#SPATIAL SIMULATION
inversePlot2D([q],[r],[z],f)

png(path*"scenarioB_STATDirsimulation.png")
