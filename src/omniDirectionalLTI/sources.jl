"""
    q = LTIsourceO(ð©â, p)
    R = LTIsourceO(ð, r)

Create an LTI Omnidirectional Source by calling `LTIsourceO()` with
the *source position*, ð©â and the *transmisson signal*, `p`.

# Examples
```@example
using LTVsystems
ð©â =  [0.0, 0.0]
p(t) = Î´(t,1.0e-10)
q = LTIsourceO(ð©â, p)
```
Another type of sources, called as reflected sources can also be defined
by calling `LTIsourceO()` with *reflectors* position, ð and
the *reflected signal*, given by `r = Î± q(ð,t)`.

# Examples
```@example
using LTVsystems
ð©â =  [0.0, 0.0]
p(t) = Î´(t,1.0e-10)
q = LTIsourceO(ð©â, p)
Î±â = 0.7; ðâ = [1.8,0.0]
Râ = LTIsourceO(ðâ, t->Î±â*q(ðâ,t))
```
"""
struct LTIsourceO <: Sources
  position::Vector{Float64}
  transmission ::Function
end

# Methods
function (ð½::LTIsourceO)(ðâ::Vector{Float64}, tâ::Float64)
   ð©â, p = ð½.position, ð½.transmission
   delay = norm(ð©â-ðâ)/c
   return A(delay) * p(tâ-delay)
end




# DISPLAY
Base.show(io::IO, x::LTIsourceO) = print(io, "LTI Omnidirectional Source")
