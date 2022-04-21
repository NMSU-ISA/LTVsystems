module LTVsystems

using LinearAlgebra: norm, dot, normalize

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
