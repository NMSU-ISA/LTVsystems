"""
    z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
    z = STATreceiverD(r,𝐩ᵣ,𝐛,G)

Create an LTI Omnidirectional Receiver by calling `STATreceiverD()` with
a vector of *single reflection*, `r`, provided by calling `pointReflector()`, 
the *receiver position*, 𝐩ᵣ , a *time-varying (rotating) beam center*,
``\\bm{b}_\\mathrm{r}(t)`` and the *source antenna's gain*,
``\\mathrm{G}_\\mathrm{r}(\\Theta)`` relative to beam center ``\\bm{b}_\\mathrm{r}(t)``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
 G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
 q = STATsourceD(𝐩ₛ, p, 𝐛, G)
 α = -0.7; 𝛏 = [3.75e-06c,0.0]
 r = pointReflector(𝛏,α,q)
 z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
```
In order to observe the multiple reflections, we create an LTI Omnidirectional Receiver by calling `STATreceiverD()` with
the observed *multiple reflection*, `r`,  provided by calling `pointReflector()`, the *receiver position*, 𝐩ᵣ, a *time-varying (rotating) beam center*,
``\\bm{b}_\\mathrm{r}(t)`` and the *source antenna's gain*,
``\\mathrm{G}_\\mathrm{r}(\\Theta)`` relative to beam center ``\\bm{b}_\\mathrm{r}(t)``.

# Examples
```@example
 using LTVsystems
 𝐩ₛ =  [0.0, 0.0]
 𝐩ᵣ =  𝐩ₛ
 tₚ = 1.0e-06
 p(t) = δn(t-tₚ,1.0e-07)
 𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
 G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
 q = STATsourceD(𝐩ₛ, p, 𝐛, G)
 α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
 α₁ = -0.7; 𝛏₁ = [1.5e-06c,0.0]
 α₂ = -0.7; 𝛏₂ = [2.5e-06c,0.0]
 r = pointReflector([𝛏₀,𝛏₁,𝛏₂],[α₀,α₁,α₂],[q])
 z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
```
"""
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

Base.show(io::IO, x::STATreceiverD) = print(io, "Stationary Directional Receiver with Time-Varying Beam Center")
