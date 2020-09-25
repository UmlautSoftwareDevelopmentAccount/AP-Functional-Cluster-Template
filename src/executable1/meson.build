srcs = [
    'main.cpp',
]

exec = executable(
    'executable1',
    srcs,
    dependencies: [
        library1_dep,
        dependency('spdlog', include_type: 'system')
    ],
    install: true
)
