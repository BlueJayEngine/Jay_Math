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
    _Vec2d: Test_Data(Vec2d);
    _Vec2s: Test_Data(Vec2s);
    _Vec2u: Test_Data(Vec2u);

    _Vec3f: Test_Data(Vec3f);
    _Vec3d: Test_Data(Vec3d);
    _Vec3s: Test_Data(Vec3s);
    _Vec3u: Test_Data(Vec3u);

    _Vec4f: Test_Data(Vec4f);
    _Vec4d: Test_Data(Vec4d);
    _Vec4s: Test_Data(Vec4s);
    _Vec4u: Test_Data(Vec4u);

    _Mat2f: Test_Data(Mat2f);
    _Mat2d: Test_Data(Mat2d);

    _Mat3f: Test_Data(Mat3f);
    _Mat3d: Test_Data(Mat3d);

    _Mat4f: Test_Data(Mat4f);
    _Mat4d: Test_Data(Mat4d);
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
    vector_test("_Vec2f", "+");
    vector_test("_Vec2f", "-");
    vector_test("_Vec2f", "*");
    vector_test("_Vec2f", "/");

    vector_test("_Vec2d", "+");
    vector_test("_Vec2d", "-");
    vector_test("_Vec2d", "*");
    vector_test("_Vec2d", "/");

    vector_test("_Vec2s", "+");
    vector_test("_Vec2s", "-");
    vector_test("_Vec2s", "*");
    vector_test("_Vec2s", "/");

    vector_test("_Vec2u", "+");
    vector_test("_Vec2u", "-");
    vector_test("_Vec2u", "*");
    vector_test("_Vec2u", "/");

    // Vec3
    vector_test("_Vec3f", "+");
    vector_test("_Vec3f", "-");
    vector_test("_Vec3f", "*");
    vector_test("_Vec3f", "/");

    vector_test("_Vec3d", "+");
    vector_test("_Vec3d", "-");
    vector_test("_Vec3d", "*");
    vector_test("_Vec3d", "/");

    vector_test("_Vec3s", "+");
    vector_test("_Vec3s", "-");
    vector_test("_Vec3s", "*");
    vector_test("_Vec3s", "/");

    vector_test("_Vec3u", "+");
    vector_test("_Vec3u", "-");
    vector_test("_Vec3u", "*");
    vector_test("_Vec3u", "/");

    // Vec4
    vector_test("_Vec4f", "+");
    vector_test("_Vec4f", "-");
    vector_test("_Vec4f", "*");
    vector_test("_Vec4f", "/");

    vector_test("_Vec4d", "+");
    vector_test("_Vec4d", "-");
    vector_test("_Vec4d", "*");
    vector_test("_Vec4d", "/");

    vector_test("_Vec4s", "+");
    vector_test("_Vec4s", "-");
    vector_test("_Vec4s", "*");
    vector_test("_Vec4s", "/");

    vector_test("_Vec4u", "+");
    vector_test("_Vec4u", "-");
    vector_test("_Vec4u", "*");
    vector_test("_Vec4u", "/");

}

vector_test :: ($target: string, $op: string, $test_proc: string = "") {
    #insert,scope() -> string {
        // Determine the component count from the target type
        component_count := 3;
        if contains(target, "Vec4") then component_count = 4;
        if contains(target, "Vec2") then component_count = 2;
        
        builder: String_Builder;
        print_to_builder(*builder, "for 0..test.%1.length-1 {\n", target);
        
        // Generate ref initialization
        print_to_builder(*builder, "        test.%1.ref[it] = .{", target);
        for i: 0..component_count-1 {
            if i > 0 then print_to_builder(*builder, ", ");
            if i == 0 print_to_builder(*builder, "xx (it/2)");
            else if i == 1 print_to_builder(*builder, "xx (it*2)");
            else if i == 2 print_to_builder(*builder, "xx (it*PI)");
           else print_to_builder(*builder, "xx (it*3.21098)"); 
        }
        print_to_builder(*builder, "};\n");
        
        // Generate res initialization  
        print_to_builder(*builder, "        test.%1.res[it] = .{", target);
        for i: 0..component_count-1 {
            if i > 0 then print_to_builder(*builder, ", ");
            if i == 0 print_to_builder(*builder, "xx (it/2)");
            else if i == 1 print_to_builder(*builder, "xx (it*2)");
            else if i == 2 print_to_builder(*builder, "xx (it*PI)");
            else print_to_builder(*builder, "xx (it*3.21098)");
        }
        print_to_builder(*builder, "};\n");
        
        // Generate delta initialization
        print_to_builder(*builder, "        test.%1.delta[it] = .{", target);
        for i: 0..component_count-1 {
            if i > 0 then print_to_builder(*builder, ", ");
            if i == 0 print_to_builder(*builder, "xx (it*5+5)");
            else if i == 1 print_to_builder(*builder, "xx (it/3.5+1)");
            else if i == 2 print_to_builder(*builder, "xx (it*TAU+2)");
            else print_to_builder(*builder, "xx (it/PI+1)");
        }
        print_to_builder(*builder, "};\n");
        
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
        log("\n");
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

math_test :: () {
    // make_non_binary_workspace();
    // math_test();
    // log("math_test OK\n");
    vector_test();
    // cephes_test();
    simd_test();
    // log("t_test OK\n");
}
