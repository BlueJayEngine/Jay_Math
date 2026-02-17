matrix_test :: () {

// Mat2
    operator_test("_Mat2d", "+");
    operator_test("_Mat2d", "-");
    operator_test("_Mat2d", "*");
    operator_test("_Mat2d", "/");

    operator_test("_Mat2", "+");
    operator_test("_Mat2", "-");
    operator_test("_Mat2", "*");
    operator_test("_Mat2", "/");

    // Mat3
    operator_test("_Mat3d", "+");
    operator_test("_Mat3d", "-");
    operator_test("_Mat3d", "*");
    operator_test("_Mat3d", "/");

    operator_test("_Mat3", "+");
    operator_test("_Mat3", "-");
    operator_test("_Mat3", "*");
    operator_test("_Mat3", "/");

    // Mat3x4
    operator_test("_Mat3x4d", "+");
    operator_test("_Mat3x4d", "-");
    operator_test("_Mat3x4d", "*");

    operator_test("_Mat3x4", "+");
    operator_test("_Mat3x4", "-");
    operator_test("_Mat3x4", "*");

    // Mat4
    operator_test("_Mat4d", "+");
    operator_test("_Mat4d", "-");
    operator_test("_Mat4d", "*");
    operator_test("_Mat4d", "/");

    operator_test("_Mat4", "+");
    operator_test("_Mat4", "-");
    operator_test("_Mat4", "*");
    operator_test("_Mat4", "/");

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
        -0.0769231, 0.6923077, 1.1538461,
         0.8461538, 1.3846154, 2.3076923,
         1.5384616, 2.1538462, 3.9230769
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
    a2d : Mat2d = .{1, 2, 3, 4};
    b2d : Mat2d = .{5, 6, 7, 8};
    assert_mat("Mat2d A + B", a2d + b2d, Mat2d.{6, 8, 10, 12});
    assert_mat("Mat2d A * B", a2d * b2d, Mat2d.{19, 22, 43, 50});
    assert_mat("Mat2d A * inv(A) = I", a2d * inverse(a2d), Mat2d.identity(), 0.001);
    assert_mat("Mat2d A / B", a2d / b2d, Mat2d.{3, -2, 2, -1}, 0.001);

    a3d : Mat3d = .{1, 2, 3, 4, 5, 6, 7, 8, 10};
    assert_mat("Mat3d A * inv(A) = I", a3d * inverse(a3d), Mat3d.identity(), 0.001);

    a4d : Mat4d = .{4, 1, 0, 1, 1, 3, 1, 0, 0, 1, 4, 1, 1, 0, 1, 3};
    assert_mat("Mat4d A * inv(A) = I", a4d * inverse(a4d), Mat4d.identity(), 0.001);
}

matrix_transform_test :: () {
    log("\nMATRIX TRANSFORMS\n");

    // =========================================================================
    //  Translation
    // =========================================================================

    {
        log(" -- Translation --");

        // make_translation: identity with translation set
        v := Vec3.{3, 5, 7};
        mt := make_translation(v);
        expected_mt := Mat4.{
            1, 0, 0, 3,
            0, 1, 0, 5,
            0, 0, 1, 7,
            0, 0, 0, 1
        };
        assert_mat("make_translation(Vec3)", mt, expected_mt);

        // make_translation with float64 vector -> Mat4d
        vf := Vec3d.{2, 4, 6};
        mtf := make_translation(vf);
        expected_mtf := Mat4d.{
            1, 0, 0, 2,
            0, 1, 0, 4,
            0, 0, 1, 6,
            0, 0, 0, 1
        };
        assert_mat("make_translation(Vec3d)", mtf, expected_mtf);

        // set_translation: overwrite translation column
        m4 := Mat4.identity();
        set_translation(*m4, Vec3.{10, 20, 30});
        assert_mat("set_translation ptr", m4, Mat4.{
            1, 0, 0, 10,
            0, 1, 0, 20,
            0, 0, 1, 30,
            0, 0, 0, 1
        });

        // set_translation value overload
        m4b := set_translation(Mat4.identity(), Vec3.{-1, -2, -3});
        assert_mat("set_translation val", m4b, Mat4.{
            1, 0, 0, -1,
            0, 1, 0, -2,
            0, 0, 1, -3,
            0, 0, 0, 1
        });

        // translate (apply): add to existing translation
        m4c := Mat4.identity();
        set_translation(*m4c, Vec3.{1, 2, 3});
        translate(*m4c, Vec3.{10, 20, 30});
        assert_mat("translate ptr accumulate", m4c, Mat4.{
            1, 0, 0, 11,
            0, 1, 0, 22,
            0, 0, 1, 33,
            0, 0, 0, 1
        });

        // translate value overload
        m4d := translate(Mat4.identity(), Vec3.{5, 6, 7});
        assert_mat("translate val", m4d, Mat4.{
            1, 0, 0, 5,
            0, 1, 0, 6,
            0, 0, 1, 7,
            0, 0, 0, 1
        });
    }

    // =========================================================================
    //  Rotation 2D
    // =========================================================================

    {
        log(" -- Rotation 2D --");

        // make_rotation 2d: 90 degrees (PI/2)
        // cos(PI/2) = 0, sin(PI/2) = 1
        // Expected: [0, -1; 1, 0]
        r90 := make_rotation(PI_2);
        assert_mat("make_rotation 2d PI/2", r90, Mat2.{0, -1, 1, 0});

        // make_rotation 2d: 0 degrees -> identity (0.0 is float32 -> Mat2)
        r0 := make_rotation(0.0);
        assert_mat("make_rotation 2d 0", r0, Mat2.identity());

        // make_rotation 2d: PI -> [-1, 0; 0, -1]
        rpi := make_rotation(PI);
        assert_mat("make_rotation 2d PI", rpi, Mat2.{-1, 0, 0, -1});

        // make_rotation 2d: PI/4 (45 degrees)
        r45 := make_rotation(PI_4);
        s45, c45 := sincos(PI_4, true, true);
        assert_mat("make_rotation 2d PI/4", r45, Mat2.{xx c45, xx -s45, xx s45, xx c45});

        // make_rotation float64 input -> Mat2d
        r90f := make_rotation(PI64_2);
        assert_mat("make_rotation 2d f64 PI/2", r90f, Mat2d.{0, -1, 1, 0}, 0.001);

        // set_rotation 2d: overwrite matrix
        m2 : Mat2 = .{99, 99, 99, 99};
        set_rotation(*m2, PI_2);
        assert_mat("set_rotation 2d ptr", m2, Mat2.{0, -1, 1, 0});

        // set_rotation 2d value overload
        m2b := set_rotation(Mat2.{99, 99, 99, 99}, 0.0);
        assert_mat("set_rotation 2d val", m2b, Mat2.identity());

        // rotate 2d (apply): multiply by rotation
        // Start with identity, rotate by PI/2 -> rotation matrix
        m2c := Mat2.identity();
        rotate(*m2c, PI_2);
        assert_mat("rotate 2d ptr identity*R", m2c, Mat2.{0, -1, 1, 0});

        // rotate 2d: two successive 90-degree rotations = 180 degrees
        m2d := Mat2.identity();
        rotate(*m2d, PI_2);
        rotate(*m2d, PI_2);
        assert_mat("rotate 2d 2x PI/2 = PI", m2d, Mat2.{-1, 0, 0, -1});

        // rotate 2d value overload
        m2e := rotate(Mat2.identity(), PI_4);
        assert_mat("rotate 2d val PI/4", m2e, Mat2.{xx c45, xx -s45, xx s45, xx c45});
    }

    // =========================================================================
    //  Rotation 3D
    // =========================================================================

    {
        log(" -- Rotation 3D --");

        // Rotation around Z axis by PI/2:
        // Same as 2d rotation in the XY plane
        // Expected: [0, -1, 0; 1, 0, 0; 0, 0, 1]
        z_axis := Vec3.{0, 0, 1};
        rz90 := make_rotation(PI_2, z_axis);
        assert_mat("make_rotation 3d Z PI/2", rz90, Mat3.{
            0, -1, 0,
            1,  0, 0,
            0,  0, 1
        });

        // Rotation around X axis by PI/2:
        // Expected: [1, 0, 0; 0, 0, -1; 0, 1, 0]
        x_axis := Vec3.{1, 0, 0};
        rx90 := make_rotation(PI_2, x_axis);
        assert_mat("make_rotation 3d X PI/2", rx90, Mat3.{
            1,  0, 0,
            0,  0, -1,
            0,  1, 0
        });

        // Rotation around Y axis by PI/2:
        // Expected: [0, 0, 1; 0, 1, 0; -1, 0, 0]
        y_axis := Vec3.{0, 1, 0};
        ry90 := make_rotation(PI_2, y_axis);
        assert_mat("make_rotation 3d Y PI/2", ry90, Mat3.{
             0, 0, 1,
             0, 1, 0,
            -1, 0, 0
        });

        // Rotation by 0 -> identity (0.0 is float32, z_axis is Vec3/float32 -> Mat3)
        rz0 := make_rotation(0.0, z_axis);
        assert_mat("make_rotation 3d 0 = I", rz0, Mat3.identity());

        // float64 variant
        z_axis_f := Vec3d.{0, 0, 1};
        rz90f := make_rotation(PI64_2, z_axis_f);
        assert_mat("make_rotation 3d f64 Z PI/2", rz90f, Mat3d.{
            0, -1, 0,
            1,  0, 0,
            0,  0, 1
        }, 0.001);

        // set_rotation 3d: overwrite upper-left 3x3
        m3 := Mat3.identity();
        set_rotation(*m3, PI_2, z_axis);
        assert_mat("set_rotation 3d ptr Z PI/2", m3, Mat3.{
            0, -1, 0,
            1,  0, 0,
            0,  0, 1
        });

        // set_rotation 3d value overload
        m3b := set_rotation(Mat3.identity(), PI_2, x_axis);
        assert_mat("set_rotation 3d val X PI/2", m3b, Mat3.{
            1,  0, 0,
            0,  0, -1,
            0,  1, 0
        });

        // rotate 3d (apply): identity * rotation = rotation
        m3c := Mat3.identity();
        rotate(*m3c, PI_2, z_axis);
        assert_mat("rotate 3d ptr I*Rz", m3c, Mat3.{
            0, -1, 0,
            1,  0, 0,
            0,  0, 1
        });

        // rotate 3d: two successive Z rotations of PI/2 = PI
        m3d := Mat3.identity();
        rotate(*m3d, PI_2, z_axis);
        rotate(*m3d, PI_2, z_axis);
        assert_mat("rotate 3d 2x Rz PI/2 = Rz PI", m3d, Mat3.{
            -1, 0, 0,
             0, -1, 0,
             0, 0, 1
        });

        // rotate 3d value overload
        m3e := rotate(Mat3.identity(), PI_2, y_axis);
        assert_mat("rotate 3d val Y PI/2", m3e, Mat3.{
             0, 0, 1,
             0, 1, 0,
            -1, 0, 0
        });

        // Rotation on a 4x4 matrix (only upper-left 3x3 affected)
        m4 := Mat4.identity();
        set_translation(*m4, Vec3.{10, 20, 30});
        rotate(*m4, PI_2, z_axis);
        // Translation column should be unchanged
        assert(m4.cells[0][3] == 10, "4x4 rotate preserves translation x");
        assert(m4.cells[1][3] == 20, "4x4 rotate preserves translation y");
        assert(m4.cells[2][3] == 30, "4x4 rotate preserves translation z");
        log(" - rotate 3d on Mat4 preserves translation OK");
    }

    // =========================================================================
    //  Face
    // =========================================================================

    {
        log(" -- Face --");

        // Looking down -Z with Y up (standard OpenGL camera default)
        // forward = (0,0,-1), up = (0,1,0)
        // After normalization: fwd = (0,0,-1)
        // right = cross(fwd, up) = cross((0,0,-1), (0,1,0)) = ((-1)*1 - 0*0, 0*0 - 0*1, 0*0 - (-1)*0) = (-1, 0, 0)
        // Hmm, let's be precise. Row-major face: rows = right, actual_up, -forward
        // fwd = normalize(direction) = (0,0,-1)
        // right = normalize(cross(fwd, up)) = normalize(cross((0,0,-1),(0,1,0)))
        //   cross = (0*0 - (-1)*1, (-1)*0 - 0*0, 0*1 - 0*0) = (1, 0, 0)
        // actual_up = cross(right, fwd) = cross((1,0,0),(0,0,-1)) = (0*(-1)-0*0, 0*0-1*(-1), 1*0-0*0) = (0, 1, 0)
        // Row 0 (right):    1, 0, 0
        // Row 1 (up):       0, 1, 0
        // Row 2 (-forward): 0, 0, 1
        // = identity!
        dir_neg_z := Vec3.{0, 0, -1};
        up_y := Vec3.{0, 1, 0};
        face_default := make_face(dir_neg_z, up_y);
        assert_mat("make_face -Z up Y = I", face_default, Mat3.identity());

        // Looking down +X with Y up
        // fwd = (1,0,0)
        // right = normalize(cross((1,0,0),(0,1,0))) = normalize((0*0-0*1, 0*0-1*0, 1*1-0*0)) = (0, 0, 1)
        // actual_up = cross((0,0,1),(1,0,0)) = (0*0-1*0, 1*1-0*0, 0*0-0*1) = (0, 1, 0)
        // Row 0 (right):     0, 0, 1
        // Row 1 (up):        0, 1, 0
        // Row 2 (-forward): -1, 0, 0
        dir_pos_x := Vec3.{1, 0, 0};
        face_x := make_face(dir_pos_x, up_y);
        assert_mat("make_face +X up Y", face_x, Mat3.{
             0, 0, 1,
             0, 1, 0,
            -1, 0, 0
        });

        // set_face: overwrite 3x3
        m3 := Mat3.identity();
        set_face(*m3, dir_pos_x, up_y);
        assert_mat("set_face ptr +X", m3, Mat3.{
             0, 0, 1,
             0, 1, 0,
            -1, 0, 0
        });

        // set_face value overload
        m3b := set_face(Mat3.identity(), dir_neg_z, up_y);
        assert_mat("set_face val -Z = I", m3b, Mat3.identity());

        // face (apply): identity * face = face
        m3c := Mat3.identity();
        face(*m3c, dir_pos_x, up_y);
        assert_mat("face ptr I*face(+X)", m3c, Mat3.{
             0, 0, 1,
             0, 1, 0,
            -1, 0, 0
        });

        // face value overload
        m3d := face(Mat3.identity(), dir_neg_z, up_y);
        assert_mat("face val -Z = I", m3d, Mat3.identity());

        // float64 variant
        dir_f := Vec3d.{0, 0, -1};
        up_f := Vec3d.{0, 1, 0};
        face_f := make_face(dir_f, up_f);
        assert_mat("make_face f64 -Z = I", face_f, Mat3d.identity(), 0.001);

        // Orthogonality check: R * R^T = I (face matrix should be orthogonal)
        // For +X direction
        face_xt := Mat3.{
            face_x._11, face_x._21, face_x._31,
            face_x._12, face_x._22, face_x._32,
            face_x._13, face_x._23, face_x._33
        };
        assert_mat("face orthogonal R*R^T=I", face_x * face_xt, Mat3.identity());
    }

    // =========================================================================
    //  Scale
    // =========================================================================

    {
        log(" -- Scale --");

        // make_scale 2d (float literals are float32 -> Mat2)
        s2 := make_scale(2.0, 3.0);
        assert_mat("make_scale 2d f32", s2, Mat2.{2, 0, 0, 3});

        // make_scale 3d
        sv := Vec3.{2, 3, 4};
        s3d := make_scale(sv);
        assert_mat("make_scale 3d", s3d, Mat3.{
            2, 0, 0,
            0, 3, 0,
            0, 0, 4
        });

        // make_scale 3d float64
        svf := Vec3d.{5, 6, 7};
        s3df := make_scale(svf);
        assert_mat("make_scale 3d f64", s3df, Mat3d.{
            5, 0, 0,
            0, 6, 0,
            0, 0, 7
        });

        // set_scale 2d
        m2 := Mat2.{99, 99, 99, 99};
        set_scale(*m2, 4.0, 5.0);
        assert(m2._11 == 4.0, "set_scale 2d _11");
        assert(m2._22 == 5.0, "set_scale 2d _22");
        // Off-diagonal should be untouched
        assert(m2._12 == 99.0, "set_scale 2d preserves _12");
        assert(m2._21 == 99.0, "set_scale 2d preserves _21");
        log(" - set_scale 2d ptr OK");

        // set_scale 2d value
        m2b := set_scale(Mat2.identity(), 3.0, 7.0);
        assert_mat("set_scale 2d val", m2b, Mat2.{3, 0, 0, 7});

        // set_scale 3d
        m3 := Mat3.identity();
        set_scale(*m3, Vec3.{10, 20, 30});
        assert_mat("set_scale 3d ptr", m3, Mat3.{
            10, 0, 0,
            0, 20, 0,
            0, 0, 30
        });

        // set_scale 3d value
        m3b := set_scale(Mat3.identity(), Vec3.{2, 4, 8});
        assert_mat("set_scale 3d val", m3b, Mat3.{
            2, 0, 0,
            0, 4, 0,
            0, 0, 8
        });

        // scale 2d (apply): scales columns
        // [1, 2; 3, 4] scaled by (2, 3):
        // row0: [1*2, 2*3] = [2, 6]
        // row1: [3*2, 4*3] = [6, 12]
        m2c : Mat2 = .{1, 2, 3, 4};
        scale(*m2c, 2.0, 3.0);
        assert_mat("scale 2d ptr", m2c, Mat2.{2, 6, 6, 12});

        // scale 2d value
        m2d := scale(Mat2.{1, 2, 3, 4}, 2.0, 3.0);
        assert_mat("scale 2d val", m2d, Mat2.{2, 6, 6, 12});

        // scale 3d (apply): scales columns
        // identity scaled by (2,3,4) = diagonal(2,3,4)
        m3c := Mat3.identity();
        scale(*m3c, Vec3.{2, 3, 4});
        assert_mat("scale 3d ptr I*S", m3c, Mat3.{
            2, 0, 0,
            0, 3, 0,
            0, 0, 4
        });

        // scale 3d on non-identity
        // [1,2,3; 4,5,6; 7,8,9] scaled by (2,3,4):
        // row0: [1*2, 2*3, 3*4] = [2, 6, 12]
        // row1: [4*2, 5*3, 6*4] = [8, 15, 24]
        // row2: [7*2, 8*3, 9*4] = [14, 24, 36]
        m3d : Mat3 = .{1, 2, 3, 4, 5, 6, 7, 8, 9};
        scale(*m3d, Vec3.{2, 3, 4});
        assert_mat("scale 3d ptr non-I", m3d, Mat3.{
            2, 6, 12,
            8, 15, 24,
            14, 24, 36
        });

        // scale 3d value
        m3e := scale(Mat3.identity(), Vec3.{5, 6, 7});
        assert_mat("scale 3d val", m3e, Mat3.{
            5, 0, 0,
            0, 6, 0,
            0, 0, 7
        });

        // Uniform scale by 1 = identity
        m3f := Mat3.identity();
        scale(*m3f, Vec3.{1, 1, 1});
        assert_mat("scale 3d uniform 1 = I", m3f, Mat3.identity());
    }

    // =========================================================================
    //  Shear
    // =========================================================================

    {
        log(" -- Shear --");

        // make_shear 2d (float literals -> Mat2)
        sh2 := make_shear(2.0, 0.0);
        assert_mat("make_shear 2d (2,0)", sh2, Mat2.{1, 2, 0, 1});

        sh2_b := make_shear(0.0, 3.0);
        assert_mat("make_shear 2d (0,3)", sh2_b, Mat2.{1, 0, 3, 1});

        sh2_c := make_shear(2.0, 3.0);
        assert_mat("make_shear 2d (2,3)", sh2_c, Mat2.{1, 2, 3, 1});

        sh2f := make_shear(1.5, 0.5);
        assert_mat("make_shear 2d (1.5,0.5)", sh2f, Mat2.{1, 1.5, 0.5, 1});

        // make_shear 3d (float literals -> Mat3)
        sh3 := make_shear(1.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        assert_mat("make_shear 3d xy=1", sh3, Mat3.{
            1, 1, 0,
            0, 1, 0,
            0, 0, 1
        });

        sh3_all := make_shear(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
        assert_mat("make_shear 3d all", sh3_all, Mat3.{
            1, 1, 2,
            3, 1, 4,
            5, 6, 1
        });

        // set_shear 2d
        m2 : Mat2 = .{99, 99, 99, 99};
        set_shear(*m2, 2.0, 3.0);
        assert_mat("set_shear 2d ptr", m2, Mat2.{1, 2, 3, 1});

        // set_shear 2d value
        m2b := set_shear(Mat2.{99, 99, 99, 99}, 0.5, 0.5);
        assert_mat("set_shear 2d val", m2b, Mat2.{1, 0.5, 0.5, 1});

        // set_shear 3d
        m3 : Mat3 = .{99, 99, 99, 99, 99, 99, 99, 99, 99};
        set_shear(*m3, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
        assert_mat("set_shear 3d ptr", m3, Mat3.{
            1, 1, 2,
            3, 1, 4,
            5, 6, 1
        });

        // set_shear 3d value (numbers auto-cast to Mat3's float64)
        m3b := set_shear(Mat3.{99, 99, 99, 99, 99, 99, 99, 99, 99}, 0, 0, 0, 0, 0, 0);
        assert_mat("set_shear 3d val zeros = I", m3b, Mat3.identity());

        // shear 2d (apply): M * shear_matrix
        // [1, 2; 3, 4] * [1, shx; shy, 1] where shx=1, shy=0
        // For each row: new_c0 = c0 + c1*shy, new_c1 = c0*shx + c1
        // row0: c0=1, c1=2 -> new_c0 = 1+2*0=1, new_c1 = 1*1+2=3
        // row1: c0=3, c1=4 -> new_c0 = 3+4*0=3, new_c1 = 3*1+4=7
        m2c : Mat2 = .{1, 2, 3, 4};
        shear(*m2c, 1.0, 0.0);
        assert_mat("shear 2d ptr (1,0)", m2c, Mat2.{1, 3, 3, 7});

        // shear 2d: shy only
        // row0: c0=1, c1=2 -> new_c0 = 1+2*2=5, new_c1 = 1*0+2=2
        // row1: c0=3, c1=4 -> new_c0 = 3+4*2=11, new_c1 = 3*0+4=4
        m2d : Mat2 = .{1, 2, 3, 4};
        shear(*m2d, 0.0, 2.0);
        assert_mat("shear 2d ptr (0,2)", m2d, Mat2.{5, 2, 11, 4});

        // shear 2d value
        m2e := shear(Mat2.identity(), 2.0, 3.0);
        assert_mat("shear 2d val I*sh(2,3)", m2e, Mat2.{1, 2, 3, 1});

        // shear 2d: identity shear (0,0) = no change
        m2g : Mat2 = .{1, 2, 3, 4};
        shear(*m2g, 0.0, 0.0);
        assert_mat("shear 2d (0,0) = noop", m2g, Mat2.{1, 2, 3, 4});

        // shear 3d (apply): identity * shear = shear matrix
        m3c := Mat3.identity();
        shear(*m3c, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
        assert_mat("shear 3d ptr I*sh", m3c, Mat3.{
            1, 1, 2,
            3, 1, 4,
            5, 6, 1
        });

        // shear 3d: zero shear = no change
        m3d : Mat3 = .{1, 2, 3, 4, 5, 6, 7, 8, 9};
        shear(*m3d, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        assert_mat("shear 3d zeros = noop", m3d, Mat3.{1, 2, 3, 4, 5, 6, 7, 8, 9});

        // shear 3d value
        m3e := shear(Mat3.identity(), 0.5, 0.0, 0.0, 0.0, 0.0, 0.5);
        assert_mat("shear 3d val", m3e, Mat3.{
            1, 0.5, 0,
            0, 1, 0,
            0, 0.5, 1
        });
    }

    // =========================================================================
    //  Combined / integration tests
    // =========================================================================

    {
        log(" -- Combined --");

        // Rotation then inverse rotation = identity
        z_axis := Vec3.{0, 0, 1};
        m := Mat3.identity();
        rotate(*m, PI_4, z_axis);
        rotate(*m, -PI_4, z_axis);
        assert_mat("rotate + inverse rotate = I", m, Mat3.identity());

        // Scale then inverse scale = identity
        m2 := Mat3.identity();
        scale(*m2, Vec3.{2, 3, 4});
        scale(*m2, Vec3.{0.5, 1.0/3.0, 0.25});
        assert_mat("scale + inv scale = I", m2, Mat3.identity());

        // make_rotation * make_rotation inverse = identity
        r := make_rotation(1.23, z_axis);
        r_inv := make_rotation(-1.23, z_axis);
        assert_mat("make_rot * make_rot_inv = I", r * r_inv, Mat3.identity());

        // Translation: translate then inverse = identity
        m4 := Mat4.identity();
        translate(*m4, Vec3.{5, 10, 15});
        translate(*m4, Vec3.{-5, -10, -15});
        assert_mat("translate + inv translate = I", m4, Mat4.identity());

        // 4x4: set rotation, then set translation, verify both
        m4b := Mat4.identity();
        // Manually set a Z rotation in upper-left 3x3
        set_rotation(*m4b, PI_2, z_axis);
        set_translation(*m4b, Vec3.{10, 20, 30});
        // Upper-left 3x3 should be Z rotation
        assert(abs(cast(float64) m4b.cells[0][0] - 0.0) < 0.0001, "4x4 combo rot _11");
        assert(abs(cast(float64) m4b.cells[0][1] - -1.0) < 0.0001, "4x4 combo rot _12");
        assert(abs(cast(float64) m4b.cells[1][0] - 1.0) < 0.0001, "4x4 combo rot _21");
        assert(abs(cast(float64) m4b.cells[1][1] - 0.0) < 0.0001, "4x4 combo rot _22");
        // Translation column
        assert(m4b.cells[0][3] == 10, "4x4 combo trans x");
        assert(m4b.cells[1][3] == 20, "4x4 combo trans y");
        assert(m4b.cells[2][3] == 30, "4x4 combo trans z");
        log(" - 4x4 rotation + translation combo OK");
    }

    log("\nAll transform tests passed!\n");
}


