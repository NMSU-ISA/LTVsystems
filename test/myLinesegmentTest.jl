using LTVsystems, QuadGK
๐ฉโ =  [0.0, 0.0]
๐ฉแตฃ =  ๐ฉโ
p(t) = ฮดn(t,1.0e-10)
q = LTIsourceO(๐ฉโ, p)
ฮฑโ = 0.7; ๐โ = [1.8,2.0]; ๐ฎ = [1.0,0.0]; L=1.0
r = lineSegment(๐โ,๐ฎ,L,k->ฮฑโ,[q])
z = LTIreceiverO([r],๐ฉแตฃ)
t = 0.0:1.0e-10:25.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
f(๐::Vector{Float64}) = z(2(norm(๐-๐ฉโ))./c)./(A(norm(๐-๐ฉโ)./c))^2
inverse2Dplot([q],[r],[z],f)
