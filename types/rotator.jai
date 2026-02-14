Rotator :: Vector(3, float32, .["roll", "pitch", "yaw"]);
Euler :: Rotator;

to_rotator :: (using quat: Quat) -> Rotator {
    // Convert quaternion to Euler angles (roll, pitch, yaw) in radians, then to degrees
    // Using standard aerospace/game conventions: ZYX order (yaw-pitch-roll)
    
    // Roll (x-axis rotation)
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
    
    return .{ roll * RAD_TO_DEG, pitch * RAD_TO_DEG, yaw * RAD_TO_DEG };
}

to_rotator :: (using vec: $T/Vectors3) -> Rotator {
    return .{ x * RAD_TO_DEG, y * RAD_TO_DEG, z * RAD_TO_DEG };
}
to_euler :: to_rotator;

to_radians :: (using rot: Rotator) -> Vec3  {
   return .{ roll * DEG_TO_RAD, pitch * DEG_TO_RAD, yaw * DEG_TO_RAD }; 
}
