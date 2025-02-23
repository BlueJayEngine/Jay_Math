
Mat2 :: Matrix(2, 2, float64);
Mat3 :: Matrix(3, 3, float64);
Mat4 :: Matrix(4, 4, float64);
Mat4x3 :: Matrix(4, 3, float64);

Mat2f :: Matrix(2, 2, float32);
Mat3f :: Matrix(3, 3, float32);
Mat4f :: Matrix(4, 4, float32);
Mat4x3f :: Matrix(4, 3, float32);

Matrix :: struct(COL: u8, ROW: u8, T: Type) {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "//\tMatrix(%1,%2,%3)\n", COL, ROW, T);
        for h: 0..ROW-1 {
            print_to_builder(*builder, "\t");
            for w: 0..COL-1 {
                print_to_builder(*builder, "_%1%2", h, w);

                if w+1<COL {
                    print_to_builder(*builder, ", ");
                }
            }

            print_to_builder(*builder, ": T;\n");
        }
        return builder_to_string(*builder);
    }

    #place _00; values: [COL*ROW] T = ---;
    #place _00; cells: [ROW][COL] T = ---;

    identity :: () -> Matrix(COL,ROW,T) {
        #insert -> string {
            builder: String_Builder;
            print_to_builder(*builder, "\nreturn .{");
            for h: 0..ROW-1 {
                for w: 0..COL-1 {
                    print_to_builder(*builder, ifx h == w then "1" else "0");
                    if (h+1)*(w+1) < ROW*COL {
                        print_to_builder(*builder, ",");
                    }
                }
            }
            print_to_builder(*builder, "};\n");
            return builder_to_string(*builder);
        }
    }
}

operator[]= :: (mat: *$MT/Matrix, index: int, value: [MT.W] MT.T) {
    mat.cells[index] = value;
}

operator[] :: (mat: *$MT/Matrix, index: int) -> [MT.W] MT.T {
    return mat.cells[index];
}

operator* :: (a: $Ta/Matrix, b: $Tb/Matrix) -> $RT/Matrix
#modify {
    
    a_info := cast(*Type_Info_Struct) Ta;
    b_info := cast(*Type_Info_Struct) Tb;

    a_rows, b_rows : u8 = ---;

    matrix_type: Type;

    for param: a_info.specified_parameters {
        if param.name == {
            case "ROW"; a_rows = a_info.constant_storage[param.offset_into_constant_storage];
        }
    }

    for param: b_info.specified_parameters {
        if param.name == {
            case "ROW"; b_rows = b_info.constant_storage[param.offset_into_constant_storage];
        }
    }

    RT = ifx a_rows>=b_rows then Ta else Tb;
    return true;
} {
    
    max_col :: #run max(Ta.COL, Tb.ROW);
    max_row :: #run max(Ta.ROW, Tb.COL);

    result: RT = ---;

    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "\n//\t%1 * %2\n//\tResult: %3\n", Ta, Tb, RT);

        for i: 0..RT.ROW-1 {
            for j: 0..RT.COL-1 {

                if i>=Ta.ROW {
                    print_to_builder(*builder, "\tresult._%1%2 = b._%1%2;\n", i, j);
                    continue;
                }

                if j>=Tb.COL {
                    print_to_builder(*builder, "\tresult._%1%2 = a._%1%2;\n", i, j);
                    continue;
                }

                print_to_builder(*builder, "\tresult._%1%2 = ", i, j);

                for k: 0..Tb.ROW-1 {

                    print_to_builder(*builder, "a._%1%3*b._%3%2", i, j, k);

                    if k+1>=Tb.ROW {
                        if j>=Tb.ROW {
                            k+=1;
                            for g: k..max_row-1 {
                                print_to_builder(*builder, " + a._%1%2", i, g);
                            }
                        }
                        
                        print_to_builder(*builder, ";\n");
                    } else {
                        print_to_builder(*builder, " + ");
                    }
                }
            }
            print_to_builder(*builder, "\n");
        }

        return builder_to_string(*builder);
    }

    return result;
}


translate :: inline (mat: *$MT/Matrix, vec: $VT/Vector) {
    #assert(MT.COL > 3);
    
    #if MT.T != VT.T {
        mat._03 += xx vec.x;
        mat._13 += xx vec.y;
        mat._23 += xx vec.z;
    } else {
        mat._03 += vec.x;
        mat._13 += vec.y;
        mat._23 += vec.z;
    }
}

translate :: (mat: $MT/Matrix, vec: $VT/Vector) -> MT {
    result: MT;
    translate(*result, vec);
    return result;
}

set_translation :: inline (mat: *$MT/Matrix, vec: Vec3) {
    #assert MT.COL > 3 "Matrix has no capacity to store 3d translation";

    mat._03 = vec.x;
    mat._13 = vec.y;
    mat._23 = vec.z;
}

set_translation :: (mat: $MT/Matrix, vec: Vec3) -> MT {
    result: MT;
    set_translation(*result, vec);
    return result;
}

rotate :: (mat: $MT/Matrix, rot: Rot) -> MT {
    result: MT;
    rotate(*result, vec);
    return result;
}

rotate :: (mat: *$MT/Matrix, rot: Rot) {
    <<mat *= to_matrix(rot);
}