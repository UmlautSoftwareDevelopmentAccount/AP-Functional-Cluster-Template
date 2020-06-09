project('ap-functional-cluster-template', 'cpp',
    version: '0.1',
    license: 'MIT',
    default_options : ['cpp_std=c++2a']
)

# additional compilation arguments
add_global_arguments('-Wall', '-Wextra', '-O2', language : 'cpp')

# install dependencies
conan = find_program('conan', required : true)
pkg_config = find_program('pkg-config', required : true)
conan_out = run_command('conan', 'install', '--build=missing', '-if', meson.build_root(), meson.source_root(), check: true)
if conan_out.returncode() != 0
	error(conan_out.stderr())
else
	message(conan_out.stdout())
endif

pkg_config_path = meson.build_root()

subdir('src')
subdir('tests')

