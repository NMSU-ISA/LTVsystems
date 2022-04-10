"""
    z = LTIreceiversO([R₁,R₂,…Rₙ],𝐩ᵣ)

Create an LTI Omnidirectional Receiver by calling `LTIreceiversO()` with
the *receiver position*, 𝐩ᵣ and all the *reflections*, `Rᵢ` where i=1,2,…n.

# Examples
```@example
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiversO([R₁],𝐩ᵣ)
```
"""
struct LTIreceiversO
   sourceList::Vector{LTISources}
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
