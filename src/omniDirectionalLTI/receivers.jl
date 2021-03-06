"""
    z = LTIreceiverO([Rā,Rā,ā¦Rā],š©įµ£)

Create an LTI Omnidirectional Receiver by calling `LTIreceiverO()` with
the *receiver position*, š©įµ£ and all the *reflections*, `Rįµ¢` where i=1,2,ā¦n.

# Examples
```@example
using LTVsystems
š©ā =  [0.0, 0.0]
š©įµ£ =  š©ā
p(t) = Ī“n(t,1.0e-10)
q = LTIsourceO(š©ā, p)
Ī±ā = 0.7; šā = [1.8,0.0]
r = pointReflector(šā,Ī±ā,q)
z = LTIreceiverO([r],š©įµ£)
```
"""
struct  LTIreceiverO <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Vector{Float64}
end

function (Ļ::LTIreceiverO)(tā::Float64)
sourceList = Ļ.sourceList
š©įµ£ = Ļ.position
   val = 0.0
   for i = 1:length(sourceList)
      val+=sourceList[i](š©įµ£,tā)
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
