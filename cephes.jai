/*
Most of the code in this file comes from cephes:

Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1995, 2000 by Stephen L. Moshier
*/



/*							ceil()
 *							floor()
 *							frexp()
 *							ldexp()
 *							signbit()
 *							isnan()
 *							isfinite()
 *
 *	Floating point numeric utilities
 *
 *
 * DESCRIPTION:
 *
 * All four routines return a double precision floating point
 * result.
 *
 * floor() returns the largest integer less than or equal to x.
 * It truncates toward minus infinity.
 *
 * ceil() returns the smallest integer greater than or equal
 * to x.  It truncates toward plus infinity.
 *
 * frexp() extracts the exponent from x.  It returns an integer
 * power of two to expnt and the significand between 0.5 and 1
 * to y.  Thus  x = y * 2**expn.
 *
 * ldexp() multiplies x by 2**n.
 *
 * signbit(x) returns 1 if the sign bit of x is 1, else 0.
 *
 * These functions are part of the standard C run time library
 * for many but not all C compilers.  The ones supplied are
 * written in C for either DEC or IEEE arithmetic.  They should
 * be used only if your compiler library does not already have
 * them.
 *
 * The IEEE versions assume that denormal numbers are implemented
 * in the arithmetic.  Some modifications will be required if
 * the arithmetic has abrupt rather than gradual underflow.
 */



// IMPORTANT:
// IMPORTANT:
// IMPORTANT:
// The cephes web site gave us permission to use the code, but
// we really should email the dude and get real serious permission
// before shipping this.   -jblow, 28 August 2018
// 'floor' was VERY HEAVILY modified; it doesn't even work the same
// basic way any more, but I did use the cephes routine as a starting
// point for the modifications.

ceil :: (x: float64) -> float64 {
    if !is_finite(x)     return x;

    y := floor(x);
    if y < x  y += 1;

    if (y == 0) && (x < 0)  return NEGATIVE_ZERO_64;

    return y;
}

// Someone in chat asked whether we should just implement floor
// by casting to int and back ... obviously we would need to check
// the exponent and return x if it's too high to fit. That might
// be simpler than this implementation, but it's still more of
// a hack than just using an intrinsic, so maybe we should just
// get our intrinsics figured out.
floor :: (x: float64) -> float64 {
    if !is_finite(x)     return x;
    if x == 0       return x;
    
    // Find the exponent (power of 2).
    uf := << cast(*u64)*x;
    e  := (cast(s32) ((uf >> 52) & 0x7ff)) - 1023;

    if e < 0 {
	    if x < 0   return -1;
        else       return 0;
	}

    e = (MANTISSA_BITS - 1) - e;
    
    mask : u64 = 0xffff_ffff_ffff_ffff;
    mask = mask << e;
    uf &= mask;

    result := << cast(*float64)*uf;
    if (x < 0) && (result != x) {  // This seems expensive, can we just determine that we did not make a change?
	    result -= 1.0;
    }
    
    return result;
}

ceil :: (f: float) -> float {
    return cast(float) ceil(cast(float64) f);
}

floor :: (f: float) -> float {
    return cast(float) floor(cast(float64) f);
}


/*							sin.c
 *
 *	Circular sine
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, sin();
 *
 * y = sin( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Range reduction is into intervals of pi/4.  The reduction
 * error is nearly eliminated by contriving an extended precision
 * modular arithmetic.
 *
 * Two polynomial approximating functions are employed.
 * Between 0 and pi/4 the sine is approximated by
 *      x  +  x**3 P(x**2).
 * Between pi/4 and pi/2 the cosine is represented as
 *      1  -  x**2 Q(x**2).
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain      # trials      peak         rms
 *    DEC       0, 10       150000       3.0e-17     7.8e-18
 *    IEEE -1.07e9,+1.07e9  130000       2.1e-16     5.4e-17
 * 
 * ERROR MESSAGES:
 *
 *   message           condition        value returned
 * sin total loss   x > 1.073741824e9      0.0
 *
 * Partial loss of accuracy begins to occur at x = 2**30
 * = 1.074e9.  The loss is not gradual, but jumps suddenly to
 * about 1 part in 10e7.  Results may be meaningless for
 * x > 2**49 = 5.6e14.  The routine as implemented flags a
 * TLOSS error for x > 2**30 and returns 0.0.
 */

/*							cos.c
 *
 *	Circular cosine
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, cos();
 *
 * y = cos( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Range reduction is into intervals of pi/4.  The reduction
 * error is nearly eliminated by contriving an extended precision
 * modular arithmetic.
 *
 * Two polynomial approximating functions are employed.
 * Between 0 and pi/4 the cosine is approximated by
 *      1  -  x**2 Q(x**2).
 * Between pi/4 and pi/2 the sine is represented as
 *      x  +  x**3 P(x**2).
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain      # trials      peak         rms
 *    IEEE -1.07e9,+1.07e9  130000       2.1e-16     5.4e-17
 *    DEC        0,+1.07e9   17000       3.0e-17     7.2e-18
 */

/*							sin.c	*/

/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1985, 1995, 2000 by Stephen L. Moshier
*/
/*
sincof :: float64.[
           1.58962301576546568060E-10,
           -2.50507477628578072866E-8,
           2.75573136213857245213E-6,
           -1.98412698295895385996E-4,
           8.33333333332211858878E-3,
           -1.66666666666666307295E-1,
          ];
coscof :: float64.[
           -1.13585365213876817300E-11,
           2.08757008419747316778E-9,
           -2.75573141792967388112E-7,
           2.48015872888517045348E-5,
           -1.38888888888730564116E-3,
           4.16666666666665929218E-2,
          ];
*/
DP1 :: 7.85398125648498535156E-1;
DP2 :: 3.77489470793079817668E-8;
DP3 :: 2.69515142907905952645E-15;
LOSSTH : float64 : 1.073741824e9; 

sin :: (x: float32) -> float32 { return cast(float32) sin(cast(float64) x); }
cos :: (x: float32) -> float32 { return cast(float32) cos(cast(float64) x); }



//
// We worked on this code a bunch to make it faster than base Cephes, and we did --
// by a more-than-2x speedup. However, now we are in a place where we are still
// slower than the Windows libc version, and it looks like the bottleneck now
// is just how much math we are doing. So maybe it would be fruitful to look
// at a different algorithm at this point, for something that approximates
// with fewer multiply-adds in some way.
//
// Alternatively, it seems we are still spending a fair chunk of CPU power just
// to do an fmod on x, essentially. So, if we had a faster way of doing that,
// we would be pretty good. Note that even though we have this variable j that
// is limited to a small positive number, for the math shown here, y has to stay big
// because x is big. That seems like an opportunity to fix something.
//
//    -jblow, 30 June 2020
//

sin_or_cos :: (x: float64, $IS_SIN: bool) -> float64 {
    #if IS_SIN  if x == 0 return x;

    sf := << cast(*s64)*x;
    exponent := cast(s32) ((sf >> 52) & 0x7ff);
    if exponent == 0x7ff {  // It is nan or inf. Replace with an intrinsic.
        if isnan(x) return x;  // @Cleanup: Redundancies...

        // It's not nan, so it's inf.

        // :MathError
        // @Incomplete: Do we signal errors in any other way? Programmer-only error log?
	    // mtherr( "sin", DOMAIN );
	    return FLOAT64_NAN;
    }

    /* make argument positive but save the sign */
    negate : s64 = 0;
    {
        //
        // The code here was:
        //
        //   if x < 0 {   // We could do a branch-free negate here if we really wanted to, like we do on returning, but ... is it worth it?
	    //       x = -x;
	    //       #if IS_SIN  negate = 1;
	    //   }
        //
        // But we wanted to do it in a branch-free way, so, you see the below:
        //
        flint: FloatInt64 = ---;
        flint._float64 = x;
        #if IS_SIN  negate = xx(flint._u64 >> 63);
        flint._u64 &= 0x7fff_ffff_ffff_ffff;
        x = flint._float64;
    }
    

    if x > LOSSTH {
        // :MathError
	    // mtherr( "sin", TLOSS );
	    return 0;
	}


    // We know x is not negative.
    // So taking the floor is the same as casting to int (casts round toward 0,
    // but when you're always positive, that is the floor).
    // Here we cast to s64, which will not preserve input angles greater than
    // 2**64, but, we don't have enough precision up there to sensibly perform
    // trig anyway -- and this algorithm already bailed out if the input angle
    // is higher than LOSSTH, which is only about 1 billion, way less than
    // 2**64.
    j := cast(s64)(x/PIO4);

    /* map zeros to origin */
    j += (j & 1);

    y := cast(float64) j;
    
    j = j & 0b111; /* octant modulo 360 degrees */  // But, the low bit actually cannot be 1, since we made j even above, so we could have masked by 0b110.

    // The code below used to be:
    //
    // if j > 3 {
	//    negate ^= 1;
	//    j -= 4;
    // }
    //
    // But we wanted to get rid of the 'if' statement, for performance, because
    // the branch predictor might have problems with it in many use cases.
    //
    // If j > 3, then j & 4, and furthermore, no higher bits are set on j.
    // So if we want to toggle 'negate' iff j > 3, we xor it with (j >> 2).
    // j -= 4 is the same as masking j & 2.
    //
    
    /* reflect in x axis */

    negate ^= (j >> 2);
    j = j & 2;  // Semi-redundant with & 6 above?!?
    
    // When we get to this point, j can only be 0 or 2.
    // Each increment of j represents 45 degrees, so 0 and 2 are one quadrant apart.
    // sin and cos want the same behavior, offset by one quadrant.
    #if !IS_SIN {
        // Here we wanted to do:
        //     if j  negate ^= 1;
        // But j can only be 2 or 0, so we toggle by j >> 1.
        negate ^= (j >> 1);
        j = xx !j;   // Should get optimized out alongside the if below.
    }
    
    /* Extended precision modular arithmetic */

    z := ((x - y * DP1) - y * DP2) - y * DP3;
    zz := z * z;
    
    r: float64 = ---;
    if j  r = 1.0 - zz*.5 + zz * zz * polynomial_eval_coscof5(zz);
	else  r = z  +  z * (zz * polynomial_eval_sincof5(zz));

    //
    // The code here to return the value was:
    //
    //    if negate  return -r;
    //    return r;
    //
    // But we want to return in a branch-free way, so, we do the thing
    // where we toggle the sign bit of the result if negate is 1.
    //
    flint: FloatInt64 = ---;
    flint._float64 = r;
    flint._u64 ^= xx,no_check(negate << 63);
    return flint._float64;
}

sin :: (x: float64) -> float64 {
    return inline sin_or_cos(x, true);
}

cos :: (x: float64) -> float64 {
    return inline sin_or_cos(x, false);
}



/*							atan.c
 *
 *	Inverse circular tangent
 *      (arctangent)
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, atan();
 *
 * y = atan( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns radian angle between -pi/2 and +pi/2 whose tangent
 * is x.
 *
 * Range reduction is from three intervals into the interval
 * from zero to 0.66.  The approximant uses a rational
 * function of degree 4/5 of the form x + x**3 P(x)/Q(x).
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       -10, 10     50000       2.4e-17     8.3e-18
 *    IEEE      -10, 10      10^6       1.8e-16     5.0e-17
 *
 */

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

atan :: inline (y: float32) -> float32 { return cast(float32) atan(cast(float64)y); }


/*							atan2()
 *
 *	Quadrant correct inverse circular tangent
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, z, atan2();
 *
 * z = atan2( y, x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns radian angle whose tangent is y/x.
 * Range -PI < z <= +PI.
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      -10, 10      10^6       2.5e-16     6.9e-17
 * See atan.c.
 *
 */

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

#scope_file 


/*							polevl.c
 *							p1evl.c
 *
 *	Evaluate polynomial
 *
 *
 *
 * SYNOPSIS:
 *
 * int N;
 * double x, y, coef[N+1], polevl[];
 *
 * y = polevl( x, coef, N );
 *
 *
 *
 * DESCRIPTION:
 *
 * Evaluates polynomial of degree N:
 *
 *                     2          N
 * y  =  C  + C x + C x  +...+ C x
 *        0    1     2          N
 *
 * Coefficients are stored in reverse order:
 *
 * coef[0] = C  , ..., coef[N] = C  .
 *            N                   0
 *
 *  The function p1evl() assumes that coef[N] = 1.0 and is
 * omitted from the array.  Its calling arguments are
 * otherwise the same as polevl().
 *
 *
 * SPEED:
 *
 * In the interest of speed, there are no checks for out
 * of bounds arithmetic.  This routine is used by most of
 * the functions in the library.  Depending on available
 * equipment features, the user may wish to rewrite the
 * program in microcode or assembly language.
 *
 */

/*
Cephes Math Library Release 2.1:  December, 1988
Copyright 1984, 1987, 1988 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/


// Speed idea! We can mark polynomial_* as inline, and also make N
// a compile-time constant, and have some nice inlined guaranteed
// loop unroll action!

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

signbit :: inline (x: float64) -> u64 {
    value: FloatInt64 = ---;
    value._float64 = x;
    return value._u64 & 0x8000_0000_0000_0000;
}





/*
 *	Square root
 *
 * SYNOPSIS:
 *
 * double x, y, sqrt();
 *
 * y = sqrt( x );
 *
 *
 * DESCRIPTION:
 *
 * Returns the square root of x.
 *
 * Range reduction involves isolating the power of two of the
 * argument and using a polynomial approximation to obtain
 * a rough value for the square root.  Then Heron's iteration
 * is used three times to converge to an accurate value.
 *
 *
 * ACCURACY:
 *
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       0, 10       60000       2.1e-17     7.9e-18
 *    IEEE      0,1.7e308   30000       1.7e-16     6.3e-17
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * sqrt domain        x < 0            0.0
 *
 */

/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1988, 2000 by Stephen L. Moshier
*/

#scope_export
frexp :: (x: float64) -> (result: float64, pow2: s32) {
    union {
	    _float64: float64;
        _u64:     u64;
    }

    _float64 = x;
    i  :=  cast(s32)(_u64 >> 52);
    i &= 0x7ff;
    if i == 0 {
        // Handle denormal numbers.
        // Could static-if this, as the cephes code does...?

        k: s32;
        while 1 {
	        _float64 *= 2.0;
	        i -= 1;
	        k := cast(s32)(_u64 >> 52) & 0x7ff;

            if k != 0  break;
	    }

        i = i + k;
    }

    i -= 0x3fe;
    _u64 &= 0x800f_ffff_ffff_ffff;  // @Speed: Could just AND 16 bits depending on endian, as C cephes does? We just need to have a global that tells us endian, which we currently do not...
    _u64 |= 0x3fe0_0000_0000_0000;

    return _float64, i;
}

ldexp :: (x: float64, pw2: s32) -> float64 {
    union {
        _float64: float64;
        _u64:     u64;
    };

    _float64 = x;

    e: s32;
    while 1 {
        e = cast(s32)((_u64 & 0x7ff0_0000_0000_0000) >> 52);
        if e != 0  break;

	    if _float64 == 0  return 0;

        /* Input is denormal. */
	    if pw2 > 0  {
		    _float64 *= 2;
		    pw2 -= 1;
		}
        
	    if pw2 < 0 {
		    if pw2 < -53  return 0;
		    _float64 *= .5;
		    pw2 += 1;
		}
        
	    if pw2 == 0  return _float64;
	}

    e += pw2;

    // Handle overflow.
    MEXP :: 0x7ff;
    MAXNUM :: 0h7fef_ffff_ffff_ffff;
    if e >= MEXP  return 2*MAXNUM;
    
    // Handle denormalized results.
    if e < 1 {
        DENORMAL :: 1;
        #if DENORMAL {
	        if e < -53  return 0;

	        _u64 &= 0x800f_ffff_ffff_ffff;
	        _u64 |= 0x0010_0000_0000_0000;
	        /* For denormals, significant bits may be lost even
         	   when dividing by 2.  Construct 2^-(1-e) so the result
         	   is obtained with only one multiplication.  */

	        _float64 *= ldexp(1.0, e-1);
	        return _float64;
        } else {
	        return 0;
        }
	} else {
        _u64 &= 0x800f_ffff_ffff_ffff;
	    _u64 |= (cast(u64)(e & 0x7ff)) << 52;

        return _float64;
	}
}


SQRT2 :: 1.41421356237309504880;

sqrt :: (x: float64) -> float64 {
    if x <= 0 {
	    if x < 0 log("Invalid argument to sqrt: %\n", x, flags=Log_Flags.ERROR);
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



/*
 *
 *	Natural logarithm
 *
 *
 * SYNOPSIS:
 *
 * double x, y, log();
 *
 * y = log( x );
 *
 *
 * DESCRIPTION:
 *
 * Returns the base e (2.718...) logarithm of x.
 *
 * The argument is separated into its exponent and fractional
 * parts.  If the exponent is between -1 and +1, the logarithm
 * of the fraction is approximated by
 *
 *     log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x).
 *
 * Otherwise, setting  z = 2(x-1)/x+1),
 * 
 *     log(x) = z + z**3 P(z)/Q(z).
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0.5, 2.0    150000      1.44e-16    5.06e-17
 *    IEEE      +-MAXNUM    30000       1.20e-16    4.78e-17
 *    DEC       0, 10       170000      1.8e-17     6.3e-18
 *
 * In the tests over the interval [+-MAXNUM], the logarithms
 * of the random arguments were uniformly distributed over
 * [0, MAXLOG].
 *
 * ERROR MESSAGES:
 *
 * log singularity:  x = 0; returns -INFINITY
 * log domain:       x < 0; returns NAN
 */

/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1995, 2000 by Stephen L. Moshier
*/

/* Coefficients for log(1+x) = x - x**2/2 + x**3 P(x)/Q(x)
 * 1/sqrt(2) <= x < sqrt(2)
 */

SQRTH :: 0.70710678118654752440;

log :: (x: float64) -> float64 {
    // @Feature: The log2 function in cephes is mostly copypasta
    // from log10, with a few lines of code difference; we could
    // make a log_10_or_2 function with a bakeable parameter
    // that switches between.

    if isnan(x) return x;
    if x ==  INFINITY return x;
    if x == -INFINITY return x;
    
    /* Test for domain */
    if x <= 0 {
        log("Invalid argument to log(): %\n", x);
	    if x == 0 return -INFINITY;
        else      return FLOAT64_NAN;
	}

    /* separate mantissa from exponent */
    e: s32;
    x, e = frexp(x);

    /* logarithm using log(x) = z + z**3 P(z)/Q(z),
     * where z = 2(x-1)/x+1)
     */

    if (e > 2) || (e < -2) {
        y, z: float64 = ---;
        
        if x < SQRTH  {
	        // 2( 2x-1 )/( 2x+1 )
	        e -= 1;
	        z = x - 0.5;
	        y = 0.5 * z + 0.5;
	    } else {
            //  2 (x-1)/(x+1) 
	        z = x - 0.5;
	        z -= 0.5;
	        y = 0.5 * x  + 0.5;
	    }


        x = z / y;


        /* Coefficients for log(x) = z + z**3 P(z)/Q(z),
         * where z = 2(x-1)/(x+1)
         * 1/sqrt(2) <= x < sqrt(2)
         */

        R :: float64.[
            0hbfe9_443d_dc6c_0e84,
            0h4030_62fc_7302_7b6b,
            0hc050_0906_1122_2a20,
        ];

        S :: float64.[
            1,
            0hc041_d60d_43ec_6d0a,
            0h4073_8180_112a_e40e,
            0hc088_0d89_19b3_3f3b
        ];

        /* rational form */
        z = x*x;
        z = x * (z * polynomial(z, R) / polynomial(z, S));
        y = cast(float64)e; // wtf... why not just factor e into the next line?
        z = z - y * 2.121944400546905827679e-4;
        z = z + x;
        z = z + e * 0.693359375;

        return z;
    }

    /* logarithm using log(1+x) = x - .5x**2 + x**3 P(x)/Q(x) */

    if x < SQRTH {
	    e -= 1;
	    x = ldexp(x, 1) - 1; /*  2x - 1  */
	} else {
	    x = x - 1;
	}

    
    P :: float64.[
        0h3f1a_b4c2_93c3_1bb0,
        0h3fdf_d6f5_3f56_52f2,
        0h4012_d2ba_ed92_6911,
        0h402c_ff72_c63e_eb2e,
        0h4031_efd6_924b_c84d,
        0h401e_d563_7d7e_dcf8
    ];

    Q :: float64.[
        1,
        0h4026_9320_ae97_ef8e,
        0h4046_9d2c_4e19_c033,
        0h4054_bf33_a326_bdbd,
        0h4051_c9e2_eb5e_ae21,
        0h4037_200a_9e1f_25b2
    ];

    /* rational form */
    z := x*x;
    y := x * (z * polynomial(x, P) / polynomial(x, Q));

    if e  y = y - e * 2.121944400546905827679e-4;
    y = y - ldexp(z, -1);   /*  y - 0.5 * z  */
    z = x + y;
    if e  z = z + e * 0.693359375;

    return z;
}




/*							tan.c
 *
 *	Circular tangent
 *
 *
 * DESCRIPTION:
 *
 * Returns the circular tangent of the radian argument x.
 *
 * Range reduction is modulo pi/4.  A rational function
 *       x + x**3 P(x**2)/Q(x**2)
 * is employed in the basic interval [0, pi/4].
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC      +-1.07e9      44000      4.1e-17     1.0e-17
 *    IEEE     +-1.07e9      30000      2.9e-16     8.1e-17
 *
 * ERROR MESSAGES:
 *
 *   message         condition          value returned
 * tan total loss   x > 1.073741824e9     0.0
 *
 */
/*							cot.c
 *
 *	Circular cotangent
 *
 *
 * DESCRIPTION:
 *
 * Returns the circular cotangent of the radian argument x.
 *
 * Range reduction is modulo pi/4.  A rational function
 *       x + x**3 P(x**2)/Q(x**2)
 * is employed in the basic interval [0, pi/4].
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE     +-1.07e9      30000      2.9e-16     8.2e-17
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition          value returned
 * cot total loss   x > 1.073741824e9       0.0
 * cot singularity  x = 0                  INFINITY
 *
 */


tan :: (x: float64) -> float64 {
    if x == 0  return x;

    if isnan(x) return x;
    if !is_finite(x) {
        log("Invalid argument to tan(): %\n", x);
        return FLOAT64_NAN;
    }

    return tancot(x, false);
}

cot :: (x: float64) -> float64 {
    if x == 0 {
	    log("Invalid argument to cot(): %\n", x);
	    return FLOAT64_INFINITY;
	}
    
    return tancot(x, true);
}


#scope_file

TANCOT_P :: float64.[
    0hc0c9_92d8_d24f_3f38,
    0h4131_99ec_a5fc_9ddd,
    0hc171_1fea_d329_9176
];

TANCOT_Q :: float64.[
    1,
    0h40ca_b8a5_eeb3_6572,
    0hc134_27bc_582a_bc96,
    0h4177_d98f_c2ea_d8ef,
    0hc189_afe0_3cbe_5a31
];

tancot :: (input_x: float64, $is_cotangent: bool) -> float64 {

    lossth : float64 : 1.073741824e9;

    // make argument positive but save the sign.

    x: float64 = ---;
    sign: float64 = ---;
    if input_x < 0  {
	    x = -input_x;
	    sign = -1;
	} else {
	    x = input_x;
	    sign = 1;
	}

    if x > lossth {
        NAME :: #ifx is_cotangent then "cot" else "tan";  
        log("Argument to %() is too high: %\n", NAME, x);
        return 0;
    }

    /* compute x mod PIO4 */
    y := floor( x/PIO4 );

    /* strip high bits of integer part */
    z := ldexp( y, -3 );
    z = floor(z);		/* integer part of y/8 */
    z = y - ldexp( z, 3 );  /* y - 16 * (y/16) */

    /* integer and fractional part modulo one octant */
    j := cast(s32) z;

    /* map zeros and singularities to origin */
    if j & 1 {
	    j += 1;
	    y += 1.0;
	}

    DP1 :: 0h3fe9_21fb_4000_0000;
    DP2 :: 0h3e64_442d_0000_0000;
    DP3 :: 0h3ce8_4698_98cc_5170;

    z = ((x - y * DP1) - y * DP2) - y * DP3;

    zz := z * z;

    if zz > 1.0e-14 {
	    y = z + z * (zz * polynomial(zz, TANCOT_P)/polynomial(zz, TANCOT_Q));
    } else {
	    y = z;
    }
	
    if j & 2 {
	    if is_cotangent y = -y;
	    else y = -1/y;
	} else {
	    if is_cotangent y = 1/y;
	}

    return y * sign;
}

/*							asin.c
 *
 *	Inverse circular sine
 *
 *
 * DESCRIPTION:
 *
 * Returns radian angle between -pi/2 and +pi/2 whose sine is x.
 *
 * A rational function of the form x + x**3 P(x**2)/Q(x**2)
 * is used for |x| in the interval [0, 0.5].  If |x| > 0.5 it is
 * transformed by the identity
 *
 *    asin(x) = pi/2 - 2 asin( sqrt( (1-x)/2 ) ).
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC      -1, 1        40000       2.6e-17     7.1e-18
 *    IEEE     -1, 1        10^6        1.9e-16     5.4e-17
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * asin domain        |x| > 1           NAN
 *
 */
/*							acos()
 *
 *	Inverse circular cosine
 *
 *
 * DESCRIPTION:
 *
 * Returns radian angle between 0 and pi whose cosine
 * is x.
 *
 * Analytically, acos(x) = pi/2 - asin(x).  However if |x| is
 * near 1, there is cancellation error in subtracting asin(x)
 * from pi/2.  Hence if x < -0.5,
 *
 *    acos(x) =	 pi - 2.0 * asin( sqrt((1+x)/2) );
 *
 * or if x > +0.5,
 *
 *    acos(x) =	 2.0 * asin(  sqrt((1-x)/2) ).
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       -1, 1       50000       3.3e-17     8.2e-18
 *    IEEE      -1, 1       10^6        2.2e-16     6.5e-17
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * asin domain        |x| > 1           NAN
 */

#scope_export
asin :: (x: float64) -> float64 {
    /* pi/2 = PIO2 + MOREBITS.  */
    MOREBITS :: 6.123233995736765886130E-17;

    sign: float64 = ---;
    a:    float64 = ---;
    if x > 0 {
	    sign = 1;
	    a = x;
	} else {
	    sign = -1;
	    a = -x;
	}

    if a > 1 {
        if (a > ASIN_AND_ACOS_ERROR_REPORTING_LIMIT) {
	        log_error("Argument to asin() is out of range: %\n", x);
	        return FLOAT64_NAN;
        }

        // Allow people to call us with a little bit of slop, like a dot product result.
        a = 1;
	}

    if a > 0.625 {
        // arcsin(1-x) = pi/2 - sqrt(2x)(1+R(x))
        // 0 <= x <= 0.5
        // Peak relative error = 4.2e-18
        
        R :: float64.[
            0h3f68_4fc3_988e_9f08,
            0hbfe2_0792_59f9_290f,
            0h401b_dff5_baf3_3e6a,
            0hc039_91aa_ac01_ab68,
            0h403c_8962_40f3_081d,
        ];

        S :: float64.[
            1,
            0hc035_f2a2_b6bf_5d8c,
            0h4062_6219_af6a_7f42,
            0hc077_fe08_9590_63ee,
            0h4075_6709_b0b6_44be,
        ];

	    zz := 1.0 - a;
	    p := zz * polynomial(zz, R)/polynomial(zz, S);
	    zz = sqrt(zz+zz);
	    z := PIO4 - zz;
	    zz = zz * p - MOREBITS;
	    z = z - zz;
	    z = z + PIO4;

        return z * sign;
	} else {
        // arcsin(x)  =  x + x^3 P(x^2)/Q(x^2)
        // 0 <= x <= 0.625
        // Peak relative error = 1.2e-18 
        P :: float64.[
            0h3f71_6b9b_0bd4_8ad3,
            0hbfe3_4341_333e_5c16,
            0h4015_c74b_178a_2dd9,
            0hc030_4331_de27_907b,
            0h4033_9007_da77_9259,
            0hc020_656c_06ce_afd5,
        ];
        
        Q :: float64.[
            1,
            0hc02d_7b59_0b5e_0eab,
            0h4051_9fc0_25fe_9054,
            0hc062_65bb_6d35_76d7,
            0h4061_7056_84ff_bf9d,
            0hc048_9822_0a36_07ac,
        ];

	    if a < 1.0e-8  return x;

	    zz := a * a;
	    z := zz * polynomial(zz, P)/polynomial(zz, Q);
	    z = a * z + a;
        
        return z * sign;
	}
}


ASIN_AND_ACOS_ERROR_REPORTING_LIMIT :: 1.000001;

acos :: (x: float64) -> float64 {
    // Do some basic range checking.
    if (x < -1) || (x > 1) {
        if (x < -ASIN_AND_ACOS_ERROR_REPORTING_LIMIT) || (x > ASIN_AND_ACOS_ERROR_REPORTING_LIMIT) {
	        log("Argument to acos() is out of range: %\n", x);
	        return FLOAT64_NAN;
        }

        // Allow people to call us with a little bit of slop, like a dot product result.
        if x < -1  x = -1;
        if x >  1  x =  1;

        // It's a bit @Redunant since we also do some range-checking inside asin.
	}

    if x > 0.5 	{
        return(2 * asin(sqrt(0.5 - 0.5*x)));  // Do we know that this will not magnify error in x? Hmm.
    }

    z := PIO4 - asin(x);
    z = z + MOREBITS;
    z = z + PIO4;

    return z;
}

/*
 *
 *	Exponential function
 *
 *
 * DESCRIPTION:
 *
 * Returns e (2.71828...) raised to the x power.
 *
 * Range reduction is accomplished by separating the argument
 * into an integer k and fraction f such that
 *
 *     x    k  f
 *    e  = 2  e.
 *
 * A Pade' form  1 + 2x P(x**2)/( Q(x**2) - P(x**2) )
 * of degree 2/3 is used to approximate exp(f) in the basic
 * interval [-0.5, 0.5].
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       +- 88       50000       2.8e-17     7.0e-18
 *    IEEE      +- 708      40000       2.0e-16     5.6e-17
 *
 *
 * Error amplification in the exponential function can be
 * a serious matter.  The error propagation involves
 * exp( X(1+delta) ) = exp(X) ( 1 + X*delta + ... ),
 * which shows that a 1 lsb error in representing X produces
 * a relative error of X times 1 lsb in the function.
 * While the routine gives an accurate result for arguments
 * that are exactly represented by a double precision
 * computer number, the result contains amplified roundoff
 * error for large arguments not exactly represented.
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * exp underflow    x < MINLOG         0.0
 * exp overflow     x > MAXLOG         INFINITY
 *
 */

//
// Note, 17 December 2022:
//
// This is not as accurate as the Windows libc exp() and I am a little
// worried about that. Can we just give it a longer polynomial? Or do we
// need to do something different here?  -jblow
//

/*	Exponential function	*/

exp :: (x: float64) -> float64 {
    if isnan(x) return x;

    MAXLOG ::  170.0;
    MINLOG :: -170.0;
    if x > MAXLOG  return FLOAT64_INFINITY;
    if x < MINLOG  return 0;

    // Express e**x = e**g 2**n
    //   = e**g e**( n loge(2) )
    //   = e**( g + n loge(2) )
    //
    
    px := floor(LOG2E * x + 0.5); /* floor() truncates toward -infinity. */
    n := cast(s32) px;

    C1 :: 0h3fe6_2e40_0000_0000;
    C2 :: 0h3eb7_f7d1_cf79_abca;

    x -= px * C1;
    x -= px * C2;

    // rational approximation for exponential
    // of the fractional part:
    // e**x = 1 + 2x P(x**2)/( Q(x**2) - P(x**2) )
    //

    P :: float64.[
        0h3f20_89cd_d5e4_4be8,
        0h3f9f_06d1_0cca_2c7e,
        0h3ff0_0000_0000_0000,
    ];

    Q :: float64.[
        0h3ec9_2eb6_bc36_5fa0,
        0h3f64_ae39_b508_b6c0,
        0h3fcd_1709_9887_e074,
        0h4000_0000_0000_0000,
    ];

    XX := x * x;
    px = x * polynomial(XX, P);
    x =  px/(polynomial(XX, Q) - px);
    x = 1 + 2 * x;

    /* multiply by power of 2 */
    x = ldexp(x, n);
    return x;
}



/*
 *
 *	Power function
 *
 *
 * DESCRIPTION:
 *
 * Computes x raised to the yth power.  Analytically,
 *
 *      x**y  =  exp( y log(x) ).
 *
 * Following Cody and Waite, this program uses a lookup table
 * of 2**-i/16 and pseudo extended precision arithmetic to
 * obtain an extra three bits of accuracy in both the logarithm
 * and the exponential.
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE     -26,26       30000      4.2e-16      7.7e-17
 * 1/26 < x < 26, with log(x) uniformly distributed.
 * -26 < y < 26, y uniformly distributed.
 *    IEEE     0,8700       30000      1.5e-14      2.1e-15
 * 0.99 < x < 1.01, 0 < y < 8700, uniformly distributed.
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * pow overflow     x**y > MAXNUM      INFINITY
 * pow underflow   x**y < 1/MAXNUM       0.0
 * pow domain      x<0 and y noninteger  0.0
 *
 */

//
// Note: This function is off by a few significant digits relative to
// the Windows implementation, and it is also a mess, so we would like
// to substitute it with something else.  -jblow, 18 December 2022
//

#scope_export 
pow :: (x: float64, y: float64) -> float64 {
    if y == 0    return 1;

    if isnan(x)  return x;
    if isnan(y)  return y;

    if y == 1    return x;

    if !is_finite(y) && ((x == 1) || (x == -1)) {
	    log("Invalid arguments to pow(): (%, %)\n", x, y);
        return FLOAT64_NAN;
	}

    if x == 1  return 1;

    MAXNUM :: 0h7fef_ffff_ffff_ffff;
    if y >= MAXNUM {
	    if x > 1  return INFINITY;
	    if (x > 0) && (x < 1)  return 0;

	    if x < -1 return INFINITY;

	    if (x > -1) && (x < 0)  return 0;
	}

    if y <= -MAXNUM {
	    if x > 1  return 0;
	    if (x > 0) && (x < 1)  return INFINITY;

	    if x < -1  return 0;
	    if (x > -1) && (x < 0) return INFINITY;
	}

    if x >= MAXNUM {
	    if y > 0  return( INFINITY );
	    return 0;
	}

    /* Set iyflg to 1 if y is an integer.  */
    w := floor(y);
    y_is_integer := (w == y);

    /* Test for odd integer y.  */
    y_is_odd := false;
    if y_is_integer {
	    ya := abs(y);
	    ya  = floor(0.5 * ya);
	    yb := 0.5 * abs(w);

	    y_is_odd = (ya != yb);
	}

    if x <= -MAXNUM {
	    if y > 0 {
		    if y_is_odd return -INFINITY;
		    return INFINITY;
		}
        
	    if y < 0 {
		    return ifx y_is_odd then NEGATIVE_ZERO_64 else 0;
		}
 	}

    nflg: bool;	/* flag = 1 if x<0 raised to integer power */

    if x <= 0 {
	    if x == 0 {
		    if y < 0 {
			    if signbit(x) && y_is_odd return -INFINITY;
			    return INFINITY;
			}
            
		    if y > 0 {
			    return ifx signbit(x) && y_is_odd then NEGATIVE_ZERO_64;
			}

		    return 1;
		} else {
		    if !y_is_integer {
			    /* noninteger power of negative number */
			    log("Invalid arguments to pow(): (%, %)\n", x, y);
			    return FLOAT64_NAN;
			}

		    nflg = true;
		}
	}


    /*
    /* Integer power of an integer.  */
    // @Cleanup: Why is this code here? Is it just to avoid using the FPU
    // for speed purposes in older computers? Because nowadays it is probably
    // faster to use the FPU than to do this integer stuff, before you even talk
    // about the branching etc.

    // Actually there is kind of a reason to keep this here, which is to preserve
    // exactness for integer-stored-in-double inputs. But I don't think we need
    // to spec pow to preserve that. So let's just remove this code please.
    
    if y_is_integer {
	    i = w;
	    w = floor(x);
	    if( (w == x) && (fabs(y) < 32768.0) )
		{
		    w = powi( x, (int) y );
		    return( w );
		}
	}
    */

    if nflg  x = abs(x);  // We could move this to the place where nflg is set, and remove the 'if', presuming the intervening code stays deleted.

    /* For results close to 1, use a series expansion.  */
    w   = x - 1.0;
    aw := abs(w);
    ay := abs(y);
    wy := w * y;
    ya := abs(wy);

    ReturnZ :: () #expand {  // The old code used a goto, which we don't support at this time.
        /* Negate if odd integer power of negative number */
        if nflg && y_is_odd {
	        if z == 0  z = NEGATIVE_ZERO_64;
            else z = -z;
	    }

        `return z;
    }

    z: float64 = ---;
    if ((aw <= 1.0e-3) && (ay <= 1)) || ((ya <= 1.0e-3) && (ay >= 1)) {
	    z = (((((w*(y-5)/720 + 1/120.0)*w*(y-4) + 1/24.0)*w*(y-3)
		       + 1/6.0)*w*(y-2) + 0.5)*w*(y-1) )*wy + wy + 1;
        ReturnZ();
	}

    /* separate significand from exponent */
    e: s32;
    x, e = frexp(x);

    /*
    #if 0
    /* For debugging, check for gross overflow. */
    if( (e * y)  > (MEXP + 1024) )
    	goto overflow;
    #endif
    */

    A :: float64.[
        0h3ff0_0000_0000_0000, 0h3fee_a4af_a2a4_90da, 0h3fed_5818_dcfb_a487, 0h3fec_199b_dd85_529c,
        0h3fea_e89f_995a_d3ad, 0h3fe9_c491_82a3_f090, 0h3fe8_ace5_422a_a0db, 0h3fe7_a114_73eb_0187,
        0h3fe6_a09e_667f_3bcd, 0h3fe5_ab07_dd48_5429, 0h3fe4_bfda_d536_2a27, 0h3fe3_dea6_4c12_3422,
        0h3fe3_06fe_0a31_b715, 0h3fe2_387a_6e75_6238, 0h3fe1_72b8_3c7d_517b, 0h3fe0_b558_6cf9_890f,
        0h3fe0_0000_0000_0000
    ];

    B :: float64.[
        0,
        0h3c72_ed02_d75b_3707, 0h3c87_a1cd_345d_cc81, 0h3c86_e9f1_5686_4b27,
        0hbc8b_dd34_13b2_6456, 0h3c6d_4397_afec_42e2, 0h3c76_f46a_d231_82e4, 0hbc71_9041_b9d7_8a76,
        0
    ];
    
    /* Find significand of x in antilog table A[]. */
    i: s32 = 1;
    if x <= A[9]   i = 9;
    if x <= A[i+4] i += 4;
    if x <= A[i+2] i += 2;
    if x >= A[1]   i = -1;
    i += 1;


/* Find (x - A[i])/A[i]
 * in order to compute log(x/A[i]):
 *
 * log(x) = log( a x/a ) = log(a) + log(x/a)
 *
 * log(x/a) = log(1+v),  v = x/a - 1 = (x-a)/a
 */
    x -= A[i];
    x -= B[i/2];
    x /= A[i];

/* rational approximation for log(1+v):
 *
 * log(1+v)  =  v  -  v**2/2  +  v**3 P(v) / Q(v)
 */
    P :: float64.[
        0h3fdf_db99_7f5b_5cf0,
        0h400d_ddef_ea9e_df15,
        0h401e_ccbd_7f78_eb6f,
        0h4012_aa83_b65c_9b74
    ];

    Q :: float64.[
        0h4022_aab4_9b20_914e,
        0h403b_ffff_41c1_c9f5,
        0h4040_ccbc_1b17_6402,
        0h402b_ffc5_918a_e92e
    ];

    z = x*x;
    w = x * (z * polynomial(x, P) / polynomial(x, Q));
    w = w - ldexp( z, -1 );   /*  w - 0.5 * z  */

    /* Convert to base 2 logarithm:
     * multiply by log2(e)
     */
    w = w + LOG2EA * w;
    
    /* Note x was not yet added in
     * to above rational approximation,
     * so do it now, while multiplying
     * by log2(e).
     */
    z = w + LOG2EA * x;
    z = z + x;

    /* Compute exponent term of the base 2 logarithm. */
    w = cast(float64) -i;
    w = ldexp(w, -4);	/* divide by 16 */
    w += e;

    /* Now base 2 log of x is w + z. */

    /* Multiply base 2 log by y, in extended precision. */

    /* separate y into large part ya
     * and small part yb less than 1/16
     */

    ya = reduc(y);
    yb := y - ya;

    F  := z * y  +  w * yb;
    Fa := reduc(F);
    Fb := F - Fa;

    G  := Fa + w * ya;
    Ga := reduc(G);
    Gb := G - Ga;

    H  := Fb + Gb;
    Ha := reduc(H);
    w = ldexp(Ga+Ha, 4);

    MEXP  :: 16383.0;
    MNEXP :: -17183.0;
    // If !DENORMAL, MNEXP :: -16383.0;

    /* Test the power of 2 for overflow */
    if w > MEXP { 
	    return ifx nflg && y_is_odd  then -INFINITY else INFINITY;
	}

    if w < (MNEXP - 1) {
	    return ifx nflg && y_is_odd then NEGATIVE_ZERO_64;
	}

    e = cast(s32) w;
    Hb := H - Ha;

    if Hb > 0 {
	    e += 1;
	    Hb -= 0.0625;
	}

    R :: float64.[
        0h3eef_6307_d7f2_937f,
        0h3f24_2fbe_60fc_9259,
        0h3f55_d87e_c84a_ef1d,
        0h3f83_b2ab_6ef1_33b7,
        0h3fac_6b08_d704_1a92,
        0h3fce_bfbd_ff82_c56d,
        0h3fe6_2e42_fefa_39ef
    ];

    /* Now the product y * log2(x)  =  Hb + e/16.0.
     *
     * Compute base 2 exponential of Hb,
     * where -0.0625 <= Hb <= 0.
     */
    z = Hb * polynomial(Hb, R);  /*    z  =  2**Hb - 1    */

    /* Express e/16 as an integer plus a negative number of 16ths.
     * Find lookup table entry for the fractional power of 2.
     */

    {
        // Note: New i!
        i := cast(s32) (e >= 0);

        i = e/16 + i;
        e = 16*i - e;
        w = A[e];
        z = w + w * z;      /*    2**-e * ( 1 + (2**Hb-1) )    */
        z = ldexp(z, i);  /* multiply by integer power of 2 */
    }
    
    ReturnZ();
}


/* Find a multiple of 1/16 that is within 1/16 of x. */
reduc :: (x: float64) -> float64 {
    t := ldexp(x, 4);
    t = floor(t);
    t = ldexp(t, -4);
    return t;
}


#scope_file


/*
 *
 *	Evaluate polynomial
 *
 *
 * DESCRIPTION:
 *
 * Evaluates polynomial of degree N:
 *
 *                     2          N
 * y  =  C  + C x + C x  +...+ C x
 *        0    1     2          N
 *
 * Coefficients are stored in reverse order:
 *
 * coef[0] = C  , ..., coef[N] = C  .
 *            N                   0
 *
 *  The function p1evl() assumes that coef[N] = 1.0 and is
 * omitted from the array.  Its calling arguments are
 * otherwise the same as polevl().
 *
 */


// This implementation of polevl, renamed 'polynomial',
// has been totally rewritten to leverage compiler features.
// If we want to, we could write a version that just generates
// the string to multiply-add all constants of coef in a hardcoded
// way... not sure if that is worth it!

// Original cephes had a p1evl, but since we see the array and know
// that it is constant, and dereferencing it is constant,
// it is easy to optimize out the initial multiply by 1, so
// we are just good. This function is much less error-prone.

polynomial :: (x: float64, $coef: [$N] float64) -> float64 {
    #assert (N >= 2) && (N <= 7);

    ans := coef[0] * x + coef[1];
    #if N > 2  ans = ans * x + coef[2];
    #if N > 3  ans = ans * x + coef[3];
    #if N > 4  ans = ans * x + coef[4];
    #if N > 5  ans = ans * x + coef[5];
    #if N > 6  ans = ans * x + coef[6];
    
    return ans;
}

