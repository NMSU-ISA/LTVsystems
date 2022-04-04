path = "docs/src/assets/"

using ISA, LTVSourceReceiverModel
using Plots

#Source
𝐩ₛ =  [1.0, 0.0]
#Receiver
𝐩ᵣ =  [-1.0, 0.0]

# Transmitter's signal i.e single pulse
p(t) = δ(t-1.0e-15,1.0e-10)

# Signal observed due to source
q = omnidirectionalLTISource(𝐩ₛ, p)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = omnidirectionalLTISource(𝛏₁, t->α₁*q(𝛏₁,t))

# Observed signal
z = omnidirectionalLTIListener([R₁],𝐩ᵣ)

#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioB_signal.png")

#-----------------------------------------------------------------
# Estimator function
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))

#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,zticks=false,title="Scenario B Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')

png(path*"scenarioB_simulation.png")
