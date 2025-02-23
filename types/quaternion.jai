Quat :: Vector(4, float32, DEFAULT_AXES);

to_matrix :: (q: Quat) -> Mat3f {
    return .{
        1 - 2*q.y^2 - 2*q.z^2,	2*q.x*q.y - 2*q.z*q.w,	2*q.x*q.z + 2*q.y*q.w,
        2*q.x*q.y + 2*q.z*q.w,	1 - 2*q.x^2 - 2*q.z^2,	2*q.y*q.z - 2*q.x*q.w,
        2*q.x*q.z - 2*q.y*q.w,	2*q.y*q.z + 2*q.x*q.w,	1 - 2*q.x^2 - 2*q.y^2
    };
}