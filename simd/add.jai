add_s32_8 :: (a: *s32, b: *s32) {
    #asm AVX, AVX2 {
        movdqu.y  ymm0: vec, [a];
        movdqu.y  ymm1: vec, [b];
        paddd.y   ymm1, ymm0, ymm1;
        movupd.y  [b], ymm1;
    }
}

add_s32_4 :: (a: *s32, b: *s32) {
    #asm SSE {
        movdqu.x  xmm0: vec, [a];
        movdqu.x  xmm1: vec, [b];
        paddd.x   xmm1, xmm0;
        movdqu.x  [b], xmm1;
    }
}
