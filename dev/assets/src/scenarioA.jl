path = "docs/src/assets/"

using ISA, LTVsystems
using Plots

𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₀, t->α₀*q(𝛏₀,t))
z = LTIreceiverO([R₁],𝐩ᵣ)


#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_signal.png")

#----------------------------------------------------------------
# Estimator function
a₁(ξ::Vector{Float64}) = (A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2
f(ξ::Vector{Float64}) = (z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./
                        (a₁(ξ::Vector{Float64}))
#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=true,zticks=false,bg = RGB(0.1, 0.1, 0.1))
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')

png(path*"scenarioA_simulation.png")
