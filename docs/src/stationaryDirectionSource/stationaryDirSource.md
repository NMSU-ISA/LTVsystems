# Stationary Direction Source Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $\mathbf{b}_\mathrm{s}(t)$        | vector function of time|  time-varying source beam center   |
| $\mathbf{b}_\mathrm{r}(t)$        | vector function of time|  time-varying receiver beam center   |
| $\Theta(t)$     | scalar function of time    | angle relative to time-varying beam center |
| $\mathrm{G}_\mathrm{s}(\Theta)$   | scalar function of angle  |  Gain of the source antenna |
| $\mathrm{G}_\mathrm{r}(\Theta)$   | scalar function of angle  |  Gain of the receiver antenna |
| $\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)$   | scalar function of position |  directivity of source |
| $\mathrm{D}_\mathrm{r}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}(\cdot)}\big)$   | scalar function of position |  directivity of receiver |
| $\mathsf{h}\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $\mathsf{g}(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}(\cdot)})$   |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/Stationary_Directional_Model_BD.png)


The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$\mathsf{h}\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big) = \mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```math
\begin{aligned}
\mathsf{q}(\bm{\xi},t)  &= \mathsf{p}(t) \overset{t}{*} \mathsf{h}\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big) \\
               &=\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
               \mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
               {\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).
\end{aligned}
```

The reflection due to source is given by

$\mathsf{r}(\bm{\xi},t) = \mathsf{f}(\bm{\xi}) \mathsf{q}(\bm{\xi},t).$

The LTI impulse response from an arbitrary position $\bm{\xi}$ to the receiver at position $\mathbf{p}_\mathrm{r}$ is given by

$\mathsf{g}\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}}\big) = \mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) \delta\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$

The signal observed at $\mathbf{p}_\mathrm{r}$ due to the reflection from the
position $\bm{\xi}$ is given by

```math
\begin{aligned}
\mathsf{\psi}(\bm{\xi},t) &= \mathsf{r}(\bm{\xi},t) \overset{t}{*} \mathsf{g}\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}}\big) \\
                 &= \mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) \mathsf{r}\left(\bm{\xi},t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).
\end{aligned}
```

## Scenario A [Single pulse, single reflector, transmitter and receiver at same location]

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver at same location as the source
* single stationary ideal point reflector
* the source emits a pulse


### Forward Modeling

For scenario A, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$ being at the same location $(𝐩ₛ=𝐩ᵣ)$, the transmitted signal $\mathsf{p}(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the directional source as follows

$\mathsf{r}(\bm{\xi},t) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$ with $(𝐩ₛ=𝐩ᵣ)$ is given by

$\mathsf{z}(t) = \mathsf{\alpha}_0 \mathrm{D}_
\mathrm{s}\big(\bm{\xi}_0;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{s}(\cdot)}\big)\mathsf{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)\mathsf{p}\left(t -2\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06 
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_STATDirsignal.png)

### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $\mathsf{z}(t)$. Now we can estimate the reflector function by considering the transmitted signal as follows 

$\mathsf{p}(t)=δ(t-\mathrm{t_p})$ 

$\hat{\mathsf{f}}(\bm{\xi}) = \dfrac{\mathsf{z}\left(\mathrm{t_p}+\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\mathrm{t_p})}\right)}
{\mathsf{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big) }.$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06 
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ.+2(norm(ξ-𝐩ₛ))/c).*Dₛ(ξ))/
                        (A(norm(ξ-𝐩ₛ)/c))^2
inversePlot2D([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_STATDirsimulation.png)


## Scenario B [Single pulse, single reflector, transmitter and receiver at different location]

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver
* single stationary ideal point reflector
* the source emits a pulse


### Forward Modeling

For scenario B, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$, the transmitted signal $\mathsf{p}(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the directional source as follows

$\mathsf{r}(\bm{\xi},t) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$ is given by

$\mathsf{z}(t) = \mathsf{\alpha}_0 \mathrm{D}_
\mathrm{s}\big(\bm{\xi}_0;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{s}(\cdot)}\big)\mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathsf{A}\left(\frac{\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) \mathsf{p}\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06 
𝐩ₛ =  [0.1c*T, 0.0]
𝐩ᵣ =  [-0.1c*T, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_STATDirsignal.png)


### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $\mathsf{z}(t)$. Now we can estimate the reflector function by considering the transmitted signal as follows 

$\mathsf{p}(t)=δ(t-\mathrm{t_p})$ 

$\hat{\mathsf{f}}(\bm{\xi}) =\dfrac{\mathsf{z}\left(\mathrm{t_p}+\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\mathrm{t_p})}\right)}{\mathsf{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathsf{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}
.$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06 
𝐩ₛ =  [0.1c*T, 0.0]
𝐩ᵣ =  [-0.1c*T, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
𝐛(t) = [cos(2π*10*(t-tₚ)),0.0]/(norm(cos(2π*10*(t-tₚ))))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
α₀ = -0.7; 𝛏₀ = [0.2c*T,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
Dₛ(ξ::Vector{Float64}) = G(angleBetween(𝐛(tₚ), ξ.-𝐩ₛ))
f(ξ::Vector{Float64}) = (z(tₚ.+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dₛ(ξ))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))
inversePlot2D([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_STATDirsimulation.png)



## Scenario C [Pulse train, multiple reflector, transmitter and receiver at same location]

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver at same location as the source
* multiple stationary ideal point reflectors at different radial distances
* the source emits a periodic impulse train


### Forward Modeling

For scenario C, we provided the position of the stationary direction source $𝐩ₛ$, with time-varying beam center $𝐛(t)$, the stationary direction receiver's position $𝐩ᵣ$, being at the same location $(𝐩ₛ=𝐩ᵣ)$, the transmitted signal $\mathsf{p}(t)$, and multiple reflector say, N.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \sum\limits_{n=1}^{N}\mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n).$

We compute the reflection due to the directional source as follows

$\mathsf{r}(\bm{\xi},t) = \sum\limits_{n=1}^{N}\mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\big)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$ is given by

$\mathsf{z}(t) = \sum\limits_{n=1}^{N} \mathsf{\alpha}_n \mathrm{D}_\mathrm{s}\big(\bm{\xi}_n;\,{\mathbf{p}_\mathrm{s},
\mathbf{b}_\mathrm{r}(\cdot)}\big)\mathsf{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{s}-\bm{\xi}_n\|}
{\mathrm{c}}\right)\mathsf{p}\left(t -2\frac{\|\mathbf{p}_\mathrm{s}-\bm{\xi}_n\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 
D = 4 
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.0,0.10c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.0]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.0]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [0.0,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_STATDirsignal.png)


### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $\mathsf{z}(t)$. Now we can estimate the reflector function by considering the transmitted signal as a pulse train as follows

$\mathsf{p}(t)=∑_{k=1}^{M}δ(t-\mathrm{t_p}-(k-1)\mathrm{T})$ as follows

In order to consider the transmitted time of the time-varying beam with respect to each periodic pulse, we computed the reflector function as follows

$\mathsf{f}_k(\bm{\xi})=\dfrac{\mathsf{z}\left(\mathrm{t_p}+(k-1)\mathrm{T}+\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)\mathrm{D}_\mathrm{sk}(\bm{\xi})}{\mathsf{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)}$

where $\mathrm{D}_\mathrm{sk}(\bm{\xi}) = \mathbf{G}\big(∠(𝐛(\mathrm{t_p}+(k-1)\mathrm{T}), \bm{\xi}.-\mathbf{p}_\mathrm{s})\big)$ 

Finally, the reflector function for the scenario is given as follows

$\hat{\mathsf{f}}(\bm{\xi}) = ∑_{k=1}^{M} \mathsf{f}_k(\bm{\xi}).$

```julia 
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 
D = 4 
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.0,0.10c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.0]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.0]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [0.0,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)
Dₛₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T), ξ.-𝐩ₛ))
fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T+(2norm(ξ-𝐩ₛ))./c).*Dₛₖ(ξ,k)./(A(norm(ξ-𝐩ₛ)/c))^2)) 
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_STATDir_simulation.png)




## Scenario D (More General Case) [Pulse train, multiple reflector, transmitter and receiver at same location]

### Scenario Assumptions

* single stationary directional source with time-varying beam center
* single stationary receiver at same location as the source
* multiple stationary ideal point reflectors
* the source emits a periodic impulse train

### Forward Modeling

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 
D = 30 
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.18c*T,0.12c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.22c*T]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.18c*T]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [-0.10c*T,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_STATDirsignal.png)


### Inverse Modeling

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
tₚ = 1.0e-06 
T  = 15.0e-6 
D = 30 
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.21c*T,0.0]
α₂ = -0.7; 𝛏₂ = [0.18c*T,0.12c*T] 
α₃ = -0.7; 𝛏₃ = [-0.22c*T,0.22c*T]
α₄ = -0.7; 𝛏₄ = [0.0,-0.15c*T]  
α₅ = -0.7; 𝛏₅ = [0.18c*T,0.18c*T]
α₆ = -0.7; 𝛏₆ = [0.0,0.13c*T]
α₇ = -0.7; 𝛏₇ = [-0.10c*T,-0.12c*T]
α₈ = -0.7; 𝛏₈ = [-0.25c*T,0.0]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/64)
q = STATsourceD(𝐩ₛ,p,𝐛,G)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄,𝛏₅,𝛏₆,𝛏₇,𝛏₈],[α₁,α₂,α₃,α₄,α₅,α₆,α₇,α₈],[q])
z = LTIreceiverO(r,𝐩ᵣ)
Dₛₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T), ξ.-𝐩ₛ))
fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T+(2norm(ξ-𝐩ₛ))./c).*Dₛₖ(ξ,k)./(A(norm(ξ-𝐩ₛ)/c))^2)) 
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_STATDsimulation.png)


## Scenario E [Pulse train, multiple reflector, transmitter and receiver at different location]

### Scenario Assumptions

* single stationary source 
* single stationary directional receiver with time-varying beam center
* multiple stationary ideal point reflectors
* the source emits a periodic impulse train

### Forward Modeling

```julia
using LTVsystems
using Plots
T  = 15.0e-6 
𝐩ₛ = [0.01c*T, 0.0]
𝐩ᵣ = [-0.06c*T, 0.0]
tₚ = 1.0e-06 
D = 32
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.2c*T,0.10c*T]
α₂ = -0.7; 𝛏₂ = [-0.15c*T,0.08c*T]
α₃ = -0.7; 𝛏₃ = [-0.11c*T,0.2c*T]
α₄ = -0.7; 𝛏₄ = [-0.05c*T,-0.12c*T]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/2D)
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
t=0.0:T/500:D*T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t),ylims=(minimum(z(t)),maximum(z(t))), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioESTAT_signal.png)


### Inverse Modeling

```julia
using LTVsystems
using Plots
T  = 15.0e-6 
𝐩ₛ = [0.01c*T, 0.0]
𝐩ᵣ = [-0.06c*T, 0.0]
tₚ = 1.0e-06 
D = 32
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.2c*T,0.10c*T]
α₂ = -0.7; 𝛏₂ = [-0.15c*T,0.08c*T]
α₃ = -0.7; 𝛏₃ = [-0.11c*T,0.2c*T]
α₄ = -0.7; 𝛏₄ = [-0.05c*T,-0.12c*T]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/2D)
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
Dᵣₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T.+(norm(ξ-𝐩ₛ).- norm(𝐩ᵣ.-ξ))./c), 𝐩ᵣ.-ξ))

fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T.+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dᵣₖ(ξ,k))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioESTAT_simulation.png)

Alternate inverse modeling

```julia
using LTVsystems
using Plots
T  = 15.0e-6 
𝐩ₛ = [0.01c*T, 0.0]
𝐩ᵣ = [-0.06c*T, 0.0]
tₚ = 1.0e-06 
D = 32
p(t) = δn(mod(t-tₚ,T),1.0e-07)
α₁ = -0.7; 𝛏₁ = [0.2c*T,0.10c*T]
α₂ = -0.7; 𝛏₂ = [-0.15c*T,0.08c*T]
α₃ = -0.7; 𝛏₃ = [-0.11c*T,0.2c*T]
α₄ = -0.7; 𝛏₄ = [-0.05c*T,-0.12c*T]
f₀ = 1/(D*T) 
𝐛(t) = [cos(2π*f₀*(t-tₚ)),sin(2π*f₀*(t-tₚ))]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/2D)
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector([𝛏₁,𝛏₂,𝛏₃,𝛏₄],[α₁,α₂,α₃,α₄],[q])
z = STATreceiverD(r,𝐩ᵣ,𝐛,G)
Dᵣₖ(ξ::Vector{Float64},k::Int64) = G(angleBetween(𝐛(tₚ+(k-1)*T.+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ.-ξ))./c), 𝐩ᵣ.-ξ))

fₖ(ξ::Vector{Float64},k::Int64) = ifelse(norm(ξ)>c*T/2, NaN, (z(tₚ+(k-1)*T.+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c).*Dᵣₖ(ξ,k))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
g(ξ::Vector{Float64}) = sum(fₖ(ξ,k) for k ∈ 1:D)
inversePlot2D([q],r,[z],g)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioESTAT_simulation2.png)