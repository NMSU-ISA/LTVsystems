"""
    z = LTIreceiverO([R₁,R₂,…Rₙ],𝐩ᵣ)

Create an LTI Omnidirectional Receiver by calling `LTIreceiverO()` with
the *receiver position*, 𝐩ᵣ and all the *reflections*, `Rᵢ` where i=1,2,…n.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiverO([R₁],𝐩ᵣ)
```
"""
struct  LTIreceiverO <: Receivers
   sourceList::Vector{SourcesReflectors}
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



# DISPLAY
Base.show(io::IO, x::LTIreceiverO) = print(io, "LTI Omnidirectional Receiver")





#multi-thread model evaluation over a time interval
function (z::Receivers)(t::Vector{<:Real})
   Z = zeros( typeof(z(0.0)), size(t))
   Threads.@threads for i = 1:length(t)
      Z[i] = z(t[i])
   end
   return Z
end
#(t::Vector{Float64})
function (z::Receivers)(t::StepRangeLen)
  return (z::Receivers)(collect(t))
end
function (z::Receivers)(t::UnitRange)
  return (z::Receivers)(collect(t))
end
