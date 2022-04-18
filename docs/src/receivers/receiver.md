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
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
α₁ = 0.7; 𝛏₁ = [1.8,0.0]
R₁ = LTIsourceO(𝛏₁, t->α₁*q(𝛏₁,t))
z = LTIreceiverO([R₁],𝐩ᵣ)
```
