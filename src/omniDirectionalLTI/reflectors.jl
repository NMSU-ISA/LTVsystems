struct pointReflector <: Reflectors
        S::LTIsourceO
end

function pointReflector(𝛏::Vector{Float64},α₀::Float64,sourceList::Vector{<:Sources})
    return pointReflector(LTIsourceO(𝛏, t->α₀*sourceList[1](𝛏,t)))
end

function pointReflector(𝛏::Vector{Vector{Float64}},α₀::Vector{Float64},sourceList::Vector{<:Sources})
    return [pointReflector(LTIsourceO(𝛏[i], t->α₀[i]*sourceList[1](𝛏[i],t))) for i in 1:length(𝛏)]
end

function (R::pointReflector)(𝛏::Vector{Float64}, t::Float64)
    R.S(𝛏,t)
end




struct lineSegment <: Reflectors
        position::Vector{Float64}
        direction::Vector{Float64}
        length::Float64
end

function lineSegment(𝛏₀::Vector{Float64},𝛏₁::Vector{Float64})
    𝐮L = 𝛏₁-𝛏₀
    L = norm(𝐮L)
    𝐮 = 𝐮L./L
    return lineSegment(𝛏₀,𝐮,L)
end

#function (R::lineSegment)(𝛏::Vector{Float64}, t::Float64)
#    f() =
#    return quadgk( f() ,0.0,R.length)
#end
