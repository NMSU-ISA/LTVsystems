# Receivers

## LTI Omnidirectional Receiver

In order to define **LTI Omnidirectional Receiver**, first we observed the signal due to the reflection which is given by taking convolution between the reflected signal, $r(\bm{\xi},t)$ and the impulse response from the receiver located at position, $\bm{p}_\mathrm{r}$. Mathematically, we can define the observed signal
as follows

$\psi(\bm{\xi},t) = r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\bm{p}_\mathrm{r}(\cdot)}\big)$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Psi.png)

Finally, the observed signal, $z(t)$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$z(t) = ∭ \psi(\bm{\xi},t) dS$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Listeners.png)

### Defining an LTI Omnidirectional Receiver

First, we will define the reflected signal by  calling `LTIsourceO()` with a transmitted signal, $p(t)$
and the source position, $\bm{p}_\mathrm{s}$. Then
we can define a  **LTI Omnidirectional Receiver** by calling `LTIreceiverO()` with the defined reflected signal and the receiver position, $\bm{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Receivers.png)
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]  
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiverO([R₁],𝐩ᵣ)
```

## LTI Directional Receiver

An **LTI Directional Receiver** is parameterized by accounting the direction of the antenna which is defined by directional gain,

$\mathrm{D}_\mathrm{r}\left(\bm{\xi};\,\textcolor{myLightSlateGrey}
{\bm{p}_\mathrm{r},\bm{b}_\mathrm{r}}\right)= \mathrm{G}_\mathrm{r}
\left(∠[\,\bm{b}\,,\,\bm{\xi}-\bm{p}_\mathrm{r}\,]\right)$

where $∠[⋅,⋅]$ returns the angle between the two arguments and $\mathrm{G}_\mathrm{r}(\Theta)$
is the receiver antenna's $\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{r}$.

We define an **LTI Directional Receiver** by observing the signal due to the reflection given by taking convolution between the reflected signal, $r(\bm{\xi},t)$ and the impulse response from the receiver located at position, $\bm{p}_\mathrm{r}$.
Mathematically, we can define the observed signal as follows.


$\psi(\bm{\xi},t)=r(\bm{\xi},t) \overset{t}{*} g(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{r},\bm{b}_\mathrm{r}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_Receivers_DTI.png)

Finally, the observed signal, $z(t)$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$z(t) = ∭ \psi(\bm{\xi},t) dS$

### Defining an LTI Directional Receiver

we can define a  **LTI Directional Receiver** by calling `LTIreceiverDTI()` with the defined reflected signal and the receiver position, $\bm{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_Receivers_DTIobs.png)

```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]  
p(t) = δ(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ, p, 𝐛, G)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiverDTI([R₁],𝐩ᵣ, 𝐛, G)
```
## Stationary Direction Receiver

### Stationary Direction Receiver with Time-Varying Beam Center

Mathematically, a **Stationary Direction Receiver** with time-varying beam center is given as follows.

$\psi(\bm{\xi},t)=r(\bm{\xi},t) \overset{t}{*} g(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{r},\bm{b}_\mathrm{r}(t)})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_Receivers_D.png)

Finally, the observed signal, $z(t)$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$z(t) = ∭ \psi(\bm{\xi},t) dS$

### Defining an Stationary Direction Receiver

we can define a  **Stationary Direction Receiver** with time-varying beam center by calling `LTIreceiverD()` with the defined reflected signal and the receiver position, $\bm{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_Receivers_Dobs.png)

```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [1.0, 0.0]  
p(t) = δ(t,1.0e-10)
𝐛(t) = [cos(2π*1.0e8*t),sin(2π*1.0e8*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceD(𝐩ₛ, p, 𝐛, G)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiverD([R₁],𝐩ᵣ, 𝐛, G)
```
