"""
    r = pointReflector(𝛏,α,q)
    r = pointReflector([𝛏₀,𝛏₁,𝛏₂],[α₀,α₁,α₂],[q])

Create an LTI Omnidirectional Reflection by calling `pointReflector()` with
a single *ideal point reflector*, ``\\bm{\\xi}``, *a reflection coefficient*, ``\\mathsf{\\alpha}`` and
the *source observation*, ``\\mathsf{q}``.

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
```
In case of multiple ideal point reflector, we create an LTI Omnidirectional Reflection by calling `pointReflector()` with
a vector of multiple *ideal point reflector*, ``\\bm{\\xi}_0,\\bm{\\xi}_1\\ldots,\\bm{\\xi}_n``, corresponding *reflection coefficients*, 
``\\mathsf{\\alpha}_0,\\mathsf{\\alpha}_1,\\ldots,\\mathsf{\\alpha}_n`` and a vector of *source observation*, ``\\mathsf{q}``.

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
```
"""
struct pointReflector <: Reflectors
        S::LTIsourceO
end

function pointReflector(𝛏::Vector{Float64},α₀::Float64,sourceList::SourcesReflectors)
    return pointReflector(LTIsourceO(𝛏, t->α₀*sourceList(𝛏,t)))
end

function pointReflector(𝛏::Vector{Float64},α₀::Float64,sourceList::Vector{<:SourcesReflectors})
    return pointReflector(LTIsourceO(𝛏, t->α₀*sourceList[1](𝛏,t)))
end

function pointReflector(𝛏::Vector{Vector{Float64}},α₀::Vector{Float64},sourceList::Vector{<:SourcesReflectors})
    return [pointReflector(LTIsourceO(𝛏[i], t->α₀[i]*sourceList[1](𝛏[i],t))) for i in 1:length(𝛏)]
end

function (R::pointReflector)(𝛏::Vector{Float64}, t::Float64)
    R.S(𝛏,t)
end



struct lineSegment <: Reflectors
        position::Vector{Float64}
        direction::Vector{Float64}
        length::Float64
        reflectionFunction::Function
        sourceList::Vector{<:SourcesReflectors}
end



function (R::lineSegment)(𝛏::Vector{Float64}, t::Float64)
    𝛏₀ = R.position
    𝐮 = R.direction/norm(R.direction)
    L = R.length
    α = R.reflectionFunction
    q = R.sourceList
    f(k) = α(k) * A( norm(𝛏-(𝛏₀+k*𝐮))/c ) * q[1](𝛏₀+k*𝐮 , t-norm(𝛏-(𝛏₀+k*𝐮))/c)
    return quadgk(f,0.0,L)[1]
end

# DISPLAY
Base.show(io::IO, x::pointReflector) = print(io, "Primary Reflection")