include("vec.jl")
include("image.jl")
include("ray.jl")
include("camera.jl")
include("texture.jl")
include("sphere.jl")
include("scene.jl")


# choose a random vector in the hemisphere around the given normal vector
function randomVecHemisphere(normal::Vec3)
    return normalize(normal + (Vec3(rand(), rand(), rand()) * 2 - 1))
end

function raytrace(scene::Scene, ray::Ray, maxDepth::Int64)
    rec = HitRecord()

    skyColor = Vec3(173, 237, 255) / 255

    result = Vec3(1, 1, 1)


    for bounce = 1:maxDepth
        if(!hit(ray, rec, scene))
            return result * skyColor
        end

        result = result * at(rec.uv, rec.obj.tex)

        ray.pos = rec.pos
        ray.dir = randomVecHemisphere(rec.normal)
    end

    return result
end


function main()
    WIDTH = 800
    HEIGHT = 500
    MAX_BOUNCES = 10

    # Number of rays to shoot.
    SAMPLES = 200

    img = Image(WIDTH, HEIGHT)
    cam = Camera(Vec3(0, 0, 0), Vec3(0, 0, 1), Vec3(0, 1, 0), 90)

    setResolution(WIDTH, HEIGHT, cam)

    scene = Scene(Vector{Sphere}())

    # Add objects to scene.
    add(Sphere(Vec3(-0.55, 0, 1), 0.5, Texture(Vec3(1, 0, 0))), scene)
    add(Sphere(Vec3(0.55, 0, 1), 0.5, Texture(Vec3(1, 0, 0))), scene)
    add(Sphere(Vec3(0, -100.5, 1), 100.0, Texture(Vec3(0, 1, 0))), scene)

    println("tracing rays...")
    for j = HEIGHT:-1:1  # Loop over the rows in reverse because ppm has origin on bottom left.
        for i = 1:WIDTH
            color = Vec3(0, 0, 0)
            for k = 1:SAMPLES
                ray = getRay(i, HEIGHT - j, cam)
                # Accumulate color of all the rays shot.
                color = color + raytrace(scene, ray, MAX_BOUNCES)
            end
            setPixel(i, j, color / SAMPLES, img)
        end
    end
    println("saving as ppm...")
    saveAsPPM(img)
    println("saved output to \e[32mout.ppm\e[0m")
end

main()
