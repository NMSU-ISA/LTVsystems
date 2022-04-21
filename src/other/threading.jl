#multi-thread model evaluation over a 2D/3D space
function (q::Sources)(𝛏::Array{Array{Float64,1}}, t₀::Float64)
   Q = zeros( typeof(q(𝛏[1], t₀)), size(𝛏))
   Threads.@threads for i =1:length(𝛏)
      Q[i] = q(𝛏[i], t₀)
   end
   return Q
end

#multi-thread model evaluation over a time interval
function (q::Sources)(𝛏₀::Vector{Float64}, t::Vector{Float64})
   Q = zeros( typeof(q(𝛏₀, 0.0)), size(𝛏))
   Threads.@threads for i =1:length(t)
      Q[i] = q(𝛏₀, t[i])
   end
   return Q
end
