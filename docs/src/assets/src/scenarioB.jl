path = "docs/src/assets/"

using LTVsystems
using Plots
π©β =  [1.0, 0.0]
π©α΅£ =  [-1.0, 0.0]
p(t) = Ξ΄n(t,1.0e-10)
q = LTIsourceO(π©β, p)
Ξ±β = 0.7; πβ = [1.8,0.0]
r = pointReflector(πβ,Ξ±β,q)
z = LTIreceiverO([r],π©α΅£)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


png(path*"scenarioB_signal.png")

scene2Dplot([q],[r],[z])

png(path*"scenarioB.png")
#-----------------------------------------------------------------
# Estimator function
f(ΞΎ::Vector{Float64})=(z((norm(ΞΎ-π©β) .+ norm(π©α΅£-ΞΎ))./c))./(A(norm(ΞΎ-π©β)./c).*A(norm(π©α΅£-ΞΎ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioB_simulation.png")
