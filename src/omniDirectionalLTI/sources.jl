"""
   q = LTIsourcesO(𝐩ₛ, p)
   R = LTIsourcesO(𝛏, r)
Create an LTI Omnidirectional Source by calling `LTIsourcesO()` with
the *source position*, $\bm{p}_\mathrm{s}$ and the *transmisson signal*, `p`.

# Examples
```@example
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
```
Another type of sources, called as reflected sources can also be defined
by calling `LTIsourcesO()` with *reflectors* position, $\bm{ξ}$ and
the *reflected signal*, given by `r = α q(𝛏,t)`.

# Examples
```@example
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
```
"""
struct LTIsourcesO
  position::Vector{Float64}
  transmission ::Function
end

# Method
function (𝚽::LTIsourcesO)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   delay = distBetween(𝐩ₛ,𝛏₀)/lightSpeed
   return A(delay) * p(t₀-delay)
end

# DISPLAY
Base.show(io::IO, x::LTIsourcesO) = print(io, "LTI Omnidirectional Sources")
#multi-thread model evaluation over a 2D/3D space
function (q::LTIsourcesO)(𝛏::Array{Array{Float64,1}}, t₀::Float64)
   Q = zeros( typeof(q(𝛏[1], t₀)), size(𝛏))
   Threads.@threads for i =1:length(𝛏)
      Q[i] = q(𝛏[i], t₀)
   end
   return Q
end

#multi-thread model evaluation over a time interval
function (q::LTIsourcesO)(𝛏₀::Vector{Float64}, t::Vector{Float64})
   Q = zeros( typeof(q(𝛏₀, 0.0)), size(𝛏))
   Threads.@threads for i =1:length(t)
      Q[i] = q(𝛏₀, t[i])
   end
   return Q
end
