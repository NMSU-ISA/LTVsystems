"""
    z = LTIreceiverO([R₁,R₂,…Rₙ],𝐩ᵣ)

Create an LTI Omnidirectional Receiver by calling `LTIreceiverO()` with
the *receiver position*, 𝐩ᵣ and all the *reflections*, `Rᵢ` where i=1,2,…n.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiverO([R₁],𝐩ᵣ)
```
"""
struct LTIreceiverO
   sourceList::Vector{LTISources}
   position::Vector{Float64}
end

function (ψ::LTIreceiverO)(t₀::Float64)
sourceList = ψ.sourceList
𝐩ᵣ = ψ.position
   val = 0.0
   for i = 1:length(sourceList)
      val+=sourceList[i](𝐩ᵣ,t₀)
   end
   return val
end

#DEFINE STATIONARY ψ w/ DIRECTIONAL ANTENNA and TIME-INVARIANT BEAM CENTER

struct LTIreceiverDTI
   sourceList::Vector{LTISources}
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
         val+=sourceList[i](𝐩ᵣ,t₀) * G( angleBetween(𝐛, 𝐩ᵣ-sourceList[i].position) )
      end
      return val
end

#DEFINE STATIONARY ψ w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

struct LTIreceiverD
   sourceList::Vector{LTISources}
   position::Vector{Float64}
   beamCenter::Function
   antennaGain ::Function
end

function (ψ::LTIreceiverD)(t₀::Float64)
   sourceList = ψ.sourceList
   𝐩ᵣ = ψ.position
   𝐛, G = ψ.beamCenter , ψ.antennaGain
      val = 0.0
      for i = 1:length(sourceList)
         val+=sourceList[i](𝐩ᵣ,t₀) * G( angleBetween(𝐛(t₀), 𝐩ᵣ-sourceList[i].position) )
      end
      return val
end


# DISPLAY
Base.show(io::IO, x::LTIreceiverO) = print(io, "LTI Omnidirectional Receiver")
Base.show(io::IO, x::LTIreceiverDTI) = print(io, "LTI Receiver with Directional Antenna and Time-Invariant Beam Center")
Base.show(io::IO, x::LTIreceiverD) = print(io, "LTI Receiver with Directional Antenna and Time-Varying Beam Center")

LTIReceivers = Union{LTIreceiverO,
                   LTIreceiverDTI,
                   LTIreceiverD,
                   }


#multi-thread model evaluation over a time interval
function (z::LTIReceivers)(t::Vector{Float64})
   Z = zeros( typeof(z(0.0)), size(t))
   Threads.@threads for i = 1:length(t)
      Z[i] = z(t[i])
   end
   return Z
end
