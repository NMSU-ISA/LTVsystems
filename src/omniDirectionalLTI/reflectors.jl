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
Base.show(io::IO, x::pointReflector) = print(io, "Ideal Point Reflectors")