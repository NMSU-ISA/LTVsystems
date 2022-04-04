path = "docs/src/assets/"

using ISA, LTVSourceReceiverModel
using Plots
#Source
𝐩ₛ =  [0.0, 0.3]
# Multiple Receiver
𝐩ᵣ =  [-0.3, 0.0]
# Transmitter's signal i.e single pulse
p(t) = δ(t-1.0e-15,1.0e-10)
# Signal observed due to source
q = omnidirectionalLTISource(𝐩ₛ, p)

# Continuos target, suppose line segment AB has length 2
ξ₀=[0.9,0.0]
temp = quadgk.(x->ξ₀.+x.*[1.0,0.0],0.0,1.0)

α₁ = 10.7; 𝛏₁ = temp[1]
R₁ = omnidirectionalLTISource(𝛏₁, t->α₁*q(𝛏₁,t))

# Observed signal
z = omnidirectionalLTIListener([R₁],𝐩ᵣ)

#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioE_signal.png")

# Estimator function
