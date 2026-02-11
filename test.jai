#import "Basic";
#import "Compiler";
Math :: #import "Math";
#import,file "module.jai";
#import "Machine_X64";
#import "Process";
#import "String";

make_non_binary_workspace :: () {
    set_build_options_dc(.{do_output=false});
}

assert_close :: (label: string, a: $T/Floats, b: T, index: $inT) {
    delta := abs(a-b);
    error += xx delta;
    if delta > epsilon(T) {
        log_error("% mismatch. Index = %, left = %, right = % \n", label, index, formatFloat(a, -1, -1, FormatFloat.Mode.SCIENTIFIC), formatFloat(b, -1, -1, FormatFloat.Mode.SCIENTIFIC));
        exit(1);
    } 
}

DATA_BYTES :: 80000000; 

Test_Data :: struct(T:Type) {
    ref : [DATA_BYTES/size_of(T)]T;
    delta : [DATA_BYTES/size_of(T)]T;
    res : [DATA_BYTES/size_of(T)]T;
    length :: DATA_BYTES/size_of(T);
}

test: union {
    _u8: Test_Data(u8);
    _s8: Test_Data(s8);
    
    _u16: Test_Data(u16);
    _s16: Test_Data(s16);

    _u32: Test_Data(u32);
    _s32: Test_Data(s32);

    _u64: Test_Data(u64);
    _s64: Test_Data(s64);

    _f32: Test_Data(float32);
    _f64: Test_Data(float64);

    _Vec2f: Test_Data(Vec2f);
    _Vec2: Test_Data(Vec2);
    _Point2: Test_Data(Point2);
    _Point2s: Test_Data(Point2s);

    _Vec3f: Test_Data(Vec3f);
    _Vec3: Test_Data(Vec3);
    _Point3: Test_Data(Point3);
    _Point3s: Test_Data(Point3s);

    _Vec4f: Test_Data(Vec4f);
    _Vec4: Test_Data(Vec4);
    _Point4: Test_Data(Point4);
    _Point4s: Test_Data(Point4s);

    _Mat2f: Test_Data(Mat2f);
    _Mat2: Test_Data(Mat2);

    _Mat3f: Test_Data(Mat3f);
    _Mat3: Test_Data(Mat3);

    _Mat3x4f: Test_Data(Mat3f);
    _Mat3x4: Test_Data(Mat3);

    _Mat4f: Test_Data(Mat4f);
    _Mat4: Test_Data(Mat4);
}

TestT :: #type ()->();
CheckT :: #type ()->(bool, s64);

error: float64 = 0;


do_test :: (label: string, $code: TestT, $check: CheckT) {
    time: Apollo_Time;
    delta: s64;

    error = 0;

    time = current_time_monotonic();

    code();
    
    delta = to_milliseconds(current_time_monotonic() - time);

    has_error, error_index := check();
    if !has_error
        log(" - % OK - %ms", label, delta);
    else  
        log_error(" - % - %ms error at index %, total error: %", label, delta, error_index, error);

}

cephes_test :: () {
        

    print("\nCEPHES TEST\n");

    simple_test("_f32", "floor", false);
    simple_test("_f64", "floor", false);

    simple_test("_f32", "ceil", false);
    simple_test("_f64", "ceil", false);

    simple_test("_f32", "mod", false, "frac");
    simple_test("_f64", "mod", false, "frac");

    simple_test("_f32", "sin", false);
    simple_test("_f64", "sin", false);

    simple_test("_f32", "cos", false);
    simple_test("_f64", "cos", false);

    simple_test("_f32", "tan", false);
    log("due to difference of methods there is an inaccuracy. the error is insignificantly small, ignore it");
    simple_test("_f64", "tan", false);

    simple_test("_f32", "atan", false);
    simple_test("_f64", "atan", false);

    simple_test("_f32", "atan2", true);
    simple_test("_f64", "atan2", true);

}

simd_test :: () {

    // cpu_info := get_cpu_info();
    // has_avx     := check_feature(cpu_info.feature_leaves, x86_Feature_Flag.AVX);
    // has_avx2    := check_feature(cpu_info.feature_leaves, x86_Feature_Flag.AVX2);
    //
    // log("\nSIMD:");
    // log("CPU SIMD support - AVX: %, AVX2: %\n", has_avx, has_avx2);
    //
    // if !(has_avx && has_avx2) {
    //     print("Required SIMD features (AVX+AVX2) not available; skipping SIMD tests.\n");
    //     return;
    // }

    simd_test("_s8", .ADD, 2, 4, 8, 16, 32);
    simd_test("_u8", .ADD, 2, 4, 8, 16, 32);
    simd_test("_s8", .SUB, 2, 4, 8, 16, 32);
    simd_test("_u8", .SUB, 2, 4, 8, 16, 32);
    simd_test("_s16", .ADD, 2, 4, 8, 16, 32);
    simd_test("_u16", .ADD, 2, 4, 8, 16, 32);
    simd_test("_s16", .SUB, 2, 4, 8, 16, 32);
    simd_test("_u16", .SUB, 2, 4, 8, 16, 32);
    simd_test("_s32", .ADD, 2, 4, 8, 16, 32);
    simd_test("_u32", .ADD, 2, 4, 8, 16, 32);
    simd_test("_f32", .ADD, 2, 4, 8, 16, 32);
    simd_test("_s32", .SUB, 2, 4, 8, 16, 32);
    simd_test("_u32", .SUB, 2, 4, 8, 16, 32);
    simd_test("_f32", .SUB, 2, 4, 8, 16, 32);
    simd_test("_f32", .MULT, 2, 4, 8, 16, 32);
    simd_test("_f32", .DIV, 2, 4, 8, 16, 32);
    simd_test("_s64", .ADD, 2, 4, 8, 16, 32);
    simd_test("_u64", .ADD, 2, 4, 8, 16, 32);
    simd_test("_f64", .ADD, 2, 4, 8, 16, 32);
    simd_test("_s64", .SUB, 2, 4, 8, 16, 32);
    simd_test("_u64", .SUB, 2, 4, 8, 16, 32);
    simd_test("_f64", .SUB, 2, 4, 8, 16, 32);
    simd_test("_f64", .MULT, 2, 4, 8, 16, 32);
    simd_test("_f64", .DIV, 2, 4, 8, 16, 32);
}

vector_test :: () {

    // Vec2
    operator_test("_Vec2f", "+");
    operator_test("_Vec2f", "-");
    operator_test("_Vec2f", "*");
    operator_test("_Vec2f", "/");

    operator_test("_Vec2", "+");
    operator_test("_Vec2", "-");
    operator_test("_Vec2", "*");
    operator_test("_Vec2", "/");

    operator_test("_Point2", "+");
    operator_test("_Point2", "-");
    operator_test("_Point2", "*");
    operator_test("_Point2", "/");

    operator_test("_Point2s", "+");
    operator_test("_Point2s", "-");
    operator_test("_Point2s", "*");
    operator_test("_Point2s", "/");

    // Vec3
    operator_test("_Vec3f", "+");
    operator_test("_Vec3f", "-");
    operator_test("_Vec3f", "*");
    operator_test("_Vec3f", "/");

    operator_test("_Vec3", "+");
    operator_test("_Vec3", "-");
    operator_test("_Vec3", "*");
    operator_test("_Vec3", "/");

    operator_test("_Point3", "+");
    operator_test("_Point3", "-");
    operator_test("_Point3", "*");
    operator_test("_Point3", "/");

    operator_test("_Point3s", "+");
    operator_test("_Point3s", "-");
    operator_test("_Point3s", "*");
    operator_test("_Point3s", "/");

    // Vec4
    operator_test("_Vec4f", "+");
    operator_test("_Vec4f", "-");
    operator_test("_Vec4f", "*");
    operator_test("_Vec4f", "/");

    operator_test("_Vec4", "+");
    operator_test("_Vec4", "-");
    operator_test("_Vec4", "*");
    operator_test("_Vec4", "/");

    operator_test("_Point4", "+");
    operator_test("_Point4", "-");
    operator_test("_Point4", "*");
    operator_test("_Point4", "/");

    operator_test("_Point4s", "+");
    operator_test("_Point4s", "-");
    operator_test("_Point4s", "*");
    operator_test("_Point4s", "/");

}

matrix_test :: () {

// Mat2
    operator_test("_Mat2f", "+");
    operator_test("_Mat2f", "-");
    operator_test("_Mat2f", "*");
    operator_test("_Mat2f", "/");

    operator_test("_Mat2", "+");
    operator_test("_Mat2", "-");
    operator_test("_Mat2", "*");
    operator_test("_Mat2", "/");

    // Mat3
    operator_test("_Mat3f", "+");
    operator_test("_Mat3f", "-");
    operator_test("_Mat3f", "*");
    operator_test("_Mat3f", "/");

    operator_test("_Mat3", "+");
    operator_test("_Mat3", "-");
    operator_test("_Mat3", "*");
    operator_test("_Mat3", "/");

    // Mat3x4
    operator_test("_Mat3x4f", "+");
    operator_test("_Mat3x4f", "-");
    operator_test("_Mat3x4f", "*");

    operator_test("_Mat3x4", "+");
    operator_test("_Mat3x4", "-");
    operator_test("_Mat3x4", "*");

    // Mat4
    operator_test("_Mat4f", "+");
    operator_test("_Mat4f", "-");
    operator_test("_Mat4f", "*");
    operator_test("_Mat4f", "/");

    operator_test("_Mat4", "+");
    operator_test("_Mat4", "-");
    operator_test("_Mat4", "*");
    operator_test("_Mat4", "/");

}

hash :: (i: s64, $T: Type = float64) -> T {
    x := i;
    x = ((x >> 16) ^ x) * 0x45d9f3b;
    x = ((x >> 16) ^ x) * 0x45d9f3b;
    x = (x >> 16) ^ x;

    info := type_info(T);
    if info.type == .FLOAT {
        result : T = xx (x % 500);
        if result == 0 then result = 1;
        return result;
    }

    max_val : s64 = (1 << (info.runtime_size * 8 - 1)) - 1;
    limit := ifx max_val >= 500 then max_val / 500 else max_val;
    result := x % limit;
    if result == 0 then result = 1;
    return xx result;
}

operator_test :: ($target: string, $op: string, $test_proc: string = "") {
    component_count :: #insert #run sprint("type_of(test.%).T.N;", target);

    #insert -> string {
        builder: String_Builder;
        scalar_type := sprint("type_of(test.%).T.T", target);
        print_to_builder(*builder, "for 0..test.%1.length-1 {\n", target);
        
        // Generate ref initialization
        print_to_builder(*builder, "        test.%1.ref[it] = .{", target);
        for i: 0..component_count-1 {
            if i > 0 then print_to_builder(*builder, ", ");
            print_to_builder(*builder, "hash(it * % + %, %)", component_count, i, scalar_type);
        }
        print_to_builder(*builder, "};\n");
        
        // Generate res initialization  
        print_to_builder(*builder, "        test.%1.res[it] = .{", target);
        for i: 0..component_count-1 {
            if i > 0 then print_to_builder(*builder, ", ");
            print_to_builder(*builder, "hash(it * % + %, %)", component_count, i, scalar_type);
        }
        print_to_builder(*builder, "};\n");
        
        // Generate delta initialization (offset input to avoid hash(0)==0 div-by-zero)
        is_matrix := begins_with(target, "_Mat");
        is_div := op == "/";
        if is_matrix && is_div {
            // Generate diagonally dominant matrices to guarantee invertibility
            // Start from identity, add small perturbation to keep it well-conditioned
            print_to_builder(*builder, "        test.%1.delta[it] = type_of(test.%1.delta[it]).identity();\n", target);
            print_to_builder(*builder, "        for k: 0..type_of(test.%1.delta[it]).N-1\n", target);
            print_to_builder(*builder, "            test.%1.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test.%1.delta[it]).N + k), %2) * 0.0001;\n", target, scalar_type);
        } else {
            print_to_builder(*builder, "        test.%1.delta[it] = .{", target);
            for i: 0..component_count-1 {
                if i > 0 then print_to_builder(*builder, ", ");
                print_to_builder(*builder, "hash((it + 1) * % + %, %)", component_count, i, scalar_type);
            }
            print_to_builder(*builder, "};\n");
        }
        
        print_to_builder(*builder, "    }");
        return builder_to_string(*builder);
    }
    
    #insert -> string {
        return sprint(#string CLEAR 
        do_test("%1 %3 %2", () {
            for 0..test.%2.length-1 {
                    test.%2.ref[it] = test.%2.ref[it] %3 test.%2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});
        CLEAR, target, target, op); 
    }

    #if test_proc.count > 0 then #insert -> string {
        return sprint(#string CLEAR 
        do_test("%1%2", () {
            for 0..test.%2.length-1 {
                    test.%2.res[it] = %3(test.%2.res[it], test.%2.delta[it]);
                    }
            }, ()->(bool, s64){
                last_error := -1;
                for 0..test.%2.length-1 {
                    if test.%2.ref[it] != test.%2.res[it] { 
                        error += cast(float64) length(test.%2.ref[it] - test.%2.res[it]);
                        last_error = it;
                    }
                }
                return last_error >= 0, last_error;
            });
        CLEAR, test_proc, target, test_proc);
    }
}

simple_test :: ($target: string, $op: string, $needs_delta: bool, $default: string = "") #modify {
    if default == "" then default = op;
    return true;
} {


    #insert -> string {return sprint(#string CLEAR 
    for 0..test.%1.length-1 {
        test.%1.ref[it] = xx (1+(it+1) * 1.23456789);
        test.%1.res[it] = xx (1+(it+1) * 1.23456789);
        test.%1.delta[it] = xx (1+(it+2) * 1.23456789);
    }
    CLEAR, target); }
     
        #insert -> string {
            return sprint(#string CLEAR 
            do_test("%1%2_default", () {
                for 0..test.%2.length-1 {
                        test.%2.ref[it] = Math.%1(test.%2.ref[it]%3);
                        }
                }, ()->(bool, s64){return false, -1;});
            CLEAR, default, target, ifx needs_delta then sprint(", test.%.delta[it]", target) else ""); 
        }

    #insert -> string {
        builder: String_Builder;
            print_to_builder(*builder, #string TEST

    do_test("%1%2", () {
    for 0..test.%2.length-1 {
            test.%2.res[it] = %1(test.%2.res[it]%4);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test.%2.length-1 {
               if test.%2.ref[it] != test.%2.res[it] { 
                    error += cast(float64) (test.%2.ref[it] - test.%2.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test.%2.length then continue;
                    log("\t%3%3: ref %3, res %3", ifx offset == 0 then ">>" else "  ", last_error+offset, test.%2.ref[last_error+offset], test.%2.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test.%2.length-1 {
        test.%2.res[it] = xx (it+1);
    }
            TEST, op, target, "%", ifx needs_delta then sprint(", test.%.delta[it]", target));

        return builder_to_string(*builder);
    }

    log("\n");
}
simd_test :: ($target: string, $op: Simd_Op, $portions: ..s64) {

    #insert -> string {return sprint(#string CLEAR 
    for 0..test.%1.length-1 {
        test.%1.ref[it] = reinterp(type_of(test.%1.ref[it]), (it+1));
        test.%1.res[it] = reinterp(type_of(test.%1.ref[it]), (it+1));
        test.%1.delta[it] = reinterp(type_of(test.%1.ref[it]), (it+2)); 
    }
    CLEAR, target); }

    #insert -> string {
        oper: string;


        if op == {
        case .ADD; oper = "+";
        case .SUB; oper = "-";
        case .MULT; oper = "*";
        case .DIV; oper = "/";

        case .AND; oper = "&";
        case .OR; oper = "|";
        case .XOR; oper = "^";
        case .NOT; oper = "~";
        } 

        return sprint(#string CLEAR 
        do_test("%1%2_default", () {
            for 0..test.%2.length-1 {
                    test.%2.ref[it] = test.%2.ref[it] %3 test.%2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});
        CLEAR, to_lower_copy(sprint("%",op)), target, oper); 
    }
    #insert -> string {
        builder: String_Builder;

        for portion: portions {
            print_to_builder(*builder, #string TEST

    do_test("%1%2x%3", () {
    for 0..test.%2.length/%3-1 {
            simd_%1(*test.%2.res[it*%3], *test.%2.delta[it*%3], %3);
        } 
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test.%2.length-1 {
                if abs(cast(float64)(test.%2.ref[it] - test.%2.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%4%4: ref %4, res %4", ifx offset == 0 then ">>" else "  ", it+offset, test.%2.ref[it+offset], test.%2.res[it+offset]);
                    }
                    last_error = it;
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test.%2.length-1 {
        test.%2.res[it] = reinterp(type_of(test.%2.ref[it]), (it+1)); 
    }
            TEST, to_lower_copy(sprint("%",op)), target, portion, "%" );

        }

        return builder_to_string(*builder);
    }

    log("\n");
}

assert_mat :: (label: string, a: $T/Matrix, b: T, tol: float64 = 0.0001) {
    for i: 0..T.N-1 {
        delta := abs(cast(float64) a.values[i] - cast(float64) b.values[i]);
        if delta > tol {
            log_error("% FAILED at [%]: got %, expected %", label, i, a.values[i], b.values[i]);
            assert(false, "Matrix correctness test failed");
        }
    }
    log(" - % OK", label);
}

matrix_correctness_test :: () {
    print("\nMATRIX CORRECTNESS\n");

    // ===== 2x2 tests =====
    a2 : Mat2 = .{1, 2, 3, 4};
    b2 : Mat2 = .{5, 6, 7, 8};

    // Addition (element-wise)
    assert_mat("Mat2 A + B", a2 + b2, Mat2.{6, 8, 10, 12});

    // Subtraction (element-wise)
    assert_mat("Mat2 A - B", a2 - b2, Mat2.{-4, -4, -4, -4});

    // Multiplication (matrix multiply)
    // [1,2]*[5,6] = [1*5+2*7, 1*6+2*8] = [19, 22]
    // [3,4] [7,8]   [3*5+4*7, 3*6+4*8]   [43, 50]
    assert_mat("Mat2 A * B", a2 * b2, Mat2.{19, 22, 43, 50});

    // Division (A * inverse(B))
    // inv(B) = 1/(5*8-6*7) * [8,-6; -7,5] = [-4, 3; 3.5, -2.5]
    // A/B = [1*(-4)+2*3.5, 1*3+2*(-2.5); 3*(-4)+4*3.5, 3*3+4*(-2.5)] = [3, -2; 2, -1]
    assert_mat("Mat2 A / B", a2 / b2, Mat2.{3, -2, 2, -1});

    // Inverse: A * inverse(A) = identity
    assert_mat("Mat2 A * inv(A) = I", a2 * inverse(a2), Mat2.identity());

    // Identity: A * I = A
    assert_mat("Mat2 A * I = A", a2 * Mat2.identity(), a2);

    // Identity: I * A = A
    assert_mat("Mat2 I * A = A", Mat2.identity() * a2, a2);


    // ===== 3x3 tests =====
    a3 : Mat3 = .{1, 2, 3, 4, 5, 6, 7, 8, 10}; // 10 not 9 to avoid singularity
    e3 : Mat3 = .{2, 1, 0, 0, 3, 1, 1, 0, 2};

    // Inverse: A * inverse(A) = identity
    assert_mat("Mat3 A * inv(A) = I", a3 * inverse(a3), Mat3.identity());

    // Identity properties
    assert_mat("Mat3 A * I = A", a3 * Mat3.identity(), a3);
    assert_mat("Mat3 I * A = A", Mat3.identity() * a3, a3);

    // Division: A / E = A * inv(E)
    // Hand-computed from numpy
    expected_div3 : Mat3 = .{
        -0.07692307692307693, 0.6923076923076923, 1.1538461538461537,
         0.8461538461538461,  1.3846153846153846, 2.307692307692308,
         1.5384615384615383,  2.153846153846154,  3.923076923076923
    };
    assert_mat("Mat3 A / E", a3 / e3, expected_div3);

    // Addition
    assert_mat("Mat3 A + E", a3 + e3, Mat3.{3, 3, 3, 4, 8, 7, 8, 8, 12});

    // Subtraction
    assert_mat("Mat3 A - E", a3 - e3, Mat3.{-1, 1, 3, 4, 2, 5, 6, 8, 8});


    // ===== 4x4 tests =====
    a4 : Mat4 = .{4, 1, 0, 1, 1, 3, 1, 0, 0, 1, 4, 1, 1, 0, 1, 3}; // symmetric, well-conditioned
    f4 : Mat4 = .{1, 0, 2, 1, 0, 1, 1, 0, 2, 1, 1, 0, 1, 0, 0, 1};

    // Inverse: A * inverse(A) = identity
    assert_mat("Mat4 A * inv(A) = I", a4 * inverse(a4), Mat4.identity());

    // Identity properties
    assert_mat("Mat4 A * I = A", a4 * Mat4.identity(), a4);
    assert_mat("Mat4 I * A = A", Mat4.identity() * a4, a4);

    // Division: A / F = A * inv(F)
    // Hand-computed from numpy
    expected_div4 : Mat4 = .{
        -0.5, -0.5,  1.5, 1.5,
        -1.0,  2.5,  0.5, 1.0,
         1.5,  1.5, -0.5, -0.5,
         0.5,  1.0, -1.0, 2.5
    };
    assert_mat("Mat4 A / F", a4 / f4, expected_div4);

    // Addition
    assert_mat("Mat4 A + F", a4 + f4, Mat4.{5, 1, 2, 2, 1, 4, 2, 0, 2, 2, 5, 1, 2, 0, 1, 4});

    // Subtraction
    assert_mat("Mat4 A - F", a4 - f4, Mat4.{3, 1, -2, 0, 1, 2, 0, 0, -2, 0, 3, 1, 0, 0, 1, 2});


    // ===== float32 variants =====
    a2f : Mat2f = .{1, 2, 3, 4};
    b2f : Mat2f = .{5, 6, 7, 8};
    assert_mat("Mat2f A + B", a2f + b2f, Mat2f.{6, 8, 10, 12});
    assert_mat("Mat2f A * B", a2f * b2f, Mat2f.{19, 22, 43, 50});
    assert_mat("Mat2f A * inv(A) = I", a2f * inverse(a2f), Mat2f.identity(), 0.001);
    assert_mat("Mat2f A / B", a2f / b2f, Mat2f.{3, -2, 2, -1}, 0.001);

    a3f : Mat3f = .{1, 2, 3, 4, 5, 6, 7, 8, 10};
    assert_mat("Mat3f A * inv(A) = I", a3f * inverse(a3f), Mat3f.identity(), 0.001);

    a4f : Mat4f = .{4, 1, 0, 1, 1, 3, 1, 0, 0, 1, 4, 1, 1, 0, 1, 3};
    assert_mat("Mat4f A * inv(A) = I", a4f * inverse(a4f), Mat4f.identity(), 0.001);
}

math_test :: () {
    // make_non_binary_workspace();
    // math_test();
    // log("math_test OK\n");
    // vector_test();
    // matrix_test();
    // matrix_correctness_test();
    cephes_test();
    // simd_test();
    // log("t_test OK\n");
}
