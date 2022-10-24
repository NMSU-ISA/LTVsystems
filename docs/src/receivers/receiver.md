# Receivers

## LTI Omnidirectional Receiver

In order to define **LTI Omnidirectional Receiver**, first we observed the signal due to the reflection which is given by taking convolution between the reflected signal, $\mathsf{r(\bm{\xi},t)}$ and the impulse response from the receiver located at position, $\mathbf{p}_\mathrm{r}$. Mathematically, we can define the observed signal
as follows

$\mathsf{\psi(\bm{\xi},t)} = \mathsf{r(\bm{\xi},t)} \overset{t}{*} \mathsf{g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}(\cdot)}\big)}.$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Psi.png)

Finally, the observed signal, $\mathsf{z(t)}$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$\mathsf{z(t)} = ∭ \mathsf{\psi(\bm{\xi},t)} dS$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Listeners.png)

### Defining an LTI Omnidirectional Receiver

First, we will define the reflected signal by  calling `LTIsourceO()` with a transmitted signal, $\mathsf{p(t)}$
and the source position, $\mathbf{p}_\mathrm{s}$. Then
we can define a  **LTI Omnidirectional Receiver** by calling `LTIreceiverO()` with the defined reflected signal and the receiver position, $\mathbf{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Receivers.png)
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverO([r],𝐩ᵣ)
```

## LTI Directional Receiver

An **LTI Directional Receiver** is parameterized by accounting the direction of the antenna which is defined by directional gain,

$\mathrm{D}_\mathrm{r}\left(\bm{\xi};\,\textcolor{myLightSlateGrey}
{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\right)= \mathrm{G}_\mathrm{r}
\left(∠[\,\mathbf{b}\,,\,\bm{\xi}-\mathbf{p}_\mathrm{r}\,]\right)$

where $∠[⋅,⋅]$ returns the angle between the two arguments and $\mathrm{G}_\mathrm{r}(\Theta)$
is the receiver antenna's $\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\mathbf{b}_\mathrm{r}$.

We define an **LTI Directional Receiver** by observing the signal due to the reflection given by taking convolution between the reflected signal, $\mathsf{r(\bm{\xi},t)}$ and the impulse response from the receiver located at position, $\mathbf{p}_\mathrm{r}$.
Mathematically, we can define the observed signal as follows.


$\mathsf{\psi(\bm{\xi},t)}=\mathsf{r(\bm{\xi},t)} \overset{t}{*} \mathsf{g(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}})}$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiverDTI.png)

Finally, the observed signal, $\mathsf{z(t)}$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$\mathsf{z(t)} = ∭ \mathsf{\psi(\bm{\xi},t)} dS$

### Defining an LTI Directional Receiver

we can define a  **LTI Directional Receiver** by calling `LTIreceiverDTI()` with the defined reflected signal and the receiver position, $\mathbf{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiversDTIobs.png)

```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = LTIsourceDTI(𝐩ₛ, p, 𝐛, G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = LTIreceiverDTI([r],𝐩ᵣ,𝐛,G)
```
## Stationary Directional Receiver

### Stationary Directional Receiver with Time-Varying Beam Center

Mathematically, a **Stationary Directional Receiver** with time-varying beam center is given as follows.

$\mathsf{\psi(\bm{\xi},t)}=\mathsf{r(\bm{\xi},t)} \overset{t}{*} \mathsf{g(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}(t)})}$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiverD.png)

Finally, the observed signal, $\mathsf{z(t)}$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$\mathsf{z(t)} = ∭ \mathsf{\psi(\bm{\xi},t)} dS$

### Defining an Stationary Directional Receiver

we can define a  **Stationary Directional Receiver** with time-varying beam center by calling `STATreceiverD()` with the defined reflected signal and the receiver position, $\mathbf{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiversDobs.png)

```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  𝐩ₛ
p(t) = δn(t,1.0e-10)
𝐛(t) = [cos(2π*10*t),0.0]/(norm(cos(2π*10*t)))
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
q = STATsourceD(𝐩ₛ, p, 𝐛, G)
α₀ = 0.7; 𝛏₀ = [1.8,0.0]
r = pointReflector(𝛏₀,α₀,q)
z = STATreceiverD([r],𝐩ᵣ,𝐛,G)
```
