struct pointReflector <: Reflectors
        S::LTIsourceO
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
    f(k) = R.reflectionFunction(k) * A( norm(𝛏-(R.position+k*R.direction))/c ) * R.sourceList[1](R.position+k*R.direction , t-norm(𝛏-(R.position+k*R.direction))/c)
    return quadgk( f,0.0,R.length)[1]
end
