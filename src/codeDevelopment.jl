using Roots, LinearAlgebra, LTVsystems, Plots

τ = 2.0

𝐩ₛ(t) = [0.0, 0.0] + [10.0, 0.0]*t


𝐩ₛ(3.0)

𝛏 = [5000000000.0, 5.0]

function TXₜ2RXₜ(τ,𝛏,𝐩ₛ)
    f(t) = τ + norm(𝛏-𝐩ₛ(τ))/c-t
    return find_zero( f , 0)[1]
end



TXₜ2RXₜ(τ,𝛏,𝐩ₛ)

t= 0:0.01:10
plot(t, f.(t))
plot!([t₀],[f(t₀)], marker = :circle)


