path = "docs/src/assets/"

using LTVsystems
using Plots
π©β =  [0.3, 0.3]
π©α΅£ =  [0.9, 0.9]
p(t) = Ξ΄n(t,1.0e-10)
q = LTIsourceO(π©β, p)
#Reflectors
Ξ±β = 0.7; πβ = [1.2,0.0]
Ξ±β = 0.4; πβ = [1.8,1.8]
Ξ±β = 0.5; πβ = [2.7,-0.9]
r = pointReflector([πβ,πβ,πβ],[Ξ±β,Ξ±β,Ξ±β],[q])
z = LTIreceiverO(r,π©α΅£)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioC_signal.png")

scene2Dplot([q],r,[z])

png(path*"scenarioC.png")
#-----------------------------------------------------------------
# Estimator function
f(ΞΎ::Vector{Float64})=(z((norm(ΞΎ-π©β) .+norm(π©α΅£-ΞΎ))./c))./(A(norm(ΞΎ-π©β)./c).*A(norm(π©α΅£-ΞΎ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],r,[z],f)
png(path*"scenarioC_simulation.png")
