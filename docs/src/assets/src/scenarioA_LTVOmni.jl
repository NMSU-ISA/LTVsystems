path = "docs/src/assets/"
using LTVsystems
using Plots
𝐩ₛ(t) = [0.5c, 0.0]*t
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

#Inverse modeling

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ(?)) .+ norm(𝐩ᵣ(?)-ξ))./c)+?)./
                       (A(norm(ξ-𝐩ₛ(?))./c).*A(norm(𝐩ᵣ(?)-ξ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
