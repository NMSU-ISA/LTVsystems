using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
R₁ = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([R₁],𝐩ᵣ)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
f(ξ::Vector{Float64}) = z(2(norm(ξ-𝐩ₛ))./lightSpeed)./(A(norm(ξ-𝐩ₛ)./lightSpeed))^2

inverse2Dplot([q],[R₁],[z],f)
