#DEFINE STATIONARY Ï w/ DIRECTIONAL ANTENNA and TIME-INVARIANT BEAM CENTER

struct LTIreceiverDTI <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Vector{Float64}
   beamCenter::Vector{Float64}
   antennaGain ::Function
end

function (Ï::LTIreceiverDTI)(tâ::Float64)
   sourceList = Ï.sourceList
   ğ©áµ£ = Ï.position
   ğ, G = Ï.beamCenter , Ï.antennaGain
      val = 0.0
      for i = 1:length(sourceList)
         val+=sourceList[i](ğ©áµ£,tâ) * G(angleBetween(ğ, ğ©áµ£-sourceList[i].S.position))
      end
      return val
end


#Display
Base.show(io::IO, x::LTIreceiverDTI) = print(io, "LTI Directional Receiver")
