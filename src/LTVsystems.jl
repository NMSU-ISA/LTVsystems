module LTVsystems

using LinearAlgebra: norm, dot, normalize
export norm

using Plots

using QuadGK

#using ISA
#export u, 𝒩ᵤ, 𝒩, δ, δn

include("other/types.jl")
export SourcesReflectors, Sources, Reflectors, Receivers

include("omniDirectionalLTI/sources.jl")
export LTIsourceO, LTISources

include("directionalLTI/dirSources.jl")
export LTIsourceDTI, LTIsourceD

include("directionalLTI/dirReceivers.jl")
export LTIreceiverDTI, LTIreceiverD

include("omniDirectionalLTI/reflectors.jl")
export pointReflector, lineSegment

include("omniDirectionalLTI/receivers.jl")
export LTIreceiverO,  LTIReceivers

include("other/threading.jl")

include("other/utilityFunctions.jl")
export u, 𝒩ᵤ, 𝒩, δ, δn

include("other/plots.jl")
export inverse2Dplot, scene2Dplot, inverse2Dfinalplot

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, c

end
