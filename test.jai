#import "Basic";
#import "Compiler";
Math :: #import "Math";
#import,file "module.jai";
#import "Process";
#import "String";

make_non_binary_workspace :: () {
    set_build_options_dc(.{do_output=false});
}

gt :: (x:$T, label: string) -> string {
    l := stop_at_any(label, "_36");
    if l == "atan2" {
        l = sprint("atan2(%, -%)", x, x);
    } else {
        l = sprint("%(%)", l, x);
    }
    r,res_str := run_command("python3", "-c", sprint(#string CMD
import math,
print(math.%)
CMD, l), sprint("%", x), capture_and_return_output=true);
    return res_str; 
} 

// assert_vec3_matches :: (label: string, jay: Vec3f, reference: Math.Vector3) {
//     dx := abs(jay.x - reference.x);
//     dy := abs(jay.y - reference.y);
//     dz := abs(jay.z - reference.z);
//
//     if (dx > TOLERANCE) || (dy > TOLERANCE) || (dz > TOLERANCE) {
//         log_error("% mismatch. Vec3f = {%, %, %}, Vector3 = {%, %, %}\n",
//                   label, jay.x, jay.y, jay.z, reference.x, reference.y, reference.z);
//         assert(false);
//     }
//
//     log("% OK\n", label);
// }

error: float64 = 0;

assert_close :: (label: string, a: $T/Floats, b: T, index: $inT) {
    delta := abs(a-b);
    error += xx delta;
    if delta > epsilon(T) {
        ground_truth:= gt(cast(float64)index, label); 
        log_error("% mismatch. Index = %, left = %, right = % || GT = %\n", label, index, formatFloat(a, -1, -1, FormatFloat.Mode.SCIENTIFIC), formatFloat(b, -1, -1, FormatFloat.Mode.SCIENTIFIC), ground_truth);
        exit(1);
    } 
}

// math_test :: () {
//     base_jay  := Vec3f.{1.0, 2.0, 3.0};
//     base_math := Math.Vector3.{1.0, 2.0, 3.0};
//
//     delta_jay  := Vec3f.{4.0, 5.0, 6.0};
//     delta_math := Math.Vector3.{4.0, 5.0, 6.0};
//
//     added_jay  := base_jay + delta_jay;
//     added_math := Math.Vector3.{base_math.x + delta_math.x, base_math.y + delta_math.y, base_math.z + delta_math.z};
//     assert_vec3_matches("add", added_jay, added_math);
//
//     sub_jay  := added_jay - delta_jay;
//     sub_math := Math.Vector3.{added_math.x - delta_math.x, added_math.y - delta_math.y, added_math.z - delta_math.z};
//     assert_vec3_matches("subtract", sub_jay, sub_math);
//
//     scaled_jay  := base_jay * 2.5;
//     scaled_math := Math.Vector3.{base_math.x * 2.5, base_math.y * 2.5, base_math.z * 2.5};
//     assert_vec3_matches("scale", scaled_jay, scaled_math);
//
//     divided_jay  := added_jay / 2.0;
//     divided_math := Math.Vector3.{added_math.x / 2.0, added_math.y / 2.0, added_math.z / 2.0};
//     assert_vec3_matches("divide", divided_jay, divided_math);
//
//     component_mul_jay  := base_jay * delta_jay;
//     component_mul_math := Math.Vector3.{base_math.x * delta_math.x, base_math.y * delta_math.y, base_math.z * delta_math.z};
//     assert_vec3_matches("component multiply", component_mul_jay, component_mul_math);
//
//     component_div_jay  := added_jay / Vec3f.{2.0, 5.0, 2.0};
//     component_div_math := Math.Vector3.{added_math.x / 2.0, added_math.y / 5.0, added_math.z / 2.0};
//     assert_vec3_matches("component divide", component_div_jay, component_div_math);
//
//     t32 : float = 0.35;
//     lerped_jay  := lerp(base_jay, delta_jay, cast(float64)t32);
//     lerped_math := Math.lerp(base_math, delta_math, t32);
//     assert_vec3_matches("lerp", lerped_jay, lerped_math);
//
//     length_jay  := length(base_jay);
//     length_math := Math.length(base_math);
//     assert_close("length", length_jay, length_math);
// }

refi32 : []s32;
resi32 : []s32;
deltai32 : []s32;

refi64 : []s64;
resi64 : []s64;


ref32 : [2000000]float32;
res32 : [2000000]float32;

ref64 : [2000000]float64;
res64 : [2000000]float64;

TestT :: #type ()->();

do_test :: (label: string, $code: TestT, checkerror: = false) {
    time: Apollo_Time;
    delta: s64;

    time = current_time_monotonic();

    code();
    
    delta = to_milliseconds(current_time_monotonic() - time);

    if checkerror
        log(" - % error - %", label, error);
    else  
        log(" - % OK - %ms", label, delta);

}

cephes_test :: () {
        

    print("\nFLOOR\n");

    do_test("Math.floor32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.floor(input); 
        }
    });

    do_test("floor32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = floor(input);
        }
    });

    do_test("floor32 - correctness", () {

        error = 0;
        for 0..2000000-1 {
            assert_close("floor32", ref32[it], res32[it], it);
        }
    }, true);

    print("\n");

    do_test("Math.floor64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.floor(input); 
        }
    });

    do_test("floor64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = floor(input);
        }
    });

    do_test("floor64 - correctness", () {

        error = 0;
        for 0..2000000-1 {
            assert_close("floor64", ref64[it], res64[it], it);
        }
    }, true);

    print("\nCEIL\n");

   do_test("Math.ceil32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.ceil(input); 
        }
    });

    do_test("ceil32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = ceil(input);
        }
    });

    do_test("ceil32 - correctness", () {

        error = 0;
        for 0..2000000-1 {
            assert_close("ceil32", ref32[it], res32[it], it);
        }
    }, true);

    print("\n");

    do_test("Math.ceil64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.ceil(input); 
        }
    });

    do_test("ceil64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = ceil(input);
        }
    });

    do_test("ceil64 - correctness", () {

        error = 0;
        for 0..2000000-1 {
            assert_close("ceil64", ref64[it], res64[it], it);
        }
    }, true);

    print("\nSIN\n");

    do_test("Math.sin32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.sin(input); 
        }
    });

    do_test("sin32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = sin(input);
        }
    });

    do_test("sin32 - correctness", () {
        input: float32 = -10000; 
        error = 0;
        for 0..2000000-1 {
            input += PI32;
            assert_close("sin32", ref32[it], res32[it], input);
        }
    }, true);

    print("\n"); 

    do_test("Math.sin64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.sin(input); 
        }
    });

    do_test("sin64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = sin(input);
        }
    });

    do_test("sin64 - correctness", () {

        error = 0;
       
        input: float64 = -10000; 
        
        for 0..2000000-1 {
            input += PI; 
            assert_close("sin64", ref64[it], res64[it], input);
        }

    }, true);

    print("\nMOD\n");

    do_test("Math.mod32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.fmod_cycling(input, 1); 
        }
    });

    do_test("mod32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = mod(input);
        }
    });

    do_test("mod32 - correctness", () {
        input: float32 = -10000; 
        error = 0;
        for 0..2000000-1 {
            input += PI32;
            assert_close("mod32", ref32[it], res32[it], input);
        }
    }, true);

    print("\n"); 

    do_test("Math.mod64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.fmod_cycling(input, 1); 
        }
    });

    do_test("mod64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = mod(input);
        }
    });

    do_test("mod64 - correctness", () {

        error = 0;
        for 0..2000000-1 {
            assert_close("mod64", ref64[it], res64[it], it);
        }
    }, true);


    print("\nCOS\n");

    do_test("Math.cos32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.cos(input); 
        }
    });

    do_test("cos32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = cos(input);
        }
    });

    do_test("cos32 - correctness", () {
        input: float32 = -10000; 
        error = 0;
        for 0..2000000-1 {
            input += PI32;
            assert_close("cos32", ref32[it], res32[it], input);
        }
    }, true);

    print("\n"); 

    do_test("Math.cos64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.cos(input); 
        }
    });

    do_test("cos64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = cos(input);
        }
    });

    do_test("cos64 - correctness", () {

        error = 0;
        for 0..2000000-1 {
            assert_close("cos64", ref64[it], res64[it], it);
        }
    }, true);

    print("\nATAN\n");

    do_test("Math.atan32", () {
        input: float32 = -10000;


        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.atan(input); 
        }
    });

    do_test("atan32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = atan(input);
        }
    });

    do_test("atan32 - correctness", () {

        error = 0;
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32; 
            assert_close("atan32", ref32[it], res32[it], input);
        }
    }, true);  

    print("\n");  

    do_test("Math.atan64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.atan(input); 
        }
    });

    do_test("atan64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = atan(input);
        }
    });

    do_test("atan64 - correctness", () {
        error = 0;
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI; 
            assert_close("atan64", ref64[it], res64[it], input);
        }
    }, true);

    print("\nATAN2 (from the creators of ATAN and ATAN: Origin)\n");

    do_test("Math.atan2_32", () {
        input: float32 = -10000;


        for 0..2000000-1 {
            input += PI32;

            ref32[it] = Math.atan(input); 
        }
    });

    do_test("atan2_32", () {
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32;

            res32[it] = atan(input);
        }
    });

    do_test("atan2_32 - correctness", () {

        error = 0;
        input: float32 = -10000;

        for 0..2000000-1 {
            input += PI32; 
            assert_close("atan2_32", ref32[it], res32[it], input);
        }
    }, true);  

    print("\n");  

    do_test("Math.atan2_64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            ref64[it] = Math.atan2(input, -input); 
        }
    });

    do_test("atan2_64", () {
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI;

            res64[it] = atan2(input, -input); 
        }
    });

    do_test("atan2_64 - correctness", () {

        error = 0;
        input: float64 = -10000;

        for 0..2000000-1 {
            input += PI; 
            assert_close("atan2_64", ref64[it], res64[it], input);
        }
    }, true);

    print("\nSIMD:\n"); 
    
    refi32 = NewArray(200000000, s32);
    resi32 = NewArray(200000000, s32);

    deltai32 = NewArray(200000000, s32);

    for 0..200000000-1 {

        refi32[it] = xx it;
        resi32[it] = xx it;
        deltai32[it] = xx it;
    }

    
    do_test("add_s32_default", () {

        for 0..200000000-1 {
            refi32[it] = refi32[it] + deltai32[it];
        }
    });

    do_test("add_s32_4", () {

        for 0..50000000-1 {
            add_s32_4(*resi32[it*4], *deltai32[it*4]);
        } 
    });

    do_test("add_s32_4 - correctness", () {

        error = 0;

        for 0..200000000-1 {
            assert(refi32[it] == resi32[it], "SIMD error, #% % - %", it,  refi32[it], resi32[it]);     
        }
    }, true); 
   
    for 0..200000000-1 {
        resi32[it] = xx it;
    }

    do_test("add_s32_8", () {

        for 0..25000000-1 {
            add_s32_8(*resi32[it*8], *deltai32[it*8]);
        } 
    });

    do_test("add_s32_8 - correctness", () {

        error = 0;

        for 0..200000000-1 {
            assert(refi32[it] == resi32[it], "SIMD error, #% % - %", it,  refi32[it], resi32[it]);     
        }
    }, true);

    for 0..200000000-1 {
        resi32[it] = xx it;
    }

    do_test("add_s32_16", () {

        for 0..12500000-1 {
            add_s32_16(*resi32[it*16], *deltai32[it*16]);
        } 
    });

    do_test("add_s32_16 - correctness", () {

        error = 0;

        for 0..200000000-1 {
            assert(refi32[it] == resi32[it], "SIMD error, #% % - %", it,  refi32[it], resi32[it]);     
        }
    }, true);
}

math_test :: () {
    // make_non_binary_workspace();
    // math_test();
    // log("math_test OK\n");
    cephes_test();
    log("t_test OK\n");
}
