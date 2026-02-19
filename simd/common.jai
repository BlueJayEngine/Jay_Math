simd_add :: #bake_arguments simd(op = .ADD);
simd_sub :: #bake_arguments simd(op = .SUB);
simd_mult :: #bake_arguments simd(op = .MULT);
simd_div :: #bake_arguments simd(op = .DIV);
simd_and :: #bake_arguments simd(op = .AND);
simd_or :: #bake_arguments simd(op = .OR);
simd_xor :: #bake_arguments simd(op = .XOR);
simd_not :: #bake_arguments simd(op = .NOT);


#scope_module

Simd_Op :: enum {
    ADD :: 0;
    SUB :: 1;
    MULT :: 2;
    DIV :: 3;
    AND :: 4;
    OR :: 5;
    XOR :: 6;
    AND_NOT :: 7;
    NOT :: 8;
};

get_simd_magic :: ($type: Type, count: s64) -> (segments_32: s64, segments_16: s64, tail: s64) {
    total_size := size_of(type) * count;

    seg32 := 0;
    seg16 := 0;
    tail := 0;

    // is_opt :: #run -> bool {
    //     #import "Compiler";
    //     opts := get_build_options();
    //     return opts.emit_debug_info == .NONE;
    // }

    // #if is_opt {
        // if total_size >= 32 {       // TODO: HANDLE 32-byte registry and optimization level
        //     seg32 = total_size/32;  // Seems like we need to wait for when state of LLVM will chenge, idk for now
        //     total_size -= seg32*32;
        // }
        if total_size >= 16 {
            seg16 = total_size/16;
            total_size -= seg16*16;
        }
    // }

   
    
    tail = total_size/size_of(type);

    return seg32, seg16, tail;
}

simd :: inline (a: []$T, b: [$N]T, $op: Simd_Op) {
    result := a.data;
    bp := b.data;
    offset := 0;

    SEG32, SEG16, TAIL :: #run get_simd_magic(T, N);

    #if SEG32 >0 then for seg: 0..SEG32-1 {
        #insert -> string {
            
            found, commands := table_find(*t_commands, reinterp(s64,T));

            if !found {
                log_error("The '%' is not a valid SIMD type", T);
                exit(1); 
            }
            command := get_command(commands, op);


            buffer_decl: [..]string;

            array_add(*buffer_decl, "ymm0: vec;");
            array_add(*buffer_decl, "ymm1: vec;");
            command_buffer: [..]string;

            builder: String_Builder;

            array_add(*command_buffer, sprint("%.y  ymm0, [result+offset];", commands.move));
            array_add(*command_buffer, sprint("%.y ymm1, [bp+offset];", commands.move));
            array_add(*command_buffer, sprint("%.y  ymm0, ymm0, ymm1;", get_command(commands, op))); 
            array_add(*command_buffer, sprint("%.y [result+offset], ymm0;\n", commands.move));

            print_to_builder(*builder, "#asm AVX, AVX2 {\n\t%\n\n\t%\n}\n", join(..buffer_decl, "\n\t"), join(..command_buffer, "\n\t"));
            
            return builder_to_string(*builder);
        }

        offset+=32;
    }

    #if SEG16 >0 then for seg: 0..SEG16-1 {
        #insert -> string {
            found, commands := table_find(*t_commands, reinterp(s64,T));

            if !found {
                log_error("The '%' is not a valid SIMD type", T);
                exit(1); 
            }
            command := get_command(commands, op);


            buffer_decl: [..]string;

            array_add(*buffer_decl, "xmm0: vec === 0;");
            array_add(*buffer_decl, "xmm1: vec === 1;");
            command_buffer: [..]string;

            builder: String_Builder;

            array_add(*command_buffer, sprint("%.x xmm0, [result+offset];", commands.move));
            array_add(*command_buffer, sprint("%.x xmm1, [bp+offset];", commands.move));
            array_add(*command_buffer, sprint("%.x xmm0, xmm0, xmm1;", get_command(commands, op))); 
            array_add(*command_buffer, sprint("%.x [result+offset], xmm0;\n", commands.move));

            print_to_builder(*builder, "#asm AVX, AVX2 {\n\t%\n\n\t%\n}\n", join(..buffer_decl, "\n\t"), join(..command_buffer, "\n\t"));

            return builder_to_string(*builder);
        }
        offset+=16;
    }

    #if TAIL > 0 {
       for offset/size_of(T)..N-1 {
            #insert -> string {
                oper: string;

                if op == {
                    case .ADD; oper = "+";
                    case .SUB; oper = "-";
                    case .MULT; oper = "*";
                    case .DIV; oper = "/";

                    case .AND; oper = "&";
                    case .OR; oper = "|";
                    case .XOR; oper = "^";
                    case .NOT; oper = "~";
                }

                return sprint("a[it] %= b[it];\n", oper);
            }
        }
    }
}



#import "Hash_Table";

get_command :: (cmds: Type_Commands, $op: Simd_Op) -> string {
    #insert -> string { return sprint("return cmds.%;", to_lower_copy(sprint("%", op)));}
} 

Type_Commands :: struct {
    move: string = "";
    add: string = "";
    sub: string = "";
    mult: string = "";
    div: string = "";

    // logic:
    and: string = "";
    or: string = "";
    xor: string = "";
    and_not: string = "";
    test: string = "";

    // matrix multiply support:
    shuf: string = "";       // lane shuffle (shufps/shufpd)
    broadcast: string = "";  // scalar broadcast into all XMM lanes (broadcastss/movddup)
    fma: string = "";        // fused multiply-add: dest += src1 * src2 (fmadd231ps/pd)
}

t_commands := #run -> Table(s64, Type_Commands) {
    res: Table(s64, Type_Commands);

    table_add(*res, reinterp(s64, u8), .{
        move = "movdqu",
        add = "paddb",
        sub = "psubb",
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"
    });

    table_add(*res, reinterp(s64, s8), .{
        move = "movdqu",
        add = "paddb",
        sub = "psubb",
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    table_add(*res, reinterp(s64, u16), .{
        move = "movdqu",
        add = "paddw",
        sub = "psubw",
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    table_add(*res, reinterp(s64, s16), .{
       move = "movdqu",
        add = "paddw",
        sub = "psubw",
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    table_add(*res, reinterp(s64, u32), .{
        move = "movdqu",
        add = "paddd",
        sub = "psubd",
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    table_add(*res, reinterp(s64, s32), .{
        move = "movdqu",
        add = "paddd",
        sub = "psubd",
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    table_add(*res, reinterp(s64, u64), .{
       move = "movdqu",
        add = "paddq",
        sub = "psubq", 
        mult = "ERROR",
        div = "ERROR",

        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    table_add(*res, reinterp(s64, s64), .{
        move = "movdqu",
        add = "paddq",
        sub = "psubq",
        mult = "ERROR",
        div = "ERROR",
        // logic:
        and = "pand",
        or = "por",
        xor = "pxor",
        and_not = "pandn",
        test = "ptest"

    });

    // FLOATS:

    table_add(*res, reinterp(s64, float32), .{
        move = "movups",
        add = "addps",
        sub = "subps",
        mult = "mulps",
        div = "divps",
        // logic:
        and = "andps",
        or = "orps",
        xor = "xorps",
        and_not = "andnps",
        // matrix multiply:
        shuf = "shufps",
        broadcast = "broadcastss",  // AVX2, broadcasts low float32 to all 4 XMM lanes
        fma = "fmadd231ps",        // FMA: dest += src1 * src2 (packed single)
    });

    table_add(*res, reinterp(s64, float64), .{
        move = "movupd",
        add = "addpd",
        sub = "subpd",
        mult = "mulpd",
        div = "divpd",
        // logic:
        and = "andpd",
        or = "orpd",
        xor = "xorpd",
        and_not = "andnpd",
        // matrix multiply:
        shuf = "shufpd",
        broadcast = "movddup",      // SSE3, duplicates low float64 into both XMM lanes
        fma = "fmadd231pd",        // FMA: dest += src1 * src2 (packed double)
    });


    return res;
}
