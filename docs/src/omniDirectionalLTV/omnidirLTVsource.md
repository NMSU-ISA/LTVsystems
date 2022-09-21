# LTV Omnidirectional Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $t$                     | scalar variable |  time   |
| $\bm{\xi}$              | vector variable |  position   |
| $\mathbf{p}_\mathrm{s}(t)$     | vector function of time    | position of source |
| $\mathbf{p}_\mathrm{r}(t)$     | vector function of time    | position of receiver |
| $h_τ\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}(\cdot)}\big)$  |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}(t)$ to  $\bm{\xi}$ |
| $g_τ\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}(\cdot)}\big)$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}(t)$ |

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTV_BD_omnimodel.png)


## Scenario A

### Scenario Assumptions

  * single omnidirectional source moving with a constant speed
  * single omnidirectional receiver at same location as the source moving with a  
    constant speed
  * single stationary ideal point reflector
  * the source emits an impulse


### Forward Modeling

```julia
using LTVsystems
using Plots
𝐩ₛ(t) = [0.5c, 0.0]*t
𝐩ᵣ(t) = 𝐩ₛ(t)
p(t) = δn(t,0.05)
q = LTVsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [0.5c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTVreceiverO([r],𝐩ᵣ)
t = collect(-2.0:0.001:2.0)
p1=plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2=plot(t,z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioALTV_signal.png)
