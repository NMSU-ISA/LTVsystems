path = "docs/src/assets/"

using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_signal.png")

scene2Dplot([q],[r],[z])
png(path*"scenarioA.png")
#----------------------------------------------------------------
# Estimator function
f(ξ::Vector{Float64}) = (z(2(norm(ξ-𝐩ₛ))/c))/
                        (A(norm(ξ-𝐩ₛ)/c))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioA_simulation.png")
