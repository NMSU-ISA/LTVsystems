# LTI Omnidirectional Modeling

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model.png)

## Scenario A

### Scenario Assumptions

  * single stationary omnidirectional source
  * single stationary omnidirectional receiver at same location as the source
  * single stationary ideal point reflector
  * the source emits an impulse

Given the scenario A assumptions, we simulated the geometry of scenario as follows.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA.png)

### Forward Modeling

For scenario A, given the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$ being at the same location $(𝐩ₛ=𝐩ᵣ)$, by providing the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$, we obtained the expression for the reflector function as follows

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given as follows.

$q(\bm{\xi},t)=\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

Mathematically, we defined the reflection due to the source as follows.

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

Now the signal observed at $\bm{p}_\mathrm{r}$ due to the reflection from the
position $\bm{\xi}$ is given as follows.

$\psi(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right)$


Finally, we obtained the closed form expression of the observed signal, $z(t)$
with $(𝐩ₛ=𝐩ᵣ)$ as follows.

$z(t) = \alpha_0 \mathrm{A}^2
\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)p\left(t -2\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)$

We plot the signal at the receiver as follows.

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

Given the scenario A assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows.

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{2\|\bm{\xi}-\bm{p}_\mathrm{r}\|}{\mathrm{c}}\right)}
{\mathrm{A}^2(\frac{\|\bm{\xi}-\bm{p}_\mathrm{r}\|}{\mathrm{c}})}$

```julia
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
f(ξ::Vector{Float64}) = (z(2(norm(ξ-𝐩ₛ))./c))./
                        (A(norm(ξ-𝐩ₛ)./c))^2
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_simulation.png)


## Scenario B

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* single stationary ideal point reflector
* the source emits an impulse

Given the scenario B assumptions, we simulated the geometry of scenario as follows.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB.png)

### Forward Modeling

For scenario B, given the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$, by providing the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$, we obtained the expression for the reflector function as follows

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given as follows.

$q(\bm{\xi},t)=\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

Mathematically, we defined the reflection due to the source as follows.

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

Now the signal observed at $\bm{p}_\mathrm{r}$ due to the reflection from the position $\bm{\xi}$ is given as follows.

$\psi(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right)$


We obtained the closed form expression of the observed signal, $z(t)$ as follows.

$z(t) = \alpha_0 \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_0-
\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

We plot the signal at the receiver as follows.

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

Given the scenario B assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows.

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\bm{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})    
\mathrm{A}(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}})}$

```julia
using LTVsystems
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,[q])
z = LTIreceiverO([r],𝐩ᵣ)
f(ξ::Vector{Float64})=(z((norm(ξ-𝐩ₛ) .+ norm(𝐩ᵣ-ξ))./c))./
                       A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c)
inverse2Dplot([q],[r],[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_simulation.png)


## Scenario C

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* multiple stationary ideal point reflectors
* the source emits an impulse

Given the scenario C assumptions, we simulated the geometry of scenario as follows.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC.png)

### Forward Modeling

For scenario C, given the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$, by providing the transmitted signal $p(t)$, and multiple stationary reflectors say N, we obtained the expression for the reflector function as follows

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\bm{p}_\mathrm{s}$ is given as follows.

$q(\bm{\xi},t)=\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

Mathematically, we defined the reflection due to the source as follows.

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

Now the signal observed at $\bm{p}_\mathrm{r}$ due to the reflection from the position $\bm{\xi}$ is given as follows.

$\psi(\bm{\xi},t) = \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) r\left(\bm{\xi},t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right)$


We obtained the closed form expression of the observed signal, $z(t)$ as follows.

$z(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_n\|+\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$

We plot the signal at the receiver as follows.

```julia
using LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
α₂ = 0.4; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_signal.png)

### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=δ(t)$ as follows.

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\bm{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)}
{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})    
\mathrm{A}(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}})}$

```julia
using LTVsystems
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
α₂ = 0.4; 𝛏₂ = [1.8,1.8]
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
r = pointReflector([𝛏₁,𝛏₂,𝛏₃],[α₁,α₂,α₃],[q])
z = LTIreceiverO(r,𝐩ᵣ)
f(ξ::Vector{Float64}) = (z((norm(ξ-𝐩ₛ).+norm(𝐩ᵣ-ξ))./c))./
                         A(norm(ξ-𝐩ₛ)./c).*A(norm(𝐩ᵣ-ξ)./c)   
inverse2Dplot([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_simulation.png)

## Scenario D

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* multiple stationary ideal point reflectors
* the source emits an ideal impulse

### Forward Modeling

Given the scenario D assumptions with the position of the source $𝐩ₛ$ and the multiple receivers at $\mathbf{p}_{\mathrm{r}^{(i)}}$ where $i = 1,2,…M$ by providing the transmitted signal, $p(t)=δ(t)$ as an ideal impulse and multiple stationary reflectors $\bm{\xi}_n$ where $n = 1,2,…,N$ and $M ≥N$.
We obtained the closed form expression of the observed signals, $zᵢ(t)$ where $i = 1,2,…M$. as follows.


$zᵢ(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)
δ\left(t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|+\|\bm{\xi}_n-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)$


We can simulate the scenario and plot signal at the receiver as follows.

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.0, 0.3]
𝐩ᵣ₃ =  [0.3, 0.0]
𝐩ᵣ₄ =  [0.0, -0.3]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.4,0.7]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.5; 𝛏₂ = [0.6,0.2]
R₂ = LTIsourceO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.4; 𝛏₃ = [0.6,0.9]
R₃ = LTIsourceO(𝛏₃, t->α₃*q(𝛏₃,t))
z₁ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₁)
z₂ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₂)
z₃ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₃)
z₄ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₄)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))
plot!(p1,t, z₄(t))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_signal.png)

### Inverse Modeling

Given the scenario D assumptions, we obtained the received signals, $zᵢ(t)$ where $i=1,2,…M$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = \left(\prod\limits_{i=1}^{M}fᵢ(\bm{\xi})\right)^{\frac{1}{M}}$, where

$fᵢ(\bm{\xi}) = \dfrac{zᵢ\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-    \bm{\xi}\|+\|\bm{\xi}
-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})
\mathrm{A}(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}})}$

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.0, 0.3]
𝐩ᵣ₃ =  [0.3, 0.0]
𝐩ᵣ₄ =  [0.0, -0.3]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.4,0.7]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.5; 𝛏₂ = [0.6,0.2]
R₂ = LTIsourceO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.4; 𝛏₃ = [0.6,0.9]
R₃ = LTIsourceO(𝛏₃, t->α₃*q(𝛏₃,t))
z₁ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₁)
z₂ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₂)
z₃ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₃)
z₄ = LTIreceiverO([R₁,R₂,R₃],𝐩ᵣ₄)
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₁,ξ)./lightSpeed)
a₂(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₂,ξ)./lightSpeed)
a₃(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₃,ξ)./lightSpeed)
a₄(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₄,ξ)./lightSpeed)
f₁(ξ::Vector{Float64})=(z₁((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₁,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))
f₂(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₂,ξ))./lightSpeed))./(a₂(ξ::Vector{Float64}))
f₃(ξ::Vector{Float64})=(z₃((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₃,ξ))./lightSpeed))./(a₃(ξ::Vector{Float64}))
f₄(ξ::Vector{Float64})=(z₄((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₄,ξ))./lightSpeed))./(a₄(ξ::Vector{Float64}))

f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64})
                      .+f₃(ξ::Vector{Float64}).+f₄(ξ::Vector{Float64})
Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-2:Δpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
       aspect_ratio=:equal,legend=true,zticks=false,
       bg = RGB(0.1,0.1,0.1))
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 6.5,color = :green,
         marker=:pentagon, label='s')
scatter!(p2,[𝐩ᵣ₁[1]], [𝐩ᵣ₁[2]],markersize = 5.5,color = :blue,   
         marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₂[1]], [𝐩ᵣ₂[2]],markersize = 5.5,color = :blue,
        marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₃[1]], [𝐩ᵣ₃[2]],markersize = 5.5,color = :blue,
        marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₄[1]], [𝐩ᵣ₄[2]],markersize = 5.5,color = :blue,
        marker=:square, label='r')
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red,
         marker=:star8, label='t')
scatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red,
         marker=:star8, label='t')
scatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red,
        marker=:star8, label='t')
f_new(ξ::Vector{Float64})=(f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*f₃(ξ::Vector{Float64}).*f₄(ξ::Vector{Float64}))^(1/3)
val1 = [f_new(𝐮) for 𝐮 ∈ xyGrid]
p3 = plot(x_range,y_range,transpose(val1),st=:surface,
      camera=(0,90),aspect_ratio=:equal,legend=true,zticks=false,bg = RGB(0.1, 0.1, 0.1))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_target_estimation.png)

## Scenario E

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* a continuous line segment reflector
* the source emits an ideal impulse

### Forward Modeling

Given the scenario E assumptions with the position of the source $𝐩ₛ$ and the receivers $𝐩ᵣ$, by providing the transmitted signal, $p(t)=δ(t)$ as an ideal impulse and a continuous line segment reflector. We obtained the received signal, $z(t)$ as follows.

$z(t) = \int_{0}^{L}\Big[\alpha_0 \mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-[\bm{\xi}_0+k\bm{u}]\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|[\bm{\xi}_0+k\bm{u}]-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)
δ\left(t-\frac{\|\bm{p}_\mathrm{r}-[\bm{\xi}_0+k\bm{u}]\|}{\mathrm{c}}-\frac{\|[\bm{\xi}_0+k\bm{u}]-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right) \Big] dk$

We can simulate the scenario and plot signal at the receiver as follows.

```julia
using ISA, LTVsystems
using QuadGK
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ =  [-0.3, 0.0]
ξ₀=[0.2,0.3]
α₀ = 0.6;
u_vec = [1/√(2),1/√(2)]
step = 0.015;
line_seg = [quadgk(x->ξ₀ .+ x.*u_vec,0.0,i+step)[1] for i in 1.0:step:2.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
z = LTIreceiverO([LTIsourceO(line_seg[i], t->α₀*q(line_seg[i],t)) for i in 1:length(line_seg)],𝐩ᵣ)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
display(p1)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_signal.png)


### Inverse Modeling

Given the scenario E assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = ∫_{0}^{L}\dfrac{z\left(\dfrac{\|\bm{p}_\mathrm{r}-[\bm{\xi}+k\bm{u}]\|+\|[\bm{\xi}+k\bm{u}]-\bm{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}\left(\frac{\|\bm{p}_\mathrm{r}-[\bm{\xi}+k\bm{u}]\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|[\bm{\xi}+k\bm{u}]-\bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)} dk$

```julia
using ISA, LTVsystems
using QuadGK
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ =  [-0.3, 0.0]
ξ₀=[0.2,0.3]
α₀ = 0.6;
u_vec = [1/√(2),1/√(2)]
step = 0.015;
line_seg = [quadgk(x->ξ₀ .+ x.*u_vec,0.0,i+step)[1] for i in 1.0:step:2.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
z = LTIreceiverO([LTIsourceO(line_seg[i], t->α₀*q(line_seg[i],t))
                 for i in 1:length(line_seg)],𝐩ᵣ)
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)
                           ./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))
                         ./(a₁(ξ::Vector{Float64}))
T_val1 = map(x->x[1],line_seg)
T_val2 = map(x->x[2],line_seg)
line = Any[collect(zip(T_val1,T_val2))]
Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-3:Δpos:3)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
          aspect_ratio=:equal,legend=true,zticks=false,bg = RGB(0.0, 0.0, 0.0))
plot!(p2,line[1],color = :red, lw=5,label='t')
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green,
         marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue,
         marker=:square, label='r' )
display(p2)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_simulation.png)

## Scenario F

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* a continuous line segment reflector
* the source emits an ideal impulse

### Forward Modeling
