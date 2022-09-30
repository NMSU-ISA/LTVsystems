path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)+ δn(t-0.5e-9-3T,1.0e-10)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.0,0.0]
α₂ = 0.6; 𝛏₂ = [-1.0,0.0]
α₃ = 0.6; 𝛏₃ = [0.0,1.0]
α₄ = 0.5; 𝛏₄ = [0.0,-1.0]

#ω = T/4
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
#𝐛(t) = 𝐛(t)/norm(𝐛(t))
#t = 0.0:1.0e-10:4T
#plot(t,getindex.(𝐛.(t),1))

function beam(t::Float64)
    return ifelse(0.0<t<T,𝐛(t) , ifelse(T<t<2T, 𝐛(t-T), ifelse(2T<t<3T, 𝐛(t-2T), 𝐛(t-3T))))
end

G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)

q = STATsourceD(𝐩ₛ,p,beam,G)

#q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])

z = STATreceiverD(r,𝐩ᵣ,beam,G)
#z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

t = -5.0e-9:1.0e-10:75.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scene2Dplot([q],r,[z])

#scene2Dmultidirplot([q₁],R₁,[z₁],[𝐛₁,𝐛₂,𝐛₃,𝐛₄])
#([q₁],𝐑₁,[z₁],[𝐛₁,𝐛₂,𝐛₃])
png(path*"scenarioE_STATD.png")

png(path*"scenarioESTAT_signal.png")





function beamtime(t::Float64)
    return ifelse(0.0<t<T,beam(t) , ifelse(T<t<2T, beam(t+T), ifelse(2T<t<3T, beam(t+2T), beam(t+3T))))
end




Dᵣ(ξ::Vector{Float64}) = G(angleBetween(beamtime((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(beamtime((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

#Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c.-T), ξ.-𝐩ᵣ))
#Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c.-T), ξ.-𝐩ₛ))

zₜ = PulseTrainReceivers(z,T)


f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dᵣ(ξ).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

#f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

inverse2Dplot([q],r,[z],f)



png(path*"scenarioESTAT_simulation.png")










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