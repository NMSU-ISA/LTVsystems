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
        "Receivers" => "receivers/receiver.md",
        "LTI Omnidirectional Modeling" => "omniDirectionalLTI/omnidirLTIsource.md",
        "Types/Methods/Functions" => "typesMethodsFunctions.md",
        "Cite" => "cite.md",
    ],
)

deploydocs(;
    repo="github.com/NMSU-ISA/LTVsystems"
)
