function inverse2Dplot(
        S::Vector{<:Sources},
        T::Vector{<:Reflectors},
        R::Vector{<:Receivers},
        f::Function;
        Δpos = 0.01,
        x_min = -4.0,
        x_max = 4.0,
        y_min = -4.0,
        y_max = 4.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false,bg = cmap[1])

scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.0,color = :green,
                 marker=:pentagon,label="Source")
for i = 2:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.0,color = :green,label="",
                marker=:pentagon)
end
if isa(T[1],pointReflector)
        scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 3.0,color = :red,label="Reflector",
                        marker=:star8)
elseif isa(T[1],lineSegment)
         endPt = T[1].position+T[1].length*T[1].direction
        plot!(p2,[T[1].position[1],endPt[1]],[T[1].position[2],endPt[2]],color=:red,lw=3.0,label="Reflector")
else

end
#scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
#        marker=:star8,label="Reflector")
for i = 1:length(T)
        if isa(T[i],pointReflector)
                scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 3.0,color = :red,label="",
                                marker=:star8)
        elseif isa(T[i],lineSegment)
                endPt = T[i].position+T[i].length*T[i].direction
                plot!(p2,[T[i].position[1],endPt[1]],[T[i].position[2],endPt[2]],color=:red,label="")
        else

        end
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.0,color = :blue,
        marker=:square,label="Receiver")
for i = 2:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.0,color = :blue,label="",
                marker=:square)
end
return p2
end

#----------------------------------------------------------------
function scene2Dplot(
        S::Vector{<:Sources},
        T::Vector{<:Reflectors},
        R::Vector{<:Receivers};
        Δpos = 0.01,
        x_min = -3.0,
        x_max = 3.0,
        y_min = -3.0,
        y_max = 3.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [0.0]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,bg=cmap[1],colorbar=false,zticks=false)
scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.0,color = :green,
        marker=:pentagon,label="Source")
for i = 1:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.0,color = :green,
                marker=:pentagon,label="")
end
#scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
#        marker=:star8,label="Reflector")
#for i = 1:length(T)
#        scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 5.5,color = :red,
#                marker=:star8,label="")
#end
if isa(T[1],pointReflector)
        scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 3.0,color = :red,label="Reflector",
                        marker=:star8)
elseif isa(T[1],lineSegment)
         endPt = T[1].position+T[1].length*T[1].direction
        plot!(p2,[T[1].position[1],endPt[1]],[T[1].position[2],endPt[2]],color=:red,lw=3.0,label="Reflector")
else

end

for i = 1:length(T)
        if isa(T[i],pointReflector)
                scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 3.0,color = :red,label="",
                                marker=:star8)
        elseif isa(T[i],lineSegment)
                endPt = T[i].position+T[i].length*T[i].direction
                plot!(p2,[T[i].position[1],endPt[1]],[T[i].position[2],endPt[2]],color=:red,label="")
        else

        end
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.0,color = :blue,
        marker=:square,label="Receiver")
for i = 1:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.0,color = :blue,
                marker=:square,label="")
end
return p2
end

#-----------------------------------------------------------------
function inverse2Dfinalplot(
        S::Vector{<:Sources},
        R::Vector{<:Receivers},
        f::Function;
        Δpos = 0.01,
        x_min = -4.0,
        x_max = 4.0,
        y_min = -4.0,
        y_max = 4.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false,bg = cmap[1])

scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.0,color = :green,
                 marker=:pentagon,label="Source")
for i = 2:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.0,color = :green,label="",
                marker=:pentagon)
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.0,color = :blue,
        marker=:square,label="Receiver")
for i = 2:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.0,color = :blue,label="",
                marker=:square)
end
return p2
end
#---------------------------------------------------------
#---------------------------------------------------------
function scene2Ddirplot(
        S::Vector{<:Sources},
        T::Vector{<:Reflectors},
        R::Vector{<:Receivers},
        𝐛::Vector{Float64};
        Δpos = 0.01,
        x_min = -3.0,
        x_max = 3.0,
        y_min = -3.0,
        y_max = 3.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [0.0]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,bg=cmap[1],colorbar=false,zticks=false)
scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.0,color = :green,
        marker=:pentagon,label="Source")
for i = 1:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.0,color = :green,
                marker=:pentagon,label="")
end
#scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
#        marker=:star8,label="Reflector")
#for i = 1:length(T)
#        scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 5.5,color = :red,
#                marker=:star8,label="")
#end
if isa(T[1],pointReflector)
        scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 3.0,color = :red,label="Reflector",
                        marker=:star8)
elseif isa(T[1],lineSegment)
         endPt = T[1].position+T[1].length*T[1].direction
        plot!(p2,[T[1].position[1],endPt[1]],[T[1].position[2],endPt[2]],color=:red,lw=3.0,label="Reflector")
else

end

for i = 1:length(T)
        if isa(T[i],pointReflector)
                scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 3.0,color = :red,label="",
                                marker=:star8)
        elseif isa(T[i],lineSegment)
                endPt = T[i].position+T[i].length*T[i].direction
                plot!(p2,[T[i].position[1],endPt[1]],[T[i].position[2],endPt[2]],color=:red,label="")
        else

        end
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.0,color = :blue,
        marker=:square,label="Receiver")
for i = 1:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.0,color = :blue,
                marker=:square,label="")
end
plot!(p2,[S[1].position[1],𝐛[1]],[S[1].position[2],𝐛[2]],arrow=true,color=:red,linewidth=2,label="Beam Center")
return p2
end


#---------------------------------------------------
function scene2Dmultidirplot(
        S::Vector{<:Sources},
        T::Vector{<:Reflectors},
        R::Vector{<:Receivers},
        𝐛::Vector{Vector{Float64}};
        Δpos = 0.01,
        x_min = -3.0,
        x_max = 3.0,
        y_min = -3.0,
        y_max = 3.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [0.0]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,bg=cmap[1],colorbar=false,zticks=false)
scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.0,color = :green,
        marker=:pentagon,label="Source")
for i = 1:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.0,color = :green,
                marker=:pentagon,label="")
end
#scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
#        marker=:star8,label="Reflector")
#for i = 1:length(T)
#        scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 5.5,color = :red,
#                marker=:star8,label="")
#end
if isa(T[1],pointReflector)
        scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 3.0,color = :red,label="Reflector",
                        marker=:star8)
elseif isa(T[1],lineSegment)
         endPt = T[1].position+T[1].length*T[1].direction
        plot!(p2,[T[1].position[1],endPt[1]],[T[1].position[2],endPt[2]],color=:red,lw=3.0,label="Reflector")
else

end

for i = 1:length(T)
        if isa(T[i],pointReflector)
                scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 3.0,color = :red,label="",
                                marker=:star8)
        elseif isa(T[i],lineSegment)
                endPt = T[i].position+T[i].length*T[i].direction
                plot!(p2,[T[i].position[1],endPt[1]],[T[i].position[2],endPt[2]],color=:red,label="")
        else

        end
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.0,color = :blue,
        marker=:square,label="Receiver")
for i = 1:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.0,color = :blue,
                marker=:square,label="")
end

plot!(p2,[S[1].position[1],𝐛[1][1]],[S[1].position[2],𝐛[1][2]],arrow=true,color=:red,linewidth=2,label="Beam Center")

for i = 1:length(𝐛)
    plot!(p2,[S[1].position[1],𝐛[i][1]],[S[1].position[2],𝐛[i][2]],arrow=true,color=:red,linewidth=2,label="")
end
return p2
end


#----------------------------------------------------------------------
function scene2DRangeplot(
        S::Vector{<:Sources},
        T::Vector{<:Reflectors},
        R::Vector{<:Receivers},
        P::Float64;
        Δpos = 0.01,
        x_min = -3.0,
        x_max = 3.0,
        y_min = -3.0,
        y_max = 3.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [0.0]
r = 2c*P
m=range(0, 2π, length=100)
xₖ(m) = r.*cos.(m).- S[1].position[1]
yₖ(m) = r.*sin.(m).- S[1].position[2]

p2=plot(x_range,y_range,transpose([0.0]),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false)

p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,bg=cmap[1],colorbar=false,zticks=false)
plot!(p2,xₖ.(m),yₖ.(m),label="Range")
       scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.0,color = :green,
               marker=:pentagon,label="Source")
for i = 1:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.0,color = :green,
                marker=:pentagon,label="")
end
#scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
#        marker=:star8,label="Reflector")
#for i = 1:length(T)
#        scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 5.5,color = :red,
#                marker=:star8,label="")
#end
if isa(T[1],pointReflector)
        scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 3.0,color = :red,label="Reflector",
                        marker=:star8)
elseif isa(T[1],lineSegment)
         endPt = T[1].position+T[1].length*T[1].direction
        plot!(p2,[T[1].position[1],endPt[1]],[T[1].position[2],endPt[2]],color=:red,lw=3.0,label="Reflector")
else

end

for i = 1:length(T)
        if isa(T[i],pointReflector)
                scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 3.0,color = :red,label="",
                                marker=:star8)
        elseif isa(T[i],lineSegment)
                endPt = T[i].position+T[i].length*T[i].direction
                plot!(p2,[T[i].position[1],endPt[1]],[T[i].position[2],endPt[2]],color=:red,label="")
        else

        end
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.0,color = :blue,
        marker=:square,label="Receiver")
for i = 1:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.0,color = :blue,
                marker=:square,label="")
end
return p2
end