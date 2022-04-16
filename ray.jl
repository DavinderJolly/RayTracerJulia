include("vec.jl")

mutable struct Ray
    pos::Vec3
    dir::Vec3
end

function at(t::Float64, ray::Ray)
    return ray.pos + t * ray.dir
end
