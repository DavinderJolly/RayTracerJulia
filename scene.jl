include("vec.jl")
include("sphere.jl")


mutable struct Scene
    spheres::Vector{Sphere}
end

function add(s::Sphere, scene::Scene)
    push!(scene.spheres, s)
end

function hit(ray::Ray, rec::HitRecord, scene::Scene)
    temp = HitRecord()
    hitAnything = false
    closest = Inf

    for sphere in scene.spheres
        if (hit(ray, temp, sphere))
            hitAnything = true
            if(temp.t < closest)
                closest = temp.t
                rec.t = temp.t
                rec.pos = temp.pos
                rec.normal = temp.normal
                rec.uv = temp.uv
                rec.obj = temp.obj
            end
        end
    end

    return hitAnything
end
