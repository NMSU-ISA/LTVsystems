using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 #pulse period
D = 12 #pulses per revolution

p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.0,0.10c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.0]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.0]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [0.0,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/128)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

scenePlot2D([q],r,[z]) 


function angleBetweenval(𝛏₀::Vector{Float64},𝛏₁::Vector{Float64})::Float64
    return atan(norm(𝛏₀./norm(𝛏₀) .- 𝛏₁./norm(𝛏₁)),norm(𝛏₀./norm(𝛏₀) .+ 𝛏₁./norm(𝛏₁)))
end

 
Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+0T), ξ.-𝐩ₛ))
Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+1T), ξ.-𝐩ₛ))
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+2T), ξ.-𝐩ₛ))
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+3T), ξ.-𝐩ₛ))
Dₛ₅(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+4T), ξ.-𝐩ₛ))
Dₛ₆(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+5T), ξ.-𝐩ₛ))
Dₛ₇(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+6T), ξ.-𝐩ₛ))
Dₛ₈(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+7T), ξ.-𝐩ₛ))
Dₛ₉(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+8T), ξ.-𝐩ₛ))
Dₛ₁₀(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+9T), ξ.-𝐩ₛ))
Dₛ₁₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+10T), ξ.-𝐩ₛ))
Dₛ₁₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ+11T), ξ.-𝐩ₛ))

f₁(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+0*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₁(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₂(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+1*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₂(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₃(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+2*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₃(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₄(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+3*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₄(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₅(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+4*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₅(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₆(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+5*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₆(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₇(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+6*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₇(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₈(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+7*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₈(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₉(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+8*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₉(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₁₀(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+9*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₁₀(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₁₁(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+10*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₁₁(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )
f₁₂(ξ::Vector{Float64})=ifelse(norm(ξ)>c*T/2, NaN, ( z(tₚ+11*T+(2norm(ξ-𝐩ₛ))./c).*Dₛ₁₂(ξ)./(A(norm(ξ-𝐩ₛ)/c))^2)  )

p11 = inversePlot2D([q],r,[z],f₁)
plot!(1000*[0.0,𝐛(tₚ+0T)[1]],1000*[0.0,𝐛(tₚ+0T)[2]])

p12 = inversePlot2D([q],r,[z],f₂)
plot!(1000*[0.0,𝐛(tₚ+1T)[1]],1000*[0.0,𝐛(tₚ+1T)[2]])

p13 = inversePlot2D([q],r,[z],f₃)
plot!(1000*[0.0,𝐛(tₚ+2T)[1]],1000*[0.0,𝐛(tₚ+2T)[2]])

p14 = inversePlot2D([q],r,[z],f₄)
plot!(1000*[0.0,𝐛(tₚ+3T)[1]],1000*[0.0,𝐛(tₚ+3T)[2]])

p15 = inversePlot2D([q],r,[z],f₅)
plot!(1000*[0.0,𝐛(tₚ+4T)[1]],1000*[0.0,𝐛(tₚ+4T)[2]])

p16 = inversePlot2D([q],r,[z],f₆)
plot!(1000*[0.0,𝐛(tₚ+5T)[1]],1000*[0.0,𝐛(tₚ+5T)[2]])

p17 = inversePlot2D([q],r,[z],f₇)
plot!(1000*[0.0,𝐛(tₚ+6T)[1]],1000*[0.0,𝐛(tₚ+6T)[2]])

p18 = inversePlot2D([q],r,[z],f₈)
plot!(1000*[0.0,𝐛(tₚ+7T)[1]],1000*[0.0,𝐛(tₚ+7T)[2]])

p19 = inversePlot2D([q],r,[z],f₉)
plot!(1000*[0.0,𝐛(tₚ+8T)[1]],1000*[0.0,𝐛(tₚ+8T)[2]])

p20 = inversePlot2D([q],r,[z],f₁₀)
plot!(1000*[0.0,𝐛(tₚ+9T)[1]],1000*[0.0,𝐛(tₚ+9T)[2]])

p21 = inversePlot2D([q],r,[z],f₁₁)
plot!(1000*[0.0,𝐛(tₚ+10T)[1]],1000*[0.0,𝐛(tₚ+10T)[2]])

p22 = inversePlot2D([q],r,[z],f₁₂)
plot!(1000*[0.0,𝐛(tₚ+11T)[1]],1000*[0.0,𝐛(tₚ+11T)[2]])

plot(p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,layout=(12,1),size=(800,800*12))

f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ).+f₅(ξ).+ f₆(ξ).+f₇(ξ).+ f₈(ξ) .+f₉(ξ).+f₁₀(ξ).+f₁₁(ξ).+f₁₂(ξ)
inversePlot2D([q],r,[z],f)




#-------------Animation------------------

t = collect(0.0:T/100:5T)
plot(t,p.(t))

plot(t,z.(t),ylims=(minimum(z.(t)),maximum(z.(t))))

Δpos = 0.01e03
x_min = -0.5c*15.0e-6
x_max = 0.5c*15.0e-6
y_min = -0.5c*15.0e-6
y_max = 0.5c*15.0e-6
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [q(𝐮,5.0e-6) for 𝐮 ∈ xyGrid]
plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90))

allPlots = []
for t ∈ 0:T/10:5T
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