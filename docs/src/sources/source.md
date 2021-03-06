# Sources

## LTI Omnidirectional Source

An **LTI Omnidirectional Source**  is parameterized by taking the convolution between the transmitted signal and the impulse response from the source located at position, $\mathbf{p}_\mathrm{s}$. Mathematically, we can define an **LTI Omnidirectional Source** as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTISource_omni.png)


### Defining an LTI Omnidirectional Source
We can define an  **LTI Omnidirectional Source** by calling `LTIsourceO()` with a transmitted signal, $p(t)$ and the source position vector, $\mathbf{p}_\mathrm{s}$.
```@example
using LTVsystems
ðĐâ =  [0.0, 0.0]
p(t) = Îīn(t,1.0e-10)
q = LTIsourceO(ðĐâ, p)
```
## LTI Directional Source

An **LTI Directional Source** is parameterized by accounting the direction of the antenna which is defined by directional gain,

$\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,\textcolor{myLightSlateGrey}
{\mathbf{p}_\mathrm{s},\bm{b}_\mathrm{s}}\right)= \mathrm{G}_\mathrm{s}
\left(â [\,\bm{b}\,,\,\bm{\xi}-\mathbf{p}_\mathrm{s}\,]\right)$

where $â [â,â]$ returns the angle between the two arguments and $\mathrm{G}_\mathrm{s}(\Theta)$
is the source antenna's $\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}$.

Mathematically, an **LTI Directional Source** is given as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\mathbf{p}_\mathrm{s},\bm{b}_\mathrm{s}})$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTISource_Dir.png)


### Defining an LTI Directional Source
We can define an  **LTI Directional Source** by calling `LTIsourceDTI()` with a transmitted signal, $p(t)$, the source position vector, $\mathbf{p}_\mathrm{s}$,time-invariant beam center,
$\bm{b}_\mathrm{s}$ and
$\mathrm{G}_\mathrm{s}(\Theta)$ is the source antenna's
$\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}$.
```@example
using LTVsystems
ðĐâ =  [0.0, 0.0]
ð = [1.0,0.0]
G(Îļ) = ðĐáĩĪ(Îļ, Îž=0.0, Ï=Ï/8)
p(t) = Îīn(t,1.0e-10)
q = LTIsourceDTI(ðĐâ, p, ð, G)
```

## Stationary Direction Source

### Stationary Direction Source with Time-Varying Beam Center

Mathematically, a **Stationary Direction Source** with time-varying beam center is given as follows.

$q(\bm{\xi},t)=p(t) \overset{t}{*} h\big(\bm{\xi},t;\,
\textcolor{myLightSlateGrey}{\mathbf{p}_\mathrm{s}},\bm{b}_\mathrm{s}(t)\big)$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/StationarySource_Dir.png)


### Defining an Stationary Direction Source with Time-Varying Beam Center
We can define an  **Stationary Direction Source** with time-varying beam center by calling `LTIsourceD()` with a transmitted signal, $p(t)$, the source position vector, $\mathbf{p}_\mathrm{s}$, time-varying beam center,
$\bm{b}_\mathrm{s}(t)$
and $\mathrm{G}_\mathrm{s}(\Theta)$ is the source antenna's
$\textit{voltage gain}$ as a function of angle $\Theta$ relative to the beam center $\bm{b}_\mathrm{s}(t)$.
```@example
using LTVsystems
ðĐâ =  [0.0, 0.0]
ð(t) = [cos(2Ï*1.0e8*t),sin(2Ï*1.0e8*t)]
G(Îļ) = ðĐáĩĪ(Îļ, Îž=0.0, Ï=Ï/8)
p(t) = Îīn(t,1.0e-10)
q = LTIsourceD(ðĐâ, p, ð, G)
```
