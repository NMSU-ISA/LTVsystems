function inverse2Dplot(
        S::Vector{<:Sources},
        T::Vector{<:Reflectors},
        R::Vector{<:Receivers},
        f::Function;
        Δpos = 0.01,
        x_min = -5.0,
        x_max = 5.0,
        y_min = -5.0,
        y_max = 5.0,
)
cmap=cgrad(:default)
x_range = collect(x_min:Δpos:x_max)
y_range = collect(y_min:Δpos:y_max)
xyGrid = [[x, y] for x in x_range, y in y_range]
val = [f(𝐮) for 𝐮 ∈ xyGrid]
p2 = plot(x_range,y_range,transpose(val),st=:surface,camera=(0,90),
         aspect_ratio=:equal,legend=:outertopright,colorbar=false,zticks=false,bg = cmap[1])

scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.5,color = :green,
                 marker=:pentagon,label="Source")
for i = 2:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.5,color = :green,label="",
                marker=:pentagon)
end
#scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
#        marker=:star8,label="Reflector")
for i = 1:length(T)
        if isa(T[i],pointReflector)
                scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 5.5,color = :red,label="",
                                marker=:star8)
        elseif isa(T[i],lineSegment)
                endPt = T[i].position+T[i].length*T[i].direction
                plot!(p2,[T[i].position[1],endPt[1]],[T[i].position[2],endPt[2]],color=:red)
        else

        end
end

scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.5,color = :blue,
        marker=:square,label="Receiver")
for i = 2:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.5,color = :blue,label="",
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
scatter!(p2,[S[1].position[1]], [S[1].position[2]],markersize = 5.5,color = :green,
        marker=:pentagon,label="Source")
for i = 1:length(S)
        scatter!(p2,[S[i].position[1]], [S[i].position[2]],markersize = 5.5,color = :green,
                marker=:pentagon,label="")
end
scatter!(p2,[T[1].S.position[1]],[T[1].S.position[2]],markersize = 5.5,color = :red,
        marker=:star8,label="Reflector")
for i = 1:length(T)
        scatter!(p2,[T[i].S.position[1]],[T[i].S.position[2]],markersize = 5.5,color = :red,
                marker=:star8,label="")
end
scatter!(p2,[R[1].position[1]], [R[1].position[2]],markersize = 3.5,color = :blue,
        marker=:square,label="Receiver")
for i = 1:length(R)
        scatter!(p2,[R[i].position[1]], [R[i].position[2]],markersize = 3.5,color = :blue,
                marker=:square,label="")
end
return p2
end
