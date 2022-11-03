# LTI Omnidirectional Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $t$                     | scalar variable |  time   |
| $\bm{\xi}$              | vector variable |  position   |
| $\mathbf{p}_\mathrm{s}$     | vector                  | position of source |
| $\mathbf{p}_\mathrm{r}$     | vector                  | position of receiver |
| $\mathsf{p}(t)$                  | scalar function of time |  source emission   |
| $\mathsf{f}(\bm{\xi})$           | scalar function of position |  reflectivity function   |
| $\mathsf{h}(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}})$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $\mathsf{q}(\bm{\xi},t)$  |  scalar function of position and time  | observation of source emission at $\bm{\xi}$ |
| $\mathsf{r}(\bm{\xi},t)$  |  scalar function of position and time  | reflection from $\bm{\xi}$ due to source|
| $\mathsf{g}(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}})$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |
| $\mathsf{\psi}(\bm{\xi},t)$ |  scalar function of position and time  | observation of reflections from $\bm{\xi}$ at $\mathbf{p}_\mathrm{r}$ |
| $\mathsf{z}(t)$                | scalar function of time |   observation of reflections at $\mathbf{p}_\mathrm{r}$   |




![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model.png)



The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$\mathsf{h}(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}}) = \mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\mathbf{p}_\mathrm{s}$ is given as

```math
\begin{aligned}
\mathsf{q}(\bm{\xi},t)  &= \mathsf{p}(t) \overset{t}{*} \mathsf{h}(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}}) \\
               &= \mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
               {\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).
\end{aligned}
```

The reflection due to source is given by

$\mathsf{r}(\bm{\xi},t) = \mathsf{f}(\bm{\xi}) \mathsf{q}(\bm{\xi},t).$

The LTI impulse response from an arbitrary position $\bm{\xi}$ to the receiver at position $\mathbf{p}_\mathrm{r}$ is given by

$\mathsf{g}(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}}) = \mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) \delta\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$

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

  * single stationary omnidirectional source
  * single stationary omnidirectional receiver at same location as the source
  * single stationary ideal point reflector
  * the source emits a pulse

Given the assumptions, we simulate the following geometry for scenario A.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA.png)

### Forward Modeling

For scenario A, we provided the position of the source $𝐩ₛ$, the receiver's position $𝐩ᵣ$, being at the same location $(𝐩ₛ=𝐩ᵣ)$, the transmitted signal
$\mathsf{p}(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the source as follows

$\mathsf{r}(\bm{\xi},t) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$
with $(𝐩ₛ=𝐩ᵣ)$ is given by

$\mathsf{z}(t) = \mathsf{\alpha}_0 \mathsf{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)\mathsf{p}\left(t -2\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right).$

```julia
using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_signal.png)

### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $\mathsf{z}(t)$. 
Now by considering the transmitted singal as 

$\mathsf{p}(t)=δ(t-t_\mathrm{p}),$

we can estimate the reflector function as follows

$\hat{\mathsf{f}}(\bm{\xi}) = \dfrac{\mathsf{z}\left(t_\mathrm{p}+\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)}
{\mathsf{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems, Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
f(ξ::Vector{Float64}) = z(tₚ.+ 2(norm(ξ-𝐩ₛ))/c)/(A(norm(ξ-𝐩ₛ)/c))^2
inversePlot2D([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_simulation.png)


## Scenario B [Single pulse, single reflector, transmitter and receiver at different location]

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* single stationary ideal point reflector
* the source emits a pulse

Given the assumptions, we simulate the following geometry for scenario B.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB.png)

### Forward Modeling

For scenario B, we provided the position of the source $𝐩ₛ$, the receiver's position $𝐩ᵣ$, the transmitted signal $\mathsf{p}(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the source as follows

$\mathsf{r}(\bm{\xi},t) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$ is given by

$\mathsf{z}(t) = \mathsf{\alpha}_0 \mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathsf{A}\left(\frac{\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) \mathsf{p}\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ =  [0.75e-06c, 0.0]
𝐩ᵣ =  [-3.0e-06c, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_signal.png)

### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $\mathsf{z}(t)$. Now by considering the transmitted singal as 

$\mathsf{p}(t)=δ(t-t_\mathrm{p}),$

we can estimate the reflector function as follows

$\hat{\mathsf{f}}(\bm{\xi}) = \dfrac{\mathsf{z}\left(t_\mathrm{p}+\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathsf{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathsf{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ =  [0.75e-06c, 0.0]
𝐩ᵣ =  [-3.0e-06c, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
f(ξ::Vector{Float64})=(z(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))
inversePlot2D([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_simulation.png)


## Scenario C [Single pulse, multiple reflector, transmitter and receiver at different location]

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* multiple stationary ideal point reflectors
* the source emits a pulse

Given the assumptions, we simulate the following geometry for scenario C.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC.png)

### Forward Modeling

For scenario C, we provided the position of the source $𝐩ₛ$, the receiver's position $𝐩ᵣ$, the transmitted signal $\mathsf{p}(t)$, and multiple stationary reflectors say N.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \sum\limits_{n=1}^{N}\mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n).$

We compute the reflection due to the source as follows

$\mathsf{r}(\bm{\xi},t) = \sum\limits_{n=1}^{N}\mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$ is given by

$\mathsf{z}(t) = \sum\limits_{n=1}^{N} \mathsf{\alpha}_n \mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathsf{A}\left(\frac{\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)
\mathsf{p}\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|+\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ =  [0.3e-06c, 0.0]
𝐩ᵣ =  [-3.0e-06c, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₁ = -0.7; 𝛏₁ = [3.3e-06c,0.0]
α₂ = -0.4; 𝛏₂ = [1.2e-06c,0.375e-06c]
α₃ = -0.5; 𝛏₃ = [1.5e-06c,-1.5e-06c]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_signal.png)

### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $\mathsf{z}(t)$. Now by considering the transmitted singal as 

$\mathsf{p}(t)=δ(t-t_\mathrm{p}),$

we can estimate the reflector function as follows

$\hat{\mathsf{f}}(\bm{\xi}) = \dfrac{\mathsf{z}\left(t_\mathrm{p}+\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)}
{\mathsf{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathsf{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ =  [0.3e-06c, 0.0]
𝐩ᵣ =  [-3.0e-06c, 0.0]
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₁ = -0.7; 𝛏₁ = [3.3e-06c,0.0]
α₂ = -0.4; 𝛏₂ = [1.2e-06c,0.375e-06c]
α₃ = -0.5; 𝛏₃ = [1.5e-06c,-1.5e-06c]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
f(ξ::Vector{Float64})=(z(tₚ+(norm(ξ-𝐩ₛ) .+norm(𝐩ᵣ-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c))
inversePlot2D([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_simulation.png)

## Scenario D [Single pulse, multiple reflector, single transmitter and multiple receiver]

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* multiple stationary ideal point reflectors
* the source emits a pulse

Given the assumptions, we simulate the following geometry for scenario D.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD.png)

### Forward Modeling

For scenario D, we provided the position of the source $𝐩ₛ$ and the multiple receivers's position at $\mathbf{p}_{\mathrm{r}^{(i)}}$ where $i = 1,2,\ldots,M$, the transmitted signal, $\mathsf{p}(t)$ and multiple stationary reflectors $\bm{\xi}_n$ where $n = 1,2,…,N$ and $M ≥N$.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \sum\limits_{n=1}^{N}\mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n).$


We compute the reflection due to the source as follows

$\mathsf{r}(\bm{\xi},t) = \sum\limits_{n=1}^{N}\mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signals, $\mathsf{z}_i(t)$ where $i = 1,2,…M$ is given by

$\mathsf{z}_i(t) = \sum\limits_{n=1}^{N} \mathsf{\alpha}_n \mathsf{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathsf{A}\left(\frac{\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)
\mathsf{p}\left(t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|+\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.45e-06c, 0.0]
𝐩ᵣ₂ =  [0.0, 0.45e-06c]
𝐩ᵣ₃ =  [0.45e-06c, 0.0]
𝐩ᵣ₄ =  [0.0, -0.45e-06c]
𝐩ᵣ₅ =  [0.0, 0.0]
p(t) = δn(t-tₚ,1.5e-07)
q = LTIsourceO(𝐩ₛ, p)
α₁ = -0.7; 𝛏₁ = [1.2e-06c,1.05e-06c]
α₂ = -0.5; 𝛏₂ = [2.4e-06c,0.0]
α₃ = -0.4; 𝛏₃ = [3.3e-06c,1.5e-06c]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z₁ = LTIreceiverO(r,𝐩ᵣ₁)
z₂ = LTIreceiverO(r,𝐩ᵣ₂)
z₃ = LTIreceiverO(r,𝐩ᵣ₃)
z₄ = LTIreceiverO(r,𝐩ᵣ₄)
z₅ = LTIreceiverO(r,𝐩ᵣ₅)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p2,t,z₂(t))
plot!(p2,t,z₃(t))
plot!(p2,t,z₄(t))
plot!(p2,t,z₅(t))
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_signal.png)

### Inverse Modeling

Given the scenario D assumptions, we obtained the received signals, $\mathsf{z}_i(t)$ where $i=1,2,…,M$. Now by considering the transmitted singal as 

$\mathsf{p}(t)=δ(t-t_\mathrm{p}),$

we can estimate the reflector function as follows

$\hat{\mathsf{f}}(\bm{\xi}) = \left(\prod\limits_{i=1}^{M}\mathsf{f}_i(\bm{\xi})\right)^{\frac{1}{M}},$ where

$\mathsf{f}_i(\bm{\xi}) = \dfrac{\mathsf{z}_i\left(t_\mathrm{p}+\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}- \bm{\xi}\|+\|\bm{\xi}
-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}{\mathsf{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)
\mathsf{A}\big(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.45e-06c, 0.0]
𝐩ᵣ₂ =  [0.0, 0.45e-06c]
𝐩ᵣ₃ =  [0.45e-06c, 0.0]
𝐩ᵣ₄ =  [0.0, -0.45e-06c]
𝐩ᵣ₅ =  [0.0, 0.0]
p(t) = δn(t-tₚ,1.5e-07)
q = LTIsourceO(𝐩ₛ, p)
α₁ = -0.7; 𝛏₁ = [1.2e-06c,1.05e-06c]
α₂ = -0.5; 𝛏₂ = [2.4e-06c,0.0]
α₃ = -0.4; 𝛏₃ = [3.3e-06c,1.5e-06c]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z₁ = LTIreceiverO(r,𝐩ᵣ₁)
z₂ = LTIreceiverO(r,𝐩ᵣ₂)
z₃ = LTIreceiverO(r,𝐩ᵣ₃)
z₄ = LTIreceiverO(r,𝐩ᵣ₄)
z₅ = LTIreceiverO(r,𝐩ᵣ₅)
f₁(ξ::Vector{Float64})=(z₁(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₁-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₁-ξ)./c))
f₂(ξ::Vector{Float64})=(z₂(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₂-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₂-ξ)./c))
f₃(ξ::Vector{Float64})=(z₃(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₃-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₃-ξ)./c))
f₄(ξ::Vector{Float64})=(z₄(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₄-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₄-ξ)./c))
f₅(ξ::Vector{Float64})=(z₅(tₚ+(norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₅-ξ))./c))./(A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ₅-ξ)./c))
f(ξ::Vector{Float64})=(f₁(ξ).*f₂(ξ).*f₃(ξ).*f₄(ξ).*f₅(ξ))^1/5
p11 = inversePlot2D([q],r,[z₁,z₂,z₃,z₄,z₅],f₁)
p12 = inversePlot2D([q],r,[z₁,z₂,z₃,z₄,z₅],f₂)
p13 = inversePlot2D([q],r,[z₁,z₂,z₃,z₄,z₅],f₃)
p14 = inversePlot2D([q],r,[z₁,z₂,z₃,z₄,z₅],f₄)
p15 = inversePlot2D([q],r,[z₁,z₂,z₃,z₄,z₅],f₅)
p6 = inversefinalPlot2D([q],[z₁,z₂,z₃,z₄,z₅],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation1.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation2.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation3.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation4.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation5.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation.png)



## Scenario E [Single pulse, single reflector, multiple transmitter and receiver at different locations]

### Scenario Assumptions

* multiple stationary omnidirectional sources
* multiple stationary omnidirectional receivers
* a stationary ideal point reflector
* the source emits a pulse

Given the assumptions, we simulate the following geometry for scenario E.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE.png)

### Forward Modeling

For scenario E, we provided the positions of multiple sources at $\mathbf{p}_{\mathrm{s}^{(i)}}$
where $i = 1,2,…N$, the multiple receivers at $\mathbf{p}_{\mathrm{r}^{(i)}}$ where $i = 1,2,…N$, the transmitted signal $\mathsf{p}(t)$, and a stationary reflector.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0).$


We compute the reflection due to the sources as follows

$\mathsf{r}_i(\bm{\xi},t) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathsf{A}\left(\frac{\|\bm{\xi}-\bm{p}_{\mathrm{s}^{(i)}}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\bm{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\right)$

where $i = 1,2,…N$,


Finally, the closed form expression of the observed signals, $\mathsf{z}_i(t)$ where $i = 1,2,…M$ is given by

$\mathsf{z}_i(t) = \mathsf{\alpha}_0 \mathsf{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathsf{A}\left(\frac{\|\bm{\xi}_0-\mathbf{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\right)
\mathsf{p}\left(t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_0\|+\|\bm{\xi}_0-\mathbf{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ₁ =  [-0.75e-06c, 0.0]
𝐩ᵣ₁ =  [-0.15e-06c, 0.0]
𝐩ₛ₂ =  [0.75e-06c, 0.0]
𝐩ᵣ₂ =  [1.5e-06c, 0.0]
𝐩ₛ₃ =  [2.1e-06c, 0.0]
𝐩ᵣ₃ =  [2.85e-06c, 0.0]
p(t) = δn(t-tₚ,1.5e-07)
q₁ = LTIsourceO(𝐩ₛ₁, p)
q₂ = LTIsourceO(𝐩ₛ₂, p)
q₃ = LTIsourceO(𝐩ₛ₃, p)
α₁ = -0.7; 𝛏₁ = [3.6e-06c,3.6e-06c]
r₁ = pointReflector(𝛏₁,α₁,[q₁])
r₂ = pointReflector(𝛏₁,α₁,[q₂])
r₃ = pointReflector(𝛏₁,α₁,[q₃])
z₁ = LTIreceiverO([r₁],𝐩ᵣ₁)
z₂ = LTIreceiverO([r₂],𝐩ᵣ₂)
z₃ = LTIreceiverO([r₃],𝐩ᵣ₃)
t=0.0:1.0e-08:25.0e-06
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p2,t,z₂(t))
plot!(p2,t,z₃(t))
plot(p1,p2,layout=(2,1),size=(800,800))
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_signal.png)

### Inverse Modeling
Given the scenario E assumptions, we obtained the received signals, $\mathsf{z}_i(t)$ where $i=1,2,…M$. Now by considering the transmitted singal as 

$\mathsf{p}(t)=δ(t-t_\mathrm{p}),$

we can estimate the reflector function as follows

$\hat{\mathsf{f}}(\bm{\xi}) = \left(\prod\limits_{i=1}^{N}\mathsf{f}_i(\bm{\xi})\right),$ where

$\mathsf{f}_i(\bm{\xi}) = \dfrac{\mathsf{z}_i\left(t_\mathrm{p}+\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}- \bm{\xi}\|+\|\bm{\xi}
-\bm{p}_{\mathrm{s}^{(i)}}\|}
{\mathrm{c}}\right)}{\mathsf{A}\big(\frac{\|\bm{\xi}-\bm{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\big)
\mathsf{A}\big(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
using Plots
tₚ = 1.0e-06
𝐩ₛ₁ =  [-0.75e-06c, 0.0]
𝐩ᵣ₁ =  [-0.15e-06c, 0.0]
𝐩ₛ₂ =  [0.75e-06c, 0.0]
𝐩ᵣ₂ =  [1.5e-06c, 0.0]
𝐩ₛ₃ =  [2.1e-06c, 0.0]
𝐩ᵣ₃ =  [2.85e-06c, 0.0]
p(t) = δn(t-tₚ,1.5e-07)
q₁ = LTIsourceO(𝐩ₛ₁, p)
q₂ = LTIsourceO(𝐩ₛ₂, p)
q₃ = LTIsourceO(𝐩ₛ₃, p)
α₁ = -0.7; 𝛏₁ = [3.6e-06c,3.6e-06c]
r₁ = pointReflector(𝛏₁,α₁,[q₁])
r₂ = pointReflector(𝛏₁,α₁,[q₂])
r₃ = pointReflector(𝛏₁,α₁,[q₃])
z₁ = LTIreceiverO([r₁],𝐩ᵣ₁)
z₂ = LTIreceiverO([r₂],𝐩ᵣ₂)
z₃ = LTIreceiverO([r₃],𝐩ᵣ₃)
f₁(ξ::Vector{Float64})=(z₁(tₚ+(norm(ξ-𝐩ₛ₁) .+ norm(𝐩ᵣ₁-ξ))./c))./(A(norm(ξ-𝐩ₛ₁)./c).*A(norm(𝐩ᵣ₁-ξ)./c))
f₂(ξ::Vector{Float64})=(z₂(tₚ+(norm(ξ-𝐩ₛ₂) .+ norm(𝐩ᵣ₂-ξ))./c))./(A(norm(ξ-𝐩ₛ₂)./c).*A(norm(𝐩ᵣ₂-ξ)./c))
f₃(ξ::Vector{Float64})=(z₃(tₚ+(norm(ξ-𝐩ₛ₃) .+ norm(𝐩ᵣ₃-ξ))./c))./(A(norm(ξ-𝐩ₛ₃)./c).*A(norm(𝐩ᵣ₃-ξ)./c))
f(ξ::Vector{Float64})=f₁(ξ).+f₂(ξ).+f₃(ξ)
inversePlot2D([q₁,q₂,q₃],[r₁,r₂,r₃],[z₁,z₂,z₃],f)
f_new(ξ::Vector{Float64})=f₁(ξ).*f₂(ξ).*f₃(ξ)
inversefinalPlot2D([q₁,q₂,q₃],[z₁,z₂,z₃],f_new)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_simulation.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_target_estimation.png)




## Scenario F [Pulse train, single reflector, transmitter and receiver at same location, random noise]

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver at the same location as source
* single ideal point reflector
* the source emits a pulse train with period T
* random noise presence

Given the assumptions, we simulate the following geometry for scenario F.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioG.png)

### Forward Modeling

For scenario F, we provided the position of the source $𝐩ₛ$, the receiver's position $𝐩ᵣ$, the transmitted signal $\mathsf{p}(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$\mathsf{f}(\bm{\xi}) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the source as follows

$\mathsf{r}(\bm{\xi},t) = \mathsf{\alpha}_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathsf{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \mathsf{p}\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $\mathsf{z}(t)$ is given by

$\mathsf{z}(t) = \mathsf{\alpha}_0 \mathsf{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathsf{A}\left(\frac{\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) \mathsf{p}\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-6
tₚ = 1.0e-06
p(t) = δn(mod(t-tₚ,T),1.0e-7)
α₁ = -0.7; 𝛏₁ = [3.0e-06c,0.0]
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector(𝛏₁,α₁,q)
z = LTIreceiverO([r],𝐩ᵣ)
t=0.0:T/100:5T
p1 = plot(t,p, xlab="time (sec)", ylab="p(t)", legend=:false)
p2 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot(p1,p2,layout=(2,1),size=(800,800))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioG_signal.png)


### Inverse Modeling

Given the scenario F assumptions, we obtained the received signal, $\mathsf{z}(t)$. Now by considering the transmitted singal as 

$\mathsf{p}(t)=δ(\mathrm{mod}(t-t_\mathrm{p},T)),$

we computed the reflector function, $\mathsf{f}_k$ with respect to each pulse's transmission time, $kT$ where $k \in \mathbf{Z}$ in the presence of random white noise as follows


$\mathsf{f}_k(\bm{\xi})=\dfrac{\mathsf{z}\left(t_\mathrm{p}+kT+\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}{\mathsf{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathsf{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

Finally, the reflector function is given as follows

$\hat{\mathsf{f}}(\bm{\xi}) = \frac{∑_{k=0}^{M-1} \mathsf{f}_k(\bm{\xi})}{M}.$


```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-6
tₚ = 1.0e-06
p(t) = δn(mod(t-tₚ,T),1.0e-7)
α₁ = -0.7; 𝛏₁ = [3.0e-06c,0.0]
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector(𝛏₁,α₁,q)
z = LTIreceiverO([r],𝐩ᵣ)
f₁(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (0.5e-05randn(1)[1]+z(tₚ+0*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f₂(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (0.5e-05randn(1)[1]+z(tₚ+1*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))          
f₃(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (0.5e-05randn(1)[1]+z(tₚ+2*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f₄(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (0.5e-05randn(1)[1]+z(tₚ+3*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f₅(ξ::Vector{Float64}) = ifelse(norm(ξ)>c*T/2, NaN, (0.5e-05randn(1)[1]+z(tₚ+4*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)))
f(ξ::Vector{Float64}) = (f₁(ξ).+f₂(ξ).+f₃(ξ).+f₄(ξ).+f₅(ξ))/5
p11=inversePlot2D([q],[r],[z],f₁)
p12=inversePlot2D([q],[r],[z],f₂)
p13=inversePlot2D([q],[r],[z],f₃)
p14=inversePlot2D([q],[r],[z],f₄)
p15=inversePlot2D([q],[r],[z],f₅)
p6=inversePlot2D([q],[r],[z],f)
plot(p11,p12,p13,p14,p15,p6,layout=(3,2),size=(1000,1000))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioG_simulation.png)


By transmitting more number of pulses, we can average out the white noise presence in the model and can get better target estimation. Here we provide the result of target estimation with $50$ pulses i.e $M=50$.

```julia
using LTVsystems
using Plots
𝐩ₛ = [0.0, 0.0]
𝐩ᵣ = [0.0, 0.0]
T  = 15.0e-6
tₚ = 1.0e-06
p(t) = δn(mod(t-tₚ,T),1.0e-7)
α₁ = 0.7; 𝛏₁ = [0.2c*T,0.0]
q = LTIsourceO(𝐩ₛ,p)
r = pointReflector(𝛏₁,α₁,q)
z = LTIreceiverO([r],𝐩ᵣ)
M=50
fm(ξ::Vector{Float64}) = [ifelse(norm(ξ)>c*T/2, NaN, (0.5e-05randn(1)[1]
+z(tₚ+(k-1)*T+(norm(ξ-𝐩ₛ).+ norm(𝐩ᵣ-ξ))./c))/(A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c))) for k∈1:M]
g(ξ::Vector{Float64}) = sum(fm(ξ)[i] for i ∈ 1:M )/M
inversePlot2D([q],[r],[z],g)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioG_simulation2.png)
