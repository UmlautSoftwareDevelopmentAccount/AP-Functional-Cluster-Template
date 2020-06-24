project('ap-functional-cluster-template', 'cpp',
    version: '0.1',
    license: 'MIT',
    default_options : [
		'cpp_std=c++2a',
		'warning_level=3',
		'werror=true',
		'buildtype=debugoptimized',
		'pkg_config_path=.',
		'b_coverage=true',
		'b_lto=true',
		'b_pie=true'
    ]
)

# additional compilation arguments
add_global_arguments(
	'-Wshadow', # warn whenever a local variable or type declaration shadows another variable, parameter or type,
	'-Wnon-virtual-dtor', # warn the user if a class with virtual functions has a non-virtual destructor
	'-Wold-style-cast', # warn for c-style casts
	'-Wcast-align', # warn for potential performance problem casts
	'-Wunused', # warn on anything being unused
	'-Woverloaded-virtual', # warn if you overload (not override) a virtual function
	'-Wpedantic', # warn if non-standard C++ is used
	'-Wconversion', # warn on type conversions that may lose data
	'-Wsign-conversion', # warn on sign conversions
	'-Wnull-dereference', # warn if a null dereference is detected
	'-Wdouble-promotion', # warn if float is implicit promoted to double
	'-Wformat=2', # warn on security issues around functions that format output
	'-Wmisleading-indentation', # warn if indentation implies blocks where blocks do not exist
	'-Wduplicated-cond', # warn if if / else chain has duplicated conditions
	'-Wduplicated-branches', # warn if if / else branches have duplicated code
	'-Wlogical-op', # warn about logical operations being used where bitwise were probably wanted
	'-Wuseless-cast', # warn if you perform a cast to the same type
	language : 'cpp'
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
pkg_mod.generate(libraries : [library1],
                 name : meson.project_name(),
                 version : meson.project_version(),
                 filebase : meson.project_name(),
                 description : 'The template repository for Adaptive Platform Functional Cluster')

install_subdir('include/ara', install_dir : 'include') # install include/ara into <prefix_path>/include
