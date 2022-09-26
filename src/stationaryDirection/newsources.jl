struct NewSources <: Receivers
  s::Receivers
  timedelay ::Float64
 end

 function (𝐒::NewSources)(t₀::Float64)
   T=𝐒.timedelay
  return ifelse(0.0<t₀<T, 𝐒.s(t₀), ifelse(T<t₀<2T, 𝐒.s(t₀+T), 𝐒.s(t₀+2T)))

end



struct PulseTrainReceivers <: Receivers
  s::Receivers
  Period ::Float64
 end

 function (𝐒::PulseTrainReceivers)(t₀::Float64)
   T=𝐒.Period
   k = floor(t₀/T)
  return 𝐒.s(t₀.+k*T)
end
