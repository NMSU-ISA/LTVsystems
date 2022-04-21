# LTI Directional Modeling

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_directmodel.png)

## Scenario A

### Scenario Assumptions

  * single LTI directional source
  * single LTI directional receiver at same location as the source
  * single stationary ideal point reflector
  * the source emits an impulse

### Forward Modeling

Given the scenario A assumptions with the position of the source $𝐩ₛ$, the receiver $𝐩ᵣ$ being at the same location $(𝐩ₛ=𝐩ᵣ)$, by providing the transmitted signal $p(t)$ as an ideal impulse, and an ideal point reflector $\bm{\xi}_0$. We obtained the closed form expression of the observed signal, $z(t)$ as follows.

$z(t) = \alpha_0 \mathrm{A}^2
\left(\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}
{\mathrm{c}}\right)\mathrm{D}^2_\mathrm{r}\left(\bm{\xi_0};\,\textcolor{myLightSlateGrey}
{\bm{p}_\mathrm{r},\bm{b}_\mathrm{r}}\right)
p\left(t -2\frac{\|\bm{p}_\mathrm{r}-\bm{\xi}_0\|}{\mathrm{c}}\right)$

Now we can simulate the scenario and plot signal at the receiver as follows.
