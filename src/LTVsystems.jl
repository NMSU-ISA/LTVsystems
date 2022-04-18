module LTVsystems

using LinearAlgebra: norm, dot, normalize
include("omniDirectionalLTI/sources.jl")
export LTIsourceO, LTIsourceDTI, LTIsourceD, LTISources

include("omniDirectionalLTI/receivers.jl")
export LTIreceiverO, LTIreceiverDTI, LTIreceiverD, LTIReceivers

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, lightSpeed

end
