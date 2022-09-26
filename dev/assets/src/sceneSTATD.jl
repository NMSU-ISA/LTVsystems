path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.3, 0.3]
𝐩ᵣ = [0.9, 0.9]
T  = 15.0e-09
p(t) = δn(t,2.0e-10) + δn(t-T,2.0e-10) + δn(t-2T,2.0e-10)
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]

ω = T/3
𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

t = collect(-10.5e-9:1.0e-10:50.5e-9)
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioD_STATDsignal1.png")

#Inverse modeling
Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

zt=NewSources(z,T)


znew = PulseTrainReceivers(z,T)


f(ξ::Vector{Float64}) = (znew((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ).*Dᵣ(ξ))/
                           (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))


inverse2Dplot([q],r,[z],f,Δpos = 0.01,x_min = -5.0,x_max = 5.0,y_min = -5.0,y_max = 5.0)

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
