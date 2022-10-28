# Stationary Direction Source Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $\mathbf{b}_\mathrm{s}(t)$        | vector function of time|  time-varying source beam center   |
| $\mathbf{b}_\mathrm{r}(t)$        | vector function of time|  time-varying receiver beam center   |
| $\Theta(t)$     | scalar function of time    | angle relative to time-varying beam center |
| $\mathrm{G}_\mathrm{s}(\Theta)$   | scalar function of angle  |  Gain of the source antenna |
| $\mathrm{G}_\mathrm{r}(\Theta)$   | scalar function of angle  |  Gain of the receiver antenna |
| $\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$   | scalar function of position |  directivity of source |
| $h\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $g(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}})$   |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Stationary_Directional_Model_BD.png)


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

## Scenario A [Single pulse, single reflector, transmitter and receiver at same location]

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
tₚ = 1.0e-06 
T  = 15.0e-6
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
t=0.0:T/100:2T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_STATDirsignal.png)

### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t-t_p)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(t_p+\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}\big(\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big)}\right)}
{\mathrm{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big) }
.$

```julia
using LTVsystems, Plots
tₚ = 1.0e-06 
T  = 15.0e-6
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(2norm(ξ-𝐩ₛ)/c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ.+2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ))/
(A(norm(ξ-𝐩ₛ)/c))^2
inversePlot2D([q],[r],[z],f,T)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_STATDirsimulation.png)


## Scenario B [Single pulse, single reflector, transmitter and receiver at different location]

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
tₚ = 1.0e-06 
T  = 15.0e-6
𝐩ₛ =  [0.1c*T, 0.0]
𝐩ᵣ =  [-0.1c*T, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
t=0.0:T/100:2T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_STATDirsignal.png)


### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t-t_p)$ as follows

$\hat{f}(\bm{\xi}) =\dfrac{z\left(t_p+\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}\big(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\big)}\right)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}
.$

```julia
using LTVsystems, Plots
tₚ = 1.0e-06 
T  = 15.0e-6
𝐩ₛ =  [0.1c*T, 0.0]
𝐩ᵣ =  [-0.1c*T, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = 0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ.+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inversePlot2D([q],[r],[z],f,T)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_STATDirsimulation.png)



## Scenario C [Pulse train, multiple reflector, transmitter and receiver at same location]

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver at same location as the source
* multiple stationary ideal point reflectors
* the source emits a periodic impulse train

Given the assumptions, we simulate the following geometry for scenario C.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_STATDir.png)

### Forward Modeling

For scenario C, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$, being at the same location $(𝐩ₛ=𝐩ᵣ)$, the transmitted signal $p(t)$, and multiple reflector say, N.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

We compute the reflection due to the directional source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $z(t)$
is given by

$z(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{D}_
\mathrm{s}\big(\bm{\xi}_n;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{r}(\cdot)}\big)\mathrm{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{s}-\bm{\xi}_n\|}
{\mathrm{c}}\right)p\left(t -2\frac{\|\mathbf{p}_\mathrm{s}-\bm{\xi}_n\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6
p(t) = δn(t-tₚ,1.0e-07) + δn(t-T-tₚ,1.0e-07) + δn(t-2T-tₚ,1.0e-07)+ δn(t-3T-tₚ,1.0e-07)
α₁ = 0.7; 𝛏₁ = [0.2c*T,0.0]
α₂ = 0.7; 𝛏₂ = [-0.2c*T,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,0.2c*T]
α₄ = 0.7; 𝛏₄ = [0.0,-0.2c*T]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/12)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/100:4T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioESTAT_signal.png)


### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal as impulse train $p(t)=∑_{k=1}^{M}δ(t-t_p-(k-1)T)$ as follows


In order to consider the transmitted time of the time-varying beam with respect to each periodic impulse, we computed the reflector function corresponding to each periodic impulse as follows

$f_k(\bm{\xi})=\dfrac{z\left(t_p+(k-1)T+\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)\mathrm{D}_\mathrm{sk}(\bm{\xi})}{\mathrm{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)}$

where $\mathrm{D}_\mathrm{sk}(\bm{\xi}) = \mathbf{G}\big(∠(𝐛(t_p-(k-1)T), \bm{\xi}.-\mathbf{p}_\mathrm{s})\big)$ 

Finally, the reflector function for the scenario is given as follows

$\hat{f}(\bm{\xi}) = ∑_{k=1}^{M} f_k(\bm{\xi}).$

```julia 
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6
p(t) = δn(t-tₚ,1.0e-07) + δn(t-T-tₚ,1.0e-07) + δn(t-2T-tₚ,1.0e-07)+ δn(t-3T-tₚ,1.0e-07)
α₁ = 0.7; 𝛏₁ = [0.2c*T,0.0]
α₂ = 0.7; 𝛏₂ = [-0.2c*T,0.0]
α₃ = 0.7; 𝛏₃ = [0.0,0.2c*T]
α₄ = 0.7; 𝛏₄ = [0.0,-0.2c*T]
f₀ = 1/4T
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/12)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
Dₛ₁(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f₁(ξ::Vector{Float64}) = (z(tₚ+2(norm(ξ-𝐩ₛ))/c).*Dₛ₁(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₂(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-T), ξ.-𝐩ₛ))
f₂(ξ::Vector{Float64}) = (z(tₚ.+T+2(norm(ξ-𝐩ₛ))/c).*Dₛ₂(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₃(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-2T), ξ.-𝐩ₛ))
f₃(ξ::Vector{Float64}) = (z(tₚ.+2T+2(norm(ξ-𝐩ₛ))/c).*Dₛ₃(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
Dₛ₄(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ-3T), ξ.-𝐩ₛ))
f₄(ξ::Vector{Float64}) = (z(tₚ.+3T+2(norm(ξ-𝐩ₛ))/c).*Dₛ₄(ξ))/(A(norm(ξ-𝐩ₛ)/c))^2
f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)
p11 = inversePlot2D([q],r,[z],f₁,T)
p12 = inversePlot2D([q],r,[z],f₂,T)
p13 = inversePlot2D([q],r,[z],f₃,T)
p14 = inversePlot2D([q],r,[z],f₄,T)
plot(p11,p12,p13,p14,layout=(2,2),size=(1000,1000))
f(ξ::Vector{Float64}) = f₁(ξ).+ f₂(ξ) .+f₃(ξ).+f₄(ξ)
inversePlot2D([q],r,[z],f,T)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioESTAT_simulationall.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioESTAT_simulation.png)


## Scenario D (More General Case) [Pulse train, multiple reflector, transmitter and receiver at same location]

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver at same location as the source
* multiple stationary ideal point reflectors
* the source emits a periodic impulse train

Given the assumptions, we simulate the following geometry for scenario D.


