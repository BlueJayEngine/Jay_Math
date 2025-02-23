Vec2 :: Vector(2, float64, DEFAULT_AXES);
Vec3 :: Vector(3, float64, DEFAULT_AXES);
Vec4 :: Vector(4, float64, DEFAULT_AXES);

Vec2f :: Vector(2, float32, DEFAULT_AXES);
Vec3f :: Vector(3, float32, DEFAULT_AXES);
Vec4f :: Vector(4, float32, DEFAULT_AXES);

Vec2i :: Vector(2, s32, DEFAULT_AXES);
Vec3i :: Vector(3, s32, DEFAULT_AXES);
Vec4i :: Vector(4, s32, DEFAULT_AXES);

DEFAULT_AXES :: string.["x", "y", "z", "w"]; 

Vectors2 :: Type.[Vec2, Vec2f];
Vectors3 :: Type.[Vec3, Vec3f];
Vectors4 :: Type.[Vec4, Vec4f];

USE_SIMD :: false;

#import "String";

Vector :: struct(N: u8, T: Type = float64, AXES: []string) {
    #insert -> string {
        body_builder: String_Builder; // Mmmm... Muskles...

        print_to_builder(*body_builder, "\t");
            for i: 0..N-1 {
                if i<AXES.count {
                    print_to_builder(*body_builder, "%", AXES[i]);
                } else {
                    print_to_builder(*body_builder, "_%", i);
                }

                if i+1<N {
                    print_to_builder(*body_builder, ", ");
                }
            }

        #if AXES.count>0 {
            print_to_builder(*body_builder, ": T;\n\t#place %; values: [N] T = ---;\n", AXES[0]);
            for i: 1..N-1 {
                for j: 0..N-i-1 {
                    if i+1 == N continue;
                    names: []string = AXES;
                    names.count = i+1;
                    names.data += j;
                    print_to_builder(*body_builder, "\t#place %; %: Vector(%, T, AXES) = ---;\n", AXES[j], join(..names), i+1);
                }
            }
        } else {
            print_to_builder(*body_builder, ": T;\n\t#place _0; values: [N] T  = ---;\n");
        }
        
        result: [..][]u8;

        get_components(N, .[], *result);

        for components: result {
            if components.count>1 {
                build_init(*body_builder, components, AXES);
            }
        }

        return builder_to_string(*body_builder);
    }

    new :: (vec: $VT/Vector) -> Vector(N, T, AXES) {
        result: Vector(N, T, AXES);

        #insert -> string {
            builder: String_Builder;
            for i: 0..max(VT.N, N)-1 {
                print_to_builder(*builder, "\tresult.values[%1] = cast(T)vec.values[%1];\n", i);
            }

            return builder_to_string(*builder);
        }

        return result;
    }

    new :: (n: $NT/Numbers) -> Vector(N, T, AXES) {
        #insert -> string {
            builder: String_Builder;
            print_to_builder(*builder, "\treturn .{");
            for i: 0..N-1 {
                print_to_builder(*builder, "n, ");
            }

            return builder_to_string(*builder);
        }
    } 
}

#if USE_SIMD {
    #import "jai-simpd";
    __simd_type := SIMD_Type.avx2;

    init_simd :: () {
        __simd_type = most_recent_simd();
    }
}

operator []= :: (vec: *$VT/Vector, index: s64, value: VT.T) {
    vec.values[index] = value;
}

operator [] :: (vec: *$VT/Vector, index: s64) -> VT.T {
    return vec.values[index];
}

operator + :: (a: $VT/Vector, b: VT) -> VT {
    result: VT = --- #align 16;
    #if USE_SIMD {
        result = a;
        simd_type := __simd_type;
        __simd_add_float(result.values.data, b.values.data);
    } else {
        #insert -> string {
            builder: String_Builder;
            for i: 0..VT.N-1 {
                print_to_builder(*builder, "\tresult.values[%] = a.values[%] + b.values[%];\n", i, i, i);
            }

            return builder_to_string(*builder);
        }
    }
    

    return result;
}

operator - :: (a: $VT/Vector, b: VT) -> VT {
    result: VT = ---;
    #if USE_SIMD {
        result = a;
        simd_subtract(result.values, b.values, __simd_type);
    } else {
        #insert -> string {
            builder: String_Builder;
            for i: 0..VT.N-1 {
                print_to_builder(*builder, "\tresult.values[%] = a.values[%] - b.values[%];\n", i, i, i);
            }

            return builder_to_string(*builder);
        }
    }

    return result;
}

operator * :: (a: $VT/Vector, b: VT) -> VT {
    result: VT = ---;
    #if USE_SIMD {
        result = a;
        simd_multiply(result.values, b.values, __simd_type);
    } else {
        #insert -> string {
            builder: String_Builder;
            for i: 0..VT.N-1 {
                print_to_builder(*builder, "\tresult.values[%] = a.values[%] * b.values[%];\n", i, i, i);
            }

            return builder_to_string(*builder);
        }
    }

    return result;
}

operator / :: (a: $VT/Vector, b: VT) -> VT {
    result: VT = ---;
    #if USE_SIMD {
        result = a;
        simd_divide(result.values, b.values, __simd_type);
    } else {
        #insert -> string {
            builder: String_Builder;
            for i: 0..VT.N-1 {
                print_to_builder(*builder, "\tresult.values[%] = a.values[%] / b.values[%];\n", i, i, i);
            }

            return builder_to_string(*builder);
        }
    }

    return result;
}



operator + :: (a: $VT/Vector, b: VT.T) -> VT {
    result: VT = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..VT.N-1 {
            print_to_builder(*builder, "\tresult.values[%] = a.values[%] + b;\n", i, i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator - :: (a: $VT/Vector, b: VT.T) -> VT {
    result: VT = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..VT.N-1 {
            print_to_builder(*builder, "\tresult.values[%] = a.values[%] - b;\n", i, i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator * :: (a: $VT/Vector, b: VT.T) -> VT {
    result: VT = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..VT.N-1 {
            print_to_builder(*builder, "\tresult.values[%] = a.values[%] * b;\n", i, i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator / :: (a: $VT/Vector, b: VT.T) -> VT {
    result: VT = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..VT.N-1 {
            print_to_builder(*builder, "\tresult.values[%] = a.values[%] / b;\n", i, i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator == :: (a: $VT/Vector, b: VT) -> bool {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "\treturn a.values[0] == b.values[0]");
        for i: 1..VT.N-1 {
            print_to_builder(*builder, " && a.values[%1] == b.values[%1]", i);
        }
        print_to_builder(*builder, ";");

        return builder_to_string(*builder);
    }
}

operator != :: (a: $VT/Vector, b: VT) -> bool {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "\treturn a.values[0] != b.values[0]\n");
        for i: 1..VT.N-1 {
            print_to_builder(*builder, "\t\t&& a.values[%1] != b.values[%1]", i);
        }
        print_to_builder(*builder, ";");

        return builder_to_string(*builder);
    }
}

get_components :: (n: u8, prefix: []u8, result: *[..][]u8) {
    if n <= 0 then {
        array_add(result, prefix);
    } else {
        for i: 1..n {
            new_prefix: [..]u8;

            array_add(*new_prefix, ..prefix);
            array_add(*new_prefix, i);
            get_components(n-i, new_prefix, result);
        }
    }
}

build_init :: (builder: *String_Builder, components: []u8, axes: []string) {
    print_to_builder(builder, "\n\tnew :: (");

    offset := 0;

    for component, c_index: components {

        names: []string = axes;
        names.count = component;
        names.data += offset;

        offset+=component;

        arg_name := join(..names);

        if component > 1 {
            print_to_builder(builder, "%: Vector(%, $T%, $A%)", arg_name, component, c_index, c_index);
        } else {
            print_to_builder(builder, "%: T", arg_name);
        }

        if c_index+1 < components.count {
            print_to_builder(builder, ", ");
        }
    }

    print_to_builder(builder, ") -> Vector(N, T, AXES) {\n");

    print_to_builder(builder, "\t\tresult: Vector(N, T, AXES);\n\n");

    target_index := 0;
    offset = 0;
    for component, c_index: components {
        names: []string = axes;
        names.count = component;
        names.data += offset;

        offset+=component;

        arg_name := join(..names);

        if component > 1 {
            for i: 0..component-1 {
                print_to_builder(builder, "\t\tresult.values[%] = %.values[%];\n", target_index, arg_name, i);
                target_index +=1;
            }   
        } else {
            print_to_builder(builder, "\t\tresult.values[%] = %;\n", target_index, arg_name);
            target_index +=1;
        }
    }

    print_to_builder(builder, "\n\t\treturn result;\n\t}\n");
}