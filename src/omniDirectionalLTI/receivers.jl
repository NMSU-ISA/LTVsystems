"""
    z = LTIreceiverO([r],𝐩ᵣ)
    z = LTIreceiverO(r,𝐩ᵣ)

Create an LTI Omnidirectional Receiver by calling `LTIreceiverO()` with
a vector of *single reflection*, `r`, provided by calling `pointReflector()`, and the *receiver position*, ``\\mathsf{p}_\\mathrm{r}``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 q = LTIsourceO(𝐩ₛ, p)
 α = -0.7; 𝛏 = [3.75e-06c,0.0]
 r = pointReflector(𝛏,α,q)
 z = LTIreceiverO([r],𝐩ᵣ)
```
In order to observe the multiple reflections, we create an LTI Omnidirectional Receiver by calling `LTIreceiverO()` with
the observed *multiple reflection*, `r`,  provided by calling `pointReflector()` and the *receiver position*, ``\\mathsf{p}_\\mathrm{r}``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 q = LTIsourceO(𝐩ₛ, p)
 α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
 α₁ = -0.7; 𝛏₁ = [1.5e-06c,0.0]
 α₂ = -0.7; 𝛏₂ = [2.5e-06c,0.0]
 r = pointReflector([𝛏₀,𝛏₁,𝛏₂],[α₀,α₁,α₂],[q])
 z = LTIreceiverO(r,𝐩ᵣ)
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
