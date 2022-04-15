path = "docs/src/assets/"

using ISA, LTVsystems
using Plots

#Source
𝐩ₛ =  [0.3, 0.3]
#Receiver
𝐩ᵣ =  [0.9, 0.9]
# Transmitter's signal i.e single pulse
p(t) = δ(t,1.0e-10)

# Signal observed due to source
q = LTIsourcesO(𝐩ₛ, p)

#Reflectors
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.3; 𝛏₂ = [1.8,1.8]
R₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
R₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))

# Observed signal
z = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioC_signal.png")

#-----------------------------------------------------------------
# Estimator function
a₀(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₀(ξ::Vector{Float64}))

#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,zticks=false,title="Scenario C Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5, color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red, marker=:star8, label='t')

png(path*"scenarioC_simulation.png")
