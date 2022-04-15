path = "docs/src/assets/"

using ISA, LTVsystems
using Plots

#Source
𝐩ₛ =  [0.0, 0.0]
#Receiver
𝐩ᵣ =  [0.0, 0.0]  # Considering 𝐩ₛ = 𝐩ᵣ

# Transmitter's signal i.e single pulse
p(t) = δ(t-1.0e-15,1.0e-10)

# Signal observed due to source
q = LTIsourcesO(𝐩ₛ, p)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))

# Observed signal
z = LTIreceiversO([R₁],𝐩ᵣ)

#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_signal.png")

#----------------------------------------------------------------
# Estimator function
a₁(ξ::Vector{Float64}) = α₁.*(A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2
f(ξ::Vector{Float64})=(z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./(a₁(ξ::Vector{Float64}))

#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=false,zticks=false,title="Scenario A Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')

png(path*"scenarioA_simulation.png")

#-------------------------------------------------------------
# Scenario A with LTI directional antenna and time inavriant beam center
using LTVsystems, ISA
using Plots
#Source
𝐩ₛ =  [0.0, 0.0]
#Receiver
𝐩ᵣ =  [0.0, 0.0]  # Considering 𝐩ₛ = 𝐩ᵣ

# Transmitter's signal i.e single pulse
p(t) = δ(t-1.0e-14,1.0e-10)
#p(t) = u(t)-u(t-1.0e-9)
#p(t) = (u(mod(t,1.0e-9))-u(mod(t,1.0e-9)-1.0e-10))*u(t)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
#𝐛(t) = [cos(2π*1.0e8*t),sin(2π*1.0e8*t)]
#G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
# Signal observed due to source
q = LTIsourcesDTI(𝐩ₛ, p,𝐛,G)

#Reflectors
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))

# Observed signal
z = LTIreceiversDTI([R₁],𝐩ᵣ,𝐛, G)

#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_DirTIsignal.png")

# Estimator function
a₁(ξ::Vector{Float64}) = α₁.*(A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2
D(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))^2
f(ξ::Vector{Float64})=(z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./(a₁(ξ::Vector{Float64})).*D(ξ::Vector{Float64})

#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=false,zticks=false,title="Scenario A Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')

png(path*"scenarioA_DirTIsimulation.png")
