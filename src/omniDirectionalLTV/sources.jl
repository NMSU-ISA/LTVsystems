"""
    q = 
  

"""
struct LTVsourceO <: Sources
  position::Function
  transmission ::Function
end

# Methods
function (𝚽::LTVsourceO)(𝛏₀::Vector{Float64}, τ::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   t₀ = TXₜ2RXₜ(τ,𝛏₀,𝐩ₛ(τ))
   return A(t₀) * p(t₀)
end


# DISPLAY
Base.show(io::IO, x::LTVsourceO) = print(io, "LTI Omnidirectional Source")
