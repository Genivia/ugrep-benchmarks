# performance reports

[performance report x64](#performance-report-x64)

[performance report arm64](#performance-report-arm64)

Intel machine:
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

**WARNING** performance results are meaningless when the host machine executes other tasks that load the CPU; quit all running applications first and check for running background processes (with e.g. `top`) before running `./bench.sh`

important notes:

- timing results are collected with the standard 10ms resolution; a lower resolution is unusable and a higher resolution is unreliable due to the natural timing variations observed in the system
- all timed runs are warm runs, cold runs are not timed
- all timed runs of ugrep are performed without a .ugrep configuration file using the ugrep batch command
- all regex patterns tested are fully compliant with the common ERE standard syntax; a failure may occur if a grep tool fails to parse ERE (ripgrep failing to parse `[][a-z]` in URL pattern testing, `[\[\]a-z]` works but this is not compliant and GNU grep fails)
- ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files; we include option `-I` in recursive searches for a fair performance comparison
- ripgrep does not search tar file contents, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead
- ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected (note: ugrep option `-m1,` skips zero matches but is not used in this benchmark)
- ugrep `-z` is more powerful than just decompressing a single file to search, it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files within archives
- ugrep context options `-ABC` are a bit sub-optimal because of double buffering (input buffer and context buffer), which will be optimized soon in a future release
- ugrep line matching and option `-c` will be optimized in a future release; when matching lines, the idea is to skip to the next line when permitted instead of continuing matching on the same line, an optimization that is effectively performed by GNU grep and copied by other grep

# performance report x64

found ugrep 1172664 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.0.2 x86_64-apple-darwin19.6.0 +avx2 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
License BSD-3-Clause: <https://opensource.org/licenses/BSD-3-Clause>
Written by Robert van Engelen and others: <https://github.com/Genivia/ugrep>
~~~

found rg 6075312 byte executable located at /opt/local/bin/rg
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

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.12 |   0.17 |   0.17 |   0.17 |   0.17 |   0.17 |   0.08 |   0.00 |
|     rg |   0.14 |   0.34 |  20.79 |   1.41 |   1.38 | *fail* |   0.98 |   0.01 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   1.21 |
|  ggrep |   0.20 |   0.35 |  17.17 |   1.53 |   3.40 |  47.53 |   3.03 |   0.00 |

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.01 |
|     rg |   0.03 |   0.04 |   0.04 |   0.05 |   0.06 |   0.06 |   0.06 |   0.02 |
|     ag |   0.66 |   0.66 |   0.41 |   0.35 |   0.35 |   0.35 |   0.11 |   0.11 |
|  ggrep |   0.11 |   0.13 |   0.15 |   0.16 |   0.52 |   0.56 |   0.52 |   0.08 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.03 |   0.03 |   0.04 |   0.04 |   0.04 |   0.04 |   0.00 |
|     rg |   0.03 |   0.03 |   0.04 |   0.25 |   0.07 |   0.07 |   0.07 |   0.01 |
|     ag |   0.41 |   0.41 |   0.42 |   0.42 |   0.42 |   0.42 |   0.17 |   0.17 |
|  ggrep |   0.20 |   0.22 |   0.22 |   0.32 |   0.30 |   0.30 |   0.28 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.05 |   0.04 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |
|     rg |   0.09 |   0.12 |   0.14 |   0.11 |   0.12 |   0.12 |   0.11 |   0.01 |
|     ag |   1.86 |   1.86 |   0.63 |   0.44 |   0.43 |   0.43 |   0.18 |   0.18 |
|  ggrep |   0.11 |   0.13 |   0.36 |   0.38 |   1.74 |   1.73 |   1.69 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.06 |   0.05 |   0.06 |   0.06 |   0.06 |   0.01 |
|     rg |   0.07 |   0.07 |   0.07 |   0.17 |   0.25 |   0.24 |   0.24 |   0.01 |
|     ag |   0.44 |   0.45 |   0.40 |   0.41 |   0.41 |   0.40 |   0.15 |   0.15 |
|  ggrep |   0.36 |   0.37 |   0.38 |   0.41 |   0.84 |   0.85 |   0.83 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |
|     rg |   0.06 |   0.06 |   0.06 |   0.16 |   0.16 |   0.15 |   0.16 |   0.01 |
|     ag |   0.41 |   0.41 |   0.40 |   0.41 |   0.41 |   0.40 |   0.15 |   0.15 |
|  ggrep |   0.05 |   0.07 |   0.07 |   0.09 |   0.10 |   0.11 |   0.08 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.08 |   0.06 |   0.08 |   0.09 |   0.08 |   0.08 |   0.02 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.80 |   0.79 |   0.56 |   0.80 |   0.80 |   0.56 |   0.17 |   0.17 |
|  ggrep |   5.70 |   5.84 |  11.66 |   5.85 |   6.04 |  12.18 |   5.97 |   0.01 |

grepping `^={2,4}[^=].*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.01 |
|     rg |   0.05 |   0.06 |   0.08 |   0.13 |   0.14 |   3.39 |   0.11 |   0.01 |
|     ag |   0.40 |   0.40 |   0.40 | *fail* | *fail* | *fail* | *fail* | *fail* |
|  ggrep |   0.12 |   0.14 |   0.25 |   0.14 |   0.15 |   0.27 |   0.12 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.05 |   0.05 |   0.00 |
|     rg |   0.20 |   0.24 |   0.25 |   0.37 |   0.37 |   0.78 |   0.31 |   0.01 |
|     ag |   0.41 |   0.41 |   0.38 | *fail* | *fail* | *fail* | *fail* | *fail* |
|  ggrep |   0.10 |   0.14 |   0.14 |   2.89 |   4.70 |   4.72 |   4.69 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.07 |   0.06 |   0.07 |   0.24 |   0.25 |   0.19 |   0.00 |
|     rg |   0.05 |   0.07 |   0.09 |   0.16 |   0.29 |   2.65 |   0.20 |   0.01 |
|  ggrep |   0.13 |   0.16 |   0.21 |   0.17 |   0.98 |   4.27 |   0.83 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |   0.27 |   0.26 |   0.26 |   0.29 |   0.28 |   0.28 |   0.00 |
|     rg |   0.13 |   0.33 |  18.84 |   0.40 |   0.35 |   0.34 |   0.33 |   0.02 |
|  ggrep |   0.96 |   0.95 |   0.96 |   0.96 |   0.43 |   0.49 |   0.41 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |   0.30 |   0.29 |   0.28 |   0.42 |   0.40 |   0.41 |   0.00 |
|     rg |   1.95 |   1.97 |   2.36 |   0.39 |   0.42 |   0.41 |   0.40 |   0.04 |
|  ggrep |   1.40 |   1.40 |   1.62 |   1.49 |   9.69 |  10.00 |   9.62 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.24 |   0.24 |   0.24 |   0.25 |   0.50 |   0.47 |   0.47 |   0.02 |
|     rg |   0.34 |   0.35 |   0.35 |   1.51 |   1.92 |   1.94 |   1.87 |   0.17 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.03 |
|     rg |   0.03 | *fail* | *fail* | *fail* |
|     ag |   0.40 | *fail* |   0.39 | *fail* |

## results for large text file search with replaced output

grepping `flop` elapsed real time (s)

| search | --replace=flip |
| -----: | -----: |
|  ugrep |   0.02 |
|     rg |   0.03 |

## results for large text file search with context

grepping `^$` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |
|     rg |   0.25 |   0.25 |   0.26 |   0.47 |   0.46 |   0.49 |
|     ag |   0.49 |   0.71 |   0.74 | *fail* | *fail* | *fail* |
|  ggrep |   0.16 |   0.18 |   0.18 |   4.89 |   4.95 |   4.96 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.13 |   0.13 |   0.10 |   0.13 |   0.13 |
|     rg |   0.04 |   0.03 |   0.04 |   0.09 |   0.09 |   0.09 |
|     ag |   0.40 |   0.58 |   0.59 |   0.43 |   0.60 |   0.61 |
|  ggrep |   0.13 |   0.13 |   0.13 |   0.29 |   0.29 |   0.29 |

## results for source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.03 |        |   0.04 |        |   0.05 |        |   0.05 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.15 |        |   0.16 |        |   0.23 |        |   0.24 |        |   0.22 |        |   0.22 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.04 |        |
|     rg |   0.05 |        |   0.07 |        |   0.08 |        |   0.15 |        |   0.07 |        |   0.06 |        |
|     ag |        |   0.50 |        |   0.34 |        |   0.35 |        |   0.22 |        |   0.08 |        |   0.08 |
|  ggrep |        |   0.24 |        |   0.32 |        |   0.52 |        |   0.73 |        |   0.48 |        |   0.20 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.08 |        |
|     ag |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.13 |        |   0.13 |        |   0.15 |        |   0.16 |        |   0.14 |        |   0.14 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.23 |   3.32 |   3.28 |   3.23 |   0.46 |   0.47 |
|     rg |   3.37 |   3.36 |   3.37 |   3.34 |   0.47 |   0.49 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.48 |   0.49 |   0.48 |   0.49 |   0.07 |   0.07 |
|     rg |   0.41 |   0.42 |   0.41 |   0.41 |   0.06 |   0.07 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.11 |   0.09 |   0.10 |   0.02 |   0.02 |
|     rg |   0.12 |   0.16 |   0.12 |   0.16 |   0.03 |   0.05 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.45 |   1.45 |   1.44 |   1.44 |   0.21 |   0.21 |
|     rg |   1.55 |   1.55 |   1.57 |   1.57 |   0.23 |   0.23 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.19 |   0.19 |   0.19 |   0.03 |   0.03 |
|     rg |   0.18 |   0.19 |   0.17 |   0.19 | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.31 |   0.31 |   0.30 |   0.30 |   0.30 |   0.30 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.17 |   0.17 |   0.14 |   0.14 |   0.16 |   0.15 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.37 |   0.37 |   0.35 |   0.36 |   0.36 |   0.35 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1091266 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.0.2 arm-apple-darwin21.6.0 +neon/AArch64 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
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

grepping `''` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.08 |   0.10 |   0.10 |   0.10 |   0.10 |   0.10 |   0.05 |   0.00 |
|     rg |   0.09 |   0.18 |   8.68 |   0.88 |   0.88 | *fail* |   0.75 |   0.00 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   2.03 |
|  ggrep |   0.11 |   0.19 |   7.44 |   0.70 |   1.19 |  15.83 |   1.03 |   0.00 |

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |
|     rg |   0.08 |   0.08 |   0.09 |   0.10 |   0.14 |   0.14 |   0.14 |   0.02 |
|     ag |   0.55 |   0.54 |   0.43 |   0.41 |   0.40 |   0.40 |   0.16 |   0.17 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.38 |   0.38 |   0.36 |   0.05 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |
|     rg |   0.20 |   0.20 |   0.20 |   0.25 |   0.22 |   0.22 |   0.21 |   0.00 |
|     ag |   0.52 |   0.52 |   0.52 |   0.51 |   0.50 |   0.50 |   0.27 |   0.27 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.22 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |
|     rg |   0.13 |   0.14 |   0.18 |   0.11 |   0.21 |   0.21 |   0.20 |   0.00 |
|     ag |   1.07 |   1.07 |   0.56 |   0.45 |   0.45 |   0.46 |   0.21 |   0.21 |
|  ggrep |   0.08 |   0.10 |   0.20 |   0.21 |   1.09 |   1.10 |   1.07 |   0.00 |

grepping `ro[a-z]*ds` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.00 |
|     rg |   0.16 |   0.16 |   0.16 |   0.21 |   0.27 |   0.27 |   0.26 |   0.00 |
|     ag |   0.44 |   0.44 |   0.42 |   0.42 |   0.41 |   0.41 |   0.17 |   0.17 |
|  ggrep |   0.25 |   0.27 |   0.28 |   0.30 |   0.59 |   0.60 |   0.59 |   0.00 |

grepping `(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |
|     rg |   0.05 |   0.06 |   0.06 |   0.14 |   0.14 |   0.14 |   0.14 |   0.00 |
|     ag |   0.38 |   0.38 |   0.38 |   0.37 |   0.36 |   0.36 |   0.12 |   0.12 |
|  ggrep |   0.04 |   0.05 |   0.06 |   0.07 |   0.08 |   0.08 |   0.06 |   0.00 |

grepping `(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.06 |   0.06 |   0.05 |   0.00 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag |   0.60 |   0.60 |   0.50 |   0.59 |   0.60 |   0.50 |   0.19 |   0.19 |
|  ggrep |   3.40 |   3.43 |   6.95 |   3.53 |   3.68 |   7.45 |   3.66 |   0.00 |

grepping `^={2,4}[^=].*` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.00 |
|     rg |   0.04 |   0.05 |   0.06 |   0.09 |   0.09 |   2.90 |   0.08 |   0.00 |
|     ag |   0.42 |   0.42 |   0.42 | *fail* | *fail* | *fail* | *fail* | *fail* |
|  ggrep |   0.05 |   0.08 |   0.11 |   0.08 |   0.08 |   0.12 |   0.05 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.00 |
|     rg |   0.19 |   0.21 |   0.22 |   0.29 |   0.29 |   0.62 |   0.27 |   0.00 |
|     ag |   0.41 |   0.41 |   0.40 | *fail* | *fail* | *fail* | *fail* | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.54 |   2.99 |   2.99 |   2.95 |   0.00 |

## results for large text file search for words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.05 |   0.21 |   0.21 |   0.18 |   0.00 |
|     rg |   0.16 |   0.18 |   0.25 |   0.23 |   0.21 |   2.15 |   0.17 |   0.00 |
|  ggrep |   0.08 |   0.10 |   0.13 |   0.11 |   0.55 |   2.44 |   0.49 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.13 |   0.15 |   0.15 |   0.15 |   0.00 |
|     rg |   0.09 |   0.17 |   7.66 |   0.31 |   0.27 |   0.27 |   0.27 |   0.01 |
|  ggrep |   0.63 |   0.65 |   0.66 |   0.65 |   0.32 |   0.36 |   0.30 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.15 |   0.15 |   0.15 |   0.14 |   0.24 |   0.24 |   0.24 |   0.00 |
|     rg |   0.16 |   0.17 |   0.20 |   0.28 |   0.30 |   0.31 |   0.30 |   0.01 |
|  ggrep |   0.88 |   0.90 |   1.07 |   1.00 |   6.29 |   6.52 |   6.31 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |   0.20 |   0.19 |   0.20 |   0.33 |   0.33 |   0.33 |   0.01 |
|     rg |   0.21 |   0.21 |   0.22 |   0.85 |   1.05 |   1.10 |   1.04 |   0.06 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

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
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |
|     rg |   0.22 |   0.23 |   0.23 |   0.33 |   0.35 |   0.35 |
|     ag |   0.45 |   0.53 |   0.55 | *fail* | *fail* | *fail* |
|  ggrep |   0.09 |   0.12 |   0.11 |   3.03 |   3.06 |   3.05 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.09 |   0.09 |   0.08 |   0.11 |   0.11 |
|     rg |   0.03 |   0.03 |   0.03 |   0.23 |   0.23 |   0.23 |
|     ag |   0.33 |   0.41 |   0.41 |   0.50 |   0.59 |   0.59 |
|  ggrep |   0.09 |   0.09 |   0.09 |   0.23 |   0.23 |   0.24 |

## results for source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.05 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |
|     rg |   0.05 |        |   0.05 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.10 |        |   0.12 |        |   0.17 |        |   0.17 |        |   0.15 |        |   0.15 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.04 |        |   0.05 |        |   0.05 |        |   0.09 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.32 |        |   0.23 |        |   0.23 |        |   0.18 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.16 |        |   0.21 |        |   0.32 |        |   0.43 |        |   0.28 |        |   0.13 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.05 |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.06 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.10 |        |   0.10 |        |   0.11 |        |   0.11 |        |   0.09 |        |   0.09 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.97 |   1.97 |   1.97 |   1.97 |   0.28 |   0.28 |
|     rg |   2.00 |   2.00 |   2.00 |   2.00 |   0.27 |   0.29 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |   0.30 |   0.30 |   0.30 |   0.04 |   0.04 |
|     rg |   0.29 |   0.30 |   0.30 |   0.30 |   0.04 |   0.04 |
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
|  ugrep |   1.09 |   1.09 |   1.08 |   1.08 |   0.15 |   0.15 |
|     rg |   1.11 |   1.12 |   1.11 |   1.12 |   0.16 |   0.16 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.14 |   0.14 |   0.14 |   0.14 |   0.02 |   0.02 |
|     rg |   0.12 |   0.13 |   0.12 |   0.13 |   0.02 | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zip archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |   0.20 |   0.20 |   0.20 |   0.19 |   0.19 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for tar archived repo search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.09 |   0.09 |   0.08 |   0.07 |   0.07 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.22 |   0.22 |   0.21 |   0.21 |   0.20 |   0.20 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


