Quat :: Vector(4, float32, .["w", "x", "y", "z"]);

Rotator :: Vector(3, float32, .["roll", "pitch", "yaw"]);
Euler :: Rotator;

Radians :: Vector(3, float32, .["roll", "pitch", "yaw"]);

to_rotator :: (using quat: Quat) -> Rotator {        
    return RAD_TO_DEG * reinterp(Radians, to_radians(quat));
}

to_radians :: (using quat: Quat) -> Radians {
    sinr_cosp := 2.0 * (w * x + y * z);
    cosr_cosp := 1.0 - 2.0 * (x * x + y * y);
    roll := atan2(sinr_cosp, cosr_cosp);
    
    // Pitch (y-axis rotation)
    sinp := 2.0 * (w * y - z * x);
    pitch: float32;
    if abs(sinp) >= 1.0 {
        pitch = ifx sinp < 0 then -PI_2 else PI_2; // Use 90 degrees if out of range
    } else {
        pitch = asin(sinp);
    }
    
    // Yaw (z-axis rotation)
    siny_cosp := 2.0 * (w * z + x * y);
    cosy_cosp := 1.0 - 2.0 * (y * y + z * z);
    yaw := atan2(siny_cosp, cosy_cosp);
    
    return .{roll, pitch, yaw};
}

to_rotator :: (using vec: Radians) -> Rotator {
    return .{ roll * RAD_TO_DEG, pitch * RAD_TO_DEG, yaw * RAD_TO_DEG };
}
to_euler :: to_rotator;

to_radians :: (using rot: Rotator) -> Radians  {
   return .{ roll * DEG_TO_RAD, pitch * DEG_TO_RAD, yaw * DEG_TO_RAD }; 
}

// ============================================================================
//  Radians / Rotator -> Quaternion
//  (Rotator and Radians are the same type — input is treated as radians.
//   For degrees, convert first: to_quat(to_radians(my_rotator)))
// ============================================================================

to_quat :: (using rad: Radians) -> Quat {
    // Half-angle formula: intrinsic ZYX (yaw, pitch, roll)
    // Quat layout is {w, x, y, z}
    sr, cr := sincos(cast(float64) roll  * 0.5, true, true);
    sp, cp := sincos(cast(float64) pitch * 0.5, true, true);
    sy, cy := sincos(cast(float64) yaw   * 0.5, true, true);

    return .{
        xx (cr * cp * cy + sr * sp * sy),  // w
        xx (sr * cp * cy - cr * sp * sy),  // x
        xx (cr * sp * cy + sr * cp * sy),  // y
        xx (cr * cp * sy - sr * sp * cy),  // z
    };
}

// ============================================================================
//  Quaternion -> Matrix
// ============================================================================

to_matrix :: (using q: Quat) -> Mat3 {
    x2 := x + x;  y2 := y + y;  z2 := z + z;
    xx2 := x * x2;  xy2 := x * y2;  xz2 := x * z2;
    yy2 := y * y2;  yz2 := y * z2;  zz2 := z * z2;
    wx2 := w * x2;  wy2 := w * y2;  wz2 := w * z2;

    result: Mat3;
    result._11 = 1.0 - (yy2 + zz2);  result._12 = xy2 - wz2;          result._13 = xz2 + wy2;
    result._21 = xy2 + wz2;          result._22 = 1.0 - (xx2 + zz2);  result._23 = yz2 - wx2;
    result._31 = xz2 - wy2;          result._32 = yz2 + wx2;          result._33 = 1.0 - (xx2 + yy2);
    return result;
}

to_matrix4 :: (using q: Quat) -> Mat4 {
    m3 := to_matrix(q);

    result := Mat4.identity();
    result._11 = m3._11;  result._12 = m3._12;  result._13 = m3._13;
    result._21 = m3._21;  result._22 = m3._22;  result._23 = m3._23;
    result._31 = m3._31;  result._32 = m3._32;  result._33 = m3._33;
    return result;
}

// ============================================================================
//  Matrix -> Quaternion  (Shepperd's method — numerically stable)
// ============================================================================

to_quat :: (using m: Mat3) -> Quat {
    // Shepperd's method: pick the largest diagonal to avoid division by near-zero
    // Quat layout is {w, x, y, z}
    trace := _11 + _22 + _33;

    if trace > 0.0 {
        s := sqrt(trace + 1.0) * 2.0;  // s = 4*w
        return .{
            0.25 * s,
            (_32 - _23) / s,
            (_13 - _31) / s,
            (_21 - _12) / s,
        };
    } else if _11 > _22 && _11 > _33 {
        s := sqrt(1.0 + _11 - _22 - _33) * 2.0;  // s = 4*x
        return .{
            (_32 - _23) / s,
            0.25 * s,
            (_12 + _21) / s,
            (_13 + _31) / s,
        };
    } else if _22 > _33 {
        s := sqrt(1.0 + _22 - _11 - _33) * 2.0;  // s = 4*y
        return .{
            (_13 - _31) / s,
            (_12 + _21) / s,
            0.25 * s,
            (_23 + _32) / s,
        };
    } else {
        s := sqrt(1.0 + _33 - _11 - _22) * 2.0;  // s = 4*z
        return .{
            (_21 - _12) / s,
            (_13 + _31) / s,
            (_23 + _32) / s,
            0.25 * s,
        };
    }
}

to_quat :: (using m: Mat4) -> Quat {
    m3: Mat3;
    m3._11 = _11;  m3._12 = _12;  m3._13 = _13;
    m3._21 = _21;  m3._22 = _22;  m3._23 = _23;
    m3._31 = _31;  m3._32 = _32;  m3._33 = _33;
    return to_quat(m3);
}

// ============================================================================
//  Radians / Rotator -> Matrix  (via quaternion, input treated as radians)
// ============================================================================

to_matrix :: (rad: Radians) -> Mat3 {
    return to_matrix(to_quat(rad));
}

to_matrix4 :: (rad: Radians) -> Mat4 {
    return to_matrix4(to_quat(rad));
}

// ============================================================================
//  Matrix -> Rotator / Radians  (via quaternion)
// ============================================================================

to_rotator :: (m: Mat3) -> Rotator {
    return to_rotator(to_quat(m));
}

to_radians :: (m: Mat3) -> Radians {
    return to_radians(to_quat(m));
}

to_rotator :: (m: Mat4) -> Rotator {
    return to_rotator(to_quat(m));
}

to_radians :: (m: Mat4) -> Radians {
    return to_radians(to_quat(m));
}

// ============================================================================
//  Transform <-> Matrix4
// ============================================================================

to_matrix :: (using t: Transform) -> Mat4 {
    // TRS composition: M = T * R * S
    m := to_matrix4(rotation);

    // Apply scale to rotation columns
    m._11 *= scale.x;  m._12 *= scale.y;  m._13 *= scale.z;
    m._21 *= scale.x;  m._22 *= scale.y;  m._23 *= scale.z;
    m._31 *= scale.x;  m._32 *= scale.y;  m._33 *= scale.z;

    // Set translation column
    m._14 = translation.x;
    m._24 = translation.y;
    m._34 = translation.z;

    return m;
}

to_transform :: (using m: Mat4) -> Transform {
    result: Transform;

    // Extract translation from column 4
    result.translation = .{_14, _24, _34};

    // Extract scale as column lengths
    sx := sqrt(_11 * _11 + _21 * _21 + _31 * _31);
    sy := sqrt(_12 * _12 + _22 * _22 + _32 * _32);
    sz := sqrt(_13 * _13 + _23 * _23 + _33 * _33);
    result.scale = .{sx, sy, sz};

    // Build normalized rotation matrix and extract quaternion
    inv_sx := ifx sx > EPSILON then 1.0 / sx else 0.0;
    inv_sy := ifx sy > EPSILON then 1.0 / sy else 0.0;
    inv_sz := ifx sz > EPSILON then 1.0 / sz else 0.0;

    rot: Mat3;
    rot._11 = _11 * inv_sx;  rot._12 = _12 * inv_sy;  rot._13 = _13 * inv_sz;
    rot._21 = _21 * inv_sx;  rot._22 = _22 * inv_sy;  rot._23 = _23 * inv_sz;
    rot._31 = _31 * inv_sx;  rot._32 = _32 * inv_sy;  rot._33 = _33 * inv_sz;
    result.rotation = to_quat(rot);

    return result;
}


