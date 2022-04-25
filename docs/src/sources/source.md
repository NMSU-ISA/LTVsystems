# Sources

## LTI Omnidirectional Source

An **LTI Omnidirectional Source**  is parameterized by taking the convolution between the transmitted signal and the impulse response from the source located at position, $\bm{p}_\mathrm{s}$. Mathematically, we can define an **LTI Omnidirectional Source** as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,{\bm{p}_\mathrm{s}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_source.png)


### Defining an LTI Omnidirectional Source
We can define an  **LTI Omnidirectional Source** by calling `LTIsourceO()` with a transmitted signal, $p(t)$ and the source position vector, $\bm{p}_\mathrm{s}$.
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
p(t) = δ(t,1.0e-10)
q = LTIsourceO(𝐩ₛ, p)
```
## LTI Directional Source

An **LTI Directional Source** is parameterized by accounting the direction of the antenna which is defined by directional gain,

$\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,\textcolor{myLightSlateGrey}
{\bm{p}_\mathrm{s},\bm{b}_\mathrm{s}}\right)= \mathrm{G}_\mathrm{s}
\left(∠[\,\bm{b}\,,\,\bm{\xi}-\bm{p}_\mathrm{s}\,]\right)$

where $∠[⋅,⋅]$ returns the angle between the two arguments and $\mathrm{G}_\mathrm{s}(\Theta)$
is the source antenna's $\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}$.

Mathematically, an **LTI Directional Source** is given as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{s},\bm{b}_\mathrm{s}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTIsource_DTI.png)


### Defining an LTI Directional Source
We can define an  **LTI Directional Source** by calling `LTIsourceDTI()` with a transmitted signal, $p(t)$, the source position vector, $\bm{p}_\mathrm{s}$,time-invariant beam center,
$\bm{b}_\mathrm{s}$ and
$\mathrm{G}_\mathrm{s}(\Theta)$ is the source antenna's
$\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}$.
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
p(t) = δ(t,1.0e-10)
q = LTIsourceDTI(𝐩ₛ, p, 𝐛, G)
```

## Stationary Direction Source

### Stationary Direction Source with Time-Varying Beam Center

Mathematically, a **Stationary Direction Source** with time-varying beam center is given as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h\big(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{s}},\bm{b}_\mathrm{s}(t)\big)$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTIsource_D.png)


### Defining an Stationary Direction Source with Time-Varying Beam Center
We can define an  **Stationary Direction Source** with time-varying beam center by calling `LTIsourceD()` with a transmitted signal, $p(t)$, the source position vector, $\bm{p}_\mathrm{s}$, time-varying beam center,
$\bm{b}_\mathrm{s}(t)$
and $\mathrm{G}_\mathrm{s}(\Theta)$ is the source antenna's
$\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}(t)$.
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐛(t) = [cos(2π*1.0e8*t),sin(2π*1.0e8*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
p(t) = δ(t,1.0e-10)
q = LTIsourceD(𝐩ₛ, p, 𝐛, G)
```