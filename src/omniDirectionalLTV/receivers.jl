"""
    z = LTVreceiverO([r],𝐩ᵣ)
    z = LTVreceiverO(r,𝐩ᵣ)

Create an LTV Omnidirectional Receiver by calling `LTVreceiverO()` with
a vector of *single reflection*, `r`, provided by calling `pointReflector()`, and a time-varying *receiver position*, ``\\mathsf{p}_\\mathrm{r}(t)``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 q = LTVsourceO(𝐩ₛ, p)
 α = -0.7; 𝛏 = [3.75e-06c,0.0]
 r = pointReflector(𝛏,α,q)
 z = LTVreceiverO([r],𝐩ᵣ)
```
In order to observe the multiple reflections, we create an LTV Omnidirectional Receiver by calling `LTVreceiverO()` with
the observed *multiple reflection*, `r`,  provided by calling `pointReflector()` and a time-varying *receiver position*, ``\\mathsf{p}_\\mathrm{r}(t)``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 q = LTVsourceO(𝐩ₛ, p)
 α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
 α₁ = -0.7; 𝛏₁ = [1.5e-06c,0.0]
 α₂ = -0.7; 𝛏₂ = [2.5e-06c,0.0]
 r = pointReflector([𝛏₀,𝛏₁,𝛏₂],[α₀,α₁,α₂],[q])
 z = LTVreceiverO(r,𝐩ᵣ)
```
"""
struct  LTVreceiverO <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Function
end

function (ψ::LTVreceiverO)(t₀::Float64)
sourceList = ψ.sourceList
𝐩ᵣ = ψ.position
   val = 0.0
  for i = 1:length(sourceList)
      val+=sourceList[i](𝐩ᵣ(t₀),t₀)
   end
   return val
end



# DISPLAY
Base.show(io::IO, x::LTVreceiverO) = print(io, "LTV Omnidirectional Receiver")
