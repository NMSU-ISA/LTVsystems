path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ = [0.3, 0.3]
𝐩ᵣ = [0.9, 0.9]
T  = 15.0e-09
p(t) = δn(t,2.0e-10) + δn(t-T,2.0e-10) + δn(t-2T,2.0e-10)
#δn(t-T,1.0e-10) + δn(t-2T,1.0e-10) + δn(t-3T,1.0e-10)
#Reflectors
#α₁ = 0.7; 𝛏₁ = [1.0,0.0]
#α₂ = 0.7; 𝛏₂ = [-1.0,0.0]
#α₃ = 0.7; 𝛏₃ = [0.0,1.0]
#α₄ = 0.7; 𝛏₄ = [0.0,-1.0]

α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]


ω = T/3
𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]

G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)

q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

t = collect(-10.5e-9:1.0e-10:50.5e-9)

p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"scenarioD_STATDsignal1.png")


zₚ(t)= ifelse(0.0<t<T,t->z(t),ifelse(T<t<2T,t->z(t+T),t->z(t+2T)))
z_new = NewSources(zₚ)
#gg(ξ::Vector{Float64})=zₚ((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c)

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

f(ξ::Vector{Float64}) = (z_new((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ).*Dᵣ(ξ))/
                           (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

x_range = collect(-4.0:0.01:4.0)
y_range = collect(-4.0:0.01:4.0)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]


p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
                                    aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false,bg = cmap[1])


inverse2Dplot([q],r,[z],f)




















# Inverse modeling

Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))

Dᵣₜ(ξ::Vector{Float64}) = G(angleBetween(𝐛(T+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛₜ(ξ::Vector{Float64}) = G(angleBetween(𝐛(T+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))


f₁(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                           (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
f₂(ξ::Vector{Float64}) = (z(T+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛₜ(ξ::Vector{Float64}).*Dᵣₜ(ξ::Vector{Float64}))/
                          (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))

f(ξ::Vector{Float64}) = f₁(ξ::Vector{Float64})+f₂(ξ::Vector{Float64})

inverse2Dplot([q],r,[z],f,Δpos = 0.01,x_min = -6.0,x_max = 6.0,y_min = -6.0,y_max = 6.0)


# correct one

x_range = collect(-5.0:0.01:5.0)
y_range = collect(-5.0:0.01:5.0)
xyGrid = [[x, y] for x in x_range, y in y_range]
tᵢ = 0.0
for ξ ∈ xyGrid
      tᵢ = (norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c
end
if tᵢ<T
      td=0.0
      Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
      Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
     f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                                 (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
elseif T<tᵢ<2T
      td=T
 Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
 Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
 f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                               (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
else  tᵢ>2T
      td=2T
      Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
      Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
      f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
                                    (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
end

inverse2Dplot([q],r,[z],f)
png(path*"scenarioD_STATdirectioSourcesimulation.png")

#Δpos = 0.01,x_min = -6.0,x_max = 6.0,y_min = -6.0,y_max = 6.0



#elseif T<tᵢ<2T
#      td=T
#      Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
#      Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
#      f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
#                                  (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
#elseif 2T<tᵢ<3T
#      td=2T
#      Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
#      Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
#      f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
#                                  (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
#else tᵢ>3T
#      td=3T
#      Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
#      Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
#      f(ξ::Vector{Float64}) = (z(td+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
#                                  (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
#end

#Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
#Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
#f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64}))/
#                            (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))




png(path*"scenarioD_STATDsimulation.png")
