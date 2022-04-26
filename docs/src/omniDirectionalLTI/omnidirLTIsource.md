# LTI Omnidirectional Modeling

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model.png)

## Scenario A

### Scenario Assumptions

  * single stationary omnidirectional source
  * single stationary omnidirectional receiver at same location as the source
  * single stationary ideal point reflector
  * the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario A.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA.png)

### Forward Modeling

For scenario A, given the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$ being at the same location $(𝐩ₛ=𝐩ᵣ)$, by providing the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$, the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given as

$q(\bm{\xi},t) = p(t) \overset{t}{*} h(\bm{\xi},t;\,{\bm{p}_\mathrm{s}}) ,$

$q(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Mathematically, we define the reflection due to the source as

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Now the signal observed at $\bm{p}_\mathrm{r}$ due to the reflection from the
position $\bm{\xi}$ is given by

$\psi(\bm{\xi},t) = r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\bm{p}_\mathrm{r}(\cdot)}\big) ,$

$\psi(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $z(t)$
with $(𝐩ₛ=𝐩ᵣ)$ is given by

$z(t) = \alpha_0 \mathrm{A}^2
\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)p\left(t -2\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_signal.png)

### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{2\|\bm{\xi}-\bm{p}_\mathrm{r}\|}{\mathrm{c}}\right)}
{\mathrm{A}^2(\frac{\|\bm{\xi}-\bm{p}_\mathrm{r}\|}{\mathrm{c}})}.$

```julia
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
f(ξ::Vector{Float64}) = (z(2(norm(ξ-𝐩ₛ))/c))/
                        (A(norm(ξ-𝐩ₛ)/c))^2
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_simulation.png)


## Scenario B

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* single stationary ideal point reflector
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario B.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB.png)

### Forward Modeling

For scenario B, given the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$, by providing the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$, the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given by

$q(\bm{\xi},t) = p(t) \overset{t}{*} h(\bm{\xi},t;\,{\bm{p}_\mathrm{s}}) ,$

$q(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Mathematically, we define the reflection due to the source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Now the signal observed at $\bm{p}_\mathrm{r}$ due to the reflection from the position $\bm{\xi}$ is given by

$\psi(\bm{\xi},t) = r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\bm{p}_\mathrm{r}(\cdot)}\big) ,$

$\psi(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $z(t)$ is given by

$z(t) = \alpha_0 \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_0-
\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_signal.png)

### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\bm{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})    
\mathrm{A}(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}})}.$

```julia
using LTVsystems
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))/c))/
                       A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_simulation.png)


## Scenario C

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* multiple stationary ideal point reflectors
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario C.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC.png)

### Forward Modeling

For scenario C, given the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$, by providing the transmitted signal $p(t)$, and multiple stationary reflectors say N, the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given by

$q(\bm{\xi},t) = p(t) \overset{t}{*} h(\bm{\xi},t;\,{\bm{p}_\mathrm{s}}) ,$

$q(\bm{\xi},t)=\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Mathematically, we define the reflection due to the source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Now the signal observed at $\bm{p}_\mathrm{r}$ due to the reflection from the position $\bm{\xi}$ is given by

$\psi(\bm{\xi},t) = r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\bm{p}_\mathrm{r}(\cdot)}\big) ,$

$\psi(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $z(t)$ is given by

$z(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_n\|+\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.4; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_signal.png)

### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\bm{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)}
{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})    
\mathrm{A}(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}})}.$

```julia
using LTVsystems
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.2,0.0]
α₂ = 0.4; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ).+norm(𝐩ᵣ-ξ))/c))/
                         A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ-ξ)/c)   
inverse2Dplot([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_simulation.png)

## Scenario D

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* multiple stationary ideal point reflectors
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario C.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD.png)

### Forward Modeling

For scenario D, given the position of the source $𝐩ₛ$ and the multiple receivers at $\mathbf{p}_{\mathrm{r}^{(i)}}$ where $i = 1,2,…M$ by providing the transmitted signal, $p(t)$ and multiple stationary reflectors $\bm{\xi}_n$ where $n = 1,2,…,N$ and $M ≥N$, the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given by

$q(\bm{\xi},t) = p(t) \overset{t}{*} h(\bm{\xi},t;\,{\bm{p}_\mathrm{s}}) ,$

$q(\bm{\xi},t)=\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Mathematically, we define the reflection due to the source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

Now the signal observed at $\mathbf{p}_{\mathrm{r}^{(i)}}$ due to the reflection from the position $\bm{\xi}$ is given as follows

$\psi(\bm{\xi},t) = r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\bm{p}_\mathrm{r}(\cdot)}\big) ,$

$\psi_i(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}}\right).$

Finally, the closed form expression of the observed signals, $zᵢ(t)$ where $i = 1,2,…M$ is given by

$zᵢ(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|+\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.0, 0.3]
𝐩ᵣ₃ =  [0.3, 0.0]
𝐩ᵣ₄ =  [0.0, -0.3]
𝐩ᵣ₅ =  [0.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.4,0.7]
α₂ = 0.5; 𝛏₂ = [0.6,0.2]
α₃ = 0.4; 𝛏₃ = [0.6,1.0]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z₁ = LTIreceiverO(r,𝐩ᵣ₁); z₂ = LTIreceiverO(r,𝐩ᵣ₂)
z₃ = LTIreceiverO(r,𝐩ᵣ₃); z₄ = LTIreceiverO(r,𝐩ᵣ₄)
z₅ = LTIreceiverO(r,𝐩ᵣ₅)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))
plot!(p1,t, z₄(t))
plot!(p1,t, z₅(t))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_signal.png)

### Inverse Modeling

Given the scenario D assumptions, we obtained the received signals, $zᵢ(t)$ where $i=1,2,…M$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows

$\hat{f}(\bm{\xi}) = \left(\prod\limits_{i=1}^{M}fᵢ(\bm{\xi})\right)^{\frac{1}{M}}$, where

$fᵢ(\bm{\xi}) = \dfrac{zᵢ\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}- \bm{\xi}\|+\|\bm{\xi}
-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})
\mathrm{A}(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}})}.$

```julia
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.0, 0.3]
𝐩ᵣ₃ =  [0.3, 0.0]
𝐩ᵣ₄ =  [0.0, -0.3]
𝐩ᵣ₅ =  [0.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.4,0.7]
α₂ = 0.5; 𝛏₂ = [0.6,0.2]
α₃ = 0.4; 𝛏₃ = [0.6,1.0]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z₁ = LTIreceiverO(r,𝐩ᵣ₁); z₂ = LTIreceiverO(r,𝐩ᵣ₂)
z₃ = LTIreceiverO(r,𝐩ᵣ₃); z₄ = LTIreceiverO(r,𝐩ᵣ₄)
z₅ = LTIreceiverO(r,𝐩ᵣ₅)
f₁(ξ::Vector{Float64})=(z₁((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₁-ξ))/c))/
                       A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ₁-ξ)/c)
f₂(ξ::Vector{Float64})=(z₂((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₂-ξ))/c))/
                       A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ₂-ξ)/c)
f₃(ξ::Vector{Float64})=(z₃((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₃-ξ))/c))/
                       A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ₃-ξ)/c)
f₄(ξ::Vector{Float64})=(z₄((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₄-ξ))/c))/
                       A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ₄-ξ)/c)
f₅(ξ::Vector{Float64})=(z₅((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ₅-ξ))/c))/
                       A(norm(ξ-𝐩ₛ)/c).*A(norm(𝐩ᵣ₅-ξ)/c)
f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+
                      f₃(ξ::Vector{Float64}).+f₄(ξ::Vector{Float64}).+f₅(ξ::Vector{Float64})
inverse2Dplot([q],r,[z₁,z₂,z₃,z₄,z₅],f;x_min = -3.0,x_max = 3.0,
             y_min = -2.0,y_max = 2.0)
f_new(ξ::Vector{Float64})=(f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*
                          f₃(ξ::Vector{Float64}).*f₄(ξ::Vector{Float64}).*f₅(ξ::Vector{Float64}))^(1/3)
inverse2Dplot([q],r,[z₁,z₂,z₃,z₄,z₅],f_new;x_min = -3.0,x_max = 3.0,
             y_min = -2.0,y_max = 2.0)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_target_estimation.png)

## Scenario E

### Scenario Assumptions

* multiple stationary omnidirectional sources
* multiple stationary omnidirectional receivers
* multiple stationary ideal point reflectors
* the source emits an impulse

### Forward Modeling


### Inverse Modeling


## Scenario F

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* a continuous line segment reflector
* the source emits an ideal impulse

### Forward Modeling

Given the scenario E assumptions with the position of the source $𝐩ₛ$ and the receivers $𝐩ᵣ$, by providing the transmitted signal, $p(t)=δ(t)$ as an ideal impulse and a continuous line segment reflector. We obtained the received signal, $z(t)$ as follows.

$z(t) = \int_{0}^{L}\Big[\alpha_0 \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-[\bm{\xi}_0+k\bm{u}]\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|[\bm{\xi}_0+k\bm{u}]-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\bm{p}_\mathrm{r}-[\bm{\xi}_0+k\bm{u}]\|}{\mathrm{c}}-\frac{\|[\bm{\xi}_0+k\bm{u}]-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right) \Big] \mathrm{d}k$

We can simulate the scenario and plot signal at the receiver as follows.




### Inverse Modeling

Given the scenario E assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = ∫_{0}^{L}\dfrac{z\left(\dfrac{\|\bm{p}_\mathrm{r}-[\bm{\xi}+k\bm{u}]\|+\|[\bm{\xi}+k\bm{u}]-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-[\bm{\xi}+k\bm{u}]\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|[\bm{\xi}+k\bm{u}]-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)} \mathrm{d}k$



## Scenario G

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* a continuous line segment reflector
* the source emits an ideal impulse

### Forward Modeling
