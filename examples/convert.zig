///reference https://proj.org/en/latest/development/quickstart.html
const c = @cImport({
    @cInclude("proj.h");
});
const std = @import("std");
pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    //Create the context
    const ctx = c.proj_context_create() orelse unreachable;
    defer _ = c.proj_context_destroy(ctx);

    //Create a projection
    const projection = c.proj_create(ctx, "+proj=utm +zone=32 +datum=WGS84 +type=crs") orelse unreachable;
    defer _ = c.proj_destroy(projection);
    
    //Get the geodetic CRS for that projection
    const geodetic_crs = c.proj_crs_get_geodetic_crs(ctx,projection);
    defer _ = c.proj_destroy(geodetic_crs);

    //Create the transform from geodetic to projected coordinates
    const g2p = c.proj_create_crs_to_crs_from_pj(ctx,geodetic_crs,projection,null,null);
    defer _ = c.proj_destroy(g2p);

    //Longitude and latitude of Copenhagen, in degrees
    const lon:f64 = 12.0;
    const lat :f64 = 55.0;
    const a = c.proj_coord(lon, lat, 0, 0);

    //Compute easting and northing
    const c_out  = c.proj_trans(g2p,c.PJ_FWD,a);
    try stdout.print("Output easting: {}, northing: {} (meters)\n", .{c_out.enu.e,c_out.enu.n});

    //Apply the inverse transform
    const c_inv  = c.proj_trans(g2p,c.PJ_INV,c_out);
    try stdout.print("Inverse applied. Longitude: {}, latitude: {} (degrees)\n", .{c_inv.lp.lam, c_inv.lp.phi});
}
