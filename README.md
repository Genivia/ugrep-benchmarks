# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released.
Last update Mon Jun 16 11:52:19 EDT 2025

[performance report x64](#performance-report-x64)

[performance report arm64](#performance-report-arm64)

## benchmark setup

Intel x64 machine:
~~~
./install.sh # expand source code repo in corpi dir and create archives to search
./bench.sh > report_x64.md
./collect.awk < report_x64.md
~~~

ARM64 machine:
~~~
./install.sh # expand source code repo in corpi dir and create archives to search
./bench.sh > report_arm64.md
./collect.awk < report_arm64.md
~~~

the `install.sh` script requires the following compression utilities:

- bzip2
- gzip
- lzip
- xz
- zstd

## important notes on benchmarking methodology

**WARNING** performance results are meaningless when the host machine executes other tasks that load the CPU; quit all running applications first, disconnect from the network if possible to halt background process networking activity, and check for running background processes (with e.g. `top`) before running `./bench.sh`

- ugrep is compiled with Clang for performance, i.e. results may differ when ugrep is compiled with the GNU compiler
- timing results are collected with the standard 10ms resolution; a lower resolution is unusable and a higher resolution is unreliable due to the natural timing variations observed in the system
- all timed runs are warm runs, cold runs are not timed
- all timed runs of ugrep are performed without a .ugrep configuration file by using the ugrep command
- all regex patterns tested are fully compliant with the common ERE standard syntax; a failure may occur if a grep tool fails to parse ERE (for example, ripgrep failing to parse `[][a-z]` in URL pattern testing, when `[\[\]a-z]` works for ripgrep but this is not compliant so GNU grep fails)

## important notes on grep tool differences that impact the results

- **ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files;** we include option `-I` in recursive searches for a fair performance comparison
- **ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected to list all files thereby making the performance of option `-c` incomparable for recursive searches** (note: ugrep option `-m1,` (`--min-count=1`) skips zero matches but is not used in this benchmark)
- **ripgrep does not search tar file contents**, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead
- **ugrep option `-z` is more powerful than just internally decompressing a single file in a buffer to search,** it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files stored within archives
- **different versions and implementations of a compression library linked with ugrep may have different performance characteristics**, notably zlib (gz); the performance is mostly determined by the compression library and is not attributable to the grep tool

# performance report x64

found ugrep 1458616 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 7.5.0 x86_64-apple-darwin21.6.0 +avx2; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli,7z,tar/pax/cpio/zip
License: BSD-3-Clause; ugrep user manual: <https://ugrep.com>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
Ugrep utilizes the RE/flex regex library: <https://github.com/Genivia/RE-flex>
~~~

found rg 6748656 byte executable located at /usr/local/bin/rg
~~~
ripgrep 14.1.0

features:-simd-accel,+pcre2
simd(compile):+SSE2,+SSSE3,-AVX2
simd(runtime):+SSE2,+SSSE3,+AVX2

PCRE2 10.42 is available (JIT is available)
~~~

found ag 84764 byte executable located at /usr/local/bin/ag
~~~
ag version 2.2.0

Features:
  +jit +lzma +zlib
~~~

found ggrep 263184 byte executable located at /usr/local/bin/ggrep
~~~
ggrep (GNU grep) 3.11
Packaged by Homebrew
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Mike Haertel and others; see
<https://git.savannah.gnu.org/cgit/grep.git/tree/AUTHORS>.

grep -P uses PCRE2 10.44 2024-06-07
~~~



## results for large text file search

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.01 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.01 |
|     ag |   0.66 |   0.66 |   0.40 |   0.34 |   0.34 |   0.35 |   0.10 |   0.10 |   0.10 |   0.10 |
|  ggrep |   0.11 |   0.13 |   0.14 |   0.15 |   0.52 |   0.52 |   0.11 |   0.50 |   0.00 |   0.08 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.07 |   0.13 |   0.08 |   0.10 |   0.18 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.06 |   0.09 |   0.18 |   0.11 |   0.13 |   0.32 |   0.03 |   0.07 |   0.00 |   0.00 |
|     ag |   3.70 |   3.70 |   1.11 |   3.59 |   3.60 |   1.05 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.13 |   0.17 |   0.70 |   0.34 |   0.88 |   3.81 |   0.09 |   0.73 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.01 |
|     rg |   0.03 |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.03 |   0.05 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.40 |   0.41 |   0.41 |   0.41 |   0.16 |   0.17 |   0.15 |   0.16 |
|  ggrep |   0.21 |   0.22 |   0.22 |   0.33 |   0.29 |   0.29 |   0.20 |   0.27 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.06 |   0.07 |   0.07 |   0.05 |   0.06 |   0.01 |   0.01 |
|     rg |   0.04 |   0.04 |   0.04 |   0.06 |   0.07 |   0.06 |   0.04 |   0.06 |   0.00 |   0.00 |
|     ag |   0.44 |   0.45 |   0.39 |   0.40 |   0.40 |   0.38 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.36 |   0.37 |   0.37 |   0.39 |   0.83 |   0.85 |   0.34 |   0.82 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.10 |   0.10 |   0.12 |   0.11 |   0.06 |   0.11 |   0.00 |   0.00 |
|     rg |   0.15 |   0.16 |   0.21 |   0.17 |   0.19 |   0.19 |   0.13 |   0.18 |   0.00 |   0.00 |
|     ag |   1.84 |   1.84 |   0.69 |   0.47 |   0.47 |   0.41 |   0.20 |   0.15 |   0.20 |   0.15 |
|  ggrep |   0.86 |   0.91 |   1.28 |   1.12 |   3.16 |   3.21 |   0.81 |   3.11 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.05 |   0.04 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.12 |   0.20 |   0.02 |   0.11 |   0.00 |   0.00 |
|     ag |   0.74 |   0.74 |   0.52 |   0.73 |   1.75 |   1.20 |   0.23 |   0.84 |   0.23 |   0.85 |
|  ggrep |   0.26 |   0.27 |   0.34 |   0.30 |   1.72 |   3.28 |   0.24 |   1.63 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.03 |   0.01 |   0.01 |
|     rg |   0.02 |   0.02 |   0.02 |   0.03 |   0.14 |   0.14 |   0.02 |   0.14 |   0.00 |   0.02 |
|     ag |   0.35 |   0.34 |   0.34 |   0.23 |   0.41 |   0.41 |   0.14 |   0.17 |   0.13 |   0.18 |
|  ggrep |   0.31 |   0.33 |   0.33 |   0.32 |   2.44 |   2.47 |   0.30 |   2.42 |   0.04 |   0.29 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.05 |   0.04 |   0.04 |   0.01 |   0.01 |
|     rg |   0.04 |   0.05 |   0.05 |   0.04 |   0.12 |   0.23 |   0.03 |   0.10 |   0.01 |   0.00 |
|     ag |   1.61 |   1.62 |   0.86 |   1.57 |   1.57 |   0.87 |   0.47 |   0.48 |   0.46 |   0.48 |
|  ggrep |   1.09 |   1.11 |   3.17 |   1.25 |   1.53 |   3.74 |   1.04 |   1.43 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.07 |   0.04 |   0.12 |   0.11 |   0.04 |   0.11 |   0.00 |   0.00 |
|     ag |   1.87 |   1.87 |   0.65 |   0.42 |   0.43 |   0.42 |   0.15 |   0.17 |   0.15 |   0.17 |
|  ggrep |   0.11 |   0.13 |   0.32 |   0.34 |   1.61 |   1.63 |   0.09 |   1.62 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.13 |   0.21 |   0.12 |   0.14 |   0.14 |   0.04 |   0.13 |   0.00 |   0.00 |
|     rg |   0.14 |   0.24 |  10.03 |   0.26 |   0.26 |   1.73 |   0.08 |   0.10 |   0.00 |   0.00 |
|     ag |   4.25 |   4.23 |   4.29 |   2.25 |   2.25 |   2.26 |   4.01 |   2.01 |   3.99 |   2.02 |
|  ggrep |   0.20 |   0.34 |  16.84 |   1.59 |   2.89 |  36.81 |   0.07 |   2.45 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.04 |   0.04 |   0.04 |   0.07 |   0.07 |   0.07 |   0.04 |   0.07 |   0.00 |   0.00 |
|     ag |   0.40 |   0.40 |   0.40 |   0.40 |   0.40 |   0.38 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.05 |   0.07 |   0.07 |   0.09 |   0.09 |   0.11 |   0.05 |   0.08 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.07 |   0.07 |   0.07 |   0.05 |   0.06 |   0.01 |   0.02 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.81 |   0.80 |   0.55 |   0.80 |   0.81 |   0.56 |   0.15 |   0.16 |   0.15 |   0.17 |
|  ggrep |   5.64 |   5.67 |  11.43 |   5.80 |   5.97 |  11.99 |   5.57 |   5.88 |   0.01 |   0.01 |

grepping `[a-z]+-[a-z]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.05 |   0.06 |   0.06 |   0.07 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.06 |   0.07 |   0.09 |   0.08 |   0.09 |   0.12 |   0.05 |   0.07 |   0.00 |   0.00 |
|     ag |   2.10 |   2.12 |   0.93 |   2.13 |   2.14 |   0.96 |   0.38 |   0.41 |   0.38 |   0.41 |
|  ggrep |   2.73 |   2.71 |   5.21 |   3.04 |   2.97 |   6.45 |   2.57 |   2.80 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.16 |   0.16 |   0.16 |   0.16 |   0.16 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.15 |   0.25 |   9.97 |   0.26 |   0.26 |   1.70 |   0.08 |   0.10 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.06 |   1.17 |
|  ggrep |   0.20 |   0.35 |  16.62 |   1.56 |   2.66 |  34.36 |   0.07 |   2.26 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.06 |   0.06 |   0.06 |   0.06 |   0.05 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.06 |   0.08 |   0.09 |   0.75 |   0.76 |   0.76 |   0.05 |   0.73 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.37 | *fail* | *fail* | *fail* |   0.11 | *fail* |   0.11 | *fail* |
|  ggrep |   0.10 |   0.14 |   0.14 |   2.83 |   4.61 |   4.60 |   0.08 |   4.54 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.05 |   0.06 |   0.11 |   0.22 |   0.03 |   0.05 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.07 |   0.07 |   0.16 |   0.41 |   0.03 |   0.10 |   0.00 |   0.00 |
|  ggrep |   0.14 |   0.17 |   0.21 |   0.18 |   0.91 |   3.99 |   0.10 |   0.77 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.10 |   0.10 |   0.10 |   0.11 |   0.11 |   0.10 |   0.11 |   0.00 |   0.01 |
|     rg |   0.14 |   0.14 |   0.14 |   0.16 |  11.52 |  11.57 |   0.13 |  11.71 |   0.01 |   0.01 |
|  ggrep |   0.96 |   0.95 |   0.97 |   0.95 |   0.42 |   0.47 |   0.93 |   0.39 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.22 |   0.23 |   0.23 |   0.22 |   0.54 |   0.54 |   0.19 |   0.53 |   0.00 |   0.01 |
|     rg |   0.20 |   0.21 |   0.23 |   0.21 |  19.21 |  19.10 |   0.18 |  19.20 |   0.00 |   0.03 |
|  ggrep |   1.37 |   1.42 |   1.61 |   1.47 |   9.28 |   9.69 |   1.28 |   9.29 |   0.00 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.17 |   0.17 |   0.17 |   0.18 |   0.52 |   0.53 |   0.16 |   0.49 |   0.01 |   0.05 |
|     rg |   0.28 |   0.28 |   0.29 |   3.96 | 367.62 | 372.53 |   0.26 | 367.11 |   0.01 |   0.10 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |
|     rg |   0.03 | *fail* | *fail* | *fail* |
|     ag |   0.39 | *fail* |   0.39 | *fail* |

## results for large text file search with replaced output

grepping `flop` elapsed real time (s)

| search | --replace=flip |
| -----: | -----: |
|  ugrep |   0.02 |
|     rg |   0.02 |

## results for large text file search with context

grepping `^$` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.17 |   0.18 |   0.19 |   0.20 |   0.23 |   0.20 |
|     rg |   0.18 |   0.20 |   0.20 |   0.97 |   1.00 |   1.00 |
|     ag |   0.56 |   0.75 |   0.78 | *fail* | *fail* | *fail* |
|  ggrep |   0.29 |   0.34 |   0.34 |   5.11 |   5.39 |   5.32 |

grepping `begin|end` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.08 |   0.15 |   0.18 |   0.23 |   0.19 |
|     rg |   0.08 |   0.08 |   0.11 |   0.23 |   0.25 |   0.24 |
|     ag |   1.52 |   1.70 |   1.73 |   1.01 |   1.25 |   1.22 |
|  ggrep |   0.33 |   0.35 |   0.38 |   1.28 |   1.35 |   1.29 |

## results for large long lines JSON file search

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.03 |   0.04 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.01 |
|     rg |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     ag |   2.71 |   2.71 |   0.74 |   0.56 |   0.56 |   0.36 |   0.10 |   0.11 |   0.10 |   0.11 |
|  ggrep |   0.19 |   0.19 |   0.35 |   0.35 |   2.10 |   2.32 |   0.17 |   2.13 |   0.00 |   0.07 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.06 |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.17 |        |   0.18 |        |   0.25 |        |   0.25 |        |   0.24 |        |   0.24 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |        |   0.05 |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |
|     rg |   0.07 |        |   0.06 |        |   0.07 |        |   0.07 |        |   0.06 |        |   0.06 |        |
|     ag |        |   0.51 |        |   0.35 |        |   0.35 |        |   0.24 |        |   0.08 |        |   0.08 |
|  ggrep |        |   0.27 |        |   0.34 |        |   0.52 |        |   0.76 |        |   0.46 |        |   0.22 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.05 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.15 |        |   0.15 |        |   0.18 |        |   0.17 |        |   0.16 |        |   0.16 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |        |   0.25 |        |   0.25 |        |   0.26 |        |   0.28 |        |   0.25 |        |
|     rg |   0.26 |        |   0.25 |        |   0.26 |        |   0.26 |        |   0.26 |        |   0.26 |        |
|     ag |        |   0.42 |        |   0.40 |        |   0.40 |        |   0.41 |        |   0.39 |        |   0.40 |
|  ggrep |        |   0.78 |        |   0.92 |        |   1.01 |        |   1.00 |        |   0.97 |        |   0.93 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.29 |        |   0.27 |        |   0.30 |        |   0.30 |        |   0.29 |        |   0.26 |        |
|     rg |   0.33 |        |   0.31 |        |   0.34 |        |   0.34 |        |   0.33 |        |   0.31 |        |
|     ag |        |   1.41 |        |   0.81 |        |   1.08 |        |   0.85 |        |   0.49 |        |   0.50 |
|  ggrep |        |   1.03 |        |   1.20 |        |   2.64 |        |   3.00 |        |   2.49 |        |   1.08 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.25 |        |   0.25 |        |   0.26 |        |   0.26 |        |   0.27 |        |   0.26 |        |
|     rg |   0.25 |        |   0.26 |        |   0.27 |        |   0.27 |        |   0.27 |        |   0.27 |        |
|     ag |        |   0.43 |        |   0.40 |        |   0.42 |        |   0.44 |        |   0.43 |        |   0.42 |
|  ggrep |        |   0.98 |        |   1.03 |        |   1.35 |        |   1.33 |        |   1.30 |        |   1.22 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |        |   0.26 |        |   0.25 |        |   0.26 |        |   0.27 |        |   0.25 |        |
|     rg |   0.31 |        |   0.26 |        |   0.27 |        |   0.27 |        |   0.27 |        |   0.26 |        |
|     ag |        |   0.53 |        |   0.45 |        |   0.47 |        |   0.47 |        |   0.39 |        |   0.41 |
|  ggrep |        |   0.89 |        |   0.91 |        |   1.18 |        |   1.20 |        |   1.15 |        |   1.04 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.23 |   3.24 |   3.25 |   3.21 |   0.47 |   0.47 |
|     rg |   3.35 |   3.35 |   3.36 |   3.36 |   0.46 |   0.46 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.51 |   0.51 |   0.53 |   0.52 |   0.08 |   0.08 |
|     rg |   0.40 |   0.42 |   0.41 |   0.41 |   0.06 |   0.06 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.09 |   0.09 |   0.02 |   0.02 |
|     rg |   0.11 |   0.12 |   0.11 |   0.12 |   0.02 |   0.03 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.43 |   1.40 |   1.42 |   1.44 |   0.21 |   0.21 |
|     rg |   1.49 |   1.51 |   1.47 |   1.48 |   0.22 |   0.21 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.17 |   0.17 |   0.17 |   0.18 |   0.03 |   0.03 |
|     rg |   0.16 |   0.16 |   0.16 |   0.16 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.31 |   0.31 |   0.32 |   0.32 |   0.32 |   0.33 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.11 |   0.12 |   0.13 |   0.11 |   0.11 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.34 |   0.34 |   0.38 |   0.35 |   0.33 |   0.34 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1297746 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 7.5.0 aarch64-apple-darwin21.6.0 +neon/AArch64; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli,7z,tar/pax/cpio/zip
License: BSD-3-Clause; ugrep user manual: <https://ugrep.com>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
Ugrep utilizes the RE/flex regex library: <https://github.com/Genivia/RE-flex>
~~~

found rg 6680304 byte executable located at /opt/homebrew/bin/rg
~~~
ripgrep 14.1.0

features:-simd-accel,+pcre2
simd(compile):+NEON
simd(runtime):+NEON

PCRE2 10.42 is available (JIT is available)
~~~

found ag 111344 byte executable located at /opt/homebrew/bin/ag
~~~
ag version 2.2.0

Features:
  +jit +lzma +zlib
~~~

found ggrep 266352 byte executable located at /opt/homebrew/bin/ggrep
~~~
ggrep (GNU grep) 3.11
Packaged by Homebrew
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Mike Haertel and others; see
<https://git.savannah.gnu.org/cgit/grep.git/tree/AUTHORS>.

grep -P uses PCRE2 10.44 2024-06-07
~~~



## results for large text file search

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.02 |   0.01 |   0.01 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     ag |   0.53 |   0.53 |   0.43 |   0.40 |   0.40 |   0.40 |   0.16 |   0.16 |   0.16 |   0.16 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.37 |   0.37 |   0.09 |   0.35 |   0.00 |   0.05 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.08 |   0.05 |   0.06 |   0.13 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.10 |   0.06 |   0.08 |   0.18 |   0.02 |   0.05 |   0.00 |   0.00 |
|     ag |   1.94 |   1.94 |   0.84 |   1.89 |   1.89 |   0.80 |   0.20 |   0.21 |   0.20 |   0.21 |
|  ggrep |   0.10 |   0.13 |   0.40 |   0.23 |   0.50 |   2.22 |   0.08 |   0.44 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.00 |
|     ag |   0.52 |   0.52 |   0.51 |   0.50 |   0.50 |   0.50 |   0.28 |   0.26 |   0.28 |   0.26 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.15 |   0.22 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.04 |   0.05 |   0.05 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.02 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.02 |   0.04 |   0.00 |   0.00 |
|     ag |   0.44 |   0.44 |   0.42 |   0.41 |   0.41 |   0.40 |   0.17 |   0.16 |   0.17 |   0.17 |
|  ggrep |   0.25 |   0.27 |   0.28 |   0.30 |   0.58 |   0.58 |   0.25 |   0.56 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.07 |   0.07 |   0.08 |   0.08 |   0.08 |   0.05 |   0.08 |   0.00 |   0.00 |
|     rg |   0.13 |   0.14 |   0.18 |   0.11 |   0.13 |   0.13 |   0.12 |   0.12 |   0.00 |   0.00 |
|     ag |   1.16 |   1.16 |   0.68 |   0.46 |   0.46 |   0.43 |   0.31 |   0.18 |   0.31 |   0.18 |
|  ggrep |   0.49 |   0.51 |   0.72 |   0.63 |   1.81 |   1.85 |   0.48 |   1.79 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.01 |   0.02 |   0.02 |   0.02 |   0.09 |   0.16 |   0.01 |   0.08 |   0.00 |   0.00 |
|     ag |   0.63 |   0.63 |   0.54 |   0.63 |   2.18 |   1.95 |   0.27 |   1.65 |   0.27 |   1.66 |
|  ggrep |   0.16 |   0.18 |   0.21 |   0.18 |   0.97 |   1.90 |   0.16 |   0.95 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.01 |   0.01 |   0.01 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.01 |   0.01 |   0.01 |   0.02 |   0.11 |   0.11 |   0.01 |   0.11 |   0.00 |   0.01 |
|     ag |   0.39 |   0.39 |   0.40 |   0.28 |   1.53 |   1.54 |   0.19 |   1.31 |   0.19 |   1.31 |
|  ggrep |   0.19 |   0.21 |   0.21 |   0.21 |   1.42 |   1.42 |   0.19 |   1.40 |   0.02 |   0.17 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.04 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.09 |   0.18 |   0.02 |   0.08 |   0.00 |   0.00 |
|     ag |   3.32 |   3.32 |   2.99 |   2.29 |   2.29 |   2.00 |   2.69 |   1.68 |   2.69 |   1.69 |
|  ggrep |   0.57 |   0.59 |   1.69 |   0.65 |   0.86 |   2.06 |   0.56 |   0.83 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.03 |   0.04 |   0.04 |   0.03 |   0.08 |   0.08 |   0.02 |   0.08 |   0.00 |   0.00 |
|     ag |   1.07 |   1.07 |   0.55 |   0.45 |   0.45 |   0.45 |   0.19 |   0.21 |   0.19 |   0.21 |
|  ggrep |   0.08 |   0.10 |   0.20 |   0.21 |   1.05 |   1.05 |   0.07 |   1.03 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.09 |   0.14 |   0.10 |   0.11 |   0.11 |   0.03 |   0.10 |   0.00 |   0.00 |
|     rg |   0.08 |   0.14 |   5.13 |   0.15 |   0.15 |   0.96 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag |   3.97 |   3.98 |   3.98 |   3.02 |   3.02 |   3.02 |   3.73 |   2.78 |   3.71 |   2.80 |
|  ggrep |   0.11 |   0.19 |   7.61 |   0.72 |   1.28 |  16.78 |   0.04 |   1.12 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.01 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.05 |   0.03 |   0.05 |   0.00 |   0.00 |
|     ag |   0.37 |   0.37 |   0.37 |   0.36 |   0.36 |   0.36 |   0.13 |   0.12 |   0.13 |   0.12 |
|  ggrep |   0.04 |   0.05 |   0.06 |   0.07 |   0.07 |   0.08 |   0.04 |   0.06 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.05 |   0.05 |   0.03 |   0.04 |   0.00 |   0.01 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.60 |   0.60 |   0.50 |   0.59 |   0.60 |   0.50 |   0.19 |   0.19 |   0.19 |   0.19 |
|  ggrep |   3.40 |   3.42 |   6.94 |   3.53 |   3.67 |   7.43 |   3.39 |   3.64 |   0.00 |   0.00 |

grepping `[a-z]+-[a-z]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.04 |   0.03 |   0.04 |   0.04 |   0.04 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.04 |   0.04 |   0.06 |   0.06 |   0.06 |   0.08 |   0.03 |   0.04 |   0.00 |   0.00 |
|     ag |   2.22 |   2.22 |   1.72 |   2.17 |   2.18 |   1.67 |   1.33 |   1.28 |   1.33 |   1.28 |
|  ggrep |   1.37 |   1.38 |   2.70 |   1.53 |   1.49 |   3.36 |   1.34 |   1.46 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.09 |   0.09 |   0.09 |   0.09 |   0.09 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.08 |   0.13 |   5.14 |   0.15 |   0.15 |   0.95 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.02 |   2.02 |
|  ggrep |   0.11 |   0.19 |   7.43 |   0.70 |   1.16 |  15.58 |   0.04 |   1.00 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.54 |   0.54 |   0.54 |   0.04 |   0.53 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.39 | *fail* | *fail* | *fail* |   0.14 | *fail* |   0.14 | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.55 |   2.87 |   2.89 |   0.05 |   2.82 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.09 |   0.19 |   0.02 |   0.05 |   0.00 |   0.00 |
|     rg |   0.03 |   0.04 |   0.05 |   0.04 |   0.14 |   0.37 |   0.02 |   0.11 |   0.00 |   0.00 |
|  ggrep |   0.08 |   0.10 |   0.13 |   0.11 |   0.52 |   2.31 |   0.07 |   0.47 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.07 |   0.07 |   0.07 |   0.08 |   0.08 |   0.07 |   0.08 |   0.00 |   0.00 |
|     rg |   0.11 |   0.11 |   0.11 |   0.12 |   7.46 |   7.48 |   0.11 |   7.47 |   0.00 |   0.00 |
|  ggrep |   0.63 |   0.65 |   0.65 |   0.65 |   0.31 |   0.35 |   0.63 |   0.29 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |   0.14 |   0.16 |   0.15 |   0.38 |   0.39 |   0.13 |   0.38 |   0.00 |   0.00 |
|     rg |   1.20 |   1.20 |   1.48 |   1.35 |  12.10 |  12.13 |   1.19 |  12.12 |   0.00 |   0.01 |
|  ggrep |   0.88 |   0.91 |   1.07 |   1.00 |   5.80 |   6.03 |   0.87 |   5.78 |   0.00 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.13 |   0.33 |   0.34 |   0.13 |   0.32 |   0.00 |   0.02 |
|     rg |   0.22 |   0.22 |   0.23 |   2.43 | 177.07 | 179.52 |   0.22 | 176.74 |   0.00 |   0.04 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.01 |   0.01 |   0.01 |
|     rg |   0.02 | *fail* | *fail* | *fail* |
|     ag |   0.33 | *fail* |   0.33 | *fail* |

## results for large text file search with replaced output

grepping `flop` elapsed real time (s)

| search | --replace=flip |
| -----: | -----: |
|  ugrep |   0.01 |
|     rg |   0.01 |

## results for large text file search with context

grepping `^$` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.12 |   0.13 |   0.13 |   0.15 |   0.13 |
|     rg |   0.11 |   0.12 |   0.12 |   0.66 |   0.67 |   0.66 |
|     ag |   0.48 |   0.58 |   0.59 | *fail* | *fail* | *fail* |
|  ggrep |   0.17 |   0.21 |   0.19 |   3.03 |   3.19 |   3.15 |

grepping `begin|end` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.06 |   0.10 |   0.12 |   0.15 |   0.12 |
|     rg |   0.05 |   0.05 |   0.06 |   0.14 |   0.15 |   0.14 |
|     ag |   0.99 |   1.08 |   1.10 |   0.72 |   0.83 |   0.82 |
|  ggrep |   0.22 |   0.23 |   0.25 |   0.77 |   0.82 |   0.78 |

## results for large long lines JSON file search

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     ag |   1.39 |   1.38 |   0.53 |   0.43 |   0.43 |   0.35 |   0.11 |   0.11 |   0.11 |   0.11 |
|  ggrep |   0.13 |   0.14 |   0.24 |   0.23 |   1.50 |   1.63 |   0.13 |   1.48 |   0.00 |   0.05 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |        |   0.02 |        |   0.03 |        |   0.03 |        |   0.03 |        |   0.02 |        |
|     rg |   0.09 |        |   0.09 |        |   0.09 |        |   0.08 |        |   0.09 |        |   0.09 |        |
|     ag |        |   0.07 |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.11 |        |   0.12 |        |   0.18 |        |   0.18 |        |   0.16 |        |   0.16 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.03 |        |
|     rg |   0.08 |        |   0.08 |        |   0.08 |        |   0.08 |        |   0.08 |        |   0.08 |        |
|     ag |        |   0.32 |        |   0.23 |        |   0.23 |        |   0.19 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.17 |        |   0.22 |        |   0.32 |        |   0.42 |        |   0.29 |        |   0.13 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.02 |        |   0.02 |        |   0.03 |        |   0.03 |        |
|     rg |   0.09 |        |   0.09 |        |   0.08 |        |   0.09 |        |   0.09 |        |   0.09 |        |
|     ag |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |
|  ggrep |        |   0.10 |        |   0.10 |        |   0.12 |        |   0.12 |        |   0.10 |        |   0.10 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.20 |        |   0.19 |        |   0.19 |        |   0.23 |        |   0.20 |        |
|     rg |   0.77 |        |   0.75 |        |   0.76 |        |   0.77 |        |   0.77 |        |   0.78 |        |
|     ag |        |   0.70 |        |   0.71 |        |   0.71 |        |   0.71 |        |   0.71 |        |   0.71 |
|  ggrep |        |   0.48 |        |   0.57 |        |   0.61 |        |   0.62 |        |   0.56 |        |   0.54 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.24 |        |   0.23 |        |   0.26 |        |   0.26 |        |   0.24 |        |   0.22 |        |
|     rg |   0.75 |        |   0.76 |        |   0.73 |        |   0.72 |        |   0.73 |        |   0.75 |        |
|     ag |        |   1.05 |        |   0.74 |        |   0.89 |        |   0.80 |        |   0.64 |        |   0.64 |
|  ggrep |        |   0.60 |        |   0.73 |        |   1.59 |        |   1.82 |        |   1.51 |        |   0.64 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |        |   0.19 |        |   0.19 |        |   0.20 |        |   0.22 |        |   0.19 |        |
|     rg |   0.77 |        |   0.77 |        |   0.74 |        |   0.75 |        |   0.74 |        |   0.77 |        |
|     ag |        |   0.67 |        |   0.68 |        |   0.66 |        |   0.66 |        |   0.66 |        |   0.66 |
|  ggrep |        |   0.63 |        |   0.69 |        |   0.88 |        |   0.88 |        |   0.82 |        |   0.78 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.20 |        |   0.19 |        |   0.20 |        |   0.23 |        |   0.20 |        |
|     rg |   0.76 |        |   0.77 |        |   0.77 |        |   0.77 |        |   0.77 |        |   0.77 |        |
|     ag |        |   0.66 |        |   0.70 |        |   0.70 |        |   0.71 |        |   0.70 |        |   0.70 |
|  ggrep |        |   0.59 |        |   0.59 |        |   0.77 |        |   0.77 |        |   0.71 |        |   0.64 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.97 |   1.97 |   1.97 |   2.00 |   0.28 |   0.28 |
|     rg |   1.99 |   1.99 |   1.99 |   2.00 |   0.27 |   0.27 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |   0.30 |   0.30 |   0.30 |   0.04 |   0.04 |
|     rg |   0.29 |   0.29 |   0.29 |   0.30 |   0.04 |   0.04 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.01 |   0.01 |
|     rg |   0.07 |   0.09 |   0.07 |   0.08 |   0.01 |   0.01 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.08 |   1.08 |   1.08 |   1.08 |   0.15 |   0.15 |
|     rg |   1.11 |   1.11 |   1.11 |   1.11 |   0.15 |   0.15 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.12 |   0.11 |   0.11 |   0.01 |   0.01 |
|     rg |   0.10 |   0.11 |   0.10 |   0.11 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |   0.20 |   0.21 |   0.21 |   0.20 |   0.20 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.07 |   0.07 |   0.08 |   0.06 |   0.07 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.20 |   0.20 |   0.19 |   0.19 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


