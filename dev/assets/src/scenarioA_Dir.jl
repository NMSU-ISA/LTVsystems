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

# Estimator function
a₁(ξ::Vector{Float64}) = α₁.*(A(norm(ξ - 𝐩ₛ)./lightSpeed))^2
D(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))^2
f(ξ::Vector{Float64})=(z(2(norm(ξ - 𝐩ₛ))./lightSpeed))./(a₁(ξ::Vector{Float64})).*D(ξ::Vector{Float64})

#SPATIAL SIMULATION
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=true,legendfontsize=7,colorbar=false,zticks=false,bg = RGB(0.0, 0.0, 0.0))
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon,label=["Source" ""] )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square,label=["Receiver" ""] )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8,label=["Reflector" ""])

png(path*"scenarioA_DirTIsimulation.png")
