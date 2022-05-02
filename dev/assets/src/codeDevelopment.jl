# Animation
using LTVsystems
using QuadGK
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ =  [-0.3, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
#Reflectors
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([R₁],𝐩ᵣ)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-2:Δpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]
allPlots = []
#Q1 = q(𝐮,t₀1)
#R1 = R₁(𝐮,t₀1)
for t₀1 ∈ 0.0:0.2e-9:4.5e-9
    val1 = [q(𝐮,t₀1) for 𝐮 ∈ xyGrid]
    p11 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    #p12 = plot!(p11,x_range,y_range,transpose(val2))
    scatter!(p11,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p11,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p11,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p11, size = (600, 600) )
    push!(allPlots, frame)
 end
anim = @animate for i ∈ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA_source.gif", fps = 30)

for t₀2 = 6.5e-9:0.2e-9:13.0e-9
    val2 = [R₁(𝐮,t₀2) for 𝐮 ∈ xyGrid]
    p12 = plot(x_range,y_range,transpose(val2),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    scatter!(p12,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p12,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p12,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p12, size = (600, 600) )
    push!(allPlots, frame)
 end
anim = @animate for i ∈ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA_receiver.gif", fps = 30)


# Observed signal
z = LTIreceiverO([R₁],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
# Estimator function
a₁(ξ::Vector{Float64}) = (A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2
f(ξ::Vector{Float64})=(z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./(a₁(ξ::Vector{Float64}))

#SPATIAL SIMULATION
t₀1 = 3.5e-9
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

allPlots = []
#Q1 = q(𝐮,t₀1)
#R1 = R₁(𝐮,t₀1)
for t₀1 ∈ 0.0:0.2e-9:5e-5
    val = [f((𝐮).- q(𝐮,t₀1).-R₁(𝐮,t₀1)) for 𝐮 ∈ xyGrid]
    p11 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    scatter!(p11,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p11,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p11,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p11, size = (600, 600) )
    push!(allPlots, frame)
end
anim = @animate for i ∈ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA.gif", fps = 30)

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=false,zticks=false,title="Scenario A Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
