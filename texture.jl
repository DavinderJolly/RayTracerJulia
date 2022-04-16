include("vec.jl")

mutable struct Texture
    color::Vec3
end

function at(uv::Vec3, tex::Texture)
    return tex.color
end
