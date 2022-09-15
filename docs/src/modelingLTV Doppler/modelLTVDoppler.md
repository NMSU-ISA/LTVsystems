### LTV Doppler Effect Modeling

In order to observe the Doppler effect, we consider a time-varying receiver at
position $\mathbf{p}_\mathrm{r}(t)$,
a source at position $\mathbf{p}_\mathrm{s}$ and a reflector at an arbitrary position $\bm{\xi}$.

The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}}) = \mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


## Scenario A

### Scenario Assumptions

  * single stationary omnidirectional source
  * single omnidirectional receiver moving with a constant speed
  * single stationary ideal point reflector
  * the source emits a real exponential signal

Given the assumptions, we observed the final signal that accounts the Doppler effect
inherently in term of time-scale and shift.

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [1.0c, 0.0] + [1.0c, 0.0]*t
p(t) = exp(-t^2)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
t = collect(-2.0:0.001:2.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTVreceiverDoppler_signalA.png)

## Scenario B

### Scenario Assumptions

  * single stationary omnidirectional source
  * single omnidirectional receiver moving with a constant speed
  * single stationary ideal point reflector
  * the source emits a sinusoidal signal

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [1.0c, 1.0c] + [1.0c, 0.0]*t
p(t) = 100cos(10.0π*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
t = collect(-2.0:0.001:2.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTVreceiverDoppler_signalB.png)

## Scenario C

### Scenario Assumptions

  * single moving omnidirectional source
  * single stationary omnidirectional receiver
  * single stationary ideal point reflector
  * the source emits a complex exponential signal

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ(t) = [1.0c, 1.0c] + [1.0c, 0.0]*t
p(t) = 100exp(1im*2π*5*t)
#p(t) = exp(im*2π*1.0e09*t)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
t = collect(-2.0:0.001:2.0)
p1=plot(t,real.(p.(t)), xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,real.(z(t)), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
p11=plot(t,p.(t), xlab="time (sec)", ylab="p(t)", legend=:false)
p12=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p11,p12,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTVreceiverDoppler_signalC.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTVreceiverDoppler_signalC1.png)
