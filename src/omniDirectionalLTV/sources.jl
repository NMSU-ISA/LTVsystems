"""
    q = LTVsourceO(𝐩ₛ, p)

Create an LTV Omnidirectional Source by calling `LTVsourceO()` with time-varying
*source position*, ``\\mathsf{p}_\\mathrm{s}(t)`` and the *transmisson signal*, ``\\mathsf{p}(t)``.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
q = LTVsourceO(𝐩ₛ, p)
```
"""
struct LTVsourceO <: Sources
  position::Function
  transmission ::Function
end

# Methods
function (𝚽::LTVsourceO)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   tₜₓ = RXₜ2TXₜ(t₀,𝛏₀,𝐩ₛ) 
   return A(norm(𝛏₀-𝐩ₛ(tₜₓ))/c) * p(tₜₓ)
end


# DISPLAY
Base.show(io::IO, x::LTVsourceO) = print(io, "LTV Omnidirectional Source")
