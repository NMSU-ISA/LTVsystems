#DECLARE PHYSICAL CONSTANTS AND FUNCTIONS

const c = 299_792_458.0
const μ₀ = 1.25663706212e-6
const Z₀ = μ₀*c

#amplitude-scale due to divergence
function A(t₀::Float64)::Float64
   return sqrt(Z₀)/(sqrt(4π)*c*t₀)
end

#---------------------------------------------
#DECLARE SPECIAL FUNCTIONS

function NaNnormalize(𝛏₀::Vector{Float64})::Vector{Float64}
   return ifelse( norm(𝛏₀)==0, zero(𝛏₀), normalize(𝛏₀) )
end

function angleBetween(𝛏₀::Vector{Float64},𝛏₁::Vector{Float64})::Float64
   temp = dot(NaNnormalize(𝛏₁),NaNnormalize(𝛏₀))
   temp = ifelse(abs(temp)<1,temp,temp/(abs(temp)) )
   return acos(temp)
end

function TXₜ2RXₜ(τ,𝛏,𝐩ₛ)
   return τ - norm(𝛏-𝐩ₛ(τ))/c
end
