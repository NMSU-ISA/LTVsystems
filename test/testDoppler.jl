using LTVsystems
using Plots
𝐩ₛ(t) = [0.0, 0.0] + [1.0, 0.0]*t
𝐩ᵣ = [1.0, 2.0]
p(t) = exp(-t^2)
#p(t) = exp(im*2π*1.0e09*t)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(0.0:0.01:5.0)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
