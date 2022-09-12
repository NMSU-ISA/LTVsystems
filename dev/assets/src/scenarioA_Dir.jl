path = "docs/src/assets/"

# Scenario A with LTI directional antenna and time inavriant beam center
using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)

𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
#q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
#z = LTIreceiverO([r],𝐩ᵣ)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot(t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioA_LTIDirsignal.png")

scene2Dplot([q],[r],[z])
png(path*"scenarioA_LTIDir.png")
# Estimator function
D(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))
f(ξ::Vector{Float64}) = z(2(norm(ξ-𝐩ₛ))/c)/
                        (A(norm(ξ-𝐩ₛ)/c))^2 .*(D(ξ::Vector{Float64}))^2
#SPATIAL SIMULATION
inverse2Dplot([q],[r],[z],f)

png(path*"scenarioA_DirTIsimulation.png")
