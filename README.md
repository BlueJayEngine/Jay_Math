# Jay Math

![Language](https://img.shields.io/badge/lang-JAI-orange.svg) ![License](https://img.shields.io/badge/license-Apache_2.0-blue.svg) ![Badges](https://img.shields.io/badge/badges-included-green.svg)

A compact math module for Jai, built for the Jay engine. It provides vectors, matrices, quaternions, transforms, and a pile of numeric helpers with SIMD-accelerated paths where possible.

## Minimal example

```jai
#import "Basic";
#import "Jay_Math";

main :: () {
    a := Vec3d.{1, 2, 3};
    b := Vec3d.{4, 5, 6};

    d := dot(a, b);
    len := length(a);
    mid := lerp(a, b, 0.5);

    rot := Rot.{pitch = 30, roll = 0, yaw = 90};
    rot_mat := to_matrix(rot); // Mat3 (degrees in, matrix out)

    world := Mat4f.identity();
    set_translation(*world, Vec3d .{10, 0, 2});

    t := Transform.{translation = Vec3d .{1, 2, 3}};

    log("dot=% len=% mid=%", d, len, mid);
    log("rot_mat=%", rot_mat);
    log("world=%", world);
    log("transform=%", t);
}
```

## Included

- Vector types: `Vec2/3/4`, `Vec2f/3d/4f`, `Point2/3/4`, `Point2s/3s/4s`.
- Matrix types: `Mat2/3/4`, `Mat4x3`, and float32 variants.
- Quaternion and Euler: `Quat`, `Rot`/`Euler`, plus `to_matrix` helpers.
- `Transform` struct for translation/rotation/scale.
- Scalar helpers: `abs`, `lerp`, `floor`, `ceil`, `mod`, `epsilon`, `inf`, `nan`, `is_finite`, `is_nan`, `is_inf`, and more.
- Constants: `PI`, `TAU`, `DEG_TO_RAD`, `RAD_TO_DEG`, float/integer limits.
- SIMD paths for vector/matrix ops on supported types (AVX/AVX2), with scalar fallbacks for tails and unsupported ops.

## Notes

- `Rot` uses degrees; convert with `DEG_TO_RAD` if you are feeding radians.
- Matrix ops include `identity`, `inverse`, `translate`, `set_translation`, and `rotate` (Mat3 with `Rot`).

## License

Apache 2.0. See `engine/Jay_Math/LICENSE`.
