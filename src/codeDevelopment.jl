using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
tₚ = 1.0e-9

p(t) = δn(t-tₚ,1.0e-10) + δn(t-T-tₚ,1.0e-10) + δn(t-2T-tₚ,1.0e-10)+ δn(t-3T-tₚ,1.0e-10)
α₁ = 0.7; 𝛏₁ = [2.0,0.0]
α₂ = 0.7; 𝛏₂ = [-2.0,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,2.0]
α₄ = 0.7; 𝛏₄ = [0.0,-2.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/16)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
zₜ = PulseTrainReceivers(z,T)



t = collect(0.0:T/100:5T)
plot(t,p.(t))

plot(t,z.(t),ylims=(minimum(z.(t)),maximum(z.(t))))

Δpos = 0.01
x_range = -3.0:Δpos:3.0
y_range = -3.0:Δpos:3.0
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [q(𝐮,5.0e-9) for 𝐮 ∈ xyGrid]
plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90))




allPlots = []
for t ∈ 0:T/100:5T
    val = [q(𝐮,t) + r[1](𝐮,t) for 𝐮 ∈ xyGrid]
    #val = [q(𝐮,t) + r[1](𝐮,t)+r[2](𝐮,t)+r[3](𝐮,t)+r[4](𝐮,t) for 𝐮 ∈ xyGrid]
    p1 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    frame = plot(p1, size = (800, 800) )
    push!(allPlots, frame)
end
anim = @animate for i ∈ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "fileName3.gif", fps = 30)




Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f₁(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₁(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
#p11 = inverse2Dplot([q],r,[z],f₁)

#plot!(size= (800,800))



Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-T), ξ.-𝐩ₛ))
f₂(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₂(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
f₃(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₃(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))
f₄(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₄(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)
p11 = inverse2Dplot([q],r,[z],f₁)
p12 = inverse2Dplot([q],r,[z],f₂)
p13 = inverse2Dplot([q],r,[z],f₃)
p14 = inverse2Dplot([q],r,[z],f₄)
plot(p11,p12,p13,p14,layout=(2,2),size=(1000,1000))





#----------------Animation for line segment-------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
tₚ = 1.0e-9
p(t) = δn(t-tₚ,1.0e-10)
α₀ = 0.7; 𝛏₀ = [1.8,2.0]; 𝛖 = [1.0,0.0]; len=1.0
q = LTIsourceO(𝐩ₛ, p)
r = lineSegment(𝛏₀,𝛖,len,k->α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
Δpos = 0.01
x_range = -3.0:Δpos:3.0
y_range = -3.0:Δpos:3.0
xyGrid = [[x, y] for x in x_range, y in y_range]
allPlots = []
for t ∈ 0:T/100:5T
    val = [q(𝐮,t) + r(𝐮,t) for 𝐮 ∈ xyGrid]
    #val = [q(𝐮,t) + r[1](𝐮,t)+r[2](𝐮,t)+r[3](𝐮,t)+r[4](𝐮,t) for 𝐮 ∈ xyGrid]
    p1 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    frame = plot(p1, size = (800, 800) )
    push!(allPlots, frame)
end
anim = @animate for i ∈ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "fileName4.gif", fps = 30)