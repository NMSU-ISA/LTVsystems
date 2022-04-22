using Pkg
Pkg.Registry.update()
Pkg.develop(url="https://github.com/NMSU-ISA/ISA")
Pkg.develop(PackageSpec(path=pwd())) # I'm assuming we are in the SHbundle directory
Pkg.instantiate()

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
        "Types/Methods/Functions" => "typesMethodsFunctions.md",
        "Cite" => "cite.md",
    ],
)

deploydocs(;
    repo="github.com/NMSU-ISA/LTVsystems"
)
