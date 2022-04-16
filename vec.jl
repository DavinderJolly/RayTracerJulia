import Base: +, -, *, /

mutable struct Vec3
    x::Float64
    y::Float64
    z::Float64
end

function +(a::Vec3, b::Vec3)
    Vec3(a.x + b.x, a.y + b.y, a.z + b.z)
end

function +(a::Vec3, b::Union{Int64,Float64})
    Vec3(a.x + b, a.y + b, a.z + b)
end

function -(a::Vec3, b::Vec3)
    Vec3(a.x - b.x, a.y - b.y, a.z - b.z)
end

function -(a::Vec3, b::Union{Int64,Float64})
    Vec3(a.x - b, a.y - b, a.z - b)
end

function *(a::Vec3, b::Vec3)
    Vec3(a.x * b.x, a.y * b.y, a.z * b.z)
end

function *(a::Vec3, b::Union{Int64,Float64})
    Vec3(a.x * b, a.y * b, a.z * b)
end

function *(b, a::Vec3)
    Vec3(a.x * b, a.y * b, a.z * b)
end

function /(a::Vec3, b::Union{Int64,Float64})
    Vec3(a.x / b, a.y / b, a.z / b)
end

function dot(a::Vec3, b::Vec3)
    (a.x * b.x + a.y * b.y + a.z * b.z)
end

function cross(a::Vec3, b::Vec3)
    Vec3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
end

function length(a::Vec3)
    sqrt(dot(a, a))
end

function normalize(a::Vec3)
    a * (1.0 / length(a))
end
