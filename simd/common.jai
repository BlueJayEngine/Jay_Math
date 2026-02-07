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


    // if total_size >= 32 {       // TODO: HANDLE 32-byte registry
    //     seg32 = total_size/32;
    //     total_size -= seg32*32;
    // }

    if total_size >= 16 {
        seg16 = total_size/16;
        total_size -= seg16*16;
    }

    tail = total_size/size_of(type);

    return seg32, seg16, tail;
}

simd :: inline (a: *$T/Numbers, b: *T, $length: s64 = 4, $op: Simd_Op) {
    #insert -> string {
        found, commands := table_find(*t_commands, reinterp(s64,T));

        if !found {
            log_error("The '%' is not a valid SIMD type", T);
            exit(1); 
        }
        command := get_command(commands, op);
        
        builder: String_Builder;

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


        if command == "" { // Unknown command fallback
            
            if oper == "" { log_error("Unable to satisfy % call for %x%", op, T, length); exit(0);}

            for i: 0..length-1 {
                print_to_builder(*builder, "a[%] %= b[%];", i, oper, i);
            }
            return builder_to_string(*builder);
        } 

        total_size: s64 = size_of(T) * length;
        bach_sizes: [..]s64;

        while total_size > 0 {
            if total_size < 16 {
                array_add(*bach_sizes, total_size); // non-simd fallback required
                total_size = 0;
                break;
            }

            best_bach_size := ifx total_size < 32 then 16 else 32;

            array_add(*bach_sizes, best_bach_size);
            total_size -= best_bach_size;
        }

        buffer_decl: [..]string;
        defer free(buffer_decl.data);

        for current_bach_size : bach_sizes {
            if (current_bach_size == 16) {
                array_add_if_unique(*buffer_decl, "xmm0: vec === 0;");
                array_add_if_unique(*buffer_decl, "xmm1: vec === 1;");
            } else if (current_bach_size == 32) {
                array_add_if_unique(*buffer_decl, "ymm0: vec === 0;");
                array_add_if_unique(*buffer_decl, "ymm1: vec === 1;");
            }
        }

        command_buffer: [..]string;
        defer free(command_buffer.data);

        fallback: [..]string;

        offset: s64 = 0;


        for current_bach_size : bach_sizes {

            if current_bach_size == {
            case 16; {
                array_add(*command_buffer, sprint("%.x  xmm0, [a+%];", commands.move, offset));
                array_add(*command_buffer, sprint("%.x  xmm1, [b+%];", commands.move, offset));
                array_add(*command_buffer, sprint("%.x  xmm0, xmm1;", command));
                array_add(*command_buffer, sprint("%.x [a+%], xmm0;\n", commands.move, offset));
            }
            case 32; {
                array_add(*command_buffer, sprint("%.y  ymm0, [a+%];", commands.move, offset));
                array_add(*command_buffer, sprint("%.y ymm1, [b+%];", commands.move, offset));
 
                array_add(*command_buffer, sprint("%.y  ymm0, ymm0, ymm1;", get_command(commands, op))); 
                array_add(*command_buffer, sprint("%.y [a+%], ymm0;\n", commands.move, offset));
 
            }
            case; {
                start_index :=  offset/size_of(T);
                end_index := start_index + current_bach_size/size_of(T);
                
                for i: start_index..end_index-1 {
                    array_add(*fallback, sprint("a[%] %= b[%];", i, oper, i));
                }
            }
        }

            offset += current_bach_size;
        }


        print_to_builder(*builder, "#asm AVX, AVX2 {\n\t%\n\n\t%\n}\n%", join(..buffer_decl, "\n\t"), join(..command_buffer, "\n\t"),  join(..fallback, "\n"));

        return builder_to_string(*builder);
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
    });


    return res;
}
