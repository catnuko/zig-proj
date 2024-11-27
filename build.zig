const std = @import("std");
const build_proj = @import("./build_proj.zig");
const Example = struct {
    cmd: []const u8,
    src: []const u8,
    descr: []const u8,
};

const examples = [_]Example{
    Example{ .cmd = "run-convert", .src = "examples/convert.zig", .descr = "Convert between a CRS and geodetic coordinates for that CRS." },
};
pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const proj = try build_proj.createCAPI(b,target,optimize);

    const zig_proj_mod = b.addModule("root",.{
        .root_source_file = b.path("src/c_api.zig"),
        .target = target,
        .optimize = optimize,
    });

    for (examples) |ex| {
        const exe = b.addExecutable(.{
            .name = ex.cmd,
            .root_source_file = b.path(ex.src),
            .target = target,
            .optimize = optimize,
        });
        exe.root_module.addImport("zig-proj",zig_proj_mod);
        proj.link(b,exe);

        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }
        const run_step = b.step(ex.cmd, ex.descr);
        run_step.dependOn(&run_cmd.step);
    }
}
