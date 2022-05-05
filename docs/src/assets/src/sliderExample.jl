using LTVsystems
using Plots
using Interact

mp = @manipulate for loc1 in slider(-1.0:0.1:1.0; label="S slider"), loc2 in slider(-1.0:0.1:1.0; label="R slider"),
    loc3 in slider(0.1:0.1:2.0; label="T slider"), loc4 in slider(0.1:0.1:2.0; label="Coef slider")
#Source
𝐩ₛ =  [1.0, 0.0]
𝐩ₛ =@. transpose(loc1.*𝐩ₛ)
# Transmitter's signal i.e single pulse
p(t) = δn(t,1.0e-10)
# Signal observed due to source
q = LTIsourceO(𝐩ₛ, p)
#Reflectors
α₀ = 3.0; 𝛏₀ = [1.2,0.0]; 𝐮 = [1.0,0.0]; L=1.0
α₀ =@. transpose(loc4.*α₀)
𝛏₀ = @. transpose(loc3.*𝛏₀)
r = lineSegment(𝛏₀,𝐮,L,k->α₀,[q])
α₁ = 1.0; 𝛏₁ = [1.2,0.0]
α₁ =@. transpose(loc4.*α₁)
#𝛏₁ = @. transpose(loc3.*𝛏₁)
R₁ = pointReflector(𝛏₁,α₁,[q])
# Observed signal
𝐩ᵣ =  [1.0, 0.0]
𝐩ᵣ = @. transpose(loc2.*𝐩ᵣ)
z = LTIreceiverO([R₁,r],𝐩ᵣ)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
end
#png(path*"scenarioB_signal.png")

#-----------------------------------------------------------------
# Estimator function

#f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))

#inverse2Dplot([q],[R₁,r],[z],f)
#end
#SPATIAL SIMULATION
#Δpos = 0.01
#x_range = collect(-2:Δpos:2)
#y_range = collect(-2:Δpos:2)
#xyGrid = [[x, y] for x in x_range, y in y_range]
#val = [f(𝐮) for 𝐮 ∈ xyGrid]

#p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,zticks=false,title="Scenario B Simulation")
#    scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
#    scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
#    scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
#end
