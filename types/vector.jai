Vec2d :: Vector(2, float64, DEFAULT_AXES);
Vec3d :: Vector(3, float64, DEFAULT_AXES);
Vec4d :: Vector(4, float64, DEFAULT_AXES);

Vec2 :: Vector(2, float32, DEFAULT_AXES);
Vec3 :: Vector(3, float32, DEFAULT_AXES);
Vec4 :: Vector(4, float32, DEFAULT_AXES);

Point2d :: Vector(2, s64, DEFAULT_AXES);
Point3d :: Vector(3, s64, DEFAULT_AXES);
Point4d :: Vector(4, s64, DEFAULT_AXES);

Point2 :: Vector(2, s32, DEFAULT_AXES);
Point3 :: Vector(3, s32, DEFAULT_AXES);
Point4 :: Vector(4, s32, DEFAULT_AXES);

DEFAULT_AXES :: string.["x", "y", "z", "w"]; 

Vectors2 :: Type.[Vec2, Vec2d, Point2, Point2d];
Vectors3 :: Type.[Vec3, Vec3d, Point3, Point3d];
Vectors4 :: Type.[Vec4, Vec4d, Point4, Point4d];

IntVectors2 :: Type.[Point2, Point2d];
IntVectors3 :: Type.[Point3, Point3d];
IntVectors4 :: Type.[Point4, Point4d];

FloatVectors2 :: Type.[Vec2, Vec2d];
FloatVectors3 :: Type.[Vec3, Vec3d];
FloatVectors4 :: Type.[Vec4, Vec4d];

IntVectors :: Type.[Point2, Point2d, Point3, Point3d, Point4, Point4d];
FloatVectors :: Type.[Vec2, Vec2d, Vec3, Vec3d, Vec4, Vec4d];

#import "String";

Vector :: struct(N: s64, T: Type = float32, AXES: []string) {

    #assert N > 1 "Vector with length of 1 and below are illegal in this part of town.";

    #insert -> string {
        body_builder: String_Builder; // Mmmm... Muskles...

        print_to_builder(*body_builder, "    ");
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
            print_to_builder(*body_builder, ": T #align 16;\n    #overlay (%) values: [N] T = ---;\n", AXES[0]);
            for i: 1..N-1 {
                for j: 0..N-i-1 {
                    if i+1 == N continue;
                    names: []string = AXES;
                    names.count = i+1;
                    names.data += j;
                    print_to_builder(*body_builder, "    #overlay (%) %: Vector(%, T, AXES) = ---;\n", AXES[j], join(..names), i+1);
                }
            }
        } else {
            print_to_builder(*body_builder, ": T;\n    #overlay (_0); values: [N] T  = ---;\n");
        }
        
        result: [..][]s64;

        get_components(N, .[], *result);

        for components: result {
            if components.count>1 {
                build_init(*body_builder, components, AXES);
            }
        }

        return builder_to_string(*body_builder);
    }

    new :: inline (vec: $VT/Vector) -> Vector(N, T, AXES) {
        result: Vector(N, T, AXES);

        #insert -> string {
            builder: String_Builder;
            for i: 0..max(a.N, N)-1 {
                print_to_builder(*builder, "    result.values[%1] = cast(T)vec.values[%1];\n", i);
            }

            return builder_to_string(*builder);
        }

        return result;
    }

    new :: inline (n: $NT/Numbers) -> Vector(N, T, AXES) {
        result: Vector(N, T, AXES) = ---; 
        #insert -> string {
            builder: String_Builder;
            
            for i: 0..N-1 {
                print_to_builder(*builder, "result.values[%] = xx n; ", i);
            }

            return builder_to_string(*builder);
        }
        return result;
    }

    #overlay (values) _simd_data: Simd_Vector(T, N);
}

length :: inline (v: $VT/Vector) -> VT.T {
    return #insert -> string {
            builder: String_Builder;
            
            print_to_builder(*builder, "sqrt(v.values[0] * v.values[0]");
            
            for i: 1..VT.N-1 {
                print_to_builder(*builder, " + v.values[%] * v.values[%]", i, i);
            }
            print_to_builder(*builder, ");");
            return builder_to_string(*builder);
        };
}

length_sqr :: inline (v: $VT/Vector) -> VT.T {
    return #insert -> string {
        builder: String_Builder;

        print_to_builder(*builder, "v.values[0] * v.values[0]");

        for i: 1..VT.N-1 {
            print_to_builder(*builder, " + v.values[%] * v.values[%]", i, i);
        }
        print_to_builder(*builder, ";");
        return builder_to_string(*builder);
    };
}

normalize :: inline (v: $VT/Vector, epsilon: VT.T = 0, fallback := VT.{}) -> VT.T {
    vec := v;
    sq := length(v);
    if sq <= epsilon {
        vec = fallback;
        return sq;
    }

    factor := 1 / sq;

    #insert -> string {
        builder: String_Builder;
        for i: 0..VT.N-1 {
            print_to_builder(*builder, "    vec.values[%] *= factor;", i);
        }
        return builder_to_string(*builder);
    } 
    

    return sq;
}@NoProfile

// FALLBACK FOR THE SLOW TYPES
// TODO: HANDLE SLOW TYPES FASTER IN WITH SIMD

operator - :: inline (a: Vec3, b: Vec3) -> Vec3  #no_abc #no_aoc {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] - b.values[%];\n", i, i, i);
        }
        return builder_to_string(*builder);
    }
    return result;
}

operator * :: inline (a: Vec3, b: Vec3) -> Vec3  #no_abc #no_aoc {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] * b.values[%];\n", i, i, i);
        }
        return builder_to_string(*builder);
    }
    return result;
}

operator + :: inline (a: Vec3, b: Vec3) -> Vec3  #no_abc #no_aoc {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] + b.values[%];\n", i, i, i);
        }
        return builder_to_string(*builder);
    }
    return result;
}

operator / :: inline (a: Vec3, b: Vec3) -> Vec3  #no_abc #no_aoc {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] / b.values[%];\n", i, i, i);
        }
        return builder_to_string(*builder);
    }
    return result;
}
// FALLBACK END


operator []= :: inline (vec: *Vector, index: s64, value: vec.T) {
    vec.values[index] = value;
}

operator [] :: inline (vec: *Vector, index: s64) -> vec.T {
    return vec.values[index];
}

operator + :: inline (a: Vector, b: type_of(a)) -> type_of(a) #no_abc #no_aoc {
   return inline simd_vec(a, b, .ADD);   
}

operator - :: inline (a: Vector, b: type_of(a)) -> type_of(a) #no_abc #no_aoc {
   return inline simd_vec(a, b, .SUB);    
}

operator * :: inline (a: $T/FloatVectors, b: type_of(a)) -> type_of(a) #no_abc #no_aoc {
    return inline simd_vec(a, b, .MULT);    
}

operator * :: inline (a: $T/IntVectors, b: type_of(a)) -> type_of(a) #no_abc #no_aoc {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] * b.values[%];\n", i, i, i);
        }
        return builder_to_string(*builder);
    }
    return result;
}

operator / :: inline (a: $T/FloatVectors, b: type_of(a)) -> type_of(a) #no_abc #no_aoc {
   return inline simd_vec(a, b, .DIV);    
}

operator / :: inline (a: $T/IntVectors, b: type_of(a)) -> type_of(a) #no_abc #no_aoc {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] / b.values[%];\n", i, i, i);
        }
        return builder_to_string(*builder);
    }
    return result;  
}



operator + :: inline (a: Vector, b: $T/Numbers) -> type_of(a) #no_abc #no_aoc #symmetric {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] + b;\n", i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator - :: inline (a: Vector, b: $T/Numbers) -> type_of(a) #no_abc #no_aoc #symmetric {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] - b;\n", i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator * :: inline (a: Vector, b: $T/Numbers) -> type_of(a) #no_abc #no_aoc #symmetric {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            if T != a.T {
                print_to_builder(*builder, "    result.values[%] = cast(a.T)(a.values[%] * b);\n", i, i);
            } else {
                print_to_builder(*builder, "    result.values[%] = a.values[%] * b;\n", i, i);
            }
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator / :: inline (a: Vector, b: $T/Numbers) -> type_of(a) #no_abc #no_aoc #symmetric {
    result: type_of(a) = ---;
    #insert -> string {
        builder: String_Builder;
        for i: 0..a.N-1 {
            print_to_builder(*builder, "    result.values[%] = a.values[%] / b;\n", i, i);
        }

        return builder_to_string(*builder);
    }

    return result;
}

operator == :: (a: Vector, b: type_of(a)) -> bool #no_abc #no_aoc {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "    return a.values[0] == b.values[0]");
        for i: 1..a.N-1 {
            print_to_builder(*builder, " && a.values[%1] == b.values[%1]", i);
        }
        print_to_builder(*builder, ";");

        return builder_to_string(*builder);
    }
}

operator != :: (a: Vector, b: type_of(a)) -> bool #no_abc #no_aoc {
    #insert -> string {
        builder: String_Builder;
        print_to_builder(*builder, "    return a.values[0] != b.values[0]\n");
        for i: 1..a.N-1 {
            print_to_builder(*builder, "        || a.values[%1] != b.values[%1]", i);
        }
        print_to_builder(*builder, ";");

        return builder_to_string(*builder);
    }
}

get_components :: (n: s64, prefix: []s64, result: *[..][]s64) {
    if n <= 0 then {
        array_add(result, prefix);
    } else {
        for i: 1..n {
            new_prefix: [..]s64;

            array_add(*new_prefix, ..prefix);
            array_add(*new_prefix, i);
            get_components(n-i, new_prefix, result);
        }
    }
}

build_init :: (builder: *String_Builder, components: []s64, axes: []string) {
    print_to_builder(builder, "\n    new :: (");

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

    print_to_builder(builder, "        result: Vector(N, T, AXES);\n\n");

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
                print_to_builder(builder, "        result.values[%] = %.values[%];\n", target_index, arg_name, i);
                target_index +=1;
            }   
        } else {
            print_to_builder(builder, "        result.values[%] = %;\n", target_index, arg_name);
            target_index +=1;
        }
    }

    print_to_builder(builder, "\n        return result;\n    }\n");
}

lerp :: inline (a: Vector, b: type_of(a), t: float32) -> type_of(a) {
    return a + (b - a) * t;
}

dot :: inline (a: Vector, b: type_of(a)) -> a.T {
    return #insert -> string {
            builder: String_Builder;
            
            print_to_builder(*builder, "a.values[0] * b.values[0]");
            
            for i: 1..a.N-1 {
                print_to_builder(*builder, " + a.values[%] * b.values[%]", i, i);
            }
            print_to_builder(*builder, ";");
            return builder_to_string(*builder);
        };
}


#scope_file 
Simd_Vector :: struct (T: Type, N: s64) {
    seg32, seg16, tail :: #run,stallable get_simd_magic(T, N);

    #if seg32 > 0 
        simd32: [seg32][32/size_of(T)] T;
    #if seg16 > 0 
        simd16: [seg16][16/size_of(T)] T;
    #if tail > 0
        simd_tail: [tail] T;
}

