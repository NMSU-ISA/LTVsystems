# LTI Omnidirectional Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $t$                     | scalar variable |  time   |
| $\bm{\xi}$              | vector variable |  position   |
| $\mathbf{p}_\mathrm{s}$     | vector                  | position of source |
| $\mathbf{p}_\mathrm{r}$     | vector                  | position of receiver |
| $p(t)$                  | scalar function of time |  source emission   |
| $f(\bm{\xi})$           | scalar function of position |  reflectivity function   |
| $h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}})$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $q(\bm{\xi},t)$  |  scalar function of position and time  | observation of source emission at $\bm{\xi}$ |
| $r(\bm{\xi},t)$  |  scalar function of position and time  | reflection from $\bm{\xi}$ due to source|
| $g(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}})$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |
| $\psi(\bm{\xi},t)$ |  scalar function of position and time  | observation of reflections from $\bm{\xi}$ at $\mathbf{p}_\mathrm{r}$ |
| $z(t)$                | scalar function of time |   observation of reflections at $\mathbf{p}_\mathrm{r}$   |




![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model.png)



The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}}) = \mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$

The signal observed at position $\bm{\xi}$ and time $t$ due to the source emitting from position $\mathbf{p}_\mathrm{s}$ is given as

```math
\begin{aligned}
q(\bm{\xi},t)  &= p(t) \overset{t}{*} h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}}) \\
               &= \mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
               {\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).
\end{aligned}
```

The reflection due to source is given by

$r(\bm{\xi},t) = f(\bm{\xi}) q(\bm{\xi},t).$

The LTI impulse response from an arbitrary position $\bm{\xi}$ to the receiver at position $\mathbf{p}_\mathrm{r}$ is given by

$g(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}}) = \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right) \delta\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\right).$

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

  * single stationary omnidirectional source
  * single stationary omnidirectional receiver at same location as the source
  * single stationary ideal point reflector
  * the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario A.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA.png)

### Forward Modeling

For scenario A, we provided the position of the source $???????$, the receiver's position $???????$, being at the same location $(???????=???????)$, the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $z(t)$
with $(???????=???????)$ is given by

$z(t) = \alpha_0 \mathrm{A}^2
\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)p\left(t -2\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
??????? =  [0.0, 0.0]
??????? =  ???????
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.8,0.0]
r = pointReflector(???????,?????,q)
z = LTIreceiverO([r],???????)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioA_signal.png)

### Inverse Modeling

Given the scenario A assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=??(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{2\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\right)}
{\mathrm{A}^2\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{r}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
??????? =  [0.0, 0.0]
??????? =  ???????
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.8,0.0]
r = pointReflector(???????,?????,q)
z = LTIreceiverO([r],???????)
f(??::Vector{Float64}) = z(2(norm(??-???????))/c)/
                        (A(norm(??-???????)/c))^2
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

For scenario B, we provided the position of the source $???????$, the receiver's position $???????$, the transmitted signal $p(t)$, and an ideal point reflector $\bm{\xi}_0$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$

We compute the reflection due to the source as follows

$r(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $z(t)$ is given by

$z(t) = \alpha_0 \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right) p\left(t-
\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_0\|+\|\bm{\xi}_0-
\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
??????? =  [1.0, 0.0]
??????? =  [-1.0, 0.0]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.8,0.0]
r = pointReflector(???????,?????,q)
z = LTIreceiverO([r],???????)
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioB_signal.png)

### Inverse Modeling

Given the scenario B assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=??(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
??????? =  [1.0, 0.0]
??????? =  [-1.0, 0.0]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.8,0.0]
r = pointReflector(???????,?????,q)
z = LTIreceiverO([r],???????)
f(??::Vector{Float64})=z((norm(??-???????) .+ norm(???????-??))/c)/
                      (A(norm(??-???????)/c).*A(norm(???????-??)/c))
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

For scenario C, we provided the position of the source $???????$, the receiver's position $???????$, the transmitted signal $p(t)$, and multiple stationary reflectors say N.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

We compute the reflection due to the source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signal, $z(t)$ is given by

$z(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{A}\left(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}_n\|+\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
??????? =  [0.3, 0.3]
??????? =  [0.9, 0.9]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.2,0.0]
????? = 0.4; ??????? = [1.8,1.8]
????? = 0.5; ??????? = [2.7,-0.9]
r = pointReflector([???????,???????,???????],[?????,?????,?????],[q])
z = LTIreceiverO(r,???????)
t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_signal.png)

### Inverse Modeling

Given the scenario C assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=??(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\frac{\|\mathbf{p}_\mathrm{r}-
\bm{\xi}\|+\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)}
{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)    
\mathrm{A}\big(\frac{\|\mathbf{p}_\mathrm{r}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
??????? =  [0.3, 0.3]
??????? =  [0.9, 0.9]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.2,0.0]
????? = 0.4; ??????? = [1.8,1.8]
????? = 0.5; ??????? = [2.7,-0.9]
r = pointReflector([???????,???????,???????],[?????,?????,?????],[q])
z = LTIreceiverO(r,???????)
f(??::Vector{Float64}) = z((norm(??-???????).+norm(???????-??))/c)/
                        (A(norm(??-???????)/c).*A(norm(???????-??)/c))   
inverse2Dplot([q],r,[z],f)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioC_simulation.png)

## Scenario D

### Scenario Assumptions

* single stationary omnidirectional source
* multiple stationary omnidirectional receivers
* multiple stationary ideal point reflectors
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario D.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD.png)

### Forward Modeling

For scenario D, we provided the position of the source $???????$ and the multiple receivers's position at $\mathbf{p}_{\mathrm{r}^{(i)}}$ where $i = 1,2,???M$, the transmitted signal, $p(t)$ and multiple stationary reflectors $\bm{\xi}_n$ where $n = 1,2,???,N$ and $M ???N$.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$


We compute the reflection due to the source as follows

$r(\bm{\xi},t) = \sum\limits_{n=1}^{N}\alpha_n \delta(\bm{\xi} - \bm{\xi}_n)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


Finally, the closed form expression of the observed signals, $z???(t)$ where $i = 1,2,???M$ is given by

$z???(t) = \sum\limits_{n=1}^{N} \alpha_n \mathrm{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_n\|+\|\bm{\xi}_n-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


```julia
using LTVsystems
using Plots
??????? =  [0.0, 0.0]
?????????? =  [-0.3, 0.0]
?????????? =  [0.0, 0.3]
?????????? =  [0.3, 0.0]
?????????? =  [0.0, -0.3]
?????????? =  [0.0, 0.0]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [0.4,0.7]
????? = 0.5; ??????? = [0.6,0.2]
????? = 0.4; ??????? = [0.6,1.0]
r = pointReflector([???????,???????,???????],[?????,?????,?????],[q])
z??? = LTIreceiverO(r,??????????); z??? = LTIreceiverO(r,??????????)
z??? = LTIreceiverO(r,??????????); z??? = LTIreceiverO(r,??????????)
z??? = LTIreceiverO(r,??????????)
t = 0.0:1.0e-10:15.5e-9
p1 = plot( t, z???(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z???(t))
plot!(p1,t, z???(t))
plot!(p1,t, z???(t))
plot!(p1,t, z???(t))
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_signal.png)

### Inverse Modeling

Given the scenario D assumptions, we obtained the received signals, $z???(t)$ where $i=1,2,???M$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=??(t)$ as follows

$\hat{f}(\bm{\xi}) = \left(\prod\limits_{i=1}^{M}f???(\bm{\xi})\right)^{\frac{1}{M}}$, where

$f???(\bm{\xi}) = \dfrac{z???\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}- \bm{\xi}\|+\|\bm{\xi}
-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\big)
\mathrm{A}\big(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
??????? =  [0.0, 0.0]
?????????? =  [-0.3, 0.0]
?????????? =  [0.0, 0.3]
?????????? =  [0.3, 0.0]
?????????? =  [0.0, -0.3]
?????????? =  [0.0, 0.0]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [0.4,0.7]
????? = 0.5; ??????? = [0.6,0.2]
????? = 0.4; ??????? = [0.6,1.0]
r = pointReflector([???????,???????,???????],[?????,?????,?????],[q])
z??? = LTIreceiverO(r,??????????); z??? = LTIreceiverO(r,??????????)
z??? = LTIreceiverO(r,??????????); z??? = LTIreceiverO(r,??????????)
z??? = LTIreceiverO(r,??????????)
f???(??::Vector{Float64})=z???((norm(??-???????) .+ norm(??????????-??))/c)/
                       (A(norm(??-???????)/c).*A(norm(??????????-??)/c))
f???(??::Vector{Float64})=z???((norm(??-???????) .+ norm(??????????-??))/c)/
                       (A(norm(??-???????)/c).*A(norm(??????????-??)/c))
f???(??::Vector{Float64})=z???((norm(??-???????) .+ norm(??????????-??))/c)/
                       (A(norm(??-???????)/c).*A(norm(??????????-??)/c))
f???(??::Vector{Float64})=z???((norm(??-???????) .+ norm(??????????-??))/c)/
                       (A(norm(??-???????)/c).*A(norm(??????????-??)/c))
f???(??::Vector{Float64})=z???((norm(??-???????) .+ norm(??????????-??))/c)/
                       (A(norm(??-???????)/c).*A(norm(??????????-??)/c))
f(??::Vector{Float64})=f???(??::Vector{Float64}).+f???(??::Vector{Float64}).+
                    f???(??::Vector{Float64}).+f???(??::Vector{Float64}).+f???(??::Vector{Float64})
inverse2Dplot([q],r,[z???,z???,z???,z???,z???],f)
f_new(??::Vector{Float64})=(f???(??::Vector{Float64}).*f???(??::Vector{Float64}).*
                          f???(??::Vector{Float64}).*f???(??::Vector{Float64}).*f???(??::Vector{Float64}))^(1/3)
inverse2Dfinalplot([q],[z???,z???,z???,z???,z???],f_new)
```
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_simulation.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioD_target_estimation.png)

## Scenario E

### Scenario Assumptions

* multiple stationary omnidirectional sources
* multiple stationary omnidirectional receivers
* a stationary ideal point reflector
* the source emits an impulse

Given the assumptions, we simulate the following geometry for scenario E.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE.png)

### Forward Modeling

For scenario E, we provided the positions of multiple sources at $\mathbf{p}_{\mathrm{s}^{(i)}}$
where $i = 1,2,???N$, the multiple receivers at $\mathbf{p}_{\mathrm{r}^{(i)}}$ where $i = 1,2,???N$, the transmitted signal $p(t)$, and a stationary reflector.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0).$


We compute the reflection due to the sources as follows

$r_i(\bm{\xi},t) = \alpha_0 \delta(\bm{\xi} - \bm{\xi}_0)
\mathrm{A}\left(\frac{\|\bm{\xi}-\bm{p}_{\mathrm{s}^{(i)}}\|}
{\mathrm{c}}\right) p\left(t-\frac{\|\bm{\xi}-\bm{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\right).$

where $i = 1,2,???N$,


Finally, the closed form expression of the observed signals, $z???(t)$ where $i = 1,2,???M$ is given by

$z???(t) = \alpha_0 \mathrm{A}\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_0\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}_0-\mathbf{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\right)
p\left(t-\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}_0\|+\|\bm{\xi}_0-\mathbf{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\right).$

```julia
using LTVsystems
using Plots
?????????? =  [-0.8, 0.0]
?????????? =  [-0.4, 0.0]
?????????? =  [0.1, 0.0]
?????????? =  [0.5, 0.0]
?????????? =  [0.8, 0.0]
?????????? =  [1.2, 0.0]
p(t) = ??n(t,1.0e-10)
q??? = LTIsourceO(??????????, p); q??? = LTIsourceO(??????????, p); q??? = LTIsourceO(??????????, p)
????? = 0.7; ??????? = [0.7,0.9]
r??? = pointReflector(???????,?????,[q???]); r??? = pointReflector(???????,?????,[q???]);
r??? = pointReflector(???????,?????,[q???])
z??? = LTIreceiverO([r???],??????????)
z??? = LTIreceiverO([r???],??????????)
z??? = LTIreceiverO([r???],??????????)
t = 0.0:1.0e-10:15.5e-9
p1 = plot( t, z???(t), xlab="time (sec)", ylab="z(t)", legend=:false)
plot!(p1,t, z???(t))
plot!(p1,t, z???(t))
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_signal.png)

### Inverse Modeling
Given the scenario E assumptions, we obtained the received signals, $z???(t)$ where $i=1,2,???M$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=??(t)$ as follows

$\hat{f}(\bm{\xi}) = \left(\prod\limits_{i=1}^{N}f???(\bm{\xi})\right)$, where

$f???(\bm{\xi}) = \dfrac{z???\left(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}- \bm{\xi}\|+\|\bm{\xi}
-\bm{p}_{\mathrm{s}^{(i)}}\|}
{\mathrm{c}}\right)}{\mathrm{A}\big(\frac{\|\bm{\xi}-\bm{p}_{\mathrm{s}^{(i)}}\|}{\mathrm{c}}\big)
\mathrm{A}\big(\frac{\|\mathbf{p}_{\mathrm{r}^{(i)}}-\bm{\xi}\|}{\mathrm{c}}\big)}.$

```julia
using LTVsystems
?????????? =  [-0.8, 0.0]
?????????? =  [-0.4, 0.0]
?????????? =  [0.1, 0.0]
?????????? =  [0.5, 0.0]
?????????? =  [0.8, 0.0]
?????????? =  [1.2, 0.0]
p(t) = ??n(t,1.0e-10)
q??? = LTIsourceO(??????????, p); q??? = LTIsourceO(??????????, p); q??? = LTIsourceO(??????????, p)
????? = 0.7; ??????? = [0.7,0.9]
r??? = pointReflector(???????,?????,[q???]); r??? = pointReflector(???????,?????,[q???]);
r??? = pointReflector(???????,?????,[q???])
z??? = LTIreceiverO([r???],??????????)
z??? = LTIreceiverO([r???],??????????)
z??? = LTIreceiverO([r???],??????????)
f???(??::Vector{Float64})=z???((norm(??-??????????) .+ norm(??????????-??))./c)./
                       (A(norm(??-??????????)./c).*A(norm(??????????-??)./c))
f???(??::Vector{Float64})=z???((norm(??-??????????) .+ norm(??????????-??))./c)./
                       (A(norm(??-??????????)./c).*A(norm(??????????-??)./c))
f???(??::Vector{Float64})=z???((norm(??-??????????) .+ norm(??????????-??))./c)./
                       (A(norm(??-??????????)./c).*A(norm(??????????-??)./c))
f(??::Vector{Float64})=f???(??::Vector{Float64}).+f???(??::Vector{Float64}).+
                      f???(??::Vector{Float64})
inverse2Dplot([q???,q???,q???],[r???,r???,r???],[z???,z???,z???],f)
f_new(??::Vector{Float64})=(f???(??::Vector{Float64}).*f???(??::Vector{Float64}).*
                           f???(??::Vector{Float64}))
inverse2Dfinalplot([q???,q???,q???],[z???,z???,z???],f_new)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_simulation.png)

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioE_target_estimation.png)


## Scenario F

### Scenario Assumptions

* single stationary omnidirectional source
* single stationary omnidirectional receiver
* a continuous line segment reflector
* the source emits an ideal impulse

Given the assumptions, we simulate the following geometry for scenario F.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioF.png)

### Forward Modeling

Given the scenario F assumptions, we provided the position of the source $???????$, the receiver's position $???????$, the transmitted signal, $p(t)$ as an impulse and a continuous line segment reflector.

Now the expression for the reflector function is given by

$f(\bm{\xi}) = \int_{0}^{L}\alpha_0 \delta(\bm{\xi} - [\bm{\xi}_0+k\bm{u}]) \mathrm{d}k$

where $?????$ is a reflection coefficient, $\bm{?????}$ is an initial position vector, $\bm{u}$ is an unit vector in the direction of line segment, $AB$ and $k$ is any scalar quantity.


We compute the reflection due to the source as follows

$r(\bm{\xi},t)  = \int_{0}^{L}\alpha_0 \delta(\bm{\xi} - [\bm{\xi}_0+k\bm{u}])\mathrm{d}k ~~ q(\bm{\xi},t).$


Finally, the closed form expression of the observed signal, $z(t)$ is given by

$z(t) = \int_{0}^{L}\Big[\alpha_0 \mathrm{A}\left(\frac{\big\|\mathbf{p}_\mathrm{r}-[\bm{\xi}_0+k\bm{u}]\big\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\big\|[\bm{\xi}_0+k\bm{u}]-\mathbf{p}_\mathrm{s}\big\|}{\mathrm{c}}\right)
p\left(t-\frac{\big\|\mathbf{p}_\mathrm{r}-[\bm{\xi}_0+k\bm{u}]\big\|}{\mathrm{c}}-\frac{\big\|[\bm{\xi}_0+k\bm{u}]-\mathbf{p}_\mathrm{s}\big\|}{\mathrm{c}}\right) \Big] \mathrm{d}k.$

```julia
using LTVsystems
using QuadGK
using Plots
??????? =  [0.1, 0.0]
??????? =  [0.6, 0.0]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.8,2.0]; ???? = [1.0,0.0]; len=1.0
r = lineSegment(???????,????,len,k->?????,[q])
z = LTIreceiverO([r],???????)
t = 0.0:1.0e-10:35.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioF_signal.png)

### Inverse Modeling

Given the scenario F assumptions, we obtained the received signal, $z(t)$. Now we can estimate the reflector function by considering the transmitted signal $p(t)=??(t)$ as follows

$\hat{f}(\bm{\xi}) = \dfrac{z\left(\dfrac{\|\mathbf{p}_\mathrm{r}-[\bm{\xi}+k\bm{u}]\|+\|[\bm{\xi}+k\bm{u}]-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}  \right)}{\mathrm{A}\left(\frac{\big\|\mathbf{p}_\mathrm{r}-[\bm{\xi}+k\bm{u}]\big\|}{\mathrm{c}}\right)
\mathrm{A}\left(\frac{\big\|[\bm{\xi}+k\bm{u}]-\mathbf{p}_\mathrm{s}\big\|}{\mathrm{c}}\right)}.$

```julia
using LTVsystems
using QuadGK
using Plots
??????? =  [0.1, 0.0]
??????? =  [0.6, 0.0]
p(t) = ??n(t,1.0e-10)
q = LTIsourceO(???????, p)
????? = 0.7; ??????? = [1.8,2.0]; ???? = [1.0,0.0]; len=1.0
r = lineSegment(???????,????,len,k->?????,[q])
z = LTIreceiverO([r],???????)
f(??::Vector{Float64})=z((norm(??-???????) .+norm(???????-??))./c)./(A(norm(??-???????)./c).*A(norm(???????-??)./c))
inverse2Dplot([q],[r],[z],f)
```

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/scenarioF_simulation.png)
