# LTV Doppler Effect Modeling

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Doppler_LTV_BD.png)

The LTV impulse response from an omnidirectional source located at position $\mathbf{p}_\mathrm{s}(t)$ to an omnidirectional receiver located at position $\mathbf{p}_\mathrm{r}(t)$  is given by

$\mathsf{h}_\tau(t;\,{\mathbf{p}_\mathrm{s}(\cdot),\mathbf{p}_\mathrm{r}(\cdot)}) = \mathsf{A}(t_\mathrm{D}(\tau))\delta\big(t-\left[\tau + t_\mathrm{D}(\tau) \right]\big),$

where $t_\mathrm{D}$ is the time-delay given as

$t_\mathrm{D}(t) = \frac{\|\mathbf{p}_\mathrm{r}(t) - \mathbf{p}_\mathrm{s}(t) \|}{\mathrm{c}}$

The observation of the source at the position $\mathbf{p}_\mathrm{r}(t)$ is given by

$z(t) = \mathsf{A}\left(\frac{\frac{s\|t\|}{\|1 \pm \mathrm{s}/\mathrm{c}\|}}{\mathrm{c}}\right)\mathsf{p}\left(\frac{t}{1 \pm \mathrm{s}/\mathrm{c} }\right).$


## Scenario A [Sinusoidal signal, moving transmitter and stationary receiver]

### Scenario Assumptions

  * single omnidirectional source moving with a constant speed
  * single stationary omnidirectional receiver
  * the source emits a sinusoidal signal



```julia
using LTVsystems
using Plots
s = 0.025c
𝐯 = [1.0, 0.0]  
tₚ = 1.0e-06
𝐩ₛ(t) = [0.18e-06c,0.0] .+ s.*𝐯.*t
𝐩ᵣ = [5.25e-06c,0.0]
f = 5e05
p(t) = 10cos(2π*f*(t-tₚ))
q = LTVsourceO(𝐩ₛ, p)
z = LTIreceiverO([q],𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Doppler_movingSstatR_signal.png)


## Scenario B [Sinusoidal signal, stationary transmitter and moving receiver]

### Scenario Assumptions

  * single stationary omnidirectional source
  * single omnidirectional receiver moving with a constant speed
  * the source emits a sinusoidal signal

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.15e-06c,0.0]  
s = 0.25c 
𝐯 = [1.0, 0.0] 
tₚ = 1.0e-06 
𝐩ᵣ(t) = 𝐩ₛ .+ s.*𝐯.*t
f = 5e05
p(t) = 10cos(2π*f*(t-tₚ))
q = LTIsourceO(𝐩ₛ, p)   
z = LTVreceiverO([q],𝐩ᵣ)  
t=0.0e-06:1.0e-07:25.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Doppler_statSmovingRsignal.png)


## Scenario C [Sinusoidal signal, transmitter and receiver moving towards each other with a constant speed]

### Scenario Assumptions

  * single omnidirectional source moving with a constant speed
  * single omnidirectional receiver moving with a constant speed
  * the source emits a sinusoidal signal

```julia
using LTVsystems
using Plots
s₁ = 0.35c 
𝐯₁ = [1.0, 0.0]  
s₂ = 0.25c 
𝐯₂ = [-1.0, 0.0]  
tₚ = 1.0e-06
𝐩ₛ(t) = [5.0e-06c,0.0] .+ s₁.*𝐯₁.*t 
𝐩ᵣ(t) = [100.0e-06c,0.0] .+ s₂.*𝐯₂.*t 
f = 0.25e06
p(t) = cos(2π*f*(t-tₚ))
q = LTVsourceO(𝐩ₛ, p)
z = LTVreceiverO([q],𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Doppler_movingSRsignal.png)