"""
    z = LTVreceiverO()




"""
struct  LTVreceiverO <: Receivers
   sourceList::Vector{SourcesReflectors}
   position::Function
end

function (ψ::LTVreceiverO)(t₀::Float64)
sourceList = ψ.sourceList
𝐩ᵣ = ψ.position
   val = 0.0
  for i = 1:length(sourceList)
      val+=sourceList[i](𝐩ᵣ(t₀),t₀)
   end
   return val
end



# DISPLAY
Base.show(io::IO, x::LTVreceiverO) = print(io, "LTV Omnidirectional Receiver")
