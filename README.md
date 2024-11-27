# zig-proj
zig binding for the [PROJ](https://github.com/OSGeo/PROJ)

## Build
require list
* Zig`0.13.0`
* PROJ`9.5.0`
* sqlite3

```bash
$ git clone --recurse-submodules https://github.com/catnuko/zig-proj
$ cd zig-proj
$ zig build run-convert

proj_create_operation_factory_context: Cannot find proj.db
pj_obj_create: Cannot find proj.db
proj_coordoperation_is_instantiable: Cannot find proj.db
Output easting: 6.91875632137542e5, northing: 6.098907825129169e6 (meters)
Inverse applied. Longitude: 1.2e1, latitude: 5.5e1 (degrees)
```