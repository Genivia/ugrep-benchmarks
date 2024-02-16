# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released.
Last update Fri Feb 16 15:58:16 EST 2024

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
- **different versions and implementations of the same compression library linked with ugrep may have different performance characteristics**, notably zlib (gz); the performance is mostly determined by the compression library and is not attributable to the grep tool

# performance report x64

found ugrep 1339752 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 5.0.0 x86_64-apple-darwin21.6.0 +avx2; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli
License: BSD-3-Clause; ugrep user manual: <https://ugrep.com>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
Ugrep utilizes the RE/flex regex library: <https://github.com/Genivia/RE-flex>
~~~

found rg 6004560 byte executable located at /opt/local/bin/rg
~~~
ripgrep 13.0.0
-SIMD -AVX (compiled)
+SIMD +AVX (runtime)
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

grep -P uses PCRE2 10.42 2022-12-11
~~~



## results for large text file search

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.01 |
|     rg |   0.03 |   0.04 |   0.03 |   0.05 |   0.05 |   0.06 |   0.03 |   0.05 |   0.00 |   0.02 |
|     ag |   0.69 |   0.66 |   0.40 |   0.35 |   0.35 |   0.35 |   0.10 |   0.10 |   0.10 |   0.10 |
|  ggrep |   0.11 |   0.13 |   0.15 |   0.15 |   0.53 |   0.53 |   0.11 |   0.51 |   0.00 |   0.08 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.09 |   0.16 |   0.09 |   0.10 |   0.21 |   0.05 |   0.06 |   0.00 |   0.00 |
|     rg |   0.07 |   0.11 |   0.27 |   0.19 |   0.20 |   1.52 |   0.04 |   0.12 |   0.00 |   0.01 |
|     ag |   3.75 |   3.75 |   1.14 |   3.66 |   3.64 |   1.08 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.13 |   0.17 |   0.71 |   0.35 |   0.88 |   3.91 |   0.09 |   0.75 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.04 |   0.03 |   0.03 |   0.00 |   0.01 |
|     rg |   0.03 |   0.03 |   0.03 |   0.25 |   0.06 |   0.07 |   0.03 |   0.06 |   0.01 |   0.01 |
|     ag |   0.41 |   0.41 |   0.41 |   0.41 |   0.42 |   0.41 |   0.16 |   0.17 |   0.15 |   0.17 |
|  ggrep |   0.21 |   0.22 |   0.23 |   0.33 |   0.29 |   0.30 |   0.21 |   0.29 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.05 |   0.05 |   0.06 |   0.06 |   0.05 |   0.06 |   0.01 |   0.01 |
|     rg |   0.07 |   0.07 |   0.07 |   0.17 |   0.25 |   0.24 |   0.06 |   0.23 |   0.00 |   0.01 |
|     ag |   0.45 |   0.45 |   0.40 |   0.41 |   0.41 |   0.39 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.36 |   0.38 |   0.38 |   0.41 |   0.84 |   0.87 |   0.35 |   0.84 |   0.00 |   0.01 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.10 |   0.10 |   0.09 |   0.10 |   0.10 |   0.08 |   0.10 |   0.00 |   0.00 |
|     rg |   0.14 |   0.16 |   0.21 |   0.20 |   0.30 |   0.30 |   0.12 |   0.28 |   0.00 |   0.01 |
|     ag |   1.85 |   1.86 |   0.69 |   0.49 |   0.48 |   0.41 |   0.20 |   0.15 |   0.20 |   0.15 |
|  ggrep |   0.89 |   0.91 |   1.29 |   1.15 |   3.22 |   3.29 |   0.83 |   3.20 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.03 |   0.04 |   0.00 |   0.00 |
|     rg |   0.07 |   0.07 |   0.07 |   0.09 |   0.10 |   0.19 |   0.05 |   0.08 |   0.00 |   0.01 |
|     ag |   0.76 |   0.75 |   0.54 |   0.75 |   1.79 |   1.22 |   0.23 |   0.86 |   0.23 |   0.86 |
|  ggrep |   0.26 |   0.28 |   0.35 |   0.29 |   1.71 |   3.31 |   0.25 |   1.64 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.04 |   0.05 |   0.05 |   0.04 |   0.04 |   0.05 |   0.04 |   0.01 |   0.01 |
|     rg |   0.06 |   0.06 |   0.06 |   0.08 |   0.09 |   0.09 |   0.06 |   0.09 |   0.01 |   0.03 |
|     ag |   0.35 |   0.35 |   0.35 |   0.23 |   0.42 |   0.41 |   0.13 |   0.18 |   0.13 |   0.18 |
|  ggrep |   0.32 |   0.33 |   0.33 |   0.32 |   2.49 |   2.49 |   0.31 |   2.47 |   0.04 |   0.30 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.05 |   0.06 |   0.06 |   0.06 |   0.05 |   0.06 |   0.02 |   0.02 |
|     rg |   0.07 |   0.07 |   0.11 |   0.10 |   0.10 |   0.17 |   0.05 |   0.09 |   0.01 |   0.01 |
|     ag |   1.63 |   1.63 |   0.88 |   1.58 |   1.59 |   0.89 |   0.48 |   0.49 |   0.47 |   0.49 |
|  ggrep |   1.13 |   1.14 |   3.25 |   1.26 |   1.56 |   3.75 |   1.05 |   1.46 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.09 |   0.11 |   0.14 |   0.10 |   0.11 |   0.12 |   0.08 |   0.11 |   0.00 |   0.01 |
|     ag |   1.90 |   1.90 |   0.65 |   0.43 |   0.44 |   0.43 |   0.15 |   0.17 |   0.15 |   0.17 |
|  ggrep |   0.11 |   0.13 |   0.33 |   0.34 |   1.64 |   1.66 |   0.09 |   1.65 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.14 |   0.26 |   0.11 |   0.13 |   0.12 |   0.08 |   0.12 |   0.00 |   0.00 |
|     rg |   0.14 |   0.31 |  18.37 |   1.78 |   1.77 | *fail* |   0.07 |   1.37 |   0.00 |   0.01 |
|     ag |   4.35 |   4.33 |   4.37 |   2.29 |   2.30 |   2.31 |   4.11 |   2.04 |   4.11 |   2.07 |
|  ggrep |   0.20 |   0.36 |  17.13 |   1.62 |   2.90 |  37.57 |   0.07 |   2.57 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.06 |   0.05 |   0.06 |   0.16 |   0.15 |   0.16 |   0.06 |   0.15 |   0.01 |   0.01 |
|     ag |   0.40 |   0.40 |   0.39 |   0.40 |   0.40 |   0.39 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.05 |   0.07 |   0.08 |   0.09 |   0.10 |   0.11 |   0.05 |   0.08 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.07 |   0.06 |   0.08 |   0.08 |   0.08 |   0.06 |   0.07 |   0.02 |   0.02 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.81 |   0.81 |   0.56 |   0.80 |   0.82 |   0.57 |   0.16 |   0.17 |   0.16 |   0.16 |
|  ggrep |   5.74 |   5.79 |  11.69 |   5.93 |   6.09 |  12.32 |   5.70 |   5.99 |   0.01 |   0.01 |

grepping `^={2,4}[^=].*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.07 |   0.06 |   0.06 |   0.06 |   0.06 |   0.01 |   0.01 |
|     rg |   0.04 |   0.06 |   0.08 |   0.13 |   0.13 |   3.37 |   0.04 |   0.11 |   0.00 |   0.01 |
|     ag |   0.40 |   0.40 |   0.39 | *fail* | *fail* | *fail* |   0.07 | *fail* |   0.07 | *fail* |
|  ggrep |   0.11 |   0.13 |   0.22 |   0.13 |   0.14 |   0.24 |   0.10 |   0.11 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.18 |   0.17 |   0.17 |   0.17 |   0.18 |   0.08 |   0.08 |   0.00 |   0.00 |
|     rg |   0.14 |   0.31 |  18.44 |   1.36 |   1.39 | *fail* |   0.07 |   0.98 |   0.00 |   0.01 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.06 |   1.21 |
|  ggrep |   0.20 |   0.36 |  16.85 |   1.59 |   2.68 |  35.52 |   0.07 |   2.30 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.06 |   0.07 |   0.06 |   0.06 |   0.05 |   0.05 |   0.00 |   0.00 |
|     rg |   0.21 |   0.24 |   0.25 |   0.36 |   0.36 |   0.79 |   0.20 |   0.31 |   0.00 |   0.01 |
|     ag |   0.41 |   0.41 |   0.39 | *fail* | *fail* | *fail* |   0.11 | *fail* |   0.11 | *fail* |
|  ggrep |   0.10 |   0.14 |   0.14 |   2.90 |   4.72 |   4.72 |   0.09 |   4.65 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.12 |   0.25 |   0.05 |   0.08 |   0.00 |   0.00 |
|     rg |   0.05 |   0.07 |   0.08 |   0.15 |   0.28 |   2.64 |   0.04 |   0.19 |   0.00 |   0.01 |
|  ggrep |   0.14 |   0.16 |   0.22 |   0.17 |   0.95 |   4.11 |   0.11 |   0.81 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.25 |   0.25 |   0.26 |   0.25 |   0.27 |   0.27 |   0.25 |   0.26 |   0.00 |   0.00 |
|     rg |   0.12 |   0.31 |  16.21 |   0.38 |   0.33 |   0.32 |   0.06 |   0.32 |   0.01 |   0.02 |
|  ggrep |   0.95 |   0.98 |   0.99 |   0.96 |   0.43 |   0.48 |   0.95 |   0.41 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.25 |   0.26 |   0.28 |   0.27 |   0.40 |   0.41 |   0.24 |   0.40 |   0.00 |   0.01 |
|     rg |   1.99 |   2.05 |   2.51 |   0.37 |   0.40 |   0.39 |   1.89 |   0.38 |   0.01 |   0.03 |
|  ggrep |   1.39 |   1.46 |   1.69 |   1.56 |   9.55 |   9.94 |   1.37 |   9.52 |   0.00 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.23 |   0.23 |   0.23 |   0.24 |   0.47 |   0.47 |   0.22 |   0.45 |   0.01 |   0.02 |
|     rg |   0.34 |   0.35 |   0.36 |   1.35 |   1.70 |   1.73 |   0.32 |   1.63 |   0.02 |   0.14 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.03 |   0.03 |
|     rg |   0.03 | *fail* | *fail* | *fail* |
|     ag |   0.40 | *fail* |   0.39 | *fail* |

## results for large text file search with replaced output

grepping `flop` elapsed real time (s)

| search | --replace=flip |
| -----: | -----: |
|  ugrep |   0.02 |
|     rg |   0.02 |

## results for large text file search with context

grepping `^$` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.16 |   0.21 |   0.20 |   0.18 |   0.23 |
|     rg |   0.25 |   0.25 |   0.25 |   0.45 |   0.45 |   0.46 |
|     ag |   0.48 |   0.67 |   0.68 | *fail* | *fail* | *fail* |
|  ggrep |   0.15 |   0.18 |   0.18 |   4.97 |   4.99 |   5.00 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.02 |   0.03 |   0.04 |   0.04 |   0.04 |
|     rg |   0.03 |   0.03 |   0.03 |   0.09 |   0.09 |   0.09 |
|     ag |   0.40 |   0.55 |   0.54 |   0.42 |   0.58 |   0.59 |
|  ggrep |   0.12 |   0.13 |   0.13 |   0.30 |   0.30 |   0.30 |

## results for large long lines JSON file search

grepping `99` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.04 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.06 |   0.06 |   0.06 |   0.11 |   0.11 |   0.23 |   0.02 |   0.08 |   0.01 |   0.01 |
|     ag |   5.08 |   5.08 |   1.30 |   4.53 |   4.61 |   1.19 |   0.32 |   0.32 |   0.32 |   0.31 |
|  ggrep |   0.05 |   0.06 |   0.27 |   0.15 |   1.24 |   4.27 |   0.03 |   1.15 |   0.00 |   0.00 |

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.05 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.01 |   0.01 |
|     rg |   0.04 |   0.04 |   0.03 |   0.12 |   0.13 |   0.13 |   0.02 |   0.12 |   0.00 |   0.01 |
|     ag |   2.76 |   2.75 |   0.72 |   0.58 |   0.58 |   0.37 |   0.10 |   0.11 |   0.10 |   0.11 |
|  ggrep |   0.19 |   0.19 |   0.37 |   0.37 |   2.14 |   2.35 |   0.17 |   2.15 |   0.00 |   0.08 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |        |   0.03 |        |   0.03 |        |   0.03 |        |   0.04 |        |   0.03 |        |
|     rg |   0.03 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.15 |        |   0.15 |        |   0.22 |        |   0.23 |        |   0.21 |        |   0.21 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.06 |        |   0.07 |        |   0.13 |        |   0.06 |        |   0.05 |        |
|     ag |        |   0.50 |        |   0.34 |        |   0.35 |        |   0.23 |        |   0.08 |        |   0.08 |
|  ggrep |        |   0.24 |        |   0.31 |        |   0.50 |        |   0.69 |        |   0.44 |        |   0.19 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |        |   0.03 |        |   0.03 |        |   0.03 |        |   0.04 |        |   0.03 |        |
|     rg |   0.03 |        |   0.04 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |
|     ag |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.12 |        |   0.12 |        |   0.15 |        |   0.14 |        |   0.15 |        |   0.13 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.17 |        |   0.18 |        |   0.18 |        |   0.18 |        |   0.21 |        |   0.17 |        |
|     rg |   0.19 |        |   0.20 |        |   0.21 |        |   0.21 |        |   0.21 |        |   0.21 |        |
|     ag |        |   0.37 |        |   0.35 |        |   0.33 |        |   0.34 |        |   0.33 |        |   0.35 |
|  ggrep |        |   0.67 |        |   0.79 |        |   0.87 |        |   0.89 |        |   0.86 |        |   0.81 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.23 |        |   0.20 |        |   0.24 |        |   0.22 |        |   0.23 |        |   0.18 |        |
|     rg |   0.21 |        |   0.22 |        |   0.28 |        |   0.37 |        |   0.27 |        |   0.22 |        |
|     ag |        |   1.36 |        |   0.75 |        |   1.02 |        |   0.79 |        |   0.44 |        |   0.41 |
|  ggrep |        |   0.90 |        |   1.08 |        |   2.55 |        |   2.99 |        |   2.42 |        |   0.98 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |        |   0.18 |        |   0.19 |        |   0.18 |        |   0.21 |        |   0.17 |        |
|     rg |   0.19 |        |   0.28 |        |   0.37 |        |   0.38 |        |   0.37 |        |   0.36 |        |
|     ag |        |   0.36 |        |   0.37 |        |   0.35 |        |   0.39 |        |   0.36 |        |   0.36 |
|  ggrep |        |   0.88 |        |   0.93 |        |   1.24 |        |   1.25 |        |   1.20 |        |   1.12 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.19 |        |   0.19 |        |   0.18 |        |   0.23 |        |   0.18 |        |
|     rg |   0.19 |        |   0.19 |        |   0.29 |        |   0.30 |        |   0.29 |        |   0.28 |        |
|     ag |        |   0.46 |        |   0.38 |        |   0.39 |        |   0.37 |        |   0.37 |        |   0.33 |
|  ggrep |        |   0.78 |        |   0.79 |        |   1.08 |        |   1.11 |        |   1.06 |        |   0.95 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.30 |   3.31 |   3.30 |   3.32 |   0.47 |   0.48 |
|     rg |   3.42 |   3.50 |   3.54 |   3.45 |   0.47 |   0.50 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.50 |   0.51 |   0.51 |   0.51 |   0.08 |   0.07 |
|     rg |   0.41 |   0.42 |   0.41 |   0.41 |   0.06 |   0.07 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.08 |   0.08 |   0.08 |   0.02 |   0.02 |
|     rg |   0.12 |   0.16 |   0.12 |   0.16 |   0.03 |   0.05 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.48 |   1.50 |   1.49 |   1.48 |   0.22 |   0.22 |
|     rg |   1.50 |   1.48 |   1.47 |   1.49 |   0.23 |   0.22 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.19 |   0.19 |   0.03 |   0.03 |
|     rg |   0.17 |   0.17 |   0.16 |   0.17 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.31 |   0.31 |   0.31 |   0.31 |   0.31 |   0.30 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.13 |   0.12 |   0.12 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.36 |   0.35 |   0.35 |   0.35 |   0.34 |   0.35 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1259906 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 5.0.0 arm-apple-darwin21.6.0 +neon/AArch64; -P:pcre2jit; -z:zlib,bzip2,lzma,lz4,zstd,brotli
License: BSD-3-Clause; ugrep user manual: <https://ugrep.com>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
Ugrep utilizes the RE/flex regex library: <https://github.com/Genivia/RE-flex>
~~~

found rg 5571088 byte executable located at /opt/local/bin/rg
~~~
ripgrep 13.0.0
-SIMD -AVX (compiled)
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

grep -P uses PCRE2 10.42 2022-12-11
~~~



## results for large text file search

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.03 |   0.02 |   0.00 |   0.00 |
|     rg |   0.08 |   0.08 |   0.09 |   0.10 |   0.14 |   0.14 |   0.08 |   0.14 |   0.00 |   0.02 |
|     ag |   0.53 |   0.53 |   0.43 |   0.40 |   0.40 |   0.40 |   0.16 |   0.17 |   0.16 |   0.16 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.37 |   0.37 |   0.10 |   0.35 |   0.00 |   0.05 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.11 |   0.07 |   0.07 |   0.13 |   0.04 |   0.05 |   0.00 |   0.00 |
|     rg |   0.06 |   0.08 |   0.21 |   0.14 |   0.18 |   1.22 |   0.05 |   0.14 |   0.00 |   0.00 |
|     ag |   1.94 |   1.94 |   0.84 |   1.89 |   1.89 |   0.81 |   0.20 |   0.21 |   0.21 |   0.21 |
|  ggrep |   0.10 |   0.13 |   0.40 |   0.23 |   0.50 |   2.22 |   0.08 |   0.44 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.20 |   0.20 |   0.20 |   0.25 |   0.22 |   0.22 |   0.20 |   0.21 |   0.00 |   0.00 |
|     ag |   0.52 |   0.52 |   0.51 |   0.50 |   0.50 |   0.50 |   0.28 |   0.26 |   0.28 |   0.26 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.15 |   0.22 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.04 |   0.04 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.16 |   0.16 |   0.16 |   0.21 |   0.27 |   0.27 |   0.16 |   0.26 |   0.00 |   0.00 |
|     ag |   0.44 |   0.44 |   0.42 |   0.41 |   0.41 |   0.40 |   0.17 |   0.16 |   0.17 |   0.16 |
|  ggrep |   0.25 |   0.27 |   0.28 |   0.30 |   0.58 |   0.59 |   0.25 |   0.56 |   0.00 |   0.00 |

grepping `r[a-z]*st` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.07 |   0.07 |   0.07 |   0.08 |   0.08 |   0.06 |   0.08 |   0.00 |   0.00 |
|     rg |   0.17 |   0.18 |   0.23 |   0.21 |   0.29 |   0.29 |   0.15 |   0.28 |   0.00 |   0.00 |
|     ag |   1.16 |   1.16 |   0.68 |   0.46 |   0.46 |   0.43 |   0.31 |   0.18 |   0.31 |   0.18 |
|  ggrep |   0.49 |   0.51 |   0.72 |   0.64 |   1.82 |   1.86 |   0.48 |   1.80 |   0.00 |   0.00 |

grepping `[A-Z][a-z]+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.04 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.07 |   0.08 |   0.09 |   0.09 |   0.17 |   0.24 |   0.07 |   0.15 |   0.00 |   0.00 |
|     ag |   0.63 |   0.63 |   0.54 |   0.63 |   2.18 |   1.95 |   0.27 |   1.66 |   0.27 |   1.66 |
|  ggrep |   0.16 |   0.18 |   0.21 |   0.18 |   0.98 |   1.90 |   0.16 |   0.95 |   0.00 |   0.00 |

grepping `[A-Z][a-z]{11}ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.03 |   0.04 |   0.03 |   0.00 |   0.00 |
|     rg |   0.07 |   0.08 |   0.08 |   0.09 |   0.17 |   0.17 |   0.07 |   0.17 |   0.01 |   0.03 |
|     ag |   0.40 |   0.39 |   0.40 |   0.28 |   1.54 |   1.54 |   0.19 |   1.31 |   0.19 |   1.31 |
|  ggrep |   0.19 |   0.21 |   0.21 |   0.21 |   1.42 |   1.42 |   0.19 |   1.40 |   0.02 |   0.16 |

grepping `\w+ny` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.05 |   0.05 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.07 |   0.07 |   0.11 |   0.09 |   0.17 |   0.23 |   0.06 |   0.16 |   0.00 |   0.00 |
|     ag |   3.32 |   3.32 |   3.01 |   2.29 |   2.29 |   2.00 |   2.69 |   1.69 |   2.69 |   1.69 |
|  ggrep |   0.57 |   0.59 |   1.67 |   0.65 |   0.86 |   2.04 |   0.56 |   0.84 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.02 |   0.02 |   0.02 |   0.03 |   0.02 |   0.00 |   0.00 |
|     rg |   0.13 |   0.14 |   0.18 |   0.11 |   0.21 |   0.21 |   0.12 |   0.20 |   0.00 |   0.00 |
|     ag |   1.07 |   1.07 |   0.55 |   0.45 |   0.45 |   0.45 |   0.18 |   0.21 |   0.18 |   0.21 |
|  ggrep |   0.08 |   0.10 |   0.20 |   0.21 |   1.05 |   1.06 |   0.07 |   1.03 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.10 |   0.14 |   0.09 |   0.11 |   0.11 |   0.06 |   0.11 |   0.00 |   0.00 |
|     rg |   0.09 |   0.18 |   8.63 |   1.19 |   1.19 | *fail* |   0.06 |   1.07 |   0.00 |   0.00 |
|     ag |   3.97 |   3.92 |   3.91 |   3.03 |   3.03 |   3.03 |   3.75 |   2.79 |   3.75 |   2.79 |
|  ggrep |   0.11 |   0.19 |   7.59 |   0.73 |   1.28 |  16.79 |   0.04 |   1.12 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.06 |   0.14 |   0.14 |   0.14 |   0.05 |   0.14 |   0.00 |   0.00 |
|     ag |   0.37 |   0.37 |   0.37 |   0.37 |   0.36 |   0.36 |   0.13 |   0.12 |   0.13 |   0.12 |
|  ggrep |   0.04 |   0.05 |   0.06 |   0.07 |   0.08 |   0.08 |   0.04 |   0.06 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.04 |   0.05 |   0.00 |   0.01 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.60 |   0.60 |   0.50 |   0.59 |   0.60 |   0.50 |   0.19 |   0.19 |   0.19 |   0.19 |
|  ggrep |   3.40 |   3.42 |   6.95 |   3.53 |   3.67 |   7.44 |   3.39 |   3.65 |   0.00 |   0.00 |

grepping `^={2,4}[^=].*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.10 |   0.09 |   2.90 |   0.04 |   0.08 |   0.00 |   0.00 |
|     ag |   0.42 |   0.42 |   0.41 | *fail* | *fail* | *fail* |   0.15 | *fail* |   0.14 | *fail* |
|  ggrep |   0.05 |   0.08 |   0.11 |   0.08 |   0.08 |   0.12 |   0.05 |   0.05 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.10 |   0.10 |   0.10 |   0.10 |   0.10 |   0.05 |   0.05 |   0.00 |   0.00 |
|     rg |   0.09 |   0.18 |   8.68 |   0.88 |   0.88 | *fail* |   0.06 |   0.75 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.03 |   2.03 |
|  ggrep |   0.11 |   0.19 |   7.44 |   0.70 |   1.16 |  15.26 |   0.04 |   1.00 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.05 |   0.04 |   0.05 |   0.05 |   0.04 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.19 |   0.21 |   0.22 |   0.29 |   0.29 |   0.61 |   0.19 |   0.27 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.39 | *fail* | *fail* | *fail* |   0.14 | *fail* |   0.14 | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.55 |   2.86 |   2.88 |   0.05 |   2.83 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.04 |   0.05 |   0.09 |   0.20 |   0.04 |   0.07 |   0.00 |   0.00 |
|     rg |   0.16 |   0.17 |   0.25 |   0.23 |   0.21 |   2.14 |   0.15 |   0.17 |   0.00 |   0.00 |
|  ggrep |   0.08 |   0.10 |   0.13 |   0.11 |   0.53 |   2.31 |   0.07 |   0.47 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.13 |   0.15 |   0.15 |   0.13 |   0.15 |   0.00 |   0.00 |
|     rg |   0.09 |   0.17 |   7.66 |   0.31 |   0.27 |   0.27 |   0.05 |   0.27 |   0.00 |   0.01 |
|  ggrep |   0.63 |   0.65 |   0.66 |   0.65 |   0.31 |   0.35 |   0.63 |   0.30 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |   0.14 |   0.15 |   0.14 |   0.23 |   0.24 |   0.13 |   0.23 |   0.00 |   0.00 |
|     rg |   0.16 |   0.17 |   0.20 |   0.29 |   0.30 |   0.31 |   0.16 |   0.30 |   0.00 |   0.01 |
|  ggrep |   0.88 |   0.90 |   1.07 |   1.00 |   5.80 |   6.04 |   0.87 |   5.80 |   0.00 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.19 |   0.19 |   0.32 |   0.33 |   0.18 |   0.32 |   0.00 |   0.01 |
|     rg |   0.20 |   0.21 |   0.22 |   0.84 |   1.05 |   1.10 |   0.20 |   1.03 |   0.00 |   0.06 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |
|     rg |   0.03 | *fail* | *fail* | *fail* |
|     ag |   0.33 | *fail* |   0.33 | *fail* |

## results for large text file search with replaced output

grepping `flop` elapsed real time (s)

| search | --replace=flip |
| -----: | -----: |
|  ugrep |   0.02 |
|     rg |   0.04 |

## results for large text file search with context

grepping `^$` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.08 |   0.11 |   0.10 |   0.09 |   0.12 |
|     rg |   0.22 |   0.23 |   0.23 |   0.33 |   0.35 |   0.35 |
|     ag |   0.44 |   0.54 |   0.54 | *fail* | *fail* | *fail* |
|  ggrep |   0.09 |   0.12 |   0.11 |   2.91 |   2.94 |   2.93 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.04 |   0.03 |   0.04 |
|     rg |   0.03 |   0.03 |   0.03 |   0.23 |   0.23 |   0.23 |
|     ag |   0.33 |   0.41 |   0.41 |   0.50 |   0.58 |   0.58 |
|  ggrep |   0.09 |   0.09 |   0.09 |   0.23 |   0.23 |   0.23 |

## results for large long lines JSON file search

grepping `99` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.11 |   0.09 |   0.09 |   0.24 |   0.02 |   0.07 |   0.00 |   0.00 |
|     ag |   2.43 |   2.44 |   0.84 |   2.17 |   2.17 |   0.78 |   0.23 |   0.24 |   0.23 |   0.23 |
|  ggrep |   0.04 |   0.04 |   0.16 |   0.09 |   0.74 |   2.65 |   0.02 |   0.72 |   0.00 |   0.00 |

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.06 |   0.06 |   0.08 |   0.14 |   0.15 |   0.16 |   0.05 |   0.14 |   0.00 |   0.01 |
|     ag |   1.38 |   1.38 |   0.53 |   0.43 |   0.43 |   0.35 |   0.11 |   0.11 |   0.11 |   0.11 |
|  ggrep |   0.13 |   0.14 |   0.24 |   0.23 |   1.49 |   1.62 |   0.13 |   1.48 |   0.00 |   0.05 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.05 |        |   0.06 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.10 |        |   0.11 |        |   0.17 |        |   0.17 |        |   0.16 |        |   0.15 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.03 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.03 |        |
|     rg |   0.04 |        |   0.04 |        |   0.05 |        |   0.09 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.32 |        |   0.23 |        |   0.23 |        |   0.18 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.16 |        |   0.21 |        |   0.31 |        |   0.41 |        |   0.28 |        |   0.12 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.05 |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.09 |        |   0.09 |        |   0.11 |        |   0.11 |        |   0.09 |        |   0.09 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |        |   0.12 |        |   0.12 |        |   0.12 |        |   0.16 |        |   0.11 |        |
|     rg |   0.24 |        |   0.23 |        |   0.24 |        |   0.28 |        |   0.28 |        |   0.24 |        |
|     ag |        |   0.23 |        |   0.25 |        |   0.23 |        |   0.23 |        |   0.27 |        |   0.23 |
|  ggrep |        |   0.42 |        |   0.50 |        |   0.54 |        |   0.55 |        |   0.49 |        |   0.47 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.16 |        |   0.14 |        |   0.17 |        |   0.18 |        |   0.17 |        |   0.13 |        |
|     rg |   0.24 |        |   0.23 |        |   0.29 |        |   0.28 |        |   0.23 |        |   0.25 |        |
|     ag |        |   0.85 |        |   0.49 |        |   0.68 |        |   0.57 |        |   0.26 |        |   0.25 |
|  ggrep |        |   0.53 |        |   0.66 |        |   1.50 |        |   1.73 |        |   1.42 |        |   0.56 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |        |   0.12 |        |   0.12 |        |   0.12 |        |   0.16 |        |   0.11 |        |
|     rg |   0.26 |        |   0.20 |        |   0.23 |        |   0.27 |        |   0.25 |        |   0.22 |        |
|     ag |        |   0.24 |        |   0.24 |        |   0.23 |        |   0.23 |        |   0.23 |        |   0.23 |
|  ggrep |        |   0.55 |        |   0.62 |        |   0.80 |        |   0.80 |        |   0.75 |        |   0.70 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |        |   0.12 |        |   0.12 |        |   0.12 |        |   0.16 |        |   0.11 |        |
|     rg |   0.24 |        |   0.25 |        |   0.26 |        |   0.22 |        |   0.23 |        |   0.23 |        |
|     ag |        |   0.32 |        |   0.26 |        |   0.28 |        |   0.26 |        |   0.24 |        |   0.24 |
|  ggrep |        |   0.51 |        |   0.51 |        |   0.69 |        |   0.69 |        |   0.63 |        |   0.56 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.98 |   1.97 |   1.97 |   1.98 |   0.28 |   0.28 |
|     rg |   2.00 |   2.00 |   1.99 |   2.00 |   0.27 |   0.29 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |   0.30 |   0.30 |   0.30 |   0.04 |   0.04 |
|     rg |   0.29 |   0.30 |   0.29 |   0.30 |   0.04 |   0.04 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.01 |   0.01 |
|     rg |   0.11 |   0.17 |   0.11 |   0.17 |   0.02 |   0.03 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.09 |   1.08 |   1.08 |   1.08 |   0.15 |   0.15 |
|     rg |   1.11 |   1.12 |   1.11 |   1.12 |   0.16 |   0.16 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |   0.14 |   0.14 |   0.14 |   0.02 |   0.02 |
|     rg |   0.12 |   0.13 |   0.12 |   0.13 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.22 |   0.21 |   0.22 |   0.21 |   0.21 |   0.21 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.09 |   0.08 |   0.08 |   0.07 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.21 |   0.21 |   0.21 |   0.21 |   0.20 |   0.20 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


