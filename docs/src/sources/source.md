# Sources

## LTI Omnidirectional Sources

An **LTI Omnidirectional Source**  is parameterized by taking the convolution between the transmitted signal and the impulse response from the source located at position, $\bm{p}_\mathrm{s}$. Mathematically, we can define an **LTI Omnidirectional Source** as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,{\bm{p}_\mathrm{s}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_source.png)


### Defining an LTI Omnidirectional Source
We can define an  **LTI Omnidirectional Source** by calling `LTIsourcesO()` with a transmitted signal, $p(t)$ and the source position vector, $\bm{p}_\mathrm{s}$.
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]  
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesO(𝐩ₛ, p)
```
## LTI Directional Sources

### LTI Directional Sources with Time-Invariant Beam Center

An **LTI Directional Source** with time-invariant beam center is parameterized by accounting the direction of the antenna which is defined by directional gain,

$\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{s},\bm{b}_\mathrm{s}}\right) = \mathrm{G}_\mathrm{s}
\left(\varangle[\,\bm{b}\,,\,\bm{\xi}-\bm{p}_\mathrm{s}\,]\vertOne\right)$

Mathematically, an **LTI Directional Source** with time-invariant beam center as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{s},\bm{b}_\mathrm{s}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTID_sourceTI.png)


### Defining an LTI Directional Source with Time-Invariant Beam Center
We can define an  **LTI Omnidirectional Source** by calling `LTIsourcesDTI()` with a transmitted signal, $p(t)$, the source position vector, $\bm{p}_\mathrm{s}$, time-
invariant beam center,$\bm{b}_\mathrm{s}$
and $\mathrm{G}_\mathrm{s}(\Theta)$ is the source antenna's
$\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}$.
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
𝐛 = [1.0,0.0]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesDTI(𝐩ₛ, p, 𝐛, G)
```
### LTI Directional Sources with Time-Varying Beam Center
Mathematically, an **LTI Directional Source** with time-varying beam center as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{s}},\bm{b}_\mathrm{s}(t))$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_sourceDir.png)


### Defining an LTI Directional Source with Time-Varying Beam Center
We can define an  **LTI Omnidirectional Source** by calling `LTIsourcesD()` with a transmitted signal, $p(t)$, the source position vector, $\bm{p}_\mathrm{s}$, time-
invariant beam center,$\bm{b}_\mathrm{s}$
and $\mathrm{G}_\mathrm{s}(\Theta)$ is the source antenna's
$\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}$.
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
𝐩ᵣ =  [0.0, 0.0]
𝐛(t) = [cos(2π*1.0e8*t),sin(2π*1.0e8*t)]
G(θ) = 𝒩ᵤ(θ, μ=0.0, σ=π/8)
p(t) = δ(t-1.0e-15,1.0e-10)
q = LTIsourcesD(𝐩ₛ, p, 𝐛, G)
```
