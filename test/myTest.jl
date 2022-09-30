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
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)


#t = 0.0:1.0e-10:4T
# plot(t,getindex.(𝐛.(t),1))

q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

t = -5.0e-9:1.0e-10:75.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scene2Dplot([q],r,[z])

#scene2Dmultidirplot([q₁],R₁,[z₁],[𝐛₁,𝐛₂,𝐛₃,𝐛₄])
#([q₁],𝐑₁,[z₁],[𝐛₁,𝐛₂,𝐛₃])
png(path*"scenarioE_STATDir_signal.png")

# Inverse Modeling


function beam(t::Float64)
    return ifelse(0.0<t<T,𝐛(t) , ifelse(T<t<2T, 𝐛(T+t), ifelse(2T<t<3T, 𝐛(2T+t), 𝐛(3T+t))))
end



Dₛ(ξ::Vector{Float64}) = G(angleBetween(beam(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c, ξ.-𝐩ₛ))

zₜ = PulseTrainReceivers(z,T)

f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)


png(path*"scenarioE_STATDir_simulation.png")














#---------------------------------------------------
#line plus point reflector
using LTVsystems
using Plots, QuadGK
𝐩ₛ =  [0.0, 0.0]
p(t) = δn(t,1.0e-10)
# Signal observed due to source
q = LTIsourceO(𝐩ₛ, p)
#Reflectors
α₀ = 0.7; 𝛏₀ = [0.3,0.1]; 𝛖 = [1.0,0.0]; len=1.0
r = lineSegment(𝛏₀,𝛖,len,k->α₀,[q])

α₁ = 0.5; 𝛏₁ = [0.0,1.8]
R₁ = pointReflector(𝛏₁,α₁,[q])
# Observed signal
𝐩ᵣ =  [0.0, 0.0]
z = LTIreceiverO([R₁,r],𝐩ᵣ)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

scene2Dplot([q],[R₁,r],[z])

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))
inverse2Dplot([q],[R₁,r],[z],f)
