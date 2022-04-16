include("vec.jl")
import Base.Vector

mutable struct Image
    width::Int64
    height::Int64
    data::Vector{Vec3}

    function Image(width, height)
        new(width, height, Vector{Vec3}(undef, width * height))
    end
end

function setPixel(x::Int64, y::Int64, grayscaleColor::Int64, img::Image)
    img.data[(y - 1) * img.width + (x - 1) + 1] = Vec3(grayscaleColor, grayscaleColor, grayscaleColor)
end

function setPixel(x::Int64, y::Int64, color::Vec3, img::Image)
    img.data[(y - 1) * img.width + (x - 1) + 1] = color
end

function getPixel(x, y, img::Image)
    img.data[(y - 1) * img.width + (x - 1) + 1]
end

function saveAsPPM(img::Image)
    open("out.ppm", "w") do file
        print(file, "P3\n")
        print(file, img.width)
        print(file, " ")
        print(file, img.height)
        print(file, "\n")
        print(file, "255\n")
        for i in 1:img.width*img.height
            local r = img.data[i].x
            local g = img.data[i].y
            local b = img.data[i].z
            print(file, trunc(Int , r * 255))
            print(file, " ")
            print(file, trunc(Int, g * 255))
            print(file, " ")
            print(file, trunc(Int, b * 255))
            print(file, "\n")
        end
    end
end
