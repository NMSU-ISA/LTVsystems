path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.0, 0.3]
𝐩ᵣ₃ =  [0.3, 0.0]
𝐩ᵣ₄ =  [0.0, -0.3]
𝐩ᵣ₅ =  [0.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
#Multiple Targets
α₁ = 0.7; 𝛏₁ = [0.4,0.7]
α₂ = 0.5; 𝛏₂ = [0.6,0.2]
α₃ = 0.4; 𝛏₃ = [0.6,1.0]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
# Observed signal
z₁ = LTIreceiverO(r,𝐩ᵣ₁)
z₂ = LTIreceiverO(r,𝐩ᵣ₂)
z₃ = LTIreceiverO(r,𝐩ᵣ₃)
z₄ = LTIreceiverO(r,𝐩ᵣ₄)
z₅ = LTIreceiverO(r,𝐩ᵣ₅)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))
plot!(p1,t, z₄(t))
plot!(p1,t, z₅(t))

png(path*"scenarioD_signal.png")

scene2Dplot([q],r,[z₁,z₂,z₃,z₄,z₅])

png(path*"scenarioD.png")
#----------------------------------------------------
# Estimator function
f₁(ξ::Vector{Float64})=(z₁((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₁-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₁-ξ)./c)
f₂(ξ::Vector{Float64})=(z₂((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₂-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₂-ξ)./c)
f₃(ξ::Vector{Float64})=(z₃((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₃-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₃-ξ)./c)
f₄(ξ::Vector{Float64})=(z₄((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₄-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₄-ξ)./c)
f₅(ξ::Vector{Float64})=(z₅((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₅-ξ))./c))./A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₅-ξ)./c)

f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+f₃(ξ::Vector{Float64}).+f₄(ξ::Vector{Float64}).+f₅(ξ::Vector{Float64})
#SPATIAL SIMULATION3
inverse2Dplot([q],r,[z₁,z₂,z₃,z₄,z₅],f;x_min = -3.0,x_max = 3.0,y_min = -2.0,y_max = 2.0)

png(path*"scenarioD_simulation.png")

# Target estimation
f_new(ξ::Vector{Float64})=(f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64}).*f₄(ξ::Vector{Float64}).*f₅(ξ::Vector{Float64}))^(1/3)
#SPATIAL SIMULATION
inverse2Dplot([q],r,[z₁,z₂,z₃,z₄,z₅],f_new;Δpos = 0.01,x_min = -3.0,x_max = 3.0,y_min = -2.0,y_max = 2.0,)

png(path*"scenarioD_target_estimation.png")
#-----------------------------------------------------------------
# with 3 target and 3 receiver
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ1 =  [-0.3, 0.0]
𝐩ᵣ2 =  [0.6, 0.0]
𝐩ᵣ3 =  [1.2, 1.2]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.3; 𝛏₂ = [1.8,1.8]
R₂ = LTIsourceO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.5; 𝛏₃ = [2.7,0.0]
R₃ = LTIsourceO(𝛏₃, t->α₃*q(𝛏₃,t))
z₁ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ1)
z₂ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ2)
z₃ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ3)
t = collect(0.0:1.0e-10:25.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))

#-----------------------------------------
a₁(ξ::Vector{Float64}) = (α₁.+α₂.+α₃).*A(norm(ξ-𝐩ₛ)./c).*A(distBetween(𝐩ᵣ1,ξ)./c)
a₂(ξ::Vector{Float64}) = (α₁.+α₂.+α₃).*A(norm(ξ-𝐩ₛ)./c).*A(distBetween(𝐩ᵣ2,ξ)./c)
a₃(ξ::Vector{Float64}) = (α₁.+α₂.+α₃).*A(norm(ξ-𝐩ₛ)./c).*A(distBetween(𝐩ᵣ3,ξ)./c)
f₁(ξ::Vector{Float64})=(z₁((norm(ξ-𝐩ₛ) .+ distBetween(𝐩ᵣ1,ξ))./c))./(a₁(ξ::Vector{Float64}))
f₂(ξ::Vector{Float64})=(z₂((norm(ξ-𝐩ₛ) .+ distBetween(𝐩ᵣ2,ξ))./c))./(a₂(ξ::Vector{Float64}))
f₃(ξ::Vector{Float64})=(z₃((norm(ξ-𝐩ₛ) .+ distBetween(𝐩ᵣ3,ξ))./c))./(a₃(ξ::Vector{Float64}))
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
