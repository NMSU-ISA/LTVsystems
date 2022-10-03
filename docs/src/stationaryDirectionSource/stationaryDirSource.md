# Stationary Direction Source Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $\mathbf{b}_\mathrm{s}(t)$        | vector function of time|  time-varying source beam center   |
| $\Theta(t)$     | scalar function of time    | angle relative to time-varying beam center |
| $\mathrm{G}_\mathrm{s}(\Theta)$   | scalar function of angle  |  Gain of the source antenna |
| $\mathrm{G}_\mathrm{r}(\Theta)$   | scalar function of angle  |  Gain of the receiver antenna |
| $\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$   | scalar function of position |  directivity of source |
| $h\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $g(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}})$   |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/STAT_directionSource__model.png)


The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$h\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big) = \mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```math
\begin{aligned}
q(\bm{\xi},t)  &= p(t) \overset{t}{*} h\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big) \\
               &=\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
               \mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
               {\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).
\end{aligned}
```

The reflection due to source is given by

$r(\bm{\xi},t) = f(\bm{\xi}) q(\bm{\xi},t).$

The LTI impulse response from an arbitrary position $\bm{\xi}$ to the receiver at position $\mathbf{p}_\mathrm{r}$ is given by

$g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}}\big) = \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) \delta\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$

The signal observed at $\mathbf{p}_\mathrm{r}$ due to the reflection from the
position $\bm{\xi}$ is given by

```math
\begin{aligned}
\psi(\bm{\xi},t) &= r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}}\big) \\
                 &= \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).
\end{aligned}
```

## Scenario A

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver at same location as the source
* single stationary ideal point reflector
* the source emits an impulse


### Forward Modeling

For scenario A, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$ being at the same location $(𝐩ₛ=𝐩ᵣ)$, the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the directional source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $z(t)$
with $(𝐩ₛ=𝐩ᵣ)$ is given by

$z(t) = \alpha_0 \mathrm{D}_
\mathrm{s}\big(\bm{\xi}_0;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{r}(\cdot)}\big)\mathrm{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)p\left(t -2\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right).$

```julia
using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t-0.5e-09,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
t = -5.5e-9:1.0e-10:15.5e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_STATDirsignal.png)

### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}\left(\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)}\big)}
{\mathrm{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big) }
.$

```julia
using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t-0.5e-09,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(2norm(ξ-𝐩ₛ)/c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c))^2
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_STATDirsimulation.png)


## Scenario B

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver
* single stationary ideal point reflector
* the source emits an impulse


### Forward Modeling

For scenario B, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$, the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the directional source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $z(t)$
is given by

$z(t) = \alpha_0 \mathrm{D}_
\mathrm{s}\big(\bm{\xi}_0;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{s}(\cdot)}\big)\mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems, Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t-0.5e-09,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
t = -5.5e-9:1.0e-10:15.5e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_STATDirsignal.png)


### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) =\dfrac{z\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}\big)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}
.$

```julia
using LTVsystems, Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t-0.5e-09,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_STATDirsimulation.png)


## Scenario C

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver
* multiple stationary ideal point reflectors
* the source emits an impulse

For scenario C, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$, the transmitted signal $p(t)$, and multiple stationary reflectors say N.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

We compute the reflection due to the directional source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $z(t)$ is given by

$z(t) = \sum\limits_{n=1}^{N} \alpha_n  \mathrm{D}_\mathrm{s}\big(\bm{\xi}_n;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|+\|\bm{\xi}_n-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t-0.5e-09,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/3)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = -5.5e-9:1.0e-10:35.5e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_STATDirsignal.png)

### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) =\dfrac{z\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}\big)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}
.$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/3)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.6; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_STATDirsimulation.png)



## Scenario D

### Scenario Assumptions

* single stationary directional source with time-
  varying beam center
* single stationary receiver
* multiple stationary ideal point reflectors
* the source emits multiple impulse


For scenario D, we provided the position of the directional source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the directional receiver's position $𝐩ᵣ$, multiple stationary reflectors say N and the transmitted signal, $p(t)$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

We compute the reflections $r_i(\bm{\xi},t)$ where $i=1,2,…M$, due to the multiple impulses emitted by the directional source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{D}\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signals, $z(t)$ is given by

$z(t) = \sum\limits_{n=1}^{N} \alpha_n  \mathrm{D}\mathrm{s}\big(\bm{\xi}_n;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|+\|\bm{\xi}_n-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.1, 0.0]
𝐩ᵣ = [0.4, 0.2]
T  = 20.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
α₂ = 0.6; 𝛏₂ = [1.1,1.1]
α₃ = 0.5; 𝛏₃ = [2.0,-0.2]
ω = T/3
𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = 0.0:1.0e-10:55.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_STATDsignal1.png)

### Inverse Modeling

Given the scenario D assumptions, we obtained the received signals, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=∑_{k=0}^{M-1}δ(t-kT)$ where $kT=td$ is the delayed time as follows

${f}(\bm{\xi}) =\dfrac{z\left(td+\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)\mathrm{D}\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}\big)
\mathrm{D}\mathrm{r}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}
\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}} \right)}\big)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}
.$

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.1, 0.0]
𝐩ᵣ = [0.4, 0.2]
T  = 20.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
α₂ = 0.6; 𝛏₂ = [1.1,1.1]
α₃ = 0.5; 𝛏₃ = [2.0,-0.2]
ω = T/3
𝐛(t) = [cos(2π*ω*t), sin(2π*ω*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
zₜ = PulseTrainReceivers(z,T)
f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dᵣ(ξ).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_STATDsimulationnew.png)


## Scenario E

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver
* multiple stationary ideal point reflectors
* the source emits multiple impulses

Given the assumptions, we simulate the following geometry for scenario E.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_STATDir.png)

### Forward Modeling

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)+ δn(t-0.5e-9-3T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.0,0.0]
α₂ = 0.6; 𝛏₂ = [-1.0,0.0]
α₃ = 0.6; 𝛏₃ = [0.0,1.0]
α₄ = 0.5; 𝛏₄ = [0.0,-1.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t = -5.0e-9:1.0e-10:75.0e-9
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_STATDir_signal.png)


### Inverse Modeling

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-9
p(t) = δn(t-0.5e-9,1.0e-10) + δn(t-0.5e-9-T,1.0e-10) + δn(t-0.5e-9-2T,1.0e-10)+ δn(t-0.5e-9-3T,1.0e-10)
α₁ = 0.7; 𝛏₁ = [1.0,0.0]
α₂ = 0.6; 𝛏₂ = [-1.0,0.0]
α₃ = 0.6; 𝛏₃ = [0.0,1.0]
α₄ = 0.5; 𝛏₄ = [0.0,-1.0]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*t),sin(2π*f₀*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/4)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
function beam(t::Float64)
    return ifelse(0.0<t<T,𝐛(t) , ifelse(T<t<2T, 𝐛(T+t), ifelse(2T<t<3T, 𝐛(2T+t), 𝐛(3T+t))))
end
Dₛ(ξ::Vector{Float64}) = G(angleBetween(beam((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
zₜ = PulseTrainReceivers(z,T)
f(ξ::Vector{Float64}) = (zₜ((norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inverse2Dplot([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_STATDir_simulation.png)
