# Stationary Direction Source Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $\mathbf{b}_\mathrm{s}(t)$        | vector function of time|  time-varying source beam center   |
| $\mathbf{b}_\mathrm{r}(t)$        | vector function of time|  time-varying receiver beam center  |
| $\Theta(t)$     | scalar function of time    | angle relative to time-varying beam center |
| $\mathrm{G}_\mathrm{s}(\Theta(\cdot))$   | scalar function of angle  |  Gain of the source antenna |
| $\mathrm{G}_\mathrm{r}(\Theta(\cdot))$   | scalar function of angle  |  Gain of the receiver antenna |
| $\mathrm{D}_\mathrm{s}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$   | scalar function of position |  directivity of source |
| $h\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathrm{G}_\mathrm{s}(\cdot)}\big)$       |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ |
| $\mathrm{D}_\mathrm{r}\big(\bm{\xi};\,{\mathbf{p}_\mathrm{r},\mathrm{G}_\mathrm{r}(\cdot)}\big)$   | scalar function of position |  directivity of receiver |
| $g\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r},\mathrm{G}_\mathrm{r}(\cdot)}\big)$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}$ |

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/STAT_directionSource__model.png)


The LTI impulse response from $\mathbf{p}_\mathrm{s}$ to  $\bm{\xi}$ is given by

$h(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}) = \mathrm{D}_\mathrm{s}\left(\bm{\xi};\,{\mathbf{p}_\mathrm{s},\mathbf{b}_\mathrm{s}(\cdot)}\right)
\mathrm{A}\left(\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}
{\mathrm{c}}\right) \delta\left(t-\frac{\|\bm{\xi}-\mathbf{p}_\mathrm{s}\|}{\mathrm{c}}\right).$
