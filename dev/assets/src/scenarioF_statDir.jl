
path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 # in microseconds
T  = 15.0e-6
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = 0.7; 𝛏₁ = [0.11c*T,-0.07c*T]
α₂ = 0.7; 𝛏₂ = [0.09c*T,0.04c*T]
α₃ = 0.7; 𝛏₃ = [0.22c*T,0.20c*T]
f₀ = 1/T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/16)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
#r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅],[α₁,α₂,α₃,α₄,α₅],[q])
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/100:5T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scenePlot2D([q],r,[z],T)

#scene2Dmultidirplot([q₁],R₁,[z₁],[𝐛₁,𝐛₂,𝐛₃,𝐛₄])
#([q₁],𝐑₁,[z₁],[𝐛₁,𝐛₂,𝐛₃])
png(path*"scenarioF_STATD.png")

png(path*"scenarioFSTAT_signal.png")

#zₜ = PulseTrainReceivers(z,T)


M=10
fm(ξ::Vector{Float64}) = [z(tₚ+(k-1)*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*G(angleBetween(𝐛(tₚ-(k-1)T), ξ.-𝐩ₛ))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)) for k∈1:M]
g(ξ::Vector{Float64}) = sum(fm(ξ)[i] for i ∈ 1:M )

inversePlot2D([q],r,[z],g,T)




Dₛ1(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
Dₛ2(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-T), ξ.-𝐩ₛ))
Dₛ3(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
Dₛ4(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))
Dₛ5(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-4T), ξ.-𝐩ₛ))

f1(ξ::Vector{Float64}) = (z(tₚ+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ1(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

f2(ξ::Vector{Float64}) = (z(tₚ+T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ2(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

f3(ξ::Vector{Float64}) = (z(tₚ+2T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ3(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

f4(ξ::Vector{Float64}) = (z(tₚ+3T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ4(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

f5(ξ::Vector{Float64}) = (z(tₚ+4T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ5(ξ))/
                          (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))                        

f(ξ::Vector{Float64}) = f1(ξ).+ f2(ξ) .+f3(ξ).+f4(ξ).+f5(ξ)
inversePlot2D([q],r,[z],f,T)




p11 = inversePlot2D([q],r,[z],f1,T)
p12 = inversePlot2D([q],r,[z],f2,T)
p13 = inversePlot2D([q],r,[z],f3,T)
p14 = inversePlot2D([q],r,[z],f4,T)
p15 = inversePlot2D([q],r,[z],f5,T)
plot(p11,p12,p13,p14,p15,layout=(5,1),size=(2000,2000))

scene2Dplot([q],r,[z])