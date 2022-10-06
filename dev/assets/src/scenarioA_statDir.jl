path = "docs/src/assets/"

using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
#𝐛(t) = [cos(2π*t),sin(2π*t)] #/(norm(cos(2π*10*t)))
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)

#TEMPORAL SIMULATION
t = -5.5e-9:1.0e-10:25.5e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


#plot(t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_STATDirsignal.png")


Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(2norm(ξ-𝐩ₛ)/c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)

png(path*"scenarioA_STATDirsimulation.png")























##########################################################
p(t) = δn(t-0.5e-09,1.0e-10)
#𝐛(t) = [cos(2π*t),sin(2π*t)] #/(norm(cos(2π*10*t)))
𝐛(t) = [cos(2π*10*(t-0.5e-09)),0.0]/(norm(cos(2π*10*(t-0.5e-09))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [0.9,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)

#TEMPORAL SIMULATION
t = -5.5e-9:1.0e-10:25.5e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


#plot(t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

#png(path*"scenarioA_STATDirsignal.png")


Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(2norm(ξ-𝐩ₛ)/c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(0.5e-09+2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)

png(path*"scenarioA_STATDirsimulation.png")
