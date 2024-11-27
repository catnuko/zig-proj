///reference https://proj.org/en/latest/development/quickstart.html
const proj = @import("zig-proj");
const std = @import("std");
pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    //Create the context
    const ctx = proj.proj_context_create() orelse unreachable;
    defer _ = proj.proj_context_destroy(ctx);

    //Create a projection
    const projection = proj.proj_create(ctx, "+proj=utm +zone=32 +datum=WGS84 +type=crs") orelse unreachable;
    defer _ = proj.proj_destroy(projection);
    
    //Get the geodetic CRS for that projection
    const geodetic_crs = proj.proj_crs_get_geodetic_crs(ctx,projection);
    defer _ = proj.proj_destroy(geodetic_crs);

    //Create the transform from geodetic to projected coordinates
    const g2p = proj.proj_create_crs_to_crs_from_pj(ctx,geodetic_crs,projection,null,null);
    defer _ = proj.proj_destroy(g2p);

    //Longitude and latitude of Copenhagen, in degrees
    const lon:f64 = 12.0;
    const lat :f64 = 55.0;
    const a = proj.proj_coord(lon, lat, 0, 0);

    //Compute easting and northing
    const c_out  = proj.proj_trans(g2p,proj.PJ_FWD,a);
    try stdout.print("Output easting: {}, northing: {} (meters)\n", .{c_out.enu.e,c_out.enu.n});

    //Apply the inverse transform
    const c_inv  = proj.proj_trans(g2p,proj.PJ_INV,c_out);
    try stdout.print("Inverse applied. Longitude: {}, latitude: {} (degrees)\n", .{c_inv.lp.lam, c_inv.lp.phi});
}
