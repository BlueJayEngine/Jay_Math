vector_test :: () {

    // Vec2
    operator_test("_Vec2d", "+");
    operator_test("_Vec2d", "-");
    operator_test("_Vec2d", "*");
    operator_test("_Vec2d", "/");

    operator_test("_Vec2", "+");
    operator_test("_Vec2", "-");
    operator_test("_Vec2", "*");
    operator_test("_Vec2", "/");

    operator_test("_Point2", "+");
    operator_test("_Point2", "-");
    operator_test("_Point2", "*");
    operator_test("_Point2", "/");

    operator_test("_Point2d", "+");
    operator_test("_Point2d", "-");
    operator_test("_Point2d", "*");
    operator_test("_Point2d", "/");

    // Vec3
    operator_test("_Vec3d", "+");
    operator_test("_Vec3d", "-");
    operator_test("_Vec3d", "*");
    operator_test("_Vec3d", "/");

    operator_test("_Vec3", "+");
    operator_test("_Vec3", "-");
    operator_test("_Vec3", "*");
    operator_test("_Vec3", "/");

    operator_test("_Point3", "+");
    operator_test("_Point3", "-");
    operator_test("_Point3", "*");
    operator_test("_Point3", "/");

    operator_test("_Point3d", "+");
    operator_test("_Point3d", "-");
    operator_test("_Point3d", "*");
    operator_test("_Point3d", "/");

    // Vec4
    operator_test("_Vec4d", "+");
    operator_test("_Vec4d", "-");
    operator_test("_Vec4d", "*");
    operator_test("_Vec4d", "/");

    operator_test("_Vec4", "+");
    operator_test("_Vec4", "-");
    operator_test("_Vec4", "*");
    operator_test("_Vec4", "/");

    operator_test("_Point4", "+");
    operator_test("_Point4", "-");
    operator_test("_Point4", "*");
    operator_test("_Point4", "/");

    operator_test("_Point4d", "+");
    operator_test("_Point4d", "-");
    operator_test("_Point4d", "*");
    operator_test("_Point4d", "/");
}

assert_vec :: (label: string, a: $VT/Vector, b: VT, tol: float64 = 0.0001) {
    for i: 0..VT.N-1 {
        delta := abs(cast(float64) a.values[i] - cast(float64) b.values[i]);
        if delta > tol {
            log_error("% FAILED at [%]: got %, expected %", label, i, a.values[i], b.values[i]);
            assert(false, "Vector correctness test failed");
        }
    }
    log(" - % OK", label);
}

assert_vec_int :: (label: string, a: $VT/Vector, b: VT) {
    for i: 0..VT.N-1 {
        if a.values[i] != b.values[i] {
            log_error("% FAILED at [%]: got %, expected %", label, i, a.values[i], b.values[i]);
            assert(false, "Vector correctness test failed");
        }
    }
    log(" - % OK", label);
}

vector_correctness_test :: () {
    print("\nVECTOR CORRECTNESS\n");

    // ===== Vec2 (float32) =====
    {
        a : Vec2 = .{1, 2};
        b : Vec2 = .{3, 5};

        assert_vec("Vec2 a + b", a + b, Vec2.{4, 7});
        assert_vec("Vec2 a - b", a - b, Vec2.{-2, -3});
        assert_vec("Vec2 a * b", a * b, Vec2.{3, 10});
        assert_vec("Vec2 a / b", a / b, Vec2.{1.0/3.0, 2.0/5.0});

        // scalar ops
        assert_vec("Vec2 a + 10", a + 10, Vec2.{11, 12});
        assert_vec("Vec2 a - 1",  a - 1,  Vec2.{0, 1});
        assert_vec("Vec2 a * 3",  a * 3,  Vec2.{3, 6});
        assert_vec("Vec2 a / 2",  a / 2,  Vec2.{0.5, 1});

        // symmetric: scalar + vec
        assert_vec("Vec2 10 + a", 10 + a, Vec2.{11, 12});
        assert_vec("Vec2 3 * a",  3 * a,  Vec2.{3, 6});

        // equality
        assert(a == Vec2.{1, 2},  "Vec2 == failed");
        assert(a != b,            "Vec2 != failed (all differ)");
        assert(!(a == b),         "Vec2 == false positive");
        assert(!(a != Vec2.{1, 2}), "Vec2 != false positive");
        // partial difference: only one component differs
        assert(a != Vec2.{1, 99}, "Vec2 != failed (y differs)");
        assert(a != Vec2.{99, 2}, "Vec2 != failed (x differs)");
        log(" - Vec2 == / != OK");

        // dot
        // 1*3 + 2*5 = 13
        d := dot(a, b);
        assert(abs(d - 13.0) < 0.0001, "Vec2 dot failed: got %, expected 13", d);
        log(" - Vec2 dot OK");

        // length_sqr: 1^2 + 2^2 = 5
        lsq := length_sqr(a);
        assert(abs(lsq - 5.0) < 0.0001, "Vec2 length_sqr failed: got %, expected 5", lsq);
        log(" - Vec2 length_sqr OK");

        // length: sqrt(5) ≈ 2.2360679
        l := length(a);
        assert(abs(l - 2.2360679) < 0.001, "Vec2 length failed: got %", l);
        log(" - Vec2 length OK");

        // lerp: a + (b - a) * 0.5 = (2, 3.5)
        lr := lerp(a, b, 0.5);
        assert_vec("Vec2 lerp(a,b,0.5)", lr, Vec2.{2, 3.5});

        // lerp endpoints
        assert_vec("Vec2 lerp(a,b,0)", lerp(a, b, 0), a);
        assert_vec("Vec2 lerp(a,b,1)", lerp(a, b, 1), b);
    }

    // ===== Vec2d (float64) =====
    {
        a : Vec2d = .{1, 2};
        b : Vec2d = .{3, 5};

        assert_vec("Vec2d a + b", a + b, Vec2d.{4, 7});
        assert_vec("Vec2d a - b", a - b, Vec2d.{-2, -3});
        assert_vec("Vec2d a * b", a * b, Vec2d.{3, 10});
        assert_vec("Vec2d a / b", a / b, Vec2d.{1.0/3.0, 2.0/5.0});

        assert_vec("Vec2d a * 3", a * 3, Vec2d.{3, 6});
        assert_vec("Vec2d a / 2", a / 2, Vec2d.{0.5, 1});

        d := dot(a, b);
        assert(abs(d - 13.0) < 0.0001, "Vec2d dot failed: got %", d);
        log(" - Vec2d dot OK");
    }

    // ===== Point2 (s32) =====
    {
        a : Point2 = .{4, 9};
        b : Point2 = .{2, 3};

        assert_vec_int("Point2 a + b", a + b, Point2.{6, 12});
        assert_vec_int("Point2 a - b", a - b, Point2.{2, 6});
        assert_vec_int("Point2 a * b", a * b, Point2.{8, 27});
        assert_vec_int("Point2 a / b", a / b, Point2.{2, 3});

        assert_vec_int("Point2 a + 1", a + cast(s32)1, Point2.{5, 10});
        assert_vec_int("Point2 a * 3", a * cast(s32)3, Point2.{12, 27});

        assert(a == Point2.{4, 9}, "Point2 == failed");
        assert(a != b,             "Point2 != failed (all differ)");
        assert(a != Point2.{4, 99}, "Point2 != failed (y differs)");
        assert(a != Point2.{99, 9}, "Point2 != failed (x differs)");
        log(" - Point2 == / != OK");

        d := dot(a, b);
        assert(d == 35, "Point2 dot failed: got %, expected 35", d);
        log(" - Point2 dot OK");
    }

    // ===== Point2d (s64) =====
    {
        a : Point2d = .{4, 9};
        b : Point2d = .{2, 3};

        assert_vec_int("Point2d a + b", a + b, Point2d.{6, 12});
        assert_vec_int("Point2d a - b", a - b, Point2d.{2, 6});
        assert_vec_int("Point2d a * b", a * b, Point2d.{8, 27});
        assert_vec_int("Point2d a / b", a / b, Point2d.{2, 3});

        d := dot(a, b);
        assert(d == 35, "Point2d dot failed: got %, expected 35", d);
        log(" - Point2d dot OK");
    }

    // ===== Vec3 (float32) =====
    {
        a : Vec3 = .{1, 2, 3};
        b : Vec3 = .{4, 5, 6};

        assert_vec("Vec3 a + b", a + b, Vec3.{5, 7, 9});
        assert_vec("Vec3 a - b", a - b, Vec3.{-3, -3, -3});
        assert_vec("Vec3 a * b", a * b, Vec3.{4, 10, 18});
        assert_vec("Vec3 a / b", a / b, Vec3.{0.25, 0.4, 0.5});

        assert_vec("Vec3 a + 10", a + 10, Vec3.{11, 12, 13});
        assert_vec("Vec3 a * 2",  a * 2,  Vec3.{2, 4, 6});
        assert_vec("Vec3 a / 2",  a / 2,  Vec3.{0.5, 1, 1.5});

        assert_vec("Vec3 10 + a", 10 + a, Vec3.{11, 12, 13});
        assert_vec("Vec3 2 * a",  2 * a,  Vec3.{2, 4, 6});

        assert(a == Vec3.{1, 2, 3}, "Vec3 == failed");
        assert(a != b,              "Vec3 != failed (all differ)");
        // partial difference: only one component differs
        assert(a != Vec3.{99, 2, 3}, "Vec3 != failed (x differs)");
        assert(a != Vec3.{1, 99, 3}, "Vec3 != failed (y differs)");
        assert(a != Vec3.{1, 2, 99}, "Vec3 != failed (z differs)");
        log(" - Vec3 == / != OK");

        // dot: 1*4 + 2*5 + 3*6 = 32
        d := dot(a, b);
        assert(abs(d - 32.0) < 0.0001, "Vec3 dot failed: got %, expected 32", d);
        log(" - Vec3 dot OK");

        // length_sqr: 1 + 4 + 9 = 14
        lsq := length_sqr(a);
        assert(abs(lsq - 14.0) < 0.0001, "Vec3 length_sqr failed: got %, expected 14", lsq);
        log(" - Vec3 length_sqr OK");

        // length: sqrt(14) ≈ 3.7416573
        l := length(a);
        assert(abs(l - 3.7416573) < 0.001, "Vec3 length failed: got %", l);
        log(" - Vec3 length OK");

        // lerp
        assert_vec("Vec3 lerp(a,b,0.5)", lerp(a, b, 0.5), Vec3.{2.5, 3.5, 4.5});
        assert_vec("Vec3 lerp(a,b,0)",   lerp(a, b, 0),    a);
        assert_vec("Vec3 lerp(a,b,1)",   lerp(a, b, 1),    b);
    }

    // ===== Vec3d (float64) =====
    {
        a : Vec3d = .{1, 2, 3};
        b : Vec3d = .{4, 5, 6};

        assert_vec("Vec3d a + b", a + b, Vec3d.{5, 7, 9});
        assert_vec("Vec3d a - b", a - b, Vec3d.{-3, -3, -3});
        assert_vec("Vec3d a * b", a * b, Vec3d.{4, 10, 18});
        assert_vec("Vec3d a / b", a / b, Vec3d.{0.25, 0.4, 0.5});

        d := dot(a, b);
        assert(abs(d - 32.0) < 0.0001, "Vec3d dot failed: got %", d);
        log(" - Vec3d dot OK");
    }

    // ===== Point3 (s32) =====
    {
        a : Point3 = .{6, 10, 15};
        b : Point3 = .{2, 5, 3};

        assert_vec_int("Point3 a + b", a + b, Point3.{8, 15, 18});
        assert_vec_int("Point3 a - b", a - b, Point3.{4, 5, 12});
        assert_vec_int("Point3 a * b", a * b, Point3.{12, 50, 45});
        assert_vec_int("Point3 a / b", a / b, Point3.{3, 2, 5});

        // dot: 6*2 + 10*5 + 15*3 = 12 + 50 + 45 = 107
        d := dot(a, b);
        assert(d == 107, "Point3 dot failed: got %, expected 107", d);
        log(" - Point3 dot OK");
    }

    // ===== Vec4 (float32) =====
    {
        a : Vec4 = .{1, 2, 3, 4};
        b : Vec4 = .{5, 6, 7, 8};

        assert_vec("Vec4 a + b", a + b, Vec4.{6, 8, 10, 12});
        assert_vec("Vec4 a - b", a - b, Vec4.{-4, -4, -4, -4});
        assert_vec("Vec4 a * b", a * b, Vec4.{5, 12, 21, 32});
        assert_vec("Vec4 a / b", a / b, Vec4.{0.2, 1.0/3.0, 3.0/7.0, 0.5});

        assert_vec("Vec4 a + 1", a + 1, Vec4.{2, 3, 4, 5});
        assert_vec("Vec4 a * 2", a * 2, Vec4.{2, 4, 6, 8});
        assert_vec("Vec4 a / 4", a / 4, Vec4.{0.25, 0.5, 0.75, 1});

        assert(a == Vec4.{1, 2, 3, 4}, "Vec4 == failed");
        assert(a != b,                  "Vec4 != failed (all differ)");
        // partial difference: only one component differs
        assert(a != Vec4.{99, 2, 3, 4}, "Vec4 != failed (x differs)");
        assert(a != Vec4.{1, 99, 3, 4}, "Vec4 != failed (y differs)");
        assert(a != Vec4.{1, 2, 99, 4}, "Vec4 != failed (z differs)");
        assert(a != Vec4.{1, 2, 3, 99}, "Vec4 != failed (w differs)");
        log(" - Vec4 == / != OK");

        // dot: 1*5 + 2*6 + 3*7 + 4*8 = 5 + 12 + 21 + 32 = 70
        d := dot(a, b);
        assert(abs(d - 70.0) < 0.0001, "Vec4 dot failed: got %, expected 70", d);
        log(" - Vec4 dot OK");

        // length_sqr: 1 + 4 + 9 + 16 = 30
        lsq := length_sqr(a);
        assert(abs(lsq - 30.0) < 0.0001, "Vec4 length_sqr failed: got %, expected 30", lsq);
        log(" - Vec4 length_sqr OK");

        // length: sqrt(30) ≈ 5.4772255
        l := length(a);
        assert(abs(l - 5.4772255) < 0.001, "Vec4 length failed: got %", l);
        log(" - Vec4 length OK");

        // lerp
        assert_vec("Vec4 lerp(a,b,0.5)", lerp(a, b, 0.5), Vec4.{3, 4, 5, 6});
        assert_vec("Vec4 lerp(a,b,0)",   lerp(a, b, 0),    a);
        assert_vec("Vec4 lerp(a,b,1)",   lerp(a, b, 1),    b);
    }

    // ===== Vec4d (float64) =====
    {
        a : Vec4d = .{1, 2, 3, 4};
        b : Vec4d = .{5, 6, 7, 8};

        assert_vec("Vec4d a + b", a + b, Vec4d.{6, 8, 10, 12});
        assert_vec("Vec4d a - b", a - b, Vec4d.{-4, -4, -4, -4});
        assert_vec("Vec4d a * b", a * b, Vec4d.{5, 12, 21, 32});
        assert_vec("Vec4d a / b", a / b, Vec4d.{0.2, 1.0/3.0, 3.0/7.0, 0.5});

        d := dot(a, b);
        assert(abs(d - 70.0) < 0.0001, "Vec4d dot failed: got %", d);
        log(" - Vec4d dot OK");
    }

    // ===== Point4 (s32) =====
    {
        a : Point4 = .{8, 12, 20, 100};
        b : Point4 = .{2, 3, 4, 10};

        assert_vec_int("Point4 a + b", a + b, Point4.{10, 15, 24, 110});
        assert_vec_int("Point4 a - b", a - b, Point4.{6, 9, 16, 90});
        assert_vec_int("Point4 a * b", a * b, Point4.{16, 36, 80, 1000});
        assert_vec_int("Point4 a / b", a / b, Point4.{4, 4, 5, 10});

        // dot: 8*2 + 12*3 + 20*4 + 100*10 = 16 + 36 + 80 + 1000 = 1132
        d := dot(a, b);
        assert(d == 1132, "Point4 dot failed: got %, expected 1132", d);
        log(" - Point4 dot OK");
    }

    // ===== Point4d (s64) =====
    {
        a : Point4d = .{8, 12, 20, 100};
        b : Point4d = .{2, 3, 4, 10};

        assert_vec_int("Point4d a + b", a + b, Point4d.{10, 15, 24, 110});
        assert_vec_int("Point4d a - b", a - b, Point4d.{6, 9, 16, 90});
        assert_vec_int("Point4d a * b", a * b, Point4d.{16, 36, 80, 1000});
        assert_vec_int("Point4d a / b", a / b, Point4d.{4, 4, 5, 10});

        d := dot(a, b);
        assert(d == 1132, "Point4d dot failed: got %, expected 1132", d);
        log(" - Point4d dot OK");
    }

    // ===== Edge cases =====
    {
        // zero vector
        z : Vec3 = .{0, 0, 0};
        a : Vec3 = .{1, 2, 3};
        assert_vec("Vec3 a + zero", a + z, a);
        assert_vec("Vec3 a * zero", a * z, z);
        assert(dot(a, z) == 0, "dot with zero should be 0");
        assert(length(z) == 0, "length of zero vec should be 0");
        log(" - Vec3 zero vector OK");

        // negative values
        n : Vec3 = .{-1, -2, -3};
        assert_vec("Vec3 a + neg = zero", a + n, z);
        log(" - Vec3 negative values OK");

        // identity scalar ops
        assert_vec("Vec3 a * 1 = a", a * 1, a);
        assert_vec("Vec3 a + 0 = a", a + 0, a);
        assert_vec("Vec3 a / 1 = a", a / 1, a);
        log(" - Vec3 identity scalar ops OK");

        // dot self = length_sqr
        d := dot(a, a);
        lsq := length_sqr(a);
        assert(abs(d - lsq) < 0.0001, "dot(a,a) should equal length_sqr(a): % vs %", d, lsq);
        log(" - Vec3 dot(a,a) == length_sqr(a) OK");
    }

    log(" VECTOR CORRECTNESS ALL PASSED\n");
}

