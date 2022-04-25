function u(t::Float64)::Float64 #unit step function
    return ifelse( t < 0, zero(t), one(t) )
end


function 𝒩ᵤ(x::Float64; μ::Float64, σ::Float64)::Float64
    return exp(-0.5 * ((x - μ) / σ)^2)
end


function 𝒩(x::Float64; μ::Float64, σ::Float64)::Float64
    return 1 / (σ * sqrt(2 * π)) * exp(-0.5 * ((x - μ) / σ)^2)
end


function δn(t::Float64,σ::Float64=1.0e-11)::Float64
   return 𝒩ᵤ(t, μ=0.0, σ=σ)
end


function δ(t::Float64,σ::Float64=1.0e-11)::Float64
   return 𝒩(t, μ=0.0, σ=σ)
end
