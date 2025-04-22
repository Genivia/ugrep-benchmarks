# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released.
Last update Sun Apr 20 08:54:08 EDT 2025

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

found ugrep 1564584 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 7.4.0 x86_64-apple-darwin21.6.0 +avx2; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli,7z,tar/pax/cpio/zip
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
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.02 |   0.02 |   0.02 |   0.00 |   0.01 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.01 |
|     ag |   0.67 |   0.66 |   0.40 |   0.34 |   0.34 |   0.35 |   0.10 |   0.10 |   0.10 |   0.10 |
|  ggrep |   0.11 |   0.13 |   0.14 |   0.15 |   0.52 |   0.52 |   0.10 |   0.51 |   0.00 |   0.08 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.08 |   0.13 |   0.08 |   0.10 |   0.18 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.07 |   0.09 |   0.18 |   0.11 |   0.13 |   0.31 |   0.04 |   0.07 |   0.00 |   0.00 |
|     ag |   3.70 |   3.69 |   1.11 |   3.60 |   3.60 |   1.06 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.13 |   0.17 |   0.72 |   0.34 |   0.86 |   3.85 |   0.09 |   0.73 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.03 |   0.05 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.40 |   0.41 |   0.41 |   0.41 |   0.15 |   0.16 |   0.15 |   0.16 |
|  ggrep |   0.21 |   0.22 |   0.22 |   0.32 |   0.29 |   0.29 |   0.20 |   0.28 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.06 |   0.07 |   0.06 |   0.05 |   0.06 |   0.01 |   0.00 |
|     rg |   0.04 |   0.04 |   0.04 |   0.06 |   0.06 |   0.06 |   0.04 |   0.06 |   0.00 |   0.00 |
|     ag |   0.44 |   0.44 |   0.39 |   0.41 |   0.40 |   0.39 |   0.15 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.35 |   0.36 |   0.38 |   0.40 |   0.83 |   0.84 |   0.34 |   0.84 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.10 |   0.10 |   0.11 |   0.12 |   0.11 |   0.07 |   0.12 |   0.00 |   0.00 |
|     rg |   0.16 |   0.17 |   0.21 |   0.17 |   0.19 |   0.19 |   0.13 |   0.18 |   0.00 |   0.00 |
|     ag |   1.83 |   1.83 |   0.70 |   0.48 |   0.47 |   0.42 |   0.20 |   0.15 |   0.20 |   0.15 |
|  ggrep |   0.88 |   0.90 |   1.28 |   1.12 |   3.18 |   3.21 |   0.81 |   3.17 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.04 |   0.12 |   0.21 |   0.02 |   0.11 |   0.00 |   0.00 |
|     ag |   0.74 |   0.74 |   0.52 |   0.73 |   1.75 |   1.20 |   0.23 |   0.85 |   0.22 |   0.84 |
|  ggrep |   0.26 |   0.27 |   0.33 |   0.28 |   1.70 |   3.28 |   0.25 |   1.58 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.06 |   0.03 |   0.05 |   0.01 |
|     rg |   0.02 |   0.02 |   0.02 |   0.03 |   0.14 |   0.14 |   0.02 |   0.14 |   0.00 |   0.02 |
|     ag |   0.34 |   0.35 |   0.34 |   0.23 |   0.41 |   0.41 |   0.13 |   0.17 |   0.14 |   0.17 |
|  ggrep |   0.31 |   0.32 |   0.32 |   0.32 |   2.45 |   2.44 |   0.31 |   2.42 |   0.04 |   0.29 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.05 |   0.04 |   0.04 |   0.01 |   0.01 |
|     rg |   0.04 |   0.05 |   0.05 |   0.04 |   0.12 |   0.23 |   0.03 |   0.10 |   0.01 |   0.00 |
|     ag |   1.61 |   1.61 |   0.86 |   1.56 |   1.57 |   0.87 |   0.46 |   0.48 |   0.46 |   0.48 |
|  ggrep |   1.12 |   1.13 |   3.18 |   1.25 |   1.54 |   3.67 |   1.04 |   1.43 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.07 |   0.04 |   0.12 |   0.11 |   0.03 |   0.11 |   0.00 |   0.00 |
|     ag |   1.86 |   1.88 |   0.64 |   0.42 |   0.43 |   0.42 |   0.15 |   0.17 |   0.15 |   0.17 |
|  ggrep |   0.11 |   0.13 |   0.32 |   0.36 |   1.62 |   1.62 |   0.09 |   1.60 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.13 |   0.20 |   0.13 |   0.14 |   0.14 |   0.04 |   0.13 |   0.00 |   0.00 |
|     rg |   0.15 |   0.25 |  10.03 |   0.27 |   0.26 |   1.72 |   0.08 |   0.10 |   0.00 |   0.00 |
|     ag |   4.26 |   4.26 |   4.26 |   2.26 |   2.26 |   2.25 |   4.03 |   2.02 |   4.01 |   2.03 |
|  ggrep |   0.20 |   0.35 |  16.64 |   1.59 |   2.85 |  36.71 |   0.06 |   2.41 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.04 |   0.04 |   0.04 |   0.07 |   0.07 |   0.07 |   0.04 |   0.07 |   0.00 |   0.00 |
|     ag |   0.40 |   0.40 |   0.39 |   0.39 |   0.40 |   0.39 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.05 |   0.07 |   0.07 |   0.08 |   0.10 |   0.11 |   0.05 |   0.08 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.07 |   0.06 |   0.07 |   0.07 |   0.07 |   0.05 |   0.06 |   0.02 |   0.02 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.80 |   0.80 |   0.55 |   0.80 |   0.80 |   0.55 |   0.16 |   0.16 |   0.16 |   0.16 |
|  ggrep |   5.64 |   5.67 |  11.55 |   5.78 |   5.95 |  12.01 |   5.58 |   5.88 |   0.01 |   0.01 |

grepping `[a-z]+-[a-z]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.05 |   0.06 |   0.07 |   0.07 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.06 |   0.07 |   0.09 |   0.09 |   0.09 |   0.12 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag |   2.12 |   2.10 |   0.92 |   2.14 |   2.14 |   0.95 |   0.38 |   0.41 |   0.38 |   0.40 |
|  ggrep |   2.72 |   2.75 |   5.19 |   3.03 |   2.96 |   6.46 |   2.58 |   2.80 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.16 |   0.16 |   0.16 |   0.16 |   0.16 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.15 |   0.25 |   9.95 |   0.26 |   0.27 |   1.69 |   0.09 |   0.10 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.06 |   1.18 |
|  ggrep |   0.20 |   0.35 |  16.40 |   1.54 |   2.73 |  34.45 |   0.07 |   2.26 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.06 |   0.06 |   0.06 |   0.06 |   0.05 |   0.04 |   0.03 |   0.00 |   0.00 |
|     rg |   0.06 |   0.08 |   0.09 |   0.77 |   0.76 |   0.77 |   0.05 |   0.73 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.37 | *fail* | *fail* | *fail* |   0.11 | *fail* |   0.11 | *fail* |
|  ggrep |   0.10 |   0.14 |   0.14 |   2.84 |   4.61 |   4.62 |   0.09 |   4.56 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.05 |   0.06 |   0.11 |   0.22 |   0.03 |   0.06 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.07 |   0.07 |   0.17 |   0.41 |   0.03 |   0.10 |   0.00 |   0.00 |
|  ggrep |   0.14 |   0.17 |   0.21 |   0.17 |   0.91 |   3.99 |   0.11 |   0.79 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.12 |   0.12 |   0.12 |   0.14 |   0.14 |   0.11 |   0.13 |   0.00 |   0.00 |
|     rg |   0.14 |   0.14 |   0.14 |   0.16 |  11.56 |  11.57 |   0.13 |  11.68 |   0.01 |   0.01 |
|  ggrep |   0.93 |   0.96 |   0.96 |   0.95 |   0.42 |   0.48 |   0.93 |   0.40 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.24 |   0.24 |   0.25 |   0.25 |   0.52 |   0.51 |   0.21 |   0.50 |   0.00 |   0.01 |
|     rg |   0.20 |   0.21 |   0.23 |   0.22 |  19.08 |  19.08 |   0.17 |  19.20 |   0.00 |   0.03 |
|  ggrep |   1.37 |   1.41 |   1.62 |   1.48 |   9.33 |   9.66 |   1.32 |   9.77 |   0.00 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.19 |   0.20 |   0.41 |   0.41 |   0.17 |   0.38 |   0.01 |   0.02 |
|     rg |   0.28 |   0.29 |   0.30 |   3.96 | 367.69 | 372.69 |   0.26 | 367.51 |   0.01 |   0.11 |
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
|  ugrep |   0.18 |   0.18 |   0.19 |   0.20 |   0.23 |   0.20 |
|     rg |   0.18 |   0.19 |   0.20 |   0.97 |   1.01 |   0.99 |
|     ag |   0.56 |   0.77 |   0.78 | *fail* | *fail* | *fail* |
|  ggrep |   0.30 |   0.34 |   0.34 |   5.07 |   5.39 |   5.31 |

grepping `begin|end` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.10 |   0.15 |   0.18 |   0.23 |   0.19 |
|     rg |   0.10 |   0.09 |   0.11 |   0.23 |   0.24 |   0.24 |
|     ag |   1.51 |   1.69 |   1.72 |   0.99 |   1.25 |   1.20 |
|  ggrep |   0.34 |   0.34 |   0.37 |   1.25 |   1.34 |   1.29 |

## results for large long lines JSON file search

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.03 |   0.04 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.01 |
|     rg |   0.04 |   0.03 |   0.02 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     ag |   2.72 |   2.73 |   0.72 |   0.57 |   0.57 |   0.37 |   0.10 |   0.11 |   0.10 |   0.11 |
|  ggrep |   0.19 |   0.19 |   0.35 |   0.35 |   2.12 |   2.29 |   0.17 |   2.11 |   0.00 |   0.07 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.07 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.17 |        |   0.18 |        |   0.26 |        |   0.25 |        |   0.25 |        |   0.25 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |
|     rg |   0.07 |        |   0.06 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.06 |        |
|     ag |        |   0.51 |        |   0.35 |        |   0.36 |        |   0.24 |        |   0.09 |        |   0.09 |
|  ggrep |        |   0.27 |        |   0.34 |        |   0.52 |        |   0.71 |        |   0.46 |        |   0.22 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.16 |        |   0.15 |        |   0.18 |        |   0.17 |        |   0.17 |        |   0.15 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.25 |        |   0.26 |        |   0.26 |        |   0.26 |        |   0.27 |        |   0.25 |        |
|     rg |   0.26 |        |   0.26 |        |   0.26 |        |   0.26 |        |   0.26 |        |   0.26 |        |
|     ag |        |   0.42 |        |   0.43 |        |   0.43 |        |   0.40 |        |   0.42 |        |   0.40 |
|  ggrep |        |   0.78 |        |   0.92 |        |   0.98 |        |   0.99 |        |   0.96 |        |   0.93 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.29 |        |   0.27 |        |   0.30 |        |   0.30 |        |   0.28 |        |   0.26 |        |
|     rg |   0.33 |        |   0.31 |        |   0.34 |        |   0.35 |        |   0.32 |        |   0.30 |        |
|     ag |        |   1.41 |        |   0.82 |        |   1.08 |        |   0.86 |        |   0.49 |        |   0.49 |
|  ggrep |        |   1.01 |        |   1.19 |        |   2.61 |        |   3.00 |        |   2.50 |        |   1.08 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |        |   0.25 |        |   0.26 |        |   0.26 |        |   0.27 |        |   0.25 |        |
|     rg |   0.26 |        |   0.26 |        |   0.27 |        |   0.26 |        |   0.27 |        |   0.26 |        |
|     ag |        |   0.43 |        |   0.40 |        |   0.43 |        |   0.44 |        |   0.42 |        |   0.42 |
|  ggrep |        |   0.96 |        |   1.03 |        |   1.33 |        |   1.32 |        |   1.30 |        |   1.22 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |        |   0.26 |        |   0.26 |        |   0.26 |        |   0.27 |        |   0.26 |        |
|     rg |   0.29 |        |   0.26 |        |   0.26 |        |   0.27 |        |   0.27 |        |   0.26 |        |
|     ag |        |   0.53 |        |   0.45 |        |   0.46 |        |   0.45 |        |   0.40 |        |   0.39 |
|  ggrep |        |   0.90 |        |   0.88 |        |   1.18 |        |   1.18 |        |   1.13 |        |   1.03 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.23 |   3.23 |   3.24 |   3.23 |   0.47 |   0.47 |
|     rg |   3.35 |   3.34 |   3.35 |   3.33 |   0.46 |   0.47 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.51 |   0.51 |   0.51 |   0.52 |   0.08 |   0.07 |
|     rg |   0.42 |   0.41 |   0.45 |   0.41 |   0.06 |   0.06 |
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
|  ugrep |   1.44 |   1.44 |   1.53 |   1.53 |   0.23 |   0.22 |
|     rg |   1.46 |   1.58 |   1.60 |   1.57 |   0.23 |   0.22 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.18 |   0.19 |   0.18 |   0.18 |   0.03 |   0.03 |
|     rg |   0.16 |   0.16 |   0.16 |   0.16 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.32 |   0.32 |   0.33 |   0.33 |   0.32 |   0.32 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.12 |   0.12 |   0.13 |   0.11 |   0.12 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.34 |   0.34 |   0.36 |   0.35 |   0.34 |   0.34 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1367410 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 7.4.0 aarch64-apple-darwin21.6.0 +neon/AArch64; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli,7z,tar/pax/cpio/zip
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
|  ugrep |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     ag |   0.54 |   0.53 |   0.43 |   0.40 |   0.40 |   0.40 |   0.16 |   0.17 |   0.16 |   0.16 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.37 |   0.37 |   0.10 |   0.35 |   0.00 |   0.05 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.08 |   0.05 |   0.06 |   0.12 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.11 |   0.06 |   0.08 |   0.18 |   0.02 |   0.05 |   0.00 |   0.00 |
|     ag |   1.94 |   1.94 |   0.84 |   1.89 |   1.89 |   0.81 |   0.20 |   0.21 |   0.21 |   0.21 |
|  ggrep |   0.10 |   0.13 |   0.40 |   0.23 |   0.50 |   2.21 |   0.08 |   0.44 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     ag |   0.52 |   0.52 |   0.52 |   0.50 |   0.50 |   0.50 |   0.28 |   0.26 |   0.28 |   0.26 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.15 |   0.22 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.02 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.02 |   0.04 |   0.00 |   0.00 |
|     ag |   0.43 |   0.44 |   0.41 |   0.41 |   0.41 |   0.40 |   0.17 |   0.16 |   0.17 |   0.17 |
|  ggrep |   0.25 |   0.27 |   0.28 |   0.30 |   0.58 |   0.58 |   0.25 |   0.56 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.07 |   0.07 |   0.08 |   0.08 |   0.08 |   0.05 |   0.08 |   0.00 |   0.00 |
|     rg |   0.13 |   0.14 |   0.19 |   0.11 |   0.12 |   0.13 |   0.13 |   0.12 |   0.00 |   0.00 |
|     ag |   1.16 |   1.16 |   0.68 |   0.46 |   0.46 |   0.43 |   0.31 |   0.18 |   0.32 |   0.19 |
|  ggrep |   0.49 |   0.51 |   0.72 |   0.64 |   1.82 |   1.86 |   0.48 |   1.80 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.01 |   0.02 |   0.02 |   0.02 |   0.09 |   0.16 |   0.01 |   0.08 |   0.00 |   0.00 |
|     ag |   0.62 |   0.62 |   0.54 |   0.64 |   2.18 |   1.95 |   0.27 |   1.66 |   0.27 |   1.66 |
|  ggrep |   0.16 |   0.18 |   0.21 |   0.18 |   0.97 |   1.90 |   0.16 |   0.95 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.01 |   0.01 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.01 |   0.02 |   0.02 |   0.02 |   0.11 |   0.11 |   0.01 |   0.11 |   0.00 |   0.01 |
|     ag |   0.40 |   0.39 |   0.39 |   0.28 |   1.54 |   1.54 |   0.19 |   1.31 |   0.19 |   1.31 |
|  ggrep |   0.19 |   0.21 |   0.21 |   0.21 |   1.42 |   1.42 |   0.19 |   1.40 |   0.02 |   0.16 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.04 |   0.04 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.09 |   0.18 |   0.02 |   0.08 |   0.00 |   0.00 |
|     ag |   3.33 |   3.32 |   3.00 |   2.28 |   2.28 |   2.00 |   2.69 |   1.68 |   2.69 |   1.69 |
|  ggrep |   0.57 |   0.59 |   1.66 |   0.65 |   0.86 |   2.04 |   0.56 |   0.84 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.03 |   0.04 |   0.04 |   0.03 |   0.08 |   0.08 |   0.02 |   0.08 |   0.00 |   0.00 |
|     ag |   1.08 |   1.07 |   0.55 |   0.45 |   0.45 |   0.45 |   0.19 |   0.21 |   0.18 |   0.21 |
|  ggrep |   0.08 |   0.11 |   0.20 |   0.21 |   1.05 |   1.06 |   0.07 |   1.03 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.09 |   0.14 |   0.09 |   0.11 |   0.11 |   0.03 |   0.10 |   0.00 |   0.00 |
|     rg |   0.08 |   0.13 |   5.13 |   0.15 |   0.16 |   0.97 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag |   3.93 |   4.05 |   3.99 |   3.05 |   3.07 |   3.01 |   3.73 |   2.79 |   3.77 |   2.79 |
|  ggrep |   0.11 |   0.18 |   7.59 |   0.72 |   1.29 |  16.83 |   0.04 |   1.12 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.05 |   0.03 |   0.05 |   0.00 |   0.00 |
|     ag |   0.37 |   0.38 |   0.37 |   0.37 |   0.36 |   0.36 |   0.13 |   0.12 |   0.13 |   0.12 |
|  ggrep |   0.04 |   0.06 |   0.06 |   0.07 |   0.07 |   0.08 |   0.04 |   0.06 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.05 |   0.04 |   0.03 |   0.04 |   0.00 |   0.01 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.61 |   0.60 |   0.50 |   0.59 |   0.60 |   0.50 |   0.19 |   0.19 |   0.19 |   0.19 |
|  ggrep |   3.40 |   3.42 |   6.95 |   3.53 |   3.67 |   7.42 |   3.39 |   3.64 |   0.00 |   0.00 |

grepping `[a-z]+-[a-z]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.05 |   0.05 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.06 |   0.06 |   0.08 |   0.03 |   0.04 |   0.00 |   0.00 |
|     ag |   2.22 |   2.22 |   1.72 |   2.17 |   2.17 |   1.68 |   1.33 |   1.29 |   1.33 |   1.28 |
|  ggrep |   1.36 |   1.38 |   2.70 |   1.53 |   1.49 |   3.38 |   1.35 |   1.45 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.09 |   0.09 |   0.09 |   0.09 |   0.09 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.08 |   0.14 |   5.24 |   0.15 |   0.15 |   0.95 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.02 |   2.02 |
|  ggrep |   0.11 |   0.19 |   7.43 |   0.70 |   1.16 |  15.27 |   0.04 |   1.00 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.54 |   0.54 |   0.54 |   0.04 |   0.52 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.39 | *fail* | *fail* | *fail* |   0.14 | *fail* |   0.15 | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.55 |   2.86 |   2.88 |   0.05 |   2.82 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.09 |   0.18 |   0.02 |   0.05 |   0.00 |   0.00 |
|     rg |   0.03 |   0.04 |   0.05 |   0.05 |   0.15 |   0.37 |   0.02 |   0.11 |   0.00 |   0.00 |
|  ggrep |   0.08 |   0.10 |   0.13 |   0.11 |   0.53 |   2.31 |   0.07 |   0.47 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.09 |   0.09 |   0.11 |   0.11 |   0.09 |   0.11 |   0.00 |   0.00 |
|     rg |   0.11 |   0.11 |   0.11 |   0.12 |   7.47 |   7.48 |   0.11 |   7.47 |   0.00 |   0.00 |
|  ggrep |   0.63 |   0.65 |   0.66 |   0.65 |   0.32 |   0.35 |   0.63 |   0.30 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.15 |   0.14 |   0.32 |   0.32 |   0.12 |   0.31 |   0.00 |   0.00 |
|     rg |   1.20 |   1.21 |   1.48 |   1.35 |  12.10 |  12.13 |   1.19 |  12.11 |   0.00 |   0.01 |
|  ggrep |   0.88 |   0.90 |   1.07 |   1.00 |   5.83 |   6.04 |   0.87 |   5.85 |   0.00 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |   0.14 |   0.14 |   0.14 |   0.26 |   0.28 |   0.13 |   0.26 |   0.00 |   0.00 |
|     rg |   0.22 |   0.22 |   0.23 |   2.43 | 176.28 | 179.12 |   0.21 | 177.28 |   0.00 |   0.04 |
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
|  ggrep |   0.17 |   0.21 |   0.19 |   3.03 |   3.19 |   3.14 |

grepping `begin|end` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.06 |   0.10 |   0.12 |   0.15 |   0.12 |
|     rg |   0.05 |   0.05 |   0.07 |   0.14 |   0.15 |   0.14 |
|     ag |   0.98 |   1.08 |   1.10 |   0.73 |   0.84 |   0.82 |
|  ggrep |   0.22 |   0.23 |   0.25 |   0.77 |   0.81 |   0.78 |

## results for large long lines JSON file search

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     ag |   1.39 |   1.39 |   0.53 |   0.43 |   0.43 |   0.35 |   0.11 |   0.11 |   0.11 |   0.11 |
|  ggrep |   0.13 |   0.14 |   0.24 |   0.23 |   1.49 |   1.62 |   0.13 |   1.48 |   0.00 |   0.05 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.09 |        |   0.09 |        |   0.09 |        |   0.09 |        |   0.09 |        |   0.08 |        |
|     ag |        |   0.07 |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.11 |        |   0.13 |        |   0.18 |        |   0.18 |        |   0.16 |        |   0.16 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.03 |        |
|     rg |   0.08 |        |   0.09 |        |   0.08 |        |   0.08 |        |   0.09 |        |   0.08 |        |
|     ag |        |   0.32 |        |   0.23 |        |   0.23 |        |   0.19 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.17 |        |   0.22 |        |   0.32 |        |   0.43 |        |   0.29 |        |   0.13 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.09 |        |   0.09 |        |   0.09 |        |   0.08 |        |   0.09 |        |   0.09 |        |
|     ag |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |
|  ggrep |        |   0.10 |        |   0.11 |        |   0.12 |        |   0.12 |        |   0.10 |        |   0.10 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |        |   0.19 |        |   0.19 |        |   0.19 |        |   0.23 |        |   0.19 |        |
|     rg |   0.76 |        |   0.78 |        |   0.77 |        |   0.77 |        |   0.77 |        |   0.78 |        |
|     ag |        |   0.70 |        |   0.71 |        |   0.70 |        |   0.70 |        |   0.71 |        |   0.71 |
|  ggrep |        |   0.50 |        |   0.58 |        |   0.62 |        |   0.63 |        |   0.57 |        |   0.55 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.24 |        |   0.22 |        |   0.26 |        |   0.26 |        |   0.25 |        |   0.23 |        |
|     rg |   0.76 |        |   0.75 |        |   0.73 |        |   0.72 |        |   0.73 |        |   0.75 |        |
|     ag |        |   1.06 |        |   0.75 |        |   0.89 |        |   0.80 |        |   0.64 |        |   0.64 |
|  ggrep |        |   0.61 |        |   0.77 |        |   1.60 |        |   1.83 |        |   1.52 |        |   0.65 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.20 |        |   0.20 |        |   0.20 |        |   0.23 |        |   0.20 |        |
|     rg |   0.77 |        |   0.77 |        |   0.74 |        |   0.76 |        |   0.76 |        |   0.75 |        |
|     ag |        |   0.67 |        |   0.68 |        |   0.65 |        |   0.66 |        |   0.66 |        |   0.66 |
|  ggrep |        |   0.64 |        |   0.70 |        |   0.89 |        |   0.89 |        |   0.84 |        |   0.79 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.20 |        |   0.20 |        |   0.20 |        |   0.22 |        |   0.20 |        |
|     rg |   0.76 |        |   0.77 |        |   0.77 |        |   0.77 |        |   0.76 |        |   0.76 |        |
|     ag |        |   0.67 |        |   0.70 |        |   0.70 |        |   0.70 |        |   0.69 |        |   0.70 |
|  ggrep |        |   0.59 |        |   0.60 |        |   0.78 |        |   0.79 |        |   0.72 |        |   0.65 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.98 |   1.97 |   1.97 |   1.98 |   0.28 |   0.28 |
|     rg |   1.99 |   2.00 |   1.99 |   2.00 |   0.27 |   0.27 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |   0.30 |   0.30 |   0.30 |   0.04 |   0.04 |
|     rg |   0.29 |   0.29 |   0.29 |   0.29 |   0.04 |   0.04 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.01 |   0.01 |
|     rg |   0.07 |   0.08 |   0.07 |   0.08 |   0.01 |   0.01 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.08 |   1.08 |   1.08 |   1.08 |   0.15 |   0.15 |
|     rg |   1.12 |   1.11 |   1.11 |   1.11 |   0.15 |   0.15 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.12 |   0.11 |   0.12 |   0.01 |   0.01 |
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
|  ugrep |   0.07 |   0.07 |   0.08 |   0.08 |   0.06 |   0.07 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.20 |   0.20 |   0.19 |   0.19 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


