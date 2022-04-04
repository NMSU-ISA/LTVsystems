path = "docs/src/assets/"

using ISA, LTVSourceReceiverModel
using Plots
#Source
𝐩ₛ =  [0.0, 0.3]
# Multiple Receiver
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.6, 0.0]
𝐩ᵣ₃ =  [1.2, 0.0]
# Transmitter's signal i.e single pulse
p(t) = δ(t-1.0e-15,1.0e-10)
# Signal observed due to source
q = omnidirectionalLTISource(𝐩ₛ, p)
#Multiple Targets
α₁ = 0.8; 𝛏₁ = [0.9,0.0]
R₁ = omnidirectionalLTISource(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.5; 𝛏₂ = [0.5,0.0]
R₂ = omnidirectionalLTISource(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.4; 𝛏₃ = [0.7,0.0]
R₃ = omnidirectionalLTISource(𝛏₃, t->α₃*q(𝛏₃,t))
# Observed signal
z₁ = omnidirectionalLTIListener([R₁,R₂,R₃],𝐩ᵣ₁)
z₂ = omnidirectionalLTIListener([R₁,R₂,R₃],𝐩ᵣ₂)
z₃ = omnidirectionalLTIListener([R₁,R₂,R₃],𝐩ᵣ₃)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))

png(path*"scenarioD_signal.png")

#----------------------------------------------------
# Estimator function
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₁,ξ)./lightSpeed)
a₂(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₂,ξ)./lightSpeed)
a₃(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₃,ξ)./lightSpeed)
f₁(ξ::Vector{Float64})=(z₁((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₁,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))
f₂(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₂,ξ))./lightSpeed))./(a₂(ξ::Vector{Float64}))
f₃(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₃,ξ))./lightSpeed))./(a₃(ξ::Vector{Float64}))

f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64})
#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-2:Δpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]

p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,zticks=false,title="Scenario D Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s')
scatter!(p2,[𝐩ᵣ₁[1]], [𝐩ᵣ₁[2]],markersize = 5.5,color = :blue, marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₂[1]], [𝐩ᵣ₂[2]],markersize = 5.5,color = :blue, marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₃[1]], [𝐩ᵣ₃[2]],markersize = 5.5,color = :blue, marker=:square, label='r')
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red, marker=:star8, label='t')


png(path*"scenarioD_simulation.png")

# Target estimation
f_new(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64})
#SPATIAL SIMULATION
val1 = [f_new(𝐮) for 𝐮 ∈ xyGrid]

p3 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),legend=false,zticks=false,title="Scenario D Target Estimation")
#scatter!(p3,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
#scatter!(p3,[𝐩ᵣ1[1]], [𝐩ᵣ1[2]],markersize = 5.5,color = :blue, marker=:square, label='r')
#scatter!(p3,[𝐩ᵣ2[1]], [𝐩ᵣ2[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
#scatter!(p3,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
#scatter!(p3,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label='t')

png(path*"scenarioD_target_estimation.png")
#-----------------------------------------------------------------
# with 3 target and 3 receiver
using ISA, LTVSourceReceiverModel
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ1 =  [-0.3, 0.0]
𝐩ᵣ2 =  [0.6, 0.0]
𝐩ᵣ3 =  [1.2, 1.2]
p(t) = δ(t-1.0e-15,1.0e-10)
q = omnidirectionalLTISource(𝐩ₛ, p)
α₁ = 1.7; 𝛏₁ = [0.9,0.0]
R₁ = omnidirectionalLTISource(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.3; 𝛏₂ = [1.8,1.8]
R₂ = omnidirectionalLTISource(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 1.5; 𝛏₃ = [2.7,0.0]
R₃ = omnidirectionalLTISource(𝛏₃, t->α₃*q(𝛏₃,t))
z₁ = omnidirectionalLTIListener([R₁,R₂,R₃],𝐩ᵣ1)
z₂ = omnidirectionalLTIListener([R₁,R₂,R₃],𝐩ᵣ2)
z₃ = omnidirectionalLTIListener([R₁,R₂,R₃],𝐩ᵣ3)
t = collect(0.0:1.0e-10:25.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))

#-----------------------------------------
a₁(ξ::Vector{Float64}) = (α₁.+α₂.+α₃).*A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ1,ξ)./lightSpeed)
a₂(ξ::Vector{Float64}) = (α₁.+α₂.+α₃).*A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ2,ξ)./lightSpeed)
a₃(ξ::Vector{Float64}) = (α₁.+α₂.+α₃).*A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ3,ξ)./lightSpeed)
f₁(ξ::Vector{Float64})=(z₁((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ1,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))
f₂(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ2,ξ))./lightSpeed))./(a₂(ξ::Vector{Float64}))
f₃(ξ::Vector{Float64})=(z₃((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ3,ξ))./lightSpeed))./(a₃(ξ::Vector{Float64}))
f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+
f₃(ξ::Vector{Float64})
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         legend=false,zticks=false,title="Scenario D Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ1[1]], [𝐩ᵣ1[2]],markersize = 5.5,color = :blue, marker=:square, label='r')
scatter!(p2,[𝐩ᵣ2[1]], [𝐩ᵣ2[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝐩ᵣ3[1]], [𝐩ᵣ3[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
