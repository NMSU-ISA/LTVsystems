# Reflectors

## Ideal Point Reflectors

We define an ideal point reflectors with reflection coefficients,
$\mathsf{\alpha}_1,\mathsf{\alpha}_2,\ldots,\mathsf{\alpha}_n$ located at fixed positions, say $\bm{ξ₁},\bm{ξ₂},\ldots,\bm{ξₙ}$
as follows

$\mathsf{f}(\bm{\xi}) = \sum_{n} \mathsf{\alpha}_n \delta(\bm{\xi} - \bm{\xi}_n).$

Note that the reflection coefficients take negative values since we assume that the voltage is fixed at the reflector's end.
Mathematically, we define the reflection due to the **LTI Omnidirectional Source** as follows

$\mathsf{r}(\bm{\xi},t) = \mathsf{f}(\bm{\xi}) \mathsf{q}(\bm{\xi},t).$
![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/reflector_BD.png)
```@example
using LTVsystems
𝐩ₛ =  [0.0, 0.0]
tₚ = 1.0e-06
p(t) = δn(t-tₚ,1.0e-07)
q = LTIsourceO(𝐩ₛ, p)
α₀ = -0.7; 𝛏₀ = 𝛏₀ = [3.75e-06c,0.0]
r = pointReflector(𝛏₀,α₀,q)
```



## Continuous Reflectors as a Line Segment

We define a simple continuous reflector in term of a line segment, $AB$ of
length, $L$ as follows

$\mathsf{f}(\bm{\xi}) = \int_{0}^{L}\mathsf{\alpha}_0 \delta(\bm{\xi} - [\bm{\xi}_0+k\bm{u}]) \mathrm{d}k$

where $\mathsf{\alpha}_0$ is a reflection coefficient, $\bm{ξ₀}$ is an initial position vector,
$\bm{u}$ is an unit vector in the direction of $AB$ and $k$ is any scalar quantity.
