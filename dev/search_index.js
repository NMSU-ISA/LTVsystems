var documenterSearchIndex = {"docs":
[{"location":"omniDirectionalLTI/omnidirLTIsource/#LTI-Omnidirectional-Modeling","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-A","page":"LTI Omnidirectional Modeling","title":"Scenario A","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-Assumptions","page":"LTI Omnidirectional Modeling","title":"Scenario Assumptions","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"single stationary omnidirectional source\nsingle stationary omnidirectional receiver at same location as the source\nsingle stationary ideal point reflector\nthe source emits an ideal impulse","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Forward-Modeling","page":"LTI Omnidirectional Modeling","title":"Forward Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"We can simulate the scenario and plot signal at the receiver as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.0]\r\n𝐩ᵣ =  [0.0, 0.0]  \r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nz = LTIreceiversO([R₁],𝐩ᵣ)\r\nt = collect(0.0:1.0e-10:15.5e-9)\r\nplot( t, z(t), xlab=\"time (sec)\", ylab=\"z(t)\", legend=:false)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Inverse-Modeling","page":"LTI Omnidirectional Modeling","title":"Inverse Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"Given the scenario A assumptions i.e. the position of the source,𝐩ₛ and the receiver, 𝐩ᵣ being at the same location (𝐩ₛ=𝐩ᵣ), and by providing the transmitted signal, p(t) as an ideal impulse, we obtained the received signal, z(t). Now we can estimate the reflector function as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"hatf(bmxi) = dfraczleft(frac2bmxi-bmp_mathrmrmathrmcright)\r\nmathrmA^2(fracbmxi-bmp_mathrmrmathrmc)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.0]\r\n𝐩ᵣ =  [0.0, 0.0]  \r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nz = LTIreceiversO([R₁],𝐩ᵣ)\r\na₁(ξ::Vector{Float64}) = (A(distBetween(ξ,𝐩ₛ)./lightSpeed))^2\r\nf(ξ::Vector{Float64}) = (z(2(distBetween(ξ,𝐩ₛ))./lightSpeed))./   \r\n                        (a₁(ξ::Vector{Float64}))\r\nΔpos = 0.01\r\nx_range = collect(-5:Δpos:5)\r\ny_range = collect(-4:Δpos:4)\r\nxyGrid = [[x, y] for x in x_range, y in y_range]\r\nval = [f(𝐮) for 𝐮 ∈ xyGrid]\r\np2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),\r\n         aspect_ratio=:equal,legend=false,zticks=false,title=\"ScenarioA Simulation\")\r\nscatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green,     \r\n        marker=:pentagon, label='s' )\r\nscatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 3.5,color = :blue,\r\n        marker=:square, label='r' )\r\nscatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red,  \r\n        marker=:star8, label='t')","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"For all simulated results, we displayed the sources as a green pentagon, the receivers as a blue square and the reflectors as a red star.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-B","page":"LTI Omnidirectional Modeling","title":"Scenario B","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-Assumptions-2","page":"LTI Omnidirectional Modeling","title":"Scenario Assumptions","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"single stationary omnidirectional source\nsingle stationary omnidirectional receiver\nsingle stationary ideal point reflector\nthe source emits an ideal impulse","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Forward-Modeling-2","page":"LTI Omnidirectional Modeling","title":"Forward Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"We can simulate the scenario and plot signal at the receiver as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [1.0, 0.0]\r\n𝐩ᵣ =  [-1.0, 0.0]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nz = LTIreceiversO([R₁],𝐩ᵣ)\r\nt = collect(0.0:1.0e-10:15.5e-9)\r\nplot( t, z(t), xlab=\"time (sec)\", ylab=\"z(t)\", legend=:false)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Inverse-Modeling-2","page":"LTI Omnidirectional Modeling","title":"Inverse Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"Given the scenario B assumptions i.e. the position of the source,𝐩ₛ and the receiver, 𝐩ᵣ, by providing the transmitted signal, p(t) as an ideal impulse, we obtained the received signal, z(t). Now we can estimate the reflector function as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"hatf(bmxi) = dfraczleft(fracbmp_mathrmr-bmxi+bmxi-bmp_mathrmsmathrmc  right)mathrmA(fracbmxi-bmp_mathrmsmathrmc)    \r\nmathrmA(fracbmp_mathrmr-bmximathrmc)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [1.0, 0.0]\r\n𝐩ᵣ =  [-1.0, 0.0]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nz = LTIreceiversO([R₁],𝐩ᵣ)\r\na₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)\r\nf(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))\r\nΔpos = 0.01\r\nx_range = collect(-5:Δpos:5)\r\ny_range = collect(-4:Δpos:4)\r\nxyGrid = [[x, y] for x in x_range, y in y_range]\r\nval = [f(𝐮) for 𝐮 ∈ xyGrid]\r\np2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),\r\n         legend=false,zticks=false,title=\"Scenario B Simulation\")\r\nscatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )\r\nscatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )\r\nscatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-C","page":"LTI Omnidirectional Modeling","title":"Scenario C","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-Assumptions-3","page":"LTI Omnidirectional Modeling","title":"Scenario Assumptions","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"single stationary omnidirectional source\nsingle stationary omnidirectional receiver\nmultiple stationary ideal point reflectors\nthe source emits an ideal impulse","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Forward-Modeling-3","page":"LTI Omnidirectional Modeling","title":"Forward Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"We can simulate the scenario and plot signal at the receiver as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.3, 0.3]\r\n𝐩ᵣ =  [0.9, 0.9]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [0.9,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nα₂ = 0.3; 𝛏₂ = [1.8,1.8]\r\nR₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))\r\nα₃ = 0.5; 𝛏₃ = [2.7,-0.9]\r\nR₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))\r\nz = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ)\r\nt = collect(0.0:1.0e-10:25.5e-9)\r\nplot( t, z(t), xlab=\"time (sec)\", ylab=\"z(t)\", legend=:false)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Inverse-Modeling-3","page":"LTI Omnidirectional Modeling","title":"Inverse Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"Given the scenario C assumptions i.e. the position of the source,𝐩ₛ and the receiver, 𝐩ᵣ, by providing the transmitted signal, p(t) as an ideal impulse and multiple stationary reflectors say N, we obtained the received signal, z(t). Now we can estimate the reflector function as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"hatf(bmxi) = dfraczleft(fracbmp_mathrmr-bmxi+bmxi-bmp_mathrmsmathrmc  right)mathrmA(fracbmxi-bmp_mathrmsmathrmc)    \r\nmathrmA(fracbmp_mathrmr-bmximathrmc)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.3, 0.3]\r\n𝐩ᵣ =  [0.9, 0.9]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [0.9,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nα₂ = 0.3; 𝛏₂ = [1.8,1.8]\r\nR₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))\r\nα₃ = 0.5; 𝛏₃ = [2.7,-0.9]\r\nR₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))\r\nz = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ)\r\na₀(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)\r\nf(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₀(ξ::Vector{Float64}))\r\nΔpos = 0.01\r\nx_range = collect(-5:Δpos:5)\r\ny_range = collect(-4:Δpos:4)\r\nxyGrid = [[x, y] for x in x_range, y in y_range]\r\nval = [f(𝐮) for 𝐮 ∈ xyGrid]\r\np2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),\r\n         legend=false,zticks=false,title=\"Scenario C Simulation\")\r\nscatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )\r\nscatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 5.5, color = :blue, marker=:square, label='r' )\r\nscatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red, marker=:star8, label='t')\r\nscatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red, marker=:star8, label='t')\r\nscatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red, marker=:star8, label='t')","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-D","page":"LTI Omnidirectional Modeling","title":"Scenario D","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-Assumptions-4","page":"LTI Omnidirectional Modeling","title":"Scenario Assumptions","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"single stationary omnidirectional source\nmultiple stationary omnidirectional receivers\nmultiple stationary ideal point reflectors\nthe source emits an ideal impulse","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Forward-Modeling-4","page":"LTI Omnidirectional Modeling","title":"Forward Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"We can simulate the scenario and plot signal at the receiver as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.3]\r\n𝐩ᵣ₁ =  [-0.3, 0.0]\r\n𝐩ᵣ₂ =  [0.6, 0.0]\r\n𝐩ᵣ₃ =  [1.2, 0.0]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.8; 𝛏₁ = [0.9,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nα₂ = 0.5; 𝛏₂ = [0.5,0.0]\r\nR₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))\r\nα₃ = 0.4; 𝛏₃ = [0.7,0.0]\r\nR₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))\r\nz₁ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₁)\r\nz₂ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₂)\r\nz₃ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₃)\r\nt = collect(0.0:1.0e-10:15.5e-9)\r\np1 = plot( t, z₁(t), xlab=\"time (sec)\", ylab=\"z(t)\", legend=:false)\r\nplot!(p1,t, z₂(t))\r\nplot!(p1,t, z₃(t))","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Inverse-Modeling-4","page":"LTI Omnidirectional Modeling","title":"Inverse Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"Given the scenario D assumptions i.e. the position of the source,𝐩ₛ and the multiple receivers at (𝐩ᵣ)_i where i=12N by providing the transmitted signal, p(t) as an ideal impulse and multiple stationary reflectors say N, we obtained the received signal, zᵢ(t) where i=12N. Now we can estimate the reflector function as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"hatf(bmxi) = sumlimits_i=1^Nfᵢ(bmxi)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":", where","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"fᵢ(bmxi) = dfraczᵢleft(frac(bmp_mathrmr)_i-    bmxi+bmxi-  bmp_mathrmsmathrmcright)mathrmA(fracbmxi-bmp_mathrmsmathrmc)mathrmA(frac(bmp_mathrmr)_i-bmximathrmc)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.3]\r\n𝐩ᵣ₁ =  [-0.3, 0.0]\r\n𝐩ᵣ₂ =  [0.6, 0.0]\r\n𝐩ᵣ₃ =  [1.2, 0.0]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.8; 𝛏₁ = [0.9,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nα₂ = 0.5; 𝛏₂ = [0.5,0.0]\r\nR₂ = LTIsourcesO(𝛏₂, t->α₂*q(𝛏₂,t))\r\nα₃ = 0.4; 𝛏₃ = [0.7,0.0]\r\nR₃ = LTIsourcesO(𝛏₃, t->α₃*q(𝛏₃,t))\r\nz₁ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₁)\r\nz₂ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₂)\r\nz₃ = LTIreceiversO([R₁,R₂,R₃],𝐩ᵣ₃)\r\na₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₁,ξ)./lightSpeed)\r\na₂(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₂,ξ)./lightSpeed)\r\na₃(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ₃,ξ)./lightSpeed)\r\nf₁(ξ::Vector{Float64})=(z₁((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₁,ξ)). lightSpeed))./(a₁(ξ::Vector{Float64}))\r\nf₂(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₂,ξ))./lightSpeed))./(a₂(ξ::Vector{Float64}))\r\nf₃(ξ::Vector{Float64})=(z₂((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ₃,ξ))./lightSpeed))./(a₃(ξ::Vector{Float64}))\r\nf(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).+f₂(ξ::Vector{Float64}).+\r\nf₃(ξ::Vector{Float64})\r\nΔpos = 0.01\r\nx_range = collect(-3:Δpos:3)\r\ny_range = collect(-2:Δpos:2)\r\nxyGrid = [[x, y] for x in x_range, y in y_range]\r\nval = [f(𝐮) for 𝐮 ∈ xyGrid]\r\np2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),\r\n         legend=false,zticks=false,title=\"Scenario D Simulation\")\r\nscatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green,\r\n        marker=:pentagon, label='s')\r\nscatter!(p2,[𝐩ᵣ₁[1]], [𝐩ᵣ₁[2]],markersize = 5.5,color = :blue,\r\n        marker=:square, label='r')\r\nscatter!(p2,[𝐩ᵣ₂[1]], [𝐩ᵣ₂[2]],markersize = 5.5,color = :blue,\r\n        marker=:square, label='r')\r\nscatter!(p2,[𝐩ᵣ₃[1]], [𝐩ᵣ₃[2]],markersize = 5.5,color = :blue,\r\n        marker=:square, label='r')\r\nscatter!(p2,[𝛏₁[1]],[𝛏₁[2]],markersize = 8.5,color = :red,\r\n        marker=:star8, label='t')\r\nscatter!(p2,[𝛏₂[1]],[𝛏₂[2]],markersize = 8.5,color = :red,\r\n        marker=:star8, label='t')\r\nscatter!(p2,[𝛏₃[1]],[𝛏₃[2]],markersize = 8.5,color = :red,\r\n        marker=:star8, label='t')\r\nf_new(ξ::Vector{Float64})=f₁(ξ::Vector{Float64}).*f₂(ξ::Vector{Float64}).*\r\nf₃(ξ::Vector{Float64})\r\nval1 = [f_new(𝐮) for 𝐮 ∈ xyGrid]\r\np3 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),\r\n       legend=false,zticks=false,title=\"Scenario D reflector Estimation\")","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-E","page":"LTI Omnidirectional Modeling","title":"Scenario E","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Scenario-Assumptions-5","page":"LTI Omnidirectional Modeling","title":"Scenario Assumptions","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"single stationary omnidirectional source\nsingle stationary omnidirectional receiver\na continuous reflector\nthe source emits an ideal impulse","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Forward-Modeling-5","page":"LTI Omnidirectional Modeling","title":"Forward Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"We can simulate the scenario and plot signal at the receiver as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing QuadGK\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.3]\r\n𝐩ᵣ =  [-0.3, 0.0]\r\nξ₀=[0.1,0.0]\r\nα₀ = 0.7;\r\nL = collect(range(1, 2.0, step=0.01))\r\ng(k) = ξ₀ .+ k.*[1.0,0.0]\r\ntemp = quadgk.(g, 0.0, L)\r\nvalue = [α₀*(temp[i][1]) for i in 1:length(L)]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nW = []\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nfor i in 1:length(value)\r\n    R₁ = LTIsourcesO(value[i], t->q(value[i],t))\r\n    push!(W,R₁)\r\nend\r\nz = LTIreceiversO(W,𝐩ᵣ)\r\nt = collect(0.0:1.0e-10:15.5e-9)\r\np1 = plot( t, z(t), xlab=\"time (sec)\", ylab=\"z(t)\", legend=:false)\r\ndisplay(p1)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/#Inverse-Modeling-5","page":"LTI Omnidirectional Modeling","title":"Inverse Modeling","text":"","category":"section"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"Given the scenario E assumptions i.e. the position of the source,𝐩ₛ and the receivers at 𝐩ᵣ by providing the transmitted signal, p(t) as an ideal impulse and a continuous reflector we obtained the received signal, z(t). Now we can estimate the reflector function as follows.","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"f(bmxi) = dfraczleft(fracbmp_mathrmr-   \r\nalpha_0int_0^L(bmxi+kbmu)dk+\r\nalpha_0int_0^L(bmxi+kbmu)dk- bmp_mathrmsmathrmcright)\r\nmathrmA(fracalpha_0int_0^L(bmxi+kbmu) dk-bmp_mathrmsmathrmc)\r\nmathrmA(fracbmp_mathrmr-alpha_0int_0^L(bmxi+kbmu) dkmathrmc)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"using ISA, LTVsystems\r\nusing QuadGK\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.3]\r\n𝐩ᵣ =  [-0.3, 0.0]\r\nξ₀=[0.1,0.0]\r\nα₀ = 0.7;\r\nL = collect(0.0:0.1:1.0)\r\ng(k) = ξ₀ .+ k.*[1.0,0.0]\r\ntemp = quadgk.(g, 0.0, L)\r\nvalue = [α₀*(temp[i][1]) for i in 1:length(L)]\r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nW = []\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nfor i in 1:length(value)\r\n    R₁ = LTIsourcesO(value[i], t->q(value[i],t))\r\n    push!(W,R₁)\r\nend\r\nz = LTIreceiversO(W,𝐩ᵣ)\r\na₁(ξ::Vector{Float64}) = A(distBetween(ξ,𝐩ₛ)./lightSpeed).*A(distBetween(𝐩ᵣ,ξ)./lightSpeed)\r\nf(ξ::Vector{Float64})=(z((distBetween(ξ,𝐩ₛ) .+ distBetween(𝐩ᵣ,ξ))./lightSpeed))./(a₁(ξ::Vector{Float64}))\r\nΔpos = 0.01\r\nx_range = collect(-3:Δpos:3)\r\ny_range = collect(-2:Δpos:2)\r\nxyGrid = [[x, y] for x in x_range, y in y_range]\r\nval = [f(𝐮) for 𝐮 ∈ xyGrid]\r\np2=plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),\r\n       aspect_ratio=:equal,legend=false,zticks=false,title=\"Scenario E Simulation\")\r\nscatter!(p2,[𝐩ₛ[1]], [𝐩ₛ[2]],markersize = 8.5,color = :green,\r\n         marker=:pentagon, label='s' )\r\nscatter!(p2,[𝐩ᵣ[1]], [𝐩ᵣ[2]],markersize = 8.5,color = :blue,\r\n         marker=:square, label='r' )\r\nfor i in 1:length(value)\r\nscatter!(p2,[value[i][1]],[value[i][2]],markersize = 8.5,color = :red,\r\n         marker=:star8, label='t')\r\nend\r\ndisplay(p2)","category":"page"},{"location":"omniDirectionalLTI/omnidirLTIsource/","page":"LTI Omnidirectional Modeling","title":"LTI Omnidirectional Modeling","text":"(Image: )","category":"page"},{"location":"typesMethodsFunctions/#Types/Methods/Functions","page":"Types/Methods/Functions","title":"Types/Methods/Functions","text":"","category":"section"},{"location":"typesMethodsFunctions/#Index","page":"Types/Methods/Functions","title":"Index","text":"","category":"section"},{"location":"typesMethodsFunctions/","page":"Types/Methods/Functions","title":"Types/Methods/Functions","text":"","category":"page"},{"location":"typesMethodsFunctions/#Public-Interface","page":"Types/Methods/Functions","title":"Public Interface","text":"","category":"section"},{"location":"typesMethodsFunctions/","page":"Types/Methods/Functions","title":"Types/Methods/Functions","text":"Modules = [LTVsystems]","category":"page"},{"location":"typesMethodsFunctions/#LTVsystems.LTIreceiversO","page":"Types/Methods/Functions","title":"LTVsystems.LTIreceiversO","text":"z = LTIreceiversO([R₁,R₂,…Rₙ],𝐩ᵣ)\n\nCreate an LTI Omnidirectional Receiver by calling LTIreceiversO() with the receiver position, 𝐩ᵣ and all the reflections, Rᵢ where i=1,2,…n.\n\nExamples\n\nusing ISA, LTVsystems\nusing Plots\n𝐩ₛ =  [0.0, 0.0]\n𝐩ᵣ =  [1.0, 0.0]\np(t) = δ(t-1.0e-15,1.0e-10)\nq = LTIsourcesO(𝐩ₛ, p)\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\nz = LTIreceiversO([R₁],𝐩ᵣ)\n\n\n\n\n\n","category":"type"},{"location":"typesMethodsFunctions/#LTVsystems.LTIsourcesO","page":"Types/Methods/Functions","title":"LTVsystems.LTIsourcesO","text":"q = LTIsourcesO(𝐩ₛ, p)\nR = LTIsourcesO(𝛏, r)\n\nCreate an LTI Omnidirectional Source by calling LTIsourcesO() with the source position, 𝐩ₛ and the transmisson signal, p.\n\nExamples\n\nusing ISA, LTVsystems\nusing Plots\n𝐩ₛ =  [0.0, 0.0]\n𝐩ᵣ =  [0.0, 0.0]\np(t) = δ(t-1.0e-15,1.0e-10)\nq = LTIsourcesO(𝐩ₛ, p)\n\nAnother type of sources, called as reflected sources can also be defined by calling LTIsourcesO() with reflectors position, 𝛏 and the reflected signal, given by r = α q(𝛏,t).\n\nExamples\n\nusing ISA, LTVsystems\nusing Plots\n𝐩ₛ =  [0.0, 0.0]\n𝐩ᵣ =  [0.0, 0.0]\np(t) = δ(t-1.0e-15,1.0e-10)\nq = LTIsourcesO(𝐩ₛ, p)\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\n\n\n\n\n\n","category":"type"},{"location":"reflectors/reflector/#Reflectors","page":"Reflectors","title":"Reflectors","text":"","category":"section"},{"location":"reflectors/reflector/#Ideal-Point-Reflectors","page":"Reflectors","title":"Ideal Point Reflectors","text":"","category":"section"},{"location":"reflectors/reflector/","page":"Reflectors","title":"Reflectors","text":"We can define an ideal point reflectors with reflection coefficients, α₁α₂αₙ located at fixed positions, say bmξ₁bmξ₂bmξₙ as follows","category":"page"},{"location":"reflectors/reflector/","page":"Reflectors","title":"Reflectors","text":"f(bmxi) = sum_n alpha_n delta(bmxi - bmxi_n)","category":"page"},{"location":"reflectors/reflector/#Continuous-Reflectors-as-a-Line-Segment","page":"Reflectors","title":"Continuous Reflectors as a Line Segment","text":"","category":"section"},{"location":"reflectors/reflector/","page":"Reflectors","title":"Reflectors","text":"We can define a simple continuous reflector in term of a line segment, AB of length, L as follows","category":"page"},{"location":"reflectors/reflector/","page":"Reflectors","title":"Reflectors","text":"f(bmxi) = int_0^Lalpha_0 delta(bmxi - bmxi_0+kbmu) dk","category":"page"},{"location":"reflectors/reflector/","page":"Reflectors","title":"Reflectors","text":"where α₀ is a reflection coefficient, bmξ₀ is an initial position vector, bmu is an unit vector in the direction of AB and k is any scalar quantity.","category":"page"},{"location":"sources/source/#Sources","page":"Sources","title":"Sources","text":"","category":"section"},{"location":"sources/source/#LTI-Omnidirectional-Sources","page":"Sources","title":"LTI Omnidirectional Sources","text":"","category":"section"},{"location":"sources/source/","page":"Sources","title":"Sources","text":"An LTI Omnidirectional Source  is parameterized by taking the convolution between the transmitted signal and the impulse response from the source located at position, bmp_mathrms. Mathematically, we can define an LTI Omnidirectional Source as follows.","category":"page"},{"location":"sources/source/","page":"Sources","title":"Sources","text":"q(bmxit)=p(t) oversett* h(bmxitbmp_mathrms)","category":"page"},{"location":"sources/source/","page":"Sources","title":"Sources","text":"(Image: )","category":"page"},{"location":"sources/source/#Defining-an-LTI-Omnidirectional-Source","page":"Sources","title":"Defining an LTI Omnidirectional Source","text":"","category":"section"},{"location":"sources/source/","page":"Sources","title":"Sources","text":"We can define an  LTI Omnidirectional Source by calling LTIsourcesO() with a transmitted signal, p(t) and the source position vector, bmp_mathrms.","category":"page"},{"location":"sources/source/","page":"Sources","title":"Sources","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.0]\r\n𝐩ᵣ =  [0.0, 0.0]  \r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)","category":"page"},{"location":"cite/#Cite","page":"Cite","title":"Cite","text":"","category":"section"},{"location":"cite/","page":"Cite","title":"Cite","text":"If you use this software in you research, please cite the following works.","category":"page"},{"location":"receivers/receiver/#Receivers","page":"Receivers","title":"Receivers","text":"","category":"section"},{"location":"receivers/receiver/#LTI-Omnidirectional-Receivers","page":"Receivers","title":"LTI Omnidirectional Receivers","text":"","category":"section"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"In order to define LTI Omnidirectional Receivers, first we need to observe the primary reflections due to the LTI Omnidirectional Sources. Mathematically, we can define the reflection due to the sources as follows","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"r(bmxit) = f(bmxi) q(bmxit)","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"(Image: )","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"Now the signal observed by the receiver due to the reflection is given by taking convolution between the reflected signal, r(bmxit) and the impulse response from the receiver located at position, bmp_mathrmr. Mathematically, we can define the observed signal as follows","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"psi(bmxit) = r(bmxit) oversett* g(bmxitbmp_mathrmr(cdot))","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"(Image: )","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"Finally, the observed signal, z(t) is parameterized by considering all the reflections at the receiver location. Mathematically, we can given the expression for the final observed signal as follows","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"z(t) =  psi(bmxit) dS","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"(Image: )","category":"page"},{"location":"receivers/receiver/#Defining-an-LTI-Omnidirectional-Receiver","page":"Receivers","title":"Defining an LTI Omnidirectional Receiver","text":"","category":"section"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"First, we will define the reflected signal by  calling LTIsourcesO() with a transmitted signal, p(t) and the source position, bmp_mathrms. Then we can define a  LTI Omnidirectional Receiver by calling LTIreceiversO() with the defined reflected signal and the receiver position, bmp_mathrmr.","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"(Image: )","category":"page"},{"location":"receivers/receiver/","page":"Receivers","title":"Receivers","text":"using ISA, LTVsystems\r\nusing Plots\r\n𝐩ₛ =  [0.0, 0.0]\r\n𝐩ᵣ =  [1.0, 0.0]  \r\np(t) = δ(t-1.0e-15,1.0e-10)\r\nq = LTIsourcesO(𝐩ₛ, p)\r\nα₁ = 0.7; 𝛏₁ = [1.8,0.0]\r\nR₁ = LTIsourcesO(𝛏₁, t->α₁*q(𝛏₁,t))\r\nz = LTIreceiversO([R₁],𝐩ᵣ)","category":"page"},{"location":"#LTVsystems","page":"Home","title":"LTVsystems","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for LTVsystems","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"#Users","page":"Home","title":"Users","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Download Julia v1.6.4 or later, if you haven't already.\nAdd the LTVsystems module entering the following at the REPL ]add https://github.com/NMSU-ISA/LTVsystems.","category":"page"},{"location":"#Student-Developers","page":"Home","title":"Student Developers","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Clone the LTVsystems module to username/.julia/dev/.\nEnter the package manager in REPL by pressing ]  then add the package by typing dev LTVsystems rather than add LTVsystems.","category":"page"},{"location":"#Table-of-Contents","page":"Home","title":"Table of Contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\"sources/source.md\",\n         \"reflectors/reflector.md\",\n         \"receivers/receiver.md\",\n         \"omniDirectionalLTI/omnidirLTIsource.md\",\n         \"typesMethodsFunctions.md\",\n         \"cite.md\"]","category":"page"}]
}
