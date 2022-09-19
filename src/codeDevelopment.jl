using LinearAlgebra, LTVsystems, Plots

𝐩ₛ(t) = [1.0c, 1.0c] + [0.9c, 0.0]*t
𝛏₀ = [1.0c, 0.0]

#p(t) = exp(1im*2π*5*t)
p(t) = exp(-t^2)

q = LTVsourceO(𝐩ₛ,p)

t₀ = 0.0
q(𝛏₀,t₀)

t = collect(-3.0:0.001:3.0)
z = [ q(𝛏₀,t₀) for t₀∈t]

plot(t,real(p.(t)))
plot(t,real(z))





function makeFrame(q,Δpos,x_min,x_max,y_min,y_max,t₀)
    cmap=cgrad(:default)
    x_range = collect(x_min:Δpos:x_max)
    y_range = collect(y_min:Δpos:y_max)
    xyGrid = [[x, y] for x in x_range, y in y_range]
    val = [ifelse( norm(𝛏₀.-q.position(t₀))>0.5c, q(𝛏₀,t₀), NaN) for 𝛏₀ ∈ xyGrid]

    p2 = surface(x_range, y_range, real(transpose(val)),
                camera=(0,90),
             aspect_ratio=:equal,
             legend=:outertopright,
             colorbar=false,
             zticks=false,
             bg = cmap[1],
             size=(720,720))
    scatter!(p2,[q.position(t₀)[1]], [q.position(t₀)[2]],markersize = 5.0,color = :green)

    return p2
end

t₀ = 1.0
Δpos = 0.01c
x_min = -10.0c
x_max = 10.0c
y_min = -10.0c
y_max = 10.0c

p2 = makeFrame(q,Δpos,x_min,x_max,y_min,y_max,t₀)


function makeAnimation(Δpos,x_min,x_max,y_min,y_max,t)
    allFrames = []
    for t₀ ∈ t
        p1 = makeFrame(q,Δpos,x_min,x_max,y_min,y_max,t₀)
        frame = plot(p1, size = (720, 720) )
        push!(allFrames, frame)
    end
    anim = @animate for i ∈ 1:length(allFrames)
    plot(allFrames[i])
    end
    return gif(anim, "fileName.gif", fps = 10)
end

t = 1.0:0.1:3.0
makeAnimation(Δpos,x_min,x_max,y_min,y_max,t)

p1=plot(t,p,xlab="time (sec)", ylab="p(t)")
p2=plot(t,A.(t),xlab="time (sec)", ylab="A(t)")
plot(p1,p2,layout=(2,1))
