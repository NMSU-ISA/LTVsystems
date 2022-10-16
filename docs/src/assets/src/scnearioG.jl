path = "docs/src/assets/"

 
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-6
tₚ = 1.0e-06
p(t) = δn(mod(t-tₚ,T),1.0e-7)
α₁ = 0.7; 𝛏₁ = [0.2c*T,0.0]
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector(𝛏₁,α₁,q)
z = LTIreceiverO([r],𝐩ᵣ)

t=0.0:T/100:5T
#plot(t, z(t),ylims=(minimum(z(t)),maximum(z(t))),xlab="time (sec)", ylab="z(t)", legend=:false)
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


png(path*"scenarioG_signal.png")




#zₜ = PulseTrainReceivers(z,T)
#M =5
#fₘ(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (1.5e-05randn(1)[1]+z(tₚ+(M-1)*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))

f₁(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (1.5e-05randn(1)[1]+z(tₚ+0*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f₂(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (1.5e-05randn(1)[1]+z(tₚ+1*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))                        
f₃(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (1.5e-05randn(1)[1]+z(tₚ+2*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f₄(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (1.5e-05randn(1)[1]+z(tₚ+3*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f₅(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (1.5e-05randn(1)[1]+z(tₚ+4*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))

f(ξ::Vector{Float64}) = (f₁(ξ).+f₂(ξ).+f₃(ξ).+f₄(ξ).+f₅(ξ))/5



                        #f(ξ::Vector{Float64}) = (z(tₚ+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
#                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))                        
Δpos = 0.01e03
x_min = -0.5c*T
x_max = 0.5c*T
y_min = -0.5c*T
y_max = 0.5c*T

#f(ξ::Vector{Float64}) = [ifelse(norm(ξ)>c*T/2, NaN, (1.0e-07randn(1)[1]+z(tₚ+(i-1)*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/
#(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))) for i ∈ 1:M]

#g(ξ::Vector{Float64}) = sum(f(ξ)[i] for i ∈ 1:M )/M

p11=inverse2Dplot([q],[r],[z],f₁;Δpos,x_min,x_max,y_min,y_max)
p12=inverse2Dplot([q],[r],[z],f₂;Δpos,x_min,x_max,y_min,y_max)
p13=inverse2Dplot([q],[r],[z],f₃;Δpos,x_min,x_max,y_min,y_max)
p14=inverse2Dplot([q],[r],[z],f₄;Δpos,x_min,x_max,y_min,y_max)
p15=inverse2Dplot([q],[r],[z],f₅;Δpos,x_min,x_max,y_min,y_max)
p6=inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max)

plot(p11,p12,p13,p14,p15,p6,layout=(3,2),size=(1000,1000))
#inverse2Dplot([q],[r],[z],f;Δpos,x_min,x_max,y_min,y_max)

png(path*"scenarioG_simulation.png")



scene2Dplot([q],[r],[z];Δpos,x_min,x_max,y_min,y_max)

png(path*"scenarioG.png")





















#zₜ = PulseTrainReceivers(z,T)





















#----------------------Line segment example------------------------------------
using LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.1, 0.0]
𝐩ᵣ =  [0.6, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.2,1.0]; 𝐮₁ = [1.0,0.0]; L₁=1.0
α₂ = 0.5; 𝛏₂ = [1.2,1.0]; 𝐮₂ = [0.0,1.0]; L₂=1.0
α₃ = 0.3; 𝛏₃ = [2.2,1.0]; 𝐮₃ = [-1/√2,1/√2]; L₃=1.35
r₁ = lineSegment(𝛏₁,𝐮₁,L₁,k->α₁,[q])
r₂ = lineSegment(𝛏₂,𝐮₂,L₂,k->α₂,[q])
r₃ = lineSegment(𝛏₃,𝐮₃,L₃,k->α₃,[q])
z = LTIreceiverO([r₁,r₂,r₃],𝐩ᵣ)

t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioG_signal.png")


scene2Dplot([q],[r₀,r₁,r₂],[z])

png(path*"scenarioG.png")

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r₁,r₂,r₃],[z],f)
png(path*"scenarioG_simulation.png")
