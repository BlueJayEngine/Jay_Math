assert_close :: (label: string, a: $T/Floats, b: T, index: $inT) {
    delta := abs(a-b);
    error += xx delta;
    if delta > epsilon(T) {
        log_error("% mismatch. Index = %, left = %, right = % \n", label, index, formatFloat(a, -1, -1, FormatFloat.Mode.SCIENTIFIC), formatFloat(b, -1, -1, FormatFloat.Mode.SCIENTIFIC));
        exit(1);
    } 
}

DATA_BYTES :: 70000000; 

Test_Data :: struct(T:Type) {
    ref : [DATA_BYTES/size_of(T)]T;
    delta : [DATA_BYTES/size_of(T)]T;
    res : [DATA_BYTES/size_of(T)]T;
    length :: DATA_BYTES/size_of(T);
}

Test :: union {
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

    _Vec2d: Test_Data(Vec2d);
    _Vec2: Test_Data(Vec2);
    _Point2: Test_Data(Point2);
    _Point2d: Test_Data(Point2d);

    _Vec3d: Test_Data(Vec3d);
    _Vec3: Test_Data(Vec3);
    _Point3: Test_Data(Point3);
    _Point3d: Test_Data(Point3d);

    _Vec4d: Test_Data(Vec4d);
    _Vec4: Test_Data(Vec4);
    _Point4: Test_Data(Point4);
    _Point4d: Test_Data(Point4d);

    _Mat2d: Test_Data(Mat2d);
    _Mat2: Test_Data(Mat2);

    _Mat3d: Test_Data(Mat3d);
    _Mat3: Test_Data(Mat3);

    _Mat3x4d: Test_Data(Mat3d);
    _Mat3x4: Test_Data(Mat3);

    _Mat4d: Test_Data(Mat4d);
    _Mat4: Test_Data(Mat4);
};

test: *Test;

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

