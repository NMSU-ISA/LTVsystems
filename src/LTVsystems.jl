module LTVsystems

using LinearAlgebra: norm, dot, normalize
export norm

using Plots
using Roots
using QuadGK

#using ISA
#export u, 𝒩ᵤ, 𝒩, δ, δn

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, c, TXₜ2RXₜ, RXₜ2TXₜ

include("other/types.jl")
export SourcesReflectors, Sources, Reflectors, Receivers

include("omniDirectionalLTI/sources.jl")
export LTIsourceO, LTISources

include("directionalLTI/sources.jl")
export LTIsourceDTI

include("stationaryDirection/sources.jl")
export STATsourceD

include("stationaryDirection/newsources.jl")
export NewSources

include("directionalLTI/receivers.jl")
export LTIreceiverDTI

include("stationaryDirection/receivers.jl")
export STATreceiverD

include("omniDirectionalLTI/reflectors.jl")
export pointReflector, lineSegment

include("omniDirectionalLTI/receivers.jl")
export LTIreceiverO,  LTIReceivers


include("omniDirectionalLTV/receivers.jl")
export LTVreceiverO

include("omniDirectionalLTV/sources.jl")
export LTVsourceO


include("other/threading.jl")

include("other/utilityFunctions.jl")
export u, 𝒩ᵤ, 𝒩, δ, δn

include("other/plots.jl")
export inverse2Dplot, scene2Dplot, inverse2Dfinalplot, scene2Ddirplot, scene2Dmultidirplot


end
