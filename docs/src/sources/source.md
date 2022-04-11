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
An **LTI Directional Source**  is parameterized by accounting the direction of the
antenna which is defined by directional gain, $\mathrm{D}_\mathrm{s}\left(\bm{\xi};\,
\textcolor{myLightSlateGrey}{\bm{p}_\mathrm{s},\bm{b}_\mathrm{s}}\right)$


### LTI Directional Sources with Time-Invariant Beam Center

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTID_sourceTI.png)

### LTI Directional Sources with Time-Varying Beam Center

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_sourceDir.png)
