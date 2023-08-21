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

**WARNING** performance results are meaningless when the host machine executes other tasks that load the CPU; quit all running applications first before running `./bench.sh`

important notes:

- timing results are collected with the standard 10ms resolution; a lower resolution is unusable and a higher resolution is unreliable due to the natural timing variations observed in the system
- all timed runs are warm runs, cold runs are not timed
- all timed runs of ugrep are performed without a .ugrep configuration file using the ugrep batch command
- ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files; we include option `-I` in recursive searches for a fair performance comparison
- ripgrep does not search tar file contents, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead
- ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected (note: ugrep option `-m1,` skips zero matches but is not used in this benchmark)
- ugrep `-z` is more powerful than just decompressing a single file to search, it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files within archives

# performance report x64

found ugrep 1172664 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.0.1 x86_64-apple-darwin19.6.0 +avx2 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
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
|  ugrep |   0.12 |   0.17 |   0.17 |   0.17 |   0.17 |   0.17 |   0.07 |   0.00 |
|     rg |   0.14 |   0.34 |  20.85 |   1.38 |   1.40 | *fail* |   0.98 |   0.01 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |   1.20 |
|  ggrep |   0.20 |   0.35 |  17.13 |   1.54 |   3.47 |  47.30 |   3.00 |   0.00 |

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.03 |   0.03 |   0.03 |   0.01 |
|     rg |   0.03 |   0.04 |   0.03 |   0.05 |   0.06 |   0.06 |   0.06 |   0.02 |
|     ag |   0.66 |   0.66 |   0.41 |   0.35 |   0.35 |   0.36 |   0.11 |   0.11 |
|  ggrep |   0.11 |   0.13 |   0.14 |   0.15 |   0.52 |   0.53 |   0.51 |   0.08 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.03 |   0.04 |   0.03 |   0.04 |   0.04 |   0.03 |   0.00 |
|     rg |   0.03 |   0.03 |   0.03 |   0.26 |   0.07 |   0.07 |   0.06 |   0.01 |
|     ag |   0.41 |   0.41 |   0.40 |   0.42 |   0.42 |   0.41 |   0.17 |   0.17 |
|  ggrep |   0.21 |   0.22 |   0.22 |   0.33 |   0.30 |   0.29 |   0.28 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.05 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |
|     rg |   0.10 |   0.11 |   0.14 |   0.11 |   0.11 |   0.12 |   0.12 |   0.01 |
|     ag |   1.85 |   1.85 |   0.62 |   0.43 |   0.43 |   0.42 |   0.18 |   0.18 |
|  ggrep |   0.11 |   0.13 |   0.36 |   0.37 |   1.72 |   1.73 |   1.69 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.06 |   0.06 |   0.06 |   0.06 |   0.05 |   0.05 |   0.00 |
|     rg |   0.20 |   0.24 |   0.26 |   0.37 |   0.37 |   0.79 |   0.32 |   0.01 |
|     ag |   0.40 |   0.40 |   0.39 | *fail* | *fail* | *fail* | *fail* | *fail* |
|  ggrep |   0.10 |   0.14 |   0.14 |   2.87 |   4.72 |   4.73 |   4.63 |   0.00 |

## results for large text file search words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.07 |   0.06 |   0.08 |   0.24 |   0.24 |   0.18 |   0.00 |
|     rg |   0.08 |   0.09 |   0.17 |   0.31 |   2.64 |   0.20 |   0.01 |
|  ggrep |   0.16 |   0.21 |   0.17 |   0.97 |   4.30 |   0.82 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.26 |   0.25 |   0.25 |   0.28 |   0.27 |   0.28 |   0.00 |
|     rg |   0.33 |  19.00 |   0.39 |   0.35 |   0.35 |   0.34 |   0.02 |
|  ggrep |   0.97 |   0.97 |   0.97 |   0.42 |   0.49 |   0.40 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.30 |   0.28 |   0.27 |   0.40 |   0.40 |   0.39 |   0.00 |
|     rg |   1.97 |   2.36 |   0.39 |   0.42 |   0.41 |   0.40 |   0.04 |
|  ggrep |   1.40 |   1.62 |   1.49 |   9.71 |  10.05 |   9.73 |   0.02 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.25 |   0.24 |   0.28 |   0.54 |   0.53 |   0.50 |   0.02 |
|     rg |   0.36 |   0.37 |   1.73 |   2.05 |   2.12 |   1.88 |   0.17 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for large text file search with formatted output

grepping `Sherlock|Holmes` elapsed real time (s)

| search | --json |  --csv |  --xml |  --hex |
| -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.02 |   0.03 |   0.02 |   0.03 |
|     rg |   0.03 | *fail* | *fail* | *fail* |
|     ag |   0.40 | *fail* |   0.40 | *fail* |

## results for large text file search with replaced output

grepping `flop` elapsed real time (s)

| search | --replace=flip |
| -----: | -----: |
|  ugrep |   0.03 |
|     rg |   0.03 |

## results for large text file search with context

grepping `^$` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |   0.06 |
|     rg |   0.25 |   0.26 |   0.27 |   0.48 |   0.48 |   0.49 |
|     ag |   0.49 |   0.72 |   0.72 | *fail* | *fail* | *fail* |
|  ggrep |   0.16 |   0.18 |   0.18 |   4.94 |   4.94 |   4.95 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.09 |   0.13 |   0.13 |   0.10 |   0.14 |   0.14 |
|     rg |   0.03 |   0.03 |   0.03 |   0.09 |   0.09 |   0.09 |
|     ag |   0.40 |   0.58 |   0.58 |   0.42 |   0.61 |   0.62 |
|  ggrep |   0.13 |   0.13 |   0.13 |   0.29 |   0.31 |   0.29 |

## results for source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.03 |        |   0.04 |        |   0.05 |        |   0.05 |        |   0.04 |        |   0.05 |        |
|     ag |        |   0.05 |        |   0.06 |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.15 |        |   0.17 |        |   0.23 |        |   0.23 |        |   0.22 |        |   0.23 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.04 |        |
|     rg |   0.05 |        |   0.07 |        |   0.08 |        |   0.15 |        |   0.07 |        |   0.06 |        |
|     ag |        |   0.50 |        |   0.35 |        |   0.34 |        |   0.22 |        |   0.08 |        |   0.08 |
|  ggrep |        |   0.24 |        |   0.31 |        |   0.54 |        |   0.73 |        |   0.46 |        |   0.21 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.03 |        |   0.04 |        |   0.07 |        |   0.07 |        |   0.07 |        |   0.07 |        |
|     ag |        |   0.06 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.13 |        |   0.13 |        |   0.16 |        |   0.15 |        |   0.14 |        |   0.14 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   3.23 |   3.23 |   3.24 |   3.38 |   0.50 |   0.51 |
|     rg |   3.36 |   3.36 |   3.35 |   3.53 |   0.49 |   0.52 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for gz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.49 |   0.49 |   0.50 |   0.50 |   0.07 |   0.07 |
|     rg |   0.41 |   0.43 |   0.42 |   0.43 |   0.06 |   0.07 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for lz4 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.10 |   0.09 |   0.10 |   0.09 |   0.02 |   0.02 |
|     rg |   0.12 |   0.17 |   0.13 |   0.17 |   0.03 |   0.05 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for xz compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.45 |   1.45 |   1.47 |   1.44 |   0.21 |   0.21 |
|     rg |   1.56 |   1.53 |   1.54 |   1.56 |   0.23 |   0.23 |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for zstd compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.19 |   0.20 |   0.19 |   0.19 |   0.03 |   0.03 |
|     rg |   0.16 |   0.18 |   0.16 |   0.17 | *fail* |   0.04 |
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
|  ugrep |   0.17 |   0.16 |   0.14 |   0.14 |   0.17 |   0.14 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

## results for compressed tarball search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.36 |   0.37 |   0.36 |   0.36 |   0.36 |   0.36 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |



# performance report arm64

found ugrep 1091266 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.0.1 arm-apple-darwin21.6.0 +neon/AArch64 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
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
|  ggrep |   0.11 |   0.19 |   7.44 |   0.70 |   1.19 |  15.79 |   1.03 |   0.00 |

grepping `rol` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |
|     rg |   0.08 |   0.08 |   0.09 |   0.10 |   0.14 |   0.14 |   0.14 |   0.02 |
|     ag |   0.54 |   0.54 |   0.43 |   0.40 |   0.40 |   0.40 |   0.16 |   0.17 |
|  ggrep |   0.10 |   0.12 |   0.13 |   0.13 |   0.38 |   0.38 |   0.36 |   0.05 |

grepping `cycles|semigroups` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.03 |   0.00 |
|     rg |   0.20 |   0.20 |   0.20 |   0.25 |   0.22 |   0.22 |   0.21 |   0.00 |
|     ag |   0.52 |   0.52 |   0.52 |   0.51 |   0.51 |   0.50 |   0.27 |   0.27 |
|  ggrep |   0.15 |   0.17 |   0.17 |   0.26 |   0.24 |   0.24 |   0.22 |   0.00 |

grepping `ab(cd?)?` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.02 |   0.02 |   0.02 |   0.02 |   0.00 |
|     rg |   0.13 |   0.14 |   0.18 |   0.11 |   0.21 |   0.21 |   0.20 |   0.00 |
|     ag |   1.07 |   1.07 |   0.56 |   0.46 |   0.46 |   0.45 |   0.21 |   0.21 |
|  ggrep |   0.08 |   0.10 |   0.20 |   0.21 |   1.09 |   1.10 |   1.07 |   0.00 |

grepping `^$` elapsed real time (s)

| search |        |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.04 |   0.03 |   0.00 |
|     rg |   0.19 |   0.21 |   0.22 |   0.29 |   0.29 |   0.62 |   0.27 |   0.00 |
|     ag |   0.41 |   0.41 |   0.40 | *fail* | *fail* | *fail* | *fail* | *fail* |
|  ggrep |   0.06 |   0.09 |   0.09 |   1.54 |   2.98 |   2.99 |   2.94 |   0.00 |

## results for large text file search words from files

grepping `-fwords/1.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.05 |   0.05 |   0.05 |   0.21 |   0.21 |   0.18 |   0.00 |
|     rg |   0.17 |   0.25 |   0.23 |   0.21 |   2.15 |   0.17 |   0.00 |
|  ggrep |   0.10 |   0.13 |   0.11 |   0.55 |   2.44 |   0.49 |   0.00 |

grepping `-fwords/2.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.13 |   0.13 |   0.13 |   0.15 |   0.15 |   0.15 |   0.00 |
|     rg |   0.17 |   7.67 |   0.31 |   0.27 |   0.27 |   0.27 |   0.01 |
|  ggrep |   0.65 |   0.66 |   0.65 |   0.32 |   0.36 |   0.30 |   0.00 |

grepping `-fwords/3.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.15 |   0.15 |   0.14 |   0.24 |   0.24 |   0.23 |   0.00 |
|     rg |   0.17 |   0.20 |   0.29 |   0.30 |   0.31 |   0.30 |   0.01 |
|  ggrep |   0.91 |   1.07 |   1.00 |   6.30 |   6.54 |   6.28 |   0.01 |

grepping `-fwords/4.txt` elapsed real time (s)

| search |     -n |    -no |    -wn |   -win |  -wino |   -cwi |   -lwi |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.20 |   0.19 |   0.20 |   0.33 |   0.33 |   0.33 |   0.01 |
|     rg |   0.21 |   0.22 |   0.84 |   1.05 |   1.10 |   1.04 |   0.06 |
|  ggrep | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |

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
|     rg |   0.22 |   0.23 |   0.23 |   0.33 |   0.34 |   0.35 |
|     ag |   0.45 |   0.54 |   0.55 | *fail* | *fail* | *fail* |
|  ggrep |   0.09 |   0.12 |   0.11 |   3.07 |   3.06 |   3.05 |

grepping `Sherlock|Holmes` elapsed real time (s)

| search |    -A1 |    -B1 |    -C1 | -winA1 | -winB1 | -winC1 |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.06 |   0.09 |   0.09 |   0.08 |   0.10 |   0.10 |
|     rg |   0.03 |   0.03 |   0.03 |   0.23 |   0.23 |   0.23 |
|     ag |   0.33 |   0.41 |   0.42 |   0.51 |   0.59 |   0.59 |
|  ggrep |   0.09 |   0.09 |   0.09 |   0.23 |   0.23 |   0.23 |

## results for source code repo directory search

grepping `FIXME|TODO` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.04 |        |   0.05 |        |   0.04 |        |   0.05 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.10 |        |   0.12 |        |   0.17 |        |   0.18 |        |   0.16 |        |   0.15 |

grepping `char|int|long|size_t|void` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.05 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |
|     rg |   0.04 |        |   0.04 |        |   0.05 |        |   0.09 |        |   0.04 |        |   0.04 |        |
|     ag |        |   0.32 |        |   0.23 |        |   0.23 |        |   0.18 |        |   0.05 |        |   0.05 |
|  ggrep |        |   0.16 |        |   0.21 |        |   0.32 |        |   0.43 |        |   0.29 |        |   0.13 |

grepping `ssl-?3(\.[0-9]+)?` elapsed real time (s)

| search |     -n |    -nr |    -wn |   -wnr |   -win |  -winr |  -wino | -winor |   -cwi |  -cwir |   -lwi |  -lwir |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   0.04 |        |   0.04 |        |   0.04 |        |   0.05 |        |   0.04 |        |   0.04 |        |
|     rg |   0.05 |        |   0.04 |        |   0.05 |        |   0.06 |        |   0.05 |        |   0.05 |        |
|     ag |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |        |   0.04 |
|  ggrep |        |   0.10 |        |   0.10 |        |   0.11 |        |   0.11 |        |   0.09 |        |   0.09 |

## results for bz2 compressed large text file search

grepping `landsnail` elapsed real time (s)

| search |     -z |  -zwin |    -zc |  -zwic |    -zl |  -zwil |
| -----: | -----: | -----: | -----: | -----: | -----: | -----: |
|  ugrep |   1.97 |   1.97 |   1.97 |   1.97 |   0.28 |   0.28 |
|     rg |   2.20 |   2.01 |   2.00 |   2.00 |   0.27 |   0.29 |
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
|     rg |   1.12 |   1.12 |   1.12 |   1.12 |   0.15 |   0.16 |
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
|  ugrep |   0.20 |   0.20 |   0.19 |   0.19 |   0.19 |   0.19 |
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
|  ugrep |   0.21 |   0.21 |   0.20 |   0.21 |   0.19 |   0.20 |
|     rg | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |
|     ag | *fail* | *fail* | *fail* | *fail* | *fail* | *fail* |


