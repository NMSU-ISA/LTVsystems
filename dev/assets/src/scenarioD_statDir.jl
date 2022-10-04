path = "docs/src/assets/"
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
t = 0.0:1.0e-10:55.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioD_STATDsignal.png")
# Inverse modeling

Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
zₜ = PulseTrainReceivers(z,T)
f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)


png(path*"scenarioD_STATDsimulation.png")





































function beam(t::Float64)
    return ifelse(0.0<t<T,𝐛(t) , ifelse(T<t<2T, 𝐛(T+t), 𝐛(2T+t)))
end

zₜ = PulseTrainReceivers(z,T)

#Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

Dₛ1(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
Dₛ2(ξ::Vector{Float64}) = G(angleBetween(𝐛(T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
Dₛ3(ξ::Vector{Float64}) = G(angleBetween(𝐛(2T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))


f1(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ1(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
f2(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ2(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
f3(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ3(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))  

f(ξ::Vector{Float64}) = f1(ξ) .+ f2(ξ) .+ f3(ξ)               
inverse2Dplot([q],r,[z],f)

p11 = inverse2Dplot([q],r,[z],f1)
p12 = inverse2Dplot([q],r,[z],f2)
p13 = inverse2Dplot([q],r,[z],f3)

plot(p11,p12,p13,layout=(3,1))