include("vec.jl")
include("ray.jl")

mutable struct Camera
    pos::Vec3
    u::Vec3
    v::Vec3
    w::Vec3
    fov::Int64
    width::Int64
    height::Int64
    corner::Vec3
    horizontal::Vec3
    vertical::Vec3

    function Camera(pos::Vec3, dir::Vec3, up::Vec3, fov::Int64)
        w = normalize(dir * -1);
        u = normalize(cross(up, w));
        v = cross(w, u);
        return new(pos, u, v, w, fov, 0, 0, Vec3(0, 0, 0), Vec3(0, 0, 0), Vec3(0, 0, 0))
    end
end


function setResolution(width::Int64, height::Int64, camera::Camera)
    camera.width = width
    camera.height = height

    aspect = convert(Float64, width) / convert(Float64, height)
    theta = deg2rad(camera.fov)
    ysize = 2 * tan(theta / 2.0)
    xsize = ysize * aspect

    camera.horizontal = -xsize * camera.u
    camera.vertical = ysize * camera.v
    camera.corner = camera.pos - camera.horizontal / 2 - camera.vertical / 2 - camera.w
end

function getRay(i::Int64, j::Int64, camera::Camera)
    dx = (convert(Float64, i) + rand()) / convert(Float64, camera.width)
    dy = (convert(Float64, j) + rand()) / convert(Float64, camera.height)

    return Ray(camera.pos, normalize(camera.corner + (camera.horizontal * dx) + (camera.vertical * dy) - camera.pos))
end
