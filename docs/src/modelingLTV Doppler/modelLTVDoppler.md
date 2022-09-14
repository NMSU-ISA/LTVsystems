### LTV Doppler Effect Modeling

In order to observe the Doppler effect, we consider a time-varying receiver at
position $\mathbf{p}_\mathrm{r}(t)$,
a source at position $\mathbf{p}_\mathrm{s}$ and a reflector at an arbitrary position $\bm{\xi}$.

The LTI impulse response from $\mathbf{p}_\mathrm{s}(t)$ to  $\bm{\xi}$ is given by

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
𝐩ᵣ(t) = [0.0, 0.0] + [1.0, 0.0]*t
p(t) = exp(-t^2)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r,q],𝐩ᵣ)
t = collect(0.0:0.01:5.0)
plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTVreceiverDoppler_signalA.png)
