# Reflectors

## Ideal Point Reflectors

We define an ideal point reflectors with reflection coefficients,
$α₁,α₂,…αₙ$ located at fixed positions, say $\bm{ξ₁},\bm{ξ₂},…\bm{ξₙ}$
as follows

$f(\bm{\xi}) = \sum_{n} \alpha_n \delta(\bm{\xi} - \bm{\xi}_n).$

Mathematically, we define the reflection due to the **LTI Omnidirectional Source** as follows

$r(\bm{\xi},t) = f(\bm{\xi}) q(\bm{\xi},t).$

![](https://raw.githubusercontent.com/NMSU-ISA/LTVsystems/main/docs/src/assets/LTI_BD_primaryRef.png)

## Continuous Reflectors as a Line Segment

We define a simple continuous reflector in term of a line segment, $AB$ of
length, $L$ as follows

$f(\bm{\xi}) = \int_{0}^{L}\alpha_0 \delta(\bm{\xi} - [\bm{\xi}_0+k\bm{u}]) \mathrm{d}k$

where $α₀$ is a reflection coefficient, $\bm{ξ₀}$ is an initial position vector,
$\bm{u}$ is an unit vector in the direction of $AB$ and $k$ is any scalar quantity.
