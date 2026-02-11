abs :: inline (x: $T/Numbers) -> T {
    if x < 0 return -x;
    return x;
}

trunc :: inline (x: $T/Numbers) -> T {
    return ifx x>0 then floor(x) else ceil(x);
}

is_nan_is_inf :: inline (x: float64) -> (isnan: bool, isinf: bool) {
    uf := (.*) cast(*u64)*x;

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

is_nan_is_inf :: inline (x: float32) -> (isnan: bool, isinf: bool) {
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

isnan :: inline (x: $T/Numbers) -> bool {
    return is_nan_is_inf(x);
}

isinf :: inline (x: $T/Numbers) -> bool {
    _, _isinf := is_nan_is_inf(x);
    return _isinf;
}

signbit :: inline (x: float64) -> u64 {
    return reinterp(u64, x) & 0x8000_0000_0000_0000;
}

signbit :: inline (x: float32) -> u32 {
    return reinterp(u32, x) & 0x8000_0000;
}


frac :: inline (x: $T/Floats) -> T
#modify {
    if (T == float32) || (T == float64) return true;
    return false;
} {
    return x - floor(x);
}

lerp :: inline (a: $T/Numbers, b: T, t: float64) -> T {
    return a + (b - a) * t;
}

grid_snap :: inline (loc: $T/Numbers, grid: T) -> T {
    return floor((loc + (grid/ cast(T) 2)) / grid) * grid;
}

inv_sqrt :: inline (x: $T/Numbers) -> T {
    return 1/sqrt(x);
}

finv_sqrt :: inline (x: $T/Numbers) -> T {
    y := x;

    i: s64 = (.*)(cast(*s64) *y);

    i = 0x5f3759df - ( i >> 1 );
    y = (.*)(cast(*float32) *i);

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
        return EPSILON_32;
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

#load "cephes.jai";
