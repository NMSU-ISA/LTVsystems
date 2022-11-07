"""
    z = LTIreceiverO([r],𝐩ᵣ)

Create an LTI Omnidirectional Receiver by calling `LTIreceiverO()` with
the *receiver position*, 𝐩ᵣ and all the *reflections*, `r`.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
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
