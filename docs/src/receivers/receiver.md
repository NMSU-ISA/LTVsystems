# Receivers

## LTI Omnidirectional Receiver

In order to define **LTI Omnidirectional Receiver**, first we observed the signal due to the reflection which is given by taking convolution between the reflected signal, $r(\bm{\xi},t)$ and the impulse response from the receiver located at position, $\mathbf{p}_\mathrm{r}$. Mathematically, we can define the observed signal
as follows

$\psi(\bm{\xi},t) = r(\bm{\xi},t) \overset{t}{*} g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}(\cdot)}\big).$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Psi.png)

Finally, the observed signal, $z(t)$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$z(t) = โญ \psi(\bm{\xi},t) dS$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Listeners.png)

### Defining an LTI Omnidirectional Receiver

First, we will define the reflected signal by  calling `LTIsourceO()` with a transmitted signal, $p(t)$
and the source position, $\bm{p}_\mathrm{s}$. Then
we can define a  **LTI Omnidirectional Receiver** by calling `LTIreceiverO()` with the defined reflected signal and the receiver position, $\mathbf{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_Receivers.png)
```@example
using LTVsystems
๐ฉโ =  [0.0, 0.0]
๐ฉแตฃ =  ๐ฉโ
p(t) = ฮดn(t,1.0e-10)
q = LTIsourceO(๐ฉโ, p)
ฮฑโ = 0.7; ๐โ = [1.8,0.0]
r = pointReflector(๐โ,ฮฑโ,q)
z = LTIreceiverO([r],๐ฉแตฃ)
```

## LTI Directional Receiver

An **LTI Directional Receiver** is parameterized by accounting the direction of the antenna which is defined by directional gain,

$\mathrm{D}_\mathrm{r}\left(\bm{\xi};\,\textcolor{myLightSlateGrey}
{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}}\right)= \mathrm{G}_\mathrm{r}
\left(โ [\,\mathbf{b}\,,\,\bm{\xi}-\mathbf{p}_\mathrm{r}\,]\right)$

where $โ [โ,โ]$ returns the angle between the two arguments and $\mathrm{G}_\mathrm{r}(\Theta)$
is the receiver antenna's $\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\mathbf{b}_\mathrm{r}$.

We define an **LTI Directional Receiver** by observing the signal due to the reflection given by taking convolution between the reflected signal, $r(\bm{\xi},t)$ and the impulse response from the receiver located at position, $\mathbf{p}_\mathrm{r}$.
Mathematically, we can define the observed signal as follows.


$\psi(\bm{\xi},t)=r(\bm{\xi},t) \overset{t}{*} g(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiverDTI.png)

Finally, the observed signal, $z(t)$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$z(t) = โญ \psi(\bm{\xi},t) dS$

### Defining an LTI Directional Receiver

we can define a  **LTI Directional Receiver** by calling `LTIreceiverDTI()` with the defined reflected signal and the receiver position, $\mathbf{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiversDTIobs.png)

```@example
using LTVsystems
๐ฉโ =  [0.0, 0.0]
๐ฉแตฃ =  ๐ฉโ
p(t) = ฮดn(t,1.0e-10)
๐ = [1.0,0.0]
G(ฮธ) = ๐ฉแตค(ฮธ, ฮผ=0.0, ฯ=ฯ/8)
q = LTIsourceDTI(๐ฉโ, p, ๐, G)
ฮฑโ = 0.7; ๐โ = [1.8,0.0]
r = pointReflector(๐โ,ฮฑโ,q)
z = LTIreceiverDTI([r],๐ฉแตฃ,๐,G)
```
## Stationary Direction Receiver

### Stationary Direction Receiver with Time-Varying Beam Center

Mathematically, a **Stationary Direction Receiver** with time-varying beam center is given as follows.

$\psi(\bm{\xi},t)=r(\bm{\xi},t) \overset{t}{*} g(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\mathbf{p}_\mathrm{r},\mathbf{b}_\mathrm{r}(t)})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiverD.png)

Finally, the observed signal, $z(t)$ is parameterized by considering
all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows

$z(t) = โญ \psi(\bm{\xi},t) dS$

### Defining an Stationary Direction Receiver

we can define a  **Stationary Direction Receiver** with time-varying beam center by calling `LTIreceiverD()` with the defined reflected signal and the receiver position, $\mathbf{p}_\mathrm{r}$.

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_ReceiversDobs.png)

```@example
using LTVsystems
๐ฉโ =  [0.0, 0.0]
๐ฉแตฃ =  ๐ฉโ
p(t) = ฮดn(t,1.0e-10)
๐(t) = [cos(2ฯ*1.0e8*t),sin(2ฯ*1.0e8*t)]
G(ฮธ) = ๐ฉแตค(ฮธ, ฮผ=0.0, ฯ=ฯ/8)
q = LTIsourceD(๐ฉโ, p, ๐, G)
ฮฑโ = 0.7; ๐โ = [1.8,0.0]
r = pointReflector(๐โ,ฮฑโ,q)
z = LTIreceiverD([r],๐ฉแตฃ,๐,G)
```
