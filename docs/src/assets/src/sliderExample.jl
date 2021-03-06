using LTVsystems
using Plots
using Interact

mp = @manipulate for loc1 in slider(-1.0:0.1:1.0; label="S slider"), loc2 in slider(-1.0:0.1:1.0; label="R slider"),
    loc3 in slider(0.1:0.1:2.0; label="T slider"), loc4 in slider(0.1:0.1:2.0; label="Coef slider")
#Source
๐ฉโ =  [1.0, 0.0]
๐ฉโ =@. transpose(loc1.*๐ฉโ)
# Transmitter's signal i.e single pulse
p(t) = ฮดn(t,1.0e-10)
# Signal observed due to source
q = LTIsourceO(๐ฉโ, p)
#Reflectors
ฮฑโ = 3.0; ๐โ = [1.2,0.0]; ๐ฎ = [1.0,0.0]; L=1.0
ฮฑโ =@. transpose(loc4.*ฮฑโ)
๐โ = @. transpose(loc3.*๐โ)
r = lineSegment(๐โ,๐ฎ,L,k->ฮฑโ,[q])
ฮฑโ = 1.0; ๐โ = [1.2,0.0]
ฮฑโ =@. transpose(loc4.*ฮฑโ)
#๐โ = @. transpose(loc3.*๐โ)
Rโ = pointReflector(๐โ,ฮฑโ,[q])
# Observed signal
๐ฉแตฃ =  [1.0, 0.0]
๐ฉแตฃ = @. transpose(loc2.*๐ฉแตฃ)
z = LTIreceiverO([Rโ,r],๐ฉแตฃ)
#TEMPORAL SIMULATION
t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
end
#png(path*"scenarioB_signal.png")

#-----------------------------------------------------------------
# Estimator function

#f(ฮพ::Vector{Float64})=(z((norm(ฮพ-๐ฉโ) .+ norm(๐ฉแตฃ-ฮพ))./c))./(A(norm(ฮพ-๐ฉโ)./c).*A(norm(๐ฉแตฃ-ฮพ)./c))

#inverse2Dplot([q],[Rโ,r],[z],f)
#end
#SPATIAL SIMULATION
#ฮpos = 0.01
#x_range = collect(-2:ฮpos:2)
#y_range = collect(-2:ฮpos:2)
#xyGrid = [[x, y] for x in x_range, y in y_range]
#val = [f(๐ฎ) for ๐ฎ โ xyGrid]

#p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,zticks=false,title="Scenario B Simulation")
#    scatter!(p2,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
#    scatter!(p2,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 5.5,color = :blue, marker=:square, label='r' )
#    scatter!(p2,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
#end
