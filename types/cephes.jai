sin :: inline (x: float32) -> float32 { return cast(float32) sin(cast(float64) x); }    
sin :: inline (x: float64) -> float64 {
    s, _ := inline sincos(x, do_sin = true, do_cos = false);
    return s;
}

cos :: inline (x: float32) -> float32 { return cast(float32) cos(cast(float64) x); } 
cos :: inline (x: float64) -> float64 {
    _, c := inline sincos(x, do_sin = false, do_cos = true);
    return c;
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

atan :: inline (y: float32) -> float32 { return cast(float32) atan(cast(float64)y); } 
atan :: inline (x: float64) -> float64 { // TODO: replace atan
    if x == 0.0 return x;

    if x ==  INFINITY return  PIO2;
    if x == -INFINITY return -PIO2;

    sign: s16 = 1;

    if x < 0 {
	    sign = -1;
	    x = -x;
    }

    /* range reduction */

    flag: s16;  // @Cleanup: Remove flag?

    y: float64 = ---;
    if x > T3P8 {
	    y = PIO2;
	    flag = 1;
	    x = -1/x;
    } else if x <= 0.66 {
	    y = 0;
    } else {
	    y = PIO4;
	    flag = 2;
	    x = (x-1)/(x+1);
    }

    z := x * x;
    z = z * polynomial_eval(z, P, 4) / polynomial_eval_1(z, Q, 5);

    z = x * z + x;

    if flag == 2       z += 0.5 * MOREBITS;
    else if flag == 1  z += MOREBITS;

    y += z;

    if sign < 0  return -y;
    return y;
}

atan2 :: (y: float, x: float) -> float { return cast(float) atan2(cast(float64) y, cast(float64) x); } 
atan2 :: (y: float64, x: float64) -> float64 { // TODO: replace atan2
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

SQRT2 :: 1.41421356237309504880;


sqrt :: inline (x: float) -> float { return cast(float) sqrt(cast(float64) x); }
sqrt :: (x: float64) -> float64 { // TODO: replace sqrt

    if x <= 0 {
	    if x < 0 {
            Basic.log_error("Invalid argument to sqrt: %\n", x);
        }
        
        return 0;
	}
    
    /* separate exponent and significand */
    /* Note, frexp and ldexp are used in order to
     * handle denormal numbers properly.
     */
    z, e := frexp(x);

    w := x;
    
    /* approximate square root of number between 0.5 and 1
     * relative error of approximation = 7.47e-3
     */
    x = 4.173075996388649989089E-1 + 5.9016206709064458299663E-1 * z;

    /* adjust for odd powers of 2 */
    if e & 1  x *= SQRT2;

    // Newton iterations:

    x = ldexp(x, (e >> 1));

    x = 0.5*(x+w/x);
    x = 0.5*(x+w/x);
    x = 0.5*(x+w/x);

    return x;
}


sqrt :: (x: $T/Integers) -> T {
    return xx sqrt(cast(float32)x);
}


#scope_file

polynomial_eval :: (x: float64, coef: [] float64, N: s32) -> float64 {
    ans := coef[0];

    for 1..N  ans = ans * x + coef[it];

    return ans;
}

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

/*							polynomial_eval_1()	*/
/*                                          N
* Evaluate polynomial when coefficient of x  is 1.0.
* Otherwise same as polevl.
*/

polynomial_eval_1 :: (x: float64, coef: [] float64, N: s32) -> float64 {
    ans := x + coef[0];

    for 1..N-1  ans = ans * x + coef[it];

    return ans;
}

MANTISSA_BITS  :: 53;
NEGATIVE_ZERO_64 :: 0h8000_0000_0000_0000;

MOREBITS :: 6.123233995736765886130e-17;

INFINITY :: FLOAT64_INFINITY;

PIO2  :: 0h3ff9_21fb_5444_2d18;
PIO4  :: 0h3fe9_21fb_5444_2d18;
LOG2E :: 0h3ff7_1547_652b_82fe;

/* log2(e) - 1 */
// @Incomplete: Why is this not a hexfloat?
LOG2EA :: 0.44269504088896340736;


/* tan( 3*pi/8 ) */
T3P8 :: 2.41421356237309504880;

P :: float64.[
      0hbfec007fa1f72594,  // -8.750608600031904122785e-1
      0hc03028545b6b807a,  // -1.615753718733365076637e1
      0hc052c08c36880273,  // -7.500855792314704667340e1
      0hc05eb8bf2d05ba25,  // -1.228866684490136173410e2
      0hc0503669fd28ec8e   // -6.485021904942025371773e1
];

Q :: float64.[
      /* 1.000000000000000000000e0, */
      0h4038dbc45b14603c,  // 2.485846490142306297962e1
      0h4064a0dd43b8fa25,  // 1.650270098316988542046e2
      0h407b0e18d2e2be3b,  // 4.328810604912902668951e2
      0h407e563f13b049ea,  // 4.853903996359136964868e2
      0h4068519efbbd62ec   // 1.945506571482613964425e2
];

FloatInt64 :: union {
    _u64:     u64;
    _s64:     s64;
    _float64: float64;
}

DP1 :: 7.85398125648498535156E-1;
DP2 :: 3.77489470793079817668E-8;
DP3 :: 2.69515142907905952645E-15;
LOSSTH : float64 : 1.073741824e9;
