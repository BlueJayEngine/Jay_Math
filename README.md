# Jay Math

Math module. Vectors, matrices, quaternions, transforms, and scalar math — all with compile-time SIMD code generation.

## Types

**Vectors** — `Vector(N, T, AXES)` parametric struct. Named axis fields are generated from the `AXES` parameter, along with sub-vector overlays and all permutations of mixed scalar/vector constructors. SIMD-accelerated element-wise operators for float types, scalar fallback for integers.

| float32 | float64 | s32 | s64 |
|---------|---------|-----|-----|
| `Vec2` `Vec3` `Vec4` | `Vec2d` `Vec3d` `Vec4d` | `Point2` `Point3` `Point4` | `Point2d` `Point3d` `Point4d` |

Operations: `+` `-` `*` `/` `dot` `length` `length_sqr` `normalize` `lerp`, plus scalar-vector variants.

**Matrices** — `Matrix(COL, ROW, T)` parametric struct with named fields (`_11`, `_12`, ...), flat `values[]` array, and `cells[][]` row-major access. SIMD element-wise add/sub, FMA-accelerated multiply (broadcast-mul-acc with compile-time instruction selection), closed-form cofactor inverse for 2×2/3×3/4×4, Gauss-Jordan fallback for larger.

| float32 | float64 |
|---------|---------|
| `Mat2` `Mat3` `Mat4` `Mat4x3` | `Mat2d` `Mat3d` `Mat4d` `Mat4x3d` |

Transform operations (make/set/apply pattern for each):
- **translate** — 4-column affine translation
- **rotate** — 2D angle or 3D axis-angle (Rodrigues)
- **scale** — 2D scalar pair or 3D vector
- **shear** — 2D (2 params) or 3D (6 params)
- **face** — orient matrix along direction + up vector
- **inverse** — cofactor expansion or Gauss-Jordan

**Rotators** — Three interchangeable rotation representations with full conversion between all of them:

- `Quat` — unit quaternion
- `Rotator` / `Euler` — rotation vector in euler degrees (Roll, Pitch, Yaw)
- `Radians` — same layout as Rotator but in radians

Conversions: `to_matrix` `to_matrix4` `to_quat` `to_rotator` `to_radians`. Any representation can round-trip through any other. Matrix extraction uses Shepperd's method for numerical stability.

**Transform** — TRS struct (translation `Vec3`, rotation `Quat`, scale `Vec3`). Converts to/from `Mat4` via `to_matrix` / `to_transform`.

## Scalar Math

Replaces the standard library math functions with Cephes-derived implementations. Hardware `sqrtss`/`sqrtsd` for sqrt, SSE `roundss`/`roundsd` for floor/ceil. All functions have `float32`, `float64`, and integer overloads.

`sin` `cos` `tan` `asin` `acos` `atan` `atan2` `sqrt` `exp` `log` `log2` `pow` `floor` `ceil` `mod` `frac` `abs` `lerp` `grid_snap` `inv_sqrt` `is_nan` `is_inf` `is_finite` `signbit` `epsilon` `inf` `nan`

Constants: `PI` `TAU` `DEG_TO_RAD` `RAD_TO_DEG` `EPSILON` and float/integer min/max/infinity/NaN values for all sizes.

## SIMD

Compile-time code generation, not runtime dispatch. The `#insert` metaprogramming generates SSE/AVX/FMA instructions based on type and element count at compile time. A type-dispatch table (`t_commands`) maps each numeric type to its instruction set (e.g., `float32` → `addps`/`mulps`/`fmadd231ps`, `s16` → `paddw`/`psubw`).

Data is segmented into 16-byte XMM chunks with scalar tails for remainders. Matrix multiply uses broadcast-shuffle-FMA: broadcast `a[i][k]` into all lanes, FMA against pre-loaded `b` row segments, interleaved across all result rows in a single `#asm` block.

## Example

```jai
#import "Jay_Math";

main :: () {
    a := Vec3.{1, 2, 3};
    b := Vec3.{4, 5, 6};

    d := dot(a, b);
    len := length(a);
    mid := lerp(a, b, 0.5);

    rot := Quat.{1, 0, 0, 0};  // identity
    m := to_matrix(rot);        // -> Mat3

    world := Mat4.identity();
    set_translation(*world, Vec3.{10, 0, 2});
    rotate(*world, PI/4, Vec3.{0, 1, 0});

    t := Transform.{translation = .{1, 2, 3}};
    t_mat := to_matrix(t);      // -> Mat4 (TRS composition)
}
```

