path = "docs/src/assets/"

#--------------------------------------example 1 LTV Receiver----------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = 𝐩ₛ + [0.8c, 0.0]*t
p(t) = exp(-t^2)
#p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
#t = collect(0.0:1.0e-10:25.5e-9)
t = collect(-2.0:0.001:2.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"LTVreceiverDoppler_signalA.png")


#-----------------------------------example 2------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.5c, 0.5c] + [0.8c, 0.0]*t
p(t) = 100cos(10.0π*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
#TEMPORAL SIMULATION
t = collect(-2.0:0.001:2.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"LTVreceiverDoppler_signalB.png")

#-----------------------------------example 3------------------------
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [0.5c, 0.5c] + [0.8c, 0.0]*t
p(t) = 100exp(1im*2π*10*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
t = collect(-2.0:0.001:2.0)
p1=plot(t,real.(p.(t)), xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,real.(z(t)), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"LTVreceiverDoppler_signalC.png")

p11=plot(t,p.(t), xlab="time (sec)", ylab="p(t)", legend=:false)
p12=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p11,p12,layout=(2,1))

png(path*"LTVreceiverDoppler_signalC1.png")

#---------------------------------------LTV Source example 1
using LTVsystems
using Plots
𝐩ₛ(t) = [0.1c, 0.1c] + [0.8c, 0.0]*t
𝐩ᵣ = [0.2c, 0.2c]
p(t) = exp(-t^2)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t = collect(-4.0:0.001:4.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"LTVsourceDoppler_signalA.png")

#----------------------------------example 2--------------------
using LTVsystems
using Plots
𝐩ₛ(t) = [0.1c, 0.1c] + [0.8c, 0.0]*t
𝐩ᵣ = [0.2c, 0.2c]
p(t) = 100cos(10.0π*t)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t = collect(-4.0:0.001:4.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"LTVsourceDoppler_signalB.png")

#----------------------------------example 3--------------------
using LTVsystems
using Plots
𝐩ₛ(t) = [0.1c, 0.1c] + [0.8c, 0.0]*t
𝐩ᵣ = [0.2c, 0.2c]
p(t) = 50exp(1im*2π*15*t)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t = collect(-4.0:0.001:4.0)
p1=plot(t,real.(p.(t)), xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,real.(z(t)), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))

png(path*"LTVsourceDoppler_signalC.png")

p11=plot(t,p.(t), xlab="time (sec)", ylab="p(t)", legend=:false)
p12=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p11,p12,layout=(2,1))

png(path*"LTVsourceDoppler_signalC1.png")
