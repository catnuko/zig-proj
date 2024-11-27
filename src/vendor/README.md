```bash
cd src/PROJ
mkdir build
cd build
cmake ..
cmake --build .
cp src/proj_config.h ../../vendor/proj_config.h
cp data/proj.db ../../vendor/data/proj.db
```