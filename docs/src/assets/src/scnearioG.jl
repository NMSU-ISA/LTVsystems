path = "docs/src/assets/"

using LTVsystems
using QuadGK
using Plots

๐ฉโ =  [0.1, 0.0]
๐ฉแตฃ =  [0.6, 0.0]
p(t) = ฮดn(t,1.0e-10)
q = LTIsourceO(๐ฉโ, p)
ฮฑโ = 0.7; ๐โ = [1.2,1.0]; ๐ฎโ = [1.0,0.0]; Lโ=1.0
ฮฑโ = 0.5; ๐โ = [1.2,1.0]; ๐ฎโ = [0.0,1.0]; Lโ=1.0
ฮฑโ = 0.3; ๐โ = [2.2,1.0]; ๐ฎโ = [-1/โ2,1/โ2]; Lโ=1.35
rโ = lineSegment(๐โ,๐ฎโ,Lโ,k->ฮฑโ,[q])
rโ = lineSegment(๐โ,๐ฎโ,Lโ,k->ฮฑโ,[q])
rโ = lineSegment(๐โ,๐ฎโ,Lโ,k->ฮฑโ,[q])
z = LTIreceiverO([rโ,rโ,rโ],๐ฉแตฃ)

t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)

png(path*"scenarioG_signal.png")


scene2Dplot([q],[rโ,rโ,rโ],[z])

png(path*"scenarioG.png")

f(ฮพ::Vector{Float64})=(z((norm(ฮพ-๐ฉโ) .+norm(๐ฉแตฃ-ฮพ))./c))./(A(norm(ฮพ-๐ฉโ)./c).*A(norm(๐ฉแตฃ-ฮพ)./c))

#SPATIAL SIMULATION
inverse2Dplot([q],[rโ,rโ,rโ],[z],f)
png(path*"scenarioG_simulation.png")
