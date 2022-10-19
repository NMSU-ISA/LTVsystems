path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 # in microseconds
T  = 15.0e-6
p(t) = δn(t-tₚ,1.0e-07) + δn(t-T-tₚ,1.0e-07) + δn(t-2T-tₚ,1.0e-07)+ δn(t-3T-tₚ,1.0e-07)
α₁ = 0.7; 𝛏₁ = [0.2c*T,0.0]
α₂ = 0.7; 𝛏₂ = [-0.2c*T,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,0.2c*T]
α₄ = 0.7; 𝛏₄ = [0.0,-0.2c*T]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/12)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/100:4T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scenePlot2D([q],r,[z],T)

#scene2Dmultidirplot([q₁],R₁,[z₁],[𝐛₁,𝐛₂,𝐛₃,𝐛₄])
#([q₁],𝐑₁,[z₁],[𝐛₁,𝐛₂,𝐛₃])
png(path*"scenarioE_STATD.png")

png(path*"scenarioESTAT_signal.png")

# Inverse Modeling
#zₜ = PulseTrainReceivers(z,T)

Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f₁(ξ::Vector{Float64}) = (z(tₚ+2(norm(ξ-𝐩ₛ))/c).*Dₛ₁(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-T), ξ.-𝐩ₛ))
f₂(ξ::Vector{Float64}) = (z(tₚ.+T+2(norm(ξ-𝐩ₛ))/c).*Dₛ₂(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
f₃(ξ::Vector{Float64}) = (z(tₚ.+2T+2(norm(ξ-𝐩ₛ))/c).*Dₛ₃(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))
f₄(ξ::Vector{Float64}) = (z(tₚ.+3T+2(norm(ξ-𝐩ₛ))/c).*Dₛ₄(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)
p11 = inversePlot2D([q],r,[z],f₁,T)
p12 = inversePlot2D([q],r,[z],f₂,T)
p13 = inversePlot2D([q],r,[z],f₃,T)
p14 = inversePlot2D([q],r,[z],f₄,T)
plot(p11,p12,p13,p14,layout=(2,2),size=(1000,1000))

f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)

inversePlot2D([q],r,[z],f,T)
png(path*"scenarioESTAT_simulation.png")


p11 = inverse2Dplot([q],r,[z],f₁)
p12 = inverse2Dplot([q],r,[z],f₂)
p13 = inverse2Dplot([q],r,[z],f₃)
p14 = inverse2Dplot([q],r,[z],f₄)

plot(p11,p12,p13,p14,layout=(2,2),size=(1000,1000))

png(path*"scenarioESTAT_simulationaall2.png")





























Dₛ(ξ::Vector{Float64}) = G(angleBetween(getindex(zc.((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c),2), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))



function beam(t::Float64)
     return ifelse(0.0<t<T,𝐛(t) , ifelse(T<t<2T, 𝐛(T+t), ifelse(2T<t<3T, 𝐛(2T+t), 𝐛(3T+t))))
 end
                      
                      
Dₛ(ξ::Vector{Float64}) = G(angleBetween(beam((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
                      
f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                                              (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
                      
 inverse2Dplot([q],r,[z],f)




 Δpos = 0.001
 x_min = -4.0
 x_max = 4.0
 y_min = -4.0
 y_max = 4.0







#q₁ = LTIsourceDTI(𝐩ₛ,p,𝐛₁,G)
#q₂ = LTIsourceDTI(𝐩ₛ,p,𝐛₂,G)
#q₃ = LTIsourceDTI(𝐩ₛ,p,𝐛₃,G)
#q₄ = LTIsourceDTI(𝐩ₛ,p,𝐛₄,G)
#q = LTIsourceO(𝐩ₛ,p)

#R₁ = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q₁])
#R₂ = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q₂])
#R₃ = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q₃])
#R₄ = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q₄])

#z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
#z = LTIreceiverO(r,𝐩ᵣ)
#z₁ = LTIreceiverDTI(R₁,𝐩ᵣ,𝐛₁,G)
#z₂ = LTIreceiverDTI(R₂,𝐩ᵣ,𝐛₂,G)
#z₃ = LTIreceiverDTI(R₃,𝐩ᵣ,𝐛₃,G)
#z₄ = LTIreceiverDTI(R₄,𝐩ᵣ,𝐛₄,G)
#r = pointReflector(𝛏₁,α₁,q)

#𝐛₁ = 𝛏₁/norm(𝛏₁)
#𝐛₂ = 𝛏₂/norm(𝛏₂)
#𝐛₃ = 𝛏₃/norm(𝛏₃)
#𝐛₄ = 𝛏₄/norm(𝛏₄)

#Dᵣ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛₁, ξ.-𝐩ᵣ))
#Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛₁, ξ.-𝐩ₛ))

#Dᵣ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛₂, ξ.-𝐩ᵣ))
#Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛₂, ξ.-𝐩ₛ))

#Dᵣ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛₃, ξ.-𝐩ᵣ))
#Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛₃, ξ.-𝐩ₛ))

#Dᵣ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛₄, ξ.-𝐩ᵣ))
#Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛₄, ξ.-𝐩ₛ))


#zₜ₁ = PulseTrainReceivers(z₁,T)
#zₜ₂ = PulseTrainReceivers(z₂,T)
#zₜ₃ = PulseTrainReceivers(z₃,T)
#zₜ₄ = PulseTrainReceivers(z₄,T)

#f₁(ξ::Vector{Float64}) = (zₜ₁((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ₁(ξ::Vector{Float64}).*Dᵣ₁(ξ::Vector{Float64}))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
#f₂(ξ::Vector{Float64}) = (zₜ₂((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ₂(ξ::Vector{Float64}).*Dᵣ₂(ξ::Vector{Float64}))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
#f₃(ξ::Vector{Float64}) = (zₜ₃((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ₃(ξ::Vector{Float64}).*Dᵣ₃(ξ::Vector{Float64}))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
#f₄(ξ::Vector{Float64}) = (zₜ₄((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ₄(ξ::Vector{Float64}).*Dᵣ₄(ξ::Vector{Float64}))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))


#fnew(ξ::Vector{Float64}) = f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64}).*f₄(ξ::Vector{Float64})


#f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64}).+f₄(ξ::Vector{Float64})

#inverse2Dplot([q₁],R₁,[z₁],f)

#png(path*"scenarioGLTIDir2_simulation.png")