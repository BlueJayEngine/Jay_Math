// ============================================================================
//  Rotator conversion benchmark & correctness tests
//  Tests scalar vs SIMD/FMA paths for all conversion functions.
// ============================================================================

BENCH_ITERS :: 10_000_000;

rotator_test :: () {
    log("\nROTATOR CONVERSIONS\n");

    rotator_correctness_test();
    rotator_benchmark();
}

// ============================================================================
//  Correctness
// ============================================================================

assert_quat :: (label: string, a: Quat, b: Quat, tol: float32 = 0.0001) {
    // Quaternions q and -q represent the same rotation
    // Check both orientations
    d0 := abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z) + abs(a.w - b.w);
    d1 := abs(a.x + b.x) + abs(a.y + b.y) + abs(a.z + b.z) + abs(a.w + b.w);
    d := ifx d0 < d1 then d0 else d1;
    if d > tol {
        log_error("% FAILED: got {%,%,%,%}, expected {%,%,%,%} (delta %)",
            label, a.x, a.y, a.z, a.w, b.x, b.y, b.z, b.w, d);
        assert(false, "Quaternion correctness test failed");
    }
    log(" - % OK", label);
}

assert_vec3 :: (label: string, a: Vec3, b: Vec3, tol: float32 = 0.0001) {
    d := abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z);
    if d > tol {
        log_error("% FAILED: got {%,%,%}, expected {%,%,%} (delta %)",
            label, a.x, a.y, a.z, b.x, b.y, b.z, d);
        assert(false, "Vec3 correctness test failed");
    }
    log(" - % OK", label);
}

assert_transform :: (label: string, a: Transform, b: Transform, tol: float32 = 0.001) {
    assert_vec3(sprint("% translation", label), a.translation, b.translation, tol);
    assert_quat(sprint("% rotation", label), a.rotation, b.rotation, tol);
    assert_vec3(sprint("% scale", label), a.scale, b.scale, tol);
}

rotator_correctness_test :: () {
    log(" -- Correctness --");

    // Identity quaternion -> identity matrix
    {
        q_id := Quat.{1, 0, 0, 0};
        m := to_matrix(q_id);
        assert_mat("to_matrix(identity quat)", m, Mat3.identity());

        m4 := to_matrix4(q_id);
        assert_mat("to_matrix4(identity quat)", m4, Mat4.identity());
    }

    // 90-degree rotation around Z axis
    // quat = (cos(45°), 0, 0, sin(45°)) = (w=cos45, x=0, y=0, z=sin45)
    // Quat layout is (w,x,y,z) so: {cos45, 0, 0, sin45}
    {
        s45 := sin(PI_4);
        c45 := cos(PI_4);
        q_z90 := Quat.{c45, 0, 0, s45};

        m := to_matrix(q_z90);
        expected := Mat3.{
            0, -1, 0,
            1,  0, 0,
            0,  0, 1
        };
        assert_mat("to_matrix(Z 90°)", m, expected);
    }

    // 90-degree rotation around X axis
    // quat: w=cos45, x=sin45, y=0, z=0
    {
        s45 := sin(PI_4);
        c45 := cos(PI_4);
        q_x90 := Quat.{c45, s45, 0, 0};

        m := to_matrix(q_x90);
        expected := Mat3.{
            1,  0, 0,
            0,  0, -1,
            0,  1, 0
        };
        assert_mat("to_matrix(X 90°)", m, expected);
    }

    // Round-trip: Quat -> Mat3 -> Quat
    {
        s45 := sin(PI_4);
        c45 := cos(PI_4);
        q_orig := Quat.{c45, s45, 0, 0};  // X 90°

        m := to_matrix(q_orig);
        q_back := to_quat(m);
        assert_quat("round-trip Quat->Mat3->Quat (X 90°)", q_back, q_orig);
    }

    // Round-trip: Quat -> Mat3 -> Quat for arbitrary rotation
    {
        // 37° around normalized axis (0.267, 0.535, 0.802) ≈ (1,2,3)/sqrt(14)
        angle := 37.0 * DEG_TO_RAD;
        ha := angle * 0.5;
        s := sin(ha);
        c := cos(ha);
        inv_len := 1.0 / sqrt(14.0);
        q_arb := Quat.{c, s * xx (1.0 * inv_len), s * xx (2.0 * inv_len), s * xx (3.0 * inv_len)};

        m := to_matrix(q_arb);
        q_back := to_quat(m);
        assert_quat("round-trip Quat->Mat3->Quat (arbitrary)", q_back, q_arb);
    }

    // Round-trip: Radians -> Quat -> Mat3 -> Quat (compare quaternions, not angles,
    // because atan2 can return equivalent angles in different ranges)
    {
        rad := Radians.{0.3, 0.5, 0.7};  // roll, pitch, yaw in radians
        q := to_quat(rad);
        m := to_matrix(q);
        q2 := to_quat(m);
        assert_quat("round-trip Radians->Quat->Mat3->Quat", q2, q);
    }

    // Transform -> Mat4 -> Transform round-trip
    {
        t_orig := Transform.{
            translation = .{3, 5, 7},
            rotation = Quat.{cos(PI_4), 0, 0, sin(PI_4)},  // Z 90°
            scale = .{2, 3, 4},
        };

        m := to_matrix(t_orig);
        t_back := to_transform(m);
        assert_transform("round-trip Transform->Mat4->Transform", t_back, t_orig);
    }

    // Transform with identity rotation
    {
        t_id := Transform.{
            translation = .{10, 20, 30},
            rotation = Quat.{1, 0, 0, 0},
            scale = .{1, 1, 1},
        };

        m := to_matrix(t_id);
        expected := Mat4.{
            1, 0, 0, 10,
            0, 1, 0, 20,
            0, 0, 1, 30,
            0, 0, 0, 1
        };
        assert_mat("to_matrix(identity Transform)", m, expected);
    }

    // Mat4 -> Quat via upper-left 3x3
    {
        m4 := Mat4.{
            0, -1, 0, 99,
            1,  0, 0, 99,
            0,  0, 1, 99,
            0,  0, 0, 1
        };
        q := to_quat(m4);
        // Should be Z 90° rotation
        s45 := sin(PI_4);
        c45 := cos(PI_4);
        assert_quat("to_quat(Mat4) Z 90°", q, Quat.{c45, 0, 0, s45});
    }

}

// ============================================================================
//  Benchmarks
// ============================================================================

rotator_benchmark :: () {
    log("\n -- Benchmarks (% iterations) --", BENCH_ITERS);

    // Generate test data: array of normalized quaternions
    quats: [1024] Quat;
    for *quats {
        angle := cast(float32)(it_index * 0.00613);  // spread across angles
        ax := cast(float32)(it_index * 7 % 97) / 97.0;
        ay := cast(float32)(it_index * 13 % 97) / 97.0;
        az := cast(float32)(it_index * 31 % 97) / 97.0;
        len := sqrt(ax*ax + ay*ay + az*az);
        if len < 0.001 { ax = 0; ay = 0; az = 1; len = 1; }
        ax /= len; ay /= len; az /= len;
        ha := angle * 0.5;
        s := sin(ha); c := cos(ha);
        it.x = s * ax; it.y = s * ay; it.z = s * az; it.w = c;
    }

    transforms: [1024] Transform;
    for * transforms {
        it.translation = .{cast(float32)(it_index * 3 % 100), cast(float32)(it_index * 7 % 100), cast(float32)(it_index * 11 % 100)};
        it.rotation = quats[it_index];
        sx := 0.5 + cast(float32)(it_index * 13 % 100) / 50.0;
        sy := 0.5 + cast(float32)(it_index * 17 % 100) / 50.0;
        sz := 0.5 + cast(float32)(it_index * 19 % 100) / 50.0;
        it.scale = .{sx, sy, sz};
    }

    mats3: [1024] Mat3;
    for * mats3 { it.* = to_matrix(quats[it_index]); }

    mats4: [1024] Mat4;
    for * mats4 { it.* = to_matrix(transforms[it_index]); }

    radians: [1024] Radians;
    for * radians {
        it.roll  = cast(float32)(it_index * 7 % 628) / 100.0 - 3.14;
        it.pitch = cast(float32)(it_index * 13 % 314) / 100.0 - 1.57;
        it.yaw   = cast(float32)(it_index * 31 % 628) / 100.0 - 3.14;
    }

    // Prevent dead-code elimination
    sink_mat3: Mat3;
    sink_mat4: Mat4;
    sink_quat: Quat;
    sink_transform: Transform;
    sink_radians: Radians;

    // ---- to_matrix(Quat) -> Mat3 ----
    {
        t0 := current_time_monotonic();
        for 0..BENCH_ITERS-1 {
            sink_mat3 = to_matrix(quats[it & 1023]);
        }
        dt := to_microseconds(current_time_monotonic() - t0);
        log("  to_matrix(Quat):           % us  (% ns/op)", dt, (dt * 1000) / BENCH_ITERS);
    }

    // ---- to_quat(Mat3) -> Quat ----
    {
        t0 := current_time_monotonic();
        for 0..BENCH_ITERS-1 {
            sink_quat = to_quat(mats3[it & 1023]);
        }
        dt := to_microseconds(current_time_monotonic() - t0);
        log("  to_quat(Mat3):              % us  (% ns/op)", dt, (dt * 1000) / BENCH_ITERS);
    }

    // ---- to_matrix(Transform) -> Mat4 ----
    {
        t0 := current_time_monotonic();
        for 0..BENCH_ITERS-1 {
            sink_mat4 = to_matrix(transforms[it & 1023]);
        }
        dt := to_microseconds(current_time_monotonic() - t0);
        log("  to_matrix(Transform):      % us  (% ns/op)", dt, (dt * 1000) / BENCH_ITERS);
    }

    // ---- to_quat(Radians) -> Quat ----
    {
        t0 := current_time_monotonic();
        for 0..BENCH_ITERS-1 {
            sink_quat = to_quat(radians[it & 1023]);
        }
        dt := to_microseconds(current_time_monotonic() - t0);
        log("  to_quat(Radians):          % us  (% ns/op)", dt, (dt * 1000) / BENCH_ITERS);
    }

    // ---- to_radians(Quat) ----
    {
        t0 := current_time_monotonic();
        for 0..BENCH_ITERS-1 {
            sink_radians = to_radians(quats[it & 1023]);
        }
        dt := to_microseconds(current_time_monotonic() - t0);
        log("  to_radians(Quat):          % us  (% ns/op)", dt, (dt * 1000) / BENCH_ITERS);
    }

    // ---- to_transform(Mat4) (sqrt-bound, no SIMD variant) ----
    {
        t0 := current_time_monotonic();
        for 0..BENCH_ITERS-1 {
            sink_transform = to_transform(mats4[it & 1023]);
        }
        dt := to_microseconds(current_time_monotonic() - t0);
        log("  to_transform(Mat4):        % us  (% ns/op)", dt, (dt * 1000) / BENCH_ITERS);
    }

    // Use sinks to prevent elimination
    if sink_mat3._11 == 999999 then log("%", sink_mat3._11);
    if sink_mat4._11 == 999999 then log("%", sink_mat4._11);
    if sink_quat.x == 999999 then log("%", sink_quat.x);
    if sink_transform.translation.x == 999999 then log("%", sink_transform.translation.x);
    if sink_radians.roll == 999999 then log("%", sink_radians.roll);
}
