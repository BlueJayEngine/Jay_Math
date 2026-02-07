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
    
    result.cells[0][0] = cy * cr + sy * sp * sr;
    result.cells[1][0] = cr * sy * sp - sr * cy;
    result.cells[2][0] = cp * sy;

    result.cells[0][1] = cp * sr;
    result.cells[1][1] = cr * cp;
    result.cells[2][1] = -sp;

    result.cells[0][2] = sr * cy * sp - sy * cr;
    result.cells[1][2] = sy * sr + cr * cy * sp;
    result.cells[2][2] = cp * cy;

    return result;
}