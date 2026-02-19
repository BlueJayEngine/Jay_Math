#import "Basic";
#import "Compiler";
Math :: #import "Math";
#import "Machine_X64";
#import "Process";
#import "String";

#load "../module.jai";
#load "common.jai";
#load "number.jai";
#load "vector.jai";
#load "matrix.jai";
#load "rotator.jai";




simd_test :: () {
    log("\nSIMD TEST:");

    simd_test("_s8", .ADD);
    simd_test("_u8", .ADD);
    simd_test("_s8", .SUB);
    simd_test("_u8", .SUB);
    simd_test("_s16", .ADD);
    simd_test("_u16", .ADD);
    simd_test("_s16", .SUB);
    simd_test("_u16", .SUB);
    simd_test("_s32", .ADD);
    simd_test("_u32", .ADD);
    simd_test("_f32", .ADD);
    simd_test("_s32", .SUB);
    simd_test("_u32", .SUB);
    simd_test("_f32", .SUB);
    simd_test("_f32", .MULT);
    simd_test("_f32", .DIV);
    simd_test("_s64", .ADD);
    simd_test("_u64", .ADD);
    simd_test("_f64", .ADD);
    simd_test("_s64", .SUB);
    simd_test("_u64", .SUB);
    simd_test("_f64", .SUB);
    simd_test("_f64", .MULT);
    simd_test("_f64", .DIV);
}

hash :: (i: s64, $T: Type = float64) -> T {
    x := i;
    x = ((x >> 16) ^ x) * 0x45d9f3b;
    x = ((x >> 16) ^ x) * 0x45d9f3b;
    x = (x >> 16) ^ x;

    info := type_info(T);
    if info.type == .FLOAT {
        // Map to [-50, 50] with fractional precision
        result : T = xx (x % 10000);
        result = xx (result / 100.0);
        return result;
    }

    max_val : s64 = (1 << (info.runtime_size * 8 - 1)) - 1;
    limit := ifx max_val >= 500 then max_val / 500 else max_val;
    result := x % limit;
    if result == 0 then result = 1;
    return xx result;
}



main :: () {
    test = New(Test);

    // matrix_test();
    // matrix_correctness_test();
    // matrix_transform_test();
    // rotator_test();
    vector_test();
    vector_correctness_test();
    cephes_test();
    scaled_sincos_test();
    sincos_benchmark_test();
    // simd_test();
    free(test);

}
