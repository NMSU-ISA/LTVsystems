path = "data/"

using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 
M = 4 
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.0,0.10c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.0]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.0]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [0.0,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(M*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)

#t = collect(0.0:T/100:5T)
#plot(t,p.(t))

#plot(t,z.(t),ylims=(minimum(z.(t)),maximum(z.(t))))

Δpos = 0.01e03
x_min = -0.5c*15.0e-6
x_max = 0.5c*15.0e-6
y_min = -0.5c*15.0e-6
y_max = 0.5c*15.0e-6
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
#val = [q(𝐮,5.0e-6) for 𝐮 ∈ xyGrid]
#plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90))
val_max = []
allPlots = []
for t ∈ 0:T/10:4T
    #val = [q(𝐮,t) + r[1](𝐮,t) for 𝐮 ∈ xyGrid]
    val = [q(𝐮,t) + r[1](𝐮,t)+r[2](𝐮,t)+r[3](𝐮,t)+r[4](𝐮,t)+r[5](𝐮,t)+r[6](𝐮,t)+r[7](𝐮,t)+r[8](𝐮,t) for 𝐮 ∈ xyGrid]
    p1 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    scatter!(p1,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p1,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p1,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    scatter!(p1,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    scatter!(p1,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    scatter!(p1,[𝛏₄[1]],[𝛏₄[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    scatter!(p1,[𝛏₅[1]],[𝛏₅[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    scatter!(p1,[𝛏₆[1]],[𝛏₆[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    scatter!(p1,[𝛏₇[1]],[𝛏₇[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    scatter!(p1,[𝛏₈[1]],[𝛏₈[2]],markersize = 8.5,color = :red, marker=:star8, label="")
    plot!(p1,300*[𝐩ₛ[1],𝐛(t)[1]],300*[𝐩ₛ[2],𝐛(t)[2]],arrow=true,size=(800,800),color=:red,linewidth=3,label="Beam Center")
    frame = plot(p1, size = (800, 800) )
    push!(allPlots, frame)
    val_max = maximum(abs.(val))
end
anim = @animate for i ∈ 1:length(allPlots)
    plot(allPlots[i],clims=(0,val_max))
end
gif(anim, path*"STATDirScenarioA15.gif", fps = 30)