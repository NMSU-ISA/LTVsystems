path = "docs/src/assets/"

using LTVsystems, Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
#𝐛(t) = [1.0,0.0]*t
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot(t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioB_STATDirsignal.png")


Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)

png(path*"scenarioB_STATDirsimulation.png")
