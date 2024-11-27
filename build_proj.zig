/// Credit to mattnite for https://github.com/mattnite/zig-zlib/blob/a6a72f47c0653b5757a86b453b549819a151d6c7/zlib.zig
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const endsWith = std.mem.endsWith;

fn repository() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
const dir = repository() ++ "/src/";
const proj_dir = dir ++ "/PROJ/";
const src_path = proj_dir ++ "src/"; // mostly cpp
const src_path_rel = "src/PROJ/src/"; // mostly cpp

const src_libproj_projections = [_][]const u8{
    "projections/aeqd.cpp",
    "projections/adams.cpp",
    "projections/gnom.cpp",
    "projections/laea.cpp",
    "projections/mod_ster.cpp",
    "projections/nsper.cpp",
    "projections/nzmg.cpp",
    "projections/ortho.cpp",
    "projections/stere.cpp",
    "projections/sterea.cpp",
    "projections/aea.cpp",
    "projections/bipc.cpp",
    "projections/bonne.cpp",
    "projections/eqdc.cpp",
    "projections/isea.cpp",
    "projections/ccon.cpp",
    "projections/imw_p.cpp",
    "projections/krovak.cpp",
    "projections/lcc.cpp",
    "projections/poly.cpp",
    "projections/rpoly.cpp",
    "projections/sconics.cpp",
    "projections/rouss.cpp",
    "projections/cass.cpp",
    "projections/cc.cpp",
    "projections/cea.cpp",
    "projections/eqc.cpp",
    "projections/gall.cpp",
    "projections/labrd.cpp",
    "projections/som.cpp",
    "projections/merc.cpp",
    "projections/mill.cpp",
    "projections/ocea.cpp",
    "projections/omerc.cpp",
    "projections/somerc.cpp",
    "projections/tcc.cpp",
    "projections/tcea.cpp",
    "projections/times.cpp",
    "projections/tmerc.cpp",
    "projections/tobmerc.cpp",
    "projections/airy.cpp",
    "projections/aitoff.cpp",
    "projections/august.cpp",
    "projections/bacon.cpp",
    "projections/bertin1953.cpp",
    "projections/chamb.cpp",
    "projections/hammer.cpp",
    "projections/lagrng.cpp",
    "projections/larr.cpp",
    "projections/lask.cpp",
    "projections/latlong.cpp",
    "projections/nicol.cpp",
    "projections/ob_tran.cpp",
    "projections/oea.cpp",
    "projections/tpeqd.cpp",
    "projections/vandg.cpp",
    "projections/vandg2.cpp",
    "projections/vandg4.cpp",
    "projections/wag7.cpp",
    "projections/lcca.cpp",
    "projections/geos.cpp",
    "projections/boggs.cpp",
    "projections/collg.cpp",
    "projections/comill.cpp",
    "projections/crast.cpp",
    "projections/denoy.cpp",
    "projections/eck1.cpp",
    "projections/eck2.cpp",
    "projections/eck3.cpp",
    "projections/eck4.cpp",
    "projections/eck5.cpp",
    "projections/fahey.cpp",
    "projections/fouc_s.cpp",
    "projections/gins8.cpp",
    "projections/gstmerc.cpp",
    "projections/gn_sinu.cpp",
    "projections/goode.cpp",
    "projections/igh.cpp",
    "projections/igh_o.cpp",
    "projections/imoll.cpp",
    "projections/imoll_o.cpp",
    "projections/hatano.cpp",
    "projections/loxim.cpp",
    "projections/mbt_fps.cpp",
    "projections/mbtfpp.cpp",
    "projections/mbtfpq.cpp",
    "projections/moll.cpp",
    "projections/nell.cpp",
    "projections/nell_h.cpp",
    "projections/patterson.cpp",
    "projections/putp2.cpp",
    "projections/putp3.cpp",
    "projections/putp4p.cpp",
    "projections/putp5.cpp",
    "projections/putp6.cpp",
    "projections/qsc.cpp",
    "projections/robin.cpp",
    "projections/s2.cpp",
    "projections/sch.cpp",
    "projections/sts.cpp",
    "projections/urm5.cpp",
    "projections/urmfps.cpp",
    "projections/wag2.cpp",
    "projections/wag3.cpp",
    "projections/wink1.cpp",
    "projections/wink2.cpp",
    "projections/healpix.cpp",
    "projections/natearth.cpp",
    "projections/natearth2.cpp",
    "projections/calcofi.cpp",
    "projections/eqearth.cpp",
    "projections/col_urban.cpp",
};
const src_libproj_conversions = [_][]const u8{
    "conversions/axisswap.cpp",
    "conversions/cart.cpp",
    "conversions/geoc.cpp",
    "conversions/geocent.cpp",
    "conversions/noop.cpp",
    "conversions/topocentric.cpp",
    "conversions/set.cpp",
    "conversions/unitconvert.cpp",
};
const src_libproj_transformations = [_][]const u8{
"transformations/affine.cpp",
"transformations/deformation.cpp",
"transformations/gridshift.cpp",
"transformations/helmert.cpp",
"transformations/hgridshift.cpp",
"transformations/horner.cpp",
"transformations/molodensky.cpp",
"transformations/vgridshift.cpp",
"transformations/xyzgridshift.cpp",
"transformations/defmodel.cpp",
"transformations/tinshift.cpp",
"transformations/vertoffset.cpp",
};
const src_libproj_iso19111 = [_][]const u8{
    "iso19111/static.cpp",
    "iso19111/util.cpp",
    "iso19111/metadata.cpp",
    "iso19111/common.cpp",
    "iso19111/coordinates.cpp",
    "iso19111/crs.cpp",
    "iso19111/datum.cpp",
    "iso19111/coordinatesystem.cpp",
    "iso19111/io.cpp",
    "iso19111/internal.cpp",
    "iso19111/factory.cpp",
    "iso19111/c_api.cpp",
    "iso19111/operation/concatenatedoperation.cpp",
    "iso19111/operation/coordinateoperationfactory.cpp",
    "iso19111/operation/conversion.cpp",
    "iso19111/operation/esriparammappings.cpp",
    "iso19111/operation/oputils.cpp",
    "iso19111/operation/parammappings.cpp",
    "iso19111/operation/projbasedoperation.cpp",
    "iso19111/operation/singleoperation.cpp",
    "iso19111/operation/transformation.cpp",
    "iso19111/operation/vectorofvaluesparams.cpp",
};
const src_libproj_core = [_][]const u8{
    "4D_api.cpp",
    "aasincos.cpp",
    "adjlon.cpp",
    "auth.cpp",
    "ctx.cpp",
    "datum_set.cpp",
    "datums.cpp",
    "deriv.cpp",
    "dmstor.cpp",
    "ell_set.cpp",
    "ellps.cpp",
    "factors.cpp",
    "fwd.cpp",
    "gauss.cpp",
    "generic_inverse.cpp",
    "init.cpp",
    "initcache.cpp",
    "internal.cpp",
    "inv.cpp",
    "list.cpp",
    "log.cpp",
    "malloc.cpp",
    "mlfn.cpp",
    "msfn.cpp",
    "mutex.cpp",
    "param.cpp",
    "phi2.cpp",
    "pipeline.cpp",
    // "pj_list.h",
    "pr_list.cpp",
    // "proj_internal.h",
    "proj_mdist.cpp",
    "qsfn.cpp",
    "release.cpp",
    "rtodms.cpp",
    "strerrno.cpp",
    "strtod.cpp",
    "tsfn.cpp",
    "units.cpp",
    "wkt1_parser.cpp",
    // "wkt1_parser.h",

    "wkt2_parser.cpp",
    // "wkt2_parser.h",
    "wkt_parser.cpp",
    // "wkt_parser.hpp",
    "zpoly1.cpp",
    // "proj_json_streaming_writer.hpp",
    "proj_json_streaming_writer.cpp",
    "tracing.cpp",
    // "grids.hpp",
    "grids.cpp",
    // "filemanager.hpp",
    "filemanager.cpp",
    "networkfilemanager.cpp",
    // "sqlite3_utils.hpp",
    "sqlite3_utils.cpp",
};

const all_libproj_cpp_sources = src_libproj_core ++ src_libproj_conversions ++ src_libproj_projections ++ src_libproj_transformations ++ src_libproj_iso19111;

const all_libproj_c_sources = [_][]const u8{
    "geodesic.c",
    "wkt1_generated_parser.c",
    // "wkt1_generated_parser.h",
    "wkt2_generated_parser.c",
    // "wkt2_generated_parser.h",
};

// const include_dirs = [_][]const u8{
//     src_path,
//     proj_dir ++ "include/",
//     dir ++ "vendor/"
// };
const common_args = [_][]const u8{
    "-g0",
    "-O",
};
const c_args =  common_args ++ [_][]const u8{
};
const cpp_args = common_args ++ [_][]const u8{
    "-DPROJ_DATA=\"" ++ dir ++ "vendor/data/\"",
    "-std=c++14",
};

pub const Library = struct {
    step: *std.Build.Step.Compile,

    pub fn link(self: Library, b: *std.Build, other: *std.Build.Step.Compile) void {
        // for (include_dirs) |d| {
        //     other.addIncludePath(.{ .src_path = .{
        //         .sub_path = d,
        //         .owner = b,
        //     } });
        // }
        other.linkLibrary(self.step);
    }
};

pub fn createCAPI(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode) !Library {
    var all_cpp_flags = std.ArrayList([]const u8).init(b.allocator);
    const CURL_ENABLED = b.option(bool, "CURL_ENABLED", "Enable Curl support") orelse false;
    if (CURL_ENABLED){
        all_cpp_flags.append("-DCURL_ENABLED") catch @panic("OOM");
    }
    const ENABLE_TIFF = b.option(bool, "ENABLE_TIFF", "Enable TIFF support to read some grids") orelse false;
    if (ENABLE_TIFF){
        all_cpp_flags.append("-DENABLE_TIFF") catch @panic("OOM");
    }

    var c_api = b.addStaticLibrary(.{
        .name = "proj",
        .target = target,
        .optimize = optimize,
    });

    // for (include_dirs) |d| {
    //     c_api.addIncludePath(.{ .src_path = .{
    //         .owner = b,
    //         .sub_path = d,
    //     } });
    // }
    //add sqlite3 dependency
    c_api.addIncludePath(b.path("src/sqlite3/"));
    c_api.addCSourceFile(.{ .file = b.path("src/sqlite3/sqlite3.c"), .flags = &.{} });

    c_api.addIncludePath("src/vendor/");
    c_api.addIncludePath(proj_dep.path("src"));
    c_api.addIncludePath(proj_dep.path("include"));

    for(cpp_args)|arg|{
        all_cpp_flags.append(arg) catch @panic("OOM");
    }
    const proj_dep = b.lazyDependency("proj", .{
        .target = target,
        .optimize = optimize,
    }) orelse unreachable;
    
    inline for (all_libproj_cpp_sources) |s| {
        lib.addCSourceFile(.{
            .file = proj_dep.path(s),
            .flags = all_cpp_flags.items,
        });
    }

    inline for (all_libproj_c_sources) |s| {
        lib.addCSourceFile(.{
            .file = proj_dep.path(s),
            .flags = &c_args,
        });
    }
    // c_api.addCSourceFiles(.{
    //     .files = &all_libproj_cpp_sources,
    //     .flags = all_cpp_flags.items,
    // });
    // c_api.addCSourceFiles(.{
    //     .files = &all_libproj_c_sources,
    //     .flags = &c_args,
    // });
    c_api.linkLibCpp();
    return Library{ .step = c_api };
}