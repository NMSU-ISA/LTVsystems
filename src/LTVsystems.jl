module LTVsystems

using LinearAlgebra: norm, dot, normalize
include("omniDirectionalLTI/sources.jl")
export omnidirectionalLTISource

include("omniDirectionalLTI/receivers.jl")
export omnidirectionalLTIListener

include("auxiliaryFunctions/auxiliaryFunction.jl")
export A, NaNnormalize, angleBetween, distBetween, lightSpeed

end
