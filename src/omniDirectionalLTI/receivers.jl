"""
# Examples
```@example
using LTVsystems
```
"""
struct LTIreceiversO
   sourceList::Vector{LTIsourcesO}
   position::Vector{Float64}
end

function (ψ::LTIreceiversO)(t₀::Float64)
sourceList = ψ.sourceList
𝐩ᵣ = ψ.position
   val = 0.0
   for i = 1:length(sourceList)
      val+=sourceList[i](𝐩ᵣ,t₀)
   end
   return val
end

# DISPLAY
Base.show(io::IO, x::LTIreceiversO) = print(io, "LTI Omnidirectional Receivers")

#multi-thread model evaluation over a time interval
function (z::LTIreceiversO)(t::Vector{Float64})
   Z = zeros( typeof(z(0.0)), size(t))
   Threads.@threads for i = 1:length(t)
      Z[i] = z(t[i])
   end
   return Z
end
