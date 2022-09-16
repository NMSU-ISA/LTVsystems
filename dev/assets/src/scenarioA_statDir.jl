using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
𝐛(t) = [cos(2π*1.0e8*t),sin(2π*1.0e8*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverD([r],𝐩ᵣ,𝐛,G)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot(t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

#function Θ(ξ₀,ξ₁,t₀)
#    return angleBetween(ξ₀(t₀),ξ₁)
#end
#M(ξ::Vector{Float64})=[G(angleBetween(𝐛(t₀), ξ.-𝐩ᵣ)) for t₀∈collect(0.0:0.1:0.5)]

D(ξ::Vector{Float64},t₀::Float64) = G(angleBetween(𝐛(t₀), ξ.-𝐩ᵣ))
f(ξ::Vector{Float64},t₀::Float64) = (z(2(norm(ξ-𝐩ₛ))/c).*(D(ξ::Vector{Float64},t₀::Float64))^2)/
                        (A(norm(ξ-𝐩ₛ)/c))^2
#SPATIAL SIMULATION
#inverse2Dplot([q],[r],[z],ff)





x_range = collect(-4.0:0.01:4.0)
y_range = collect(-4.0:0.01:4.0)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮,t₀) for 𝐮 ∈ xyGrid, t₀∈collect(0.0:0.1:1.0)]

p2 = plot(x_range,y_range,transpose(val[:,:,5]),st=:surface,camera=(0,90),
        aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)

for i = 1:length(val[1,1,:])
        p22=plot(x_range,y_range,transpose(val[:,:,i]),st=:surface,camera=(0,90),
       aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)
       display(p22)
end
