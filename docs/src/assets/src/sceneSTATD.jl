path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.1c, 0.0]
𝐩ᵣ = [0.11c, 0.02c]
T  = 10
p(t) = δn(t-0.5,0.1) + δn(t-0.5-T,0.1) + δn(t-0.5-2T,0.1)

α₁ = 0.7; 𝛏₁ = [0.12c,0.0] 
#α₂ = 0.6; 𝛏₂ = [0.5c,0.5c]
#α₃ = 0.5; 𝛏₃ = [0.7c,0.2c]

ω = T*1.0e09/3

𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)

q = STATsourceD(𝐩ₛ,p,𝐛,G)
#r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
#z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
r = pointReflector(𝛏₁,α₁,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)

t = 0.0:0.1:35
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scene2Dplot([q],[r],[z])
#plot(t,p)

# when time in nanoseconds

using LTVsystems
using Plots
𝐩ₛ = [0.1, 0.0]
𝐩ᵣ = [0.4, 0.2]
T  = 20.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)

α₁ = 0.7; 𝛏₁ = [1.8,0.0]
α₂ = 0.6; 𝛏₂ = [1.1,1.1]
α₃ = 0.5; 𝛏₃ = [2.0,-0.2] 

ω = T/3
𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)

q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
#r = pointReflector(𝛏₁,α₁,q)
#z = STATreceiverD([r],𝐩ᵣ,𝐛,G)

t = 0.0:1.0e-10:55.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


scene2Dplot([q],r,[z])

png(path*"scenarioD_STATDsignal1.png")

#Inverse modeling

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))


#znew = PulseTrainReceivers(z,T)
zₜ = PulseTrainReceivers(z,T)

f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dᵣ(ξ).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))


inverse2Dplot([q],r,[z],f)

png(path*"scenarioD_STATDsimulationnew.png")






















#δn(t-T,1.0e-10) + δn(t-2T,1.0e-10) + δn(t-3T,1.0e-10)
#Reflectors
#α₁ = 0.7; 𝛏₁ = [1.0,0.0]
#α₂ = 0.7; 𝛏₂ = [-1.0,0.0]
#α₃ = 0.7; 𝛏₃ = [0.0,1.0]
#α₄ = 0.7; 𝛏₄ = [0.0,-1.0]


#zₚ(t)= ifelse(0.0<t<T,t->z(t),ifelse(T<t<2T,t->z(t+T),t->z(t+2T)))
#output(t) = similar(zₚ(t), typeof(z))
#z_new = NewSources(zₚ)

#zz(t) = NewSources(ifelse(0.0<t<T, t->z(t), ifelse(T<t<2T, t->z(t+T), t->z(t+2T))))

#temp(t)=ifelse(0.0<t<T, t->z(t), ifelse(T<t<2T, t->z(t+T), t->z(t+2T)))
#function mytemp(z,t)
#      return ifelse(0.0<t<T, z(t), ifelse(T<t<2T, z(t+T), z(t+2T)))
#end
