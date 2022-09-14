using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
R₁ = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([R₁,q],𝐩ᵣ)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


#f(ξ::Vector{Float64}) = z(2(norm(ξ-𝐩ₛ))./c)./(A(norm(ξ-𝐩ₛ)./c))^2

#inverse2Dplot([q],[R₁],[z],f)

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
