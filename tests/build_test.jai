#import "Basic";
#import "Compiler";

#run {
    set_build_options_dc(.{ do_output = false });

    w := compiler_create_workspace("test");
    opts := get_build_options(w);

    new_path: [..]string;
    array_add(*new_path, ..opts.import_path);
    array_add(*new_path, "../../");
    opts.import_path = new_path;

    opts.backend = .LLVM;
    set_optimization(*opts, .VERY_OPTIMIZED, true);

    opts.output_type = .EXECUTABLE;
    opts.output_executable_name = "test";
    opts.output_path = "./";

    set_build_options(opts, w);
    add_build_file("test.jai", w);
}
