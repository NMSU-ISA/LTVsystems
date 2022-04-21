struct stationaryPointReflectorO <: Reflectors
        S::LTIsourceO
end

function stationaryPointReflectorO(𝛏₀::Vector{Float64},α₀::Float64,sourceList::Vector{<:Sources})
    return stationaryPointReflectorO(LTIsourceO(𝛏₀, t->α₀*sourceList[1](𝛏₀,t)))
end

function stationaryPointReflectorO(𝛏₀::Vector{Vector{Float64}},α₀::Vector{Float64},sourceList::Vector{<:Sources})
    return [stationaryPointReflectorO(LTIsourceO(𝛏₀[i], t->α₀[i]*sourceList[1](𝛏₀[i],t))) for i in 1:length(𝛏₀)]
end

function (R::stationaryPointReflectorO)(𝛏₀::Vector{Float64}, t₀::Float64)
    R.S(𝛏₀,t₀)
end
