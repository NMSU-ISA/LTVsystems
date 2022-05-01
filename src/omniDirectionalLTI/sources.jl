"""
    q = LTIsourceO(𝐩ₛ, p)
    R = LTIsourceO(𝛏, r)

Create an LTI Omnidirectional Source by calling `LTIsourceO()` with
the *source position*, 𝐩ₛ and the *transmisson signal*, `p`.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
```
Another type of sources, called as reflected sources can also be defined
by calling `LTIsourceO()` with *reflectors* position, 𝛏 and
the *reflected signal*, given by `r = α q(𝛏,t)`.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
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
