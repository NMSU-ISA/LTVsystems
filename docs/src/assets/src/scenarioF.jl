path = "docs/src/assets/"

using LTVsystems
using QuadGK
using Plots

𝐩ₛ =  [0.1, 0.0]
𝐩ᵣ =  [0.6, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = [1.8,2.0]; 𝛖 = [1.0,0.0]; len=1.0
r = lineSegment(𝛏₀,𝛖,len,k->α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)

t = 0.0:1.0e-10:35.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioF_signal.png")


scene2Dplot([q],[r],[z])

png(path*"scenarioF.png")

f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)
png(path*"scenarioF_simulation.png")



#-----------------------------------------------------------------------



