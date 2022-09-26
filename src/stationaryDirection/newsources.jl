struct NewSources <: Receivers
  s::Function
 end

function (𝐒::NewSources)(t₀::Float64)
      𝐒.s(t₀)
end


#struct NewSources <: Receivers
#  zₚ::Function
#  timedelay::Float64
# end

#function (𝐒::NewSources)(t::Float64)
#      zₑ = 𝐒.zₚ
#      T = 𝐒.timedelay
#      temp(t) = ifelse(0.0<t<T,t->zₑ(t),ifelse(T<t<2T,t->zₑ(t+T),t->zₑ(t+2T)))
#      return temp
#end
