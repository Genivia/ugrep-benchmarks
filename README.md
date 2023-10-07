# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released.
Last update Fri Oct 06 21:05:05 EDT 2023

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
- all timed runs of ugrep are performed without a .ugrep configuration file by using the ugrep batch command
- all regex patterns tested are fully compliant with the common ERE standard syntax; a failure may occur if a grep tool fails to parse ERE (for example, ripgrep failing to parse `[][a-z]` in URL pattern testing, when `[\[\]a-z]` works for ripgrep but this is not compliant so GNU grep fails)

## important notes on grep tool differences that impact the results

- **ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files;** we include option `-I` in recursive searches for a fair performance comparison
- **ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected to list all files thereby making the performance of option `-c` incomparable for recursive searches** (note: ugrep option `-m1,` (`--min-count=1`) skips zero matches but is not used in this benchmark)
- **ripgrep does not search tar file contents**, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead
- **ugrep option `-z` is more powerful than just internally decompressing a single file in a buffer to search,** it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files stored within archives
- different versions and implementations of **the same compression library may have different performance characteristics**, notably zlib (gz); the performance is mostly determined by the compression library and is not attributable to the grep tool

## important notes on pending ugrep performance improvements

- ugrep context options `-ABC` are suboptimal, because of double buffering overhead (input buffer and context buffer), which will be optimized soon in a future release
- ugrep patterns with leading `+` repetitions that match "anything", such as `\w+foo` are quite slow, because of pattern search backtracking, which will be optimized in a future release

# performance report x64

found ugrep 1192088 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.3.0 x86_64-apple-darwin21.6.0 +avx2 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
License BSD-3-Clause: <https://opensource.org/licenses/BSD-3-Clause>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
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
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.01 |
|     rg |   0.03 |   0.03 |   0.03 |   0.05 |   0.05 |   0.05 |   0.02 |   0.05 |   0.00 |   0.02 |
|     ag |   0.66 |   0.65 |   0.41 |   0.34 |   0.35 |   0.34 |   0.10 |   0.10 |   0.10 |   0.10 |
|  ggrep |   0.11 |   0.13 |   0.14 |   0.15 |   0.55 |   0.53 |   0.11 |   0.55 |   0.00 |   0.07 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.09 |   0.17 |   0.10 |   0.10 |   0.20 |   0.05 |   0.06 |   0.00 |   0.00 |
|     rg |   0.07 |   0.10 |   0.34 |   0.18 |   0.20 |   1.51 |   0.04 |   0.12 |   0.00 |   0.01 |
|     ag |   3.72 |   3.87 |   1.11 |   3.63 |   3.63 |   1.07 |   0.14 |   0.15 |   0.14 |   0.15 |
|  ggrep |   0.13 |   0.22 |   0.71 |   0.34 |   0.88 |   3.93 |   0.09 |   0.74 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.28 |   0.06 |   0.06 |   0.03 |   0.06 |   0.00 |   0.01 |
|     ag |   0.41 |   0.40 |   0.40 |   0.41 |   0.41 |   0.41 |   0.16 |   0.16 |   0.15 |   0.17 |
|  ggrep |   0.20 |   0.22 |   0.23 |   0.34 |   0.30 |   0.29 |   0.21 |   0.28 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.00 |   0.01 |
|     rg |   0.07 |   0.06 |   0.07 |   0.17 |   0.23 |   0.24 |   0.06 |   0.23 |   0.00 |   0.01 |
|     ag |   0.45 |   0.45 |   0.39 |   0.40 |   0.40 |   0.38 |   0.14 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.37 |   0.38 |   0.37 |   0.41 |   0.87 |   0.85 |   0.35 |   0.82 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.10 |   0.11 |   0.14 |   0.10 |   0.11 |   0.11 |   0.08 |   0.11 |   0.00 |   0.01 |
|     ag |   1.87 |   1.86 |   0.65 |   0.43 |   0.43 |   0.42 |   0.15 |   0.18 |   0.14 |   0.17 |
|  ggrep |   0.11 |   0.13 |   0.32 |   0.33 |   1.66 |   1.63 |   0.09 |   1.63 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.14 |   0.26 |   0.11 |   0.13 |   0.12 |   0.08 |   0.12 |   0.00 |   0.00 |
|     rg |   0.13 |   0.31 |  18.19 |   1.74 |   1.78 | *fail* |   0.07 |   1.34 |   0.00 |   0.01 |
|     ag |   4.28 |   4.32 |   4.26 |   2.26 |   2.26 |   2.26 |   4.02 |   2.02 |   4.02 |   2.01 |
|  ggrep |   0.20 |   0.36 |  16.85 |   1.56 |   2.87 |  36.63 |   0.07 |   2.45 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.06 |   0.15 |   0.15 |   0.15 |   0.05 |   0.15 |   0.00 |   0.01 |
|     ag |   0.40 |   0.41 |   0.39 |   0.40 |   0.40 |   0.39 |   0.13 |   0.14 |   0.14 |   0.14 |
|  ggrep |   0.05 |   0.07 |   0.07 |   0.09 |   0.10 |   0.11 |   0.05 |   0.08 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.07 |   0.06 |   0.08 |   0.08 |   0.08 |   0.06 |   0.07 |   0.01 |   0.02 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.80 |   0.80 |   0.56 |   0.80 |   0.80 |   0.56 |   0.16 |   0.17 |   0.15 |   0.17 |
|  ggrep |   5.72 |   5.72 |  11.55 |   5.83 |   6.03 |  12.10 |   5.70 |   5.92 |   0.01 |   0.01 |

grepping `^={2,4}[^=].*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.01 |   0.01 |
|     rg |   0.04 |   0.05 |   0.07 |   0.13 |   0.13 |   3.32 |   0.04 |   0.11 |   0.00 |   0.01 |
|     ag |   0.39 |   0.40 |   0.39 | *fail* | *fail* | *fail* |   0.07 | *fail* |   0.07 | *fail* |
|  ggrep |   0.11 |   0.13 |   0.21 |   0.13 |   0.14 |   0.23 |   0.10 |   0.10 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.17 |   0.17 |   0.17 |   0.16 |   0.17 |   0.08 |   0.07 |   0.00 |   0.00 |
|     rg |   0.13 |   0.31 |  18.29 |   1.32 |   1.35 | *fail* |   0.07 |   0.96 |   0.00 |   0.01 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.06 |   1.19 |
|  ggrep |   0.20 |   0.35 |  16.56 |   1.53 |   2.69 |  34.56 |   0.07 |   2.25 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.05 |   0.05 |   0.00 |   0.00 |
|     rg |   0.20 |   0.24 |   0.26 |   0.36 |   0.35 |   0.77 |   0.19 |   0.30 |   0.00 |   0.01 |
|     ag |   0.41 |   0.40 |   0.39 | *fail* | *fail* | *fail* |   0.11 | *fail* |   0.11 | *fail* |
|  ggrep |   0.10 |   0.14 |   0.14 |   2.87 |   4.68 |   4.65 |   0.08 |   4.54 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.12 |   0.25 |   0.04 |   0.08 |   0.00 |   0.00 |
|     rg |   0.05 |   0.07 |   0.08 |   0.15 |   0.28 |   2.57 |   0.03 |   0.19 |   0.00 |   0.01 |
|  ggrep |   0.13 |   0.16 |   0.21 |   0.17 |   0.92 |   4.02 |   0.11 |   0.78 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.25 |   0.25 |   0.25 |   0.25 |   0.27 |   0.26 |   0.25 |   0.26 |   0.00 |   0.00 |
|     rg |   0.12 |   0.29 |  16.11 |   0.37 |   0.33 |   0.32 |   0.06 |   0.33 |   0.00 |   0.02 |
|  ggrep |   0.93 |   0.96 |   0.96 |   0.95 |   0.42 |   0.47 |   0.94 |   0.40 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |   0.26 |   0.28 |   0.26 |   0.39 |   0.38 |   0.23 |   0.37 |   0.00 |   0.00 |
|     rg |   1.96 |   2.00 |   2.37 |   0.36 |   0.39 |   0.37 |   1.88 |   0.37 |   0.01 |   0.03 |
|  ggrep |   1.39 |   1.41 |   1.62 |   1.51 |   9.44 |   9.65 |   1.29 |   9.27 |   0.00 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.23 |   0.24 |   0.23 |   0.25 |   0.46 |   0.47 |   0.22 |   0.43 |   0.01 |   0.02 |
|     rg |   0.34 |   0.35 |   0.34 |   1.37 |   1.67 |   1.68 |   0.32 |   1.61 |   0.02 |   0.13 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |
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
|  ugrep |   0.18 |   0.22 |   0.21 |   0.20 |   0.24 |   0.23 |
|     rg |   0.24 |   0.25 |   0.25 |   0.44 |   0.45 |   0.46 |
|     ag |   0.49 |   0.65 |   0.67 | *fail* | *fail* | *fail* |
|  ggrep |   0.15 |   0.18 |   0.18 |   4.92 |   4.95 |   4.93 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.16 |   0.16 |   0.14 |   0.17 |   0.17 |
|     rg |   0.03 |   0.03 |   0.03 |   0.08 |   0.09 |   0.08 |
|     ag |   0.39 |   0.52 |   0.52 |   0.41 |   0.55 |   0.55 |
|  ggrep |   0.13 |   0.12 |   0.13 |   0.29 |   0.29 |   0.29 |

## results for large long lines JSON file search

grepping `99` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.04 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.05 |   0.05 |   0.06 |   0.10 |   0.10 |   0.22 |   0.02 |   0.07 |   0.00 |   0.01 |
|     ag |   5.04 |   5.02 |   1.28 |   4.46 |   4.45 |   1.16 |   0.32 |   0.31 |   0.32 |   0.32 |
|  ggrep |   0.05 |   0.05 |   0.26 |   0.15 |   1.24 |   4.28 |   0.03 |   1.14 |   0.00 |   0.00 |

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.04 |   0.04 |   0.03 |   0.12 |   0.13 |   0.12 |   0.02 |   0.12 |   0.00 |   0.01 |
|     ag |   2.71 |   2.72 |   0.71 |   0.56 |   0.57 |   0.37 |   0.10 |   0.11 |   0.10 |   0.11 |
|  ggrep |   0.19 |   0.19 |   0.36 |   0.36 |   2.10 |   2.27 |   0.16 |   2.14 |   0.00 |   0.07 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |        |   0.03 |        |   0.03 |        |   0.03 |        |   0.04 |        |   0.03 |        |
|     rg |   0.03 |        |   0.03 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.06 |        |   0.05 |
|  ggrep |        |   0.14 |        |   0.15 |        |   0.24 |        |   0.22 |        |   0.21 |        |   0.20 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |        |   0.04 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.06 |        |   0.07 |        |   0.14 |        |   0.07 |        |   0.05 |        |
|     ag |        |   0.50 |        |   0.35 |        |   0.34 |        |   0.23 |        |   0.08 |        |   0.08 |
|  ggrep |        |   0.23 |        |   0.31 |        |   0.49 |        |   0.68 |        |   0.43 |        |   0.19 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |        |   0.03 |        |   0.03 |        |   0.03 |        |   0.04 |        |   0.03 |        |
|     rg |   0.03 |        |   0.04 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |
|     ag |        |   0.06 |        |   0.05 |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.12 |        |   0.12 |        |   0.15 |        |   0.14 |        |   0.13 |        |   0.12 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.18 |        |   0.18 |        |   0.18 |        |   0.18 |        |   0.23 |        |   0.18 |        |
|     rg |   0.19 |        |   0.20 |        |   0.20 |        |   0.21 |        |   0.20 |        |   0.20 |        |
|     ag |        |   0.35 |        |   0.36 |        |   0.33 |        |   0.32 |        |   0.32 |        |   0.32 |
|  ggrep |        |   0.66 |        |   0.79 |        |   0.86 |        |   0.87 |        |   0.83 |        |   0.79 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.23 |        |   0.21 |        |   0.24 |        |   0.23 |        |   0.23 |        |   0.19 |        |
|     rg |   0.20 |        |   0.22 |        |   0.28 |        |   0.36 |        |   0.28 |        |   0.21 |        |
|     ag |        |   1.37 |        |   0.77 |        |   1.02 |        |   0.78 |        |   0.41 |        |   0.40 |
|  ggrep |        |   0.87 |        |   1.05 |        |   2.50 |        |   2.86 |        |   2.37 |        |   0.96 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.18 |        |   0.18 |        |   0.18 |        |   0.18 |        |   0.22 |        |   0.17 |        |
|     rg |   0.19 |        |   0.28 |        |   0.37 |        |   0.37 |        |   0.37 |        |   0.36 |        |
|     ag |        |   0.33 |        |   0.33 |        |   0.36 |        |   0.36 |        |   0.36 |        |   0.33 |
|  ggrep |        |   0.82 |        |   0.92 |        |   1.20 |        |   1.21 |        |   1.18 |        |   1.09 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |        |   0.18 |        |   0.18 |        |   0.18 |        |   0.22 |        |   0.17 |        |
|     rg |   0.19 |        |   0.18 |        |   0.29 |        |   0.29 |        |   0.29 |        |   0.27 |        |
|     ag |        |   0.44 |        |   0.38 |        |   0.40 |        |   0.36 |        |   0.32 |        |   0.36 |
|  ggrep |        |   0.76 |        |   0.77 |        |   1.04 |        |   1.07 |        |   1.03 |        |   0.92 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.26 |   3.22 |   3.27 |   3.24 |   0.46 |   0.47 |
|     rg |   3.42 |   3.39 |   3.39 |   3.43 |   0.47 |   0.57 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.50 |   0.51 |   0.50 |   0.51 |   0.07 |   0.07 |
|     rg |   0.40 |   0.41 |   0.41 |   0.41 |   0.06 |   0.07 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.09 |   0.08 |   0.09 |   0.02 |   0.02 |
|     rg |   0.12 |   0.15 |   0.12 |   0.16 |   0.03 |   0.04 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.47 |   1.50 |   1.47 |   1.47 |   0.21 |   0.22 |
|     rg |   1.47 |   1.47 |   1.46 |   1.48 |   0.21 |   0.22 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.18 |   0.18 |   0.18 |   0.18 |   0.03 |   0.03 |
|     rg |   0.16 |   0.16 |   0.16 |   0.16 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.29 |   0.29 |   0.29 |   0.29 |   0.29 |   0.29 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.13 |   0.11 |   0.11 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.36 |   0.35 |   0.35 |   0.35 |   0.34 |   0.34 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1110722 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.3.0 arm-apple-darwin21.6.0 +neon/AArch64 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
License BSD-3-Clause: <https://opensource.org/licenses/BSD-3-Clause>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
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
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.08 |   0.08 |   0.09 |   0.10 |   0.14 |   0.14 |   0.07 |   0.14 |   0.00 |   0.02 |
|     ag |   0.54 |   0.53 |   0.43 |   0.40 |   0.40 |   0.40 |   0.16 |   0.16 |   0.16 |   0.16 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.38 |   0.38 |   0.10 |   0.36 |   0.00 |   0.05 |

grepping `the` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.11 |   0.07 |   0.07 |   0.13 |   0.04 |   0.05 |   0.00 |   0.00 |
|     rg |   0.06 |   0.08 |   0.21 |   0.14 |   0.18 |   1.22 |   0.05 |   0.14 |   0.00 |   0.00 |
|     ag |   1.94 |   1.94 |   0.84 |   1.89 |   1.89 |   0.81 |   0.21 |   0.21 |   0.20 |   0.21 |
|  ggrep |   0.10 |   0.13 |   0.40 |   0.23 |   0.52 |   2.33 |   0.08 |   0.46 |   0.00 |   0.00 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.20 |   0.20 |   0.20 |   0.25 |   0.22 |   0.22 |   0.20 |   0.21 |   0.00 |   0.00 |
|     ag |   0.52 |   0.52 |   0.52 |   0.50 |   0.50 |   0.50 |   0.28 |   0.26 |   0.28 |   0.26 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.15 |   0.22 |   0.00 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.16 |   0.16 |   0.16 |   0.21 |   0.27 |   0.27 |   0.16 |   0.26 |   0.00 |   0.00 |
|     ag |   0.44 |   0.43 |   0.41 |   0.41 |   0.41 |   0.40 |   0.17 |   0.17 |   0.17 |   0.16 |
|  ggrep |   0.25 |   0.27 |   0.28 |   0.30 |   0.59 |   0.60 |   0.25 |   0.58 |   0.00 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.03 |   0.02 |   0.02 |   0.03 |   0.02 |   0.00 |   0.00 |
|     rg |   0.13 |   0.14 |   0.18 |   0.11 |   0.21 |   0.21 |   0.12 |   0.20 |   0.00 |   0.00 |
|     ag |   1.07 |   1.07 |   0.55 |   0.45 |   0.45 |   0.45 |   0.18 |   0.21 |   0.19 |   0.21 |
|  ggrep |   0.08 |   0.10 |   0.20 |   0.22 |   1.09 |   1.10 |   0.07 |   1.07 |   0.00 |   0.00 |

grepping `x*y*z*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.10 |   0.16 |   0.09 |   0.11 |   0.11 |   0.06 |   0.11 |   0.00 |   0.00 |
|     rg |   0.09 |   0.18 |   8.64 |   1.19 |   1.19 | *fail* |   0.06 |   1.05 |   0.00 |   0.00 |
|     ag |   3.92 |   3.91 |   3.97 |   3.03 |   3.03 |   3.03 |   3.68 |   2.79 |   3.70 |   2.79 |
|  ggrep |   0.11 |   0.19 |   7.59 |   0.73 |   1.34 |  17.81 |   0.04 |   1.18 |   0.00 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |   0.00 |
|     rg |   0.05 |   0.06 |   0.06 |   0.14 |   0.14 |   0.14 |   0.05 |   0.14 |   0.00 |   0.00 |
|     ag |   0.37 |   0.38 |   0.37 |   0.37 |   0.36 |   0.36 |   0.13 |   0.12 |   0.13 |   0.12 |
|  ggrep |   0.04 |   0.05 |   0.06 |   0.07 |   0.08 |   0.08 |   0.04 |   0.06 |   0.00 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.04 |   0.05 |   0.00 |   0.00 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.60 |   0.60 |   0.50 |   0.59 |   0.60 |   0.50 |   0.19 |   0.19 |   0.19 |   0.19 |
|  ggrep |   3.40 |   3.42 |   6.95 |   3.53 |   3.68 |   7.44 |   3.39 |   3.65 |   0.00 |   0.00 |

grepping `^={2,4}[^=].*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.05 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.09 |   0.09 |   2.89 |   0.04 |   0.08 |   0.00 |   0.00 |
|     ag |   0.42 |   0.42 |   0.41 | *fail* | *fail* | *fail* |   0.14 | *fail* |   0.15 | *fail* |
|  ggrep |   0.05 |   0.08 |   0.11 |   0.08 |   0.08 |   0.12 |   0.05 |   0.05 |   0.00 |   0.00 |

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.10 |   0.10 |   0.10 |   0.10 |   0.10 |   0.05 |   0.05 |   0.00 |   0.00 |
|     rg |   0.09 |   0.18 |   8.68 |   0.88 |   0.88 | *fail* |   0.06 |   0.75 |   0.00 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   0.02 |   2.03 |
|  ggrep |   0.11 |   0.19 |   7.43 |   0.70 |   1.19 |  15.78 |   0.04 |   1.03 |   0.00 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.05 |   0.04 |   0.05 |   0.05 |   0.04 |   0.04 |   0.04 |   0.00 |   0.00 |
|     rg |   0.19 |   0.21 |   0.22 |   0.29 |   0.29 |   0.61 |   0.19 |   0.27 |   0.00 |   0.00 |
|     ag |   0.41 |   0.41 |   0.39 | *fail* | *fail* | *fail* |   0.15 | *fail* |   0.15 | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.55 |   2.98 |   2.99 |   0.05 |   2.95 |   0.00 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.10 |   0.21 |   0.04 |   0.07 |   0.00 |   0.00 |
|     rg |   0.16 |   0.18 |   0.25 |   0.23 |   0.21 |   2.14 |   0.15 |   0.17 |   0.00 |   0.00 |
|  ggrep |   0.08 |   0.10 |   0.13 |   0.11 |   0.55 |   2.44 |   0.07 |   0.49 |   0.00 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.13 |   0.15 |   0.15 |   0.13 |   0.15 |   0.00 |   0.00 |
|     rg |   0.09 |   0.17 |   7.66 |   0.31 |   0.27 |   0.27 |   0.05 |   0.27 |   0.00 |   0.01 |
|  ggrep |   0.63 |   0.65 |   0.66 |   0.65 |   0.32 |   0.36 |   0.63 |   0.30 |   0.00 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |   0.14 |   0.15 |   0.14 |   0.23 |   0.24 |   0.13 |   0.23 |   0.00 |   0.00 |
|     rg |   0.16 |   0.17 |   0.20 |   0.29 |   0.30 |   0.31 |   0.16 |   0.30 |   0.00 |   0.01 |
|  ggrep |   0.88 |   0.90 |   1.07 |   1.00 |   6.28 |   6.51 |   0.87 |   6.26 |   0.00 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.19 |   0.19 |   0.32 |   0.33 |   0.18 |   0.31 |   0.00 |   0.01 |
|     rg |   0.21 |   0.21 |   0.22 |   0.84 |   1.05 |   1.10 |   0.20 |   1.04 |   0.00 |   0.06 |
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
|  ugrep |   0.10 |   0.12 |   0.12 |   0.10 |   0.13 |   0.13 |
|     rg |   0.22 |   0.23 |   0.23 |   0.33 |   0.34 |   0.35 |
|     ag |   0.44 |   0.53 |   0.54 | *fail* | *fail* | *fail* |
|  ggrep |   0.09 |   0.12 |   0.11 |   3.03 |   3.06 |   3.05 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.09 |   0.09 |   0.08 |   0.10 |   0.10 |
|     rg |   0.03 |   0.03 |   0.03 |   0.23 |   0.23 |   0.23 |
|     ag |   0.33 |   0.41 |   0.41 |   0.50 |   0.59 |   0.59 |
|  ggrep |   0.09 |   0.09 |   0.09 |   0.23 |   0.23 |   0.23 |

## results for large long lines JSON file search

grepping `99` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.02 |   0.03 |   0.00 |   0.00 |
|     rg |   0.03 |   0.03 |   0.11 |   0.09 |   0.09 |   0.23 |   0.02 |   0.07 |   0.00 |   0.00 |
|     ag |   2.43 |   2.43 |   0.84 |   2.18 |   2.17 |   0.78 |   0.23 |   0.23 |   0.23 |   0.23 |
|  ggrep |   0.04 |   0.04 |   0.16 |   0.09 |   0.77 |   2.80 |   0.02 |   0.76 |   0.00 |   0.00 |

grepping `abc[a-z0-9]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |     -c |   -wic |     -l |   -wil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |   0.00 |
|     rg |   0.06 |   0.06 |   0.08 |   0.14 |   0.15 |   0.16 |   0.05 |   0.14 |   0.00 |   0.01 |
|     ag |   1.38 |   1.38 |   0.53 |   0.43 |   0.43 |   0.35 |   0.11 |   0.11 |   0.11 |   0.11 |
|  ggrep |   0.13 |   0.14 |   0.24 |   0.23 |   1.56 |   1.69 |   0.13 |   1.55 |   0.00 |   0.05 |

## results for OpenSSL source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.05 |        |   0.05 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.10 |        |   0.11 |        |   0.17 |        |   0.17 |        |   0.15 |        |   0.15 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.03 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.03 |        |
|     rg |   0.04 |        |   0.04 |        |   0.06 |        |   0.09 |        |   0.05 |        |   0.04 |        |
|     ag |        |   0.32 |        |   0.23 |        |   0.23 |        |   0.18 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.16 |        |   0.21 |        |   0.31 |        |   0.42 |        |   0.28 |        |   0.12 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |        |   0.02 |        |   0.02 |        |   0.02 |        |   0.03 |        |   0.02 |        |
|     rg |   0.07 |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.04 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.09 |        |   0.09 |        |   0.10 |        |   0.11 |        |   0.09 |        |   0.08 |

## results for Swift source code repo directory search

grepping `_(RUN|LIB|NAM)[A-Z_]+` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.11 |        |   0.11 |        |   0.11 |        |   0.11 |        |   0.16 |        |   0.11 |        |
|     rg |   0.22 |        |   0.30 |        |   0.25 |        |   0.30 |        |   0.23 |        |   0.23 |        |
|     ag |        |   0.27 |        |   0.22 |        |   0.22 |        |   0.22 |        |   0.22 |        |   0.27 |
|  ggrep |        |   0.41 |        |   0.49 |        |   0.53 |        |   0.54 |        |   0.48 |        |   0.46 |

grepping `String|Int|Double|Array|Dictionary` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.16 |        |   0.14 |        |   0.18 |        |   0.18 |        |   0.18 |        |   0.12 |        |
|     rg |   0.27 |        |   0.22 |        |   0.23 |        |   0.27 |        |   0.28 |        |   0.25 |        |
|     ag |        |   0.86 |        |   0.49 |        |   0.68 |        |   0.59 |        |   0.27 |        |   0.27 |
|  ggrep |        |   0.52 |        |   0.65 |        |   1.53 |        |   1.77 |        |   1.44 |        |   0.56 |

grepping `(class|struct)\sS[a-z]+T` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |        |   0.11 |        |   0.12 |        |   0.12 |        |   0.15 |        |   0.11 |        |
|     rg |   0.23 |        |   0.19 |        |   0.22 |        |   0.21 |        |   0.23 |        |   0.22 |        |
|     ag |        |   0.22 |        |   0.25 |        |   0.26 |        |   0.22 |        |   0.22 |        |   0.23 |
|  ggrep |        |   0.54 |        |   0.62 |        |   0.80 |        |   0.80 |        |   0.74 |        |   0.70 |

grepping `for\s[a-z]+\sin` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -wic |  -wicr |   -wil |  -wilr |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |        |   0.12 |        |   0.12 |        |   0.12 |        |   0.16 |        |   0.11 |        |
|     rg |   0.23 |        |   0.33 |        |   0.23 |        |   0.22 |        |   0.22 |        |   0.23 |        |
|     ag |        |   0.31 |        |   0.26 |        |   0.26 |        |   0.26 |        |   0.22 |        |   0.23 |
|  ggrep |        |   0.50 |        |   0.51 |        |   0.68 |        |   0.69 |        |   0.63 |        |   0.56 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.98 |   1.98 |   1.98 |   1.97 |   0.28 |   0.28 |
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
|     rg |   0.11 |   0.17 |   0.11 |   0.16 |   0.02 |   0.03 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.08 |   1.08 |   1.08 |   1.08 |   0.15 |   0.15 |
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
|  ugrep |   0.20 |   0.20 |   0.20 |   0.19 |   0.19 |   0.19 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.08 |   0.08 |   0.07 |   0.07 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.21 |   0.21 |   0.21 |   0.21 |   0.20 |   0.20 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


