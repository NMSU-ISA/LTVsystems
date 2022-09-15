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
t = collect(-5.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"LTVreceiverDoppler_signalA.png")


#-----------------------------------example 2------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.0, 0.0] + [1.0, 0.0]*t
p(t) = cos(10.0π*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(-5.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"LTVreceiverDoppler_signalB.png")

#-----------------------------------example 3------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.0, 0.0] + [1.0, 0.0]*t
p(t) = exp(im*2π*1.0e9*t)
#p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(-5.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

#------------------------------------------
using LTVsystems, Plots
𝐩ₛ(t) = [1.0c, 1.0c] + [0.9c, 1.0]*t
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
𝐩ᵣ = [1.0, 2.0]
p(t) = exp(1im*2π*5*t)
q = LTVsourceO(𝐩ₛ,p)
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r,q],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(-3.0:0.001:3.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"LTVreceiverDoppler_signalC.png")
