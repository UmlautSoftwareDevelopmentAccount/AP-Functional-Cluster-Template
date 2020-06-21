srcs = [
    'lib1.cpp',
]

library1 = library('library1',
    srcs,
    include_directories: ['./'],
    install: true
)

library1_dep = declare_dependency(
    version: meson.project_version(),
    link_with: library1,
    include_directories: ['./']
)
