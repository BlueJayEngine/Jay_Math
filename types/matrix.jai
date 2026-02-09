
Mat2 :: Matrix(2, 2, float64);
Mat3 :: Matrix(3, 3, float64);
Mat4 :: Matrix(4, 4, float64);
Mat4x3 :: Matrix(4, 3, float64);

Mat2f :: Matrix(2, 2, float32);
Mat3f :: Matrix(3, 3, float32);
Mat4f :: Matrix(4, 4, float32);
Mat4x3f :: Matrix(4, 3, float32);

Matrix :: struct(COL: u8, ROW: u8, T: Type) {
    N :: COL * ROW;
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "//\tMatrix(%1,%2,%3)\n", COL, ROW, T);
        for h: 1..ROW {
            print_to_builder(*builder, "\t");
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
    seg32, seg16, tail :: #run get_simd_magic(T, N);

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
        print_to_builder(*builder, "\treturn a.values[0] == b.values[0]");
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
        print_to_builder(*builder, "\treturn a.values[0] != b.values[0]");
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

operator/ :: inline (a: $T/Matrix, b: T) -> T #no_abc #no_aoc {
    #assert T.COL == T.ROW "Matrix division requires square matrices; use element-wise ops for non-square";
    return a * inverse(b);
}

inverse :: inline (mat: Matrix) -> type_of(mat) {
    #assert mat.COL == mat.ROW "Matrix must be square to compute inverse";
    
    result := mat.identity();
    temp := mat;
    
    // Gauss-Jordan elimination
    for pivot: 0..mat.ROW-1 {
        // Find max element in column for partial pivoting
        max_row := pivot;
        max_val := abs(temp.cells[pivot][pivot]);
        for row: pivot+1..mat.ROW-1 {
            val := abs(temp.cells[row][pivot]);
            if val > max_val {
                max_val = val;
                max_row = row;
            }
        }
        
        // Swap rows if needed
        if max_row != pivot {
            for col: 0..mat.COL-1 {
                temp.cells[pivot][col], temp.cells[max_row][col] = temp.cells[max_row][col], temp.cells[pivot][col];
                result.cells[pivot][col], result.cells[max_row][col] = result.cells[max_row][col], result.cells[pivot][col];
            }
        }
        
        // Scale pivot row
        pivot_val := temp.cells[pivot][pivot];
        assert(abs(pivot_val) > 0.0000001, "Matrix is singular and cannot be inverted");
        
        for col: 0..mat.COL-1 {
            temp.cells[pivot][col] /= pivot_val;
            result.cells[pivot][col] /= pivot_val;
        }
        
        // Eliminate column
        for row: 0..mat.ROW-1 {
            if row == pivot continue;
            
            factor := temp.cells[row][pivot];
            for col: 0..mat.COL-1 {
                temp.cells[row][col] -= factor * temp.cells[pivot][col];
                result.cells[row][col] -= factor * result.cells[pivot][col];
            }
        }
    }
    
    return result;
}

translate :: inline (mat: *$MT/Matrix, vec: $VT/Vector) {
    #assert(MT.COL > 3);
    
    #if MT.T != VT.T {
        mat.cells[0][3] += xx vec.x;
        mat.cells[1][3] += xx vec.y;
        mat.cells[2][3] += xx vec.z;
    } else {
        mat.cells[0][3] += vec.x;
        mat.cells[1][3] += vec.y;
        mat.cells[2][3] += vec.z;
    }
}

translate :: (mat: $MT/Matrix, vec: Vector) -> MT {
    result: MT = mat;
    translate(*result, vec);
    return result;
}

set_translation :: inline (mat: *$MT/Matrix, vec: $VT/Vectors3) {
    #assert MT.COL > 3 "Matrix has no capacity to store 3d translation";

    mat.cells[0][3] = vec.x;
    mat.cells[1][3] = vec.y;
    mat.cells[2][3] = vec.z;
}

set_translation :: (mat: $MT/Matrix, vec: $VT/Vectors3) -> MT {
    result: MT;
    set_translation(*result, vec);
    return result;
}

rotate :: (mat: $MT/Matrix, rot: Rot) -> MT {
    result: MT;
    rotate(*result, rot);
    return result;
}

rotate :: (mat: *$MT/Matrix, rot: Rot) {
    mat.* *= to_matrix(rot);
}
