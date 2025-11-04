abs :: inline (x: $T/Numbers) -> T {
    if x < 0 return -x;
    return x;
}

trunc :: inline (x: $T/Numbers) -> T {
    return ifx x>0 then floor(x) else ceil(x);
}

mod :: inline (x: $T/Numbers, y: T) -> T  {
    return x - trunc(x / y) * y;
}

is_nan_is_inf :: (x: $T/Numbers) -> (isnan: bool, isinf: bool) {
    uf := << cast(*u64)*x;

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

is_finite :: (x: $T/Numbers) -> bool {
    uf := << cast(*u64)*x;
    unbiased_exponent := cast(s32) ((uf >> 52) & 0x7ff);  // @Speed: Could remove shift by doing big mask.
    return unbiased_exponent != 0x7ff;
}

// is_nan_is_inf :: (x: $T/Numbers) -> (isnan: bool, isinf: bool) {
//     uf := << cast(*u32)*x;
//     unbiased_exponent := (uf >> 23) & 0xff;
//     if unbiased_exponent == 0xff {
//         raw_mantissa := uf & 0x7f_ffff;
//         if raw_mantissa == 0 {
//             return false, true;
//         } else {
//             return true, false;
//         }
//     }

//     return false, false;
// }

isnan :: (x: $T/Numbers) -> bool {
    return is_nan_is_inf(x);
}

isinf :: (x: $T/Numbers) -> bool {
    _, _isinf := is_nan_is_inf(x);
    return _isinf;
}

is_finite :: (x: $T/Numbers) -> bool {
    uf := << cast(*u32)*x;
    unbiased_exponent := (uf >> 23) & 0xff;
    return unbiased_exponent != 0xff;
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

grid_snap :: (loc: $T/Numbers, grid: T) -> T {
    return floor((loc + (grid/ cast(T) 2)) / grid) * grid;
}

inv_sqrt :: (x: $T/Numbers) -> T {
    return 1/sqrt(x);
}

finv_sqrt :: (x: $T/Numbers) -> T {
    y := x;
   
    i: s64 = <<(cast(*s64) *y);

    i = 0x5f3759df - ( i >> 1 );
    y = <<(cast(*float32) *i);
    
    y = y * ( 1.5 - ( (x * 0.5) * y * y ) );
    
    return y;
}