path = "docs/src/assets/"

using LTVsystems, Plots
tₚ = 1.0e-06 # in microseconds
T  = 15.0e-6
𝐩ₛ =  [0.1c*T, 0.0]
𝐩ᵣ =  [-0.1c*T, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t=0.0:T/100:2T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioB_STATDirsignal.png")


#Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ.+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#SPATIAL SIMULATION
inversePlot2D([q],[r],[z],f,T)

png(path*"scenarioB_STATDirsimulation.png")
