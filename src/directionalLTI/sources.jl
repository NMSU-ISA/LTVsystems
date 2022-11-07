"""
    q = LTIsourceDTI(𝐩ₛ, p)
    
Create an LTI Directional Source by calling `LTIsourceDTI()` with
the *source position*, 𝐩ₛ ,a *transmitted signal*, ``\\mathsf{p}(t)``, *time-invariant beam center*,
``\\bm{b}_\\mathrm{s}`` and the *source antenna's gain*,
``\\mathrm{G}_\\mathrm{s}(\\Theta).``

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
𝐛ₛ = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ, p, 𝐛ₛ, G)
```
"""
struct LTIsourceDTI <: Sources
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Vector{Float64}
  antennaGain ::Function
end

function (𝚽::LTIsourceDTI)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p, = 𝚽.position, 𝚽.transmission
   𝐛, G = 𝚽.beamCenter , 𝚽.antennaGain
   delay = norm(𝐩ₛ-𝛏₀)/c
   return A(delay) * p(t₀-delay) * G( angleBetween(𝐛, 𝛏₀-𝐩ₛ) )
end

#Display
Base.show(io::IO, x::LTIsourceDTI) = print(io, "LTI Directional Source")
