path = "docs/src/assets/"

# Scenario A with LTI directional antenna and time inavriant beam center
using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
tₚ = 1.0e-06 # in microseconds
p(t) = δn(t-tₚ,1.0e-07)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
#q = LTIsourceO(𝐩ₛ, p) 
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
#z = LTIreceiverO([r],𝐩ᵣ)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))

png(path*"scenarioA_LTIDirsignal.png")

scenePlot2D([q],[r],[z])

scenedirPlot2D([q],[r],[z],𝐛)

png(path*"scenarioA_LTIDir.png")
# Estimator function
D(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ+ 2(norm(ξ-𝐩ₛ))/c).*(D(ξ::Vector{Float64}))^2)/
                        (A(norm(ξ-𝐩ₛ)/c))^2
#SPATIAL SIMULATION
inversePlot2D([q],[r],[z],f)

png(path*"scenarioA_DirTIsimulation.png")



Δpos = 0.01e03
x_min = -0.5c*15.0e-6
x_max = 0.5c*15.0e-6
y_min = -0.5c*15.0e-6
y_max = 0.5c*15.0e-6

#cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
val_max = maximum(abs.(val))
p2 = plot(x_range,y_range,transpose(abs.(val)),st=:surface,camera=(0,90),clim=(0,val_max),
 aspect_ratio=:equal,size=(800,800),legend=false,left_margin = 5Plots.mm, right_margin = 15Plots.mm,colorbar=false,zticks=false)
