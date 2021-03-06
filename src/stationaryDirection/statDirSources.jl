#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

struct LTIsourceD <: Sources
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Function
  antennaGain ::Function
end

function (ğ½::LTIsourceD)(ğâ::Vector{Float64}, tâ::Float64)
   ğ©â, p, = ğ½.position, ğ½.transmission
   ğ, G = ğ½.beamCenter , ğ½.antennaGain
   delay = norm(ğ©â-ğâ)/c
   return A(delay) * p(tâ-delay) * G( angleBetween(ğ(tâ-delay), ğâ-ğ©â) )
end


Base.show(io::IO, x::LTIsourceD) = print(io, "Stationary Direction Source with Time-Varying Beam Center")
