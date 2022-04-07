module LTVsystems

using LinearAlgebra: norm, dot, normalize
include("omniDirectionalLTI/sources.jl")
export LTIsourcesO

include("omniDirectionalLTI/receivers.jl")
export LTIreceiversO

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, lightSpeed

end