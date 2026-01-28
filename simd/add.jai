add_s32_4 :: inline (a: *s32, b: *s32) {
    #asm AVX, AVX2 {
        movdqu.x  xmm0: vec, [a];
        movdqu.x  xmm1: vec, [b];
        paddd.x   xmm1, xmm0;
        movdqu.x  [a], xmm1;
    }
}

add_s32_8 :: inline (a: *s32, b: *s32) {
    #asm AVX, AVX2, AVX512F {
        movdqu.y  ymm0: vec, [a];
        movdqu.y  ymm1: vec, [b];
        paddd.y   ymm1, ymm1, ymm0;
        movdqu.y  [a], ymm1;
    }
}

add_s32_16 :: inline (a: *s32, b: *s32) {
    #asm AVX, AVX2, AVX512F {
        movdqu.z  zmm0: vec, [a];
        movdqu.z  zmm1: vec, [b];
        paddd.z   zmm1, zmm1, zmm0;
        movdqu.z  [a], zmm1;
    }
}

// add_s32_4 :: inline (a: *s32, b: *s32) {
//     
//     #asm AVX, AVX2 {
//         movdqu.x  xmm0: vec, [a];
//         movdqu.x  xmm1: vec, [b];
//         paddd.x   xmm1, xmm0;
//         movdqu.x  [a], xmm1;
//     }
// }
//
// add_s32_8 :: inline (a: *s32, b: *s32) {
// #asm AVX, AVX2, AVX512F {
//     movdqu.y  ymm0: vec, [a];
//     movdqu.y  ymm1: vec, [b];
//     paddd.y   ymm1, ymm1, ymm0;
//     movdqu.y  [a], ymm1;
// }
// }

