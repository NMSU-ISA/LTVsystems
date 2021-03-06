#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-INVARIANT BEAM CENTER

struct LTIsourceDTI <: Sources
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Vector{Float64}
  antennaGain ::Function
end

function (ğ½::LTIsourceDTI)(ğâ::Vector{Float64}, tâ::Float64)
   ğ©â, p, = ğ½.position, ğ½.transmission
   ğ, G = ğ½.beamCenter , ğ½.antennaGain
   delay = norm(ğ©â-ğâ)/c
   return A(delay) * p(tâ-delay) * G( angleBetween(ğ, ğâ-ğ©â) )
end

#Display
Base.show(io::IO, x::LTIsourceDTI) = print(io, "LTI Directional Source")
