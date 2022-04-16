include("vec.jl")
include("texture.jl")

mutable struct Sphere
    pos::Vec3
    radius::Float64
    tex::Texture
end

mutable struct HitRecord
    t::Float64
    pos::Vec3
    normal::Vec3
    uv::Vec3
    obj::Sphere

    function HitRecord()
        new(0.0, Vec3(0, 0, 0), Vec3(0, 0, 0), Vec3(0, 0, 0), Sphere(Vec3(0, 0, 0), 0.0, Texture(Vec3(0, 0, 0))))
    end
end

function hit(ray::Ray, rec::HitRecord, sphere::Sphere)
    oc = ray.pos - sphere.pos

    a = dot(ray.dir, ray.dir)
    b = 2 * dot(oc, ray.dir)
    c = dot(oc, oc) - sphere.radius * sphere.radius

    discriminant = b * b - 4 * a * c

    if (discriminant <= 0)
        return false
    end

    temp = (b * -1 - sqrt(discriminant)) / (2 * a)

    if (temp < 1e-3)
        temp - (b * -1 + sqrt(discriminant)) / (2 * a)
    end

    if (temp < 1e-3)
        return false
    end

    rec.t = temp
    rec.pos = at(rec.t, ray)
    rec.normal = normalize(rec.pos - sphere.pos)
    rec.obj = sphere
    rec.uv = Vec3(0.5 + atan(rec.normal.z, rec.normal.x) / (2 * pi), 0.5 + asin(rec.normal.y) / pi, 0)
    return true
end
