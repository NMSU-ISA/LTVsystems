#DEFINE STATIONARY ψ w/ DIRECTIONAL ANTENNA and TIME-INVARIANT BEAM CENTER

struct LTIreceiverDTI <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Vector{Float64}
   beamCenter::Vector{Float64}
   antennaGain ::Function
end

function (ψ::LTIreceiverDTI)(t₀::Float64)
   sourceList = ψ.sourceList
   𝐩ᵣ = ψ.position
   𝐛, G = ψ.beamCenter , ψ.antennaGain
      val = 0.0
      for i = 1:length(sourceList)
         val+=sourceList[i](𝐩ᵣ,t₀) * G(angleBetween(𝐛, 𝐩ᵣ-sourceList[i].position))
      end
      return val
end


#Display
Base.show(io::IO, x::LTIreceiverDTI) = print(io, "LTI Directional Receiver")
