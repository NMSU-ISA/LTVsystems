#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

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
