// SIMD-accelerated matrix operations
// Element-wise operations (add, sub, div) operate on flat SIMD segments.
// Multiplication uses row-broadcast: for each result row i, accumulate
// a[i][k] * row_k(b) across all k, leveraging SIMD on whole rows.

simd_mat_add :: inline (a: Matrix, b: type_of(a)) -> type_of(a) #no_abc #no_aoc { return simd_mat(a, b, .ADD); }
simd_mat_sub :: inline (a: Matrix, b: type_of(a)) -> type_of(a) #no_abc #no_aoc { return simd_mat(a, b, .SUB); }
simd_mat_div :: inline (a: Matrix, b: type_of(a)) -> type_of(a) #no_abc #no_aoc { return a * inverse(b); }

simd_mat :: inline (a: Matrix, b: type_of(a), $op: Simd_Op) -> type_of(a) #no_abc #no_aoc {
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

simd_mat_mult :: inline (a: $T/Matrix, b: T) -> T #no_abc #no_aoc {
    result: T = ---;

    ROW_BYTES :: T.COL * size_of(T.T);
    // Number of elements that fit in a 16-byte SIMD register for this scalar type
    SIMD_WIDTH :: 16 / size_of(T.T);
    // How many full SIMD segments per row
    ROW_SEGS :: ROW_BYTES / 16;
    // How many scalar elements remain after SIMD segments in each row
    ROW_TAIL :: T.COL - ROW_SEGS * SIMD_WIDTH;

    #insert -> string {
        builder: String_Builder;

print_to_builder(*builder, "\n//\tSIMD % x % multiply\n", T.ROW, T.COL);

        for i: 0..T.ROW-1 {
            for j: 0..T.COL-1 {
                print_to_builder(*builder, "\tresult.cells[%][%] = 0;\n", i, j);
            }
            for k: 0..T.COL-1 {
                scalar_name := sprint("a_%_%", i, k);
                print_to_builder(*builder, "\t%: T.T = a.cells[%][%];\n", scalar_name, i, k);

                if ROW_SEGS > 0 {
                    for seg: 0..ROW_SEGS-1 {
                        base := seg * SIMD_WIDTH;

                        print_to_builder(*builder, "\t{\n");
                        print_to_builder(*builder, "\t\tbcast: [SIMD_WIDTH] T.T;\n");
                        for lane: 0..SIMD_WIDTH-1 {
                            print_to_builder(*builder, "\t\tbcast[%] = %;\n", lane, scalar_name);
                        }
                        
                        print_to_builder(*builder, "\t\tb_seg: [SIMD_WIDTH] T.T;\n");
                        for lane: 0..SIMD_WIDTH-1 {
                            print_to_builder(*builder, "\t\tb_seg[%] = b.cells[%][%];\n", lane, k, base + lane);
                        }
                        print_to_builder(*builder, "\t\tprod := simd_bach(bcast, b_seg, .MULT);\n");
                        print_to_builder(*builder, "\t\tr_seg: [SIMD_WIDTH] T.T;\n");
                        for lane: 0..SIMD_WIDTH-1 {
                            print_to_builder(*builder, "\t\tr_seg[%] = result.cells[%][%];\n", lane, i, base + lane);
                        }

                        print_to_builder(*builder, "\t\tr_seg = simd_bach(r_seg, prod, .ADD);\n");

                        for lane: 0..SIMD_WIDTH-1 {
                            print_to_builder(*builder, "\t\tresult.cells[%][%] = r_seg[%];\n", i, base + lane, lane);
                        }
                        print_to_builder(*builder, "\t}\n");
                    }
                }

                if ROW_TAIL > 0 {
                    tail_base := ROW_SEGS * SIMD_WIDTH;
                    for t: 0..ROW_TAIL-1 {
                        col := tail_base + t;
                        print_to_builder(*builder, "\tresult.cells[%][%] += % * b.cells[%][%];\n", i, col, scalar_name, k, col);
                    }
                }
            }
            print_to_builder(*builder, "\n");
        }

        return builder_to_string(*builder);
    }

    return result;
}
