sin :: inline (x: float32) -> float32 { return cast(float32) sin(cast(float64) x); }    
sin :: inline (x: float64) -> float64 {
    s, _ := inline sincos(x, do_sin = true, do_cos = false);
    return s;
}
sin :: inline (x: $T/Integers) -> T { return xx floor(sin(cast(float64)x) + 0.5); }

cos :: inline (x: float32) -> float32 { return cast(float32) cos(cast(float64) x); } 
cos :: inline (x: float64) -> float64 {
    _, c := inline sincos(x, do_sin = false, do_cos = true);
    return c;
}
cos :: inline (x: $T/Integers) -> T { return xx floor(cos(cast(float64)x) + 0.5); }

sincos :: inline (x: float64, $do_sin: bool, $do_cos: bool) -> (sin_value: float64, cos_value: float64) {
    #assert do_sin || do_cos "sincos: at least one of do_sin or do_cos must be true"; 

    if x == 0 {
        #if  do_sin && do_cos  return 0, 1;
        #if  do_sin && !do_cos return 0, 0;
        #if !do_sin && do_cos  return 0, 1;
    }

    sf := reinterp(s64, x);
    exponent := cast(s32) ((sf >> 52) & 0x7ff);
    if exponent == 0x7ff {
        if isnan(x) return x, x;
        return FLOAT64_NAN, FLOAT64_NAN;
    }

    /* make argument positive but save the sign (for sin only; cos is even) */
    #if do_sin  sin_negate : s64 = 0;
    #if do_cos  cos_negate : s64 = 0;
    {
        flint: FloatInt64 = ---;
        flint._float64 = x;
        #if do_sin  sin_negate = xx(flint._u64 >> 63);
        flint._u64 &= 0x7fff_ffff_ffff_ffff;
        x = flint._float64;
    }

    if x > LOSSTH return 0, 0;

    j := cast(s64)(x/PIO4);
    j += (j & 1);
    y := cast(float64) j;
    j = j & 0b111;

    /* reflect in x axis */
    #if do_sin  sin_negate ^= (j >> 2);
    #if do_cos  cos_negate  = (j >> 2);

    sin_j := j & 2;
    #if do_cos {
        // cos is offset by one quadrant from sin
        cos_negate ^= (sin_j >> 1);
        cos_j := !sin_j;
    }

    /* Extended precision modular arithmetic */
    z := ((x - y * DP1) - y * DP2) - y * DP3;
    zz := z * z;

    // Evaluate both polynomials from the shared reduced argument
    cos_poly := 1.0 - zz*0.5 + zz * zz * polynomial_eval_coscof5(zz);
    sin_poly := z + z * (zz * polynomial_eval_sincof5(zz));

    // Select which polynomial goes to which output based on octant
    #if do_sin {
        sin_r: float64 = ---;
        if sin_j { sin_r = cos_poly; } else { sin_r = sin_poly; }
    }
    #if do_cos {
        cos_r: float64 = ---;
        if cos_j { cos_r = cos_poly; } else { cos_r = sin_poly; }
    }

    // Apply sign bits
    #if do_sin {
        sin_flint: FloatInt64 = ---;
        sin_flint._float64 = sin_r;
        sin_flint._u64 ^= xx,no_check(sin_negate << 63);
    }
    #if do_cos {
        cos_flint: FloatInt64 = ---;
        cos_flint._float64 = cos_r;
        cos_flint._u64 ^= xx,no_check(cos_negate << 63);
    }

    #if do_sin && do_cos  return sin_flint._float64, cos_flint._float64;
    #if do_sin && !do_cos return sin_flint._float64, 0;
    #if !do_sin && do_cos return 0, cos_flint._float64;
}

tan :: inline (y: float32) -> float32 { return cast(float32) tan(cast(float64)y); } 
tan :: inline (x: float64) -> float64 {
    s,c := sincos(x, true, true);
    return s/c;
}
tan :: inline (x: $T/Integers) -> T { return xx floor(tan(cast(float64)x) + 0.5); }

atan :: inline (y: float32) -> float32 { return cast(float32) atan(cast(float64)y); } 
atan :: inline (x: float64) -> float64 {
    if x == 0.0 return x;

    if x ==  INFINITY return  PIO2;
    if x == -INFINITY return -PIO2;

    sign: s16 = 1;

    if x < 0 {
	    sign = -1;
	    x = -x;
    }

    /* range reduction */

    y: float64 = ---;
    morebits: float64 = ---;
    if x > T3P8 {
	    y = PIO2;
	    morebits = MOREBITS;
	    x = -1/x;
    } else if x <= 0.66 {
	    y = 0;
	    morebits = 0;
    } else {
	    y = PIO4;
	    morebits = 0.5 * MOREBITS;
	    x = (x-1)/(x+1);
    }

    z := x * x;

    p := ((((0hbfec007fa1f72594 * z + 0hc03028545b6b807a) * z + 0hc052c08c36880273) * z + 0hc05eb8bf2d05ba25) * z + 0hc0503669fd28ec8e);
    q := (((( z               + 0h4038dbc45b14603c) * z + 0h4064a0dd43b8fa25) * z + 0h407b0e18d2e2be3b) * z + 0h407e563f13b049ea) * z + 0h4068519efbbd62ec;
    z = z * p / q;

    z = x * z + x;
    z += morebits;
    y += z;

    if sign < 0  return -y;
    return y;
}
atan :: inline (x: $T/Integers) -> T { return xx floor(atan(cast(float64)x) + 0.5); }

atan2 :: (y: float, x: float) -> float { return cast(float) atan2(cast(float64) y, cast(float64) x); } 
atan2 :: (y: float64, x: float64) -> float64 {
    //
    // Here we have some preambles to check for nans, +/- zero, and infinities.
    // Original Cephes had ifdefs so that you could compile these out.
    // If you don't care about these, you could skip them. But really, I think
    // if you don't care about these, you are likely to be using some other
    // fast atan2 approximation anyway. Hard to say!
    //

    //
    // We did a substantial amount of streamlining here to remove
    // unnecessary assignments to variables, 'else's that didn't need
    // to be there, etc!
    //
    if isnan(x) return x;
    if isnan(y) return y;

    if y == 0 {  // 0.0 compares as equal to -0.0, so .. yeah.
	    if signbit(y) {
		    if x > 0  return y;
		    if x < 0  return -PI;

			if signbit(x) return -PI;
			return y;
		} else {
            // y is +0 if we get here.
		    if x == 0 {
			    if signbit(x) return PI;
			    return 0;
			}

            if x > 0   return 0;
            return PI;
		}
	}
    
    if x == 0 {
        if y > 0 return PIO2;
        return -PIO2;
	}
    
    if x == INFINITY {
	    if y == INFINITY  return 0.25 * PI;
	    if y == -INFINITY return -0.25 * PI;
	    if y < 0  	      return -0.0;

	    return 0;
	}
    
    if x == -INFINITY {
	    if y == INFINITY   return 0.75 * PI;
	    if y <= -INFINITY  return -0.75 * PI;
	    if y >= 0          return PI;
        
	    return -PI;
	}

    if y ==  INFINITY return  PIO2;
    if y == -INFINITY return -PIO2;

    code: s16;
    if x < 0  code = 2;
    if y < 0  code |= 1;

    if x == 0.0 {
	    if code & 1  return -PIO2;
	    if y == 0    return 0;

	    return PIO2;
	}

    if y == 0 {
	    if code & 2 return PI;
	    return 0;
	}

    z := atan(y/x);
    
    if      code == 2  z += PI;
    else if code == 3  z -= PI;

    if (z == 0) && (y < 0) z = -0.0;
    
    return z;
}

atan2 :: inline (y: $T/Integers, x: T) -> T { return xx floor(atan2(cast(float64)y, cast(float64)x) + 0.5); }

sqrt :: inline (x: float) -> float {
    #if CPU == .X64 {
        ret: float;
        #asm SSE { sqrtss r:, [*x]; movss [*ret], r; }
        return ret;
    }
}

sqrt :: inline (x: float64) -> float64 {
    #if CPU == .X64 {
        ret: float64;
        #asm SSE { sqrtsd r:, [*x]; movsd [*ret], r; }
        return ret;
    }
}


sqrt :: (x: $T/Integers) -> T {
    return xx sqrt(cast(float32)x);
}

asin :: inline (y: float32) -> float32 { return cast(float32) asin(cast(float64)y); }
asin :: inline (x: float64) -> float64 {
    sign: float64 = 1;
    a := x;
    if x < 0 {
        sign = -1;
        a = -x;
    }

    if a > 1 return FLOAT64_NAN;

    if a > 0.625 {
        // arcsin(1-x) = pi/2 - sqrt(2x)(1+R(x))
        zz := 1.0 - a;
        p := ((((0h3f68_4fc3_988e_9f08 * zz + 0hbfe2_0792_59f9_290f) * zz + 0h401b_dff5_baf3_3e6a) * zz + 0hc039_91aa_ac01_ab68) * zz + 0h403c_8962_40f3_081d);
        q := ((((                  zz + 0hc035_f2a2_b6bf_5d8c) * zz + 0h4062_6219_af6a_7f42) * zz + 0hc077_fe08_9590_63ee) * zz + 0h4075_6709_b0b6_44be);
        p = zz * p / q;
        zz = sqrt(zz + zz);
        z := PIO4 - zz;
        zz = zz * p - MOREBITS;
        z = z - zz;
        z = z + PIO4;
        return z * sign;
    }

    // arcsin(x) = x + x^3 P(x^2)/Q(x^2)
    if a < 1.0e-8 return x;

    zz := a * a;
    p := (((((0h3f71_6b9b_0bd4_8ad3 * zz + 0hbfe3_4341_333e_5c16) * zz + 0h4015_c74b_178a_2dd9) * zz + 0hc030_4331_de27_907b) * zz + 0h4033_9007_da77_9259) * zz + 0hc020_656c_06ce_afd5);
    q := (((((                  zz + 0hc02d_7b59_0b5e_0eab) * zz + 0h4051_9fc0_25fe_9054) * zz + 0hc062_65bb_6d35_76d7) * zz + 0h4061_7056_84ff_bf9d) * zz + 0hc048_9822_0a36_07ac);
    z := zz * p / q;
    z = a * z + a;
    return z * sign;
}
asin :: inline (x: $T/Integers) -> T { return xx floor(asin(cast(float64)x) + 0.5); }

acos :: inline (y: float32) -> float32 { return cast(float32) acos(cast(float64)y); }
acos :: inline (x: float64) -> float64 {
    if x < -1 || x > 1 return FLOAT64_NAN;

    if x > 0.5 return 2 * asin(sqrt(0.5 - 0.5 * x));

    z := PIO4 - asin(x);
    z = z + MOREBITS;
    z = z + PIO4;
    return z;
}
acos :: inline (x: $T/Integers) -> T { return xx floor(acos(cast(float64)x) + 0.5); }

// TODO:
// - exp — e^x
// - log (ln) — natural logarithm
// - log2 — base-2 logarithm
// - pow — x^y


#scope_file

// reused cephes stuff:

polynomial_eval_coscof5 :: inline (x: float64) -> float64 {
    x2 := x*x;
    x4 := x2*x2;

    return (-1.13585365213876817300E-11*x + 2.08757008419747316778E-9)*x4 +
    (-2.75573141792967388112E-7*x  + 2.48015872888517045348E-5)*x2 +
    -1.38888888888730564116E-3*x  + 4.16666666666665929218E-2;
}

polynomial_eval_sincof5 :: inline (x: float64) -> float64 {
    x2 := x*x;
    x4 := x2*x2;

    return (1.58962301576546568060E-10*x -  2.50507477628578072866E-8)*x4 +
    (2.75573136213857245213E-6*x  -  1.98412698295895385996E-4)*x2 +
    8.33333333332211858878E-3*x  -  1.66666666666666307295E-1;
}

MOREBITS :: 6.123233995736765886130e-17;

INFINITY :: FLOAT64_INFINITY;

PIO2  :: 0h3ff9_21fb_5444_2d18;
PIO4  :: 0h3fe9_21fb_5444_2d18;

/* tan( 3*pi/8 ) */
T3P8 :: 2.41421356237309504880;

FloatInt64 :: union {
    _u64:     u64;
    _s64:     s64;
    _float64: float64;
}

DP1 :: 7.85398125648498535156E-1;
DP2 :: 3.77489470793079817668E-8;
DP3 :: 2.69515142907905952645E-15;
LOSSTH : float64 : 1.073741824e9;
