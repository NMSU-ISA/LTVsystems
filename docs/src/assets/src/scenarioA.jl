path = "docs/src/assets/"

using LTVsystems, Plots
π©β =  [0.0, 0.0]
π©α΅£ =  π©β
p(t) = Ξ΄n(t,1.0e-10)
q = LTIsourceO(π©β, p)
Ξ±β = 0.7; πβ = [1.8,0.0]
r = pointReflector(πβ,Ξ±β,q)
z = LTIreceiverO([r],π©α΅£)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_signal.png")

scene2Dplot([q],[r],[z])
png(path*"scenarioA.png")
#----------------------------------------------------------------
# Estimator function
f(ΞΎ::Vector{Float64}) = z(2(norm(ΞΎ-π©β))/c)/
                        (A(norm(ΞΎ-π©β)/c))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioA_simulation.png")
