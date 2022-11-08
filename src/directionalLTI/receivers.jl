"""
    z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
    z = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G)

Create an LTI Omnidirectional Receiver by calling `LTIreceiverDTI()` with
a vector of *single reflection*, `r`, provided by calling `pointReflector()`, 
the *receiver position*, ``\\mathsf{p}_\\mathrm{r}`` , a *time-invariant beam center*,
``\\bm{b}_\\mathrm{r}`` and the *source antenna's gain*,
``\\mathrm{G}_\\mathrm{r}(\\Theta)`` relative to beam center ``\\bm{b}_\\mathrm{r}``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 𝐛 = [1.0,0.0]
 G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
 q = LTIsourceDTI(𝐩ₛ, p, 𝐛, G)
 α = -0.7; 𝛏 = [3.75e-06c,0.0]
 r = pointReflector(𝛏,α,q)
 z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
```
In order to observe the multiple reflection, we create an LTI Omnidirectional Receiver by calling `LTIreceiverDTI()` with
the observed *multiple reflection*, `r`,  provided by calling `pointReflector()`, the *receiver position*, ``\\mathsf{p}_\\mathrm{r}``, a *time-invariant beam center*,
``\\bm{b}_\\mathrm{r}`` and the *source antenna's gain*,
``\\mathrm{G}_\\mathrm{r}(\\Theta)`` relative to beam center ``\\bm{b}_\\mathrm{r}``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 𝐛 = [1.0,0.0]
 G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
 q = LTIsourceDTI(𝐩ₛ, p, 𝐛, G)
 α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
 α₁ = -0.7; 𝛏₁ = [1.5e-06c,0.0]
 α₂ = -0.7; 𝛏₂ = [2.5e-06c,0.0]
 r = pointReflector([𝛏₀,𝛏₁,𝛏₂],[α₀,α₁,α₂],[q])
 z = LTIreceiverDTI(r,𝐩ᵣ,𝐛,G)
```
"""
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
         val+=sourceList[i](𝐩ᵣ,t₀) * G(angleBetween(𝐛, 𝐩ᵣ-sourceList[i].S.position))
      end
      return val
end


#Display
Base.show(io::IO, x::LTIreceiverDTI) = print(io, "LTI Directional Receiver")
