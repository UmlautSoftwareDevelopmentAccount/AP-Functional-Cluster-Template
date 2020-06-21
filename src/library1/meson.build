srcs = [
    'lib1.cpp',
]

lib = library('library1',
    srcs,
    include_directories: ['./'],
    install: true
)

library1_dep = declare_dependency(
    version: meson.project_version(),
    link_with: lib,
    include_directories: ['./']
)
