#!/usr/bin/env python3

"""
    C++11 Syntax Checker
    ==========================

    Runs compiler saved in the CXX environment variable with the -Wall -Wextra -fsyntax-only
    for files in a directory (recursive walk) passed with --header_file and adding includes (-I) from 
    the --include_dir path.
"""

import argparse
import sys
import os
import io
import subprocess


SUCCESS = 0
ERROR = 1


class SyntaxError(Exception):
    """ SytexError for storing the compiler command syntax errors. """

    def __init__(self, message, errs=[]):
        super(SyntaxError, self).__init__(message)
        self.errs = errs

    def msg(self):
        return str(self) + "".join(self.errs)


def list_files(directory: str, extensions: [str] = ['h']) -> [str]:
    """List all files in the [directory] (recursive) with a given extension.

    Args:
        directory (str): The path to the directory.
        extensions ([str], optional): The extensions to list. Defaults to ['h'].

    Returns:
        [str]: List of files absolute path
    """
    out = []

    if os.path.isdir(directory):
        for dirpath, _, fnames in os.walk(directory):
            fpaths = [os.path.join(dirpath, fname) for fname in fnames]
            for f in fpaths:
                ext = os.path.splitext(f)[1][1:]
                if ext in extensions:
                    out.append(os.path.abspath(f))

    return out


def run_compiler_syntax_check(header_files: [str], includes: str) -> int:
    """Run the cpp11 syntax check for each of the given header file in [header_files].

    Args:
        header_files ([str]): The list of the header files.
        includes (str): The path to include (-I) directory.

    Raises:
        SyntaxError: When there is an error in the Compiler command.

    Returns:
        int: The exit code 0 if everything went ok or 1 if error occured.
    """
    exit_code = SUCCESS

    cmd = os.environ['CXX'] + ' -Wall -Wextra -fsyntax-only -I{} {}'

    for header_file in header_files:
        try:
            parsed_cmd = cmd.format(includes, header_file)
            print(parsed_cmd)
            proc = subprocess.Popen(
                parsed_cmd,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True,
                encoding='utf-8'
            )

            proc_stderr = proc.stderr

            proc.wait()

            errs = list(proc_stderr.readlines())

            if proc.returncode:
                print("{}: error: {}".format(
                    parsed_cmd, "".join(errs)))
                exit_code = ERROR
        except OSError as e:
            raise SyntaxError(
                "Command '{}' failed to start: {}".format(
                    subprocess.list2cmdline(parsed_cmd), e
                )
            )

    return exit_code


def main() -> int:
    """The main function.
    Parse the arguments, list header files and run syntax check on each header file.

    Returns:
        int: Error code 0 on success or 1 on error.
    """
    exit_code = SUCCESS

    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        '--include_dir',
        help='Path to the include dir',
        default='include/')
    parser.add_argument(
        '--header_files',
        help='Path to the header files dir for cpp11 compatibility check',
        default='include/')

    args = parser.parse_args()

    header_files = list_files(args.header_files)
    try:
        exit_code = run_compiler_syntax_check(
            header_files, os.path.abspath(args.include_dir))
    except SyntaxError as e:
        print("{}: error: {}".format(
            os.environ['CXX'], e.msg()))
        exit_code = ERROR

    return exit_code


if __name__ == '__main__':
    sys.exit(main())
