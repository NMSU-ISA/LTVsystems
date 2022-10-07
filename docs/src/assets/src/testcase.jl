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
t = -5.0e-9:1.0e-11:75.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

struct PulseTrainReceiver <: Receivers
    s::Receivers
    EmissionTime::Float64
    Period ::Float64
end
  
function (𝐏::PulseTrainReceiver)(t₀::Float64)
     tₚ=𝐏.EmissionTime
     T=𝐏.Period
     k = floor(t₀/T)
    return ifelse(t₀<T, 𝐏.s(t₀.+tₚ.+k*T),0.0)
end



function beam(b::Function,tₚ::Float64,T::Float64)
    k = floor(tₚ/T)
    return ifelse(tₚ<T, b(tₚ.-k*T), 0.0)
end   


zz = PulseTrainReceiver(z,tₚ,T)

bc = beam(𝐛,tₚ,T)

Dₛ(ξ::Vector{Float64}) = G(angleBetween(bc, ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (zz(2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2


inverse2Dplot([q],r,[z],f)







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