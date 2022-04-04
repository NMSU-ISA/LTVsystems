using Documenter
using LTVsystems

makedocs(
    sitename = "LTVsystems",
    format = Documenter.HTML(),
    modules = [LTVsystems],
    pages=[
        "Home" => "index.md",
        ]
)

deploydocs(;
    repo="github.com/NMSU-ISA/LTVsystems"
)
