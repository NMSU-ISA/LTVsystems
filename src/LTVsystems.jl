module LTVsystems

using LinearAlgebra: norm, dot, normalize
export norm

using Plots

using ISA
export u, 𝒩ᵤ, 𝒩, δ, δn

include("other/types.jl")
export SourcesReflectors, Sources, Reflectors, Receivers

include("omniDirectionalLTI/sources.jl")
export LTIsourceO, LTIsourceDTI, LTIsourceD, LTISources

include("omniDirectionalLTI/reflectors.jl")
export stationaryPointReflectorO

include("omniDirectionalLTI/receivers.jl")
export LTIreceiverO, LTIreceiverDTI, LTIreceiverD, LTIReceivers

include("other/threading.jl")

include("other/plots.jl")
export inverse2D

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, lightSpeed

end
