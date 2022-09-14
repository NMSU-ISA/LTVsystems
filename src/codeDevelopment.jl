using LinearAlgebra, LTVsystems, Plots


𝐩ₛ(t) = [0.0, 0.0] + [0.999c, 1.0]*t


𝛏₀ = [1.0c, 0.0]


p(t) = exp(-t^2)
q = LTVsourceO(𝐩ₛ,p)



p(t) = exp(-t^2)*exp(1im*2π*5*t)


t₀ = 0.0
q(𝛏₀,t₀)

t = collect(0.0:0.01:5.0)
z = [ q(𝛏₀,t₀) for t₀∈t] 

plot(t,real(p.(t)))
plot(t,real(z))





function TXₜ2RXₜ(τ,𝛏,𝐩ₛ)
    return τ - norm(𝛏-𝐩ₛ(τ))/c
end

 z = [ t₀ - TXₜ2RXₜ(t₀,𝛏₀,𝐩ₛ) for t₀∈t] 
 plot(t,z)


 A(t₀) * p(t₀)
