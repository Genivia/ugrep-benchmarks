# performance report i386

found ugrep 1172664 byte executable located at /usr/local/bin/ugrep
~~~
ugrep 4.0.0 x86_64-apple-darwin19.6.0 +avx2 +pcre2jit +zlib +bzip2 +lzma +lz4 +zstd
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

found ggreo 263184 byte executable located at /usr/local/bin/ggrep
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

important notes

- timing results are collected with the standard 10ms resolution; a lower resolution is unreliable due to the natural timing variations observed in the system
- all timed runs are warm runs, cold runs are not timed
- all timed runs of ugrep are performed without a .ugrep configuration file using the ugrep batch command
- ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files; we include option `-I` in recursive searches for a fair performance comparison
- ripgrep does not search tar file contents, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead
- ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected (note: ugrep option `-m1,` skips zero matches but is not used in this benchmark)
- ugrep `-z` is more powerful than just decompressing a single file to search, it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files within archives

**WARNING** performance results are meaningless when the host machine executes other tasks that load the CPU; quit all running applications first

## large text file search

### grepping ` ''`

`ugrep '' corpi/enwik8`
real 0.12
user 0.10
sys 0.04

`rg '' corpi/enwik8`
real 0.14
user 0.11
sys 0.06

`ag '' corpi/enwik8`
**ERROR!**

`ggrep -E '' corpi/enwik8`
**ERROR!**

### grepping `-n ''`

`ugrep -n '' corpi/enwik8`
real 0.17
user 0.14
sys 0.05

`rg -n '' corpi/enwik8`
real 0.33
user 0.30
sys 0.07

`ag -n '' corpi/enwik8`
**ERROR!**

`ggrep -E -n '' corpi/enwik8`
**ERROR!**

### grepping `-no ''`

`ugrep -no '' corpi/enwik8`
real 0.17
user 0.14
sys 0.05

`rg -no '' corpi/enwik8`
real 20.83
user 20.73
sys 0.44

`ag -no '' corpi/enwik8`
**ERROR!**

`ggrep -E -no '' corpi/enwik8`
**ERROR!**

### grepping `-wn ''`

`ugrep -wn '' corpi/enwik8`
real 0.17
user 0.14
sys 0.05

`rg -wn '' corpi/enwik8`
real 1.40
user 1.35
sys 0.08

`ag -wn '' corpi/enwik8`
**ERROR!**

`ggrep -E -wn '' corpi/enwik8`
**ERROR!**

### grepping `-win ''`

`ugrep -win '' corpi/enwik8`
real 0.17
user 0.14
sys 0.05

`rg -win '' corpi/enwik8`
real 1.40
user 1.35
sys 0.09

`ag -win '' corpi/enwik8`
**ERROR!**

`ggrep -E -win '' corpi/enwik8`
**ERROR!**

### grepping `-wino ''`

`ugrep -wino '' corpi/enwik8`
real 0.17
user 0.14
sys 0.04

`rg -wino '' corpi/enwik8`
**ERROR!**

`ag -wino '' corpi/enwik8`
**ERROR!**

`ggrep -E -wino '' corpi/enwik8`
**ERROR!**

### grepping `-cwi ''`

`ugrep -cwi '' corpi/enwik8`
real 0.08
user 0.06
sys 0.02

`rg -cwi '' corpi/enwik8`
real 0.97
user 0.95
sys 0.01

`ag -cwi '' corpi/enwik8`
**ERROR!**

`ggrep -E -cwi '' corpi/enwik8`
**ERROR!**

### grepping `-lwi ''`

`ugrep -lwi '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi '' corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ag -lwi '' corpi/enwik8`
real 1.20
user 1.09
sys 0.10

`ggrep -E -lwi '' corpi/enwik8`
**ERROR!**

### grepping ` 'rol'`

`ugrep rol corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg rol corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`ag rol corpi/enwik8`
real 0.66
user 0.60
sys 0.05

`ggrep -E rol corpi/enwik8`
**ERROR!**

### grepping `-n 'rol'`

`ugrep -n rol corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg -n rol corpi/enwik8`
real 0.04
user 0.01
sys 0.02

`ag -n rol corpi/enwik8`
real 0.66
user 0.59
sys 0.05

`ggrep -E -n rol corpi/enwik8`
**ERROR!**

### grepping `-no 'rol'`

`ugrep -no rol corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg -no rol corpi/enwik8`
real 0.04
user 0.02
sys 0.02

`ag -no rol corpi/enwik8`
real 0.40
user 0.34
sys 0.05

`ggrep -E -no rol corpi/enwik8`
**ERROR!**

### grepping `-wn 'rol'`

`ugrep -wn rol corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`rg -wn rol corpi/enwik8`
real 0.06
user 0.03
sys 0.02

`ag -wn rol corpi/enwik8`
real 0.35
user 0.29
sys 0.05

`ggrep -E -wn rol corpi/enwik8`
**ERROR!**

### grepping `-win 'rol'`

`ugrep -win rol corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg -win rol corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`ag -win rol corpi/enwik8`
real 0.35
user 0.29
sys 0.05

`ggrep -E -win rol corpi/enwik8`
**ERROR!**

### grepping `-wino 'rol'`

`ugrep -wino rol corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg -wino rol corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`ag -wino rol corpi/enwik8`
real 0.35
user 0.29
sys 0.05

`ggrep -E -wino rol corpi/enwik8`
**ERROR!**

### grepping `-cwi 'rol'`

`ugrep -cwi rol corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg -cwi rol corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`ag -cwi rol corpi/enwik8`
real 0.11
user 0.05
sys 0.05

`ggrep -E -cwi rol corpi/enwik8`
**ERROR!**

### grepping `-lwi 'rol'`

`ugrep -lwi rol corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg -lwi rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -lwi rol corpi/enwik8`
real 0.11
user 0.04
sys 0.05

`ggrep -E -lwi rol corpi/enwik8`
**ERROR!**

### grepping ` 'cycles|semigroups'`

`ugrep cycles|semigroups corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg cycles|semigroups corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`ag cycles|semigroups corpi/enwik8`
real 0.42
user 0.36
sys 0.05

`ggrep -E cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-n 'cycles|semigroups'`

`ugrep -n cycles|semigroups corpi/enwik8`
real 0.04
user 0.01
sys 0.01

`rg -n cycles|semigroups corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`ag -n cycles|semigroups corpi/enwik8`
real 0.42
user 0.35
sys 0.05

`ggrep -E -n cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-no 'cycles|semigroups'`

`ugrep -no cycles|semigroups corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg -no cycles|semigroups corpi/enwik8`
real 0.04
user 0.01
sys 0.01

`ag -no cycles|semigroups corpi/enwik8`
real 0.40
user 0.34
sys 0.05

`ggrep -E -no cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-wn 'cycles|semigroups'`

`ugrep -wn cycles|semigroups corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg -wn cycles|semigroups corpi/enwik8`
real 0.26
user 0.24
sys 0.02

`ag -wn cycles|semigroups corpi/enwik8`
real 0.42
user 0.36
sys 0.05

`ggrep -E -wn cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-win 'cycles|semigroups'`

`ugrep -win cycles|semigroups corpi/enwik8`
real 0.04
user 0.02
sys 0.02

`rg -win cycles|semigroups corpi/enwik8`
real 0.07
user 0.05
sys 0.02

`ag -win cycles|semigroups corpi/enwik8`
real 0.42
user 0.36
sys 0.05

`ggrep -E -win cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-wino 'cycles|semigroups'`

`ugrep -wino cycles|semigroups corpi/enwik8`
real 0.04
user 0.02
sys 0.02

`rg -wino cycles|semigroups corpi/enwik8`
real 0.07
user 0.05
sys 0.01

`ag -wino cycles|semigroups corpi/enwik8`
real 0.41
user 0.35
sys 0.06

`ggrep -E -wino cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-cwi 'cycles|semigroups'`

`ugrep -cwi cycles|semigroups corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg -cwi cycles|semigroups corpi/enwik8`
real 0.07
user 0.05
sys 0.02

`ag -cwi cycles|semigroups corpi/enwik8`
real 0.17
user 0.11
sys 0.05

`ggrep -E -cwi cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping `-lwi 'cycles|semigroups'`

`ugrep -lwi cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi cycles|semigroups corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`ag -lwi cycles|semigroups corpi/enwik8`
real 0.17
user 0.11
sys 0.05

`ggrep -E -lwi cycles|semigroups corpi/enwik8`
**ERROR!**

### grepping ` 'ab(cd?)?'`

`ugrep ab(cd?)? corpi/enwik8`
real 0.06
user 0.03
sys 0.03

`rg ab(cd?)? corpi/enwik8`
real 0.10
user 0.08
sys 0.03

`ag ab(cd?)? corpi/enwik8`
real 1.88
user 1.82
sys 0.07

`ggrep -E ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-n 'ab(cd?)?'`

`ugrep -n ab(cd?)? corpi/enwik8`
real 0.05
user 0.03
sys 0.02

`rg -n ab(cd?)? corpi/enwik8`
real 0.11
user 0.09
sys 0.03

`ag -n ab(cd?)? corpi/enwik8`
real 1.85
user 1.78
sys 0.07

`ggrep -E -n ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-no 'ab(cd?)?'`

`ugrep -no ab(cd?)? corpi/enwik8`
real 0.05
user 0.03
sys 0.02

`rg -no ab(cd?)? corpi/enwik8`
real 0.14
user 0.12
sys 0.01

`ag -no ab(cd?)? corpi/enwik8`
real 0.62
user 0.56
sys 0.05

`ggrep -E -no ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-wn 'ab(cd?)?'`

`ugrep -wn ab(cd?)? corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg -wn ab(cd?)? corpi/enwik8`
real 0.11
user 0.09
sys 0.01

`ag -wn ab(cd?)? corpi/enwik8`
real 0.43
user 0.37
sys 0.05

`ggrep -E -wn ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-win 'ab(cd?)?'`

`ugrep -win ab(cd?)? corpi/enwik8`
real 0.04
user 0.01
sys 0.02

`rg -win ab(cd?)? corpi/enwik8`
real 0.12
user 0.10
sys 0.02

`ag -win ab(cd?)? corpi/enwik8`
real 0.44
user 0.37
sys 0.05

`ggrep -E -win ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-wino 'ab(cd?)?'`

`ugrep -wino ab(cd?)? corpi/enwik8`
real 0.04
user 0.01
sys 0.02

`rg -wino ab(cd?)? corpi/enwik8`
real 0.12
user 0.10
sys 0.01

`ag -wino ab(cd?)? corpi/enwik8`
real 0.44
user 0.38
sys 0.05

`ggrep -E -wino ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-cwi 'ab(cd?)?'`

`ugrep -cwi ab(cd?)? corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`rg -cwi ab(cd?)? corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`ag -cwi ab(cd?)? corpi/enwik8`
real 0.18
user 0.11
sys 0.05

`ggrep -E -cwi ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping `-lwi 'ab(cd?)?'`

`ugrep -lwi ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi ab(cd?)? corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`ag -lwi ab(cd?)? corpi/enwik8`
real 0.18
user 0.12
sys 0.05

`ggrep -E -lwi ab(cd?)? corpi/enwik8`
**ERROR!**

### grepping ` '^$'`

`ugrep ^$ corpi/enwik8`
real 0.06
user 0.03
sys 0.02

`rg ^$ corpi/enwik8`
real 0.20
user 0.18
sys 0.01

`ag ^$ corpi/enwik8`
real 0.40
user 0.34
sys 0.06

`ggrep -E ^$ corpi/enwik8`
**ERROR!**

### grepping `-n '^$'`

`ugrep -n ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`rg -n ^$ corpi/enwik8`
real 0.24
user 0.22
sys 0.01

`ag -n ^$ corpi/enwik8`
real 0.41
user 0.34
sys 0.05

`ggrep -E -n ^$ corpi/enwik8`
**ERROR!**

### grepping `-no '^$'`

`ugrep -no ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.02

`rg -no ^$ corpi/enwik8`
real 0.26
user 0.24
sys 0.02

`ag -no ^$ corpi/enwik8`
real 0.38
user 0.32
sys 0.05

`ggrep -E -no ^$ corpi/enwik8`
**ERROR!**

### grepping `-wn '^$'`

`ugrep -wn ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`rg -wn ^$ corpi/enwik8`
real 0.37
user 0.35
sys 0.02

`ag -wn ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -wn ^$ corpi/enwik8`
**ERROR!**

### grepping `-win '^$'`

`ugrep -win ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.02

`rg -win ^$ corpi/enwik8`
real 0.37
user 0.35
sys 0.01

`ag -win ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -win ^$ corpi/enwik8`
**ERROR!**

### grepping `-wino '^$'`

`ugrep -wino ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`rg -wino ^$ corpi/enwik8`
real 0.80
user 0.78
sys 0.02

`ag -wino ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -wino ^$ corpi/enwik8`
**ERROR!**

### grepping `-cwi '^$'`

`ugrep -cwi ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -cwi ^$ corpi/enwik8`
real 0.32
user 0.30
sys 0.01

`ag -cwi ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -cwi ^$ corpi/enwik8`
**ERROR!**

### grepping `-lwi '^$'`

`ugrep -lwi ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi ^$ corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ag -lwi ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -lwi ^$ corpi/enwik8`
**ERROR!**


## large text file search words from files

### grepping `-n '-fwords/1.txt'`

`ugrep -n -fwords/1.txt corpi/enwik8`
real 0.08
user 0.05
sys 0.03

`rg -n -fwords/1.txt corpi/enwik8`
real 0.08
user 0.05
sys 0.04

`ggrep -E -n -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-no '-fwords/1.txt'`

`ugrep -no -fwords/1.txt corpi/enwik8`
real 0.06
user 0.04
sys 0.02

`rg -no -fwords/1.txt corpi/enwik8`
real 0.09
user 0.07
sys 0.01

`ggrep -E -no -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-wn '-fwords/1.txt'`

`ugrep -wn -fwords/1.txt corpi/enwik8`
real 0.07
user 0.05
sys 0.02

`rg -wn -fwords/1.txt corpi/enwik8`
real 0.17
user 0.14
sys 0.04

`ggrep -E -wn -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-win '-fwords/1.txt'`

`ugrep -win -fwords/1.txt corpi/enwik8`
real 0.26
user 0.23
sys 0.04

`rg -win -fwords/1.txt corpi/enwik8`
real 0.31
user 0.27
sys 0.07

`ggrep -E -win -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-wino '-fwords/1.txt'`

`ugrep -wino -fwords/1.txt corpi/enwik8`
real 0.25
user 0.23
sys 0.02

`rg -wino -fwords/1.txt corpi/enwik8`
real 2.67
user 2.65
sys 0.03

`ggrep -E -wino -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-cwi '-fwords/1.txt'`

`ugrep -cwi -fwords/1.txt corpi/enwik8`
real 0.19
user 0.17
sys 0.01

`rg -cwi -fwords/1.txt corpi/enwik8`
real 0.20
user 0.18
sys 0.01

`ggrep -E -cwi -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-lwi '-fwords/1.txt'`

`ugrep -lwi -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi -fwords/1.txt corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ggrep -E -lwi -fwords/1.txt corpi/enwik8`
**ERROR!**

### grepping `-n '-fwords/2.txt'`

`ugrep -n -fwords/2.txt corpi/enwik8`
real 0.26
user 0.23
sys 0.02

`rg -n -fwords/2.txt corpi/enwik8`
real 0.33
user 0.29
sys 0.07

`ggrep -E -n -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-no '-fwords/2.txt'`

`ugrep -no -fwords/2.txt corpi/enwik8`
real 0.25
user 0.23
sys 0.01

`rg -no -fwords/2.txt corpi/enwik8`
real 18.91
user 18.81
sys 0.44

`ggrep -E -no -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-wn '-fwords/2.txt'`

`ugrep -wn -fwords/2.txt corpi/enwik8`
real 0.25
user 0.23
sys 0.01

`rg -wn -fwords/2.txt corpi/enwik8`
real 0.40
user 0.38
sys 0.01

`ggrep -E -wn -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-win '-fwords/2.txt'`

`ugrep -win -fwords/2.txt corpi/enwik8`
real 0.28
user 0.26
sys 0.01

`rg -win -fwords/2.txt corpi/enwik8`
real 0.35
user 0.33
sys 0.01

`ggrep -E -win -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-wino '-fwords/2.txt'`

`ugrep -wino -fwords/2.txt corpi/enwik8`
real 0.26
user 0.25
sys 0.01

`rg -wino -fwords/2.txt corpi/enwik8`
real 0.35
user 0.33
sys 0.01

`ggrep -E -wino -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-cwi '-fwords/2.txt'`

`ugrep -cwi -fwords/2.txt corpi/enwik8`
real 0.28
user 0.26
sys 0.01

`rg -cwi -fwords/2.txt corpi/enwik8`
real 0.34
user 0.32
sys 0.02

`ggrep -E -cwi -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-lwi '-fwords/2.txt'`

`ugrep -lwi -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi -fwords/2.txt corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`ggrep -E -lwi -fwords/2.txt corpi/enwik8`
**ERROR!**

### grepping `-n '-fwords/3.txt'`

`ugrep -n -fwords/3.txt corpi/enwik8`
real 0.30
user 0.28
sys 0.02

`rg -n -fwords/3.txt corpi/enwik8`
real 1.98
user 1.96
sys 0.03

`ggrep -E -n -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-no '-fwords/3.txt'`

`ugrep -no -fwords/3.txt corpi/enwik8`
real 0.28
user 0.26
sys 0.01

`rg -no -fwords/3.txt corpi/enwik8`
real 2.37
user 2.35
sys 0.01

`ggrep -E -no -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-wn '-fwords/3.txt'`

`ugrep -wn -fwords/3.txt corpi/enwik8`
real 0.27
user 0.25
sys 0.01

`rg -wn -fwords/3.txt corpi/enwik8`
real 0.39
user 0.37
sys 0.02

`ggrep -E -wn -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-win '-fwords/3.txt'`

`ugrep -win -fwords/3.txt corpi/enwik8`
real 0.41
user 0.38
sys 0.02

`rg -win -fwords/3.txt corpi/enwik8`
real 0.43
user 0.40
sys 0.02

`ggrep -E -win -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-wino '-fwords/3.txt'`

`ugrep -wino -fwords/3.txt corpi/enwik8`
real 0.41
user 0.39
sys 0.01

`rg -wino -fwords/3.txt corpi/enwik8`
real 0.41
user 0.39
sys 0.01

`ggrep -E -wino -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-cwi '-fwords/3.txt'`

`ugrep -cwi -fwords/3.txt corpi/enwik8`
real 0.41
user 0.39
sys 0.01

`rg -cwi -fwords/3.txt corpi/enwik8`
real 0.39
user 0.38
sys 0.01

`ggrep -E -cwi -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-lwi '-fwords/3.txt'`

`ugrep -lwi -fwords/3.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -lwi -fwords/3.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ggrep -E -lwi -fwords/3.txt corpi/enwik8`
**ERROR!**

### grepping `-n '-fwords/4.txt'`

`ugrep -n -fwords/4.txt corpi/enwik8`
real 0.23
user 0.22
sys 0.01

`rg -n -fwords/4.txt corpi/enwik8`
real 0.35
user 0.33
sys 0.02

`ggrep -E -n -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-no '-fwords/4.txt'`

`ugrep -no -fwords/4.txt corpi/enwik8`
real 0.22
user 0.20
sys 0.01

`rg -no -fwords/4.txt corpi/enwik8`
real 0.36
user 0.34
sys 0.01

`ggrep -E -no -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-wn '-fwords/4.txt'`

`ugrep -wn -fwords/4.txt corpi/enwik8`
real 0.24
user 0.22
sys 0.01

`rg -wn -fwords/4.txt corpi/enwik8`
real 1.49
user 1.46
sys 0.03

`ggrep -E -wn -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-win '-fwords/4.txt'`

`ugrep -win -fwords/4.txt corpi/enwik8`
real 0.49
user 0.47
sys 0.02

`rg -win -fwords/4.txt corpi/enwik8`
real 1.90
user 1.85
sys 0.05

`ggrep -E -win -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-wino '-fwords/4.txt'`

`ugrep -wino -fwords/4.txt corpi/enwik8`
real 0.47
user 0.45
sys 0.01

`rg -wino -fwords/4.txt corpi/enwik8`
real 1.94
user 1.90
sys 0.04

`ggrep -E -wino -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-cwi '-fwords/4.txt'`

`ugrep -cwi -fwords/4.txt corpi/enwik8`
real 0.46
user 0.45
sys 0.01

`rg -cwi -fwords/4.txt corpi/enwik8`
real 1.83
user 1.79
sys 0.03

`ggrep -E -cwi -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-lwi '-fwords/4.txt'`

`ugrep -lwi -fwords/4.txt corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -lwi -fwords/4.txt corpi/enwik8`
real 0.17
user 0.15
sys 0.01

`ggrep -E -lwi -fwords/4.txt corpi/enwik8`
**ERROR!**


## large text file search with formatted output

### grepping `--json 'Sherlock|Holmes'`

`ugrep --json Sherlock|Holmes corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`rg --json Sherlock|Holmes corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`ag --json Sherlock|Holmes corpi/enwik8`
real 0.39
user 0.33
sys 0.05

### grepping `--csv 'Sherlock|Holmes'`

`ugrep --csv Sherlock|Holmes corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg --csv Sherlock|Holmes corpi/enwik8`
**ERROR!**

`ag --csv Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `--xml 'Sherlock|Holmes'`

`ugrep --xml Sherlock|Holmes corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg --xml Sherlock|Holmes corpi/enwik8`
**ERROR!**

`ag --xml Sherlock|Holmes corpi/enwik8`
real 0.40
user 0.34
sys 0.05

### grepping `--hex 'Sherlock|Holmes'`

`ugrep --hex Sherlock|Holmes corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg --hex Sherlock|Holmes corpi/enwik8`
**ERROR!**

`ag --hex Sherlock|Holmes corpi/enwik8`
**ERROR!**


## large text file search with replaced output

### grepping `--replace=flip flop`

`ugrep --replace=flip flop corpi/enwik8`
real 0.03
user 0.01
sys 0.02

`rg --replace=flip flop corpi/enwik8`
real 0.03
user 0.01
sys 0.02


## large text file search with context

### grepping `-A1 '^$'`

`ugrep -A1 ^$ corpi/enwik8`
real 0.05
user 0.03
sys 0.01

`rg -A1 ^$ corpi/enwik8`
real 0.25
user 0.23
sys 0.04

`ag -A1 ^$ corpi/enwik8`
real 0.50
user 0.43
sys 0.07

`ggrep -E -A1 ^$ corpi/enwik8`
**ERROR!**

### grepping `-B1 '^$'`

`ugrep -B1 ^$ corpi/enwik8`
real 0.05
user 0.03
sys 0.01

`rg -B1 ^$ corpi/enwik8`
real 0.25
user 0.23
sys 0.05

`ag -B1 ^$ corpi/enwik8`
real 0.71
user 0.64
sys 0.07

`ggrep -E -B1 ^$ corpi/enwik8`
**ERROR!**

### grepping `-C1 '^$'`

`ugrep -C1 ^$ corpi/enwik8`
real 0.05
user 0.03
sys 0.01

`rg -C1 ^$ corpi/enwik8`
real 0.25
user 0.23
sys 0.05

`ag -C1 ^$ corpi/enwik8`
real 0.72
user 0.65
sys 0.08

`ggrep -E -C1 ^$ corpi/enwik8`
**ERROR!**

### grepping `-winA1 '^$'`

`ugrep -winA1 ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.02

`rg -winA1 ^$ corpi/enwik8`
real 0.47
user 0.44
sys 0.05

`ag -winA1 ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -winA1 ^$ corpi/enwik8`
**ERROR!**

### grepping `-winB1 '^$'`

`ugrep -winB1 ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`rg -winB1 ^$ corpi/enwik8`
real 0.47
user 0.44
sys 0.05

`ag -winB1 ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -winB1 ^$ corpi/enwik8`
**ERROR!**

### grepping `-winC1 '^$'`

`ugrep -winC1 ^$ corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`rg -winC1 ^$ corpi/enwik8`
real 0.50
user 0.47
sys 0.06

`ag -winC1 ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -winC1 ^$ corpi/enwik8`
**ERROR!**

### grepping `-A1 'Sherlock|Holmes'`

`ugrep -A1 Sherlock|Holmes corpi/enwik8`
real 0.09
user 0.07
sys 0.01

`rg -A1 Sherlock|Holmes corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`ag -A1 Sherlock|Holmes corpi/enwik8`
real 0.40
user 0.34
sys 0.05

`ggrep -E -A1 Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `-B1 'Sherlock|Holmes'`

`ugrep -B1 Sherlock|Holmes corpi/enwik8`
real 0.13
user 0.11
sys 0.01

`rg -B1 Sherlock|Holmes corpi/enwik8`
real 0.04
user 0.01
sys 0.02

`ag -B1 Sherlock|Holmes corpi/enwik8`
real 0.58
user 0.52
sys 0.05

`ggrep -E -B1 Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `-C1 'Sherlock|Holmes'`

`ugrep -C1 Sherlock|Holmes corpi/enwik8`
real 0.13
user 0.11
sys 0.02

`rg -C1 Sherlock|Holmes corpi/enwik8`
real 0.03
user 0.01
sys 0.01

`ag -C1 Sherlock|Holmes corpi/enwik8`
real 0.59
user 0.52
sys 0.05

`ggrep -E -C1 Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `-winA1 'Sherlock|Holmes'`

`ugrep -winA1 Sherlock|Holmes corpi/enwik8`
real 0.11
user 0.09
sys 0.02

`rg -winA1 Sherlock|Holmes corpi/enwik8`
real 0.09
user 0.07
sys 0.01

`ag -winA1 Sherlock|Holmes corpi/enwik8`
real 0.42
user 0.36
sys 0.05

`ggrep -E -winA1 Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `-winB1 'Sherlock|Holmes'`

`ugrep -winB1 Sherlock|Holmes corpi/enwik8`
real 0.15
user 0.12
sys 0.02

`rg -winB1 Sherlock|Holmes corpi/enwik8`
real 0.09
user 0.07
sys 0.01

`ag -winB1 Sherlock|Holmes corpi/enwik8`
real 0.62
user 0.55
sys 0.05

`ggrep -E -winB1 Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `-winC1 'Sherlock|Holmes'`

`ugrep -winC1 Sherlock|Holmes corpi/enwik8`
real 0.14
user 0.12
sys 0.01

`rg -winC1 Sherlock|Holmes corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`ag -winC1 Sherlock|Holmes corpi/enwik8`
real 0.61
user 0.55
sys 0.05

`ggrep -E -winC1 Sherlock|Holmes corpi/enwik8`
**ERROR!**


## source code repo directory search

~/Projects/ugrep/benchmarks/corpi/openssl-3.1.2 ~/Projects/ugrep/benchmarks

### grepping `-n 'FIXME|TODO'`

`ugrep -I -n FIXME|TODO`
real 0.04
user 0.09
sys 0.17

`rg -n FIXME|TODO`
real 0.03
user 0.05
sys 0.15

`ag -nr FIXME|TODO`
real 0.05
user 0.10
sys 0.17

`ggrep -E -I -nr FIXME|TODO .`
real 0.15
user 0.07
sys 0.07

### grepping `-wn 'FIXME|TODO'`

`ugrep -I -wn FIXME|TODO`
real 0.04
user 0.09
sys 0.17

`rg -wn FIXME|TODO`
real 0.04
user 0.06
sys 0.15

`ag -wnr FIXME|TODO`
real 0.05
user 0.10
sys 0.17

`ggrep -E -I -wnr FIXME|TODO .`
real 0.16
user 0.09
sys 0.07

### grepping `-win 'FIXME|TODO'`

`ugrep -I -win FIXME|TODO`
real 0.04
user 0.10
sys 0.18

`rg -win FIXME|TODO`
real 0.04
user 0.11
sys 0.15

`ag -winr FIXME|TODO`
real 0.07
user 0.12
sys 0.21

`ggrep -E -I -winr FIXME|TODO .`
real 0.23
user 0.16
sys 0.07

### grepping `-wino 'FIXME|TODO'`

`ugrep -I -wino FIXME|TODO`
real 0.04
user 0.10
sys 0.17

`rg -wino FIXME|TODO`
real 0.05
user 0.11
sys 0.15

`ag -winor FIXME|TODO`
real 0.06
user 0.12
sys 0.19

`ggrep -E -I -winor FIXME|TODO .`
real 0.23
user 0.16
sys 0.07

### grepping `-cwi 'FIXME|TODO'`

`ugrep -I -cwi FIXME|TODO`
real 0.04
user 0.11
sys 0.20

`rg -cwi FIXME|TODO`
real 0.05
user 0.11
sys 0.15

`ag -cwir FIXME|TODO`
real 0.05
user 0.11
sys 0.17

`ggrep -E -I -cwir FIXME|TODO .`
real 0.22
user 0.14
sys 0.07

### grepping `-lwi 'FIXME|TODO'`

`ugrep -I -lwi FIXME|TODO`
real 0.04
user 0.10
sys 0.17

`rg -lwi FIXME|TODO`
real 0.04
user 0.11
sys 0.15

`ag -lwir FIXME|TODO`
real 0.06
user 0.11
sys 0.19

`ggrep -E -I -lwir FIXME|TODO .`
real 0.21
user 0.14
sys 0.07

### grepping `-n 'char|int|long|size_t|void'`

`ugrep -I -n char|int|long|size_t|void`
real 0.05
user 0.17
sys 0.19

`rg -n char|int|long|size_t|void`
real 0.05
user 0.11
sys 0.18

`ag -nr char|int|long|size_t|void`
real 0.50
user 0.65
sys 0.17

`ggrep -E -I -nr char|int|long|size_t|void .`
real 0.25
user 0.17
sys 0.08

### grepping `-wn 'char|int|long|size_t|void'`

`ugrep -I -wn char|int|long|size_t|void`
real 0.05
user 0.16
sys 0.19

`rg -wn char|int|long|size_t|void`
real 0.07
user 0.24
sys 0.18

`ag -wnr char|int|long|size_t|void`
real 0.34
user 0.53
sys 0.16

`ggrep -E -I -wnr char|int|long|size_t|void .`
real 0.32
user 0.24
sys 0.08

### grepping `-win 'char|int|long|size_t|void'`

`ugrep -I -win char|int|long|size_t|void`
real 0.05
user 0.18
sys 0.19

`rg -win char|int|long|size_t|void`
real 0.08
user 0.33
sys 0.17

`ag -winr char|int|long|size_t|void`
real 0.34
user 0.53
sys 0.16

`ggrep -E -I -winr char|int|long|size_t|void .`
real 0.53
user 0.45
sys 0.08

### grepping `-wino 'char|int|long|size_t|void'`

`ugrep -I -wino char|int|long|size_t|void`
real 0.05
user 0.18
sys 0.18

`rg -wino char|int|long|size_t|void`
real 0.14
user 0.85
sys 0.18

`ag -winor char|int|long|size_t|void`
real 0.22
user 0.43
sys 0.16

`ggrep -E -I -winor char|int|long|size_t|void .`
real 0.73
user 0.65
sys 0.08

### grepping `-cwi 'char|int|long|size_t|void'`

`ugrep -I -cwi char|int|long|size_t|void`
real 0.05
user 0.17
sys 0.21

`rg -cwi char|int|long|size_t|void`
real 0.07
user 0.30
sys 0.17

`ag -cwir char|int|long|size_t|void`
real 0.08
user 0.33
sys 0.17

`ggrep -E -I -cwir char|int|long|size_t|void .`
real 0.47
user 0.39
sys 0.07

### grepping `-lwi 'char|int|long|size_t|void'`

`ugrep -I -lwi char|int|long|size_t|void`
real 0.04
user 0.11
sys 0.19

`rg -lwi char|int|long|size_t|void`
real 0.06
user 0.20
sys 0.17

`ag -lwir char|int|long|size_t|void`
real 0.08
user 0.33
sys 0.16

`ggrep -E -I -lwir char|int|long|size_t|void .`
real 0.20
user 0.13
sys 0.07

### grepping `-n 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -n ssl-?3(\.[0-9]+)?`
real 0.04
user 0.09
sys 0.17

`rg -n ssl-?3(\.[0-9]+)?`
real 0.04
user 0.06
sys 0.15

`ag -nr ssl-?3(\.[0-9]+)?`
real 0.06
user 0.12
sys 0.17

`ggrep -E -I -nr ssl-?3(\.[0-9]+)? .`
real 0.15
user 0.07
sys 0.08

### grepping `-wn 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -wn ssl-?3(\.[0-9]+)?`
real 0.04
user 0.09
sys 0.18

`rg -wn ssl-?3(\.[0-9]+)?`
real 0.04
user 0.09
sys 0.15

`ag -wnr ssl-?3(\.[0-9]+)?`
real 0.05
user 0.10
sys 0.17

`ggrep -E -I -wnr ssl-?3(\.[0-9]+)? .`
real 0.14
user 0.06
sys 0.07

### grepping `-win 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -win ssl-?3(\.[0-9]+)?`
real 0.04
user 0.09
sys 0.17

`rg -win ssl-?3(\.[0-9]+)?`
real 0.07
user 0.29
sys 0.15

`ag -winr ssl-?3(\.[0-9]+)?`
real 0.05
user 0.10
sys 0.17

`ggrep -E -I -winr ssl-?3(\.[0-9]+)? .`
real 0.16
user 0.08
sys 0.07

### grepping `-wino 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -wino ssl-?3(\.[0-9]+)?`
real 0.04
user 0.09
sys 0.17

`rg -wino ssl-?3(\.[0-9]+)?`
real 0.07
user 0.29
sys 0.15

`ag -winor ssl-?3(\.[0-9]+)?`
real 0.05
user 0.10
sys 0.17

`ggrep -E -I -winor ssl-?3(\.[0-9]+)? .`
real 0.16
user 0.08
sys 0.07

### grepping `-cwi 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -cwi ssl-?3(\.[0-9]+)?`
real 0.04
user 0.10
sys 0.20

`rg -cwi ssl-?3(\.[0-9]+)?`
real 0.07
user 0.29
sys 0.15

`ag -cwir ssl-?3(\.[0-9]+)?`
real 0.06
user 0.10
sys 0.19

`ggrep -E -I -cwir ssl-?3(\.[0-9]+)? .`
real 0.14
user 0.07
sys 0.07

### grepping `-lwi 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -lwi ssl-?3(\.[0-9]+)?`
real 0.04
user 0.09
sys 0.18

`rg -lwi ssl-?3(\.[0-9]+)?`
real 0.07
user 0.28
sys 0.15

`ag -lwir ssl-?3(\.[0-9]+)?`
real 0.06
user 0.10
sys 0.19

`ggrep -E -I -lwir ssl-?3(\.[0-9]+)? .`
real 0.14
user 0.07
sys 0.07

~/Projects/ugrep/benchmarks


## bz2 compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.bz2`
real 3.24
user 3.24
sys 0.03

`rg -z landsnail corpi/enwik8.bz2`
real 3.37
user 3.36
sys 0.05

`ag -z landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.bz2`
real 3.22
user 3.22
sys 0.03

`rg -zwin landsnail corpi/enwik8.bz2`
real 3.38
user 3.41
sys 0.05

`ag -zwin landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.bz2`
real 3.24
user 3.24
sys 0.03

`rg -zc landsnail corpi/enwik8.bz2`
real 3.37
user 3.35
sys 0.05

`ag -zc landsnail corpi/enwik8.bz2`
**ERROR!**


## gz compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.gz`
real 0.49
user 0.48
sys 0.02

`rg -z landsnail corpi/enwik8.gz`
real 0.41
user 0.41
sys 0.02

`ag -z landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.gz`
real 0.48
user 0.48
sys 0.02

`rg -zwin landsnail corpi/enwik8.gz`
real 0.41
user 0.45
sys 0.02

`ag -zwin landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.gz`
real 0.48
user 0.48
sys 0.02

`rg -zc landsnail corpi/enwik8.gz`
real 0.41
user 0.40
sys 0.02

`ag -zc landsnail corpi/enwik8.gz`
**ERROR!**


## lz4 compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.lz4`
real 0.10
user 0.06
sys 0.04

`rg -z landsnail corpi/enwik8.lz4`
real 0.12
user 0.09
sys 0.04

`ag -z landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.lz4`
real 0.10
user 0.06
sys 0.04

`rg -zwin landsnail corpi/enwik8.lz4`
real 0.16
user 0.14
sys 0.03

`ag -zwin landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.lz4`
real 0.09
user 0.06
sys 0.03

`rg -zc landsnail corpi/enwik8.lz4`
real 0.12
user 0.08
sys 0.04

`ag -zc landsnail corpi/enwik8.lz4`
**ERROR!**


## xz compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.xz`
real 1.44
user 1.44
sys 0.03

`rg -z landsnail corpi/enwik8.xz`
real 1.57
user 1.55
sys 0.06

`ag -z landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.xz`
real 1.44
user 1.44
sys 0.02

`rg -zwin landsnail corpi/enwik8.xz`
real 1.57
user 1.60
sys 0.06

`ag -zwin landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.xz`
real 1.45
user 1.44
sys 0.03

`rg -zc landsnail corpi/enwik8.xz`
real 1.55
user 1.53
sys 0.06

`ag -zc landsnail corpi/enwik8.xz`
**ERROR!**


## zstd compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.zst`
real 0.19
user 0.17
sys 0.02

`rg -z landsnail corpi/enwik8.zst`
real 0.16
user 0.17
sys 0.04

`ag -z landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.zst`
real 0.20
user 0.18
sys 0.03

`rg -zwin landsnail corpi/enwik8.zst`
real 0.17
user 0.21
sys 0.03

`ag -zwin landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.zst`
real 0.19
user 0.17
sys 0.03

`rg -zc landsnail corpi/enwik8.zst`
real 0.16
user 0.17
sys 0.04

`ag -zc landsnail corpi/enwik8.zst`
**ERROR!**


## zip archived repo search

### grepping `-z 'FIXME|TODO'`

`ugrep -z FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.30
user 0.27
sys 0.10

`rg -z FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -z FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zwin 'FIXME|TODO'`

`ugrep -zwin FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.31
user 0.28
sys 0.10

`rg -zwin FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zwin FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zc 'FIXME|TODO'`

`ugrep -zc FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.30
user 0.26
sys 0.12

`rg -zc FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zc FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**


## tar archived repo search

### grepping `-z 'FIXME|TODO'`

`ugrep -z FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.16
user 0.09
sys 0.10

`rg -z FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -z FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zwin 'FIXME|TODO'`

`ugrep -zwin FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.16
user 0.10
sys 0.10

`rg -zwin FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zwin FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zc 'FIXME|TODO'`

`ugrep -zc FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.14
user 0.07
sys 0.12

`rg -zc FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zc FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**


## compressed tarball search

### grepping `-z 'FIXME|TODO'`

`ugrep -z FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.36
user 0.31
sys 0.09

`rg -z FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -z FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zwin 'FIXME|TODO'`

`ugrep -zwin FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.38
user 0.33
sys 0.10

`rg -zwin FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zwin FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zc 'FIXME|TODO'`

`ugrep -zc FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.35
user 0.29
sys 0.11

`rg -zc FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zc FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**


## end of report

