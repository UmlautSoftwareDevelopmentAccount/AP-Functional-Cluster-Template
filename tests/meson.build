subdir('test_runner')

srcs = [
    'lib1_test.cpp'
]

tests_exec = executable(
    'tests',
    srcs,
    dependencies: [
        test_runner_dep,
        library1_dep
    ]
)

test('tests', tests_exec)
