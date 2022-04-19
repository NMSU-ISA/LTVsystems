path = "docs/src/assets/"

using ISA, LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ =  [-0.3, 0.0]
ξ₀=[0.2,0.3]
α₀ = 0.6;
u_vec = [1/√(2),1/√(2)]
step = 0.015;
line_seg = [quadgk(x->ξ₀ .+ x.*u_vec,0.0,i+step)[1] for i in 1.0:step:2.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
z = LTIreceiverO([LTIsourceO(line_seg[i], t->α₀*q(line_seg[i],t)) for i in 1:length(line_seg)],𝐩ᵣ)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
display(p1)

png(path*"scenarioE_signal.png")

#-----------------------------------------------------------------------
# Estimator function
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))
T_val1 = map(x->x[1],line_seg)
T_val2 = map(x->x[2],line_seg)
line = Any[collect(zip(T_val1,T_val2))]
#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-3:Δpos:3)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=true,zticks=false,bg = RGB(0.0, 0.0, 0.0))
plot!(p2,line[1],color = :red, lw=5,label='t')
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
display(p2)

png(path*"scenarioE_simulation.png")
