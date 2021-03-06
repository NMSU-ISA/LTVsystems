path = "docs/src/assets/"

using LTVsystems
using Plots
π©ββ =  [-0.8, 0.0]
π©α΅£β =  [-0.4, 0.0]

π©ββ =  [0.1, 0.0]
π©α΅£β =  [0.5, 0.0]

π©ββ =  [0.8, 0.0]
π©α΅£β =  [1.2, 0.0]

p(t) = Ξ΄n(t,1.0e-10)
qβ = LTIsourceO(π©ββ, p)
qβ = LTIsourceO(π©ββ, p)
qβ = LTIsourceO(π©ββ, p)
#Multiple Targets
Ξ±β = 0.7; πβ = [0.7,0.9]
#Ξ±β = 0.5; πβ = [0.6,0.2]
#Ξ±β = 0.4; πβ = [0.6,1.0]
rβ = pointReflector(πβ,Ξ±β,[qβ])
rβ = pointReflector(πβ,Ξ±β,[qβ])
rβ = pointReflector(πβ,Ξ±β,[qβ])

# Observed signal
zβ = LTIreceiverO([rβ],π©α΅£β)
zβ = LTIreceiverO([rβ],π©α΅£β)
zβ = LTIreceiverO([rβ],π©α΅£β)

t = 0.0:1.0e-10:15.5e-9
p1 = plot( t, zβ(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, zβ(t))
plot!(p1,t, zβ(t))



png(path*"scenarioE_signal.png")

scene2Dplot([qβ,qβ,qβ],[rβ,rβ,rβ],[zβ,zβ,zβ])

png(path*"scenarioE.png")

fβ(ΞΎ::Vector{Float64})=(zβ((norm(ΞΎ-π©ββ) .+ norm(π©α΅£β-ΞΎ))./c))./(A(norm(ΞΎ-π©ββ)./c).*A(norm(π©α΅£β-ΞΎ)./c))
fβ(ΞΎ::Vector{Float64})=(zβ((norm(ΞΎ-π©ββ) .+ norm(π©α΅£β-ΞΎ))./c))./(A(norm(ΞΎ-π©ββ)./c).*A(norm(π©α΅£β-ΞΎ)./c))
fβ(ΞΎ::Vector{Float64})=(zβ((norm(ΞΎ-π©ββ) .+ norm(π©α΅£β-ΞΎ))./c))./(A(norm(ΞΎ-π©ββ)./c).*A(norm(π©α΅£β-ΞΎ)./c))


f(ΞΎ::Vector{Float64})=fβ(ΞΎ::Vector{Float64}).+fβ(ΞΎ::Vector{Float64}).+fβ(ΞΎ::Vector{Float64})
inverse2Dplot([qβ,qβ,qβ],[rβ,rβ,rβ],[zβ,zβ,zβ],f)

png(path*"scenarioE_simulation.png")

# Target estimation
f_new(ΞΎ::Vector{Float64})=(fβ(ΞΎ::Vector{Float64}).*fβ(ΞΎ::Vector{Float64}).*fβ(ΞΎ::Vector{Float64}))
#SPATIAL SIMULATION
inverse2Dfinalplot([qβ,qβ,qβ],[zβ,zβ,zβ],f_new)

png(path*"scenarioE_target_estimation.png")


#Ξpos = 0.01
#x_range = collect(-3:Ξpos:3)
#y_range = collect(-3:Ξpos:3)
#xyGrid = [[x, y] for x in x_range, y in y_range]
#val11 = [f_new(π?) for π? β xyGrid]
#plot(x_range,y_range,transpose(val11),st=:surface,camera=(0,90),
#         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
