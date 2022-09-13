#using Pkg
#Pkg.Registry.update()
#Pkg.develop(url="https://github.com/NMSU-ISA/ISA/src/ISA.jl")
#Pkg.develop(PackageSpec(path=pwd()))
#Pkg.instantiate()

using Documenter
using LTVsystems

makedocs(
    sitename = "LTVsystems",
    authors="Mamta Dalal, Steven Sandoval, Hasan Al-Shammari",
    format = Documenter.HTML(),
    modules = [LTVsystems],
    pages=[
        "Home" => "index.md",
        "Sources" => "sources/source.md",
        "Reflectors" => "reflectors/reflector.md",
        "Receivers" => "receivers/receiver.md",
        "LTI Omnidirectional Modeling" => "omniDirectionalLTI/omnidirLTIsource.md",
        "LTI Directional Modeling" => "directionalLTI/dirLTIsource.md",
        "LTV Modeling Doppler" => "modelingLTV Doppler/modelLTVDoppler.md",
        "LTV Omnidirectional Modeling" => "omniDirectionalLTV/omnidirLTVsource.md",
        "LTV Directional Modeling" => "directionalLTV/dirLTVsource.md",
        "Types/Methods/Functions" => "typesMethodsFunctions.md",
        "Cite" => "cite.md",
    ],
)

deploydocs(;
    repo="github.com/NMSU-ISA/LTVsystems"
)
