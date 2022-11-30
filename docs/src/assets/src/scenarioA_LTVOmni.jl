path = "docs/src/assets/"

using LTVsystems
using Plots
s₁ = 0.30c  # 3m/s
𝐯₁ = [1.0, 0.0]  #direction 
#s₂ = 0.25c  # 6m/s
#𝐯₂ = [1.0, 0.0]  #direction
tₚ = 1.0e-06
𝐩ₛ(t) = [-10.0e-06c,-1.5e-06c] .+ s₁.*𝐯₁.*(t-tₚ) 
𝐩ᵣ(t)  =𝐩ₛ(t)
#𝐩ᵣ(t) = [5.0e-06c,0.0] .+ s₂.*𝐯₂.*(t-tₚ)
p(t) = δn(t-tₚ,2.5e-07)
q = LTVsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
#t = collect(-4.5e-9:1.0e-10:4.5e-9)
t=0.0:1.0e-08:50.0e-06
#plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


png(path*"scenarioALTV_signal.png")

scene2Dplot([q],[r],[z])

#Inverse modeling

#f(ξ::Vector{Float64}) = [z(2(norm(ξ-𝐩ₛ(t₀)))/c)/
#                        (A(norm(ξ-𝐩ₛ(t₀))/c))^2 for t₀ ∈ collect(0.0:0.1:1.0) ]


f(ξ::Vector{Float64},t::Float64) = z(2(norm(ξ-𝐩ₛ(t)))/c)/
                        (A(norm(ξ-𝐩ₛ(t))/c))^2
 
Δpos = 0.01e03
x_min = -0.5c*15.0e-6
x_max = 0.5c*15.0e-6
y_min = -0.5c*15.0e-6
y_max = 0.5c*15.0e-6
cmap=cgrad(:default,scale=log)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)

xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮,t) for 𝐮 ∈ xyGrid,t ∈ collect(0.0:1.0e-07:1.0e-06) ]
val_max = maximum(abs.(val))
p2 = plot(x_range,y_range,transpose(abs.(val[:,:,1])),st=:surface,camera=(0,90),clim=(0,val_max),
     aspect_ratio=:equal,size=(800,800),legend=false,left_margin = 5Plots.mm, right_margin = 15Plots.mm,colorbar=false,zticks=false,bg = cmap[1])

