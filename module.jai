#load "cephes.jai";
#load "scalar.jai";
#load "types/vector.jai";
#load "types/matrix.jai";
#load "types/quaternion.jai";
#load "types/euler.jai";
#load "transform.jai";

#import "Basic";


// Scalar constants from standart Math module

TAU32   :: cast(float32) 6.283185;
TAU :: 6.28318530717958648;

PI32    :: cast(float32) 3.1415927;
PI :: 3.141592653589793;

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

DEG_TO_RAD :float64: PI/180.0;
RAD_TO_DEG :float64: 180.0/PI;

#scope_module

Numbers :: Type.[s8, u8, s16, u16, s32, u32, float32, s64, u64, float64];
Floats :: Type.[float32, float64];
Reals :: Type.[s8, u8, s16, u16, s32, u32, s64, u64];