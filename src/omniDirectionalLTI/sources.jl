"""
    q = LTIsourceO(𝐩ₛ, p)
    
Create an LTI Omnidirectional Source by calling `LTIsourceO()` with
the *source position*, 𝐩ₛ and the *transmisson signal*, `p`.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
```
"""
struct LTIsourceO <: Sources
  position::Vector{Float64}
  transmission ::Function
end

# Methods
function (𝚽::LTIsourceO)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   delay = norm(𝐩ₛ-𝛏₀)/c
   return A(delay) * p(t₀-delay)
end




# DISPLAY
Base.show(io::IO, x::LTIsourceO) = print(io, "LTI Omnidirectional Source")
