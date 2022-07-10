# LTI Directional Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $\bm{b}_\mathrm{s}$               | vector|  source beam center   |
| $\bm{b}_\mathrm{r}$               | vector|  receiver beam center   |
| $\Theta$     | scalar           | angle relative to beam center |
| $\mathrm{G}_\mathrm{s}(\Theta)$   | scalar function of angle  |  Gain of the source antenna |
| $\mathrm{G}_\mathrm{r}(\Theta)$   | scalar function of angle  |  Gain of the receiver antenna |
| $\mathrm{D}_\mathrm{s}(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(.)})$   | scalar function of position |  directivity of source |
| $h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(.)})$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $\mathrm{D}_\mathrm{r}(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathrm{G}_\mathrm{r}(.)})$   | scalar function of position |  directivity of receiver |
| $g(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r},\mathrm{G}_\mathrm{r}(.)})$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |



![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_model__directional.png)


The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\bm{b}_\mathrm{s}}) = \mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\bm{b}_\mathrm{s}}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$


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
