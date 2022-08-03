# LTI Directional Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $\mathbf{b}_\mathrm{s}$               | vector|  source beam center   |
| $\mathbf{b}_\mathrm{r}$               | vector|  receiver beam center   |
| $\Theta$     | scalar           | angle relative to beam center |
| $\mathrm{G}_\mathrm{s}(\Theta)$   | scalar function of angle  |  Gain of the source antenna |
| $\mathrm{G}_\mathrm{r}(\Theta)$   | scalar function of angle  |  Gain of the receiver antenna |
| $\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$   | scalar function of position |  directivity of source |
| $h\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $\mathrm{D}_\mathrm{r}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathrm{G}_\mathrm{r}(\cdot)}\big)$   | scalar function of position |  directivity of receiver |
| $g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r},\mathrm{G}_\mathrm{r}(\cdot)}\big)$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |




![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model__directional.png)


The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}) = \mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```math
\begin{aligned}
q(\bm{\xi},t)  &= p(t) \overset{t}{*} h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}) \\
               &=\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}\right)
               \mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
               {\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).
\end{aligned}
```

The reflection due to source is given by

$r(\bm{\xi},t) = f(\bm{\xi}) q(\bm{\xi},t).$

The LTI impulse response from an arbitrary position $\bm{\xi}$ to the receiver at position $\mathbf{p}_\mathrm{r}$ is given by

$g(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}) = \mathrm{D}_\mathrm{r}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\right) \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) \delta\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$

The signal observed at $\mathbf{p}_\mathrm{r}$ due to the reflection from the
position $\bm{\xi}$ is given by

```math
\begin{aligned}
\psi(\bm{\xi},t) &= r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\big) \\
                 &= \mathrm{D}_\mathrm{r}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\right)
                 \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).
\end{aligned}
```


## Scenario A

### Scenario Assumptions

* single stationary directional source
* single stationary directional receiver at same location as the source
* single stationary ideal point reflector
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario A.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_LTIDir.png)


### Forward Modeling

For scenario A, we provided the position of the directional source $𝐩ₛ$, the directional receiver's position $𝐩ᵣ$, being at the same location $(𝐩ₛ=𝐩ᵣ)$, the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the directional source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $z(t)$
with $(𝐩ₛ=𝐩ᵣ)$ is given by

$z(t) = \alpha_0 \mathrm{D}^2_
\mathrm{r}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{r},
\mathbf{b}_\mathrm{r}}\right)\mathrm{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)p\left(t -2\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_LTIDirsignal.png)


### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)}
{\mathrm{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big)}
\mathrm{D}^2_\mathrm{r}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
D(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))
f(ξ::Vector{Float64}) = z(2(norm(ξ-𝐩ₛ))/c).*(D(ξ::Vector{Float64}))^2/
                        (A(norm(ξ-𝐩ₛ)/c))^2
inverse2Dplot([q],[r],[z],f)                        
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_DirTIsimulation.png)


## Scenario B

### Scenario Assumptions

* single stationary directional source
* single stationary directional receiver
* single stationary ideal point reflector
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario B.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_LTIDir.png)


### Forward Modeling

For scenario B, we provided the position of the directional source $𝐩ₛ$, the directional receiver's position $𝐩ᵣ$, the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the directional source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $z(t)$
is given by

$z(t) = \alpha_0 \mathrm{D}_\mathrm{r}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{r},
\mathbf{b}_\mathrm{r}}\right) \mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{s}}\right)
\mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)t = 0.0:1.0e-10:15.5e-9
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_LTIDirsignal.png)


### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}
\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}}\right)
\mathrm{D}_\mathrm{r}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)t = 0.0:1.0e-10:15.5e-9
Dᵣ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ᵣ))
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛, ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ::Vector{Float64}).*Dᵣ(ξ::Vector{Float64})/
                        A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_DirTIsimulation.png)
