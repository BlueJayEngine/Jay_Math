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

    SIMD_WIDTH :: cast(s64) (16 / size_of(T.T));
    COL        :: cast(s64) T.COL;
    ROW        :: cast(s64) T.ROW;

    ROW_SEGS   :: COL / SIMD_WIDTH;
    ROW_TAIL   :: COL - ROW_SEGS * SIMD_WIDTH;

    #insert -> string {
        builder: String_Builder;

        is_f32 :: T.T == float32;
        is_f64 :: T.T == float64;
        is_float :: is_f32 || is_f64;

        // Non-float types have no SIMD multiply — scalar fallback
        if !is_float {
            print_to_builder(*builder, "\n//\tScalar %x% multiply (no SIMD mult for %)\n", ROW, COL, T.T);
            for i: 0..ROW-1 {
                for j: 0..COL-1 {
                    print_to_builder(*builder, "\tresult.cells[%][%] = 0;\n", i, j);
                }
                for j: 0..COL-1 {
                    for k: 0..COL-1 {
                        print_to_builder(*builder, "\tresult.cells[%][%] += a.cells[%][%] * b.cells[%][%];\n", i, j, i, k, k, j);
                    }
                }
            }
            return builder_to_string(*builder);
        }

        found, commands := table_find(*t_commands, reinterp(s64, T.T));
        assert(found, "No SIMD commands for type %", T.T);

        bcast_inst := commands.broadcast;
        shuf_inst  := commands.shuf;
        mul_inst   := commands.mult;
        add_inst   := commands.add;

        asm_features := ifx is_f32 then "AVX, AVX2" else "AVX";

        SW :: SIMD_WIDTH;
        aligned :: ROW_TAIL == 0 && ROW_SEGS > 0;

        print_to_builder(*builder, "\n//\tSIMD %x% % multiply — inline asm broadcast-mul-acc\n", ROW, COL, T.T);

        if ROW_SEGS > 0 {
            for k: 0..COL-1 {
                for seg: 0..ROW_SEGS-1 {
                    if aligned {
                        // Direct overlay read — one load, straight to register
                        print_to_builder(*builder, "\tb_%_% := b._simd_data.simd16[%];\n", k, seg, k * ROW_SEGS + seg);
                    } else {
                        // Pack from cells
                        base := seg * SW;
                        print_to_builder(*builder, "\tb_%_%: [SIMD_WIDTH] T.T = ---;  ", k, seg);
                        for lane: 0..SW-1 {
                            print_to_builder(*builder, "b_%_%[%] = b.cells[%][%]; ", k, seg, lane, k, base + lane);
                        }
                        print_to_builder(*builder, "\n");
                    }
                }
            }
        }

        for i: 0..ROW-1 {
            print_to_builder(*builder, "\n\t// Row %\n\t{\n", i);

            // Load a's row segments
            if ROW_SEGS > 0 {
                for seg: 0..ROW_SEGS-1 {
                    if aligned {
                        print_to_builder(*builder, "\t\ta_seg_% := a._simd_data.simd16[%];\n", seg, i * ROW_SEGS + seg);
                    } else {
                        base := seg * SW;
                        print_to_builder(*builder, "\t\ta_seg_%: [SIMD_WIDTH] T.T = ---;  ", seg);
                        for lane: 0..SW-1 {
                            print_to_builder(*builder, "a_seg_%[%] = a.cells[%][%]; ", seg, lane, i, base + lane);
                        }
                        print_to_builder(*builder, "\n");
                    }
                }

                // Declare result segment locals
                for seg: 0..ROW_SEGS-1 {
                    print_to_builder(*builder, "\t\tr_%: [SIMD_WIDTH] T.T = ---;  \n", seg);
                }
            }

            if ROW_SEGS > 0 {
                for k: 0..COL-1 {
                    k_seg := k / SW;
                    if k_seg >= ROW_SEGS {
                        print_to_builder(*builder, "\t\tbk_%: [SIMD_WIDTH] T.T = ---;  ", k);
                        for lane: 0..SW-1 {
                            print_to_builder(*builder, "bk_%[%] = a.cells[%][%]; ", k, lane, i, k);
                        }
                        print_to_builder(*builder, "\n");
                    }
                }

                print_to_builder(*builder, "\t\t#asm % {\n", asm_features);

                // Phase 1: all broadcasts
                for k: 0..COL-1 {
                    k_seg  := k / SW;
                    k_lane := k % SW;
                    in_seg := k_seg < ROW_SEGS;

                    if in_seg {
                        if k_lane == 0 {
                            print_to_builder(*builder, "\t\t\t%.x bk%: vec, a_seg_%;\n", bcast_inst, k, k_seg);
                        } else {
                            if is_f32 {
                                shuf_imm := k_lane | (k_lane << 2) | (k_lane << 4) | (k_lane << 6);
                                print_to_builder(*builder, "\t\t\t%.x bk%: vec, a_seg_%, a_seg_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                            } else {
                                shuf_imm := k_lane | (k_lane << 1);
                                print_to_builder(*builder, "\t\t\t%.x bk%: vec, a_seg_%, a_seg_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                            }
                        }
                    }
                }

                // Phase 2: multiply-accumulate chain
                for k: 0..COL-1 {
                    k_seg  := k / SW;
                    in_seg := k_seg < ROW_SEGS;
                    bk_ref := ifx in_seg then sprint("bk%", k) else sprint("bk_%", k);

                    for seg: 0..ROW_SEGS-1 {
                        if k == 0 {
                            print_to_builder(*builder, "\t\t\t%.x r_%, %, b_%_%;\n", mul_inst, seg, bk_ref, k, seg);
                        } else {
                            print_to_builder(*builder, "\t\t\t%.x pk%s%: vec, %, b_%_%;\n", mul_inst, k, seg, bk_ref, k, seg);
                            print_to_builder(*builder, "\t\t\t%.x r_%, r_%, pk%s%;\n", add_inst, seg, seg, k, seg);
                        }
                    }
                }

                print_to_builder(*builder, "\t\t}\n");
            }

            // Scalar tail columns (outside asm)
            if ROW_TAIL > 0 {
                for k: 0..COL-1 {
                    tail_base := ROW_SEGS * SW;
                    for t: 0..ROW_TAIL-1 {
                        col := tail_base + t;
                        if k == 0 {
                            print_to_builder(*builder, "\t\tresult.cells[%][%] = a.cells[%][%] * b.cells[%][%];\n", i, col, i, k, k, col);
                        } else {
                            print_to_builder(*builder, "\t\tresult.cells[%][%] += a.cells[%][%] * b.cells[%][%];\n", i, col, i, k, k, col);
                        }
                    }
                }
            }

            // Write SIMD result segments back
            if ROW_SEGS > 0 {
                if aligned {
                    // Direct overlay write — one store from register
                    for seg: 0..ROW_SEGS-1 {
                        print_to_builder(*builder, "\t\tresult._simd_data.simd16[%] = r_%;\n", i * ROW_SEGS + seg, seg);
                    }
                } else {
                    // Unpack to cells
                    for seg: 0..ROW_SEGS-1 {
                        base := seg * SW;
                        for lane: 0..SW-1 {
                            print_to_builder(*builder, "\t\tresult.cells[%][%] = r_%[%];\n", i, base + lane, seg, lane);
                        }
                    }
                }
            }

            print_to_builder(*builder, "\t}\n");
        }

        return builder_to_string(*builder);
    }
    return result;
}
