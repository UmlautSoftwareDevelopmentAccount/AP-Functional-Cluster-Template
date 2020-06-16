# AP-Functional-Cluster-Template

[![Build Status](https://travis-ci.org/UmlautSoftwareDevelopmentAccount/AP-Functional-Cluster-Template.svg?branch=master)](https://travis-ci.org/UmlautSoftwareDevelopmentAccount/AP-Functional-Cluster-Template) [![codecov](https://codecov.io/gh/UmlautSoftwareDevelopmentAccount/AP-Functional-Cluster-Template/branch/master/graph/badge.svg)](https://codecov.io/gh/UmlautSoftwareDevelopmentAccount/AP-Functional-Cluster-Template)

The template repository for Adaptive Platform Functional Cluster


## Building project

```sh

mkdir build && cd build
meson setup -Db_coverage=true --pkg-config-path .
ninja
```

### Running tests and collecting test coverage
```sh
Run tests and coverage:
ninja test
ninja coverage-html
```
