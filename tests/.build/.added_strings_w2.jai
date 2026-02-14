// Workspace: Target Program

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z, w: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;
	#overlay (z) zw: Vector(2, T, AXES) = ---;
	#overlay (x) xyz: Vector(3, T, AXES) = ---;
	#overlay (y) yzw: Vector(3, T, AXES) = ---;

	new :: (x: T, y: T, z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (x: T, y: T, zw: Vector(2, $T2, $A2)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];
		result.values[3] = w;

		return result;
	}

	new :: (x: T, yzw: Vector(3, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yzw.values[0];
		result.values[2] = yzw.values[1];
		result.values[3] = yzw.values[2];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), zw: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (xyz: Vector(3, $T0, $A0), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xyz.values[0];
		result.values[1] = xyz.values[1];
		result.values[2] = xyz.values[2];
		result.values[3] = w;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	roll, pitch, yaw: T #align 16;
	#overlay (roll) values: [N] T = ---;
	#overlay (roll) rollpitch: Vector(2, T, AXES) = ---;
	#overlay (pitch) pitchyaw: Vector(2, T, AXES) = ---;

	new :: (roll: T, pitch: T, yaw: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = roll;
		result.values[1] = pitch;
		result.values[2] = yaw;

		return result;
	}

	new :: (roll: T, pitchyaw: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = roll;
		result.values[1] = pitchyaw.values[0];
		result.values[2] = pitchyaw.values[1];

		return result;
	}

	new :: (rollpitch: Vector(2, $T0, $A0), yaw: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = rollpitch.values[0];
		result.values[1] = rollpitch.values[1];
		result.values[2] = yaw;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y: T #align 16;
	#overlay (x) values: [N] T = ---;

	new :: (x: T, y: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;

	new :: (x: T, y: T, z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	roll, pitch: T #align 16;
	#overlay (roll) values: [N] T = ---;

	new :: (roll: T, pitch: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = roll;
		result.values[1] = pitch;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:166.
//
	result.values[0] = a.values[0] - b.values[0];
	result.values[1] = a.values[1] - b.values[1];
	result.values[2] = a.values[2] - b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:202.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];
	result.values[2] = a.values[2] / b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:190.
//
	result.values[0] = a.values[0] + b.values[0];
	result.values[1] = a.values[1] + b.values[1];
	result.values[2] = a.values[2] + b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:178.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];
	result.values[2] = a.values[2] * b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z, w: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;
	#overlay (z) zw: Vector(2, T, AXES) = ---;
	#overlay (x) xyz: Vector(3, T, AXES) = ---;
	#overlay (y) yzw: Vector(3, T, AXES) = ---;

	new :: (x: T, y: T, z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (x: T, y: T, zw: Vector(2, $T2, $A2)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];
		result.values[3] = w;

		return result;
	}

	new :: (x: T, yzw: Vector(3, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yzw.values[0];
		result.values[2] = yzw.values[1];
		result.values[3] = yzw.values[2];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), zw: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (xyz: Vector(3, $T0, $A0), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xyz.values[0];
		result.values[1] = xyz.values[1];
		result.values[2] = xyz.values[2];
		result.values[3] = w;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y: T #align 16;
	#overlay (x) values: [N] T = ---;

	new :: (x: T, y: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;

	new :: (x: T, y: T, z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z, w: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;
	#overlay (z) zw: Vector(2, T, AXES) = ---;
	#overlay (x) xyz: Vector(3, T, AXES) = ---;
	#overlay (y) yzw: Vector(3, T, AXES) = ---;

	new :: (x: T, y: T, z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (x: T, y: T, zw: Vector(2, $T2, $A2)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];
		result.values[3] = w;

		return result;
	}

	new :: (x: T, yzw: Vector(3, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yzw.values[0];
		result.values[2] = yzw.values[1];
		result.values[3] = yzw.values[2];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), zw: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (xyz: Vector(3, $T0, $A0), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xyz.values[0];
		result.values[1] = xyz.values[1];
		result.values[2] = xyz.values[2];
		result.values[3] = w;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:274.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];
	result.values[2] = a.values[2] / b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:262.
//
	result.values[0] = a.values[0] + b.values[0];
	result.values[1] = a.values[1] + b.values[1];
	result.values[2] = a.values[2] + b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4.length-1 {
        test._Vec4.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:250.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];
	result.values[2] = a.values[2] * b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:238.
//
	result.values[0] = a.values[0] - b.values[0];
	result.values[1] = a.values[1] - b.values[1];
	result.values[2] = a.values[2] - b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4 / _Vec4", () {
            for 0..test._Vec4.length-1 {
                    test._Vec4.ref[it] = test._Vec4.ref[it] / test._Vec4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y: T #align 16;
	#overlay (x) values: [N] T = ---;

	new :: (x: T, y: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;

	new :: (x: T, y: T, z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:286.
//
	result.values[0] = a.values[0] - b.values[0];
	result.values[1] = a.values[1] - b.values[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:214.
//
	result.values[0] = a.values[0] - b.values[0];
	result.values[1] = a.values[1] - b.values[1];
	result.values[2] = a.values[2] - b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:226.
//
	result.values[0] = a.values[0] + b.values[0];
	result.values[1] = a.values[1] + b.values[1];
	result.values[2] = a.values[2] + b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:298.
//
	result.values[0] = a.values[0] + b.values[0];
	result.values[1] = a.values[1] + b.values[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z, w: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;
	#overlay (z) zw: Vector(2, T, AXES) = ---;
	#overlay (x) xyz: Vector(3, T, AXES) = ---;
	#overlay (y) yzw: Vector(3, T, AXES) = ---;

	new :: (x: T, y: T, z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (x: T, y: T, zw: Vector(2, $T2, $A2)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];
		result.values[3] = w;

		return result;
	}

	new :: (x: T, yzw: Vector(3, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yzw.values[0];
		result.values[2] = yzw.values[1];
		result.values[3] = yzw.values[2];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T, w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;
		result.values[3] = w;

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), zw: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = zw.values[0];
		result.values[3] = zw.values[1];

		return result;
	}

	new :: (xyz: Vector(3, $T0, $A0), w: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xyz.values[0];
		result.values[1] = xyz.values[1];
		result.values[2] = xyz.values[2];
		result.values[3] = w;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y: T #align 16;
	#overlay (x) values: [N] T = ---;

	new :: (x: T, y: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:322.
//
	result.values[0] = a.values[0] + b.values[0];
	result.values[1] = a.values[1] + b.values[1];
	result.values[2] = a.values[2] + b.values[2];
	result.values[3] = a.values[3] + b.values[3];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:310.
//
	result.values[0] = a.values[0] - b.values[0];
	result.values[1] = a.values[1] - b.values[1];
	result.values[2] = a.values[2] - b.values[2];
	result.values[3] = a.values[3] - b.values[3];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:37.
//
	x, y, z: T #align 16;
	#overlay (x) values: [N] T = ---;
	#overlay (x) xy: Vector(2, T, AXES) = ---;
	#overlay (y) yz: Vector(2, T, AXES) = ---;

	new :: (x: T, y: T, z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = y;
		result.values[2] = z;

		return result;
	}

	new :: (x: T, yz: Vector(2, $T1, $A1)) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = x;
		result.values[1] = yz.values[0];
		result.values[2] = yz.values[1];

		return result;
	}

	new :: (xy: Vector(2, $T0, $A0), z: T) -> Vector(N, T, AXES) {
		result: Vector(N, T, AXES);

		result.values[0] = xy.values[0];
		result.values[1] = xy.values[1];
		result.values[2] = z;

		return result;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(4,4,float32)
	_11, _12, _13, _14: T;
	_21, _22, _23, _24: T;
	_31, _32, _33, _34: T;
	_41, _42, _43, _44: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(4,3,float32)
	_11, _12, _13, _14: T;
	_21, _22, _23, _24: T;
	_31, _32, _33, _34: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s8.length-1 {
        test._s8.ref[it] = reinterp(type_of(test._s8.ref[it]), (it+1));
        test._s8.res[it] = reinterp(type_of(test._s8.ref[it]), (it+1));
        test._s8.delta[it] = reinterp(type_of(test._s8.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_s8_default", () {
            for 0..test._s8.length-1 {
                    test._s8.ref[it] = test._s8.ref[it] + test._s8.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2d.length-1 {
        test._Vec2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_s8", () {
        simd_add(test._s8.res, test._s8.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s8.length-1 {
                if abs(cast(float64)(test._s8.ref[it] - test._s8.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s8.ref[it+offset], test._s8.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s8.length-1 {
        test._s8.res[it] = reinterp(type_of(test._s8.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2d - _Vec2d", () {
            for 0..test._Vec2d.length-1 {
                    test._Vec2d.ref[it] = test._Vec2d.ref[it] - test._Vec2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(4,4,float64)
	_11, _12, _13, _14: T;
	_21, _22, _23, _24: T;
	_31, _32, _33, _34: T;
	_41, _42, _43, _44: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2d.length-1 {
        test._Vec2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(3,3,float64)
	_11, _12, _13: T;
	_21, _22, _23: T;
	_31, _32, _33: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2d + _Vec2d", () {
            for 0..test._Vec2d.length-1 {
                    test._Vec2d.ref[it] = test._Vec2d.ref[it] + test._Vec2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(3,3,float32)
	_11, _12, _13: T;
	_21, _22, _23: T;
	_31, _32, _33: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(2,2,float32)
	_11, _12: T;
	_21, _22: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:26.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] - b._simd_data.simd_tail[0];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:26.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] + b._simd_data.simd_tail[0];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u8.length-1 {
        test._u8.ref[it] = reinterp(type_of(test._u8.ref[it]), (it+1));
        test._u8.res[it] = reinterp(type_of(test._u8.ref[it]), (it+1));
        test._u8.delta[it] = reinterp(type_of(test._u8.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2d.length-1 {
        test._Vec2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_u8_default", () {
            for 0..test._u8.length-1 {
                    test._u8.ref[it] = test._u8.ref[it] + test._u8.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2d * _Vec2d", () {
            for 0..test._Vec2d.length-1 {
                    test._Vec2d.ref[it] = test._Vec2d.ref[it] * test._Vec2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("log_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.log(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_u8", () {
        simd_add(test._u8.res, test._u8.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u8.length-1 {
                if abs(cast(float64)(test._u8.ref[it] - test._u8.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u8.ref[it+offset], test._u8.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u8.length-1 {
        test._u8.res[it] = reinterp(type_of(test._u8.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("log_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = log(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("log_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.log(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("log_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = log(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("floor_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.floor(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("floor_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = floor(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("ceil_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.ceil(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("floor_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.floor(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("ceil_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = ceil(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("floor_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = floor(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("frac_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.frac(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("mod_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = mod(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("frac_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.frac(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2d.length-1 {
        test._Vec2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2d).T.T), hash(it * 2 + 1, type_of(test._Vec2d).T.T)};
        test._Vec2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("mod_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = mod(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2d / _Vec2d", () {
            for 0..test._Vec2d.length-1 {
                    test._Vec2d.ref[it] = test._Vec2d.ref[it] / test._Vec2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s8.length-1 {
        test._s8.ref[it] = reinterp(type_of(test._s8.ref[it]), (it+1));
        test._s8.res[it] = reinterp(type_of(test._s8.ref[it]), (it+1));
        test._s8.delta[it] = reinterp(type_of(test._s8.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_s8_default", () {
            for 0..test._s8.length-1 {
                    test._s8.ref[it] = test._s8.ref[it] - test._s8.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("ceil_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.ceil(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("sin_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.sin(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_s8", () {
        simd_sub(test._s8.res, test._s8.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s8.length-1 {
                if abs(cast(float64)(test._s8.ref[it] - test._s8.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s8.ref[it+offset], test._s8.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s8.length-1 {
        test._s8.res[it] = reinterp(type_of(test._s8.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("ceil_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = ceil(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("sin_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = sin(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("sin_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.sin(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("cos_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.cos(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("cos_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.cos(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("sin_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = sin(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("cos_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = cos(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("cos_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = cos(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u8.length-1 {
        test._u8.ref[it] = reinterp(type_of(test._u8.ref[it]), (it+1));
        test._u8.res[it] = reinterp(type_of(test._u8.ref[it]), (it+1));
        test._u8.delta[it] = reinterp(type_of(test._u8.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2.length-1 {
        test._Vec2.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2.length-1 {
        test._Mat2.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 1, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 2, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 3, type_of(test._Mat2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_u8_default", () {
            for 0..test._u8.length-1 {
                    test._u8.ref[it] = test._u8.ref[it] - test._u8.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2 + _Vec2", () {
            for 0..test._Vec2.length-1 {
                    test._Vec2.ref[it] = test._Vec2.ref[it] + test._Vec2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2 + _Mat2", () {
            for 0..test._Mat2.length-1 {
                    test._Mat2.ref[it] = test._Mat2.ref[it] + test._Mat2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_u8", () {
        simd_sub(test._u8.res, test._u8.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u8.length-1 {
                if abs(cast(float64)(test._u8.ref[it] - test._u8.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u8.ref[it+offset], test._u8.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u8.length-1 {
        test._u8.res[it] = reinterp(type_of(test._u8.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] + b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] + b._simd_data.simd_tail[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("tan_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.tan(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2.length-1 {
        test._Vec2.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("tan_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = tan(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2.length-1 {
        test._Mat2.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 1, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 2, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 3, type_of(test._Mat2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2 - _Vec2", () {
            for 0..test._Vec2.length-1 {
                    test._Vec2.ref[it] = test._Vec2.ref[it] - test._Vec2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2 - _Mat2", () {
            for 0..test._Mat2.length-1 {
                    test._Mat2.ref[it] = test._Mat2.ref[it] - test._Mat2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] - b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] - b._simd_data.simd_tail[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s16.length-1 {
        test._s16.ref[it] = reinterp(type_of(test._s16.ref[it]), (it+1));
        test._s16.res[it] = reinterp(type_of(test._s16.ref[it]), (it+1));
        test._s16.delta[it] = reinterp(type_of(test._s16.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_s16_default", () {
            for 0..test._s16.length-1 {
                    test._s16.ref[it] = test._s16.ref[it] + test._s16.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2.length-1 {
        test._Vec2.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2.length-1 {
        test._Mat2.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 1, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 2, type_of(test._Mat2).T.T), hash((it + 1) * 4 + 3, type_of(test._Mat2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_s16", () {
        simd_add(test._s16.res, test._s16.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s16.length-1 {
                if abs(cast(float64)(test._s16.ref[it] - test._s16.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s16.ref[it+offset], test._s16.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s16.length-1 {
        test._s16.res[it] = reinterp(type_of(test._s16.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2 * _Vec2", () {
            for 0..test._Vec2.length-1 {
                    test._Vec2.ref[it] = test._Vec2.ref[it] * test._Vec2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2 * _Mat2", () {
            for 0..test._Mat2.length-1 {
                    test._Mat2.ref[it] = test._Mat2.ref[it] * test._Mat2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] * b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] * b._simd_data.simd_tail[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u16.length-1 {
        test._u16.ref[it] = reinterp(type_of(test._u16.ref[it]), (it+1));
        test._u16.res[it] = reinterp(type_of(test._u16.ref[it]), (it+1));
        test._u16.delta[it] = reinterp(type_of(test._u16.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_u16_default", () {
            for 0..test._u16.length-1 {
                    test._u16.ref[it] = test._u16.ref[it] + test._u16.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(2,2,float64)
	_11, _12: T;
	_21, _22: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("tan_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.tan(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:686.
//
	v.values[0] *= xx factor;	v.values[1] *= xx factor;	v.values[2] *= xx factor;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:112.
//
sqrt(v.values[0] * v.values[0] + v.values[1] * v.values[1] + v.values[2] * v.values[2]);

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("tan_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = tan(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:686.
//
	v.values[0] *= xx factor;	v.values[1] *= xx factor;	v.values[2] *= xx factor;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:112.
//
sqrt(v.values[0] * v.values[0] + v.values[1] * v.values[1] + v.values[2] * v.values[2]);

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:440.
//
	_r0_0 := mat.cells[0][0] * orientation.cells[0][0] + mat.cells[0][1] * orientation.cells[1][0] + mat.cells[0][2] * orientation.cells[2][0];
	_r0_1 := mat.cells[0][0] * orientation.cells[0][1] + mat.cells[0][1] * orientation.cells[1][1] + mat.cells[0][2] * orientation.cells[2][1];
	_r0_2 := mat.cells[0][0] * orientation.cells[0][2] + mat.cells[0][1] * orientation.cells[1][2] + mat.cells[0][2] * orientation.cells[2][2];
	_r1_0 := mat.cells[1][0] * orientation.cells[0][0] + mat.cells[1][1] * orientation.cells[1][0] + mat.cells[1][2] * orientation.cells[2][0];
	_r1_1 := mat.cells[1][0] * orientation.cells[0][1] + mat.cells[1][1] * orientation.cells[1][1] + mat.cells[1][2] * orientation.cells[2][1];
	_r1_2 := mat.cells[1][0] * orientation.cells[0][2] + mat.cells[1][1] * orientation.cells[1][2] + mat.cells[1][2] * orientation.cells[2][2];
	_r2_0 := mat.cells[2][0] * orientation.cells[0][0] + mat.cells[2][1] * orientation.cells[1][0] + mat.cells[2][2] * orientation.cells[2][0];
	_r2_1 := mat.cells[2][0] * orientation.cells[0][1] + mat.cells[2][1] * orientation.cells[1][1] + mat.cells[2][2] * orientation.cells[2][1];
	_r2_2 := mat.cells[2][0] * orientation.cells[0][2] + mat.cells[2][1] * orientation.cells[1][2] + mat.cells[2][2] * orientation.cells[2][2];
	mat.cells[0][0] = _r0_0;
	mat.cells[0][1] = _r0_1;
	mat.cells[0][2] = _r0_2;
	mat.cells[1][0] = _r1_0;
	mat.cells[1][1] = _r1_1;
	mat.cells[1][2] = _r1_2;
	mat.cells[2][0] = _r2_0;
	mat.cells[2][1] = _r2_1;
	mat.cells[2][2] = _r2_2;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_u16", () {
        simd_add(test._u16.res, test._u16.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u16.length-1 {
                if abs(cast(float64)(test._u16.ref[it] - test._u16.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u16.ref[it+offset], test._u16.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u16.length-1 {
        test._u16.res[it] = reinterp(type_of(test._u16.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:343.
//
	_r0_0 := mat.cells[0][0] * rot.cells[0][0] + mat.cells[0][1] * rot.cells[1][0] + mat.cells[0][2] * rot.cells[2][0];
	_r0_1 := mat.cells[0][0] * rot.cells[0][1] + mat.cells[0][1] * rot.cells[1][1] + mat.cells[0][2] * rot.cells[2][1];
	_r0_2 := mat.cells[0][0] * rot.cells[0][2] + mat.cells[0][1] * rot.cells[1][2] + mat.cells[0][2] * rot.cells[2][2];
	_r1_0 := mat.cells[1][0] * rot.cells[0][0] + mat.cells[1][1] * rot.cells[1][0] + mat.cells[1][2] * rot.cells[2][0];
	_r1_1 := mat.cells[1][0] * rot.cells[0][1] + mat.cells[1][1] * rot.cells[1][1] + mat.cells[1][2] * rot.cells[2][1];
	_r1_2 := mat.cells[1][0] * rot.cells[0][2] + mat.cells[1][1] * rot.cells[1][2] + mat.cells[1][2] * rot.cells[2][2];
	_r2_0 := mat.cells[2][0] * rot.cells[0][0] + mat.cells[2][1] * rot.cells[1][0] + mat.cells[2][2] * rot.cells[2][0];
	_r2_1 := mat.cells[2][0] * rot.cells[0][1] + mat.cells[2][1] * rot.cells[1][1] + mat.cells[2][2] * rot.cells[2][1];
	_r2_2 := mat.cells[2][0] * rot.cells[0][2] + mat.cells[2][1] * rot.cells[1][2] + mat.cells[2][2] * rot.cells[2][2];
	_r3_0 := mat.cells[3][0] * rot.cells[0][0] + mat.cells[3][1] * rot.cells[1][0] + mat.cells[3][2] * rot.cells[2][0];
	_r3_1 := mat.cells[3][0] * rot.cells[0][1] + mat.cells[3][1] * rot.cells[1][1] + mat.cells[3][2] * rot.cells[2][1];
	_r3_2 := mat.cells[3][0] * rot.cells[0][2] + mat.cells[3][1] * rot.cells[1][2] + mat.cells[3][2] * rot.cells[2][2];
	mat.cells[0][0] = _r0_0;
	mat.cells[0][1] = _r0_1;
	mat.cells[0][2] = _r0_2;
	mat.cells[1][0] = _r1_0;
	mat.cells[1][1] = _r1_1;
	mat.cells[1][2] = _r1_2;
	mat.cells[2][0] = _r2_0;
	mat.cells[2][1] = _r2_1;
	mat.cells[2][2] = _r2_2;
	mat.cells[3][0] = _r3_0;
	mat.cells[3][1] = _r3_1;
	mat.cells[3][2] = _r3_2;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:343.
//
	_r0_0 := mat.cells[0][0] * rot.cells[0][0] + mat.cells[0][1] * rot.cells[1][0] + mat.cells[0][2] * rot.cells[2][0];
	_r0_1 := mat.cells[0][0] * rot.cells[0][1] + mat.cells[0][1] * rot.cells[1][1] + mat.cells[0][2] * rot.cells[2][1];
	_r0_2 := mat.cells[0][0] * rot.cells[0][2] + mat.cells[0][1] * rot.cells[1][2] + mat.cells[0][2] * rot.cells[2][2];
	_r1_0 := mat.cells[1][0] * rot.cells[0][0] + mat.cells[1][1] * rot.cells[1][0] + mat.cells[1][2] * rot.cells[2][0];
	_r1_1 := mat.cells[1][0] * rot.cells[0][1] + mat.cells[1][1] * rot.cells[1][1] + mat.cells[1][2] * rot.cells[2][1];
	_r1_2 := mat.cells[1][0] * rot.cells[0][2] + mat.cells[1][1] * rot.cells[1][2] + mat.cells[1][2] * rot.cells[2][2];
	_r2_0 := mat.cells[2][0] * rot.cells[0][0] + mat.cells[2][1] * rot.cells[1][0] + mat.cells[2][2] * rot.cells[2][0];
	_r2_1 := mat.cells[2][0] * rot.cells[0][1] + mat.cells[2][1] * rot.cells[1][1] + mat.cells[2][2] * rot.cells[2][1];
	_r2_2 := mat.cells[2][0] * rot.cells[0][2] + mat.cells[2][1] * rot.cells[1][2] + mat.cells[2][2] * rot.cells[2][2];
	mat.cells[0][0] = _r0_0;
	mat.cells[0][1] = _r0_1;
	mat.cells[0][2] = _r0_2;
	mat.cells[1][0] = _r1_0;
	mat.cells[1][1] = _r1_1;
	mat.cells[1][2] = _r1_2;
	mat.cells[2][0] = _r2_0;
	mat.cells[2][1] = _r2_1;
	mat.cells[2][2] = _r2_2;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2d.length-1 {
        test._Mat2d.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 1, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 2, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 3, type_of(test._Mat2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2d.length-1 {
        test._Mat2d.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 1, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 2, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 3, type_of(test._Mat2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2d * _Mat2d", () {
            for 0..test._Mat2d.length-1 {
                    test._Mat2d.ref[it] = test._Mat2d.ref[it] * test._Mat2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2d.length-1 {
        test._Mat2d.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 1, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 2, type_of(test._Mat2d).T.T), hash((it + 1) * 4 + 3, type_of(test._Mat2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2d + _Mat2d", () {
            for 0..test._Mat2d.length-1 {
                    test._Mat2d.ref[it] = test._Mat2d.ref[it] + test._Mat2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2d.length-1 {
        test._Mat2d.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2d).T.T), hash(it * 4 + 1, type_of(test._Mat2d).T.T), hash(it * 4 + 2, type_of(test._Mat2d).T.T), hash(it * 4 + 3, type_of(test._Mat2d).T.T)};
        test._Mat2d.delta[it] = type_of(test._Mat2d.delta[it]).identity();
        for k: 0..type_of(test._Mat2d.delta[it]).N-1
            test._Mat2d.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test._Mat2d.delta[it]).N + k), type_of(test._Mat2d).T.T) * 0.0001;
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2d - _Mat2d", () {
            for 0..test._Mat2d.length-1 {
                    test._Mat2d.ref[it] = test._Mat2d.ref[it] - test._Mat2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2d / _Mat2d", () {
            for 0..test._Mat2d.length-1 {
                    test._Mat2d.ref[it] = test._Mat2d.ref[it] / test._Mat2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec2.length-1 {
        test._Vec2.ref[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.res[it] = .{hash(it * 2 + 0, type_of(test._Vec2).T.T), hash(it * 2 + 1, type_of(test._Vec2).T.T)};
        test._Vec2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Vec2).T.T), hash((it + 1) * 2 + 1, type_of(test._Vec2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s16.length-1 {
        test._s16.ref[it] = reinterp(type_of(test._s16.ref[it]), (it+1));
        test._s16.res[it] = reinterp(type_of(test._s16.ref[it]), (it+1));
        test._s16.delta[it] = reinterp(type_of(test._s16.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat2.length-1 {
        test._Mat2.ref[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.res[it] = .{hash(it * 4 + 0, type_of(test._Mat2).T.T), hash(it * 4 + 1, type_of(test._Mat2).T.T), hash(it * 4 + 2, type_of(test._Mat2).T.T), hash(it * 4 + 3, type_of(test._Mat2).T.T)};
        test._Mat2.delta[it] = type_of(test._Mat2.delta[it]).identity();
        for k: 0..type_of(test._Mat2.delta[it]).N-1
            test._Mat2.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test._Mat2.delta[it]).N + k), type_of(test._Mat2).T.T) * 0.0001;
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec2 / _Vec2", () {
            for 0..test._Vec2.length-1 {
                    test._Vec2.ref[it] = test._Vec2.ref[it] / test._Vec2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_s16_default", () {
            for 0..test._s16.length-1 {
                    test._s16.ref[it] = test._s16.ref[it] - test._s16.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat2 / _Mat2", () {
            for 0..test._Mat2.length-1 {
                    test._Mat2.ref[it] = test._Mat2.ref[it] / test._Mat2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] / b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] / b._simd_data.simd_tail[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_s16", () {
        simd_sub(test._s16.res, test._s16.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s16.length-1 {
                if abs(cast(float64)(test._s16.ref[it] - test._s16.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s16.ref[it+offset], test._s16.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s16.length-1 {
        test._s16.res[it] = reinterp(type_of(test._s16.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/matrix.jai:18.
//
//	Matrix(4,3,float64)
	_11, _12, _13, _14: T;
	_21, _22, _23, _24: T;
	_31, _32, _33, _34: T;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("atan_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.atan(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("atan_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = atan(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("atan_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.atan(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2.length-1 {
        test._Point2.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.res[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("atan_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = atan(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2 + _Point2", () {
            for 0..test._Point2.length-1 {
                    test._Point2.ref[it] = test._Point2.ref[it] + test._Point2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3d.length-1 {
        test._Mat3d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u16.length-1 {
        test._u16.ref[it] = reinterp(type_of(test._u16.ref[it]), (it+1));
        test._u16.res[it] = reinterp(type_of(test._u16.ref[it]), (it+1));
        test._u16.delta[it] = reinterp(type_of(test._u16.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] + b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] + b._simd_data.simd_tail[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3d + _Mat3d", () {
            for 0..test._Mat3d.length-1 {
                    test._Mat3d.ref[it] = test._Mat3d.ref[it] + test._Mat3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_u16_default", () {
            for 0..test._u16.length-1 {
                    test._u16.ref[it] = test._u16.ref[it] - test._u16.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:26.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] + b._simd_data.simd_tail[0];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_u16", () {
        simd_sub(test._u16.res, test._u16.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u16.length-1 {
                if abs(cast(float64)(test._u16.ref[it] - test._u16.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u16.ref[it+offset], test._u16.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u16.length-1 {
        test._u16.res[it] = reinterp(type_of(test._u16.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("atan2_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.atan2(test._f32.ref[it], test._f32.delta[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("atan2_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = atan2(test._f32.res[it], test._f32.delta[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("atan2_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.atan2(test._f64.ref[it], test._f64.delta[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2.length-1 {
        test._Point2.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.res[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("atan2_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = atan2(test._f64.res[it], test._f64.delta[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3d.length-1 {
        test._Mat3d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2 - _Point2", () {
            for 0..test._Point2.length-1 {
                    test._Point2.ref[it] = test._Point2.ref[it] - test._Point2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s32.length-1 {
        test._s32.ref[it] = reinterp(type_of(test._s32.ref[it]), (it+1));
        test._s32.res[it] = reinterp(type_of(test._s32.ref[it]), (it+1));
        test._s32.delta[it] = reinterp(type_of(test._s32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3d - _Mat3d", () {
            for 0..test._Mat3d.length-1 {
                    test._Mat3d.ref[it] = test._Mat3d.ref[it] - test._Mat3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] - b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] - b._simd_data.simd_tail[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_s32_default", () {
            for 0..test._s32.length-1 {
                    test._s32.ref[it] = test._s32.ref[it] + test._s32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:26.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] - b._simd_data.simd_tail[0];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_s32", () {
        simd_add(test._s32.res, test._s32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s32.length-1 {
                if abs(cast(float64)(test._s32.ref[it] - test._s32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s32.ref[it+offset], test._s32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s32.length-1 {
        test._s32.res[it] = reinterp(type_of(test._s32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("sqrt_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.sqrt(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2.length-1 {
        test._Point2.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.res[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("sqrt_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = sqrt(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2 * _Point2", () {
            for 0..test._Point2.length-1 {
                    test._Point2.ref[it] = test._Point2.ref[it] * test._Point2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3d.length-1 {
        test._Mat3d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3d).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u32.length-1 {
        test._u32.ref[it] = reinterp(type_of(test._u32.ref[it]), (it+1));
        test._u32.res[it] = reinterp(type_of(test._u32.ref[it]), (it+1));
        test._u32.delta[it] = reinterp(type_of(test._u32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:355.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3d * _Mat3d", () {
            for 0..test._Mat3d.length-1 {
                    test._Mat3d.ref[it] = test._Mat3d.ref[it] * test._Mat3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_u32_default", () {
            for 0..test._u32.length-1 {
                    test._u32.ref[it] = test._u32.ref[it] + test._u32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_u32", () {
        simd_add(test._u32.res, test._u32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u32.length-1 {
                if abs(cast(float64)(test._u32.ref[it] - test._u32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u32.ref[it+offset], test._u32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u32.length-1 {
        test._u32.res[it] = reinterp(type_of(test._u32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2.length-1 {
        test._Point2.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.res[it] = .{hash(it * 2 + 0, type_of(test._Point2).T.T), hash(it * 2 + 1, type_of(test._Point2).T.T)};
        test._Point2.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3d.length-1 {
        test._Mat3d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3d).T.T), hash(it * 9 + 1, type_of(test._Mat3d).T.T), hash(it * 9 + 2, type_of(test._Mat3d).T.T), hash(it * 9 + 3, type_of(test._Mat3d).T.T), hash(it * 9 + 4, type_of(test._Mat3d).T.T), hash(it * 9 + 5, type_of(test._Mat3d).T.T), hash(it * 9 + 6, type_of(test._Mat3d).T.T), hash(it * 9 + 7, type_of(test._Mat3d).T.T), hash(it * 9 + 8, type_of(test._Mat3d).T.T)};
        test._Mat3d.delta[it] = type_of(test._Mat3d.delta[it]).identity();
        for k: 0..type_of(test._Mat3d.delta[it]).N-1
            test._Mat3d.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test._Mat3d.delta[it]).N + k), type_of(test._Mat3d).T.T) * 0.0001;
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2 / _Point2", () {
            for 0..test._Point2.length-1 {
                    test._Point2.ref[it] = test._Point2.ref[it] / test._Point2.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3d / _Mat3d", () {
            for 0..test._Mat3d.length-1 {
                    test._Mat3d.ref[it] = test._Mat3d.ref[it] / test._Mat3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.delta[it] = reinterp(type_of(test._f32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:371.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_f32_default", () {
            for 0..test._f32.length-1 {
                    test._f32.ref[it] = test._f32.ref[it] + test._f32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_f32", () {
        simd_add(test._f32.res, test._f32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f32.length-1 {
                if abs(cast(float64)(test._f32.ref[it] - test._f32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f32.ref[it+offset], test._f32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4d.length-1 {
        test._Point4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.res[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2d.length-1 {
        test._Point2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.res[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4d * _Point4d", () {
            for 0..test._Point4d.length-1 {
                    test._Point4d.ref[it] = test._Point4d.ref[it] * test._Point4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2d + _Point2d", () {
            for 0..test._Point2d.length-1 {
                    test._Point2d.ref[it] = test._Point2d.ref[it] + test._Point2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:355.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];
	result.values[2] = a.values[2] * b.values[2];
	result.values[3] = a.values[3] * b.values[3];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s32.length-1 {
        test._s32.ref[it] = reinterp(type_of(test._s32.ref[it]), (it+1));
        test._s32.res[it] = reinterp(type_of(test._s32.ref[it]), (it+1));
        test._s32.delta[it] = reinterp(type_of(test._s32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3.length-1 {
        test._Mat3.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_s32_default", () {
            for 0..test._s32.length-1 {
                    test._s32.ref[it] = test._s32.ref[it] - test._s32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3 + _Mat3", () {
            for 0..test._Mat3.length-1 {
                    test._Mat3.ref[it] = test._Mat3.ref[it] + test._Mat3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("sqrt_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.sqrt(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_s32", () {
        simd_sub(test._s32.res, test._s32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s32.length-1 {
                if abs(cast(float64)(test._s32.ref[it] - test._s32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s32.ref[it+offset], test._s32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s32.length-1 {
        test._s32.res[it] = reinterp(type_of(test._s32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("sqrt_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = sqrt(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2d.length-1 {
        test._Point2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.res[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u32.length-1 {
        test._u32.ref[it] = reinterp(type_of(test._u32.ref[it]), (it+1));
        test._u32.res[it] = reinterp(type_of(test._u32.ref[it]), (it+1));
        test._u32.delta[it] = reinterp(type_of(test._u32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2d - _Point2d", () {
            for 0..test._Point2d.length-1 {
                    test._Point2d.ref[it] = test._Point2d.ref[it] - test._Point2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3.length-1 {
        test._Mat3.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_u32_default", () {
            for 0..test._u32.length-1 {
                    test._u32.ref[it] = test._u32.ref[it] - test._u32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3 - _Mat3", () {
            for 0..test._Mat3.length-1 {
                    test._Mat3.ref[it] = test._Mat3.ref[it] - test._Mat3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_u32", () {
        simd_sub(test._u32.res, test._u32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u32.length-1 {
                if abs(cast(float64)(test._u32.ref[it] - test._u32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u32.ref[it+offset], test._u32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u32.length-1 {
        test._u32.res[it] = reinterp(type_of(test._u32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4d.length-1 {
        test._Point4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.res[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4d / _Point4d", () {
            for 0..test._Point4d.length-1 {
                    test._Point4d.ref[it] = test._Point4d.ref[it] / test._Point4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2d.length-1 {
        test._Point2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.res[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:371.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];
	result.values[2] = a.values[2] / b.values[2];
	result.values[3] = a.values[3] / b.values[3];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3.length-1 {
        test._Mat3.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2d * _Point2d", () {
            for 0..test._Point2d.length-1 {
                    test._Point2d.ref[it] = test._Point2d.ref[it] * test._Point2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.delta[it] = reinterp(type_of(test._f32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3 * _Mat3", () {
            for 0..test._Mat3.length-1 {
                    test._Mat3.ref[it] = test._Mat3.ref[it] * test._Mat3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:355.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_f32_default", () {
            for 0..test._f32.length-1 {
                    test._f32.ref[it] = test._f32.ref[it] - test._f32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point2d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_f32", () {
        simd_sub(test._f32.res, test._f32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f32.length-1 {
                if abs(cast(float64)(test._f32.ref[it] - test._f32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f32.ref[it+offset], test._f32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point2d.length-1 {
        test._Point2d.ref[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.res[it] = .{hash(it * 2 + 0, type_of(test._Point2d).T.T), hash(it * 2 + 1, type_of(test._Point2d).T.T)};
        test._Point2d.delta[it] = .{hash((it + 1) * 2 + 0, type_of(test._Point2d).T.T), hash((it + 1) * 2 + 1, type_of(test._Point2d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3.length-1 {
        test._Mat3.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3).T.T), hash(it * 9 + 1, type_of(test._Mat3).T.T), hash(it * 9 + 2, type_of(test._Mat3).T.T), hash(it * 9 + 3, type_of(test._Mat3).T.T), hash(it * 9 + 4, type_of(test._Mat3).T.T), hash(it * 9 + 5, type_of(test._Mat3).T.T), hash(it * 9 + 6, type_of(test._Mat3).T.T), hash(it * 9 + 7, type_of(test._Mat3).T.T), hash(it * 9 + 8, type_of(test._Mat3).T.T)};
        test._Mat3.delta[it] = type_of(test._Mat3.delta[it]).identity();
        for k: 0..type_of(test._Mat3.delta[it]).N-1
            test._Mat3.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test._Mat3.delta[it]).N + k), type_of(test._Mat3).T.T) * 0.0001;
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point2d / _Point2d", () {
            for 0..test._Point2d.length-1 {
                    test._Point2d.ref[it] = test._Point2d.ref[it] / test._Point2d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3 / _Mat3", () {
            for 0..test._Mat3.length-1 {
                    test._Mat3.ref[it] = test._Mat3.ref[it] / test._Mat3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.delta[it] = reinterp(type_of(test._f32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:371.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("mult_f32_default", () {
            for 0..test._f32.length-1 {
                    test._f32.ref[it] = test._f32.ref[it] * test._f32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4d.length-1 {
        test._Point4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.res[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("mult_f32", () {
        simd_mult(test._f32.res, test._f32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f32.length-1 {
                if abs(cast(float64)(test._f32.ref[it] - test._f32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f32.ref[it+offset], test._f32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3d.length-1 {
        test._Vec3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4d - _Point4d", () {
            for 0..test._Point4d.length-1 {
                    test._Point4d.ref[it] = test._Point4d.ref[it] - test._Point4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3d + _Vec3d", () {
            for 0..test._Vec3d.length-1 {
                    test._Vec3d.ref[it] = test._Vec3d.ref[it] + test._Vec3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3x4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1));
        test._f32.delta[it] = reinterp(type_of(test._f32.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3x4d.length-1 {
        test._Mat3x4d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4d).T.T), hash(it * 9 + 1, type_of(test._Mat3x4d).T.T), hash(it * 9 + 2, type_of(test._Mat3x4d).T.T), hash(it * 9 + 3, type_of(test._Mat3x4d).T.T), hash(it * 9 + 4, type_of(test._Mat3x4d).T.T), hash(it * 9 + 5, type_of(test._Mat3x4d).T.T), hash(it * 9 + 6, type_of(test._Mat3x4d).T.T), hash(it * 9 + 7, type_of(test._Mat3x4d).T.T), hash(it * 9 + 8, type_of(test._Mat3x4d).T.T)};
        test._Mat3x4d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4d).T.T), hash(it * 9 + 1, type_of(test._Mat3x4d).T.T), hash(it * 9 + 2, type_of(test._Mat3x4d).T.T), hash(it * 9 + 3, type_of(test._Mat3x4d).T.T), hash(it * 9 + 4, type_of(test._Mat3x4d).T.T), hash(it * 9 + 5, type_of(test._Mat3x4d).T.T), hash(it * 9 + 6, type_of(test._Mat3x4d).T.T), hash(it * 9 + 7, type_of(test._Mat3x4d).T.T), hash(it * 9 + 8, type_of(test._Mat3x4d).T.T)};
        test._Mat3x4d.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3x4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("div_f32_default", () {
            for 0..test._f32.length-1 {
                    test._f32.ref[it] = test._f32.ref[it] / test._f32.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3d.length-1 {
        test._Vec3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3x4d + _Mat3x4d", () {
            for 0..test._Mat3x4d.length-1 {
                    test._Mat3x4d.ref[it] = test._Mat3x4d.ref[it] + test._Mat3x4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("div_f32", () {
        simd_div(test._f32.res, test._f32.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f32.length-1 {
                if abs(cast(float64)(test._f32.ref[it] - test._f32.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f32.ref[it+offset], test._f32.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = reinterp(type_of(test._f32.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3d - _Vec3d", () {
            for 0..test._Vec3d.length-1 {
                    test._Vec3d.ref[it] = test._Vec3d.ref[it] - test._Vec3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3x4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s64.length-1 {
        test._s64.ref[it] = reinterp(type_of(test._s64.ref[it]), (it+1));
        test._s64.res[it] = reinterp(type_of(test._s64.ref[it]), (it+1));
        test._s64.delta[it] = reinterp(type_of(test._s64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3x4d.length-1 {
        test._Mat3x4d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4d).T.T), hash(it * 9 + 1, type_of(test._Mat3x4d).T.T), hash(it * 9 + 2, type_of(test._Mat3x4d).T.T), hash(it * 9 + 3, type_of(test._Mat3x4d).T.T), hash(it * 9 + 4, type_of(test._Mat3x4d).T.T), hash(it * 9 + 5, type_of(test._Mat3x4d).T.T), hash(it * 9 + 6, type_of(test._Mat3x4d).T.T), hash(it * 9 + 7, type_of(test._Mat3x4d).T.T), hash(it * 9 + 8, type_of(test._Mat3x4d).T.T)};
        test._Mat3x4d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4d).T.T), hash(it * 9 + 1, type_of(test._Mat3x4d).T.T), hash(it * 9 + 2, type_of(test._Mat3x4d).T.T), hash(it * 9 + 3, type_of(test._Mat3x4d).T.T), hash(it * 9 + 4, type_of(test._Mat3x4d).T.T), hash(it * 9 + 5, type_of(test._Mat3x4d).T.T), hash(it * 9 + 6, type_of(test._Mat3x4d).T.T), hash(it * 9 + 7, type_of(test._Mat3x4d).T.T), hash(it * 9 + 8, type_of(test._Mat3x4d).T.T)};
        test._Mat3x4d.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3x4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_s64_default", () {
            for 0..test._s64.length-1 {
                    test._s64.ref[it] = test._s64.ref[it] + test._s64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3d.length-1 {
        test._Vec3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3x4d - _Mat3x4d", () {
            for 0..test._Mat3x4d.length-1 {
                    test._Mat3x4d.ref[it] = test._Mat3x4d.ref[it] - test._Mat3x4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_s64", () {
        simd_add(test._s64.res, test._s64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s64.length-1 {
                if abs(cast(float64)(test._s64.ref[it] - test._s64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s64.ref[it+offset], test._s64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s64.length-1 {
        test._s64.res[it] = reinterp(type_of(test._s64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3d * _Vec3d", () {
            for 0..test._Vec3d.length-1 {
                    test._Vec3d.ref[it] = test._Vec3d.ref[it] * test._Vec3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3x4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u64.length-1 {
        test._u64.ref[it] = reinterp(type_of(test._u64.ref[it]), (it+1));
        test._u64.res[it] = reinterp(type_of(test._u64.ref[it]), (it+1));
        test._u64.delta[it] = reinterp(type_of(test._u64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3x4d.length-1 {
        test._Mat3x4d.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4d).T.T), hash(it * 9 + 1, type_of(test._Mat3x4d).T.T), hash(it * 9 + 2, type_of(test._Mat3x4d).T.T), hash(it * 9 + 3, type_of(test._Mat3x4d).T.T), hash(it * 9 + 4, type_of(test._Mat3x4d).T.T), hash(it * 9 + 5, type_of(test._Mat3x4d).T.T), hash(it * 9 + 6, type_of(test._Mat3x4d).T.T), hash(it * 9 + 7, type_of(test._Mat3x4d).T.T), hash(it * 9 + 8, type_of(test._Mat3x4d).T.T)};
        test._Mat3x4d.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4d).T.T), hash(it * 9 + 1, type_of(test._Mat3x4d).T.T), hash(it * 9 + 2, type_of(test._Mat3x4d).T.T), hash(it * 9 + 3, type_of(test._Mat3x4d).T.T), hash(it * 9 + 4, type_of(test._Mat3x4d).T.T), hash(it * 9 + 5, type_of(test._Mat3x4d).T.T), hash(it * 9 + 6, type_of(test._Mat3x4d).T.T), hash(it * 9 + 7, type_of(test._Mat3x4d).T.T), hash(it * 9 + 8, type_of(test._Mat3x4d).T.T)};
        test._Mat3x4d.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3x4d).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3x4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_u64_default", () {
            for 0..test._u64.length-1 {
                    test._u64.ref[it] = test._u64.ref[it] + test._u64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4d.length-1 {
        test._Point4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.res[it] = .{hash(it * 4 + 0, type_of(test._Point4d).T.T), hash(it * 4 + 1, type_of(test._Point4d).T.T), hash(it * 4 + 2, type_of(test._Point4d).T.T), hash(it * 4 + 3, type_of(test._Point4d).T.T)};
        test._Point4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3x4d * _Mat3x4d", () {
            for 0..test._Mat3x4d.length-1 {
                    test._Mat3x4d.ref[it] = test._Mat3x4d.ref[it] * test._Mat3x4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_u64", () {
        simd_add(test._u64.res, test._u64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u64.length-1 {
                if abs(cast(float64)(test._u64.ref[it] - test._u64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u64.ref[it+offset], test._u64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u64.length-1 {
        test._u64.res[it] = reinterp(type_of(test._u64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4d + _Point4d", () {
            for 0..test._Point4d.length-1 {
                    test._Point4d.ref[it] = test._Point4d.ref[it] + test._Point4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3x4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.delta[it] = reinterp(type_of(test._f64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3d.length-1 {
        test._Vec3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3d).T.T), hash(it * 3 + 1, type_of(test._Vec3d).T.T), hash(it * 3 + 2, type_of(test._Vec3d).T.T)};
        test._Vec3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3x4.length-1 {
        test._Mat3x4.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4).T.T), hash(it * 9 + 1, type_of(test._Mat3x4).T.T), hash(it * 9 + 2, type_of(test._Mat3x4).T.T), hash(it * 9 + 3, type_of(test._Mat3x4).T.T), hash(it * 9 + 4, type_of(test._Mat3x4).T.T), hash(it * 9 + 5, type_of(test._Mat3x4).T.T), hash(it * 9 + 6, type_of(test._Mat3x4).T.T), hash(it * 9 + 7, type_of(test._Mat3x4).T.T), hash(it * 9 + 8, type_of(test._Mat3x4).T.T)};
        test._Mat3x4.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4).T.T), hash(it * 9 + 1, type_of(test._Mat3x4).T.T), hash(it * 9 + 2, type_of(test._Mat3x4).T.T), hash(it * 9 + 3, type_of(test._Mat3x4).T.T), hash(it * 9 + 4, type_of(test._Mat3x4).T.T), hash(it * 9 + 5, type_of(test._Mat3x4).T.T), hash(it * 9 + 6, type_of(test._Mat3x4).T.T), hash(it * 9 + 7, type_of(test._Mat3x4).T.T), hash(it * 9 + 8, type_of(test._Mat3x4).T.T)};
        test._Mat3x4.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3x4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("add_f64_default", () {
            for 0..test._f64.length-1 {
                    test._f64.ref[it] = test._f64.ref[it] + test._f64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3d / _Vec3d", () {
            for 0..test._Vec3d.length-1 {
                    test._Vec3d.ref[it] = test._Vec3d.ref[it] / test._Vec3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3x4 + _Mat3x4", () {
            for 0..test._Mat3x4.length-1 {
                    test._Mat3x4.ref[it] = test._Mat3x4.ref[it] + test._Mat3x4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("add_f64", () {
        simd_add(test._f64.res, test._f64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f64.length-1 {
                if abs(cast(float64)(test._f64.ref[it] - test._f64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f64.ref[it+offset], test._f64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3x4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._s64.length-1 {
        test._s64.ref[it] = reinterp(type_of(test._s64.ref[it]), (it+1));
        test._s64.res[it] = reinterp(type_of(test._s64.ref[it]), (it+1));
        test._s64.delta[it] = reinterp(type_of(test._s64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3.length-1 {
        test._Vec3.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3x4.length-1 {
        test._Mat3x4.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4).T.T), hash(it * 9 + 1, type_of(test._Mat3x4).T.T), hash(it * 9 + 2, type_of(test._Mat3x4).T.T), hash(it * 9 + 3, type_of(test._Mat3x4).T.T), hash(it * 9 + 4, type_of(test._Mat3x4).T.T), hash(it * 9 + 5, type_of(test._Mat3x4).T.T), hash(it * 9 + 6, type_of(test._Mat3x4).T.T), hash(it * 9 + 7, type_of(test._Mat3x4).T.T), hash(it * 9 + 8, type_of(test._Mat3x4).T.T)};
        test._Mat3x4.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4).T.T), hash(it * 9 + 1, type_of(test._Mat3x4).T.T), hash(it * 9 + 2, type_of(test._Mat3x4).T.T), hash(it * 9 + 3, type_of(test._Mat3x4).T.T), hash(it * 9 + 4, type_of(test._Mat3x4).T.T), hash(it * 9 + 5, type_of(test._Mat3x4).T.T), hash(it * 9 + 6, type_of(test._Mat3x4).T.T), hash(it * 9 + 7, type_of(test._Mat3x4).T.T), hash(it * 9 + 8, type_of(test._Mat3x4).T.T)};
        test._Mat3x4.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3x4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_s64_default", () {
            for 0..test._s64.length-1 {
                    test._s64.ref[it] = test._s64.ref[it] - test._s64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3 + _Vec3", () {
            for 0..test._Vec3.length-1 {
                    test._Vec3.ref[it] = test._Vec3.ref[it] + test._Vec3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3x4 - _Mat3x4", () {
            for 0..test._Mat3x4.length-1 {
                    test._Mat3x4.ref[it] = test._Mat3x4.ref[it] - test._Mat3x4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_s64", () {
        simd_sub(test._s64.res, test._s64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._s64.length-1 {
                if abs(cast(float64)(test._s64.ref[it] - test._s64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._s64.ref[it+offset], test._s64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._s64.length-1 {
        test._s64.res[it] = reinterp(type_of(test._s64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat3x4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3.length-1 {
        test._Vec3.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._u64.length-1 {
        test._u64.ref[it] = reinterp(type_of(test._u64.ref[it]), (it+1));
        test._u64.res[it] = reinterp(type_of(test._u64.ref[it]), (it+1));
        test._u64.delta[it] = reinterp(type_of(test._u64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat3x4.length-1 {
        test._Mat3x4.ref[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4).T.T), hash(it * 9 + 1, type_of(test._Mat3x4).T.T), hash(it * 9 + 2, type_of(test._Mat3x4).T.T), hash(it * 9 + 3, type_of(test._Mat3x4).T.T), hash(it * 9 + 4, type_of(test._Mat3x4).T.T), hash(it * 9 + 5, type_of(test._Mat3x4).T.T), hash(it * 9 + 6, type_of(test._Mat3x4).T.T), hash(it * 9 + 7, type_of(test._Mat3x4).T.T), hash(it * 9 + 8, type_of(test._Mat3x4).T.T)};
        test._Mat3x4.res[it] = .{hash(it * 9 + 0, type_of(test._Mat3x4).T.T), hash(it * 9 + 1, type_of(test._Mat3x4).T.T), hash(it * 9 + 2, type_of(test._Mat3x4).T.T), hash(it * 9 + 3, type_of(test._Mat3x4).T.T), hash(it * 9 + 4, type_of(test._Mat3x4).T.T), hash(it * 9 + 5, type_of(test._Mat3x4).T.T), hash(it * 9 + 6, type_of(test._Mat3x4).T.T), hash(it * 9 + 7, type_of(test._Mat3x4).T.T), hash(it * 9 + 8, type_of(test._Mat3x4).T.T)};
        test._Mat3x4.delta[it] = .{hash((it + 1) * 9 + 0, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 1, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 2, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 3, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 4, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 5, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 6, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 7, type_of(test._Mat3x4).T.T), hash((it + 1) * 9 + 8, type_of(test._Mat3x4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3 - _Vec3", () {
            for 0..test._Vec3.length-1 {
                    test._Vec3.ref[it] = test._Vec3.ref[it] - test._Vec3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_u64_default", () {
            for 0..test._u64.length-1 {
                    test._u64.ref[it] = test._u64.ref[it] - test._u64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat3x4 * _Mat3x4", () {
            for 0..test._Mat3x4.length-1 {
                    test._Mat3x4.ref[it] = test._Mat3x4.ref[it] * test._Mat3x4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_u64", () {
        simd_sub(test._u64.res, test._u64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._u64.length-1 {
                if abs(cast(float64)(test._u64.ref[it] - test._u64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._u64.ref[it+offset], test._u64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._u64.length-1 {
        test._u64.res[it] = reinterp(type_of(test._u64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4.length-1 {
        test._Point4.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.res[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3.length-1 {
        test._Vec3.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4 / _Point4", () {
            for 0..test._Point4.length-1 {
                    test._Point4.ref[it] = test._Point4.ref[it] / test._Point4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3 * _Vec3", () {
            for 0..test._Vec3.length-1 {
                    test._Vec3.ref[it] = test._Vec3.ref[it] * test._Vec3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:371.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];
	result.values[2] = a.values[2] / b.values[2];
	result.values[3] = a.values[3] / b.values[3];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4d.length-1 {
        test._Mat4d.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.delta[it] = .{hash((it + 1) * 16 + 0, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 1, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 2, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 3, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 4, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 5, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 6, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 7, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 8, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 9, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 10, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 11, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 12, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 13, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 14, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 15, type_of(test._Mat4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.delta[it] = reinterp(type_of(test._f64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f32.length-1 {
        test._f32.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f32.res[it] = xx (1+(it+1) * 1.23456789);
        test._f32.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4d + _Mat4d", () {
            for 0..test._Mat4d.length-1 {
                    test._Mat4d.ref[it] = test._Mat4d.ref[it] + test._Mat4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("sub_f64_default", () {
            for 0..test._f64.length-1 {
                    test._f64.ref[it] = test._f64.ref[it] - test._f64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("exp_f32_default", () {
                for 0..test._f32.length-1 {
                        test._f32.ref[it] = Math.exp(test._f32.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:381.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = xx (1+(it+1) * 1.23456789);
        test._f64.res[it] = xx (1+(it+1) * 1.23456789);
        test._f64.delta[it] = xx (1+(it+2) * 1.23456789);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.delta[it] = reinterp(type_of(test._f64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:439.
//
    for 0..test._f64.length-1 {
        test._f64.ref[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1));
        test._f64.delta[it] = reinterp(type_of(test._f64.ref[it]), (it+2)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Mat4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Point3d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4d).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:49.
//
type_of(test._Vec4).T.N;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("sub_f64", () {
        simd_sub(test._f64.res, test._f64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f64.length-1 {
                if abs(cast(float64)(test._f64.ref[it] - test._f64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f64.ref[it+offset], test._f64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4.length-1 {
        test._Point4.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.res[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4.length-1 {
        test._Vec4.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4 * _Point4", () {
            for 0..test._Point4.length-1 {
                    test._Point4.ref[it] = test._Point4.ref[it] * test._Point4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4 * _Vec4", () {
            for 0..test._Vec4.length-1 {
                    test._Vec4.ref[it] = test._Vec4.ref[it] * test._Vec4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4d.length-1 {
        test._Vec4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:355.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];
	result.values[2] = a.values[2] * b.values[2];
	result.values[3] = a.values[3] * b.values[3];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4.length-1 {
        test._Vec4.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4d / _Vec4d", () {
            for 0..test._Vec4d.length-1 {
                    test._Vec4d.ref[it] = test._Vec4d.ref[it] / test._Vec4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4.length-1 {
        test._Vec4.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4).T.T), hash(it * 4 + 1, type_of(test._Vec4).T.T), hash(it * 4 + 2, type_of(test._Vec4).T.T), hash(it * 4 + 3, type_of(test._Vec4).T.T)};
        test._Vec4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4 + _Vec4", () {
            for 0..test._Vec4.length-1 {
                    test._Vec4.ref[it] = test._Vec4.ref[it] + test._Vec4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4.length-1 {
        test._Mat4.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.delta[it] = type_of(test._Mat4.delta[it]).identity();
        for k: 0..type_of(test._Mat4.delta[it]).N-1
            test._Mat4.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test._Mat4.delta[it]).N + k), type_of(test._Mat4).T.T) * 0.0001;
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4 - _Vec4", () {
            for 0..test._Vec4.length-1 {
                    test._Vec4.ref[it] = test._Vec4.ref[it] - test._Vec4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3d.length-1 {
        test._Point3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.res[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4 / _Mat4", () {
            for 0..test._Mat4.length-1 {
                    test._Mat4.ref[it] = test._Mat4.ref[it] / test._Mat4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3d.length-1 {
        test._Point3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.res[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3d * _Point3d", () {
            for 0..test._Point3d.length-1 {
                    test._Point3d.ref[it] = test._Point3d.ref[it] * test._Point3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4d.length-1 {
        test._Vec4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3d / _Point3d", () {
            for 0..test._Point3d.length-1 {
                    test._Point3d.ref[it] = test._Point3d.ref[it] / test._Point3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:355.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];
	result.values[2] = a.values[2] * b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4d + _Vec4d", () {
            for 0..test._Vec4d.length-1 {
                    test._Vec4d.ref[it] = test._Vec4d.ref[it] + test._Vec4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:371.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];
	result.values[2] = a.values[2] / b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4d.length-1 {
        test._Vec4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec4d.length-1 {
        test._Vec4d.ref[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.res[it] = .{hash(it * 4 + 0, type_of(test._Vec4d).T.T), hash(it * 4 + 1, type_of(test._Vec4d).T.T), hash(it * 4 + 2, type_of(test._Vec4d).T.T), hash(it * 4 + 3, type_of(test._Vec4d).T.T)};
        test._Vec4d.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 1, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 2, type_of(test._Vec4d).T.T), hash((it + 1) * 4 + 3, type_of(test._Vec4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Vec3.length-1 {
        test._Vec3.ref[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.res[it] = .{hash(it * 3 + 0, type_of(test._Vec3).T.T), hash(it * 3 + 1, type_of(test._Vec3).T.T), hash(it * 3 + 2, type_of(test._Vec3).T.T)};
        test._Vec3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 1, type_of(test._Vec3).T.T), hash((it + 1) * 3 + 2, type_of(test._Vec3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4d - _Vec4d", () {
            for 0..test._Vec4d.length-1 {
                    test._Vec4d.ref[it] = test._Vec4d.ref[it] - test._Vec4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec4d * _Vec4d", () {
            for 0..test._Vec4d.length-1 {
                    test._Vec4d.ref[it] = test._Vec4d.ref[it] * test._Vec4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Vec3 / _Vec3", () {
            for 0..test._Vec3.length-1 {
                    test._Vec3.ref[it] = test._Vec3.ref[it] / test._Vec3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4d.length-1 {
        test._Mat4d.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.delta[it] = .{hash((it + 1) * 16 + 0, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 1, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 2, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 3, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 4, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 5, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 6, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 7, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 8, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 9, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 10, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 11, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 12, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 13, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 14, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 15, type_of(test._Mat4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("mult_f64_default", () {
            for 0..test._f64.length-1 {
                    test._f64.ref[it] = test._f64.ref[it] * test._f64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3.length-1 {
        test._Point3.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.res[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4d - _Mat4d", () {
            for 0..test._Mat4d.length-1 {
                    test._Mat4d.ref[it] = test._Mat4d.ref[it] - test._Mat4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("mult_f64", () {
        simd_mult(test._f64.res, test._f64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f64.length-1 {
                if abs(cast(float64)(test._f64.ref[it] - test._f64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f64.ref[it+offset], test._f64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3 + _Point3", () {
            for 0..test._Point3.length-1 {
                    test._Point3.ref[it] = test._Point3.ref[it] + test._Point3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4d.length-1 {
        test._Mat4d.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.delta[it] = .{hash((it + 1) * 16 + 0, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 1, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 2, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 3, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 4, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 5, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 6, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 7, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 8, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 9, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 10, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 11, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 12, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 13, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 14, type_of(test._Mat4d).T.T), hash((it + 1) * 16 + 15, type_of(test._Mat4d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] + b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] + b._simd_data.simd_tail[1];result._simd_data.simd_tail[2] = a._simd_data.simd_tail[2] + b._simd_data.simd_tail[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4d * _Mat4d", () {
            for 0..test._Mat4d.length-1 {
                    test._Mat4d.ref[it] = test._Mat4d.ref[it] * test._Mat4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:447.
//
        do_test("div_f64_default", () {
            for 0..test._f64.length-1 {
                    test._f64.ref[it] = test._f64.ref[it] / test._f64.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4.length-1 {
        test._Point4.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.res[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3.length-1 {
        test._Point3.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.res[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:471.
//

    do_test("div_f64", () {
        simd_div(test._f64.res, test._f64.delta);
    }, ()->(bool, s64){
            last_error := -1;
            for 0..test._f64.length-1 {
                if abs(cast(float64)(test._f64.ref[it] - test._f64.res[it])) > epsilon(float64) {
                    for offset: -2..2 {
                        if it+offset < 0 then continue;
                        log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", it+offset, test._f64.ref[it+offset], test._f64.res[it+offset]);
                    }
                    last_error = it;
                    exit(0);
                }
            }
            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = reinterp(type_of(test._f64.ref[it]), (it+1)); 
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4 - _Point4", () {
            for 0..test._Point4.length-1 {
                    test._Point4.ref[it] = test._Point4.ref[it] - test._Point4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3 - _Point3", () {
            for 0..test._Point3.length-1 {
                    test._Point3.ref[it] = test._Point3.ref[it] - test._Point3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4d.length-1 {
        test._Mat4d.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4d).T.T), hash(it * 16 + 1, type_of(test._Mat4d).T.T), hash(it * 16 + 2, type_of(test._Mat4d).T.T), hash(it * 16 + 3, type_of(test._Mat4d).T.T), hash(it * 16 + 4, type_of(test._Mat4d).T.T), hash(it * 16 + 5, type_of(test._Mat4d).T.T), hash(it * 16 + 6, type_of(test._Mat4d).T.T), hash(it * 16 + 7, type_of(test._Mat4d).T.T), hash(it * 16 + 8, type_of(test._Mat4d).T.T), hash(it * 16 + 9, type_of(test._Mat4d).T.T), hash(it * 16 + 10, type_of(test._Mat4d).T.T), hash(it * 16 + 11, type_of(test._Mat4d).T.T), hash(it * 16 + 12, type_of(test._Mat4d).T.T), hash(it * 16 + 13, type_of(test._Mat4d).T.T), hash(it * 16 + 14, type_of(test._Mat4d).T.T), hash(it * 16 + 15, type_of(test._Mat4d).T.T)};
        test._Mat4d.delta[it] = type_of(test._Mat4d.delta[it]).identity();
        for k: 0..type_of(test._Mat4d.delta[it]).N-1
            test._Mat4d.delta[it].values[k] += hash(cast(s64) ((it + 1) * type_of(test._Mat4d.delta[it]).N + k), type_of(test._Mat4d).T.T) * 0.0001;
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:17.
//
result._simd_data.simd_tail[0] = a._simd_data.simd_tail[0] - b._simd_data.simd_tail[0];result._simd_data.simd_tail[1] = a._simd_data.simd_tail[1] - b._simd_data.simd_tail[1];result._simd_data.simd_tail[2] = a._simd_data.simd_tail[2] - b._simd_data.simd_tail[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3.length-1 {
        test._Point3.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.res[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4d / _Mat4d", () {
            for 0..test._Mat4d.length-1 {
                    test._Mat4d.ref[it] = test._Mat4d.ref[it] / test._Mat4d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4.length-1 {
        test._Mat4.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.delta[it] = .{hash((it + 1) * 16 + 0, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 1, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 2, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 3, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 4, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 5, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 6, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 7, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 8, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 9, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 10, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 11, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 12, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 13, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 14, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 15, type_of(test._Mat4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3 * _Point3", () {
            for 0..test._Point3.length-1 {
                    test._Point3.ref[it] = test._Point3.ref[it] * test._Point3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4 + _Mat4", () {
            for 0..test._Mat4.length-1 {
                    test._Mat4.ref[it] = test._Mat4.ref[it] + test._Mat4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3.length-1 {
        test._Point3.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.res[it] = .{hash(it * 3 + 0, type_of(test._Point3).T.T), hash(it * 3 + 1, type_of(test._Point3).T.T), hash(it * 3 + 2, type_of(test._Point3).T.T)};
        test._Point3.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:355.
//
	result.values[0] = a.values[0] * b.values[0];
	result.values[1] = a.values[1] * b.values[1];
	result.values[2] = a.values[2] * b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4.length-1 {
        test._Mat4.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.delta[it] = .{hash((it + 1) * 16 + 0, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 1, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 2, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 3, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 4, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 5, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 6, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 7, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 8, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 9, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 10, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 11, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 12, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 13, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 14, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 15, type_of(test._Mat4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3 / _Point3", () {
            for 0..test._Point3.length-1 {
                    test._Point3.ref[it] = test._Point3.ref[it] / test._Point3.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point4.length-1 {
        test._Point4.ref[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.res[it] = .{hash(it * 4 + 0, type_of(test._Point4).T.T), hash(it * 4 + 1, type_of(test._Point4).T.T), hash(it * 4 + 2, type_of(test._Point4).T.T), hash(it * 4 + 3, type_of(test._Point4).T.T)};
        test._Point4.delta[it] = .{hash((it + 1) * 4 + 0, type_of(test._Point4).T.T), hash((it + 1) * 4 + 1, type_of(test._Point4).T.T), hash((it + 1) * 4 + 2, type_of(test._Point4).T.T), hash((it + 1) * 4 + 3, type_of(test._Point4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4 - _Mat4", () {
            for 0..test._Mat4.length-1 {
                    test._Mat4.ref[it] = test._Mat4.ref[it] - test._Mat4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../types/vector.jai:371.
//
	result.values[0] = a.values[0] / b.values[0];
	result.values[1] = a.values[1] / b.values[1];
	result.values[2] = a.values[2] / b.values[2];

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point4 + _Point4", () {
            for 0..test._Point4.length-1 {
                    test._Point4.ref[it] = test._Point4.ref[it] + test._Point4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3d.length-1 {
        test._Point3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.res[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Mat4.length-1 {
        test._Mat4.ref[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.res[it] = .{hash(it * 16 + 0, type_of(test._Mat4).T.T), hash(it * 16 + 1, type_of(test._Mat4).T.T), hash(it * 16 + 2, type_of(test._Mat4).T.T), hash(it * 16 + 3, type_of(test._Mat4).T.T), hash(it * 16 + 4, type_of(test._Mat4).T.T), hash(it * 16 + 5, type_of(test._Mat4).T.T), hash(it * 16 + 6, type_of(test._Mat4).T.T), hash(it * 16 + 7, type_of(test._Mat4).T.T), hash(it * 16 + 8, type_of(test._Mat4).T.T), hash(it * 16 + 9, type_of(test._Mat4).T.T), hash(it * 16 + 10, type_of(test._Mat4).T.T), hash(it * 16 + 11, type_of(test._Mat4).T.T), hash(it * 16 + 12, type_of(test._Mat4).T.T), hash(it * 16 + 13, type_of(test._Mat4).T.T), hash(it * 16 + 14, type_of(test._Mat4).T.T), hash(it * 16 + 15, type_of(test._Mat4).T.T)};
        test._Mat4.delta[it] = .{hash((it + 1) * 16 + 0, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 1, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 2, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 3, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 4, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 5, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 6, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 7, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 8, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 9, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 10, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 11, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 12, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 13, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 14, type_of(test._Mat4).T.T), hash((it + 1) * 16 + 15, type_of(test._Mat4).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:51.
//
for 0..test._Point3d.length-1 {
        test._Point3d.ref[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.res[it] = .{hash(it * 3 + 0, type_of(test._Point3d).T.T), hash(it * 3 + 1, type_of(test._Point3d).T.T), hash(it * 3 + 2, type_of(test._Point3d).T.T)};
        test._Point3d.delta[it] = .{hash((it + 1) * 3 + 0, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 1, type_of(test._Point3d).T.T), hash((it + 1) * 3 + 2, type_of(test._Point3d).T.T)};
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3d + _Point3d", () {
            for 0..test._Point3d.length-1 {
                    test._Point3d.ref[it] = test._Point3d.ref[it] + test._Point3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Mat4 * _Mat4", () {
            for 0..test._Mat4.length-1 {
                    test._Mat4.ref[it] = test._Mat4.ref[it] * test._Mat4.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/matrix.jai:94.
//
        do_test("_Point3d - _Point3d", () {
            for 0..test._Point3d.length-1 {
                    test._Point3d.ref[it] = test._Point3d.ref[it] - test._Point3d.delta[it];
                    }
            }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("exp_f32", () {
    for 0..test._f32.length-1 {
            test._f32.res[it] = exp(test._f32.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f32.length-1 {
            if abs(test._f32.ref[it] - test._f32.res[it]) > epsilon(type_of(test._f32.ref[it])) { 
                    error += cast(float64) (test._f32.ref[it] - test._f32.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f32.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f32.ref[last_error+offset], test._f32.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f32.length-1 {
        test._f32.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:389.
//
            do_test("exp_f64_default", () {
                for 0..test._f64.length-1 {
                        test._f64.ref[it] = Math.exp(test._f64.ref[it]);
                        }
                }, ()->(bool, s64){return false, -1;});

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/number.jai:399.
//

    do_test("exp_f64", () {
    for 0..test._f64.length-1 {
            test._f64.res[it] = exp(test._f64.res[it]);
        } 
    }, ()->(bool, s64){
            last_error := -1;

            for 0..test._f64.length-1 {
            if abs(test._f64.ref[it] - test._f64.res[it]) > epsilon(type_of(test._f64.ref[it])) { 
                    error += cast(float64) (test._f64.ref[it] - test._f64.res[it]);
                    last_error = it;
                }
            }

            if last_error >=0 {
                for offset: -2..2 {
                    if last_error+offset < 0 || last_error+offset >= test._f64.length then continue;
                    log("\t%%: ref %, res %", ifx offset == 0 then ">>" else "  ", last_error+offset, test._f64.ref[last_error+offset], test._f64.res[last_error+offset]);
                }
            }

            return last_error >= 0, last_error;
        });

    for 0..test._f64.length-1 {
        test._f64.res[it] = xx (it+1);
    }

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:62.
//

//	SIMD 2x2 float64 multiply — inline asm broadcast-mul-acc
	b_0_0 := b._simd_data.simd16[0];
	b_1_0 := b._simd_data.simd16[1];

	// Row 0
	{
		a_seg_0 := a._simd_data.simd16[0];
		r_0: [SIMD_WIDTH] T.T = ---;  
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
		}
		result._simd_data.simd16[0] = r_0;
	}

	// Row 1
	{
		a_seg_0 := a._simd_data.simd16[1];
		r_0: [SIMD_WIDTH] T.T = ---;  
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
		}
		result._simd_data.simd16[1] = r_0;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:62.
//

//	SIMD 3x3 float64 multiply — inline asm broadcast-mul-acc
	b_0_0: [SIMD_WIDTH] T.T = ---;  b_0_0[0] = b.cells[0][0]; b_0_0[1] = b.cells[0][1]; 
	b_1_0: [SIMD_WIDTH] T.T = ---;  b_1_0[0] = b.cells[1][0]; b_1_0[1] = b.cells[1][1]; 
	b_2_0: [SIMD_WIDTH] T.T = ---;  b_2_0[0] = b.cells[2][0]; b_2_0[1] = b.cells[2][1]; 

	// Row 0
	{
		a_seg_0: [SIMD_WIDTH] T.T = ---;  a_seg_0[0] = a.cells[0][0]; a_seg_0[1] = a.cells[0][1]; 
		r_0: [SIMD_WIDTH] T.T = ---;  
		bk_2: [SIMD_WIDTH] T.T = ---;  bk_2[0] = a.cells[0][2]; bk_2[1] = a.cells[0][2]; 
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk2s0: vec, bk_2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
		}
		result.cells[0][2] = a.cells[0][0] * b.cells[0][2];
		result.cells[0][2] += a.cells[0][1] * b.cells[1][2];
		result.cells[0][2] += a.cells[0][2] * b.cells[2][2];
		result.cells[0][0] = r_0[0];
		result.cells[0][1] = r_0[1];
	}

	// Row 1
	{
		a_seg_0: [SIMD_WIDTH] T.T = ---;  a_seg_0[0] = a.cells[1][0]; a_seg_0[1] = a.cells[1][1]; 
		r_0: [SIMD_WIDTH] T.T = ---;  
		bk_2: [SIMD_WIDTH] T.T = ---;  bk_2[0] = a.cells[1][2]; bk_2[1] = a.cells[1][2]; 
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk2s0: vec, bk_2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
		}
		result.cells[1][2] = a.cells[1][0] * b.cells[0][2];
		result.cells[1][2] += a.cells[1][1] * b.cells[1][2];
		result.cells[1][2] += a.cells[1][2] * b.cells[2][2];
		result.cells[1][0] = r_0[0];
		result.cells[1][1] = r_0[1];
	}

	// Row 2
	{
		a_seg_0: [SIMD_WIDTH] T.T = ---;  a_seg_0[0] = a.cells[2][0]; a_seg_0[1] = a.cells[2][1]; 
		r_0: [SIMD_WIDTH] T.T = ---;  
		bk_2: [SIMD_WIDTH] T.T = ---;  bk_2[0] = a.cells[2][2]; bk_2[1] = a.cells[2][2]; 
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk2s0: vec, bk_2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
		}
		result.cells[2][2] = a.cells[2][0] * b.cells[0][2];
		result.cells[2][2] += a.cells[2][1] * b.cells[1][2];
		result.cells[2][2] += a.cells[2][2] * b.cells[2][2];
		result.cells[2][0] = r_0[0];
		result.cells[2][1] = r_0[1];
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:154.
//
return cmds.sub;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:154.
//
return cmds.div;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubw.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubw.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movups.x xmm0, [result+offset];
	movups.x xmm1, [bp+offset];
	divps.x xmm0, xmm0, xmm1;
	movups.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	divps.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	divpd.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movupd.x xmm0, [result+offset];
	movupd.x xmm1, [bp+offset];
	divpd.x xmm0, xmm0, xmm1;
	movupd.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubb.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubb.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movups.x xmm0, [result+offset];
	movups.x xmm1, [bp+offset];
	subps.x xmm0, xmm0, xmm1;
	movups.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubd.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubd.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	subpd.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	subps.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	psubd.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubq.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movupd.x xmm0, [result+offset];
	movupd.x xmm1, [bp+offset];
	subpd.x xmm0, xmm0, xmm1;
	movupd.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	psubq.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:154.
//
return cmds.add;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:154.
//
return cmds.mult;

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	paddd.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddw.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movupd.x xmm0, [result+offset];
	movupd.x xmm1, [bp+offset];
	mulpd.x xmm0, xmm0, xmm1;
	movupd.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	mulpd.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	mulps.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movups.x xmm0, [result+offset];
	movups.x xmm1, [bp+offset];
	mulps.x xmm0, xmm0, xmm1;
	movups.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddd.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddw.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	addps.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddb.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movupd.x xmm0, [result+offset];
	movupd.x xmm1, [bp+offset];
	addpd.x xmm0, xmm0, xmm1;
	movupd.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddq.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/vector.jai:50.
//
#asm AVX, AVX2 {
	addpd.x result, a, b;
}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddq.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddd.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movups.x xmm0, [result+offset];
	movups.x xmm1, [bp+offset];
	addps.x xmm0, xmm0, xmm1;
	movups.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/common.jai:96.
//
#asm AVX, AVX2 {
	xmm0: vec === 0;
	xmm1: vec === 1;

	movdqu.x xmm0, [result+offset];
	movdqu.x xmm1, [bp+offset];
	paddb.x xmm0, xmm0, xmm1;
	movdqu.x [result+offset], xmm0;

}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:62.
//

//	SIMD 4x4 float64 multiply — inline asm broadcast-mul-acc
	b_0_0 := b._simd_data.simd16[0];
	b_0_1 := b._simd_data.simd16[1];
	b_1_0 := b._simd_data.simd16[2];
	b_1_1 := b._simd_data.simd16[3];
	b_2_0 := b._simd_data.simd16[4];
	b_2_1 := b._simd_data.simd16[5];
	b_3_0 := b._simd_data.simd16[6];
	b_3_1 := b._simd_data.simd16[7];

	// Row 0
	{
		a_seg_0 := a._simd_data.simd16[0];
		a_seg_1 := a._simd_data.simd16[1];
		r_0: [SIMD_WIDTH] T.T = ---;  
		r_1: [SIMD_WIDTH] T.T = ---;  
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			movddup.x bk2: vec, a_seg_1;
			shufpd.x bk3: vec, a_seg_1, a_seg_1, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x r_1, bk0, b_0_1;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk1s1: vec, bk1, b_1_1;
			addpd.x r_1, r_1, pk1s1;
			mulpd.x pk2s0: vec, bk2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
			mulpd.x pk2s1: vec, bk2, b_2_1;
			addpd.x r_1, r_1, pk2s1;
			mulpd.x pk3s0: vec, bk3, b_3_0;
			addpd.x r_0, r_0, pk3s0;
			mulpd.x pk3s1: vec, bk3, b_3_1;
			addpd.x r_1, r_1, pk3s1;
		}
		result._simd_data.simd16[0] = r_0;
		result._simd_data.simd16[1] = r_1;
	}

	// Row 1
	{
		a_seg_0 := a._simd_data.simd16[2];
		a_seg_1 := a._simd_data.simd16[3];
		r_0: [SIMD_WIDTH] T.T = ---;  
		r_1: [SIMD_WIDTH] T.T = ---;  
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			movddup.x bk2: vec, a_seg_1;
			shufpd.x bk3: vec, a_seg_1, a_seg_1, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x r_1, bk0, b_0_1;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk1s1: vec, bk1, b_1_1;
			addpd.x r_1, r_1, pk1s1;
			mulpd.x pk2s0: vec, bk2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
			mulpd.x pk2s1: vec, bk2, b_2_1;
			addpd.x r_1, r_1, pk2s1;
			mulpd.x pk3s0: vec, bk3, b_3_0;
			addpd.x r_0, r_0, pk3s0;
			mulpd.x pk3s1: vec, bk3, b_3_1;
			addpd.x r_1, r_1, pk3s1;
		}
		result._simd_data.simd16[2] = r_0;
		result._simd_data.simd16[3] = r_1;
	}

	// Row 2
	{
		a_seg_0 := a._simd_data.simd16[4];
		a_seg_1 := a._simd_data.simd16[5];
		r_0: [SIMD_WIDTH] T.T = ---;  
		r_1: [SIMD_WIDTH] T.T = ---;  
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			movddup.x bk2: vec, a_seg_1;
			shufpd.x bk3: vec, a_seg_1, a_seg_1, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x r_1, bk0, b_0_1;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk1s1: vec, bk1, b_1_1;
			addpd.x r_1, r_1, pk1s1;
			mulpd.x pk2s0: vec, bk2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
			mulpd.x pk2s1: vec, bk2, b_2_1;
			addpd.x r_1, r_1, pk2s1;
			mulpd.x pk3s0: vec, bk3, b_3_0;
			addpd.x r_0, r_0, pk3s0;
			mulpd.x pk3s1: vec, bk3, b_3_1;
			addpd.x r_1, r_1, pk3s1;
		}
		result._simd_data.simd16[4] = r_0;
		result._simd_data.simd16[5] = r_1;
	}

	// Row 3
	{
		a_seg_0 := a._simd_data.simd16[6];
		a_seg_1 := a._simd_data.simd16[7];
		r_0: [SIMD_WIDTH] T.T = ---;  
		r_1: [SIMD_WIDTH] T.T = ---;  
		#asm AVX {
			movddup.x bk0: vec, a_seg_0;
			shufpd.x bk1: vec, a_seg_0, a_seg_0, 0x3;
			movddup.x bk2: vec, a_seg_1;
			shufpd.x bk3: vec, a_seg_1, a_seg_1, 0x3;
			mulpd.x r_0, bk0, b_0_0;
			mulpd.x r_1, bk0, b_0_1;
			mulpd.x pk1s0: vec, bk1, b_1_0;
			addpd.x r_0, r_0, pk1s0;
			mulpd.x pk1s1: vec, bk1, b_1_1;
			addpd.x r_1, r_1, pk1s1;
			mulpd.x pk2s0: vec, bk2, b_2_0;
			addpd.x r_0, r_0, pk2s0;
			mulpd.x pk2s1: vec, bk2, b_2_1;
			addpd.x r_1, r_1, pk2s1;
			mulpd.x pk3s0: vec, bk3, b_3_0;
			addpd.x r_0, r_0, pk3s0;
			mulpd.x pk3s1: vec, bk3, b_3_1;
			addpd.x r_1, r_1, pk3s1;
		}
		result._simd_data.simd16[6] = r_0;
		result._simd_data.simd16[7] = r_1;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:62.
//

//	SIMD 4x4 float32 multiply — inline asm broadcast-mul-acc
	b_0_0 := b._simd_data.simd16[0];
	b_1_0 := b._simd_data.simd16[1];
	b_2_0 := b._simd_data.simd16[2];
	b_3_0 := b._simd_data.simd16[3];

	// Row 0
	{
		a_seg_0 := a._simd_data.simd16[0];
		r_0: [SIMD_WIDTH] T.T = ---;  
		#asm AVX, AVX2 {
			broadcastss.x bk0: vec, a_seg_0;
			shufps.x bk1: vec, a_seg_0, a_seg_0, 0x55;
			shufps.x bk2: vec, a_seg_0, a_seg_0, 0xaa;
			shufps.x bk3: vec, a_seg_0, a_seg_0, 0xff;
			mulps.x r_0, bk0, b_0_0;
			mulps.x pk1s0: vec, bk1, b_1_0;
			addps.x r_0, r_0, pk1s0;
			mulps.x pk2s0: vec, bk2, b_2_0;
			addps.x r_0, r_0, pk2s0;
			mulps.x pk3s0: vec, bk3, b_3_0;
			addps.x r_0, r_0, pk3s0;
		}
		result._simd_data.simd16[0] = r_0;
	}

	// Row 1
	{
		a_seg_0 := a._simd_data.simd16[1];
		r_0: [SIMD_WIDTH] T.T = ---;  
		#asm AVX, AVX2 {
			broadcastss.x bk0: vec, a_seg_0;
			shufps.x bk1: vec, a_seg_0, a_seg_0, 0x55;
			shufps.x bk2: vec, a_seg_0, a_seg_0, 0xaa;
			shufps.x bk3: vec, a_seg_0, a_seg_0, 0xff;
			mulps.x r_0, bk0, b_0_0;
			mulps.x pk1s0: vec, bk1, b_1_0;
			addps.x r_0, r_0, pk1s0;
			mulps.x pk2s0: vec, bk2, b_2_0;
			addps.x r_0, r_0, pk2s0;
			mulps.x pk3s0: vec, bk3, b_3_0;
			addps.x r_0, r_0, pk3s0;
		}
		result._simd_data.simd16[1] = r_0;
	}

	// Row 2
	{
		a_seg_0 := a._simd_data.simd16[2];
		r_0: [SIMD_WIDTH] T.T = ---;  
		#asm AVX, AVX2 {
			broadcastss.x bk0: vec, a_seg_0;
			shufps.x bk1: vec, a_seg_0, a_seg_0, 0x55;
			shufps.x bk2: vec, a_seg_0, a_seg_0, 0xaa;
			shufps.x bk3: vec, a_seg_0, a_seg_0, 0xff;
			mulps.x r_0, bk0, b_0_0;
			mulps.x pk1s0: vec, bk1, b_1_0;
			addps.x r_0, r_0, pk1s0;
			mulps.x pk2s0: vec, bk2, b_2_0;
			addps.x r_0, r_0, pk2s0;
			mulps.x pk3s0: vec, bk3, b_3_0;
			addps.x r_0, r_0, pk3s0;
		}
		result._simd_data.simd16[2] = r_0;
	}

	// Row 3
	{
		a_seg_0 := a._simd_data.simd16[3];
		r_0: [SIMD_WIDTH] T.T = ---;  
		#asm AVX, AVX2 {
			broadcastss.x bk0: vec, a_seg_0;
			shufps.x bk1: vec, a_seg_0, a_seg_0, 0x55;
			shufps.x bk2: vec, a_seg_0, a_seg_0, 0xaa;
			shufps.x bk3: vec, a_seg_0, a_seg_0, 0xff;
			mulps.x r_0, bk0, b_0_0;
			mulps.x pk1s0: vec, bk1, b_1_0;
			addps.x r_0, r_0, pk1s0;
			mulps.x pk2s0: vec, bk2, b_2_0;
			addps.x r_0, r_0, pk2s0;
			mulps.x pk3s0: vec, bk3, b_3_0;
			addps.x r_0, r_0, pk3s0;
		}
		result._simd_data.simd16[3] = r_0;
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:62.
//

//	SIMD 3x3 float32 multiply — inline asm broadcast-mul-acc

	// Row 0
	{
		result.cells[0][0] = a.cells[0][0] * b.cells[0][0];
		result.cells[0][1] = a.cells[0][0] * b.cells[0][1];
		result.cells[0][2] = a.cells[0][0] * b.cells[0][2];
		result.cells[0][0] += a.cells[0][1] * b.cells[1][0];
		result.cells[0][1] += a.cells[0][1] * b.cells[1][1];
		result.cells[0][2] += a.cells[0][1] * b.cells[1][2];
		result.cells[0][0] += a.cells[0][2] * b.cells[2][0];
		result.cells[0][1] += a.cells[0][2] * b.cells[2][1];
		result.cells[0][2] += a.cells[0][2] * b.cells[2][2];
	}

	// Row 1
	{
		result.cells[1][0] = a.cells[1][0] * b.cells[0][0];
		result.cells[1][1] = a.cells[1][0] * b.cells[0][1];
		result.cells[1][2] = a.cells[1][0] * b.cells[0][2];
		result.cells[1][0] += a.cells[1][1] * b.cells[1][0];
		result.cells[1][1] += a.cells[1][1] * b.cells[1][1];
		result.cells[1][2] += a.cells[1][1] * b.cells[1][2];
		result.cells[1][0] += a.cells[1][2] * b.cells[2][0];
		result.cells[1][1] += a.cells[1][2] * b.cells[2][1];
		result.cells[1][2] += a.cells[1][2] * b.cells[2][2];
	}

	// Row 2
	{
		result.cells[2][0] = a.cells[2][0] * b.cells[0][0];
		result.cells[2][1] = a.cells[2][0] * b.cells[0][1];
		result.cells[2][2] = a.cells[2][0] * b.cells[0][2];
		result.cells[2][0] += a.cells[2][1] * b.cells[1][0];
		result.cells[2][1] += a.cells[2][1] * b.cells[1][1];
		result.cells[2][2] += a.cells[2][1] * b.cells[1][2];
		result.cells[2][0] += a.cells[2][2] * b.cells[2][0];
		result.cells[2][1] += a.cells[2][2] * b.cells[2][1];
		result.cells[2][2] += a.cells[2][2] * b.cells[2][2];
	}

//
// #insert text. Generated from /home/nick/Documents/Jay/engine/Jay_Math/tests/../simd/matrix.jai:62.
//

//	SIMD 2x2 float32 multiply — inline asm broadcast-mul-acc

	// Row 0
	{
		result.cells[0][0] = a.cells[0][0] * b.cells[0][0];
		result.cells[0][1] = a.cells[0][0] * b.cells[0][1];
		result.cells[0][0] += a.cells[0][1] * b.cells[1][0];
		result.cells[0][1] += a.cells[0][1] * b.cells[1][1];
	}

	// Row 1
	{
		result.cells[1][0] = a.cells[1][0] * b.cells[0][0];
		result.cells[1][1] = a.cells[1][0] * b.cells[0][1];
		result.cells[1][0] += a.cells[1][1] * b.cells[1][0];
		result.cells[1][1] += a.cells[1][1] * b.cells[1][1];
	}
