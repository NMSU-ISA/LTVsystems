using LTVsystems, QuadGK
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,2.0]; 𝐮 = [1.0,0.0]; L=1.0
r = lineSegment(𝛏₀,𝐮,L,k->α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
f(𝛏::Vector{Float64}) = z(2(norm(𝛏-𝐩ₛ))./c)./(A(norm(𝛏-𝐩ₛ)./c))^2
inverse2Dplot([q],[r],[z],f)
