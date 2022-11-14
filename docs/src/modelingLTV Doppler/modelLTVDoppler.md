# LTV Doppler Effect Modeling

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Doppler_LTV_BD.png)

The LTV impulse response from an omnidirectional source located at position $\mathbf{p}_\mathrm{s}(t)$ to an omnidirectional receiver located at position $\mathbf{p}_\mathrm{r}(t)$  is given by

$\mathsf{h}_\tau(t;\,{\mathbf{p}_\mathrm{s}(\cdot),\mathbf{p}_\mathrm{r}(\cdot)}) = \mathsf{A}(t_\mathrm{D}(\tau))\delta\big(t-\left[\tau + t_\mathrm{D}(\tau) \right]\big),$

where $t_\mathrm{D}$ is the time-delay given as

$t_\mathrm{D}(t) = \frac{\|\mathbf{p}_\mathrm{r}(t) - \mathbf{p}_\mathrm{s}(t) \|}{\mathrm{c}}$

In order to observe the Doppler effect, we assume that the receiver is moving (with respect to the source) such as

$\mathbf{p}_\mathrm{r}(t) = \mathbf{p}_\mathrm{s}(t) + \mathrm{s}\bm{v}t,$

where $\|\bm{v}\|=1.$

The observation of the source at the position $\mathbf{p}_\mathrm{r}(t)$ is given by




## Scenario A [Sinusoidal signal, moving transmitter and stationary receiver]

### Scenario Assumptions

  * single omnidirectional source moving with a constant speed
  * single stationary omnidirectional receiver
  * the source emits a sinusoidal signal

#### Doppler Modeling in Time Domain  

For scenario A, we provide the position of the moving source $\mathbf{p}_\mathrm{s}(t)$, the receiver's position $\mathbf{p}_\mathrm{r}.$

Consider the source emits a sinusoidal signal given by

$p(t) = \cos(\omega (t-t_\mathrm{p})),$

where $\omega$ is the frequency in radian per second.

we observe the signal at the position $\mathbf{p}_\mathrm{r}$ is given by

$z(t) = \mathsf{A}\left(\frac{\frac{s\|t\|}{\|1 \pm \mathrm{s}/\mathrm{c}\|}}{\mathrm{c}}\right)\mathsf{\cos}\left(\frac{\mathrm{c}\omega(t-t_\mathrm{p})}{\mathrm{c} \pm \mathrm{s} }\right).$


```julia
using LTVsystems
using Plots
s = 0.45c 
𝐯 = [1.0, 0.0]  
𝐩ₛ₀= [-15.0e-06c,0.0]
𝐩ₛ(t) = 𝐩ₛ₀ .+ s.*𝐯.*t
𝐩ᵣ = [2.0e-06c,1.5e-06c] 
f = 5e05
ω = 2π*f
tₚ = 1.0e-06
p(t) = 10cos(ω*(t-tₚ))
q = LTVsourceO(𝐩ₛ, p)
z = LTIreceiverO([q],𝐩ᵣ)
t=0.0:1.0e-08:100.0e-06
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
𝐩ₛ =  [-15.0e-06c,-1.5e-06c]  
s = 0.45c 
𝐯 = [-1.0, 0.0] 
tₚ = 1.0e-06 
𝐩ᵣ₀ = [5.0e-06c,0.0]
𝐩ᵣ(t) = 𝐩ᵣ₀ .+ s.*𝐯.*t
f = 5e05
p(t) = 10cos(2π*f*(t-tₚ))
q = LTIsourceO(𝐩ₛ, p)   
z = LTVreceiverO([q],𝐩ᵣ)  
t=0.0:1.0e-08:100.0e-06
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
s₁ = 0.50c  
𝐯₁ = [1.0, 0.0]  
s₂ = 0.25c  
𝐯₂ = [1.0, 0.0]  
tₚ = 1.0e-06
𝐩ₛ(t) = [-10.0e-06c,-1.5e-06c] .+ s₁.*𝐯₁.*t 
𝐩ᵣ(t) = [5.0e-06c,0.0] .+ s₂.*𝐯₂.*t 
f = 5e05
p(t) = cos(2π*f*(t-tₚ))
q = LTVsourceO(𝐩ₛ, p)
z = LTVreceiverO([q],𝐩ᵣ)
t=0.0:1.0e-08:100.0e-06
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Doppler_movingSRsignal.png)