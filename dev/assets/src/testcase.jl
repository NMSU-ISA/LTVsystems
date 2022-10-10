using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
tₚ = 1.0e-9
M = 10 #no of pulses
p(t) = δn(mod(t-0.5e-9,T),1.0e-10)
#p(t) = δn(t-tₚ,1.0e-10) + δn(t-T-tₚ,1.0e-10) + δn(t-2T-tₚ,1.0e-10)+ δn(t-3T-tₚ,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
α₂ = 0.7; 𝛏₂ = [-1.0,0.0]
α₃ = 0.7; 𝛏₃ = [1.0,1.0]
α₄ = 0.7; 𝛏₄ = [0.5,-0.8]
f₀ = 1/M*T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = 0.0:T/100:M*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z.(t)),maximum(z.(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))


scene2Dplot([q],r,[z])

struct PulseTrain <: Receivers
    s::Receivers
    EmissionTime::Float64
    Period ::Float64
end
  
function (𝐏::PulseTrain)(t₀::Float64)
     tₚ=𝐏.EmissionTime
     T=𝐏.Period
     k = floor(t₀/T)
    return ifelse(t₀<T, 𝐏.s(t₀.+tₚ.+k*T) ,0.0)
end


zp = PulseTrain(z,tₚ,T)

Dₛ(ξ::Vector{Float64}) = [G(angleBetween(𝐛(tₚ.-k*T), ξ.-𝐩ₛ)) for k ∈ 0:M-1]

f(ξ::Vector{Float64}) = [(zp(2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ)[i])/(A(norm(ξ-𝐩ₛ)/c))^2 for i ∈ 1:M]

g(ξ::Vector{Float64}) = sum(f(ξ)[i] for i ∈ 1:M )

inverse2Dplot([q],r,[z],g)












#struct MovingBeamb <: Function
#    b::Function
#    EmissionTime::Float64
#    Period ::Float64
#end
  
#function (𝐁::MovingBeamb)(t₀::Float64)
#     tₚ=𝐁.EmissionTime
#     T=𝐁.Period
#     k = floor(t₀/T)
#     return 𝐁.b(tₚ.-k*T)
#end










zₜ = PulseTrain(z,tₚ,T)

Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f₁(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₁(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-T), ξ.-𝐩ₛ))
f₂(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₂(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
f₃(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₃(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))
f₄(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₄(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₅(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-4T), ξ.-𝐩ₛ))
f₅(ξ::Vector{Float64}) = (zₜ(2(norm(ξ-𝐩ₛ))/c).*Dₛ₅(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ).+f₅(ξ)
p11 = inverse2Dplot([q],r,[z],f₁)
p12 = inverse2Dplot([q],r,[z],f₂)
p13 = inverse2Dplot([q],r,[z],f₃)
p14 = inverse2Dplot([q],r,[z],f₄)
p15 = inverse2Dplot([q],r,[z],f₅)
plot(p11,p12,p13,p14,p15,layout=(5,1),size=(1000,1000))



inverse2Dplot([q],r,[z],f)







zz = PulseTrainReceiver(z,tₚ,T)

bc = beam(𝐛,tₚ,T)









#-----------------------------------------------------------------

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 20.0e-9
p(t) = δn(t,1.0e-10) + δn(t-T,1.0e-10) + δn(t-2T,1.0e-10)+ δn(t-3T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [2.0,0.0]
α₂ = 0.7; 𝛏₂ = [-2.0,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,2.0]
α₄ = 0.7; 𝛏₄ = [0.0,-2.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = -5.0e-9:1.0e-10:75.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

zₜ = PulseTrainReceivers(z,T)
Dₛ1(ξ::Vector{Float64},t::Float64) = G(angleBetween(𝐛(t), ξ.-𝐩ₛ))
f1(ξ::Vector{Float64},t::Float64) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ1(ξ,t))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Dₛ2(ξ::Vector{Float64},t::Float64) = G(angleBetween(𝐛(t+T), ξ.-𝐩ₛ))
f2(ξ::Vector{Float64},t::Float64) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ2(ξ,t))/
                                    (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))   

Dₛ3(ξ::Vector{Float64},t::Float64) = G(angleBetween(𝐛(t+2T), ξ.-𝐩ₛ))
f3(ξ::Vector{Float64},t::Float64) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ3(ξ,t))/
                                      (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
Dₛ4(ξ::Vector{Float64},t::Float64) = G(angleBetween(𝐛(t+3T), ξ.-𝐩ₛ))
f4(ξ::Vector{Float64},t::Float64) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ4(ξ,t))/
                                     (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))                                     
#inverse2Dplot([q],r,[z],f1)
x_range = collect(-4.0:0.01:4.0)
y_range = collect(-4.0:0.01:4.0)
xyGrid = [[x, y] for x in x_range, y in y_range]
val1 = [f1(𝐮,t) for 𝐮 ∈ xyGrid, t ∈ 2norm(xyGrid)/c]
val2 = [f2(𝐮,t) for 𝐮 ∈ xyGrid, t ∈ 2norm(xyGrid)/c]
val3 = [f3(𝐮,t) for 𝐮 ∈ xyGrid, t ∈ 2norm(xyGrid)/c]
val4 = [f4(𝐮,t) for 𝐮 ∈ xyGrid, t ∈ 2norm(xyGrid)/c]

plot(x_range,y_range,transpose(val4),st=:surface,camera=(0,90),
aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)