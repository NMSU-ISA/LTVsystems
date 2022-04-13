path = "docs/src/assets/"

using ISA, LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ =  [-0.3, 0.0]
# Continuos target, suppose line segment AB has length L

#--------------------
ξ₀=[0.0,0.3]
α₀ = 0.6;
#L = collect(0.0:0.001:1.0)
#L = collect(range(1, 2.0, step=0.01))
L = collect(range(1.0, 2.0, step=0.025))
g(k) = ξ₀ .+ k.*[0.0,1.0]
temp = quadgk.(g, 0.0, L)
value = [α₀*(temp[i][1]) for i in 1:length(L)]
#-------------------Alternate way, with Analytic result----------
# Both gives same results
Tc = [α₀*(ξ₀.*L[i] .+ ([0.0,1.0].*L[i]^2)/2) for i in 1:length(L)]

p(t) = δ(t-1.0e-15,1.0e-10)
W = []
q = LTIsourcesO(𝐩ₛ, p)
for i in 1:length(value)
R₁ = LTIsourcesO(value[i], t->q(value[i],t))
push!(W,R₁)
end
#println(W)
z = LTIreceiversO(W,𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
display(p1)

png(path*"scenarioE_signal.png")

#-----------------------------------------------------------------------
# Estimator function
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))
T_val1 = map(x->x[1],value)
T_val2 = map(x->x[2],value)
line = Any[collect(zip(T_val1,T_val2))]
#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-2:Δpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=false,zticks=false,title="Scenario E Simulation")
plot!(p2,line[1],color = :red, lw=5)
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
display(p2)

png(path*"scenarioE_simulation.png")
