# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released.
Last update Mon Feb 03 19:06:19 EST 2025

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

found ugrep 1562544 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 7.2.2 x86_64-apple-darwin21.6.0 +avx2; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli,7z,tar/pax/cpio/zip
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
|     ag |   0.69 |   0.66 |   0.41 |   0.35 |   0.35 |   0.35 |   0.10 |   0.10 |   0.10 |   0.10 |
|  ggrep |   0.11 |   0.13 |   0.14 |   0.15 |   0.52 |   0.53 |   0.11 |   0.52 |   0.00 |   0.08 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.08 |   0.13 |   0.08 |   0.10 |   0.18 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.06 |   0.09 |   0.17 |   0.11 |   0.13 |   0.31 |   0.04 |   0.07 |   0.00 |   0.00 |
|     ag |   3.77 |   3.74 |   1.12 |   3.64 |   3.62 |   1.08 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.13 |   0.17 |   0.70 |   0.35 |   0.88 |   3.96 |   0.09 |   0.74 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.03 |   0.05 |   0.00 |   0.00 |
|     ag |   0.42 |   0.42 |   0.42 |   0.42 |   0.42 |   0.41 |   0.16 |   0.17 |   0.15 |   0.16 |
|  ggrep |   0.22 |   0.23 |   0.23 |   0.33 |   0.29 |   0.30 |   0.21 |   0.28 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.06 |   0.05 |   0.06 |   0.00 |   0.01 |
|     rg |   0.04 |   0.04 |   0.04 |   0.06 |   0.06 |   0.06 |   0.04 |   0.06 |   0.00 |   0.00 |
|     ag |   0.45 |   0.44 |   0.40 |   0.40 |   0.41 |   0.39 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.36 |   0.38 |   0.38 |   0.41 |   0.85 |   0.85 |   0.34 |   0.84 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.10 |   0.10 |   0.11 |   0.11 |   0.07 |   0.10 |   0.00 |   0.00 |
|     rg |   0.15 |   0.16 |   0.22 |   0.17 |   0.20 |   0.20 |   0.13 |   0.19 |   0.00 |   0.00 |
|     ag |   1.87 |   1.86 |   0.70 |   0.49 |   0.48 |   0.41 |   0.20 |   0.15 |   0.20 |   0.15 |
|  ggrep |   0.88 |   0.91 |   1.30 |   1.15 |   3.20 |   3.27 |   0.83 |   3.17 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.04 |   0.04 |   0.03 |   0.03 |   0.00 |   0.01 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.13 |   0.21 |   0.02 |   0.11 |   0.00 |   0.00 |
|     ag |   0.75 |   0.75 |   0.53 |   0.74 |   1.77 |   1.22 |   0.23 |   0.85 |   0.22 |   0.86 |
|  ggrep |   0.26 |   0.28 |   0.33 |   0.28 |   1.73 |   3.34 |   0.25 |   1.62 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.01 |   0.01 |
|     rg |   0.02 |   0.02 |   0.02 |   0.03 |   0.14 |   0.15 |   0.02 |   0.14 |   0.00 |   0.02 |
|     ag |   0.35 |   0.35 |   0.35 |   0.23 |   0.42 |   0.41 |   0.13 |   0.17 |   0.14 |   0.17 |
|  ggrep |   0.31 |   0.34 |   0.33 |   0.32 |   2.47 |   2.49 |   0.34 |   2.48 |   0.04 |   0.29 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.04 |   0.04 |   0.01 |   0.01 |
|     rg |   0.04 |   0.05 |   0.05 |   0.04 |   0.12 |   0.24 |   0.03 |   0.10 |   0.01 |   0.00 |
|     ag |   1.63 |   1.63 |   0.87 |   1.58 |   1.58 |   0.88 |   0.46 |   0.48 |   0.47 |   0.49 |
|  ggrep |   1.12 |   1.14 |   3.22 |   1.26 |   1.55 |   3.68 |   1.05 |   1.45 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.01 |   0.00 |
|     rg |   0.05 |   0.06 |   0.07 |   0.04 |   0.12 |   0.12 |   0.03 |   0.11 |   0.00 |   0.00 |
|     ag |   1.89 |   1.87 |   0.65 |   0.43 |   0.43 |   0.42 |   0.15 |   0.17 |   0.15 |   0.17 |
|  ggrep |   0.11 |   0.13 |   0.33 |   0.34 |   1.65 |   1.66 |   0.09 |   1.62 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.13 |   0.21 |   0.11 |   0.13 |   0.13 |   0.04 |   0.12 |   0.00 |   0.00 |
|     rg |   0.15 |   0.25 |  10.17 |   0.27 |   0.26 |   1.73 |   0.09 |   0.10 |   0.00 |   0.00 |
|     ag |   4.27 |   4.32 |   4.42 |   2.30 |   2.33 |   2.34 |   4.06 |   2.05 |   4.07 |   2.05 |
|  ggrep |   0.20 |   0.36 |  16.85 |   1.58 |   2.91 |  37.30 |   0.07 |   2.49 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.05 |   0.07 |   0.08 |   0.08 |   0.04 |   0.07 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.39 |   0.40 |   0.41 |   0.39 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.05 |   0.07 |   0.08 |   0.09 |   0.10 |   0.11 |   0.05 |   0.08 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.07 |   0.07 |   0.07 |   0.05 |   0.06 |   0.02 |   0.02 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.81 |   0.81 |   0.59 |   0.80 |   0.81 |   0.56 |   0.16 |   0.17 |   0.16 |   0.16 |
|  ggrep |   5.75 |   5.76 |  11.66 |   5.88 |   6.05 |  12.20 |   5.68 |   5.96 |   0.01 |   0.01 |

grepping `[a-z]+-[a-z]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.06 |   0.07 |   0.07 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.06 |   0.07 |   0.09 |   0.09 |   0.10 |   0.12 |   0.05 |   0.07 |   0.00 |   0.00 |
|     ag |   2.12 |   2.12 |   0.94 |   2.16 |   2.17 |   0.97 |   0.38 |   0.42 |   0.38 |   0.42 |
|  ggrep |   2.73 |   2.77 |   5.29 |   3.12 |   2.99 |   6.58 |   2.61 |   2.85 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.15 |   0.15 |   0.15 |   0.16 |   0.16 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.15 |   0.25 |  10.16 |   0.26 |   0.26 |   1.70 |   0.09 |   0.10 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.06 |   1.20 |
|  ggrep |   0.20 |   0.35 |  17.36 |   1.54 |   2.69 |  34.98 |   0.07 |   2.26 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.06 |   0.08 |   0.09 |   0.79 |   0.80 |   0.78 |   0.05 |   0.74 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.38 | *fail* | *fail* | *fail* |   0.11 | *fail* |   0.11 | *fail* |
|  ggrep |   0.10 |   0.14 |   0.15 |   2.87 |   4.68 |   4.71 |   0.09 |   4.64 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.05 |   0.06 |   0.11 |   0.22 |   0.03 |   0.06 |   0.01 |   0.00 |
|     rg |   0.05 |   0.06 |   0.07 |   0.07 |   0.16 |   0.42 |   0.03 |   0.10 |   0.00 |   0.00 |
|  ggrep |   0.13 |   0.16 |   0.21 |   0.17 |   0.93 |   4.17 |   0.11 |   0.80 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.12 |   0.12 |   0.12 |   0.14 |   0.14 |   0.12 |   0.14 |   0.00 |   0.01 |
|     rg |   0.14 |   0.15 |   0.15 |   0.16 |  11.81 |  11.84 |   0.13 |  11.96 |   0.01 |   0.01 |
|  ggrep |   0.94 |   0.97 |   0.98 |   0.97 |   0.43 |   0.48 |   0.95 |   0.40 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.24 |   0.24 |   0.26 |   0.25 |   0.49 |   0.48 |   0.22 |   0.48 |   0.00 |   0.01 |
|     rg |   0.20 |   0.21 |   0.24 |   0.22 |  20.64 |  20.67 |   0.18 |  19.33 |   0.00 |   0.03 |
|  ggrep |   1.38 |   1.41 |   1.65 |   1.51 |   9.45 |   9.80 |   1.33 |   9.47 |   0.00 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.19 |   0.20 |   0.39 |   0.40 |   0.18 |   0.37 |   0.01 |   0.02 |
|     rg |   0.28 |   0.28 |   0.30 |   4.11 | 374.03 | 378.12 |   0.26 | 373.19 |   0.01 |   0.11 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |
|     rg |   0.03 | *fail* | *fail* | *fail* |
|     ag |   0.40 | *fail* |   0.40 | *fail* |

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
|  ugrep |   0.17 |   0.18 |   0.20 |   0.20 |   0.23 |   0.21 |
|     rg |   0.18 |   0.20 |   0.21 |   1.00 |   1.01 |   0.99 |
|     ag |   0.56 |   0.77 |   0.78 | *fail* | *fail* | *fail* |
|  ggrep |   0.30 |   0.34 |   0.35 |   5.15 |   5.40 |   5.35 |

grepping `begin|end` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.09 |   0.15 |   0.18 |   0.22 |   0.19 |
|     rg |   0.08 |   0.09 |   0.11 |   0.23 |   0.24 |   0.24 |
|     ag |   1.54 |   1.71 |   1.76 |   1.00 |   1.26 |   1.22 |
|  ggrep |   0.33 |   0.35 |   0.38 |   1.26 |   1.32 |   1.29 |

## results for large long lines JSON file search

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.03 |   0.04 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.01 |
|     rg |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     ag |   2.76 |   2.75 |   0.73 |   0.57 |   0.57 |   0.54 |   0.10 |   0.11 |   0.10 |   0.11 |
|  ggrep |   0.19 |   0.19 |   0.36 |   0.36 |   2.15 |   2.46 |   0.17 |   2.17 |   0.00 |   0.08 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.07 |
|  ggrep |        |   0.17 |        |   0.18 |        |   0.26 |        |   0.25 |        |   0.25 |        |   0.24 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |
|     rg |   0.07 |        |   0.06 |        |   0.07 |        |   0.07 |        |   0.06 |        |   0.06 |        |
|     ag |        |   0.51 |        |   0.35 |        |   0.35 |        |   0.24 |        |   0.09 |        |   0.09 |
|  ggrep |        |   0.27 |        |   0.34 |        |   0.53 |        |   0.72 |        |   0.47 |        |   0.22 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |
|     ag |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.15 |        |   0.15 |        |   0.18 |        |   0.18 |        |   0.16 |        |   0.16 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |        |   0.26 |        |   0.27 |        |   0.27 |        |   0.29 |        |   0.27 |        |
|     rg |   0.27 |        |   0.27 |        |   0.28 |        |   0.27 |        |   0.27 |        |   0.28 |        |
|     ag |        |   0.42 |        |   0.42 |        |   0.40 |        |   0.40 |        |   0.40 |        |   0.42 |
|  ggrep |        |   0.78 |        |   0.91 |        |   1.01 |        |   1.00 |        |   0.97 |        |   0.93 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |        |   0.29 |        |   0.32 |        |   0.30 |        |   0.30 |        |   0.27 |        |
|     rg |   0.34 |        |   0.33 |        |   0.36 |        |   0.36 |        |   0.34 |        |   0.33 |        |
|     ag |        |   1.41 |        |   0.81 |        |   1.08 |        |   0.85 |        |   0.51 |        |   0.49 |
|  ggrep |        |   1.00 |        |   1.20 |        |   2.67 |        |   3.03 |        |   2.53 |        |   1.10 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |        |   0.28 |        |   0.27 |        |   0.26 |        |   0.28 |        |   0.26 |        |
|     rg |   0.27 |        |   0.27 |        |   0.28 |        |   0.28 |        |   0.28 |        |   0.28 |        |
|     ag |        |   0.43 |        |   0.42 |        |   0.41 |        |   0.44 |        |   0.42 |        |   0.42 |
|  ggrep |        |   1.02 |        |   1.08 |        |   1.39 |        |   1.36 |        |   1.33 |        |   1.23 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.27 |        |   0.26 |        |   0.27 |        |   0.27 |        |   0.29 |        |   0.26 |        |
|     rg |   0.32 |        |   0.27 |        |   0.28 |        |   0.28 |        |   0.28 |        |   0.27 |        |
|     ag |        |   0.51 |        |   0.44 |        |   0.47 |        |   0.46 |        |   0.41 |        |   0.43 |
|  ggrep |        |   0.90 |        |   0.89 |        |   1.21 |        |   1.21 |        |   1.17 |        |   1.04 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.28 |   3.30 |   3.30 |   3.28 |   0.47 |   0.48 |
|     rg |   3.43 |   3.40 |   3.37 |   3.38 |   0.46 |   0.46 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.51 |   0.52 |   0.53 |   0.53 |   0.08 |   0.08 |
|     rg |   0.41 |   0.41 |   0.41 |   0.41 |   0.06 |   0.06 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.09 |   0.09 |   0.02 |   0.02 |
|     rg |   0.11 |   0.13 |   0.11 |   0.13 |   0.03 |   0.03 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.43 |   1.44 |   1.44 |   1.43 |   0.21 |   0.21 |
|     rg |   1.50 |   1.49 |   1.50 |   1.50 |   0.21 |   0.21 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.17 |   0.17 |   0.18 |   0.17 |   0.03 |   0.03 |
|     rg |   0.16 |   0.16 |   0.15 |   0.16 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.32 |   0.32 |   0.32 |   0.32 |   0.32 |   0.32 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.12 |   0.12 |   0.13 |   0.11 |   0.11 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.34 |   0.34 |   0.35 |   0.35 |   0.34 |   0.34 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1356802 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 7.2.2 aarch64-apple-darwin21.6.0 +neon/AArch64; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli,7z,tar/pax/cpio/zip
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
|     ag |   0.54 |   0.54 |   0.43 |   0.40 |   0.40 |   0.40 |   0.17 |   0.17 |   0.17 |   0.16 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.37 |   0.37 |   0.10 |   0.35 |   0.00 |   0.05 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.08 |   0.05 |   0.06 |   0.12 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.11 |   0.06 |   0.08 |   0.18 |   0.02 |   0.05 |   0.00 |   0.00 |
|     ag |   1.94 |   1.94 |   0.84 |   1.89 |   1.89 |   0.81 |   0.21 |   0.21 |   0.21 |   0.21 |
|  ggrep |   0.10 |   0.13 |   0.40 |   0.23 |   0.50 |   2.22 |   0.08 |   0.45 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     ag |   0.52 |   0.52 |   0.52 |   0.50 |   0.50 |   0.50 |   0.28 |   0.26 |   0.28 |   0.27 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.15 |   0.22 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.04 |   0.04 |   0.05 |   0.02 |   0.04 |   0.00 |   0.00 |
|     ag |   0.44 |   0.44 |   0.41 |   0.41 |   0.41 |   0.41 |   0.17 |   0.17 |   0.18 |   0.17 |
|  ggrep |   0.25 |   0.27 |   0.28 |   0.30 |   0.58 |   0.59 |   0.25 |   0.56 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.07 |   0.07 |   0.08 |   0.08 |   0.05 |   0.08 |   0.00 |   0.00 |
|     rg |   0.14 |   0.14 |   0.18 |   0.11 |   0.13 |   0.13 |   0.13 |   0.12 |   0.00 |   0.00 |
|     ag |   1.17 |   1.16 |   0.69 |   0.46 |   0.46 |   0.43 |   0.32 |   0.19 |   0.32 |   0.19 |
|  ggrep |   0.49 |   0.51 |   0.72 |   0.64 |   1.82 |   1.86 |   0.48 |   1.79 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.03 |   0.03 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.02 |   0.02 |   0.02 |   0.02 |   0.09 |   0.16 |   0.01 |   0.08 |   0.00 |   0.00 |
|     ag |   0.63 |   0.63 |   0.54 |   0.64 |   2.19 |   1.95 |   0.27 |   1.66 |   0.27 |   1.65 |
|  ggrep |   0.16 |   0.18 |   0.21 |   0.18 |   0.97 |   1.90 |   0.16 |   0.95 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.01 |   0.01 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.01 |   0.02 |   0.02 |   0.02 |   0.11 |   0.11 |   0.01 |   0.11 |   0.00 |   0.01 |
|     ag |   0.39 |   0.39 |   0.39 |   0.28 |   1.54 |   1.54 |   0.20 |   1.31 |   0.19 |   1.32 |
|  ggrep |   0.19 |   0.21 |   0.21 |   0.21 |   1.42 |   1.42 |   0.19 |   1.40 |   0.02 |   0.16 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.04 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.02 |   0.03 |   0.03 |   0.03 |   0.09 |   0.18 |   0.02 |   0.08 |   0.00 |   0.00 |
|     ag |   3.33 |   3.34 |   3.00 |   2.30 |   2.29 |   2.00 |   2.69 |   1.69 |   2.69 |   1.69 |
|  ggrep |   0.58 |   0.59 |   1.67 |   0.65 |   0.86 |   2.05 |   0.56 |   0.84 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.01 |   0.02 |   0.00 |   0.00 |
|     rg |   0.03 |   0.04 |   0.04 |   0.03 |   0.08 |   0.08 |   0.02 |   0.08 |   0.00 |   0.00 |
|     ag |   1.07 |   1.07 |   0.56 |   0.46 |   0.46 |   0.45 |   0.18 |   0.21 |   0.19 |   0.21 |
|  ggrep |   0.08 |   0.10 |   0.20 |   0.21 |   1.05 |   1.06 |   0.07 |   1.03 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.09 |   0.13 |   0.09 |   0.10 |   0.10 |   0.03 |   0.09 |   0.00 |   0.00 |
|     rg |   0.08 |   0.14 |   5.13 |   0.15 |   0.15 |   0.96 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag |   3.91 |   3.99 |   3.99 |   3.05 |   3.03 |   3.02 |   3.75 |   2.79 |   3.74 |   2.78 |
|  ggrep |   0.11 |   0.19 |   7.59 |   0.72 |   1.29 |  16.83 |   0.04 |   1.12 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.01 |   0.01 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.05 |   0.03 |   0.05 |   0.00 |   0.00 |
|     ag |   0.38 |   0.37 |   0.37 |   0.36 |   0.36 |   0.36 |   0.13 |   0.12 |   0.13 |   0.12 |
|  ggrep |   0.04 |   0.05 |   0.06 |   0.07 |   0.07 |   0.08 |   0.04 |   0.06 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.60 |   0.60 |   0.50 |   0.59 |   0.60 |   0.49 |   0.19 |   0.19 |   0.19 |   0.19 |
|  ggrep |   3.40 |   3.42 |   6.95 |   3.53 |   3.66 |   7.41 |   3.39 |   3.66 |   0.00 |   0.00 |

grepping `[a-z]+-[a-z]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.06 |   0.06 |   0.08 |   0.03 |   0.04 |   0.00 |   0.00 |
|     ag |   2.22 |   2.22 |   1.72 |   2.17 |   2.19 |   1.67 |   1.34 |   1.28 |   1.33 |   1.28 |
|  ggrep |   1.35 |   1.38 |   2.71 |   1.53 |   1.49 |   3.37 |   1.35 |   1.47 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.09 |   0.09 |   0.09 |   0.09 |   0.09 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.08 |   0.13 |   5.14 |   0.15 |   0.15 |   0.95 |   0.05 |   0.06 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.02 |   2.03 |
|  ggrep |   0.11 |   0.19 |   7.45 |   0.70 |   1.16 |  15.30 |   0.04 |   0.99 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.54 |   0.54 |   0.54 |   0.04 |   0.52 |   0.00 |   0.00 |
|     ag |   0.40 |   0.41 |   0.39 | *fail* | *fail* | *fail* |   0.14 | *fail* |   0.14 | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.55 |   2.86 |   2.87 |   0.05 |   2.82 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.08 |   0.18 |   0.02 |   0.05 |   0.00 |   0.00 |
|     rg |   0.03 |   0.04 |   0.05 |   0.04 |   0.14 |   0.37 |   0.02 |   0.11 |   0.00 |   0.00 |
|  ggrep |   0.08 |   0.10 |   0.13 |   0.11 |   0.53 |   2.31 |   0.07 |   0.47 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.10 |   0.10 |   0.10 |   0.11 |   0.11 |   0.10 |   0.11 |   0.00 |   0.00 |
|     rg |   0.11 |   0.11 |   0.11 |   0.12 |   7.46 |   7.48 |   0.11 |   7.46 |   0.00 |   0.00 |
|  ggrep |   0.63 |   0.65 |   0.65 |   0.65 |   0.31 |   0.35 |   0.63 |   0.29 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.14 |   0.14 |   0.31 |   0.32 |   0.12 |   0.31 |   0.00 |   0.00 |
|     rg |   1.20 |   1.20 |   1.48 |   1.35 |  12.11 |  12.16 |   1.19 |  12.14 |   0.00 |   0.01 |
|  ggrep |   0.88 |   0.90 |   1.07 |   1.00 |   5.82 |   6.05 |   0.88 |   5.79 |   0.00 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.14 |   0.14 |   0.14 |   0.26 |   0.27 |   0.13 |   0.25 |   0.00 |   0.00 |
|     rg |   0.22 |   0.22 |   0.23 |   2.43 | 173.75 | 175.44 |   0.21 | 174.73 |   0.00 |   0.04 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.01 |   0.01 |   0.01 |   0.01 |
|     rg |   0.02 | *fail* | *fail* | *fail* |
|     ag |   0.33 | *fail* |   0.32 | *fail* |

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
|     rg |   0.11 |   0.12 |   0.12 |   0.66 |   0.68 |   0.66 |
|     ag |   0.48 |   0.58 |   0.59 | *fail* | *fail* | *fail* |
|  ggrep |   0.17 |   0.21 |   0.19 |   3.03 |   3.18 |   3.14 |

grepping `begin|end` elapsed real time (s)

| search |   -nA9 |   -nB9 |   -nC9 | -winA999 | -winB999 | -winC999 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.06 |   0.10 |   0.12 |   0.15 |   0.12 |
|     rg |   0.05 |   0.05 |   0.07 |   0.14 |   0.15 |   0.14 |
|     ag |   0.99 |   1.08 |   1.09 |   0.73 |   0.83 |   0.82 |
|  ggrep |   0.22 |   0.23 |   0.25 |   0.77 |   0.82 |   0.78 |

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
|  ugrep |   0.02 |        |   0.02 |        |   0.03 |        |   0.03 |        |   0.03 |        |   0.03 |        |
|     rg |   0.09 |        |   0.09 |        |   0.08 |        |   0.08 |        |   0.08 |        |   0.08 |        |
|     ag |        |   0.07 |        |   0.07 |        |   0.06 |        |   0.06 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.11 |        |   0.12 |        |   0.18 |        |   0.18 |        |   0.16 |        |   0.16 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.08 |        |   0.08 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.08 |        |
|     ag |        |   0.32 |        |   0.24 |        |   0.23 |        |   0.19 |        |   0.06 |        |   0.06 |
|  ggrep |        |   0.17 |        |   0.22 |        |   0.32 |        |   0.42 |        |   0.29 |        |   0.13 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.09 |        |   0.08 |        |   0.09 |        |   0.09 |        |   0.09 |        |   0.09 |        |
|     ag |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |
|  ggrep |        |   0.10 |        |   0.10 |        |   0.12 |        |   0.12 |        |   0.10 |        |   0.10 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |        |   0.19 |        |   0.20 |        |   0.19 |        |   0.22 |        |   0.19 |        |
|     rg |   0.77 |        |   0.76 |        |   0.75 |        |   0.72 |        |   0.77 |        |   0.76 |        |
|     ag |        |   0.70 |        |   0.71 |        |   0.70 |        |   0.70 |        |   0.71 |        |   0.70 |
|  ggrep |        |   0.49 |        |   0.57 |        |   0.62 |        |   0.62 |        |   0.56 |        |   0.54 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.23 |        |   0.22 |        |   0.26 |        |   0.25 |        |   0.24 |        |   0.22 |        |
|     rg |   0.74 |        |   0.76 |        |   0.71 |        |   0.68 |        |   0.72 |        |   0.76 |        |
|     ag |        |   1.05 |        |   0.74 |        |   0.89 |        |   0.80 |        |   0.64 |        |   0.64 |
|  ggrep |        |   0.60 |        |   0.73 |        |   1.58 |        |   1.80 |        |   1.49 |        |   0.63 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |        |   0.19 |        |   0.21 |        |   0.20 |        |   0.23 |        |   0.20 |        |
|     rg |   0.76 |        |   0.76 |        |   0.74 |        |   0.76 |        |   0.76 |        |   0.75 |        |
|     ag |        |   0.67 |        |   0.67 |        |   0.66 |        |   0.66 |        |   0.65 |        |   0.66 |
|  ggrep |        |   0.62 |        |   0.70 |        |   0.87 |        |   0.88 |        |   0.81 |        |   0.77 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.20 |        |   0.20 |        |   0.20 |        |   0.23 |        |   0.20 |        |
|     rg |   0.75 |        |   0.76 |        |   0.75 |        |   0.76 |        |   0.76 |        |   0.76 |        |
|     ag |        |   0.66 |        |   0.70 |        |   0.70 |        |   0.69 |        |   0.69 |        |   0.69 |
|  ggrep |        |   0.58 |        |   0.59 |        |   0.76 |        |   0.76 |        |   0.70 |        |   0.63 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.97 |   1.97 |   1.97 |   1.97 |   0.28 |   0.28 |
|     rg |   1.99 |   1.99 |   1.99 |   1.99 |   0.27 |   0.27 |
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
|  ugrep |   1.09 |   1.09 |   1.08 |   1.08 |   0.15 |   0.15 |
|     rg |   1.12 |   1.11 |   1.11 |   1.11 |   0.15 |   0.16 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |   0.12 |   0.11 |   0.12 |   0.01 |   0.02 |
|     rg |   0.11 |   0.11 |   0.10 |   0.11 | *fail* | *fail* |
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
|  ugrep |   0.07 |   0.07 |   0.07 |   0.08 |   0.06 |   0.07 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.20 |   0.20 |   0.19 |   0.19 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


