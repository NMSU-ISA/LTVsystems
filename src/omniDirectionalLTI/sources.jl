"""
# Examples
```@example
using LTVsystems
```
"""
struct LTIsourcesO
  position::Vector{Float64}
  transmission ::Function
end

# Method
function (𝚽::LTIsourcesO)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   delay = distBetween(𝐩ₛ,𝛏₀)/lightSpeed
   return A(delay) * p(t₀-delay)
end

# DISPLAY
Base.show(io::IO, x::LTIsourcesO) = print(io, "LTI Omnidirectional Sources")
#multi-thread model evaluation over a 2D/3D space
function (q::LTIsourcesO)(𝛏::Array{Array{Float64,1}}, t₀::Float64)
   Q = zeros( typeof(q(𝛏[1], t₀)), size(𝛏))
   Threads.@threads for i =1:length(𝛏)
      Q[i] = q(𝛏[i], t₀)
   end
   return Q
end

#multi-thread model evaluation over a time interval
function (q::LTIsourcesO)(𝛏₀::Vector{Float64}, t::Vector{Float64})
   Q = zeros( typeof(q(𝛏₀, 0.0)), size(𝛏))
   Threads.@threads for i =1:length(t)
      Q[i] = q(𝛏₀, t[i])
   end
   return Q
end
