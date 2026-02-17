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

    COL        :: cast(s64) T.COL;
    ROW        :: cast(s64) T.ROW;

    // Register widths in elements
    SW32       :: cast(s64) (32 / size_of(T.T));  // elements per YMM (32-byte)
    SW16       :: cast(s64) (16 / size_of(T.T));  // elements per XMM (16-byte)

    // Per-row segmentation from get_simd_magic — respects build mode (debug vs opt)
    ROW_SEGS32, ROW_SEGS16, ROW_TAIL :: #run get_simd_magic(T.T, COL);

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

        asm_features := "AVX, AVX2";

        print_to_builder(*builder, "\n//\tSIMD %x% % multiply — register-aware broadcast-mul-acc\n", ROW, COL, T.T);
        print_to_builder(*builder, "//\tRow layout: % x 32-byte (YMM), % x 16-byte (XMM), % scalar tail\n", ROW_SEGS32, ROW_SEGS16, ROW_TAIL);

        // All data movement goes through cells[][] — no overlay access.
        // This avoids mismatch between per-row segmentation and whole-matrix overlay.

        // ---- Pre-load b rows into segment locals ----
        if ROW_SEGS32 > 0 {
            for k: 0..COL-1 {
                for seg: 0..ROW_SEGS32-1 {
                    base := seg * SW32;
                    print_to_builder(*builder, "\tb32_%_%: [SW32] T.T = ---;  ", k, seg);
                    for lane: 0..SW32-1 {
                        print_to_builder(*builder, "b32_%_%[%] = b.cells[%][%]; ", k, seg, lane, k, base + lane);
                    }
                    print_to_builder(*builder, "\n");
                }
            }
        }

        if ROW_SEGS16 > 0 {
            for k: 0..COL-1 {
                for seg: 0..ROW_SEGS16-1 {
                    base := ROW_SEGS32 * SW32 + seg * SW16;
                    print_to_builder(*builder, "\tb16_%_%: [SW16] T.T = ---;  ", k, seg);
                    for lane: 0..SW16-1 {
                        print_to_builder(*builder, "b16_%_%[%] = b.cells[%][%]; ", k, seg, lane, k, base + lane);
                    }
                    print_to_builder(*builder, "\n");
                }
            }
        }

        // ---- Per-row multiply-accumulate ----
        for i: 0..ROW-1 {
            print_to_builder(*builder, "\n\t// Row %\n\t{\n", i);

            has_simd := ROW_SEGS32 > 0 || ROW_SEGS16 > 0;

            if has_simd {
                // Load a[i][*] into segment locals for broadcast extraction
                if ROW_SEGS32 > 0 {
                    for seg: 0..ROW_SEGS32-1 {
                        base := seg * SW32;
                        print_to_builder(*builder, "\t\ta32_seg_%: [SW32] T.T = ---;  ", seg);
                        for lane: 0..SW32-1 {
                            print_to_builder(*builder, "a32_seg_%[%] = a.cells[%][%]; ", seg, lane, i, base + lane);
                        }
                        print_to_builder(*builder, "\n");
                    }
                }

                if ROW_SEGS16 > 0 {
                    for seg: 0..ROW_SEGS16-1 {
                        base := ROW_SEGS32 * SW32 + seg * SW16;
                        print_to_builder(*builder, "\t\ta16_seg_%: [SW16] T.T = ---;  ", seg);
                        for lane: 0..SW16-1 {
                            print_to_builder(*builder, "a16_seg_%[%] = a.cells[%][%]; ", seg, lane, i, base + lane);
                        }
                        print_to_builder(*builder, "\n");
                    }
                }

                // Declare result segment locals
                for seg: 0..ROW_SEGS32-1 {
                    print_to_builder(*builder, "\t\tr32_%: [SW32] T.T = ---;  \n", seg);
                }
                for seg: 0..ROW_SEGS16-1 {
                    print_to_builder(*builder, "\t\tr16_%: [SW16] T.T = ---;  \n", seg);
                }

                // For columns in the tail of a's row, broadcast scalar into segment-width locals
                total_simd_cols := ROW_SEGS32 * SW32 + ROW_SEGS16 * SW16;
                for k: 0..COL-1 {
                    if k >= total_simd_cols {
                        if ROW_SEGS32 > 0 {
                            print_to_builder(*builder, "\t\tbk32_%: [SW32] T.T = ---;  ", k);
                            for lane: 0..SW32-1 {
                                print_to_builder(*builder, "bk32_%[%] = a.cells[%][%]; ", k, lane, i, k);
                            }
                            print_to_builder(*builder, "\n");
                        }
                        if ROW_SEGS16 > 0 {
                            print_to_builder(*builder, "\t\tbk16_%: [SW16] T.T = ---;  ", k);
                            for lane: 0..SW16-1 {
                                print_to_builder(*builder, "bk16_%[%] = a.cells[%][%]; ", k, lane, i, k);
                            }
                            print_to_builder(*builder, "\n");
                        }
                    }
                }

                // ---- YMM (32-byte) asm block ----
                if ROW_SEGS32 > 0 {
                    print_to_builder(*builder, "\t\t#asm % {\n", asm_features);

                    // Load a-row 32-byte segments into YMM registers from memory
                    for seg: 0..ROW_SEGS32-1 {
                        print_to_builder(*builder, "\t\t\t%.y ar32_%: vec, [*a32_seg_%];\n", commands.move, seg, seg);
                    }

                    // Load a-row 16-byte segments into XMM registers (for broadcast to YMM)
                    if ROW_SEGS16 > 0 {
                        for seg: 0..ROW_SEGS16-1 {
                            print_to_builder(*builder, "\t\t\t%.x ar16_%: vec, a16_seg_%;\n", commands.move, seg, seg);
                        }
                    }

                    // Phase 1: broadcasts
                    for k: 0..COL-1 {
                        k_in_32 := k < ROW_SEGS32 * SW32;
                        k_in_16 := !k_in_32 && k < total_simd_cols;

                        if k_in_32 {
                            k_seg  := k / SW32;
                            k_lane := k % SW32;

                            if is_f32 {
                                // f32: 8 lanes in YMM, low 4 in XMM
                                // broadcastss.y from lane 0; shufps.x + broadcastss.y for others
                                if k_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.y bk32_%: vec, ar32_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := k_lane | (k_lane << 2) | (k_lane << 4) | (k_lane << 6);
                                    print_to_builder(*builder, "\t\t\t%.x bk32_%_lo: vec, ar32_%, ar32_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                    print_to_builder(*builder, "\t\t\t%.y bk32_%: vec, bk32_%_lo;\n", bcast_inst, k, k);
                                }
                            } else {
                                // f64: 4 lanes in YMM — use vpermpd (permpd.y) to broadcast any lane
                                perm_imm := k_lane | (k_lane << 2) | (k_lane << 4) | (k_lane << 6);
                                print_to_builder(*builder, "\t\t\tpermpd.y bk32_%: vec, ar32_%, 0x%;\n", k, k_seg, formatInt(perm_imm, base=16));
                            }
                        } else if k_in_16 {
                            local_k := k - ROW_SEGS32 * SW32;
                            k_seg   := local_k / SW16;
                            k_lane  := local_k % SW16;

                            if is_f32 {
                                if k_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.y bk32_%: vec, ar16_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := k_lane | (k_lane << 2) | (k_lane << 4) | (k_lane << 6);
                                    print_to_builder(*builder, "\t\t\t%.x bk32_%_lo: vec, ar16_%, ar16_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                    print_to_builder(*builder, "\t\t\t%.y bk32_%: vec, bk32_%_lo;\n", bcast_inst, k, k);
                                }
                            } else {
                                // f64 from 16-byte segment (2 lanes) — broadcast to YMM
                                if k_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.y bk32_%: vec, ar16_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := k_lane | (k_lane << 1);
                                    print_to_builder(*builder, "\t\t\t%.x bk32_%_lo: vec, ar16_%, ar16_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                    print_to_builder(*builder, "\t\t\t%.y bk32_%: vec, bk32_%_lo;\n", bcast_inst, k, k);
                                }
                            }
                        }
                        // tail columns use bk32_% array locals declared above
                    }

                    // Load b-row 32-byte segments into YMM registers
                    for k: 0..COL-1 {
                        for seg: 0..ROW_SEGS32-1 {
                            print_to_builder(*builder, "\t\t\t%.y br32_%_%: vec, [*b32_%_%];\n", commands.move, k, seg, k, seg);
                        }
                    }

                    // Phase 2: multiply-accumulate (all in registers)
                    for k: 0..COL-1 {
                        k_in_tail := k >= total_simd_cols;
                        bk_ref := ifx k_in_tail then sprint("[*bk32_%]", k) else sprint("bk32_%", k);

                        for seg: 0..ROW_SEGS32-1 {
                            if k == 0 {
                                print_to_builder(*builder, "\t\t\t%.y rr32_%: vec, %, br32_%_%;\n", mul_inst, seg, bk_ref, k, seg);
                            } else {
                                print_to_builder(*builder, "\t\t\t%.y pk%s%: vec, %, br32_%_%;\n", mul_inst, k, seg, bk_ref, k, seg);
                                print_to_builder(*builder, "\t\t\t%.y rr32_%, rr32_%, pk%s%;\n", add_inst, seg, seg, k, seg);
                            }
                        }
                    }

                    // Store results back to memory
                    for seg: 0..ROW_SEGS32-1 {
                        print_to_builder(*builder, "\t\t\t%.y [*r32_%], rr32_%;\n", commands.move, seg, seg);
                    }

                    print_to_builder(*builder, "\t\t}\n");
                }

                // ---- XMM (16-byte) asm block ----
                if ROW_SEGS16 > 0 {
                    print_to_builder(*builder, "\t\t#asm % {\n", asm_features);

                    // Load a-row segments into registers
                    // 32-byte a-segments: load from memory into XMM (low 128 bits)
                    if ROW_SEGS32 > 0 {
                        for seg: 0..ROW_SEGS32-1 {
                            print_to_builder(*builder, "\t\t\t%.x ar32_%: vec, [*a32_seg_%];\n", commands.move, seg, seg);
                        }
                    }

                    // 16-byte a-segments: load directly (fits in XMM)
                    if ROW_SEGS16 > 0 {
                        for seg: 0..ROW_SEGS16-1 {
                            print_to_builder(*builder, "\t\t\t%.x ar16_%: vec, a16_seg_%;\n", commands.move, seg, seg);
                        }
                    }

                    // Phase 1: broadcasts
                    for k: 0..COL-1 {
                        k_in_32 := k < ROW_SEGS32 * SW32;
                        k_in_16 := !k_in_32 && k < total_simd_cols;

                        if k_in_32 {
                            k_seg  := k / SW32;
                            k_lane := k % SW32;
                            xmm_lane := k_lane % SW16;

                            if is_f32 {
                                if xmm_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar32_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := xmm_lane | (xmm_lane << 2) | (xmm_lane << 4) | (xmm_lane << 6);
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar32_%, ar32_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                }
                            } else {
                                if xmm_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar32_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := xmm_lane | (xmm_lane << 1);
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar32_%, ar32_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                }
                            }
                        } else if k_in_16 {
                            local_k := k - ROW_SEGS32 * SW32;
                            k_seg   := local_k / SW16;
                            k_lane  := local_k % SW16;

                            if is_f32 {
                                if k_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar16_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := k_lane | (k_lane << 2) | (k_lane << 4) | (k_lane << 6);
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar16_%, ar16_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                }
                            } else {
                                if k_lane == 0 {
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar16_%;\n", bcast_inst, k, k_seg);
                                } else {
                                    shuf_imm := k_lane | (k_lane << 1);
                                    print_to_builder(*builder, "\t\t\t%.x bk16_%: vec, ar16_%, ar16_%, 0x%;\n", shuf_inst, k, k_seg, k_seg, formatInt(shuf_imm, base=16));
                                }
                            }
                        }
                        // tail columns use bk16_% array locals declared above
                    }

                    // Phase 2: multiply-accumulate
                    for k: 0..COL-1 {
                        bk_ref := sprint("bk16_%", k);
                        for seg: 0..ROW_SEGS16-1 {
                            if k == 0 {
                                print_to_builder(*builder, "\t\t\t%.x r16_%, %, b16_%_%;\n", mul_inst, seg, bk_ref, k, seg);
                            } else {
                                print_to_builder(*builder, "\t\t\t%.x pk16_%s%: vec, %, b16_%_%;\n", mul_inst, k, seg, bk_ref, k, seg);
                                print_to_builder(*builder, "\t\t\t%.x r16_%, r16_%, pk16_%s%;\n", add_inst, seg, seg, k, seg);
                            }
                        }
                    }

                    print_to_builder(*builder, "\t\t}\n");
                }
            }

            // Scalar tail columns (outside asm)
            if ROW_TAIL > 0 {
                tail_base := ROW_SEGS32 * SW32 + ROW_SEGS16 * SW16;
                for k: 0..COL-1 {
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

            // Write SIMD result segments back through cells[][]
            if ROW_SEGS32 > 0 {
                for seg: 0..ROW_SEGS32-1 {
                    base := seg * SW32;
                    for lane: 0..SW32-1 {
                        print_to_builder(*builder, "\t\tresult.cells[%][%] = r32_%[%];\n", i, base + lane, seg, lane);
                    }
                }
            }

            if ROW_SEGS16 > 0 {
                for seg: 0..ROW_SEGS16-1 {
                    base := ROW_SEGS32 * SW32 + seg * SW16;
                    for lane: 0..SW16-1 {
                        print_to_builder(*builder, "\t\tresult.cells[%][%] = r16_%[%];\n", i, base + lane, seg, lane);
                    }
                }
            }

            print_to_builder(*builder, "\t}\n");
        }

        return builder_to_string(*builder);
    }
    return result;
}
