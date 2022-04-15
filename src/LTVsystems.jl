module LTVsystems

using LinearAlgebra: norm, dot, normalize
include("omniDirectionalLTI/sources.jl")
export LTIsourcesO, LTIsourcesDTI, LTIsourcesD, LTISources

include("omniDirectionalLTI/receivers.jl")
export LTIreceiversO, LTIreceiversDTI, LTIreceiversD, LTIReceivers

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, lightSpeed

end
