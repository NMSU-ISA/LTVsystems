#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-INVARIANT BEAM CENTER

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
