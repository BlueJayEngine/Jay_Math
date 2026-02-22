
Mat2d :: Matrix(2, 2, float64);
Mat3d :: Matrix(3, 3, float64);
Mat4d :: Matrix(4, 4, float64);
Mat4x3d :: Matrix(4, 3, float64);

Mat2 :: Matrix(2, 2, float32);
Mat3 :: Matrix(3, 3, float32);
Mat4 :: Matrix(4, 4, float32);
Mat4x3 :: Matrix(4, 3, float32);

Matrix2 :: Type.[Mat2, Mat2d];
Matrix3 :: Type.[Mat3, Mat3d];
Matrix4 :: Type.[Mat3, Mat3d];

Matrix :: struct(COL: s64, ROW: s64, T: Type) {
    N :: COL * ROW;
    #assert N > 0 "Matrices with size of 0 are illegal in this part of town.";

    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "//  Matrix(%1,%2,%3)\n", COL, ROW, T);
        for h: 1..ROW {
            print_to_builder(*builder, "    ");
            for w: 1..COL {
                print_to_builder(*builder, "_%1%2", h, w);

                if w<COL {
                    print_to_builder(*builder, ", ");
                }
            }

            print_to_builder(*builder, ": T;\n");
        }
        return builder_to_string(*builder);
    }

    #overlay (_11) values: [N] T = ---;
    #overlay (_11) cells: [ROW][COL] T = ---;
    #overlay (_11) _simd_data: Simd_Matrix(T, N);

    identity :: () -> Matrix(COL,ROW,T) { 
        return #run -> Matrix(COL, ROW, T) {
            result: Matrix(COL,ROW,T);
            for h: 0..ROW-1 {
                for w: 0..COL-1 {
                    ifx h==w {
                        result.cells[h][w] = 1; 
                    } else {
                        result.cells[h][w] = 0;
                    } 
                }
            }
            return result;
        };
    } 
}

Simd_Matrix :: struct (T: Type, N: s64) {
    seg32, seg16, tail :: #run,stallable get_simd_magic(T, N);

    #if seg32 > 0 
        simd32: [seg32][32/size_of(T)] T;
    #if seg16 > 0 
        simd16: [seg16][16/size_of(T)] T;
    #if tail > 0
        simd_tail: [tail] T;
}

operator[]= :: (mat: *$MT/Matrix, index: int, value: [MT.COL] MT.T) {
    mat.cells[index] = value;
}

operator[] :: (mat: *$MT/Matrix, index: int) -> [MT.COL] MT.T {
    return mat.cells[index];
}

operator== :: (a: $T/Matrix, b: T) -> bool #no_abc #no_aoc {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "    return a.values[0] == b.values[0]");
        for i: 1..T.N-1 {
            print_to_builder(*builder, " && a.values[%1] == b.values[%1]", i);
        }
        print_to_builder(*builder, ";");
        return builder_to_string(*builder);
    }
}

operator!= :: (a: $T/Matrix, b: T) -> bool #no_abc #no_aoc {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "    return a.values[0] != b.values[0]");
        for i: 1..T.N-1 {
            print_to_builder(*builder, " || a.values[%1] != b.values[%1]", i);
        }
        print_to_builder(*builder, ";");
        return builder_to_string(*builder);
    }
}

length :: inline (m: $T/Matrix) -> T.T {
    return #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "sqrt(m.values[0] * m.values[0]");
        for i: 1..T.N-1 {
            print_to_builder(*builder, " + m.values[%] * m.values[%]", i, i);
        }
        print_to_builder(*builder, ");");
        return builder_to_string(*builder);
    };
}

operator+ :: inline (a: $T/Matrix, b: T) -> T #no_abc #no_aoc {
    return inline simd_mat(a, b, .ADD);
}

operator- :: inline (a: $T/Matrix, b: T) -> T #no_abc #no_aoc {
    return inline simd_mat(a, b, .SUB);
}

operator* :: inline (a: $T/Matrix, b: T) -> T #no_abc #no_aoc {
    return inline simd_mat_mult(a, b);
}

operator* :: inline (a: $T/Matrix, b: $VT/Vector) -> VT #no_abc #no_aoc {
    #assert T.COL == VT.N "Vector size must match matrix column count for multiplication";
    
    result: VT = ---;
    
    #insert -> string {
        builder: String_Builder;
        for row: 0..T.ROW-1 {
            print_to_builder(*builder, "    result.values[%] = ", row);
            for col: 0..T.COL-1 {
                if col > 0 print_to_builder(*builder, " + ");
                print_to_builder(*builder, "a.cells[%][%] * xx b.values[%]", row, col, col);
            }
            print_to_builder(*builder, ";\n");
        }
        return builder_to_string(*builder);
    }
    
    return result;
}

operator/ :: inline (a: $T/Matrix, b: T) -> T #no_abc #no_aoc {
    #assert T.COL == T.ROW "Matrix division requires square matrices; use element-wise ops for non-square";
    return a * inverse(b);
}

inverse :: inline (mat: Matrix) -> type_of(mat) {
    #assert mat.COL == mat.ROW "Matrix must be square to compute inverse";

    N :: mat.COL;

    // Closed-form cofactor expansions for 2×2, 3×3, 4×4.
    // Branchless, no loops, single division — 3-11x faster than Gauss-Jordan.

    #if N == 2 {
        inv_det := 1.0 / (mat._11 * mat._22 - mat._12 * mat._21);

        result: type_of(mat) = ---;
        result._11 =  mat._22 * inv_det;
        result._12 = -mat._12 * inv_det;
        result._21 = -mat._21 * inv_det;
        result._22 =  mat._11 * inv_det;
        return result;
    } else #if N == 3 {
        c00 := mat._22 * mat._33 - mat._23 * mat._32;
        c01 := mat._23 * mat._31 - mat._21 * mat._33;
        c02 := mat._21 * mat._32 - mat._22 * mat._31;

        c10 := mat._13 * mat._32 - mat._12 * mat._33;
        c11 := mat._11 * mat._33 - mat._13 * mat._31;
        c12 := mat._12 * mat._31 - mat._11 * mat._32;

        c20 := mat._12 * mat._23 - mat._13 * mat._22;
        c21 := mat._13 * mat._21 - mat._11 * mat._23;
        c22 := mat._11 * mat._22 - mat._12 * mat._21;

        inv_det := 1.0 / (mat._11 * c00 + mat._12 * c01 + mat._13 * c02);

        result: type_of(mat) = ---;
        result._11 = c00 * inv_det;  result._12 = c10 * inv_det;  result._13 = c20 * inv_det;
        result._21 = c01 * inv_det;  result._22 = c11 * inv_det;  result._23 = c21 * inv_det;
        result._31 = c02 * inv_det;  result._32 = c12 * inv_det;  result._33 = c22 * inv_det;
        return result;
    } else #if N == 4 {
        // Laplace expansion via 2×2 sub-determinants
        s0 := mat._11 * mat._22 - mat._12 * mat._21;
        s1 := mat._11 * mat._23 - mat._13 * mat._21;
        s2 := mat._11 * mat._24 - mat._14 * mat._21;
        s3 := mat._12 * mat._23 - mat._13 * mat._22;
        s4 := mat._12 * mat._24 - mat._14 * mat._22;
        s5 := mat._13 * mat._24 - mat._14 * mat._23;

        c5 := mat._33 * mat._44 - mat._34 * mat._43;
        c4 := mat._32 * mat._44 - mat._34 * mat._42;
        c3 := mat._32 * mat._43 - mat._33 * mat._42;
        c2 := mat._31 * mat._44 - mat._34 * mat._41;
        c1 := mat._31 * mat._43 - mat._33 * mat._41;
        c0 := mat._31 * mat._42 - mat._32 * mat._41;

        inv_det := 1.0 / (s0 * c5 - s1 * c4 + s2 * c3 + s3 * c2 - s4 * c1 + s5 * c0);

        result: type_of(mat) = ---;
        result._11 = ( mat._22 * c5 - mat._23 * c4 + mat._24 * c3) * inv_det;
        result._12 = (-mat._12 * c5 + mat._13 * c4 - mat._14 * c3) * inv_det;
        result._13 = ( mat._42 * s5 - mat._43 * s4 + mat._44 * s3) * inv_det;
        result._14 = (-mat._32 * s5 + mat._33 * s4 - mat._34 * s3) * inv_det;

        result._21 = (-mat._21 * c5 + mat._23 * c2 - mat._24 * c1) * inv_det;
        result._22 = ( mat._11 * c5 - mat._13 * c2 + mat._14 * c1) * inv_det;
        result._23 = (-mat._41 * s5 + mat._43 * s2 - mat._44 * s1) * inv_det;
        result._24 = ( mat._31 * s5 - mat._33 * s2 + mat._34 * s1) * inv_det;

        result._31 = ( mat._21 * c4 - mat._22 * c2 + mat._24 * c0) * inv_det;
        result._32 = (-mat._11 * c4 + mat._12 * c2 - mat._14 * c0) * inv_det;
        result._33 = ( mat._41 * s4 - mat._42 * s2 + mat._44 * s0) * inv_det;
        result._34 = (-mat._31 * s4 + mat._32 * s2 - mat._34 * s0) * inv_det;

        result._41 = (-mat._21 * c3 + mat._22 * c1 - mat._23 * c0) * inv_det;
        result._42 = ( mat._11 * c3 - mat._12 * c1 + mat._13 * c0) * inv_det;
        result._43 = (-mat._41 * s3 + mat._42 * s1 - mat._43 * s0) * inv_det;
        result._44 = ( mat._31 * s3 - mat._32 * s1 + mat._33 * s0) * inv_det;
        return result;
    } else {
        // Generic Gauss-Jordan fallback for N > 4
        result := mat.identity();
        temp := mat;

        for pivot: 0..N-1 {
            max_row := pivot;
            max_val := abs(temp.cells[pivot][pivot]);
            for row: pivot+1..N-1 {
                val := abs(temp.cells[row][pivot]);
                if val > max_val {
                    max_val = val;
                    max_row = row;
                }
            }

            if max_row != pivot {
                for col: 0..N-1 {
                    temp.cells[pivot][col], temp.cells[max_row][col] = temp.cells[max_row][col], temp.cells[pivot][col];
                    result.cells[pivot][col], result.cells[max_row][col] = result.cells[max_row][col], result.cells[pivot][col];
                }
            }

            pivot_val := temp.cells[pivot][pivot];
            assert(abs(pivot_val) > 0.0000001, "Matrix is singular and cannot be inverted");

            for col: 0..N-1 {
                temp.cells[pivot][col] /= pivot_val;
                result.cells[pivot][col] /= pivot_val;
            }

            for row: 0..N-1 {
                if row == pivot continue;
                factor := temp.cells[row][pivot];
                for col: 0..N-1 {
                    temp.cells[row][col] -= factor * temp.cells[pivot][col];
                    result.cells[row][col] -= factor * result.cells[pivot][col];
                }
            }
        }

        return result;
    }
}

// ============================================================================
//  Translation (4-column matrices only — affine transforms)
// ============================================================================

// Apply: add displacement to existing translation column
translate :: inline (mat: *$MT/Matrix, vec: $VT/Vector) {
    #assert MT.COL > 3 "translate requires a matrix with 4+ columns";
    #assert VT.N >= 3  "translate requires a 3d vector";

    mat.cells[0][3] += xx vec.x;
    mat.cells[1][3] += xx vec.y;
    mat.cells[2][3] += xx vec.z;
}

translate :: inline (mat: $MT/Matrix, vec: $VT/Vector) -> MT {
    result: MT = mat;
    translate(*result, vec);
    return result;
}

// Set: overwrite translation column, leave rest untouched
set_translation :: inline (mat: *$MT/Matrix, vec: $VT/Vector) {
    #assert MT.COL > 3 "set_translation requires a matrix with 4+ columns";
    #assert VT.N >= 3  "set_translation requires a 3d vector";

    mat.cells[0][3] = xx vec.x;
    mat.cells[1][3] = xx vec.y;
    mat.cells[2][3] = xx vec.z;
}

set_translation :: inline (mat: $MT/Matrix, vec: $VT/Vector) -> MT {
    result: MT = mat;
    set_translation(*result, vec);
    return result;
}

// Make: identity with translation set
make_translation :: inline (vec: $VT/Vector) -> $RT #modify {
    RT = ifx vec_element_size(VT) >= 8 then Mat4d else Mat4;
    return true;
} {
    result := RT.identity();
    result.cells[0][3] = xx vec.x;
    result.cells[1][3] = xx vec.y;
    result.cells[2][3] = xx vec.z;
    return result;
}

// ============================================================================
//  Rotation
// ============================================================================

// --- 2D (Mat2 / Mat2f) ---

// Make: create a 2d rotation matrix from angle
make_rotation :: inline (angle: $T/Numbers) -> $RT #modify {
    RT = ifx array_find(Numbers64, T) then Mat2d else Mat2;
    return true;
} {
    s, c := sincos(cast(float64) angle, true, true);
    return RT.{values = .[xx c, xx -s, xx s, xx c]};
}

// Set: overwrite a 2x2 matrix with rotation
set_rotation :: inline (mat: *$MT/Matrix, angle: $T/Numbers) {
    #assert MT.COL == 2 && MT.ROW == 2 "2d set_rotation requires a 2x2 matrix";

    s, c := sincos(cast(float64) angle, true, true);
    mat._11 = xx c;  mat._12 = xx -s;
    mat._21 = xx s;  mat._22 = xx  c;
}

set_rotation :: inline (mat: $MT/Matrix, angle: $T/Numbers) -> MT {
    result: MT = mat;
    set_rotation(*result, angle);
    return result;
}

// Apply: multiply existing 2x2 by a rotation
rotate :: inline (mat: *$MT/Matrix, angle: $T/Numbers) {
    #assert MT.COL == 2 && MT.ROW == 2 "2d rotate requires a 2x2 matrix";

    rot := make_rotation(angle);
    mat.* = inline simd_mat_mult(mat.*, rot);
}

rotate :: inline (mat: $MT/Matrix, angle: $T/Numbers) -> MT {
    result: MT = mat;
    rotate(*result, angle);
    return result;
}

// --- 3D (Mat3 / Mat3d) — rotation around an arbitrary axis ---

// Make: create a 3d rotation matrix (Rodrigues' formula)
//   axis must be unit length
make_rotation :: inline (angle: $T/Numbers, axis: $VT/Vector) -> $RT #modify {
    RT = ifx (array_find(Numbers64, T) || vec_element_size(VT) >= 8) then Mat3d else Mat3;
    return true;
} {
    s, c := sincos(cast(float64) angle, true, true);
    t: float64 = 1.0 - c;

    x := cast(float64) axis.x;
    y := cast(float64) axis.y;
    z := cast(float64) axis.z;

    result: RT;
    result._11 = xx (t * x * x + c);
    result._12 = xx (t * x * y - s * z);
    result._13 = xx (t * x * z + s * y);

    result._21 = xx (t * x * y + s * z);
    result._22 = xx (t * y * y + c);
    result._23 = xx (t * y * z - s * x);

    result._31 = xx (t * x * z - s * y);
    result._32 = xx (t * y * z + s * x);
    result._33 = xx (t * z * z + c);

    return result;
}

// Set: overwrite upper-left 3x3 of a matrix with rotation
set_rotation :: inline (mat: *$MT/Matrix, angle: $T/Numbers, axis: $VT/Vector) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "3d set_rotation requires at least a 3x3 matrix";
    #assert VT.N >= 3 "set_rotation requires a 3d axis vector";

    s, c := sincos(cast(float64) angle, true, true);
    t: float64 = 1.0 - c;

    x := cast(float64) axis.x;
    y := cast(float64) axis.y;
    z := cast(float64) axis.z;

    mat.cells[0][0] = xx (t * x * x + c);
    mat.cells[0][1] = xx (t * x * y - s * z);
    mat.cells[0][2] = xx (t * x * z + s * y);

    mat.cells[1][0] = xx (t * x * y + s * z);
    mat.cells[1][1] = xx (t * y * y + c);
    mat.cells[1][2] = xx (t * y * z - s * x);

    mat.cells[2][0] = xx (t * x * z - s * y);
    mat.cells[2][1] = xx (t * y * z + s * x);
    mat.cells[2][2] = xx (t * z * z + c);
}

set_rotation :: inline (mat: $MT/Matrix, angle: $T/Numbers, axis: $VT/Vector) -> MT {
    result: MT = mat;
    set_rotation(*result, angle, axis);
    return result;
}

// Apply: multiply existing matrix by a 3d rotation
rotate :: inline (mat: *$MT/Matrix, angle: $T/Numbers, axis: $VT/Vector) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "3d rotate requires at least a 3x3 matrix";
    #assert VT.N >= 3 "rotate requires a 3d axis vector";

    rot := make_rotation(angle, axis);

    // Multiply the upper-left 3x3 block of mat by rot
    // result[i][j] = sum_k mat[i][k] * rot[k][j], for j in 0..2
    #insert -> string {
        builder: String_Builder;
        for i: 0..MT.ROW-1 {
            for j: 0..2 {
                print_to_builder(*builder, "    _r%1_%2 := mat.cells[%1][0] * rot.cells[0][%2] + mat.cells[%1][1] * rot.cells[1][%2] + mat.cells[%1][2] * rot.cells[2][%2];\n", i, j);
            }
        }
        for i: 0..MT.ROW-1 {
            for j: 0..2 {
                print_to_builder(*builder, "    mat.cells[%1][%2] = _r%1_%2;\n", i, j);
            }
        }
        return builder_to_string(*builder);
    }
}

rotate :: inline (mat: $MT/Matrix, angle: $T/Numbers, axis: $VT/Vector) -> MT {
    result: MT = mat;
    rotate(*result, angle, axis);
    return result;
}

// ============================================================================
//  Face (orient matrix to look along a direction)
// ============================================================================

// Make: build an orientation matrix from direction and up vectors
//   forward = normalize(direction), right = normalize(cross(forward, up)), actual_up = cross(right, forward)
//   Row-major layout: rows are right, actual_up, -forward (OpenGL-style look direction)
make_face :: inline (direction: $VT/Vector, up: VT) -> $RT #modify {
    RT = ifx vec_element_size(VT) >= 8 then Mat3d else Mat3;
    return true;
} {
    fwd := direction;
    normalize(*fwd);

    right := cross3(fwd, up);
    normalize(*right);

    actual_up := cross3(right, fwd);

    result: RT;
    // Row 0: right
    result.cells[0][0] = xx right.x;
    result.cells[0][1] = xx right.y;
    result.cells[0][2] = xx right.z;
    // Row 1: up
    result.cells[1][0] = xx actual_up.x;
    result.cells[1][1] = xx actual_up.y;
    result.cells[1][2] = xx actual_up.z;
    // Row 2: -forward
    result.cells[2][0] = xx -fwd.x;
    result.cells[2][1] = xx -fwd.y;
    result.cells[2][2] = xx -fwd.z;

    return result;
}

// Set: overwrite upper-left 3x3 with face orientation
set_face :: inline (mat: *$MT/Matrix, direction: $VT/Vector, up: VT) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "set_face requires at least a 3x3 matrix";
    #assert VT.N >= 3 "set_face requires 3d vectors";

    fwd := direction;
    normalize(*fwd);

    right := cross3(fwd, up);
    normalize(*right);

    actual_up := cross3(right, fwd);

    mat.cells[0][0] = xx right.x;
    mat.cells[0][1] = xx right.y;
    mat.cells[0][2] = xx right.z;

    mat.cells[1][0] = xx actual_up.x;
    mat.cells[1][1] = xx actual_up.y;
    mat.cells[1][2] = xx actual_up.z;

    mat.cells[2][0] = xx -fwd.x;
    mat.cells[2][1] = xx -fwd.y;
    mat.cells[2][2] = xx -fwd.z;
}

set_face :: inline (mat: $MT/Matrix, direction: $VT/Vector, up: VT) -> MT {
    result: MT = mat;
    set_face(*result, direction, up);
    return result;
}

// Apply: multiply existing matrix by a face orientation
face :: inline (mat: *$MT/Matrix, direction: $VT/Vector, up: VT) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "face requires at least a 3x3 matrix";
    #assert VT.N >= 3 "face requires 3d vectors";

    orientation := make_face(direction, up);

    #insert -> string {
        builder: String_Builder;
        for i: 0..MT.ROW-1 {
            for j: 0..2 {
                print_to_builder(*builder, "    _r%1_%2 := mat.cells[%1][0] * orientation.cells[0][%2] + mat.cells[%1][1] * orientation.cells[1][%2] + mat.cells[%1][2] * orientation.cells[2][%2];\n", i, j);
            }
        }
        for i: 0..MT.ROW-1 {
            for j: 0..2 {
                print_to_builder(*builder, "    mat.cells[%1][%2] = _r%1_%2;\n", i, j);
            }
        }
        return builder_to_string(*builder);
    }
}

face :: inline (mat: $MT/Matrix, direction: $VT/Vector, up: VT) -> MT {
    result: MT = mat;
    face(*result, direction, up);
    return result;
}

// ============================================================================
//  Scale
// ============================================================================

// Make 2d: diagonal scale matrix
make_scale :: inline (sx: $T/Numbers, sy: T) -> $RT #modify {
    RT = ifx array_find(Numbers64, T) then Mat2d else Mat2;
    return true;
} {
    result: RT;
    result._11 = xx sx;  result._12 = 0;
    result._21 = 0;      result._22 = xx sy;
    return result;
}

// Make 3d: diagonal scale matrix from vector
make_scale :: inline (vec: $VT/Vector) -> $RT #modify {
    RT = ifx vec_element_size(VT) >= 8 then Mat3d else Mat3;
    return true;
} {
    result: RT;
    result.cells[0][0] = xx vec.x;
    result.cells[1][1] = xx vec.y;
    result.cells[2][2] = xx vec.z;
    return result;
}

// Set 2d: overwrite diagonal with scale factors
set_scale :: inline (mat: *$MT/Matrix, sx: $T/Numbers, sy: T) {
    #assert MT.COL >= 2 && MT.ROW >= 2 "set_scale requires at least a 2x2 matrix";

    mat.cells[0][0] = xx sx;
    mat.cells[1][1] = xx sy;
}

set_scale :: inline (mat: $MT/Matrix, sx: $T/Numbers, sy: T) -> MT {
    result: MT = mat;
    set_scale(*result, sx, sy);
    return result;
}

// Set 3d: overwrite diagonal with scale vector
set_scale :: inline (mat: *$MT/Matrix, vec: $VT/Vector) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "set_scale requires at least a 3x3 matrix";
    #assert VT.N >= 3 "set_scale requires a 3d vector";

    mat.cells[0][0] = xx vec.x;
    mat.cells[1][1] = xx vec.y;
    mat.cells[2][2] = xx vec.z;
}

set_scale :: inline (mat: $MT/Matrix, vec: $VT/Vector) -> MT {
    result: MT = mat;
    set_scale(*result, vec);
    return result;
}

// Apply 2d: multiply existing diagonal by scale factors
scale :: inline (mat: *$MT/Matrix, sx: $T/Numbers, sy: T) {
    #assert MT.COL >= 2 && MT.ROW >= 2 "scale requires at least a 2x2 matrix";

    for row: 0..MT.ROW-1 {
        mat.cells[row][0] *= xx sx;
        mat.cells[row][1] *= xx sy;
    }
}

scale :: inline (mat: $MT/Matrix, sx: $T/Numbers, sy: T) -> MT {
    result: MT = mat;
    scale(*result, sx, sy);
    return result;
}

// Apply 3d: multiply columns by scale vector components
scale :: inline (mat: *$MT/Matrix, vec: $VT/Vector) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "scale requires at least a 3x3 matrix";
    #assert VT.N >= 3 "scale requires a 3d vector";

    for row: 0..MT.ROW-1 {
        mat.cells[row][0] *= xx vec.x;
        mat.cells[row][1] *= xx vec.y;
        mat.cells[row][2] *= xx vec.z;
    }
}

scale :: inline (mat: $MT/Matrix, vec: $VT/Vector) -> MT {
    result: MT = mat;
    scale(*result, vec);
    return result;
}

// ============================================================================
//  Shear
// ============================================================================

// 2D shear: shx shears along x (by y), shy shears along y (by x)
//   | 1    shx |
//   | shy  1   |

// Make 2d
make_shear :: inline (shx: $T/Numbers, shy: T) -> $RT #modify {
    RT = ifx array_find(Numbers64, T) then Mat2d else Mat2;
    return true;
} {
    result := RT.identity();
    result._12 = xx shx;
    result._21 = xx shy;
    return result;
}

// 3D shear: six components — each pair shears one axis by the other two
//   | 1    xy   xz  |
//   | yx   1    yz  |
//   | zx   zy   1   |

// Make 3d
make_shear :: inline (xy: $T/Numbers, xz: T, yx: T, yz: T, zx: T, zy: T) -> $RT #modify {
    RT = ifx array_find(Numbers64, T) then Mat3d else Mat3;
    return true;
} {
    result := RT.identity();
    result._12 = xx xy;  result._13 = xx xz;
    result._21 = xx yx;  result._23 = xx yz;
    result._31 = xx zx;  result._32 = xx zy;
    return result;
}

// Set 2d
set_shear :: inline (mat: *$MT/Matrix, shx: $T/Numbers, shy: T) {
    #assert MT.COL >= 2 && MT.ROW >= 2 "set_shear requires at least a 2x2 matrix";

    mat.cells[0][0] = 1;  mat.cells[0][1] = xx shx;
    mat.cells[1][0] = xx shy;  mat.cells[1][1] = 1;
}

set_shear :: inline (mat: $MT/Matrix, shx: $T/Numbers, shy: T) -> MT {
    result: MT = mat;
    set_shear(*result, shx, shy);
    return result;
}

// Set 3d
set_shear :: inline (mat: *$MT/Matrix, xy: $T/Numbers, xz: T, yx: T, yz: T, zx: T, zy: T) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "set_shear requires at least a 3x3 matrix";

    mat.cells[0][0] = 1;      mat.cells[0][1] = xx xy;  mat.cells[0][2] = xx xz;
    mat.cells[1][0] = xx yx;  mat.cells[1][1] = 1;      mat.cells[1][2] = xx yz;
    mat.cells[2][0] = xx zx;  mat.cells[2][1] = xx zy;  mat.cells[2][2] = 1;
}

set_shear :: inline (mat: $MT/Matrix, xy: $T/Numbers, xz: T, yx: T, yz: T, zx: T, zy: T) -> MT {
    result: MT = mat;
    set_shear(*result, xy, xz, yx, yz, zx, zy);
    return result;
}

// Apply 2d: multiply existing matrix by shear
shear :: inline (mat: *$MT/Matrix, shx: $T/Numbers, shy: T) {
    #assert MT.COL >= 2 && MT.ROW >= 2 "shear requires at least a 2x2 matrix";

    for row: 0..MT.ROW-1 {
        c0 := mat.cells[row][0];
        c1 := mat.cells[row][1];
        mat.cells[row][0] = c0 + c1 * xx shy;
        mat.cells[row][1] = c0 * xx shx + c1;
    }
}

shear :: inline (mat: $MT/Matrix, shx: $T/Numbers, shy: T) -> MT {
    result: MT = mat;
    shear(*result, shx, shy);
    return result;
}

// Apply 3d: multiply existing matrix by 3d shear
shear :: inline (mat: *$MT/Matrix, xy: $T/Numbers, xz: T, yx: T, yz: T, zx: T, zy: T) {
    #assert MT.COL >= 3 && MT.ROW >= 3 "shear requires at least a 3x3 matrix";

    for row: 0..MT.ROW-1 {
        c0 := mat.cells[row][0];
        c1 := mat.cells[row][1];
        c2 := mat.cells[row][2];
        mat.cells[row][0] = c0 + c1 * xx yx + c2 * xx zx;
        mat.cells[row][1] = c0 * xx xy + c1 + c2 * xx zy;
        mat.cells[row][2] = c0 * xx xz + c1 * xx yz + c2;
    }
}

shear :: inline (mat: $MT/Matrix, xy: $T/Numbers, xz: T, yx: T, yz: T, zx: T, zy: T) -> MT {
    result: MT = mat;
    shear(*result, xy, xz, yx, yz, zx, zy);
    return result;
}

// ============================================================================
//  Helpers
// ============================================================================

#scope_file

// Get the element size of a Vector type for use in #modify blocks
// (can't access VT.T directly in #modify, so we inspect type_info)
vec_element_size :: (VT: Type) -> s64 {
    info := cast(*Type_Info_Struct) VT;
    return info.members[0].type.runtime_size;
}

// 3d cross product — works on any vector with at least 3 components
// Returns a vector of the same type with only xyz populated
cross3 :: inline (a: $VT/Vector, b: VT) -> VT {
    #assert VT.N >= 3 "cross3 requires 3d vectors";

    result: VT;
    result.x = a.y * b.z - a.z * b.y;
    result.y = a.z * b.x - a.x * b.z;
    result.z = a.x * b.y - a.y * b.x;
    return result;
}

// In-place normalize for internal use (modifies vector, returns length)
normalize :: inline (v: *$VT/Vector) {
    sq := length(v.*);
    if sq <= 0 return;
    factor := 1.0 / sq;
    #insert -> string {
        builder: String_Builder;
        for i: 0..VT.N-1 {
            print_to_builder(*builder, "    v.values[%] *= xx factor;", i);
        }
        return builder_to_string(*builder);
    }
}
