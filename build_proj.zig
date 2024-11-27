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
    "src/projections/aeqd.cpp",
    "src/projections/adams.cpp",
    "src/projections/gnom.cpp",
    "src/projections/laea.cpp",
    "src/projections/mod_ster.cpp",
    "src/projections/nsper.cpp",
    "src/projections/nzmg.cpp",
    "src/projections/ortho.cpp",
    "src/projections/stere.cpp",
    "src/projections/sterea.cpp",
    "src/projections/aea.cpp",
    "src/projections/bipc.cpp",
    "src/projections/bonne.cpp",
    "src/projections/eqdc.cpp",
    "src/projections/isea.cpp",
    "src/projections/ccon.cpp",
    "src/projections/imw_p.cpp",
    "src/projections/krovak.cpp",
    "src/projections/lcc.cpp",
    "src/projections/poly.cpp",
    "src/projections/rpoly.cpp",
    "src/projections/sconics.cpp",
    "src/projections/rouss.cpp",
    "src/projections/cass.cpp",
    "src/projections/cc.cpp",
    "src/projections/cea.cpp",
    "src/projections/eqc.cpp",
    "src/projections/gall.cpp",
    "src/projections/labrd.cpp",
    "src/projections/som.cpp",
    "src/projections/merc.cpp",
    "src/projections/mill.cpp",
    "src/projections/ocea.cpp",
    "src/projections/omerc.cpp",
    "src/projections/somerc.cpp",
    "src/projections/tcc.cpp",
    "src/projections/tcea.cpp",
    "src/projections/times.cpp",
    "src/projections/tmerc.cpp",
    "src/projections/tobmerc.cpp",
    "src/projections/airy.cpp",
    "src/projections/aitoff.cpp",
    "src/projections/august.cpp",
    "src/projections/bacon.cpp",
    "src/projections/bertin1953.cpp",
    "src/projections/chamb.cpp",
    "src/projections/hammer.cpp",
    "src/projections/lagrng.cpp",
    "src/projections/larr.cpp",
    "src/projections/lask.cpp",
    "src/projections/latlong.cpp",
    "src/projections/nicol.cpp",
    "src/projections/ob_tran.cpp",
    "src/projections/oea.cpp",
    "src/projections/tpeqd.cpp",
    "src/projections/vandg.cpp",
    "src/projections/vandg2.cpp",
    "src/projections/vandg4.cpp",
    "src/projections/wag7.cpp",
    "src/projections/lcca.cpp",
    "src/projections/geos.cpp",
    "src/projections/boggs.cpp",
    "src/projections/collg.cpp",
    "src/projections/comill.cpp",
    "src/projections/crast.cpp",
    "src/projections/denoy.cpp",
    "src/projections/eck1.cpp",
    "src/projections/eck2.cpp",
    "src/projections/eck3.cpp",
    "src/projections/eck4.cpp",
    "src/projections/eck5.cpp",
    "src/projections/fahey.cpp",
    "src/projections/fouc_s.cpp",
    "src/projections/gins8.cpp",
    "src/projections/gstmerc.cpp",
    "src/projections/gn_sinu.cpp",
    "src/projections/goode.cpp",
    "src/projections/igh.cpp",
    "src/projections/igh_o.cpp",
    "src/projections/imoll.cpp",
    "src/projections/imoll_o.cpp",
    "src/projections/hatano.cpp",
    "src/projections/loxim.cpp",
    "src/projections/mbt_fps.cpp",
    "src/projections/mbtfpp.cpp",
    "src/projections/mbtfpq.cpp",
    "src/projections/moll.cpp",
    "src/projections/nell.cpp",
    "src/projections/nell_h.cpp",
    "src/projections/patterson.cpp",
    "src/projections/putp2.cpp",
    "src/projections/putp3.cpp",
    "src/projections/putp4p.cpp",
    "src/projections/putp5.cpp",
    "src/projections/putp6.cpp",
    "src/projections/qsc.cpp",
    "src/projections/robin.cpp",
    "src/projections/s2.cpp",
    "src/projections/sch.cpp",
    "src/projections/sts.cpp",
    "src/projections/urm5.cpp",
    "src/projections/urmfps.cpp",
    "src/projections/wag2.cpp",
    "src/projections/wag3.cpp",
    "src/projections/wink1.cpp",
    "src/projections/wink2.cpp",
    "src/projections/healpix.cpp",
    "src/projections/natearth.cpp",
    "src/projections/natearth2.cpp",
    "src/projections/calcofi.cpp",
    "src/projections/eqearth.cpp",
    "src/projections/col_urban.cpp",
};
const src_libproj_conversions = [_][]const u8{
    "src/conversions/axisswap.cpp",
    "src/conversions/cart.cpp",
    "src/conversions/geoc.cpp",
    "src/conversions/geocent.cpp",
    "src/conversions/noop.cpp",
    "src/conversions/topocentric.cpp",
    "src/conversions/set.cpp",
    "src/conversions/unitconvert.cpp",
};
const src_libproj_transformations = [_][]const u8{
"src/transformations/affine.cpp",
"src/transformations/deformation.cpp",
"src/transformations/gridshift.cpp",
"src/transformations/helmert.cpp",
"src/transformations/hgridshift.cpp",
"src/transformations/horner.cpp",
"src/transformations/molodensky.cpp",
"src/transformations/vgridshift.cpp",
"src/transformations/xyzgridshift.cpp",
"src/transformations/defmodel.cpp",
"src/transformations/tinshift.cpp",
"src/transformations/vertoffset.cpp",
};
const src_libproj_iso19111 = [_][]const u8{
    "src/iso19111/static.cpp",
    "src/iso19111/util.cpp",
    "src/iso19111/metadata.cpp",
    "src/iso19111/common.cpp",
    "src/iso19111/coordinates.cpp",
    "src/iso19111/crs.cpp",
    "src/iso19111/datum.cpp",
    "src/iso19111/coordinatesystem.cpp",
    "src/iso19111/io.cpp",
    "src/iso19111/internal.cpp",
    "src/iso19111/factory.cpp",
    "src/iso19111/c_api.cpp",
    "src/iso19111/operation/concatenatedoperation.cpp",
    "src/iso19111/operation/coordinateoperationfactory.cpp",
    "src/iso19111/operation/conversion.cpp",
    "src/iso19111/operation/esriparammappings.cpp",
    "src/iso19111/operation/oputils.cpp",
    "src/iso19111/operation/parammappings.cpp",
    "src/iso19111/operation/projbasedoperation.cpp",
    "src/iso19111/operation/singleoperation.cpp",
    "src/iso19111/operation/transformation.cpp",
    "src/iso19111/operation/vectorofvaluesparams.cpp",
};
const src_libproj_core = [_][]const u8{
    "src/4D_api.cpp",
    "src/aasincos.cpp",
    "src/adjlon.cpp",
    "src/auth.cpp",
    "src/ctx.cpp",
    "src/datum_set.cpp",
    "src/datums.cpp",
    "src/deriv.cpp",
    "src/dmstor.cpp",
    "src/ell_set.cpp",
    "src/ellps.cpp",
    "src/factors.cpp",
    "src/fwd.cpp",
    "src/gauss.cpp",
    "src/generic_inverse.cpp",
    "src/init.cpp",
    "src/initcache.cpp",
    "src/internal.cpp",
    "src/inv.cpp",
    "src/list.cpp",
    "src/log.cpp",
    "src/malloc.cpp",
    "src/mlfn.cpp",
    "src/msfn.cpp",
    "src/mutex.cpp",
    "src/param.cpp",
    "src/phi2.cpp",
    "src/pipeline.cpp",
    "src/pr_list.cpp",
    "src/proj_mdist.cpp",
    "src/qsfn.cpp",
    "src/release.cpp",
    "src/rtodms.cpp",
    "src/strerrno.cpp",
    "src/strtod.cpp",
    "src/tsfn.cpp",
    "src/units.cpp",
    "src/wkt1_parser.cpp",
    "src/wkt2_parser.cpp",
    "src/wkt_parser.cpp",
    "src/zpoly1.cpp",
    "src/proj_json_streaming_writer.cpp",
    "src/tracing.cpp",
    "src/grids.cpp",
    "src/filemanager.cpp",
    "src/networkfilemanager.cpp",
    "src/sqlite3_utils.cpp",
};

const all_libproj_cpp_sources = src_libproj_core ++ src_libproj_conversions ++ src_libproj_projections ++ src_libproj_transformations ++ src_libproj_iso19111;

const all_libproj_c_sources = [_][]const u8{
    "src/geodesic.c",
    "src/wkt1_generated_parser.c",
    "src/wkt2_generated_parser.c",
};

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
    proj_dep: *std.Build.Dependency,

    pub fn link(self: Library, b: *std.Build, other: *std.Build.Step.Compile) void {
        other.addIncludePath(b.path("src/vendor/"));
        other.addIncludePath(self.proj_dep.path("src"));
        other.addIncludePath(self.proj_dep.path("include"));

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

    //add sqlite3 dependency
    const sqlite3_dep = b.lazyDependency("sqlite3", .{
        .target = target,
        .optimize = optimize,
    }) orelse unreachable;

    c_api.addIncludePath(sqlite3_dep.path("./"));
    c_api.addCSourceFile(.{ .file = sqlite3_dep.path("./sqlite3.c"), .flags = &.{} });

    for(cpp_args)|arg|{
        all_cpp_flags.append(arg) catch @panic("OOM");
    }

    const proj_dep = b.lazyDependency("proj", .{
        .target = target,
        .optimize = optimize,
    }) orelse unreachable;

    c_api.addIncludePath(b.path("src/vendor/"));
    c_api.addIncludePath(proj_dep.path("src"));
    c_api.addIncludePath(proj_dep.path("include"));
    
    inline for (all_libproj_cpp_sources) |s| {
        c_api.addCSourceFile(.{
            .file = proj_dep.path(s),
            .flags = all_cpp_flags.items,
        });
    }

    inline for (all_libproj_c_sources) |s| {
        c_api.addCSourceFile(.{
            .file = proj_dep.path(s),
            .flags = &c_args,
        });
    }
    c_api.linkLibCpp();
    return Library{ .step = c_api ,.proj_dep = proj_dep};
}