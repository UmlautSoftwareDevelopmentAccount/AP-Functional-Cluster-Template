# AP-Functional-Cluster-Template
The template repository for Adaptive Platform Functional Cluster


## Building project

```sh

mkdir build && cd build
meson setup -Db_coverage=true --pkg-config-path .
ninja

### Coverage

Run tests and coverage:
ninja test
ninja coverage-html
