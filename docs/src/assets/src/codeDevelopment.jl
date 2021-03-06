# Animation
using LTVsystems
using QuadGK
using Plots
๐ฉโ =  [0.0, 0.3]
๐ฉแตฃ =  [0.0, 0.3]
p(t) = ฮดn(t,1.0e-10)# emittied signal
q = LTIsourceO(๐ฉโ, p)#observed signal--1st video at ps location
#Reflectors
ฮฑโ = 0.7; ๐โ = [1.8,0.0]
Rโ = pointReflector(๐โ,ฮฑโ,[q])# primary reflections--2nd video
z = LTIreceiverO([Rโ],๐ฉแตฃ)# final signal observed at pr
ฮpos = 0.01
x_range = collect(-2:ฮpos:2)
y_range = collect(-2:ฮpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]


allPlots = []
tโ1 = collect(0.0:0.2e-9:4.5e-9)
tโ2 = collect(4.6e-9:0.2e-9:6.5e-9)

for tโ โ 0.0:0.2e-9:4.5e-9,
val1 = [q(๐ฎ,tโ) for ๐ฎ โ xyGrid]
#val2 = [Rโ(๐ฎ,0.1) for ๐ฎ โ xyGrid]
p11 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
p12 = plot!(p11,x_range,y_range,transpose(val2))
scatter!(p12,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p12,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
scatter!(p12,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
frame = plot(p12, size = (600, 600) )
    push!(allPlots, frame)
anim = @animate for i โ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA.gif", fps = 30)

for tโ1 โ 4.5e-9:0.2e-9:6.5e-9
    val1 = [Rโ(๐ฎ,tโ1) for ๐ฎ โ xyGrid]
    p11 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    #p12 = plot!(p11,x_range,y_range,transpose(val2))
    scatter!(p11,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p11,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p11,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p11, size = (600, 600) )
    push!(allPlots, frame)
 end
anim = @animate for i โ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA_reflector.gif", fps = 30)











t = 0.0:1.0e-10:15.5e-9
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)


ฮpos = 0.01
x_range = collect(-3:ฮpos:3)
y_range = collect(-2:ฮpos:2)
xyGrid = [[x, y] for x in x_range, y in y_range]
allPlots = []
#Q1 = q(๐ฎ,tโ1)
#R1 = Rโ(๐ฎ,tโ1)
for tโ1 โ 0.0:0.2e-9:4.5e-9
    val1 = [q(๐ฎ,tโ1) for ๐ฎ โ xyGrid]
    p11 = plot(x_range,y_range,transpose(val1),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    #p12 = plot!(p11,x_range,y_range,transpose(val2))
    scatter!(p11,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p11,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p11,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p11, size = (600, 600) )
    push!(allPlots, frame)
 end
anim = @animate for i โ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA_source.gif", fps = 30)

for tโ2 = 6.5e-9:0.2e-9:13.0e-9
    val2 = [Rโ(๐ฎ,tโ2) for ๐ฎ โ xyGrid]
    p12 = plot(x_range,y_range,transpose(val2),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    scatter!(p12,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p12,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p12,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p12, size = (600, 600) )
    push!(allPlots, frame)
 end
anim = @animate for i โ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA_receiver.gif", fps = 30)


# Observed signal
z = LTIreceiverO([Rโ],๐ฉแตฃ)
#TEMPORAL SIMULATION
t = collect(0.0:1.0e-10:15.5e-9)
plot( t, z(t), xlab="time (sec)", ylab="z(t)", legend=:false)
# Estimator function
aโ(ฮพ::Vector{Float64}) = (A(distBetween(ฮพ,๐ฉโ)./lightSpeed))^2
f(ฮพ::Vector{Float64})=(z(2(distBetween(ฮพ,๐ฉโ))./lightSpeed))./(aโ(ฮพ::Vector{Float64}))

#SPATIAL SIMULATION
tโ1 = 3.5e-9
ฮpos = 0.01
x_range = collect(-5:ฮpos:5)
y_range = collect(-4:ฮpos:4)
xyGrid = [[x, y] for x in x_range, y in y_range]

allPlots = []
#Q1 = q(๐ฎ,tโ1)
#R1 = Rโ(๐ฎ,tโ1)
for tโ1 โ 0.0:0.2e-9:5e-5
    val = [f((๐ฎ).- q(๐ฎ,tโ1).-Rโ(๐ฎ,tโ1)) for ๐ฎ โ xyGrid]
    p11 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),legend=false,clims=(-1,1),aspect_ratio=:equal,xticks=:false,yticks=:false,zticks=:false)
    scatter!(p11,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
    scatter!(p11,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
    scatter!(p11,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
    frame = plot(p11, size = (600, 600) )
    push!(allPlots, frame)
end
anim = @animate for i โ 1:length(allPlots)
    plot(allPlots[i])
end
gif(anim, "scenarioA.gif", fps = 30)

val = [f(๐ฎ) for ๐ฎ โ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),aspect_ratio=:equal,legend=false,zticks=false,title="Scenario A Simulation")
scatter!(p2,[๐ฉโ[1]], [๐ฉโ[2]],markersize = 8.5,color = :green, marker=:pentagon, label='s' )
scatter!(p2,[๐ฉแตฃ[1]], [๐ฉแตฃ[2]],markersize = 3.5,color = :blue, marker=:square, label='r' )
scatter!(p2,[๐โ[1]],[๐โ[2]],markersize = 8.5,color = :red, marker=:star8, label='t')
