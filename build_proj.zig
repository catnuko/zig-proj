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
    src_path_rel ++ "projections/aeqd.cpp",
    src_path_rel ++ "projections/adams.cpp",
    src_path_rel ++ "projections/gnom.cpp",
    src_path_rel ++ "projections/laea.cpp",
    src_path_rel ++ "projections/mod_ster.cpp",
    src_path_rel ++ "projections/nsper.cpp",
    src_path_rel ++ "projections/nzmg.cpp",
    src_path_rel ++ "projections/ortho.cpp",
    src_path_rel ++ "projections/stere.cpp",
    src_path_rel ++ "projections/sterea.cpp",
    src_path_rel ++ "projections/aea.cpp",
    src_path_rel ++ "projections/bipc.cpp",
    src_path_rel ++ "projections/bonne.cpp",
    src_path_rel ++ "projections/eqdc.cpp",
    src_path_rel ++ "projections/isea.cpp",
    src_path_rel ++ "projections/ccon.cpp",
    src_path_rel ++ "projections/imw_p.cpp",
    src_path_rel ++ "projections/krovak.cpp",
    src_path_rel ++ "projections/lcc.cpp",
    src_path_rel ++ "projections/poly.cpp",
    src_path_rel ++ "projections/rpoly.cpp",
    src_path_rel ++ "projections/sconics.cpp",
    src_path_rel ++ "projections/rouss.cpp",
    src_path_rel ++ "projections/cass.cpp",
    src_path_rel ++ "projections/cc.cpp",
    src_path_rel ++ "projections/cea.cpp",
    src_path_rel ++ "projections/eqc.cpp",
    src_path_rel ++ "projections/gall.cpp",
    src_path_rel ++ "projections/labrd.cpp",
    src_path_rel ++ "projections/som.cpp",
    src_path_rel ++ "projections/merc.cpp",
    src_path_rel ++ "projections/mill.cpp",
    src_path_rel ++ "projections/ocea.cpp",
    src_path_rel ++ "projections/omerc.cpp",
    src_path_rel ++ "projections/somerc.cpp",
    src_path_rel ++ "projections/tcc.cpp",
    src_path_rel ++ "projections/tcea.cpp",
    src_path_rel ++ "projections/times.cpp",
    src_path_rel ++ "projections/tmerc.cpp",
    src_path_rel ++ "projections/tobmerc.cpp",
    src_path_rel ++ "projections/airy.cpp",
    src_path_rel ++ "projections/aitoff.cpp",
    src_path_rel ++ "projections/august.cpp",
    src_path_rel ++ "projections/bacon.cpp",
    src_path_rel ++ "projections/bertin1953.cpp",
    src_path_rel ++ "projections/chamb.cpp",
    src_path_rel ++ "projections/hammer.cpp",
    src_path_rel ++ "projections/lagrng.cpp",
    src_path_rel ++ "projections/larr.cpp",
    src_path_rel ++ "projections/lask.cpp",
    src_path_rel ++ "projections/latlong.cpp",
    src_path_rel ++ "projections/nicol.cpp",
    src_path_rel ++ "projections/ob_tran.cpp",
    src_path_rel ++ "projections/oea.cpp",
    src_path_rel ++ "projections/tpeqd.cpp",
    src_path_rel ++ "projections/vandg.cpp",
    src_path_rel ++ "projections/vandg2.cpp",
    src_path_rel ++ "projections/vandg4.cpp",
    src_path_rel ++ "projections/wag7.cpp",
    src_path_rel ++ "projections/lcca.cpp",
    src_path_rel ++ "projections/geos.cpp",
    src_path_rel ++ "projections/boggs.cpp",
    src_path_rel ++ "projections/collg.cpp",
    src_path_rel ++ "projections/comill.cpp",
    src_path_rel ++ "projections/crast.cpp",
    src_path_rel ++ "projections/denoy.cpp",
    src_path_rel ++ "projections/eck1.cpp",
    src_path_rel ++ "projections/eck2.cpp",
    src_path_rel ++ "projections/eck3.cpp",
    src_path_rel ++ "projections/eck4.cpp",
    src_path_rel ++ "projections/eck5.cpp",
    src_path_rel ++ "projections/fahey.cpp",
    src_path_rel ++ "projections/fouc_s.cpp",
    src_path_rel ++ "projections/gins8.cpp",
    src_path_rel ++ "projections/gstmerc.cpp",
    src_path_rel ++ "projections/gn_sinu.cpp",
    src_path_rel ++ "projections/goode.cpp",
    src_path_rel ++ "projections/igh.cpp",
    src_path_rel ++ "projections/igh_o.cpp",
    src_path_rel ++ "projections/imoll.cpp",
    src_path_rel ++ "projections/imoll_o.cpp",
    src_path_rel ++ "projections/hatano.cpp",
    src_path_rel ++ "projections/loxim.cpp",
    src_path_rel ++ "projections/mbt_fps.cpp",
    src_path_rel ++ "projections/mbtfpp.cpp",
    src_path_rel ++ "projections/mbtfpq.cpp",
    src_path_rel ++ "projections/moll.cpp",
    src_path_rel ++ "projections/nell.cpp",
    src_path_rel ++ "projections/nell_h.cpp",
    src_path_rel ++ "projections/patterson.cpp",
    src_path_rel ++ "projections/putp2.cpp",
    src_path_rel ++ "projections/putp3.cpp",
    src_path_rel ++ "projections/putp4p.cpp",
    src_path_rel ++ "projections/putp5.cpp",
    src_path_rel ++ "projections/putp6.cpp",
    src_path_rel ++ "projections/qsc.cpp",
    src_path_rel ++ "projections/robin.cpp",
    src_path_rel ++ "projections/s2.cpp",
    src_path_rel ++ "projections/sch.cpp",
    src_path_rel ++ "projections/sts.cpp",
    src_path_rel ++ "projections/urm5.cpp",
    src_path_rel ++ "projections/urmfps.cpp",
    src_path_rel ++ "projections/wag2.cpp",
    src_path_rel ++ "projections/wag3.cpp",
    src_path_rel ++ "projections/wink1.cpp",
    src_path_rel ++ "projections/wink2.cpp",
    src_path_rel ++ "projections/healpix.cpp",
    src_path_rel ++ "projections/natearth.cpp",
    src_path_rel ++ "projections/natearth2.cpp",
    src_path_rel ++ "projections/calcofi.cpp",
    src_path_rel ++ "projections/eqearth.cpp",
    src_path_rel ++ "projections/col_urban.cpp",
};
const src_libproj_conversions = [_][]const u8{
    src_path_rel ++ "conversions/axisswap.cpp",
    src_path_rel ++ "conversions/cart.cpp",
    src_path_rel ++ "conversions/geoc.cpp",
    src_path_rel ++ "conversions/geocent.cpp",
    src_path_rel ++ "conversions/noop.cpp",
    src_path_rel ++ "conversions/topocentric.cpp",
    src_path_rel ++ "conversions/set.cpp",
    src_path_rel ++ "conversions/unitconvert.cpp",
};
const src_libproj_transformations = [_][]const u8{
  src_path_rel ++ "transformations/affine.cpp",
  src_path_rel ++ "transformations/deformation.cpp",
  src_path_rel ++ "transformations/gridshift.cpp",
  src_path_rel ++ "transformations/helmert.cpp",
  src_path_rel ++ "transformations/hgridshift.cpp",
  src_path_rel ++ "transformations/horner.cpp",
  src_path_rel ++ "transformations/molodensky.cpp",
  src_path_rel ++ "transformations/vgridshift.cpp",
  src_path_rel ++ "transformations/xyzgridshift.cpp",
  src_path_rel ++ "transformations/defmodel.cpp",
  src_path_rel ++ "transformations/tinshift.cpp",
  src_path_rel ++ "transformations/vertoffset.cpp",
};
const src_libproj_iso19111 = [_][]const u8{
    src_path_rel ++ "iso19111/static.cpp",
    src_path_rel ++ "iso19111/util.cpp",
    src_path_rel ++ "iso19111/metadata.cpp",
    src_path_rel ++ "iso19111/common.cpp",
    src_path_rel ++ "iso19111/coordinates.cpp",
    src_path_rel ++ "iso19111/crs.cpp",
    src_path_rel ++ "iso19111/datum.cpp",
    src_path_rel ++ "iso19111/coordinatesystem.cpp",
    src_path_rel ++ "iso19111/io.cpp",
    src_path_rel ++ "iso19111/internal.cpp",
    src_path_rel ++ "iso19111/factory.cpp",
    src_path_rel ++ "iso19111/c_api.cpp",
    src_path_rel ++ "iso19111/operation/concatenatedoperation.cpp",
    src_path_rel ++ "iso19111/operation/coordinateoperationfactory.cpp",
    src_path_rel ++ "iso19111/operation/conversion.cpp",
    src_path_rel ++ "iso19111/operation/esriparammappings.cpp",
    src_path_rel ++ "iso19111/operation/oputils.cpp",
    src_path_rel ++ "iso19111/operation/parammappings.cpp",
    src_path_rel ++ "iso19111/operation/projbasedoperation.cpp",
    src_path_rel ++ "iso19111/operation/singleoperation.cpp",
    src_path_rel ++ "iso19111/operation/transformation.cpp",
    src_path_rel ++ "iso19111/operation/vectorofvaluesparams.cpp",
};
const src_libproj_core = [_][]const u8{
    src_path_rel ++ "4D_api.cpp",
    src_path_rel ++ "aasincos.cpp",
    src_path_rel ++ "adjlon.cpp",
    src_path_rel ++ "auth.cpp",
    src_path_rel ++ "ctx.cpp",
    src_path_rel ++ "datum_set.cpp",
    src_path_rel ++ "datums.cpp",
    src_path_rel ++ "deriv.cpp",
    src_path_rel ++ "dmstor.cpp",
    src_path_rel ++ "ell_set.cpp",
    src_path_rel ++ "ellps.cpp",
    src_path_rel ++ "factors.cpp",
    src_path_rel ++ "fwd.cpp",
    src_path_rel ++ "gauss.cpp",
    src_path_rel ++ "generic_inverse.cpp",
    src_path_rel ++ "init.cpp",
    src_path_rel ++ "initcache.cpp",
    src_path_rel ++ "internal.cpp",
    src_path_rel ++ "inv.cpp",
    src_path_rel ++ "list.cpp",
    src_path_rel ++ "log.cpp",
    src_path_rel ++ "malloc.cpp",
    src_path_rel ++ "mlfn.cpp",
    src_path_rel ++ "msfn.cpp",
    src_path_rel ++ "mutex.cpp",
    src_path_rel ++ "param.cpp",
    src_path_rel ++ "phi2.cpp",
    src_path_rel ++ "pipeline.cpp",
    // src_path_rel ++ "pj_list.h",
    src_path_rel ++ "pr_list.cpp",
    // src_path_rel ++ "proj_internal.h",
    src_path_rel ++ "proj_mdist.cpp",
    src_path_rel ++ "qsfn.cpp",
    src_path_rel ++ "release.cpp",
    src_path_rel ++ "rtodms.cpp",
    src_path_rel ++ "strerrno.cpp",
    src_path_rel ++ "strtod.cpp",
    src_path_rel ++ "tsfn.cpp",
    src_path_rel ++ "units.cpp",
    src_path_rel ++ "wkt1_parser.cpp",
    // src_path_rel ++ "wkt1_parser.h",

    src_path_rel ++ "wkt2_parser.cpp",
    // src_path_rel ++ "wkt2_parser.h",
    src_path_rel ++ "wkt_parser.cpp",
    // src_path_rel ++ "wkt_parser.hpp",
    src_path_rel ++ "zpoly1.cpp",
    // src_path_rel ++ "proj_json_streaming_writer.hpp",
    src_path_rel ++ "proj_json_streaming_writer.cpp",
    src_path_rel ++ "tracing.cpp",
    // src_path_rel ++ "grids.hpp",
    src_path_rel ++ "grids.cpp",
    // src_path_rel ++ "filemanager.hpp",
    src_path_rel ++ "filemanager.cpp",
    src_path_rel ++ "networkfilemanager.cpp",
    // src_path_rel ++ "sqlite3_utils.hpp",
    src_path_rel ++ "sqlite3_utils.cpp",
};

const all_libproj_cpp_sources = src_libproj_core ++ src_libproj_conversions ++ src_libproj_projections ++ src_libproj_transformations ++ src_libproj_iso19111;

const all_libproj_c_sources = [_][]const u8{
    src_path_rel ++ "geodesic.c",
    src_path_rel ++ "wkt1_generated_parser.c",
    // src_path_rel ++ "wkt1_generated_parser.h",
    src_path_rel ++ "wkt2_generated_parser.c",
    // src_path_rel ++ "wkt2_generated_parser.h",
};

const headers_libproj = [_][]const u8{
    src_path_rel ++ "proj.h",
    src_path_rel ++ "proj_experimental.h",
    src_path_rel ++ "proj_constants.h",
    src_path_rel ++ "proj_symbol_rename.h",
    src_path_rel ++ "geodesic.h",
};

const all_libproj_headers = headers_libproj;

const include_dirs = [_][]const u8{
    src_path,
    proj_dir ++ "include/",
};
// const common_args = [_][]const u8{
//     "-g0",
//     "-O",
//     "-Wduplicated-cond",
//     "-Wduplicated-branches",
//     "-Wlogical-op",
// };
// const geos_c_args = common_args ++ [_][]const u8{
//     "-Wmissing-prototypes",
// };

// const geos_cpp_args = common_args ++ [_][]const u8{
//     "-Weffc++",
//     "-Woverloaded-virtual",
//     "-Wzero-as-null-pointer-constant",
//     "-std=c++11",
// };
const geos_c_args =  [_][]const u8{
    "-g0",
    "-O",
};
const geos_cpp_args = [_][]const u8{
    "-g0",
    "-O",
    "-std=c++14",
};

pub const Options = struct {
    import_name: ?[]const u8 = null,
};

pub const Library = struct {
    step: *std.Build.Step.Compile,

    pub fn link(self: Library, b: *std.Build, other: *std.Build.Step.Compile, opts: Options) void {
        for (include_dirs) |d| {
            other.addIncludePath(.{ .src_path = .{
                .sub_path = d,
                .owner = b,
            } });
        }
        other.linkLibrary(self.step);
        if (opts.import_name) |_| {
            // other.addPackagePath(import_name, package_path);
        }
    }
};

pub fn createCAPI(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode) !Library {
    var c_api = b.addStaticLibrary(.{
        .name = "proj",
        .target = target,
        .optimize = optimize,
    });

    for (include_dirs) |d| {
        c_api.addIncludePath(.{ .src_path = .{
            .owner = b,
            .sub_path = d,
        } });
    }
    //add sqlite3 dependency
    c_api.addIncludePath(b.path("src/sqlite3/"));
    c_api.addCSourceFiles(.{ .files = &.{
        "src/sqlite3/sqlite3.c",
    }, .flags = &.{} });

    c_api.addCSourceFiles(.{
        .files = &all_libproj_cpp_sources,
        .flags = &geos_cpp_args,
    });
    c_api.addCSourceFiles(.{
        .files = &all_libproj_c_sources,
        .flags = &geos_c_args,
    });
    c_api.linkLibCpp();
    return Library{ .step = c_api };
}