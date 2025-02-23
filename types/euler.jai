Rot :: Vector(3, float32, .["pitch", "roll", "yaw"]);
Euler :: Rot;

to_matrix :: (r: Rot) -> Mat3 {

    cy := cos(r.yaw     * DEG_TO_RAD);
    sy := sin(r.yaw     * DEG_TO_RAD);
    cp := cos(r.pitch   * DEG_TO_RAD);
    sp := sin(r.pitch   * DEG_TO_RAD);
    cr := cos(r.roll    * DEG_TO_RAD);
    sr := sin(r.roll    * DEG_TO_RAD);

    result := Mat3.identity();
    
    result._00 = cy * cr + sy * sp * sr;
    result._10 = cr * sy * sp - sr * cy;
    result._20 = cp * sy;

    result._01 = cp * sr;
    result._11 = cr * cp;
    result._20 = -sp;

    result._02 = sr * cy * sp - sy * cr;
    result._12 = sy * sr + cr * cy * sp;
    result._22 = cp * cy;

    return result;
}