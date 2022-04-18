"""
    q = LTIsourceO(𝐩ₛ, p)
    R = LTIsourceO(𝛏, r)

Create an LTI Omnidirectional Source by calling `LTIsourceO()` with
the *source position*, 𝐩ₛ and the *transmisson signal*, `p`.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
```
Another type of sources, called as reflected sources can also be defined
by calling `LTIsourceO()` with *reflectors* position, 𝛏 and
the *reflected signal*, given by `r = α q(𝛏,t)`.

# Examples
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
```
"""
struct LTIsourceO
  position::Vector{Float64}
  transmission ::Function
end

# Methods
function (𝚽::LTIsourceO)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   delay = distBetween(𝐩ₛ,𝛏₀)/lightSpeed
   return A(delay) * p(t₀-delay)
end

#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-INVARIANT BEAM CENTER

struct LTIsourceDTI
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Vector{Float64}
  antennaGain ::Function
end

function (𝚽::LTIsourceDTI)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p, = 𝚽.position, 𝚽.transmission
   𝐛, G = 𝚽.beamCenter , 𝚽.antennaGain
   delay = distBetween(𝐩ₛ,𝛏₀)/lightSpeed
   return A(delay) * p(t₀-delay) * G( angleBetween(𝐛, 𝛏₀-𝐩ₛ) )
end

#DEFINE STATIONARY SOURCE w/ DIRECTIONAL ANTENNA and TIME-VARYING BEAM CENTER

struct LTIsourceD
  position::Vector{Float64}
  transmission ::Function
  beamCenter::Function
  antennaGain ::Function
end

function (source::LTIsourceD)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p, = source.position, source.transmission
   𝐛, G = source.beamCenter , source.antennaGain
   delay = distBetween(𝐩ₛ,𝛏₀)/lightSpeed
   return A(delay) * p(t₀-delay) * G( angleBetween(𝐛(t₀-delay), 𝛏₀-𝐩ₛ) )
end

# DISPLAY
Base.show(io::IO, x::LTIsourceO) = print(io, "LTI Omnidirectional Source")
Base.show(io::IO, x::LTIsourceDTI) = print(io, "LTI Directional Source")
Base.show(io::IO, x::LTIsourceD) = print(io, "Stationary Direction Source with Time-Varying Beam Center")

LTISources = Union{LTIsourceO,
                   LTIsourceDTI,
                   LTIsourceD,
                   }

#multi-thread model evaluation over a 2D/3D space
function (q::LTISources)(𝛏::Array{Array{Float64,1}}, t₀::Float64)
   Q = zeros( typeof(q(𝛏[1], t₀)), size(𝛏))
   Threads.@threads for i =1:length(𝛏)
      Q[i] = q(𝛏[i], t₀)
   end
   return Q
end

#multi-thread model evaluation over a time interval
function (q::LTISources)(𝛏₀::Vector{Float64}, t::Vector{Float64})
   Q = zeros( typeof(q(𝛏₀, 0.0)), size(𝛏))
   Threads.@threads for i =1:length(t)
      Q[i] = q(𝛏₀, t[i])
   end
   return Q
end
