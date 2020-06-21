project('ap-functional-cluster-template', 'cpp',
    version: '0.1',
    license: 'MIT',
    default_options : [
        'cpp_std=c++2a',
        'warning_level=3',
        'werror=true',
        'pkg_config_path=.',
        'b_coverage=true'
    ]
)

# install dependencies
conan = find_program('conan', required : true)
pkg_config = find_program('pkg-config', required : true)
conan_out = run_command('conan', 'install', '--build=missing', '-if', meson.build_root(), meson.source_root(), check: true)
if conan_out.returncode() != 0
	error(conan_out.stderr())
else
	message(conan_out.stdout())
endif

inc_dirs = include_directories('include')

subdir('src')
subdir('tests')

pkg_mod = import('pkgconfig')
pkg_mod.generate(libraries : [],
                 name : meson.project_name(),
                 version : meson.project_version(),
                 filebase : meson.project_name(),
                 description : 'The template repository for Adaptive Platform Functional Cluster')

install_subdir('include/ara', install_dir : 'include') # install include/ara into <prefix_path>/include
