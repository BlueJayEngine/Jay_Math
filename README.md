# Jay Math

Math library for the Jay engine. If you're building games or graphics stuff, this is what you reach for.

## Design

This started as a no-nonsense math lib and grew from there. The goal is to have the stuff you need for game dev without the bloat.

**Float32 and float64 variants** - Most math is float32 for performance, but if you need precision (physics at large scales, etc) there's float64 versions of everything. The naming is consistent: plain types like `Vec3` are float32, the `d` suffix means double: `Vec3d` is float64. Same for matrices - `Mat4` is float32, `Mat4d` is float64.

**Degrees for rotations** - Rotations use degrees because that's what humans think in. The `to_radians` helper converts if you're interfacing with something that speaks radians.

**SIMD where it matters** - Vector and matrix operations use SIMD instructions when the compiler can make that happen. You don't need to think about it. If you're on older hardware or hit an edge case, there's always a scalar fallback.

## What's here

- **Vectors** - Vec2/3/4, Point2/3/4, all the usual operations (dot, cross, length, normalize, lerp)
- **Matrices** - Mat2/3/4 and Mat4x3, the transforms you'd expect (translate, rotate, scale, inverse)
- **Quaternions** - For smooth rotations, converting between quat/euler/matrix
- **Transforms** - transform.jai at module root holds translation, rotation, and scale. Useful for game objects.

## Quick look

```jai
#import "Jay_Math";

main :: () {
    a := Vec3d.{1, 2, 3};
    b := Vec3d.{4, 5, 6};

    d := dot(a, b);
    len := length(a);
    mid := lerp(a, b, 0.5);

    rot := Rot.{pitch = 30, roll = 0, yaw = 90};
    rot_mat := to_matrix(rot);

    world := Mat4f.identity();
    set_translation(*world, Vec3d.{10, 0, 2});

    t := Transform.{translation = Vec3d.{1, 2, 3}};

    log("dot=% len=%", d, len);
    log("transform=%", t);
}
```

## License

Apache 2.0 - see LICENSE file
