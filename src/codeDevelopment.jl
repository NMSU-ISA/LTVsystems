using Roots, LinearAlgebra, LTVsystems, Plots

𝐩ₛ(t) = [1.0c, 1.0c] + [0.5c, 1.0]*t
𝛏₀ = [1.0c, 0.0]

p(t) = exp(-t^2)*exp(1im*2π*5*t)
p(t) = exp(-t^2)

q = LTVsourceO(𝐩ₛ,p)

t₀ = 0.0
q(𝛏₀,t₀)

t = collect(0.0:0.01:5.0)
z = [ q(𝛏₀,t₀) for t₀∈t] 

plot(t,real(p.(t)))
plot(t,real(z))


