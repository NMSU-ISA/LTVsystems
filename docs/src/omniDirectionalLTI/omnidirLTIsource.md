# LTI Omnidirectional Modeling

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model.png)

## Scenario A

### Scenario Assumptions

  * single stationary omnidirectional source
  * single stationary omnidirectional receiver at same location as the source
  * single stationary ideal point reflector
  * the source emits an ideal impulse

### Forward Modeling

We can simulate the scenario and plot signal at the receiver as follows.

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]  
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiversO([R₁],𝐩ᵣ)
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_signal.png)

### Inverse Modeling

Given the scenario A assumptions i.e. the position of the source,$𝐩ₛ$ and the receiver, $𝐩ᵣ$ being at the same location $(𝐩ₛ=𝐩ᵣ)$, and by providing the transmitted signal, $p(t)$ as an ideal impulse, we obtained the received signal, $z(t)$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{2\|\bm{\xi}-\bm{p}_\mathrm{r}\|}{\mathrm{c}}\right)}
{\mathrm{A}^2(\frac{\|\bm{\xi}-\bm{p}_\mathrm{r}\|}{\mathrm{c}})}$

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]  
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiversO([R₁],𝐩ᵣ)
a₁(ξ::Vector{Float64}) = (A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2
f(ξ::Vector{Float64}) = (z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./
                        (a₁(ξ::Vector{Float64}))     
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=false,zticks=false,title="ScenarioA Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green,     
        marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue,
        marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red,  
        marker=:star8, label='t')
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_simulation.png)

For all simulated results, we displayed the sources as a green pentagon, the receivers as a blue square and the reflectors as a red star.

## Scenario B

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* single stationary ideal point reflector
* the source emits an ideal impulse

### Forward Modeling

We can simulate the scenario and plot signal at the receiver as follows.

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiversO([R₁],𝐩ᵣ)
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_signal.png)

### Inverse Modeling

Given the scenario B assumptions i.e. the position of the source,$𝐩ₛ$ and the receiver, $𝐩ᵣ$, by providing the transmitted signal, $p(t)$ as an ideal impulse, we obtained the received signal, $z(t)$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|+\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}  \right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})    
\mathrm{A}(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}})}$

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [1.0, 0.0]
𝐩ᵣ =  [-1.0, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiversO([R₁],𝐩ᵣ)
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         legend=false,zticks=false,title="Scenario B Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_simulation.png)


## Scenario C

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* multiple stationary ideal point reflectors
* the source emits an ideal impulse

### Forward Modeling

We can simulate the scenario and plot signal at the receiver as follows.

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.3; 𝛏₂ = [1.8,1.8]
R₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
R₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))
z = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ)
t = collect(0.0:1.0e-10:25.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_signal.png)

### Inverse Modeling

Given the scenario C assumptions i.e. the position of the source,$𝐩ₛ$ and the receiver, $𝐩ᵣ$, by providing the transmitted signal, $p(t)$ as an ideal impulse and multiple stationary reflectors say N, we obtained the received signal, $z(t)$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|+\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}}  \right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})    
\mathrm{A}(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}})}$

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.3, 0.3]
𝐩ᵣ =  [0.9, 0.9]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [0.9,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.3; 𝛏₂ = [1.8,1.8]
R₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.5; 𝛏₃ = [2.7,-0.9]
R₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))
z = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ)
a₀(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)
f(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₀(ξ::Vector{Float64}))
Δpos = 0.01
x_range = collect(-5:Δpos:5)
y_range = collect(-4:Δpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         legend=false,zticks=false,title="Scenario C Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5, color = :blue, marker=:square, label='r' )
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
scatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_simulation.png)

## Scenario D

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* multiple stationary ideal point reflectors
* the source emits an ideal impulse

### Forward Modeling

We can simulate the scenario and plot signal at the receiver as follows.

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.6, 0.0]
𝐩ᵣ₃ =  [1.2, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.8; 𝛏₁ = [0.9,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.5; 𝛏₂ = [0.5,0.0]
R₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.4; 𝛏₃ = [0.7,0.0]
R₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))
z₁ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₁)
z₂ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₂)
z₃ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₃)
t = collect(0.0:1.0e-10:15.5e-9)
p1 = plot( t, z₁(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z₂(t))
plot!(p1,t, z₃(t))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_signal.png)

### Inverse Modeling

Given the scenario D assumptions i.e. the position of the source,$𝐩ₛ$ and the multiple receivers at $(𝐩ᵣ)_i$ where $i=1,2,…N$ by providing the transmitted signal, $p(t)$ as an ideal impulse and multiple stationary reflectors say N, we obtained the received signal, $zᵢ(t)$ where $i=1,2,…N$. Now we can estimate the reflector function as follows.

$\hat{f}(\bm{\xi}) = \sum\limits_{i=1}^{N}fᵢ(\bm{\xi})$, where

$fᵢ(\bm{\xi}) = \dfrac{zᵢ\left(\frac{\|(\bm{p}_\mathrm{r})_i-    \bm{\xi}\|+\|\bm{\xi}-  \bm{p}_\mathrm{s}\|}{\mathrm{c}}\right)}{\mathrm{A}(\frac{\|\bm{\xi}-\bm{p}_\mathrm{s}\|}{\mathrm{c}})\mathrm{A}(\frac{\|(\bm{p}_\mathrm{r})_i-\bm{\xi}\|}{\mathrm{c}})}$

```julia
using ISA, LTVsystems
using Plots
𝐩ₛ =  [0.0, 0.3]
𝐩ᵣ₁ =  [-0.3, 0.0]
𝐩ᵣ₂ =  [0.6, 0.0]
𝐩ᵣ₃ =  [1.2, 0.0]
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
α₁ = 0.8; 𝛏₁ = [0.9,0.0]
R₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))
α₂ = 0.5; 𝛏₂ = [0.5,0.0]
R₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))
α₃ = 0.4; 𝛏₃ = [0.7,0.0]
R₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))
z₁ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₁)
z₂ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₂)
z₃ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₃)
a₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₁,ξ)./lightSpeed)
a₂(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₂,ξ)./lightSpeed)
a₃(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₃,ξ)./lightSpeed)
f₁(ξ::Vector{Float64})=(z₁((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₁,ξ)). lightSpeed))./(a₁(ξ::Vector{Float64}))
f₂(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₂,ξ))./lightSpeed))./(a₂(ξ::Vector{Float64}))
f₃(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₃,ξ))./lightSpeed))./(a₃(ξ::Vector{Float64}))
f(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+
f₃(ξ::Vector{Float64})
Δpos = 0.01
x_range = collect(-3:Δpos:3)
y_range = collect(-2:Δpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         legend=false,zticks=false,title="Scenario D Simulation")
scatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green,
        marker=:pentagon, label='s')
scatter!(p2,[𝐩ᵣ₁[1]], [𝐩ᵣ₁[2]],markersize = 5.5,color = :blue,
        marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₂[1]], [𝐩ᵣ₂[2]],markersize = 5.5,color = :blue,
        marker=:square, label='r')
scatter!(p2,[𝐩ᵣ₃[1]], [𝐩ᵣ₃[2]],markersize = 5.5,color = :blue,
        marker=:square, label='r')
scatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red,
        marker=:star8, label='t')
scatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red,
        marker=:star8, label='t')
scatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red,
        marker=:star8, label='t')
f_new(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*
f₃(ξ::Vector{Float64})
val1 = [f_new(𝐮) for 𝐮 ∈ xyGrid]
p3 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),
       legend=false,zticks=false,title="Scenario D reflector Estimation")
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_target_estimation.png)

## Scenario E

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* a continuous reflector
* the source emits an ideal impulse

### Forward Modeling
