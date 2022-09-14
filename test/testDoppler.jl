using LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ(t) = [1.0, 2.0e08*t-1.0]
p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
