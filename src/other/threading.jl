#multi-thread model evaluation over a 2D/3D space
function (q::Sources)(ğ::Array{Array{Float64,1}}, tâ::Float64)
   Q = zeros( typeof(q(ğ[1], tâ)), size(ğ))
   Threads.@threads for i =1:length(ğ)
      Q[i] = q(ğ[i], tâ)
   end
   return Q
end

#multi-thread model evaluation over a time interval
function (q::Sources)(ğâ::Vector{Float64}, t::Vector{Float64})
   Q = zeros( typeof(q(ğâ, 0.0)), size(ğ))
   Threads.@threads for i =1:length(t)
      Q[i] = q(ğâ, t[i])
   end
   return Q
end
