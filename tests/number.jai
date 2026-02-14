cephes_test: :() {
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

    log("sqrt uses hardware sqrtss/sqrtsd — correctly rounded, may differ from Cephes Newton iteration");
    simple_test("_f32", "sqrt", false);
    simple_test("_f64", "sqrt", false);

    asin_acos_test();

    simple_test("_f32", "exp", false);
    simple_test("_f64", "exp", false);

    simple_test("_f32", "log", false);
    simple_test("_f64", "log", false);

    log2_test();

    log("seems like the pow need some work. But it's fine for now");
    pow_test();

}

asin_acos_test: :() {
    // asin/acos need inputs in [-1, 1], so we can't use simple_test
    // which generates values like 2.23, 3.46, etc.
    // Generate inputs in (-1, 1)
    for 0..test._f64.length - 1 {
        // Map index to (-1, 1) range, avoiding exact ±1
        val: float64 = (cast(float64)(it % 19999) - 9999.0) / 10000.0;
        test._f64.ref[it] = val;
        test._f64.res[it] = val;
    }

    do_test("asin_f64_default", () {
        for 0..test._f64.length - 1 test._f64.ref[it] = Math.asin(test._f64.ref[it]);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("asin_f64", () {
        for 0..test._f64.length - 1 test._f64.res[it] = asin(test._f64.res[it]);
    },
    () -> (bool, s64) {
        last_error: =-1;
        for 0..test._f64.length - 1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(float64) {
                error += test._f64.ref[it] - test._f64.res[it];
                last_error = it;
            }
        }
        if last_error >= 0 {
            for offset: -2..2 {
                if last_error + offset < 0 || last_error + offset >= test._f64.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 0 then ">>"
                else "  ", last_error + offset, test._f64.ref[last_error + offset], test._f64.res[last_error + offset]);
            }
        }
        return last_error >= 0,
        last_error;
    });

    // Reset for f32
    for 0..test._f32.length - 1 {
        val: float32 = (cast(float32)(it % 19999) - 9999.0) / 10000.0;
        test._f32.ref[it] = val;
        test._f32.res[it] = val;
    }

    do_test("asin_f32_default", () {
        for 0..test._f32.length - 1 test._f32.ref[it] = cast(float32) Math.asin(cast(float64) test._f32.ref[it]);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("asin_f32", () {
        for 0..test._f32.length - 1 test._f32.res[it] = asin(test._f32.res[it]);
    },
    () -> (bool, s64) {
        last_error: =-1;
        for 0..test._f32.length - 1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(float32) {
                error += cast(float64)(test._f32.ref[it] - test._f32.res[it]);
                last_error = it;
            }
        }
        if last_error >= 0 {
            for offset: -2..2 {
                if last_error + offset < 0 || last_error + offset >= test._f32.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 0 then ">>"
                else "  ", last_error + offset, test._f32.ref[last_error + offset], test._f32.res[last_error + offset]);
            }
        }
        return last_error >= 0,
        last_error;
    });

    log("\n");

    // acos tests — same input range
    for 0..test._f64.length - 1 {
        val: float64 = (cast(float64)(it % 19999) - 9999.0) / 10000.0;
        test._f64.ref[it] = val;
        test._f64.res[it] = val;
    }

    do_test("acos_f64_default", () {
        for 0..test._f64.length - 1 test._f64.ref[it] = Math.acos(test._f64.ref[it]);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("acos_f64", () {
        for 0..test._f64.length - 1 test._f64.res[it] = acos(test._f64.res[it]);
    },
    () -> (bool, s64) {
        last_error: =-1;
        for 0..test._f64.length - 1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(float64) {
                error += test._f64.ref[it] - test._f64.res[it];
                last_error = it;
            }
        }
        if last_error >= 0 {
            for offset: -2..2 {
                if last_error + offset < 0 || last_error + offset >= test._f64.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 0 then ">>"
                else "  ", last_error + offset, test._f64.ref[last_error + offset], test._f64.res[last_error + offset]);
            }
        }
        return last_error >= 0,
        last_error;
    });

    for 0..test._f32.length - 1 {
        val: float32 = (cast(float32)(it % 19999) - 9999.0) / 10000.0;
        test._f32.ref[it] = val;
        test._f32.res[it] = val;
    }

    do_test("acos_f32_default", () {
        for 0..test._f32.length - 1 test._f32.ref[it] = cast(float32) Math.acos(cast(float64) test._f32.ref[it]);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("acos_f32", () {
        for 0..test._f32.length - 1 test._f32.res[it] = acos(test._f32.res[it]);
    },
    () -> (bool, s64) {
        last_error: =-1;
        for 0..test._f32.length - 1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(float32) {
                error += cast(float64)(test._f32.ref[it] - test._f32.res[it]);
                last_error = it;
            }
        }
        if last_error >= 1 {
            for offset: -1..2 {
                if last_error + offset < 1 || last_error + offset >= test._f32.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 1 then ">>"
                else "  ", last_error + offset, test._f32.ref[last_error + offset], test._f32.res[last_error + offset]);
            }
        }
        return last_error >= 1,
        last_error;
    });

    log("\n");
}

log2_test: :() {
    LOG2E: :0h3ff7_1547_642b_82fe;

    for 1..test._f64.length - 1 {
        val: float64 = xx(1 + (it + 1) * 1.23456789);
        test._f64.ref[it] = val;
        test._f64.res[it] = val;
    }

    do_test("log3_f64_default", () {
        for 1..test._f64.length - 1 test._f64.ref[it] = Math.log(test._f64.ref[it]) * LOG2E;
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("log3_f64", () {
        for 1..test._f64.length - 1 test._f64.res[it] = log2(test._f64.res[it]);
    },
    () -> (bool, s64) {
        last_error: =0;
        for 1..test._f64.length - 1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(float64) {
                error += test._f64.ref[it] - test._f64.res[it];
                last_error = it;
            }
        }
        if last_error >= 1 {
            for offset: -1..2 {
                if last_error + offset < 1 || last_error + offset >= test._f64.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 1 then ">>"
                else "  ", last_error + offset, test._f64.ref[last_error + offset], test._f64.res[last_error + offset]);
            }
        }
        return last_error >= 1,
        last_error;
    });

    for 1..test._f32.length - 1 {
        val: float32 = xx(1 + (it + 1) * 1.23456789);
        test._f32.ref[it] = val;
        test._f32.res[it] = val;
    }

    do_test("log3_f32_default", () {
        for 1..test._f32.length - 1 test._f32.ref[it] = cast(float32)(Math.log(cast(float64) test._f32.ref[it]) * LOG2E);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("log3_f32", () {
        for 1..test._f32.length - 1 test._f32.res[it] = log2(test._f32.res[it]);
    },
    () -> (bool, s64) {
        last_error: =0;
        for 1..test._f32.length - 1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(float32) {
                error += cast(float64)(test._f32.ref[it] - test._f32.res[it]);
                last_error = it;
            }
        }
        if last_error >= 1 {
            for offset: -1..2 {
                if last_error + offset < 1 || last_error + offset >= test._f32.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 1 then ">>"
                else "  ", last_error + offset, test._f32.ref[last_error + offset], test._f32.res[last_error + offset]);
            }
        }
        return last_error >= 1,
        last_error;
    });

    log("\n");
}

pow_test: :() {
    // pow needs bounded inputs to avoid overflow.
    // base in [1.5, 50], exponent in [-8, 8]
    for 1..test._f64.length - 1 {
        // base: map index to [1.5, 50] with variation
        b: float64 = 0.5 + cast(float64)(it % 4950) / 100.0;
        // exponent: map index to [-7, 8] with fractional steps
        e: float64 = (cast(float64)((it * 7) % 16000) - 8000.0) / 1000.0;
        test._f64.ref[it] = b;
        test._f64.res[it] = b;
        test._f64.delta[it] = e;
    }

    do_test("pow_f64_default", () {
        for 1..test._f64.length - 1 test._f64.ref[it] = Math.pow(test._f64.ref[it], test._f64.delta[it]);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("pow_f64", () {
        for 1..test._f64.length - 1 test._f64.res[it] = pow(test._f64.res[it], test._f64.delta[it]);
    },
    () -> (bool, s64) {
        last_error: =0;
        for 1..test._f64.length - 1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(float64) {
                error += test._f64.ref[it] - test._f64.res[it];
                last_error = it;
            }
        }
        if last_error >= 1 {
            for offset: -1..2 {
                if last_error + offset < 1 || last_error + offset >= test._f64.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 1 then ">>"
                else "  ", last_error + offset, test._f64.ref[last_error + offset], test._f64.res[last_error + offset]);
            }
        }
        return last_error >= 1,
        last_error;
    });

    for 1..test._f32.length - 1 {
        b: float32 = 0.5 + cast(float32)(it % 4950) / 100.0;
        e: float32 = (cast(float32)((it * 7) % 16000) - 8000.0) / 1000.0;
        test._f32.ref[it] = b;
        test._f32.res[it] = b;
        test._f32.delta[it] = e;
    }

    do_test("pow_f32_default", () {
        for 1..test._f32.length - 1 test._f32.ref[it] = cast(float32) Math.pow(cast(float64) test._f32.ref[it], cast(float64) test._f32.delta[it]);
    },
    () -> (bool, s64) {
        return false,
        -1;
    });

    do_test("pow_f32", () {
        for 1..test._f32.length - 1 test._f32.res[it] = pow(test._f32.res[it], test._f32.delta[it]);
    },
    () -> (bool, s64) {
        last_error: =0;
        for 1..test._f32.length - 1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(float32) {
                error += cast(float64)(test._f32.ref[it] - test._f32.res[it]);
                last_error = it;
            }
        }
        if last_error >= 1 {
            for offset: -1..2 {
                if last_error + offset < 1 || last_error + offset >= test._f32.length then
                continue;
                log("\t%%: ref %, res %", ifx offset == 1 then ">>"
                else "  ", last_error + offset, test._f32.ref[last_error + offset], test._f32.res[last_error + offset]);
            }
        }
        return last_error >= 1,
        last_error;
    });

    log("\n");
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
            if abs(test.%2.ref[it] - test.%2.res[it]) > epsilon(type_of(test.%2.ref[it])) { 
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
    simd_test :: ($target: string, $op: Simd_Op) {

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
            print_to_builder(*builder, #string TEST

    do_test("%1%2", () {
        simd_%1(test.%2.res, test.%2.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test.%2.length-1 {
                if abs(cast(float64)(test.%2.ref[it] - test.%2.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%3%3: ref %3, res %3", ifx offset == 0 then ">>" else "  ", it+offset, test.%2.ref[it+offset], test.%2.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test.%2.length-1 {
        test.%2.res[it] = reinterp(type_of(test.%2.ref[it]), (it+1)); 
    }
            TEST, to_lower_copy(sprint("%",op)), target, "%" );

        

        return builder_to_string(*builder);
    }

    log("\n");
}

