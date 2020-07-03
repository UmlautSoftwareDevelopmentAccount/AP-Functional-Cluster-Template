#!/bin/bash

#Topdir
TOPDIR=$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.." && pwd)

#global variables
sanitizer=""

function green() {
    printf "\033[01;32m%s\033[0m\n" "${1}"
}

function red() {
    printf "\033[01;31m%s\033[0m\n" "${1}"
}

# Prints an error message in bold red then exits
function die() {
    red "${1}"
    exit 1
}

function usage() {
    echo "${0}" [-c] [-h] [-a] [-t] [-u] [-m] [-s]
    echo "-c: Use clang compiler"
    echo "-a: Enable address sanitizer"
    echo "-t: Enable thread sanitizer"
    echo "-u: Enable undefined sanitizer"
    echo "-m: Enable memory sanitizer"
    echo "-s: Enable address,undefined sanitizer"
    echo "-v: verbose"
    echo "-h: Help"
}

# Parse inputs to the script
function parse_parameters() {
    while ((${#})); do
        case ${1} in
            -c | --clang)
                CC=$(command -v clang)
                CXX=$(command -v clang++)
                use_clang="1"
                ;;
            -a | --address)
                sanitizer="asan"
                ;;
            -t | --thread)
                sanitizer="tsan"
                ;;
            -u | --undefined)
                sanitizer="usan"
                ;;
            -m | --memory)
                sanitizer="msan"
                ;;
            -s | --ausan)
                sanitizer="ausan"
                ;;
            -v | --verbose)
                VERBOSE="-vvv"
                ;;
            -h | --help)
                usage
                exit 0
                ;;
            *)
                die "Invalid parameter '${1}'"
                ;;
        esac
        shift
    done
}

function enable_sanitizer() {
    case "${1}" in
    'asan')
        SANITIZER_OPTS="-Db_sanitize=address"
        if [ "${use_clang}" = "1" ]
        then
            # ref issue https://github.com/mesonbuild/meson/issues/764
            SANITIZER_OPTS="${SANITIZER_OPTS} -Db_lundef=false"
        fi
    ;;
   'tsan')
        SANITIZER_OPTS="-Db_sanitize=thread"
        if [ "${use_clang}" = "1" ]
        then
            SANITIZER_OPTS="${SANITIZER_OPTS} -Db_lundef=false"
        fi
    ;;
    'usan')
        SANITIZER_OPTS="-Db_sanitize=undefined"
        if [ "${use_clang}" = "1" ]
        then
            SANITIZER_OPTS="${SANITIZER_OPTS} -Db_lundef=false"
        fi
    ;;
    'msan')
        if [ "${use_clang}" = "1" ]
        then
            SANITIZER_OPTS="-Db_sanitize=memory -Db_lundef=false"
        fi
    ;;
    'ausan')
        SANITIZER_OPTS="-Db_sanitize=address,undefined"
        if [ "${use_clang}" = "1" ]
        then
            SANITIZER_OPTS="${SANITIZER_OPTS} -Db_lundef=false"
        fi
    ;;
    esac
}

function run_compile() {
    green "Start Compiling Now"

    if [ -d ${TOPDIR}/build ]
    then
        rm -rf ${TOPDIR}/build
    fi

    mkdir -p ${TOPDIR}/build
    cd ${TOPDIR}/build
    enable_sanitizer ${sanitizer}
    meson setup ${SANITIZER_OPTS} || die "meson setup failure!"
    ninja ${VERBOSE} || die "compiler failure!"
}

function run_test() {
    green "Running Unit Test now"
    cd ${TOPDIR}/build
    #FixMe: should enable detect_leaks
    #https://travis-ci.org/github/UmlautSoftwareDevelopmentAccount/AP-CoreTypes/builds/703187197
    export ASAN_OPTIONS=detect_leaks=0
    ninja test || die "run unit test failure!"
}

function run_coverage() {
    green "Generate coverage html now"
    cd ${TOPDIR}/build
    ninja coverage-html || die "generate coverage html failure!"
}

parse_parameters "${@}"
run_compile
run_test
run_coverage
