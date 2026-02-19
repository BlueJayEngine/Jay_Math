simd_vec :: inline (a: Vector, b: type_of(a),  $op: Simd_Op) -> type_of(a) #no_abc #no_aoc {
   result: type_of(a) = --- #align size_of(type_of(a));

    #if result._simd_data.seg32 > 0 {
        for 0..result._simd_data.seg32-1 {
            result._simd_data.simd32[it] = simd_bach(a._simd_data.simd32[it], b._simd_data.simd32[it], op);
        }
    }

    #if result._simd_data.seg16 > 0 {
        for 0..result._simd_data.seg16-1 {
            result._simd_data.simd16[it] = simd_bach(a._simd_data.simd16[it], b._simd_data.simd16[it], op);
        }
    }

    #if result._simd_data.tail > 0 {
        #insert -> string {
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

            if oper == "" { log_error("Unable to satisfy % call for %x%", op, a.T, result._simd_data.tail); exit(0);}

            for i: 0..result._simd_data.tail-1 {
                print_to_builder(*builder, "result._simd_data.simd_tail[%] = a._simd_data.simd_tail[%] % b._simd_data.simd_tail[%];", i, i, oper, i);
            }
            return builder_to_string(*builder);

        } 
    }


    return result;  
}

simd_bach :: inline (a: [$N] $T, b: [N] T, $op: Simd_Op) -> [N] T {
    result: [N] T = ---;
    #insert -> string {
        builder: String_Builder;
        
        found, commands := table_find(*t_commands, reinterp(s64,T));

        if !found {
            log_error("The '%' is not a valid SIMD type", T);
            exit(1); 
        }
        command := get_command(commands, op);

        bach_size :: size_of(T)*N;

        // log("% = % %*%", bach_size, T, size_of(T), N);

        print_to_builder(*builder, "#asm AVX, AVX2 {\n");

       
        log("bach_size %, size_of %", bach_size, size_of(type_of(a)));
        if bach_size == 32 {
            print_to_builder(*builder, "    %.y res: vec, [*a];\n", commands.move);
            print_to_builder(*builder, "    %.y br: vec, [*b];\n", commands.move);
            print_to_builder(*builder, "    %.y res, res, br;\n", command); 
            print_to_builder(*builder, "    %.y [*result], res;\n", commands.move);
        } else {
            print_to_builder(*builder, "    %.x result, a, b;\n", command); 
        }

         print_to_builder(*builder, "}\n"); 

        return builder_to_string(*builder);
    }

    return result;
}

