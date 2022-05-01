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

#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

struct LTIsourceD <: Sources
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Function
  antennaGain ::Function
end

function (source::LTIsourceD)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p, = source.position, source.transmission
   𝐛, G = source.beamCenter , source.antennaGain
   delay = norm(𝐩ₛ-𝛏₀)/c
   return A(delay) * p(t₀-delay) * G( angleBetween(𝐛(t₀-delay), 𝛏₀-𝐩ₛ) )
end

#Display

Base.show(io::IO, x::LTIsourceDTI) = print(io, "LTI Directional Source")
Base.show(io::IO, x::LTIsourceD) = print(io, "Stationary Direction Source with Time-Varying Beam Center")
