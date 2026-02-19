#load "types/number.jai";
#load "types/vector.jai";
#load "types/matrix.jai";
#load "types/rotator.jai";
#load "types/transform.jai";

#load "simd/common.jai";
#load "simd/vector.jai";
#load "simd/matrix.jai";

#import "Basic";

TAU     :: 0h40c9_0fdb;
TAU64   :: 0h4019_21fb_5444_2d18;

PI      :: 0h4049_0fdb;
PI64    :: 0h4009_21fb_5444_2d18;

PI_2    :: PI/2;
PI64_2  :: PI64/2;

PI_4    :: PI/4;
PI64_4  :: PI64/4;

INV_PI  :: 1/PI;
INV_PI64:: 1/PI64;

FLOAT16_MAX : float :   65504.0;

FLOAT32_MIN        :: 0h00800000;
FLOAT32_MAX        :: 0h7f7FFFFF;
FLOAT32_INFINITY   :: 0h7F800000;
FLOAT32_NAN        :: 0h7FBFFFFF;

FLOAT64_MIN        :: 0h00100000_00000000;
FLOAT64_MAX        :: 0h7FEFFFFF_FFFFFFFF;
FLOAT64_INFINITY   :: 0h7FF00000_00000000;
FLOAT64_NAN        :: 0h7FF7FFFF_FFFFFFFF;

S8_MIN  :s8:    -128;
S8_MAX  :s8:    127;
U8_MAX  :u8:    255;
S16_MIN :s16:   -32768;
S16_MAX :s16:   32767;
U16_MAX :u16:   0xffff;
S32_MIN :s32:   0x8000_0000;
S32_MAX :s32:   0x7fff_ffff;
U32_MAX :u32:   0xffff_ffff;
S64_MIN :s64:   0x8000_0000_0000_0000;
S64_MAX :s64:   0x7fff_ffff_ffff_ffff;
U64_MAX :u64:   0xffff_ffff_ffff_ffff;

DEG_TO_RAD :float32: PI/180.0;
RAD_TO_DEG :float32: 180.0/PI;

EPSILON    :float32: 0h33FF_FFD7;
EPSILON_64 :float64: 0h3CB0_0001_DD9D_C7D3;


Numbers :: Type.[s8, u8, s16, u16, s32, u32, float32, s64, u64, float64];

Floats :: Type.[float32, float64];

Integers :: Type.[s8, u8, s16, u16, s32, u32, s64, u64];
Signed :: Type.[s8, s16, s32, s64];
Unsigned :: Type.[u8, u16, u32, u64];

Numbers16 :: Type.[s16, u16];
Numbers32 :: Type.[s32, u32, float32];
Numbers64 :: Type.[s64, u64, float64];


reinterp :: inline ($toT: Type, x: $T) -> toT {
    union { from : T = ---; to : toT = ---; }    
    from = x;
    return to;
}
