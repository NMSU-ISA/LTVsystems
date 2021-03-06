#DEFINE STATIONARY Ï w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

struct LTIreceiverD <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Vector{Float64}
   beamCenter::Function
   antennaGain ::Function
end

function (Ï::LTIreceiverD)(tâ::Float64)
   sourceList = Ï.sourceList
   ğ©áµ£ = Ï.position
   ğ, G = Ï.beamCenter , Ï.antennaGain
      val = 0.0
      for i = 1:length(sourceList)
         val+=sourceList[i](ğ©áµ£,tâ) * G( angleBetween(ğ(tâ), ğ©áµ£-sourceList[i].position) )
      end
      return val
end

Base.show(io::IO, x::LTIreceiverD) = print(io, "Stationary Direction Receiver with Time-Varying Beam Center")
