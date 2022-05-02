path = "docs/src/assets/"

using LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.1, 0.0]
𝐩ᵣ =  [0.6, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,2.0]; 𝛖 = [1.0,0.0]; len=1.0
r = lineSegment(𝛏₀,𝛖,len,k->α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)

t = 0.0:1.0e-10:35.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioF_signal.png")


scene2Dplot([q],[r],[z])

png(path*"scenarioF.png")

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioF_simulation.png")



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

png(path*"scenarioF_simulation.png")
