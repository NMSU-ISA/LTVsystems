# LTV Omnidirectional Modeling

| Symbol     | Type       | Description |
| :---------- | :----------: | :----------- |
| $t$                     | scalar variable |  time   |
| $\bm{\xi}$              | vector variable |  position   |
| $\mathbf{p}_\mathrm{s}(t)$     | vector function of time    | position of source |
| $\mathbf{p}_\mathrm{r}(t)$     | vector function of time    | position of receiver |
| $h_τ\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{s}(\cdot)}\big)$  |  scalar function of position and time  | LTI impulse response from    $\mathbf{p}_\mathrm{s}(t)$ to  $\bm{\xi}$ |
| $g_τ\big(\bm{\xi},t;\,{\mathbf{p}_\mathrm{r}(\cdot)}\big)$  |  scalar function of position and time  | LTI impulse response from    $\bm{\xi}$ to $\mathbf{p}_\mathrm{r}(t)$ |

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTV_BD_omnimodel.png)
