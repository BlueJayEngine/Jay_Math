abs :: inline (x: $T/Numbers) -> T {
    if x < 0 return -x;
    return x;
}

trunc :: inline (x: $T/Numbers) -> T {
    return ifx x>0 then floor(x) else ceil(x);
}

is_nan_is_inf :: inline (x: float64) -> (is_nan: bool, isinf: bool) {
    uf := reinterp(u64, x);

    unbiased_exponent := cast(s32) ((uf >> 52) & 0x7ff);  // @Feature: What we really mean here is "cast to whatever you think is a fast number, that is at least some size... [in this case it needs to be at least 11 bits!]

    if unbiased_exponent == 0x7ff {
        raw_mantissa := uf & 0xf_ffff_ffff_ffff;
        if raw_mantissa == 0 {
            return false, true;
        } else {
            return true, false;
        }
    }

    return false, false;
}

is_finite :: inline (x: float64) -> bool {
    uf := reinterp(u64, x);
    unbiased_exponent := cast(s32) ((uf >> 52) & 0x7ff);  // @Speed: Could remove shift by doing big mask.
    return unbiased_exponent != 0x7ff;
}

is_finite :: inline (x: float32) -> bool {
    uf := reinterp(u32, x);
    unbiased_exponent := (uf >> 23) & 0xff;
    return unbiased_exponent != 0xff;
}

is_nan_is_inf :: inline (x: float32) -> (is_nan: bool, isinf: bool) {
    uf := reinterp(u32, x);
    unbiased_exponent := (uf >> 23) & 0xff;
    if unbiased_exponent == 0xff {
        raw_mantissa := uf & 0x7f_ffff;
        if raw_mantissa == 0 {
            return false, true;
        } else {
            return true, false;
        }
    }

    return false, false;
}

is_nan :: inline (x: $T/Floats) -> bool {
    return is_nan_is_inf(x);
}

is_inf :: inline (x: $T/Floats) -> bool {
    _, _isinf := is_nan_is_inf(x);
    return _isinf;
}

set_bit :: inline (x: $T/Integers, nth: s64) {
    // Bitwise OR with the mask
    return (x | (1 << (nth - 1)));
}

clear_bit :: inline (x: $T/Integers, nth: s64) {
    // Bitwise AND with the mask
    return (x & (~(1 << (nth - 1))));
}


toggle_bit :: inline (x: $T/Integers, nth: s64) {
    // Bitwise XOR with the mask
    return (x ^ (1 << (nth - 1)));
}

signbit :: inline (x: float64) -> u64 {
    return reinterp(u64, x) & 0x8000_0000_0000_0000;
}

signbit :: inline (x: float32) -> u32 {
    return reinterp(u32, x) & 0x8000_0000;
}

frac :: inline (x: $T/Floats) -> T {
    return x - floor(x);
}

lerp :: inline (a: $T/Numbers, b: T, t: float32) -> T {
    return a + (b - a) * t;
}

grid_snap :: inline (loc: $T/Numbers, grid: T) -> T {
    return floor((loc + (grid/ cast(T) 2)) / grid) * grid;
}

inv_sqrt :: inline (x: $T/Numbers) -> T {
    return 1/sqrt(x);
}

// Quake III fast inverse square root
finv_sqrt :: inline (x: $T/Numbers) -> T {  
    y := x;

    i: s64 = reinterp(s64, y);

    i = 0x5f3759df - ( i >> 1 );
    y = reinterp(float32, i);

    y = y * ( 1.5 - ( (x * 0.5) * y * y ) );

    return y;
}

negative_zero :: inline ($T: Type) -> T #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return 0h8000_0000;
    } 
    #if T == float64 {
        return 0h8000_0000_0000_0000;
    }

    return 0; 
}

epsilon :: inline ($T: Type) -> T #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return EPSILON;
    } 
    #if T == float64 {
        return EPSILON_64;
    }

    return 0;
}

inf :: inline ($T: Type) -> T #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return FLOAT32_INFINITY;
    } 
    #if T == float64 {
        return FLOAT64_INFINITY;
    }

    return 0;
}

nan :: inline ($T: Type) -> T #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return FLOAT32_NAN;
    } 
    #if T == float64 {
        return FLOAT64_NAN;
    }

    return 0;
}

get_u_type :: inline ($size: int) -> Type {
    #insert -> string {return sprint("return u%;", size * 8);}
}

get_s_type :: inline ($size: int) -> Type {
    #insert -> string {return sprint("return s%;", size * 8);} 
}

get_float_type :: inline ($size: int) -> Type {
    #insert -> string {return sprint("return float%;", size * 8);} 
}

exp_mask :: inline ($T: Type) -> u64 #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return 0xff;
    } else {
        return 0x7ff;
    }
}

mantissa_bits :: inline ($T: Type) -> s32 #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return 24;
    } else {
        return 53;
    }
}

mantissa_offset :: inline ($T: Type) -> s32 #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return 23;
    } else {
        return 52;
    }
}
ceil :: inline (x: float32) -> float32 {
    #if CPU == .X64 {
        ret: float32; 
        #asm SSE { roundss r:, [*x], 2; movss [*ret], r; }
        return ret;
    } 
}

ceil :: inline (x: float64) -> float64 {
    #if CPU == .X64 {
        ret: float64; 
        #asm SSE { roundsd r:, [*x], 2; movsd [*ret], r; }
        return ret;
    } 
}


floor :: inline (x: float32) -> float32 {
    #if CPU == .X64 {
        ret: float32;
        #asm SSE { roundss r:, [*x], 1; movss [*ret], r; }
        return ret;
    } 
}

floor :: inline (x: float64) -> float64 {
    #if CPU == .X64 {
       ret: float64; 
        #asm SSE { roundsd r:, [*x], 1; movsd [*ret], r; }
        return ret;
    } 
}

infinity :: inline ($T: Type) -> T #modify {
    return T == float32 || T == float64;
}{
    #if T == float32 {
        return FLOAT32_INFINITY;
    } else { 
        return FLOAT64_INFINITY;
    }
}



mod :: inline (x: $T/Floats) -> T { return x - floor(x); }

mod :: inline (x: $T/Floats, $e: T) -> T {
    i :: 1 / e;
    return x - e * floor(x * i);
}

mod :: inline (x: $T/Integers, y: T) -> T  {
    return x - trunc(x / y) * y;
}

sin :: inline (x: float32) -> float32 { return cast(float32) sin(cast(float64) x); }    
sin :: inline (x: float64) -> float64 {
    s, _ := inline sincos(x, do_sin = true, do_cos = false);
    return s;
}
sin :: inline (x: $T/Integers) -> float64 { return sin(cast(float64)x); }

// Scaled integer sin via compile-time LUT.
// Input:  x in [0..scale*4) maps to one full period [0..2π).
// Output: [-scale..scale] as T.
sin :: inline (x: $T/Integers, $scale: s64) -> T {
    table :: #run generate_sin_lut(scale);
    PERIOD :: scale * 4;
    i := ((x % PERIOD) + PERIOD) % PERIOD;  // normalize to [0..PERIOD)
    quadrant := i / scale;
    index    := i % scale;

    if quadrant == {
        case 0; return  cast(T) table[index];
        case 1; return  cast(T) table[scale - index];
        case 2; return -cast(T) table[index];
        case 3; return -cast(T) table[scale - index];
    }
    return 0;
}

cos :: inline (x: float32) -> float32 { return cast(float32) cos(cast(float64) x); } 
cos :: inline (x: float64) -> float64 {
    _, c := inline sincos(x, do_sin = false, do_cos = true);
    return c;
}
cos :: inline (x: $T/Integers) -> float64 { return cos(cast(float64)x); }

// Scaled integer cos via compile-time LUT (phase-shifted sin).
// Input:  x in [0..scale*4) maps to one full period [0..2π).
// Output: [-scale..scale] as T.
cos :: inline (x: $T/Integers, $scale: s64) -> T {
    return sin(x + scale, scale);
}

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
        if is_nan(x) return x, x;
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
tan :: inline (x: $T/Integers) -> float64 { return tan(cast(float64)x); }

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
atan :: inline (x: $T/Integers) -> float64 { return atan(cast(float64)x); }

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
    if is_nan(x) return x;
    if is_nan(y) return y;

    if y == 0 {  // 0.0 compares as equal to -0.0, so .. yeah.
	    if signbit(y) {
		    if x > 0  return y;
		    if x < 0  return -PI64;

			if signbit(x) return -PI64;
			return y;
		} else {
            // y is +0 if we get here.
		    if x == 0 {
			    if signbit(x) return PI64;
			    return 0;
			}

            if x > 0   return 0;
            return PI64;
		}
	}
    
    if x == 0 {
        if y > 0 return PIO2;
        return -PIO2;
	}
    
    if x == INFINITY {
	    if y == INFINITY  return 0.25 * PI64;
	    if y == -INFINITY return -0.25 * PI64;
	    if y < 0  	      return -0.0;

	    return 0;
	}
    
    if x == -INFINITY {
	    if y == INFINITY   return 0.75 * PI64;
	    if y <= -INFINITY  return -0.75 * PI64;
	    if y >= 0          return PI64;
        
	    return -PI64;
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
	    if code & 2 return PI64;
	    return 0;
	}

    z := atan(y/x);
    
    if      code == 2  z += PI64;
    else if code == 3  z -= PI64;

    if (z == 0) && (y < 0) z = -0.0;
    
    return z;
}

atan2 :: inline (y: $T/Integers, x: T) -> float64 { return atan2(cast(float64)y, cast(float64)x); }

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
asin :: inline (x: $T/Integers) -> float64 { return asin(cast(float64)x); }

acos :: inline (y: float32) -> float32 { return cast(float32) acos(cast(float64)y); }
acos :: inline (x: float64) -> float64 {
    if x < -1 || x > 1 return FLOAT64_NAN;

    if x > 0.5 return 2 * asin(sqrt(0.5 - 0.5 * x));

    z := PIO4 - asin(x);
    z = z + MOREBITS;
    z = z + PIO4;
    return z;
}
acos :: inline (x: $T/Integers) -> float64 { return acos(cast(float64)x); }

exp :: inline (y: float32) -> float32 { return cast(float32) exp(cast(float64)y); }
exp :: inline (x: float64) -> float64 {
    if is_nan(x) return x;
    if x >  170.0 return FLOAT64_INFINITY;
    if x < -170.0 return 0;

    // Express e^x = e^g * 2^n  via  x = g + n*ln(2)
    // n = round(x * log2(e))
    px := floor(0h3ff7_1547_652b_82fe * x + 0.5);
    n := cast(s32) px;

    // Cohn-Waite reduction: x -= n * ln(2) in extended precision
    x -= px * 0h3fe6_2e40_0000_0000;  // C1 (high bits of ln2)
    x -= px * 0h3eb7_f7d1_cf79_abca;  // C2 (low bits of ln2)

    // Pade approximation: e^x = 1 + 2x P(x^2) / (Q(x^2) - P(x^2))
    x2 := x * x;

    // P: degree 2 — inlined Horner
    px = ((0h3f20_89cd_d5e4_4be8 * x2 + 0h3f9f_06d1_0cca_2c7e) * x2 + 0h3ff0_0000_0000_0000);
    px = x * px;

    // Q: degree 3 — inlined Horner
    qx := (((0h3ec9_2eb6_bc36_5fa0 * x2 + 0h3f64_ae39_b508_b6c0) * x2 + 0h3fcd_1709_9887_e074) * x2 + 0h4000_0000_0000_0000);

    x = px / (qx - px);
    x = 1 + 2 * x;

    // Multiply by 2^n using two-step scaling to handle the full exponent range
    // without overflow in intermediates. Each step constructs a power-of-2 double
    // by writing the biased exponent directly into the IEEE-754 bit pattern.
    n1 := cast(s64)(n / 2);
    n2 := cast(s64) n - n1;
    pow1: FloatInt64;
    pow1._u64 = cast(u64)(1023 + n1) << 52;
    pow2: FloatInt64;
    pow2._u64 = cast(u64)(1023 + n2) << 52;
    return x * pow1._float64 * pow2._float64;
}
exp :: inline (x: $T/Integers) -> float64 { return exp(cast(float64)x); }

log :: inline (y: float32) -> float32 { return cast(float32) log(cast(float64)y); }
log :: inline (x: float64) -> float64 {
    if is_nan(x) return x;
    if x == FLOAT64_INFINITY return x;
    if x <= 0 {
        if x == 0 return -FLOAT64_INFINITY;
        return FLOAT64_NAN;
    }

    // Extract exponent and mantissa via bit manipulation (replaces frexp)
    fi: FloatInt64;
    fi._float64 = x;
    e := cast(s32)((fi._u64 >> 52) & 0x7ff) - 1022;
    fi._u64 = (fi._u64 & 0x800f_ffff_ffff_ffff) | 0x3fe0_0000_0000_0000;
    x = fi._float64;

    SQRTH :: 0.70710678118654752440;

    if (e > 2) || (e < -2) {
        // log(x) = z + z^3 R(z^2)/S(z^2), where z = 2(x-1)/(x+1)
        y, z: float64 = ---;
        if x < SQRTH {
            e -= 1;
            z = x - 0.5;
            y = 0.5 * z + 0.5;
        } else {
            z = x - 0.5;
            z -= 0.5;
            y = 0.5 * x + 0.5;
        }

        x = z / y;
        z = x * x;

        // R: degree 2, S: degree 3 (leading coeff 1) — inlined Horner
        r := ((0hbfe9_443d_dc6c_0e84 * z + 0h4030_62fc_7302_7b6b) * z + 0hc050_0906_1122_2a20);
        s := (((              z + 0hc041_d60d_43ec_6d0a) * z + 0h4073_8180_112a_e40e) * z + 0hc088_0d89_19b3_3f3b);
        z = x * (z * r / s);

        fe := cast(float64) e;
        z -= fe * 2.121944400546905827679e-4;
        z += x;
        z += fe * 0.693359375;
        return z;
    }

    // log(1+x) = x - 0.5x^2 + x^3 P(x)/Q(x)
    if x < SQRTH {
        e -= 1;
        x = x * 2.0 - 1;
    } else {
        x -= 1;
    }

    z := x * x;

    // P: degree 5, Q: degree 5 (leading coeff 1) — inlined Horner
    p := (((((0h3f1a_b4c2_93c3_1bb0 * x + 0h3fdf_d6f5_3f56_52f2) * x + 0h4012_d2ba_ed92_6911) * x + 0h402c_ff72_c63e_eb2e) * x + 0h4031_efd6_924b_c84d) * x + 0h401e_d563_7d7e_dcf8);
    q := (((((              x + 0h4026_9320_ae97_ef8e) * x + 0h4046_9d2c_4e19_c033) * x + 0h4054_bf33_a326_bdbd) * x + 0h4051_c9e2_eb5e_ae21) * x + 0h4037_200a_9e1f_25b2);
    y := x * (z * p / q);

    fe := cast(float64) e;
    if e  y -= fe * 2.121944400546905827679e-4;
    y -= z * 0.5;
    z = x + y;
    if e  z += fe * 0.693359375;

    return z;
}
log :: inline (x: $T/Integers) -> float64 { return log(cast(float64)x); }

log2 :: inline (y: float32) -> float32 { return cast(float32) log2(cast(float64)y); }
log2 :: inline (x: float64) -> float64 {
    return log(x) * LOG2E;
}
log2 :: inline (x: $T/Integers) -> float64 { return log2(cast(float64)x); }

pow :: inline (y: float32, p: float32) -> float32 { return cast(float32) pow(cast(float64)y, cast(float64)p); }
pow :: inline (x: float64, y: float64) -> float64 {
    if y == 0 return 1;
    if is_nan(x) return x;
    if is_nan(y) return y;
    if y == 1 return x;
    if x == 1 return 1;

    if !is_finite(y) && (x == 1 || x == -1) return FLOAT64_NAN;

    // Determine if y is an integer and if it's odd
    w := floor(y);
    y_is_integer := (w == y);
    y_is_odd := y_is_integer && (floor(0.5 * abs(w)) != 0.5 * abs(w));

    MAXNUM :: FLOAT64_MAX;

    if y >= MAXNUM {
        if x > 1 return FLOAT64_INFINITY;
        if x > 0 && x < 1 return 0;
        if x < -1 return FLOAT64_INFINITY;
        if x > -1 && x < 0 return 0;
    }

    if y <= -MAXNUM {
        if x > 1 return 0;
        if x > 0 && x < 1 return FLOAT64_INFINITY;
        if x < -1 return 0;
        if x > -1 && x < 0 return FLOAT64_INFINITY;
    }

    if x >= MAXNUM {
        if y > 0 return FLOAT64_INFINITY;
        return 0;
    }

    if x <= -MAXNUM {
        if y > 0 return ifx y_is_odd then -FLOAT64_INFINITY else FLOAT64_INFINITY;
        if y < 0 return ifx y_is_odd then -0.0 else 0.0;
    }

    nflg := false;  // true if negative x raised to integer power

    if x <= 0 {
        if x == 0 {
            if y < 0 {
                if signbit(x) && y_is_odd return -FLOAT64_INFINITY;
                return FLOAT64_INFINITY;
            }
            if y > 0 return ifx signbit(x) && y_is_odd then -0.0 else 0.0;
            return 1;
        }

        if !y_is_integer return FLOAT64_NAN;
        nflg = true;
    }

    if nflg  x = abs(x);

    z := exp(y * log(x));

    if nflg && y_is_odd {
        if z == 0 return -0.0;
        z = -z;
    }

    return z;
}
pow :: inline (x: $T/Integers, y: T) -> float64 { return pow(cast(float64)x, cast(float64)y); }


#scope_module

LOG2E :: 0h3ff7_1547_652b_82fe;

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

generate_sin_lut :: ($scale: s64) -> [scale + 1]s64 {
    table: [scale + 1]s64;
    for i: 0..scale {
        angle := cast(float64)i / cast(float64)scale * (PI64 / 2.0);
        table[i] = cast(s64)(sin(angle) * cast(float64)scale + 0.5);
    }
    return table;
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
