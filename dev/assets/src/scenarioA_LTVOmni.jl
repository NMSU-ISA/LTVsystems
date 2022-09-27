path = "docs/src/assets/"
using LTVsystems
using Plots
𝐩ₛ(t) = [0.1c, 0.0] + [0.5c, 0.0]*t
𝐩ᵣ(t) = 𝐩ₛ(t)
p(t) = δn(t,0.05)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
#t = collect(-4.5e-9:1.0e-10:4.5e-9)
t = collect(-2.0:0.001:2.0)
#plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioALTV_signal.png")

scene2Dplot([q],[r],[z])

#Inverse modeling

#f(ξ::Vector{Float64}) = [z(2(norm(ξ-𝐩ₛ(t₀)))/c)/
#                        (A(norm(ξ-𝐩ₛ(t₀))/c))^2 for t₀ ∈ collect(0.0:0.1:1.0) ]


f(ξ::Vector{Float64}) = z(2(norm(ξ-𝐩ₛ(0.1)))/c)/
                        (A(norm(ξ-𝐩ₛ(0.1))/c))^2
x_range = collect(-4.0:0.01:4.0)
y_range = collect(-4.0:0.01:4.0)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮)[1] for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
    aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
