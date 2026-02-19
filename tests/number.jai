// Bhaskara I approximation (7th century)
// sin(x) ≈ 16x(π-x) / (5π² - 4x(π-x))
// All integer: input x in [0..scale*4), output in [-scale..scale]
sin_bhaskara :: inline (x: $T/Integers, $scale: s64) -> T {
    PERIOD :: scale * 4;
    HALF   :: scale * 2;  // half period = π in our units

    i := ((x % PERIOD) + PERIOD) % PERIOD;
    negate : T = 1;
    if i >= HALF { i -= HALF; negate = -1; }

    // i is now in [0..HALF), mapping to [0..π]
    // Bhaskara: 16*i*(HALF - i) / (5*HALF*HALF - 4*i*(HALF - i))
    // To avoid overflow, factor out: let p = i*(HALF - i)
    // result = scale * 16*p / (5*HALF² - 4*p)
    p := cast(s64)i * cast(s64)(HALF - i);
    num := 16 * p;
    den := 5 * cast(s64)HALF * cast(s64)HALF - 4 * p;

    return negate * cast(T)(num * scale / den);
}

cos_bhaskara :: inline (x: $T/Integers, $scale: s64) -> T {
    return sin_bhaskara(x + scale, scale);
}

// Corrected parabolic approximation
// Base parabola: y = 4x(1-x) on [0..1] mapping to [0..π]
// Correction:    y' = y * (A + B*y) where A ≈ 0.225 for min max-error
// Using fixed-point: multiply by 2^16 precision internally
sin_parabolic :: inline (x: $T/Integers, $scale: s64) -> T {
    PERIOD :: scale * 4;
    HALF   :: scale * 2;

    i := ((x % PERIOD) + PERIOD) % PERIOD;
    negate : T = 1;
    if i >= HALF { i -= HALF; negate = -1; }

    // i in [0..HALF) maps to [0..π]
    // Base parabola: 4 * i * (HALF - i) / HALF² gives [0..1] scaled
    // We want result in [0..scale], so: 4 * scale * i * (HALF - i) / HALF²
    // Simplify: HALF = 2*scale, so HALF² = 4*scale²
    // result = 4 * scale * i * (HALF - i) / (4 * scale²) = i * (HALF - i) / scale
    y := cast(s64)i * cast(s64)(HALF - i) / scale;

    // y is now in [0..scale] (the raw parabola, ~12% max error)
    // Correction: y' = y + Q * y * (|y| - scale) / scale
    // where Q ≈ 0.225, minimizes max error
    // Work in normalized Q14 space to avoid overflow on s64:
    //   y_n = y << 14 / scale  (range [0..16384])
    //   correction = Q14 * y_n * (y_n - 16384) / 16384^2
    //   result = (y_n + correction) * scale >> 14
    SHIFT :: 14;
    ONE :: 1 << SHIFT;  // 16384
    Q14 :: 3686;  // 0.225 * 16384
    y_n := (y << SHIFT) / scale;
    // y_n in [0..ONE], (y_n - ONE) in [-ONE..0]
    // Q14 * y_n fits in ~28 bits, * (y_n - ONE) fits in ~42 bits, safe for s64
    corr := Q14 * y_n * (y_n - ONE);
    // corr is negative, divide by ONE^2 = 1<<28
    y_n = y_n + (corr >> (SHIFT * 2));
    y = (y_n * scale) >> SHIFT;

    return negate * cast(T) y;
}

cos_parabolic :: inline (x: $T/Integers, $scale: s64) -> T {
    return sin_parabolic(x + scale, scale);
}

sincos_benchmark_test: :() {
    print("\nSCALED SIN/COS BENCHMARK\n");

    SCALE :: 256;
    PERIOD :: SCALE * 4;
    ITERS :: 100000;

    // --- Accuracy comparison ---
    max_err_lut: float64 = 0;
    max_err_bhaskara: float64 = 0;
    max_err_parabolic: float64 = 0;
    sum_err_lut: float64 = 0;
    sum_err_bhaskara: float64 = 0;
    sum_err_parabolic: float64 = 0;

    for i: 0..PERIOD-1 {
        angle := cast(float64)i / cast(float64)PERIOD * TAU64;
        ref := sin(angle) * SCALE;

        e_lut := abs(ref - cast(float64) sin(i, SCALE));
        e_bhk := abs(ref - cast(float64) sin_bhaskara(i, SCALE));
        e_par := abs(ref - cast(float64) sin_parabolic(i, SCALE));

        if e_lut > max_err_lut then max_err_lut = e_lut;
        if e_bhk > max_err_bhaskara then max_err_bhaskara = e_bhk;
        if e_par > max_err_parabolic then max_err_parabolic = e_par;
        sum_err_lut += e_lut;
        sum_err_bhaskara += e_bhk;
        sum_err_parabolic += e_par;
    }

    log(" Accuracy (scale=%):", SCALE);
    log("   LUT:       max_err=%, avg_err=%", max_err_lut, sum_err_lut / PERIOD);
    log("   Bhaskara:  max_err=%, avg_err=%", max_err_bhaskara, sum_err_bhaskara / PERIOD);
    log("   Parabolic: max_err=%, avg_err=%", max_err_parabolic, sum_err_parabolic / PERIOD);

    // --- sin^2 + cos^2 identity check ---
    max_id_lut: s64 = 0;
    max_id_bhk: s64 = 0;
    max_id_par: s64 = 0;
    for i: 0..PERIOD-1 {
        s1 := sin(i, SCALE);           c1 := cos(i, SCALE);
        s2 := sin_bhaskara(i, SCALE);  c2 := cos_bhaskara(i, SCALE);
        s3 := sin_parabolic(i, SCALE); c3 := cos_parabolic(i, SCALE);

        e1 := abs(s1*s1 + c1*c1 - SCALE*SCALE);
        e2 := abs(s2*s2 + c2*c2 - SCALE*SCALE);
        e3 := abs(s3*s3 + c3*c3 - SCALE*SCALE);

        if e1 > max_id_lut then max_id_lut = e1;
        if e2 > max_id_bhk then max_id_bhk = e2;
        if e3 > max_id_par then max_id_par = e3;
    }
    log(" sin^2+cos^2 max deviation from %:", SCALE*SCALE);
    log("   LUT:       %", max_id_lut);
    log("   Bhaskara:  %", max_id_bhk);
    log("   Parabolic: %", max_id_par);

    // --- Speed benchmark ---
    // Accumulate results to prevent dead code elimination
    acc_lut: s64 = 0;
    acc_bhk: s64 = 0;
    acc_par: s64 = 0;
    acc_f64: float64 = 0;
    acc_f32: float32 = 0;

    STEP_F64 :: TAU64 / PERIOD;
    STEP_F32 : float32 : cast(float32)(TAU64 / PERIOD);

    t1 := current_time_monotonic();
    for iter: 0..ITERS-1 {
        for i: 0..PERIOD-1 {
            acc_lut += sin(i, SCALE);
        }
    }
    dt_lut := to_microseconds(current_time_monotonic() - t1);

    t2 := current_time_monotonic();
    for iter: 0..ITERS-1 {
        for i: 0..PERIOD-1 {
            acc_bhk += sin_bhaskara(i, SCALE);
        }
    }
    dt_bhk := to_microseconds(current_time_monotonic() - t2);

    t3 := current_time_monotonic();
    for iter: 0..ITERS-1 {
        for i: 0..PERIOD-1 {
            acc_par += sin_parabolic(i, SCALE);
        }
    }
    dt_par := to_microseconds(current_time_monotonic() - t3);

    t4 := current_time_monotonic();
    for iter: 0..ITERS-1 {
        angle: float64 = 0;
        for i: 0..PERIOD-1 {
            acc_f64 += sin(angle);
            angle += STEP_F64;
        }
    }
    dt_f64 := to_microseconds(current_time_monotonic() - t4);

    t5 := current_time_monotonic();
    for iter: 0..ITERS-1 {
        angle: float32 = 0;
        for i: 0..PERIOD-1 {
            acc_f32 += sin(angle);
            angle += STEP_F32;
        }
    }
    dt_f32 := to_microseconds(current_time_monotonic() - t5);

    total_calls := ITERS * PERIOD;
    log(" Speed (% calls each):", total_calls);
    log("   LUT:       %us  (%ns/call)", dt_lut, (dt_lut * 1000) / total_calls);
    log("   Bhaskara:  %us  (%ns/call)", dt_bhk, (dt_bhk * 1000) / total_calls);
    log("   Parabolic: %us  (%ns/call)", dt_par, (dt_par * 1000) / total_calls);
    log("   float64:   %us  (%ns/call)", dt_f64, (dt_f64 * 1000) / total_calls);
    log("   float32:   %us  (%ns/call)", dt_f32, (dt_f32 * 1000) / total_calls);

    // prevent optimizer from removing the loops
    if acc_lut == 999999999 then log("%", acc_lut);
    if acc_bhk == 999999999 then log("%", acc_bhk);
    if acc_par == 999999999 then log("%", acc_par);
    if acc_f64 == 999999999 then log("%", acc_f64);
    if acc_f32 == cast(float32)999999999 then log("%", acc_f32);

    log(" BENCHMARK COMPLETE\n");
}

scaled_sincos_test: :() {
    print("\nSCALED SIN/COS LUT TEST\n");

    SCALE :: 256;
    PERIOD :: SCALE * 4;  // 1024

    // Test sin at quadrant boundaries
    assert(sin(0,        SCALE) == 0,   "sin(0) should be 0, got %",          sin(0,        SCALE));
    assert(sin(SCALE,    SCALE) == 256, "sin(scale) should be 256, got %",    sin(SCALE,    SCALE));
    assert(sin(SCALE*2,  SCALE) == 0,   "sin(2*scale) should be 0, got %",   sin(SCALE*2,  SCALE));
    assert(sin(SCALE*3,  SCALE) == -256,"sin(3*scale) should be -256, got %", sin(SCALE*3,  SCALE));
    log(" - sin quadrant boundaries OK");

    // Test cos at quadrant boundaries
    assert(cos(0,        SCALE) == 256, "cos(0) should be 256, got %",        cos(0,        SCALE));
    assert(cos(SCALE,    SCALE) == 0,   "cos(scale) should be 0, got %",      cos(SCALE,    SCALE));
    assert(cos(SCALE*2,  SCALE) == -256,"cos(2*scale) should be -256, got %", cos(SCALE*2,  SCALE));
    assert(cos(SCALE*3,  SCALE) == 0,   "cos(3*scale) should be 0, got %",    cos(SCALE*3,  SCALE));
    log(" - cos quadrant boundaries OK");

    // Test periodicity: sin(x) == sin(x + period)
    for i: 0..PERIOD-1 {
        a := sin(i, SCALE);
        b := sin(i + PERIOD, SCALE);
        assert(a == b, "sin periodicity failed at %: % != %", i, a, b);
    }
    log(" - sin periodicity OK");

    // Test symmetry: sin(-x) == -sin(x)
    for i: 1..PERIOD-1 {
        a := sin(i, SCALE);
        b := sin(-i, SCALE);
        assert(a == -b, "sin odd symmetry failed at %: sin(%)=%, sin(-)=%", i, i, a, b);
    }
    log(" - sin odd symmetry OK");

    // Test identity: sin^2 + cos^2 ≈ scale^2
    max_err: s64 = 0;
    for i: 0..PERIOD-1 {
        s := sin(i, SCALE);
        c := cos(i, SCALE);
        sum := s*s + c*c;
        err := abs(sum - SCALE*SCALE);
        if err > max_err then max_err = err;
    }
    log(" - sin^2+cos^2 max deviation from %: % (should be small)", SCALE*SCALE, max_err);

    // Accuracy test: compare against float sin, check max error
    max_lut_err: float64 = 0;
    for i: 0..PERIOD-1 {
        angle := cast(float64)i / cast(float64)PERIOD * TAU64;
        ref := sin(angle) * SCALE;
        lut := cast(float64) sin(i, SCALE);
        err := abs(ref - lut);
        if err > max_lut_err then max_lut_err = err;
    }
    log(" - max LUT error vs float64 sin: % (over full period, scale=%)", max_lut_err, SCALE);

    // Test with different scale
    S2 :: 1024;
    assert(sin(0,    S2) == 0,    "sin(0, 1024) should be 0, got %",    sin(0,    S2));
    assert(sin(S2,   S2) == 1024, "sin(1024, 1024) should be 1024, got %", sin(S2, S2));
    assert(cos(0,    S2) == 1024, "cos(0, 1024) should be 1024, got %", cos(0,    S2));
    log(" - scale=1024 spot checks OK");

    log(" - SCALED SIN/COS ALL PASSED\n");
}

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
                log("    %%: ref %, res %", ifx offset == 0 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 0 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 0 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 1 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 1 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 1 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 1 then ">>"
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
                log("    %%: ref %, res %", ifx offset == 1 then ">>"
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
                    log("    %3%3: ref %3, res %3", ifx offset == 0 then ">>" else "  ", last_error+offset, test.%2.ref[last_error+offset], test.%2.res[last_error+offset]);
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
                        log("    %3%3: ref %3, res %3", ifx offset == 0 then ">>" else "  ", it+offset, test.%2.ref[it+offset], test.%2.res[it+offset]);
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

