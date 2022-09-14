path = "docs/src/assets/"

using LTVsystems
using Plots
𝐩ₛ(t) = [0.0, 0.0] + [1.0, 0.0]*t
𝐩ᵣ = [1.0, 2.0]
p(t) = exp(-t.^2)
#p(t) = exp(im*2π*1.0e09*t)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r,q],𝐩ᵣ)
#zn = LTIreceiverO([r],𝐩ᵣ)
#zq = LTIreceiverO([q],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(0.0:0.01:5.0)
plot!(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
#plot!( t, zn(t), xlab="time (sec)", ylab="z(t)", legend=:false)
#plot!( t, zq(t), xlab="time (sec)", ylab="z(t)", legend=:false)

#--------------------------------------example 1----------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.0, 0.0] + [1.0, 0.0]*t
p(t) = exp(-t^2)
#p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(0.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"LTVreceiverDoppler_signalA.png")
#-----------------------------------example 2------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.0, 0.0] + [1.0, 0.0]*t
p(t) = exp(im*2π*2.0e9*t)
#p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(0.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


#-----------------------------------example 2------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.0, 0.0] + [1.0, 0.0]*t
p(t) = cos(2π*10.0*t)
#p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(0.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
