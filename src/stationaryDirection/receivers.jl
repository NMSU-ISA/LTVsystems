#DEFINE STATIONARY ψ w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

struct STATreceiverD <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Vector{Float64}
   beamCenter::Function
   antennaGain ::Function
end

function (ψ::STATreceiverD)(t₀::Float64)
   sourceList = ψ.sourceList
   𝐩ᵣ = ψ.position
   𝐛, G = ψ.beamCenter , ψ.antennaGain
      val = 0.0
      for i = 1:length(sourceList)
         val+=sourceList[i](𝐩ᵣ,t₀) * G(angleBetween(𝐛(t₀), 𝐩ᵣ-sourceList[i].S.position))
      end
      return val
end

Base.show(io::IO, x::STATreceiverD) = print(io, "Stationary Direction Receiver with Time-Varying Beam Center")
