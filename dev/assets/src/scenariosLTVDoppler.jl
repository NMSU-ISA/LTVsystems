path = "docs/src/assets/"

#-------------------------------------------------------------------


#-----------------------------------example 2------------------------
using LTVsystems
using Plots
𝐩ₛ =  [-15.0e-06c,-1.5e-06c]  
s = 0.45c 
𝐯 = [-1.0, 0.0] 
tₚ = 1.0e-06 
𝐩ᵣ₀ = [5.0e-06c,0.0]
𝐩ᵣ(t) = 𝐩ᵣ₀ .+ s.*𝐯.*t
f = 5e05
p(t) = 10cos(2π*f*(t-tₚ))
q = LTIsourceO(𝐩ₛ, p)   # stationary source
z = LTVreceiverO([q],𝐩ᵣ)  # moving receiver
#TEMPORAL SIMULATION
t=0.0:1.0e-08:100.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))


plot(t,A.(t))

png(path*"Doppler_statSmovingRsignal.png")


#----------------------------------example 2--------------------
using LTVsystems
using Plots
s = 0.45c 
𝐯 = [1.0, 0.0]  #direction 
𝐩ₛ₀= [-15.0e-06c,0.0]
𝐩ₛ(t) = 𝐩ₛ₀ .+ s.*𝐯.*t
𝐩ᵣ = [2.0e-06c,1.5e-06c] 
f = 5e05
ω = 2π*f
tₚ = 1.0e-06
p(t) = 10cos(ω*(t-tₚ))
q = LTVsourceO(𝐩ₛ, p)
#α₀ = -0.7; 𝛏₀ = [2.5e-06c,0.0]
#r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([q],𝐩ᵣ)
t=0.0:1.0e-08:100.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))

png(path*"Doppler_movingSstatR_signal.png")

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


#----------Emitter and Receiver moving towards each other------
using LTVsystems
using Plots
s₁ = 0.50c  # 3m/s
𝐯₁ = [1.0, 0.0]  #direction 
s₂ = 0.25c  # 6m/s
𝐯₂ = [1.0, 0.0]  #direction
tₚ = 1.0e-06
𝐩ₛ(t) = [-10.0e-06c,-1.5e-06c] .+ s₁.*𝐯₁.*t 
#𝐩ᵣ(t) = 𝐩ₛ(t) .+ s₂.*𝐯₂.*t 
𝐩ᵣ(t) = [5.0e-06c,0.0] .+ s₂.*𝐯₂.*t 
#𝐩ᵣ(t) = 𝐩ₛ(t).+ [50.0e-08c,0.0] .+ s₂.*𝐯₂.*t 
f = 5e05
p(t) = cos(2π*f*(t-tₚ))
q = LTVsourceO(𝐩ₛ, p)
z = LTVreceiverO([q],𝐩ᵣ)
t=0.0:1.0e-08:100.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))

#plot(t,A.(t)) #----Instantaneous Amplitude plot

t=0.0:1.0e-08:25.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,A.(t), xlab="time (sec)", ylab="A(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))



png(path*"Doppler_movingSRsignal.png")





