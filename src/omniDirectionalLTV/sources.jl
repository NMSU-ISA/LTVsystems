"""
    q = 
  

"""
struct LTVsourceO <: Sources
  position::Function
  transmission ::Function
end

# Methods
function (𝚽::LTVsourceO)(𝛏₀::Vector{Float64}, t₀::Float64)
   𝐩ₛ, p = 𝚽.position, 𝚽.transmission
   tₜₓ = RXₜ2TXₜ(t₀,𝛏₀,𝐩ₛ) 
   return A(norm(𝛏₀-𝐩ₛ(tₜₓ))/c) * p(tₜₓ)
end


# DISPLAY
Base.show(io::IO, x::LTVsourceO) = print(io, "LTV Omnidirectional Source")
