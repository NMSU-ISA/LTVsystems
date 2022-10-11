path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
#T = 15.0e-09
tₚ = 0.5
p(t) = δn(t-tₚ,0.01) #+ δn(t-T-tₚ,1.0e-10) + δn(t-2T-tₚ,1.0e-10)+ δn(t-3T-tₚ,1.0e-10)
α₁ = 0.7; 𝛏₁ = [2.0e03,0.0]  #2km
#α₂ = 0.6; 𝛏₂ = [-1.0,0.0]
#α₃ = 0.6; 𝛏₃ = [0.0,1.0]
#α₄ = 0.5; 𝛏₄ = [0.0,-1.0]
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector(𝛏₁,α₁,q)
z = LTIreceiverO([r],𝐩ᵣ)
t = -5.0:0.001:5.0
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


f(ξ::Vector{Float64}) = (z(tₚ+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Δpos = 0.01e03
x_min = -5.0e03
x_max = 5.0e03
y_min = -5.0e03
y_max = 5.0e03                        
inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max)

















zₙ(t) = z(t) + 𝒩(t,μ=0.0,σ=1.5e-2)




plot(t, 𝒩.(t,μ=0.0,σ=1.5e-2))

plot(t, z(t))
plot!(t,zₙ.(t))


png(path*"scenarioG_signal.png")


scene2Dplot([q],[r],[z])

png(path*"scenarioG.png")





#zₜ = PulseTrainReceivers(z,T)




































#--------------------------------------------------------------------
using LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.1, 0.0]
𝐩ᵣ =  [0.6, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.2,1.0]; 𝐮₁ = [1.0,0.0]; L₁=1.0
α₂ = 0.5; 𝛏₂ = [1.2,1.0]; 𝐮₂ = [0.0,1.0]; L₂=1.0
α₃ = 0.3; 𝛏₃ = [2.2,1.0]; 𝐮₃ = [-1/√2,1/√2]; L₃=1.35
r₁ = lineSegment(𝛏₁,𝐮₁,L₁,k->α₁,[q])
r₂ = lineSegment(𝛏₂,𝐮₂,L₂,k->α₂,[q])
r₃ = lineSegment(𝛏₃,𝐮₃,L₃,k->α₃,[q])
z = LTIreceiverO([r₁,r₂,r₃],𝐩ᵣ)

t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioG_signal.png")


scene2Dplot([q],[r₀,r₁,r₂],[z])

png(path*"scenarioG.png")

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r₁,r₂,r₃],[z],f)
png(path*"scenarioG_simulation.png")
