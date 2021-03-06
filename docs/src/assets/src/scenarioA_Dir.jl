path = "docs/src/assets/"

# Scenario A with LTI directional antenna and time inavriant beam center
using LTVsystems, Plots
π©β =  [0.0, 0.0]
π©α΅£ =  π©β
p(t) = Ξ΄n(t,1.0e-10)

π = [1.0,0.0]
G(ΞΈ) = π©α΅€(ΞΈ, ΞΌ=0.0, Ο=Ο/8)
q = LTIsourceDTI(π©β,p,π,G)
#q = LTIsourceO(π©β, p)
Ξ±β = 0.7; πβ = [1.8,0.0]
r = pointReflector(πβ,Ξ±β,q)
#z = LTIreceiverO([r],π©α΅£)
z = LTIreceiverDTI([r],π©α΅£,π,G)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot(t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_LTIDirsignal.png")

scene2Dplot([q],[r],[z])
png(path*"scenarioA_LTIDir.png")
# Estimator function
D(ΞΎ::Vector{Float64}) = G(angleBetween(π, ΞΎ.-π©α΅£))^2
f(ΞΎ::Vector{Float64}) = z(2(norm(ΞΎ-π©β))/c).*D(ΞΎ::Vector{Float64})/
                        (A(norm(ΞΎ-π©β)/c))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)

png(path*"scenarioA_DirTIsimulation.png")
