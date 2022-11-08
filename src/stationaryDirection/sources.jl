"""
    q = STATsourceD(𝐩ₛ, p)
    
Create a Stationary Directional Source by calling `STATsourceD()` with
the *source position*, 𝐩ₛ ,a *transmitted signal*, ``\\mathsf{p}(t)``, *time-varying (rotating) beam center*,
``\\bm{b}_\\mathrm{s}(t)`` and the *source antenna's gain*,
``\\mathrm{G}_\\mathrm{s}(\\Theta).``

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
𝐛ₛ(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ, p, 𝐛ₛ, G)
```
"""
struct STATsourceD <: Sources
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Function
  antennaGain ::Function
end

function (𝚽::STATsourceD)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p, = 𝚽.position, 𝚽.transmission
   𝐛, G = 𝚽.beamCenter , 𝚽.antennaGain
   delay = norm(𝐩ₛ-𝛏₀)/c
   return A(delay) * p(t₀-delay) * G( angleBetween(𝐛(t₀-delay), 𝛏₀-𝐩ₛ) )
end


Base.show(io::IO, x::STATsourceD) = print(io, "Stationary Directional Source with Time-Varying Beam Center")
