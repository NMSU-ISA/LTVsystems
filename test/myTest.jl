using LTVsystems, Plots
π©β =  [0.0, 0.0]
π©α΅£ =  [0.0, 0.0]
p(t) = Ξ΄(t,1.0e-10)
q = LTIsourceO(π©β, p)
Ξ±β = 0.7; πβ = [1.8,0.0]
Rβ = pointReflector(πβ,Ξ±β,[q])
z = LTIreceiverO([Rβ],π©α΅£)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
f(ΞΎ::Vector{Float64}) = z(2(norm(ΞΎ-π©β))./c)./(A(norm(ΞΎ-π©β)./c))^2

inverse2Dplot([q],[Rβ],[z],f)

#---------------------------------------------------
#line plus point reflector
using LTVsystems
using Plots, QuadGK
π©β =  [0.0, 0.0]
p(t) = Ξ΄n(t,1.0e-10)
# Signal observed due to source
q = LTIsourceO(π©β, p)
#Reflectors
Ξ±β = 0.7; πβ = [0.3,0.1]; π = [1.0,0.0]; len=1.0
r = lineSegment(πβ,π,len,k->Ξ±β,[q])

Ξ±β = 0.5; πβ = [0.0,1.8]
Rβ = pointReflector(πβ,Ξ±β,[q])
# Observed signal
π©α΅£ =  [0.0, 0.0]
z = LTIreceiverO([Rβ,r],π©α΅£)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

scene2Dplot([q],[Rβ,r],[z])

f(ΞΎ::Vector{Float64})=(z((norm(ΞΎ-π©β) .+ norm(π©α΅£-ΞΎ))./c))./(A(norm(ΞΎ-π©β)./c).*A(norm(π©α΅£-ΞΎ)./c))
inverse2Dplot([q],[Rβ,r],[z],f)
