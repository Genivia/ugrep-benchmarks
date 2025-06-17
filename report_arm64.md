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


## large text file search

### grepping ` 'rol'`

`ugrep rol corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`rg rol corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`ag rol corpi/enwik8`
real 0.53
user 0.51
sys 0.02

`ggrep -E rol corpi/enwik8`
real 0.10
user 0.09
sys 0.01

### grepping `-n 'rol'`

`ugrep -n rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -n rol corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`ag -n rol corpi/enwik8`
real 0.53
user 0.51
sys 0.02

`ggrep -E -n rol corpi/enwik8`
real 0.12
user 0.11
sys 0.01

### grepping `-no 'rol'`

`ugrep -no rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -no rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -no rol corpi/enwik8`
real 0.43
user 0.40
sys 0.02

`ggrep -E -no rol corpi/enwik8`
real 0.13
user 0.12
sys 0.00

### grepping `-wn 'rol'`

`ugrep -wn rol corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -wn rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -wn rol corpi/enwik8`
real 0.40
user 0.37
sys 0.02

`ggrep -E -wn rol corpi/enwik8`
real 0.13
user 0.13
sys 0.00

### grepping `-win 'rol'`

`ugrep -win rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -win rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -win rol corpi/enwik8`
real 0.40
user 0.37
sys 0.02

`ggrep -E -win rol corpi/enwik8`
real 0.37
user 0.36
sys 0.00

### grepping `-wino 'rol'`

`ugrep -wino rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wino rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -wino rol corpi/enwik8`
real 0.40
user 0.37
sys 0.02

`ggrep -E -wino rol corpi/enwik8`
real 0.37
user 0.36
sys 0.00

### grepping `-c 'rol'`

`ugrep -c rol corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg -c rol corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ag -c rol corpi/enwik8`
real 0.16
user 0.14
sys 0.02

`ggrep -E -c rol corpi/enwik8`
real 0.09
user 0.09
sys 0.00

### grepping `-wic 'rol'`

`ugrep -wic rol corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -wic rol corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -wic rol corpi/enwik8`
real 0.16
user 0.14
sys 0.02

`ggrep -E -wic rol corpi/enwik8`
real 0.35
user 0.34
sys 0.00

### grepping `-l 'rol'`

`ugrep -l rol corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l rol corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l rol corpi/enwik8`
real 0.16
user 0.14
sys 0.01

`ggrep -E -l rol corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'rol'`

`ugrep -wil rol corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil rol corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil rol corpi/enwik8`
real 0.16
user 0.14
sys 0.02

`ggrep -E -wil rol corpi/enwik8`
real 0.05
user 0.05
sys 0.00

### grepping ` 'the'`

`ugrep the corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`rg the corpi/enwik8`
real 0.04
user 0.02
sys 0.02

`ag the corpi/enwik8`
real 1.94
user 1.90
sys 0.05

`ggrep -E the corpi/enwik8`
real 0.10
user 0.09
sys 0.01

### grepping `-n 'the'`

`ugrep -n the corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`rg -n the corpi/enwik8`
real 0.05
user 0.04
sys 0.02

`ag -n the corpi/enwik8`
real 1.94
user 1.90
sys 0.05

`ggrep -E -n the corpi/enwik8`
real 0.13
user 0.11
sys 0.01

### grepping `-no 'the'`

`ugrep -no the corpi/enwik8`
real 0.08
user 0.07
sys 0.01

`rg -no the corpi/enwik8`
real 0.10
user 0.09
sys 0.01

`ag -no the corpi/enwik8`
real 0.84
user 0.81
sys 0.02

`ggrep -E -no the corpi/enwik8`
real 0.40
user 0.39
sys 0.01

### grepping `-wn 'the'`

`ugrep -wn the corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`rg -wn the corpi/enwik8`
real 0.06
user 0.05
sys 0.02

`ag -wn the corpi/enwik8`
real 1.89
user 1.85
sys 0.05

`ggrep -E -wn the corpi/enwik8`
real 0.23
user 0.22
sys 0.02

### grepping `-win 'the'`

`ugrep -win the corpi/enwik8`
real 0.06
user 0.05
sys 0.01

`rg -win the corpi/enwik8`
real 0.08
user 0.06
sys 0.02

`ag -win the corpi/enwik8`
real 1.89
user 1.85
sys 0.04

`ggrep -E -win the corpi/enwik8`
real 0.50
user 0.49
sys 0.02

### grepping `-wino 'the'`

`ugrep -wino the corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`rg -wino the corpi/enwik8`
real 0.18
user 0.17
sys 0.01

`ag -wino the corpi/enwik8`
real 0.80
user 0.78
sys 0.02

`ggrep -E -wino the corpi/enwik8`
real 2.22
user 2.20
sys 0.02

### grepping `-c 'the'`

`ugrep -c the corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -c the corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`ag -c the corpi/enwik8`
real 0.20
user 0.18
sys 0.02

`ggrep -E -c the corpi/enwik8`
real 0.08
user 0.07
sys 0.00

### grepping `-wic 'the'`

`ugrep -wic the corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -wic the corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -wic the corpi/enwik8`
real 0.21
user 0.18
sys 0.02

`ggrep -E -wic the corpi/enwik8`
real 0.44
user 0.44
sys 0.00

### grepping `-l 'the'`

`ugrep -l the corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l the corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l the corpi/enwik8`
real 0.20
user 0.18
sys 0.02

`ggrep -E -l the corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'the'`

`ugrep -wil the corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil the corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil the corpi/enwik8`
real 0.21
user 0.18
sys 0.02

`ggrep -E -wil the corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` 'cycles|semigroups'`

`ugrep cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag cycles|semigroups corpi/enwik8`
real 0.52
user 0.49
sys 0.02

`ggrep -E cycles|semigroups corpi/enwik8`
real 0.15
user 0.14
sys 0.00

### grepping `-n 'cycles|semigroups'`

`ugrep -n cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -n cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -n cycles|semigroups corpi/enwik8`
real 0.52
user 0.49
sys 0.02

`ggrep -E -n cycles|semigroups corpi/enwik8`
real 0.17
user 0.16
sys 0.00

### grepping `-no 'cycles|semigroups'`

`ugrep -no cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -no cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -no cycles|semigroups corpi/enwik8`
real 0.51
user 0.49
sys 0.02

`ggrep -E -no cycles|semigroups corpi/enwik8`
real 0.17
user 0.16
sys 0.00

### grepping `-wn 'cycles|semigroups'`

`ugrep -wn cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wn cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -wn cycles|semigroups corpi/enwik8`
real 0.50
user 0.48
sys 0.02

`ggrep -E -wn cycles|semigroups corpi/enwik8`
real 0.26
user 0.25
sys 0.00

### grepping `-win 'cycles|semigroups'`

`ugrep -win cycles|semigroups corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -win cycles|semigroups corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -win cycles|semigroups corpi/enwik8`
real 0.50
user 0.48
sys 0.02

`ggrep -E -win cycles|semigroups corpi/enwik8`
real 0.24
user 0.23
sys 0.00

### grepping `-wino 'cycles|semigroups'`

`ugrep -wino cycles|semigroups corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -wino cycles|semigroups corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -wino cycles|semigroups corpi/enwik8`
real 0.50
user 0.48
sys 0.02

`ggrep -E -wino cycles|semigroups corpi/enwik8`
real 0.24
user 0.23
sys 0.00

### grepping `-c 'cycles|semigroups'`

`ugrep -c cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -c cycles|semigroups corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -c cycles|semigroups corpi/enwik8`
real 0.28
user 0.26
sys 0.02

`ggrep -E -c cycles|semigroups corpi/enwik8`
real 0.15
user 0.14
sys 0.00

### grepping `-wic 'cycles|semigroups'`

`ugrep -wic cycles|semigroups corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -wic cycles|semigroups corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`ag -wic cycles|semigroups corpi/enwik8`
real 0.26
user 0.24
sys 0.02

`ggrep -E -wic cycles|semigroups corpi/enwik8`
real 0.22
user 0.21
sys 0.00

### grepping `-l 'cycles|semigroups'`

`ugrep -l cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l cycles|semigroups corpi/enwik8`
real 0.28
user 0.26
sys 0.02

`ggrep -E -l cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'cycles|semigroups'`

`ugrep -wil cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil cycles|semigroups corpi/enwik8`
real 0.26
user 0.24
sys 0.02

`ggrep -E -wil cycles|semigroups corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` 'ro[a-z]*ds'`

`ugrep ro[a-z]*ds corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg ro[a-z]*ds corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`ag ro[a-z]*ds corpi/enwik8`
real 0.44
user 0.41
sys 0.02

`ggrep -E ro[a-z]*ds corpi/enwik8`
real 0.25
user 0.24
sys 0.01

### grepping `-n 'ro[a-z]*ds'`

`ugrep -n ro[a-z]*ds corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -n ro[a-z]*ds corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -n ro[a-z]*ds corpi/enwik8`
real 0.44
user 0.41
sys 0.02

`ggrep -E -n ro[a-z]*ds corpi/enwik8`
real 0.27
user 0.26
sys 0.01

### grepping `-no 'ro[a-z]*ds'`

`ugrep -no ro[a-z]*ds corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -no ro[a-z]*ds corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -no ro[a-z]*ds corpi/enwik8`
real 0.42
user 0.39
sys 0.02

`ggrep -E -no ro[a-z]*ds corpi/enwik8`
real 0.28
user 0.27
sys 0.00

### grepping `-wn 'ro[a-z]*ds'`

`ugrep -wn ro[a-z]*ds corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -wn ro[a-z]*ds corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ag -wn ro[a-z]*ds corpi/enwik8`
real 0.41
user 0.38
sys 0.02

`ggrep -E -wn ro[a-z]*ds corpi/enwik8`
real 0.30
user 0.29
sys 0.00

### grepping `-win 'ro[a-z]*ds'`

`ugrep -win ro[a-z]*ds corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`rg -win ro[a-z]*ds corpi/enwik8`
real 0.04
user 0.04
sys 0.00

`ag -win ro[a-z]*ds corpi/enwik8`
real 0.41
user 0.38
sys 0.02

`ggrep -E -win ro[a-z]*ds corpi/enwik8`
real 0.58
user 0.57
sys 0.01

### grepping `-wino 'ro[a-z]*ds'`

`ugrep -wino ro[a-z]*ds corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`rg -wino ro[a-z]*ds corpi/enwik8`
real 0.04
user 0.04
sys 0.00

`ag -wino ro[a-z]*ds corpi/enwik8`
real 0.40
user 0.38
sys 0.02

`ggrep -E -wino ro[a-z]*ds corpi/enwik8`
real 0.58
user 0.57
sys 0.01

### grepping `-c 'ro[a-z]*ds'`

`ugrep -c ro[a-z]*ds corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -c ro[a-z]*ds corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`ag -c ro[a-z]*ds corpi/enwik8`
real 0.17
user 0.15
sys 0.02

`ggrep -E -c ro[a-z]*ds corpi/enwik8`
real 0.25
user 0.24
sys 0.00

### grepping `-wic 'ro[a-z]*ds'`

`ugrep -wic ro[a-z]*ds corpi/enwik8`
real 0.04
user 0.04
sys 0.00

`rg -wic ro[a-z]*ds corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ag -wic ro[a-z]*ds corpi/enwik8`
real 0.16
user 0.14
sys 0.02

`ggrep -E -wic ro[a-z]*ds corpi/enwik8`
real 0.56
user 0.55
sys 0.01

### grepping `-l 'ro[a-z]*ds'`

`ugrep -l ro[a-z]*ds corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l ro[a-z]*ds corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l ro[a-z]*ds corpi/enwik8`
real 0.17
user 0.15
sys 0.01

`ggrep -E -l ro[a-z]*ds corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'ro[a-z]*ds'`

`ugrep -wil ro[a-z]*ds corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil ro[a-z]*ds corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil ro[a-z]*ds corpi/enwik8`
real 0.17
user 0.14
sys 0.02

`ggrep -E -wil ro[a-z]*ds corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` 'r[a-z]*st'`

`ugrep r[a-z]*st corpi/enwik8`
real 0.06
user 0.05
sys 0.01

`rg r[a-z]*st corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`ag r[a-z]*st corpi/enwik8`
real 1.16
user 1.13
sys 0.03

`ggrep -E r[a-z]*st corpi/enwik8`
real 0.49
user 0.48
sys 0.01

### grepping `-n 'r[a-z]*st'`

`ugrep -n r[a-z]*st corpi/enwik8`
real 0.07
user 0.06
sys 0.01

`rg -n r[a-z]*st corpi/enwik8`
real 0.14
user 0.13
sys 0.01

`ag -n r[a-z]*st corpi/enwik8`
real 1.16
user 1.13
sys 0.03

`ggrep -E -n r[a-z]*st corpi/enwik8`
real 0.51
user 0.50
sys 0.01

### grepping `-no 'r[a-z]*st'`

`ugrep -no r[a-z]*st corpi/enwik8`
real 0.07
user 0.06
sys 0.00

`rg -no r[a-z]*st corpi/enwik8`
real 0.18
user 0.17
sys 0.01

`ag -no r[a-z]*st corpi/enwik8`
real 0.68
user 0.66
sys 0.02

`ggrep -E -no r[a-z]*st corpi/enwik8`
real 0.72
user 0.71
sys 0.01

### grepping `-wn 'r[a-z]*st'`

`ugrep -wn r[a-z]*st corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`rg -wn r[a-z]*st corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`ag -wn r[a-z]*st corpi/enwik8`
real 0.46
user 0.43
sys 0.02

`ggrep -E -wn r[a-z]*st corpi/enwik8`
real 0.63
user 0.63
sys 0.01

### grepping `-win 'r[a-z]*st'`

`ugrep -win r[a-z]*st corpi/enwik8`
real 0.08
user 0.08
sys 0.00

`rg -win r[a-z]*st corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`ag -win r[a-z]*st corpi/enwik8`
real 0.46
user 0.43
sys 0.02

`ggrep -E -win r[a-z]*st corpi/enwik8`
real 1.81
user 1.80
sys 0.01

### grepping `-wino 'r[a-z]*st'`

`ugrep -wino r[a-z]*st corpi/enwik8`
real 0.08
user 0.08
sys 0.00

`rg -wino r[a-z]*st corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`ag -wino r[a-z]*st corpi/enwik8`
real 0.43
user 0.41
sys 0.02

`ggrep -E -wino r[a-z]*st corpi/enwik8`
real 1.85
user 1.84
sys 0.01

### grepping `-c 'r[a-z]*st'`

`ugrep -c r[a-z]*st corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`rg -c r[a-z]*st corpi/enwik8`
real 0.12
user 0.12
sys 0.01

`ag -c r[a-z]*st corpi/enwik8`
real 0.31
user 0.29
sys 0.02

`ggrep -E -c r[a-z]*st corpi/enwik8`
real 0.48
user 0.47
sys 0.01

### grepping `-wic 'r[a-z]*st'`

`ugrep -wic r[a-z]*st corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`rg -wic r[a-z]*st corpi/enwik8`
real 0.12
user 0.11
sys 0.01

`ag -wic r[a-z]*st corpi/enwik8`
real 0.18
user 0.16
sys 0.02

`ggrep -E -wic r[a-z]*st corpi/enwik8`
real 1.79
user 1.78
sys 0.01

### grepping `-l 'r[a-z]*st'`

`ugrep -l r[a-z]*st corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l r[a-z]*st corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l r[a-z]*st corpi/enwik8`
real 0.31
user 0.29
sys 0.02

`ggrep -E -l r[a-z]*st corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'r[a-z]*st'`

`ugrep -wil r[a-z]*st corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil r[a-z]*st corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil r[a-z]*st corpi/enwik8`
real 0.18
user 0.16
sys 0.02

`ggrep -E -wil r[a-z]*st corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '[A-Z][a-z]+ny'`

`ugrep [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg [A-Z][a-z]+ny corpi/enwik8`
real 0.01
user 0.01
sys 0.01

`ag [A-Z][a-z]+ny corpi/enwik8`
real 0.63
user 0.60
sys 0.02

`ggrep -E [A-Z][a-z]+ny corpi/enwik8`
real 0.16
user 0.15
sys 0.01

### grepping `-n '[A-Z][a-z]+ny'`

`ugrep -n [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -n [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`ag -n [A-Z][a-z]+ny corpi/enwik8`
real 0.63
user 0.60
sys 0.02

`ggrep -E -n [A-Z][a-z]+ny corpi/enwik8`
real 0.18
user 0.17
sys 0.01

### grepping `-no '[A-Z][a-z]+ny'`

`ugrep -no [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -no [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -no [A-Z][a-z]+ny corpi/enwik8`
real 0.54
user 0.51
sys 0.02

`ggrep -E -no [A-Z][a-z]+ny corpi/enwik8`
real 0.21
user 0.20
sys 0.00

### grepping `-wn '[A-Z][a-z]+ny'`

`ugrep -wn [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wn [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`ag -wn [A-Z][a-z]+ny corpi/enwik8`
real 0.63
user 0.61
sys 0.02

`ggrep -E -wn [A-Z][a-z]+ny corpi/enwik8`
real 0.18
user 0.17
sys 0.01

### grepping `-win '[A-Z][a-z]+ny'`

`ugrep -win [A-Z][a-z]+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg -win [A-Z][a-z]+ny corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`ag -win [A-Z][a-z]+ny corpi/enwik8`
real 2.18
user 2.15
sys 0.03

`ggrep -E -win [A-Z][a-z]+ny corpi/enwik8`
real 0.97
user 0.96
sys 0.01

### grepping `-wino '[A-Z][a-z]+ny'`

`ugrep -wino [A-Z][a-z]+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -wino [A-Z][a-z]+ny corpi/enwik8`
real 0.16
user 0.15
sys 0.01

`ag -wino [A-Z][a-z]+ny corpi/enwik8`
real 1.95
user 1.92
sys 0.02

`ggrep -E -wino [A-Z][a-z]+ny corpi/enwik8`
real 1.90
user 1.88
sys 0.01

### grepping `-c '[A-Z][a-z]+ny'`

`ugrep -c [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -c [A-Z][a-z]+ny corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ag -c [A-Z][a-z]+ny corpi/enwik8`
real 0.27
user 0.25
sys 0.02

`ggrep -E -c [A-Z][a-z]+ny corpi/enwik8`
real 0.16
user 0.15
sys 0.00

### grepping `-wic '[A-Z][a-z]+ny'`

`ugrep -wic [A-Z][a-z]+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wic [A-Z][a-z]+ny corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`ag -wic [A-Z][a-z]+ny corpi/enwik8`
real 1.65
user 1.62
sys 0.02

`ggrep -E -wic [A-Z][a-z]+ny corpi/enwik8`
real 0.95
user 0.94
sys 0.01

### grepping `-l '[A-Z][a-z]+ny'`

`ugrep -l [A-Z][a-z]+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l [A-Z][a-z]+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l [A-Z][a-z]+ny corpi/enwik8`
real 0.27
user 0.25
sys 0.02

`ggrep -E -l [A-Z][a-z]+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '[A-Z][a-z]+ny'`

`ugrep -wil [A-Z][a-z]+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil [A-Z][a-z]+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil [A-Z][a-z]+ny corpi/enwik8`
real 1.66
user 1.63
sys 0.02

`ggrep -E -wil [A-Z][a-z]+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '[A-Z][a-z]{11}ny'`

`ugrep [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ag [A-Z][a-z]{11}ny corpi/enwik8`
real 0.39
user 0.37
sys 0.02

`ggrep -E [A-Z][a-z]{11}ny corpi/enwik8`
real 0.19
user 0.18
sys 0.00

### grepping `-n '[A-Z][a-z]{11}ny'`

`ugrep -n [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -n [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`ag -n [A-Z][a-z]{11}ny corpi/enwik8`
real 0.39
user 0.37
sys 0.02

`ggrep -E -n [A-Z][a-z]{11}ny corpi/enwik8`
real 0.21
user 0.20
sys 0.00

### grepping `-no '[A-Z][a-z]{11}ny'`

`ugrep -no [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -no [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`ag -no [A-Z][a-z]{11}ny corpi/enwik8`
real 0.40
user 0.38
sys 0.02

`ggrep -E -no [A-Z][a-z]{11}ny corpi/enwik8`
real 0.21
user 0.20
sys 0.00

### grepping `-wn '[A-Z][a-z]{11}ny'`

`ugrep -wn [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -wn [A-Z][a-z]{11}ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -wn [A-Z][a-z]{11}ny corpi/enwik8`
real 0.28
user 0.26
sys 0.02

`ggrep -E -wn [A-Z][a-z]{11}ny corpi/enwik8`
real 0.21
user 0.20
sys 0.00

### grepping `-win '[A-Z][a-z]{11}ny'`

`ugrep -win [A-Z][a-z]{11}ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -win [A-Z][a-z]{11}ny corpi/enwik8`
real 0.11
user 0.10
sys 0.00

`ag -win [A-Z][a-z]{11}ny corpi/enwik8`
real 1.53
user 1.51
sys 0.02

`ggrep -E -win [A-Z][a-z]{11}ny corpi/enwik8`
real 1.42
user 1.40
sys 0.01

### grepping `-wino '[A-Z][a-z]{11}ny'`

`ugrep -wino [A-Z][a-z]{11}ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wino [A-Z][a-z]{11}ny corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`ag -wino [A-Z][a-z]{11}ny corpi/enwik8`
real 1.54
user 1.51
sys 0.02

`ggrep -E -wino [A-Z][a-z]{11}ny corpi/enwik8`
real 1.42
user 1.41
sys 0.01

### grepping `-c '[A-Z][a-z]{11}ny'`

`ugrep -c [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg -c [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`ag -c [A-Z][a-z]{11}ny corpi/enwik8`
real 0.19
user 0.17
sys 0.02

`ggrep -E -c [A-Z][a-z]{11}ny corpi/enwik8`
real 0.19
user 0.18
sys 0.00

### grepping `-wic '[A-Z][a-z]{11}ny'`

`ugrep -wic [A-Z][a-z]{11}ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wic [A-Z][a-z]{11}ny corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`ag -wic [A-Z][a-z]{11}ny corpi/enwik8`
real 1.31
user 1.28
sys 0.02

`ggrep -E -wic [A-Z][a-z]{11}ny corpi/enwik8`
real 1.40
user 1.39
sys 0.01

### grepping `-l '[A-Z][a-z]{11}ny'`

`ugrep -l [A-Z][a-z]{11}ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l [A-Z][a-z]{11}ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l [A-Z][a-z]{11}ny corpi/enwik8`
real 0.19
user 0.17
sys 0.02

`ggrep -E -l [A-Z][a-z]{11}ny corpi/enwik8`
real 0.02
user 0.02
sys 0.00

### grepping `-wil '[A-Z][a-z]{11}ny'`

`ugrep -wil [A-Z][a-z]{11}ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil [A-Z][a-z]{11}ny corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`ag -wil [A-Z][a-z]{11}ny corpi/enwik8`
real 1.31
user 1.28
sys 0.02

`ggrep -E -wil [A-Z][a-z]{11}ny corpi/enwik8`
real 0.17
user 0.16
sys 0.00

### grepping ` '\w+ny'`

`ugrep \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg \w+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.01

`ag \w+ny corpi/enwik8`
real 3.32
user 3.29
sys 0.03

`ggrep -E \w+ny corpi/enwik8`
real 0.57
user 0.56
sys 0.01

### grepping `-n '\w+ny'`

`ugrep -n \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg -n \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`ag -n \w+ny corpi/enwik8`
real 3.32
user 3.29
sys 0.03

`ggrep -E -n \w+ny corpi/enwik8`
real 0.59
user 0.58
sys 0.01

### grepping `-no '\w+ny'`

`ugrep -no \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg -no \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -no \w+ny corpi/enwik8`
real 2.99
user 2.96
sys 0.02

`ggrep -E -no \w+ny corpi/enwik8`
real 1.69
user 1.67
sys 0.01

### grepping `-wn '\w+ny'`

`ugrep -wn \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg -wn \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`ag -wn \w+ny corpi/enwik8`
real 2.29
user 2.26
sys 0.02

`ggrep -E -wn \w+ny corpi/enwik8`
real 0.65
user 0.63
sys 0.01

### grepping `-win '\w+ny'`

`ugrep -win \w+ny corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -win \w+ny corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`ag -win \w+ny corpi/enwik8`
real 2.29
user 2.26
sys 0.02

`ggrep -E -win \w+ny corpi/enwik8`
real 0.86
user 0.85
sys 0.01

### grepping `-wino '\w+ny'`

`ugrep -wino \w+ny corpi/enwik8`
real 0.03
user 0.03
sys 0.00

`rg -wino \w+ny corpi/enwik8`
real 0.18
user 0.17
sys 0.01

`ag -wino \w+ny corpi/enwik8`
real 2.00
user 1.97
sys 0.02

`ggrep -E -wino \w+ny corpi/enwik8`
real 2.06
user 2.04
sys 0.01

### grepping `-c '\w+ny'`

`ugrep -c \w+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -c \w+ny corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -c \w+ny corpi/enwik8`
real 2.69
user 2.67
sys 0.02

`ggrep -E -c \w+ny corpi/enwik8`
real 0.56
user 0.55
sys 0.01

### grepping `-wic '\w+ny'`

`ugrep -wic \w+ny corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -wic \w+ny corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`ag -wic \w+ny corpi/enwik8`
real 1.68
user 1.66
sys 0.02

`ggrep -E -wic \w+ny corpi/enwik8`
real 0.83
user 0.82
sys 0.01

### grepping `-l '\w+ny'`

`ugrep -l \w+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l \w+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l \w+ny corpi/enwik8`
real 2.69
user 2.66
sys 0.02

`ggrep -E -l \w+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '\w+ny'`

`ugrep -wil \w+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil \w+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil \w+ny corpi/enwik8`
real 1.69
user 1.66
sys 0.02

`ggrep -E -wil \w+ny corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` 'ab(cd?)?'`

`ugrep ab(cd?)? corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg ab(cd?)? corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`ag ab(cd?)? corpi/enwik8`
real 1.07
user 1.04
sys 0.03

`ggrep -E ab(cd?)? corpi/enwik8`
real 0.08
user 0.07
sys 0.01

### grepping `-n 'ab(cd?)?'`

`ugrep -n ab(cd?)? corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg -n ab(cd?)? corpi/enwik8`
real 0.04
user 0.02
sys 0.01

`ag -n ab(cd?)? corpi/enwik8`
real 1.07
user 1.04
sys 0.03

`ggrep -E -n ab(cd?)? corpi/enwik8`
real 0.10
user 0.09
sys 0.01

### grepping `-no 'ab(cd?)?'`

`ugrep -no ab(cd?)? corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -no ab(cd?)? corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ag -no ab(cd?)? corpi/enwik8`
real 0.55
user 0.53
sys 0.02

`ggrep -E -no ab(cd?)? corpi/enwik8`
real 0.20
user 0.19
sys 0.00

### grepping `-wn 'ab(cd?)?'`

`ugrep -wn ab(cd?)? corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wn ab(cd?)? corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -wn ab(cd?)? corpi/enwik8`
real 0.45
user 0.43
sys 0.02

`ggrep -E -wn ab(cd?)? corpi/enwik8`
real 0.21
user 0.20
sys 0.00

### grepping `-win 'ab(cd?)?'`

`ugrep -win ab(cd?)? corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -win ab(cd?)? corpi/enwik8`
real 0.08
user 0.07
sys 0.01

`ag -win ab(cd?)? corpi/enwik8`
real 0.45
user 0.43
sys 0.02

`ggrep -E -win ab(cd?)? corpi/enwik8`
real 1.05
user 1.04
sys 0.01

### grepping `-wino 'ab(cd?)?'`

`ugrep -wino ab(cd?)? corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wino ab(cd?)? corpi/enwik8`
real 0.08
user 0.07
sys 0.01

`ag -wino ab(cd?)? corpi/enwik8`
real 0.45
user 0.42
sys 0.02

`ggrep -E -wino ab(cd?)? corpi/enwik8`
real 1.05
user 1.04
sys 0.01

### grepping `-c 'ab(cd?)?'`

`ugrep -c ab(cd?)? corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg -c ab(cd?)? corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag -c ab(cd?)? corpi/enwik8`
real 0.19
user 0.16
sys 0.02

`ggrep -E -c ab(cd?)? corpi/enwik8`
real 0.07
user 0.06
sys 0.00

### grepping `-wic 'ab(cd?)?'`

`ugrep -wic ab(cd?)? corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wic ab(cd?)? corpi/enwik8`
real 0.08
user 0.07
sys 0.01

`ag -wic ab(cd?)? corpi/enwik8`
real 0.21
user 0.18
sys 0.02

`ggrep -E -wic ab(cd?)? corpi/enwik8`
real 1.03
user 1.02
sys 0.01

### grepping `-l 'ab(cd?)?'`

`ugrep -l ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l ab(cd?)? corpi/enwik8`
real 0.19
user 0.16
sys 0.02

`ggrep -E -l ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'ab(cd?)?'`

`ugrep -wil ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil ab(cd?)? corpi/enwik8`
real 0.21
user 0.18
sys 0.02

`ggrep -E -wil ab(cd?)? corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` 'x*y*z*'`

`ugrep x*y*z* corpi/enwik8`
real 0.08
user 0.06
sys 0.01

`rg x*y*z* corpi/enwik8`
real 0.08
user 0.07
sys 0.02

`ag x*y*z* corpi/enwik8`
real 3.97
user 3.78
sys 0.18

`ggrep -E x*y*z* corpi/enwik8`
real 0.11
user 0.10
sys 0.02

### grepping `-n 'x*y*z*'`

`ugrep -n x*y*z* corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`rg -n x*y*z* corpi/enwik8`
real 0.14
user 0.12
sys 0.02

`ag -n x*y*z* corpi/enwik8`
real 3.98
user 3.79
sys 0.18

`ggrep -E -n x*y*z* corpi/enwik8`
real 0.19
user 0.17
sys 0.02

### grepping `-no 'x*y*z*'`

`ugrep -no x*y*z* corpi/enwik8`
real 0.14
user 0.13
sys 0.01

`rg -no x*y*z* corpi/enwik8`
real 5.13
user 5.07
sys 0.28

`ag -no x*y*z* corpi/enwik8`
real 3.98
user 3.76
sys 0.21

`ggrep -E -no x*y*z* corpi/enwik8`
real 7.61
user 7.56
sys 0.05

### grepping `-wn 'x*y*z*'`

`ugrep -wn x*y*z* corpi/enwik8`
real 0.10
user 0.09
sys 0.00

`rg -wn x*y*z* corpi/enwik8`
real 0.15
user 0.13
sys 0.02

`ag -wn x*y*z* corpi/enwik8`
real 3.02
user 2.95
sys 0.07

`ggrep -E -wn x*y*z* corpi/enwik8`
real 0.72
user 0.71
sys 0.03

### grepping `-win 'x*y*z*'`

`ugrep -win x*y*z* corpi/enwik8`
real 0.11
user 0.10
sys 0.00

`rg -win x*y*z* corpi/enwik8`
real 0.15
user 0.13
sys 0.02

`ag -win x*y*z* corpi/enwik8`
real 3.02
user 2.94
sys 0.07

`ggrep -E -win x*y*z* corpi/enwik8`
real 1.28
user 1.26
sys 0.03

### grepping `-wino 'x*y*z*'`

`ugrep -wino x*y*z* corpi/enwik8`
real 0.11
user 0.10
sys 0.00

`rg -wino x*y*z* corpi/enwik8`
real 0.96
user 0.95
sys 0.04

`ag -wino x*y*z* corpi/enwik8`
real 3.02
user 2.94
sys 0.07

`ggrep -E -wino x*y*z* corpi/enwik8`
real 16.78
user 16.74
sys 0.04

### grepping `-c 'x*y*z*'`

`ugrep -c x*y*z* corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -c x*y*z* corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -c x*y*z* corpi/enwik8`
real 3.73
user 3.53
sys 0.19

`ggrep -E -c x*y*z* corpi/enwik8`
real 0.04
user 0.03
sys 0.00

### grepping `-wic 'x*y*z*'`

`ugrep -wic x*y*z* corpi/enwik8`
real 0.10
user 0.10
sys 0.00

`rg -wic x*y*z* corpi/enwik8`
real 0.06
user 0.05
sys 0.00

`ag -wic x*y*z* corpi/enwik8`
real 2.78
user 2.70
sys 0.07

`ggrep -E -wic x*y*z* corpi/enwik8`
real 1.12
user 1.11
sys 0.01

### grepping `-l 'x*y*z*'`

`ugrep -l x*y*z* corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l x*y*z* corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l x*y*z* corpi/enwik8`
real 3.71
user 3.53
sys 0.18

`ggrep -E -l x*y*z* corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'x*y*z*'`

`ugrep -wil x*y*z* corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil x*y*z* corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil x*y*z* corpi/enwik8`
real 2.80
user 2.70
sys 0.09

`ggrep -E -wil x*y*z* corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.37
user 0.35
sys 0.02

`ggrep -E (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.04
user 0.03
sys 0.00

### grepping `-n '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -n (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -n (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -n (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.37
user 0.35
sys 0.02

`ggrep -E -n (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.05
user 0.05
sys 0.00

### grepping `-no '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -no (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -no (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -no (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.37
user 0.34
sys 0.02

`ggrep -E -no (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.06
user 0.05
sys 0.00

### grepping `-wn '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -wn (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wn (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -wn (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.36
user 0.34
sys 0.02

`ggrep -E -wn (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.07
user 0.06
sys 0.00

### grepping `-win '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -win (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -win (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -win (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.36
user 0.34
sys 0.02

`ggrep -E -win (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.07
user 0.07
sys 0.00

### grepping `-wino '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -wino (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -wino (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -wino (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.36
user 0.33
sys 0.02

`ggrep -E -wino (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.08
user 0.07
sys 0.00

### grepping `-c '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -c (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -c (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -c (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.13
user 0.10
sys 0.02

`ggrep -E -c (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.04
user 0.03
sys 0.00

### grepping `-wic '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -wic (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`rg -wic (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -wic (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.12
user 0.09
sys 0.02

`ggrep -E -wic (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.06
user 0.05
sys 0.00

### grepping `-l '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -l (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.13
user 0.11
sys 0.02

`ggrep -E -l (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}'`

`ugrep -wil (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.12
user 0.09
sys 0.02

`ggrep -E -wil (19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2} corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.60
user 0.57
sys 0.02

`ggrep -E (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 3.40
user 3.38
sys 0.01

### grepping `-n '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -n (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -n (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -n (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.60
user 0.57
sys 0.02

`ggrep -E -n (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 3.42
user 3.40
sys 0.01

### grepping `-no '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -no (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -no (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -no (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.50
user 0.47
sys 0.02

`ggrep -E -no (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 6.94
user 6.93
sys 0.02

### grepping `-wn '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -wn (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -wn (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -wn (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.59
user 0.56
sys 0.02

`ggrep -E -wn (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 3.53
user 3.51
sys 0.01

### grepping `-win '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -win (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`rg -win (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -win (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.60
user 0.57
sys 0.02

`ggrep -E -win (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 3.67
user 3.65
sys 0.01

### grepping `-wino '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -wino (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`rg -wino (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -wino (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.50
user 0.47
sys 0.02

`ggrep -E -wino (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 7.43
user 7.40
sys 0.02

### grepping `-c '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -c (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -c (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -c (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.19
user 0.17
sys 0.02

`ggrep -E -c (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 3.39
user 3.38
sys 0.01

### grepping `-wic '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -wic (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -wic (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -wic (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.19
user 0.17
sys 0.02

`ggrep -E -wic (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 3.64
user 3.63
sys 0.01

### grepping `-l '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -l (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -l (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.19
user 0.17
sys 0.02

`ggrep -E -l (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+'`

`ugrep -wil (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg -wil (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
**ERROR!**

`ag -wil (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.19
user 0.17
sys 0.02

`ggrep -E -wil (https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '[a-z]+-[a-z]+'`

`ugrep [a-z]+-[a-z]+ corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`rg [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`ag [a-z]+-[a-z]+ corpi/enwik8`
real 2.22
user 2.19
sys 0.03

`ggrep -E [a-z]+-[a-z]+ corpi/enwik8`
real 1.37
user 1.35
sys 0.02

### grepping `-n '[a-z]+-[a-z]+'`

`ugrep -n [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -n [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`ag -n [a-z]+-[a-z]+ corpi/enwik8`
real 2.22
user 2.19
sys 0.03

`ggrep -E -n [a-z]+-[a-z]+ corpi/enwik8`
real 1.38
user 1.37
sys 0.02

### grepping `-no '[a-z]+-[a-z]+'`

`ugrep -no [a-z]+-[a-z]+ corpi/enwik8`
real 0.03
user 0.03
sys 0.00

`rg -no [a-z]+-[a-z]+ corpi/enwik8`
real 0.06
user 0.05
sys 0.01

`ag -no [a-z]+-[a-z]+ corpi/enwik8`
real 1.72
user 1.70
sys 0.02

`ggrep -E -no [a-z]+-[a-z]+ corpi/enwik8`
real 2.70
user 2.69
sys 0.01

### grepping `-wn '[a-z]+-[a-z]+'`

`ugrep -wn [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -wn [a-z]+-[a-z]+ corpi/enwik8`
real 0.06
user 0.04
sys 0.01

`ag -wn [a-z]+-[a-z]+ corpi/enwik8`
real 2.17
user 2.14
sys 0.03

`ggrep -E -wn [a-z]+-[a-z]+ corpi/enwik8`
real 1.53
user 1.52
sys 0.02

### grepping `-win '[a-z]+-[a-z]+'`

`ugrep -win [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -win [a-z]+-[a-z]+ corpi/enwik8`
real 0.06
user 0.05
sys 0.01

`ag -win [a-z]+-[a-z]+ corpi/enwik8`
real 2.18
user 2.14
sys 0.04

`ggrep -E -win [a-z]+-[a-z]+ corpi/enwik8`
real 1.49
user 1.48
sys 0.02

### grepping `-wino '[a-z]+-[a-z]+'`

`ugrep -wino [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -wino [a-z]+-[a-z]+ corpi/enwik8`
real 0.08
user 0.07
sys 0.01

`ag -wino [a-z]+-[a-z]+ corpi/enwik8`
real 1.67
user 1.65
sys 0.02

`ggrep -E -wino [a-z]+-[a-z]+ corpi/enwik8`
real 3.36
user 3.34
sys 0.02

### grepping `-c '[a-z]+-[a-z]+'`

`ugrep -c [a-z]+-[a-z]+ corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -c [a-z]+-[a-z]+ corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`ag -c [a-z]+-[a-z]+ corpi/enwik8`
real 1.33
user 1.30
sys 0.02

`ggrep -E -c [a-z]+-[a-z]+ corpi/enwik8`
real 1.34
user 1.33
sys 0.01

### grepping `-wic '[a-z]+-[a-z]+'`

`ugrep -wic [a-z]+-[a-z]+ corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -wic [a-z]+-[a-z]+ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ag -wic [a-z]+-[a-z]+ corpi/enwik8`
real 1.28
user 1.25
sys 0.02

`ggrep -E -wic [a-z]+-[a-z]+ corpi/enwik8`
real 1.46
user 1.44
sys 0.01

### grepping `-l '[a-z]+-[a-z]+'`

`ugrep -l [a-z]+-[a-z]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l [a-z]+-[a-z]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l [a-z]+-[a-z]+ corpi/enwik8`
real 1.33
user 1.30
sys 0.02

`ggrep -E -l [a-z]+-[a-z]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '[a-z]+-[a-z]+'`

`ugrep -wil [a-z]+-[a-z]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil [a-z]+-[a-z]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil [a-z]+-[a-z]+ corpi/enwik8`
real 1.28
user 1.26
sys 0.02

`ggrep -E -wil [a-z]+-[a-z]+ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` ''`

`ugrep '' corpi/enwik8`
real 0.07
user 0.06
sys 0.01

`rg '' corpi/enwik8`
real 0.08
user 0.07
sys 0.02

`ag '' corpi/enwik8`
**ERROR!**

`ggrep -E '' corpi/enwik8`
real 0.11
user 0.10
sys 0.01

### grepping `-n ''`

`ugrep -n '' corpi/enwik8`
real 0.09
user 0.08
sys 0.02

`rg -n '' corpi/enwik8`
real 0.13
user 0.12
sys 0.02

`ag -n '' corpi/enwik8`
**ERROR!**

`ggrep -E -n '' corpi/enwik8`
real 0.19
user 0.17
sys 0.02

### grepping `-no ''`

`ugrep -no '' corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`rg -no '' corpi/enwik8`
real 5.14
user 5.08
sys 0.28

`ag -no '' corpi/enwik8`
**ERROR!**

`ggrep -E -no '' corpi/enwik8`
real 7.43
user 7.40
sys 0.03

### grepping `-wn ''`

`ugrep -wn '' corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`rg -wn '' corpi/enwik8`
real 0.15
user 0.13
sys 0.03

`ag -wn '' corpi/enwik8`
**ERROR!**

`ggrep -E -wn '' corpi/enwik8`
real 0.70
user 0.69
sys 0.03

### grepping `-win ''`

`ugrep -win '' corpi/enwik8`
real 0.09
user 0.08
sys 0.02

`rg -win '' corpi/enwik8`
real 0.15
user 0.13
sys 0.02

`ag -win '' corpi/enwik8`
**ERROR!**

`ggrep -E -win '' corpi/enwik8`
real 1.16
user 1.14
sys 0.03

### grepping `-wino ''`

`ugrep -wino '' corpi/enwik8`
real 0.09
user 0.08
sys 0.01

`rg -wino '' corpi/enwik8`
real 0.95
user 0.94
sys 0.03

`ag -wino '' corpi/enwik8`
**ERROR!**

`ggrep -E -wino '' corpi/enwik8`
real 15.58
user 15.54
sys 0.04

### grepping `-c ''`

`ugrep -c '' corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -c '' corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`ag -c '' corpi/enwik8`
**ERROR!**

`ggrep -E -c '' corpi/enwik8`
real 0.04
user 0.03
sys 0.00

### grepping `-wic ''`

`ugrep -wic '' corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -wic '' corpi/enwik8`
real 0.06
user 0.05
sys 0.00

`ag -wic '' corpi/enwik8`
**ERROR!**

`ggrep -E -wic '' corpi/enwik8`
real 1.00
user 0.99
sys 0.01

### grepping `-l ''`

`ugrep -l '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l '' corpi/enwik8`
real 0.02
user 0.00
sys 0.02

`ggrep -E -l '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil ''`

`ugrep -wil '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil '' corpi/enwik8`
real 2.02
user 1.97
sys 0.04

`ggrep -E -wil '' corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '^$'`

`ugrep ^$ corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ag ^$ corpi/enwik8`
real 0.41
user 0.38
sys 0.02

`ggrep -E ^$ corpi/enwik8`
real 0.06
user 0.05
sys 0.00

### grepping `-n '^$'`

`ugrep -n ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -n ^$ corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`ag -n ^$ corpi/enwik8`
real 0.41
user 0.38
sys 0.02

`ggrep -E -n ^$ corpi/enwik8`
real 0.09
user 0.08
sys 0.00

### grepping `-no '^$'`

`ugrep -no ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -no ^$ corpi/enwik8`
real 0.06
user 0.05
sys 0.01

`ag -no ^$ corpi/enwik8`
real 0.39
user 0.37
sys 0.02

`ggrep -E -no ^$ corpi/enwik8`
real 0.09
user 0.08
sys 0.00

### grepping `-wn '^$'`

`ugrep -wn ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -wn ^$ corpi/enwik8`
real 0.54
user 0.53
sys 0.01

`ag -wn ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -wn ^$ corpi/enwik8`
real 1.55
user 1.53
sys 0.01

### grepping `-win '^$'`

`ugrep -win ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -win ^$ corpi/enwik8`
real 0.54
user 0.53
sys 0.01

`ag -win ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -win ^$ corpi/enwik8`
real 2.87
user 2.84
sys 0.02

### grepping `-wino '^$'`

`ugrep -wino ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -wino ^$ corpi/enwik8`
real 0.54
user 0.53
sys 0.01

`ag -wino ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -wino ^$ corpi/enwik8`
real 2.89
user 2.85
sys 0.03

### grepping `-c '^$'`

`ugrep -c ^$ corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -c ^$ corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`ag -c ^$ corpi/enwik8`
real 0.14
user 0.12
sys 0.02

`ggrep -E -c ^$ corpi/enwik8`
real 0.05
user 0.04
sys 0.00

### grepping `-wic '^$'`

`ugrep -wic ^$ corpi/enwik8`
real 0.03
user 0.02
sys 0.00

`rg -wic ^$ corpi/enwik8`
real 0.53
user 0.51
sys 0.01

`ag -wic ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -wic ^$ corpi/enwik8`
real 2.82
user 2.81
sys 0.01

### grepping `-l '^$'`

`ugrep -l ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -l ^$ corpi/enwik8`
real 0.14
user 0.12
sys 0.02

`ggrep -E -l ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '^$'`

`ugrep -wil ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ag -wil ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -wil ^$ corpi/enwik8`
real 0.00
user 0.00
sys 0.00


## large text file search for words from files

### grepping ` '-fwords/1.txt'`

`ugrep -fwords/1.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -fwords/1.txt corpi/enwik8`
real 0.03
user 0.02
sys 0.01

`ggrep -E -fwords/1.txt corpi/enwik8`
real 0.08
user 0.07
sys 0.01

### grepping `-n '-fwords/1.txt'`

`ugrep -n -fwords/1.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -n -fwords/1.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`ggrep -E -n -fwords/1.txt corpi/enwik8`
real 0.10
user 0.09
sys 0.01

### grepping `-no '-fwords/1.txt'`

`ugrep -no -fwords/1.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.00

`rg -no -fwords/1.txt corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`ggrep -E -no -fwords/1.txt corpi/enwik8`
real 0.13
user 0.12
sys 0.00

### grepping `-wn '-fwords/1.txt'`

`ugrep -wn -fwords/1.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`rg -wn -fwords/1.txt corpi/enwik8`
real 0.04
user 0.03
sys 0.01

`ggrep -E -wn -fwords/1.txt corpi/enwik8`
real 0.11
user 0.10
sys 0.01

### grepping `-win '-fwords/1.txt'`

`ugrep -win -fwords/1.txt corpi/enwik8`
real 0.09
user 0.07
sys 0.01

`rg -win -fwords/1.txt corpi/enwik8`
real 0.14
user 0.13
sys 0.02

`ggrep -E -win -fwords/1.txt corpi/enwik8`
real 0.52
user 0.51
sys 0.02

### grepping `-wino '-fwords/1.txt'`

`ugrep -wino -fwords/1.txt corpi/enwik8`
real 0.19
user 0.18
sys 0.01

`rg -wino -fwords/1.txt corpi/enwik8`
real 0.37
user 0.36
sys 0.01

`ggrep -E -wino -fwords/1.txt corpi/enwik8`
real 2.31
user 2.29
sys 0.01

### grepping `-c '-fwords/1.txt'`

`ugrep -c -fwords/1.txt corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`rg -c -fwords/1.txt corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ggrep -E -c -fwords/1.txt corpi/enwik8`
real 0.07
user 0.06
sys 0.00

### grepping `-wic '-fwords/1.txt'`

`ugrep -wic -fwords/1.txt corpi/enwik8`
real 0.05
user 0.04
sys 0.00

`rg -wic -fwords/1.txt corpi/enwik8`
real 0.11
user 0.10
sys 0.00

`ggrep -E -wic -fwords/1.txt corpi/enwik8`
real 0.47
user 0.46
sys 0.00

### grepping `-l '-fwords/1.txt'`

`ugrep -l -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ggrep -E -l -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '-fwords/1.txt'`

`ugrep -wil -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ggrep -E -wil -fwords/1.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '-fwords/2.txt'`

`ugrep -fwords/2.txt corpi/enwik8`
real 0.07
user 0.06
sys 0.00

`rg -fwords/2.txt corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`ggrep -E -fwords/2.txt corpi/enwik8`
real 0.63
user 0.62
sys 0.00

### grepping `-n '-fwords/2.txt'`

`ugrep -n -fwords/2.txt corpi/enwik8`
real 0.07
user 0.07
sys 0.00

`rg -n -fwords/2.txt corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`ggrep -E -n -fwords/2.txt corpi/enwik8`
real 0.65
user 0.64
sys 0.00

### grepping `-no '-fwords/2.txt'`

`ugrep -no -fwords/2.txt corpi/enwik8`
real 0.07
user 0.07
sys 0.00

`rg -no -fwords/2.txt corpi/enwik8`
real 0.11
user 0.10
sys 0.00

`ggrep -E -no -fwords/2.txt corpi/enwik8`
real 0.65
user 0.65
sys 0.00

### grepping `-wn '-fwords/2.txt'`

`ugrep -wn -fwords/2.txt corpi/enwik8`
real 0.07
user 0.07
sys 0.00

`rg -wn -fwords/2.txt corpi/enwik8`
real 0.12
user 0.11
sys 0.01

`ggrep -E -wn -fwords/2.txt corpi/enwik8`
real 0.65
user 0.64
sys 0.00

### grepping `-win '-fwords/2.txt'`

`ugrep -win -fwords/2.txt corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`rg -win -fwords/2.txt corpi/enwik8`
real 7.46
user 7.44
sys 0.02

`ggrep -E -win -fwords/2.txt corpi/enwik8`
real 0.31
user 0.30
sys 0.00

### grepping `-wino '-fwords/2.txt'`

`ugrep -wino -fwords/2.txt corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`rg -wino -fwords/2.txt corpi/enwik8`
real 7.48
user 7.44
sys 0.03

`ggrep -E -wino -fwords/2.txt corpi/enwik8`
real 0.35
user 0.34
sys 0.00

### grepping `-c '-fwords/2.txt'`

`ugrep -c -fwords/2.txt corpi/enwik8`
real 0.07
user 0.06
sys 0.00

`rg -c -fwords/2.txt corpi/enwik8`
real 0.11
user 0.10
sys 0.00

`ggrep -E -c -fwords/2.txt corpi/enwik8`
real 0.63
user 0.62
sys 0.01

### grepping `-wic '-fwords/2.txt'`

`ugrep -wic -fwords/2.txt corpi/enwik8`
real 0.08
user 0.07
sys 0.00

`rg -wic -fwords/2.txt corpi/enwik8`
real 7.47
user 7.43
sys 0.03

`ggrep -E -wic -fwords/2.txt corpi/enwik8`
real 0.29
user 0.29
sys 0.00

### grepping `-l '-fwords/2.txt'`

`ugrep -l -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ggrep -E -l -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '-fwords/2.txt'`

`ugrep -wil -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ggrep -E -wil -fwords/2.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping ` '-fwords/3.txt'`

`ugrep -fwords/3.txt corpi/enwik8`
real 0.14
user 0.13
sys 0.01

`rg -fwords/3.txt corpi/enwik8`
real 1.20
user 1.18
sys 0.01

`ggrep -E -fwords/3.txt corpi/enwik8`
real 0.88
user 0.87
sys 0.01

### grepping `-n '-fwords/3.txt'`

`ugrep -n -fwords/3.txt corpi/enwik8`
real 0.14
user 0.14
sys 0.01

`rg -n -fwords/3.txt corpi/enwik8`
real 1.20
user 1.19
sys 0.02

`ggrep -E -n -fwords/3.txt corpi/enwik8`
real 0.91
user 0.90
sys 0.01

### grepping `-no '-fwords/3.txt'`

`ugrep -no -fwords/3.txt corpi/enwik8`
real 0.16
user 0.15
sys 0.00

`rg -no -fwords/3.txt corpi/enwik8`
real 1.48
user 1.47
sys 0.01

`ggrep -E -no -fwords/3.txt corpi/enwik8`
real 1.07
user 1.06
sys 0.01

### grepping `-wn '-fwords/3.txt'`

`ugrep -wn -fwords/3.txt corpi/enwik8`
real 0.15
user 0.14
sys 0.00

`rg -wn -fwords/3.txt corpi/enwik8`
real 1.35
user 1.34
sys 0.01

`ggrep -E -wn -fwords/3.txt corpi/enwik8`
real 1.00
user 0.99
sys 0.01

### grepping `-win '-fwords/3.txt'`

`ugrep -win -fwords/3.txt corpi/enwik8`
real 0.38
user 0.37
sys 0.01

`rg -win -fwords/3.txt corpi/enwik8`
real 12.10
user 12.07
sys 0.04

`ggrep -E -win -fwords/3.txt corpi/enwik8`
real 5.80
user 5.79
sys 0.01

### grepping `-wino '-fwords/3.txt'`

`ugrep -wino -fwords/3.txt corpi/enwik8`
real 0.39
user 0.38
sys 0.01

`rg -wino -fwords/3.txt corpi/enwik8`
real 12.13
user 12.09
sys 0.03

`ggrep -E -wino -fwords/3.txt corpi/enwik8`
real 6.03
user 6.01
sys 0.01

### grepping `-c '-fwords/3.txt'`

`ugrep -c -fwords/3.txt corpi/enwik8`
real 0.13
user 0.12
sys 0.00

`rg -c -fwords/3.txt corpi/enwik8`
real 1.19
user 1.18
sys 0.01

`ggrep -E -c -fwords/3.txt corpi/enwik8`
real 0.87
user 0.86
sys 0.01

### grepping `-wic '-fwords/3.txt'`

`ugrep -wic -fwords/3.txt corpi/enwik8`
real 0.38
user 0.37
sys 0.00

`rg -wic -fwords/3.txt corpi/enwik8`
real 12.12
user 12.06
sys 0.05

`ggrep -E -wic -fwords/3.txt corpi/enwik8`
real 5.78
user 5.77
sys 0.01

### grepping `-l '-fwords/3.txt'`

`ugrep -l -fwords/3.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l -fwords/3.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ggrep -E -l -fwords/3.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

### grepping `-wil '-fwords/3.txt'`

`ugrep -wil -fwords/3.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -wil -fwords/3.txt corpi/enwik8`
real 0.01
user 0.01
sys 0.00

`ggrep -E -wil -fwords/3.txt corpi/enwik8`
real 0.01
user 0.01
sys 0.00

### grepping ` '-fwords/4.txt'`

`ugrep -fwords/4.txt corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`rg -fwords/4.txt corpi/enwik8`
real 0.22
user 0.21
sys 0.01

`ggrep -E -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-n '-fwords/4.txt'`

`ugrep -n -fwords/4.txt corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`rg -n -fwords/4.txt corpi/enwik8`
real 0.22
user 0.21
sys 0.01

`ggrep -E -n -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-no '-fwords/4.txt'`

`ugrep -no -fwords/4.txt corpi/enwik8`
real 0.13
user 0.12
sys 0.00

`rg -no -fwords/4.txt corpi/enwik8`
real 0.23
user 0.22
sys 0.01

`ggrep -E -no -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-wn '-fwords/4.txt'`

`ugrep -wn -fwords/4.txt corpi/enwik8`
real 0.13
user 0.12
sys 0.01

`rg -wn -fwords/4.txt corpi/enwik8`
real 2.43
user 2.42
sys 0.01

`ggrep -E -wn -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-win '-fwords/4.txt'`

`ugrep -win -fwords/4.txt corpi/enwik8`
real 0.33
user 0.32
sys 0.01

`rg -win -fwords/4.txt corpi/enwik8`
real 177.07
user 176.96
sys 0.11

`ggrep -E -win -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-wino '-fwords/4.txt'`

`ugrep -wino -fwords/4.txt corpi/enwik8`
real 0.34
user 0.33
sys 0.01

`rg -wino -fwords/4.txt corpi/enwik8`
real 179.52
user 179.37
sys 0.14

`ggrep -E -wino -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-c '-fwords/4.txt'`

`ugrep -c -fwords/4.txt corpi/enwik8`
real 0.13
user 0.11
sys 0.01

`rg -c -fwords/4.txt corpi/enwik8`
real 0.22
user 0.20
sys 0.01

`ggrep -E -c -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-wic '-fwords/4.txt'`

`ugrep -wic -fwords/4.txt corpi/enwik8`
real 0.32
user 0.31
sys 0.01

`rg -wic -fwords/4.txt corpi/enwik8`
real 176.74
user 176.55
sys 0.19

`ggrep -E -wic -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-l '-fwords/4.txt'`

`ugrep -l -fwords/4.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`rg -l -fwords/4.txt corpi/enwik8`
real 0.00
user 0.00
sys 0.00

`ggrep -E -l -fwords/4.txt corpi/enwik8`
**ERROR!**

### grepping `-wil '-fwords/4.txt'`

`ugrep -wil -fwords/4.txt corpi/enwik8`
real 0.02
user 0.02
sys 0.00

`rg -wil -fwords/4.txt corpi/enwik8`
real 0.04
user 0.04
sys 0.00

`ggrep -E -wil -fwords/4.txt corpi/enwik8`
**ERROR!**


## large text file search with formatted output

### grepping `--json 'Sherlock|Holmes'`

`ugrep --json Sherlock|Holmes corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg --json Sherlock|Holmes corpi/enwik8`
real 0.02
user 0.01
sys 0.00

`ag --json Sherlock|Holmes corpi/enwik8`
real 0.33
user 0.30
sys 0.02

### grepping `--csv 'Sherlock|Holmes'`

`ugrep --csv Sherlock|Holmes corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg --csv Sherlock|Holmes corpi/enwik8`
**ERROR!**

`ag --csv Sherlock|Holmes corpi/enwik8`
**ERROR!**

### grepping `--xml 'Sherlock|Holmes'`

`ugrep --xml Sherlock|Holmes corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg --xml Sherlock|Holmes corpi/enwik8`
**ERROR!**

`ag --xml Sherlock|Holmes corpi/enwik8`
real 0.33
user 0.30
sys 0.02

### grepping `--hex 'Sherlock|Holmes'`

`ugrep --hex Sherlock|Holmes corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg --hex Sherlock|Holmes corpi/enwik8`
**ERROR!**

`ag --hex Sherlock|Holmes corpi/enwik8`
**ERROR!**


## large text file search with replaced output

### grepping `--replace=flip flop`

`ugrep --replace=flip flop corpi/enwik8`
real 0.01
user 0.00
sys 0.00

`rg --replace=flip flop corpi/enwik8`
real 0.01
user 0.00
sys 0.00


## large text file search with context

### grepping `-nA9 '^$'`

`ugrep -nA9 ^$ corpi/enwik8`
real 0.11
user 0.10
sys 0.01

`rg -nA9 ^$ corpi/enwik8`
real 0.11
user 0.09
sys 0.02

`ag -nA9 ^$ corpi/enwik8`
real 0.48
user 0.46
sys 0.03

`ggrep -E -nA9 ^$ corpi/enwik8`
real 0.17
user 0.16
sys 0.02

### grepping `-nB9 '^$'`

`ugrep -nB9 ^$ corpi/enwik8`
real 0.12
user 0.11
sys 0.01

`rg -nB9 ^$ corpi/enwik8`
real 0.12
user 0.10
sys 0.02

`ag -nB9 ^$ corpi/enwik8`
real 0.58
user 0.56
sys 0.03

`ggrep -E -nB9 ^$ corpi/enwik8`
real 0.21
user 0.19
sys 0.02

### grepping `-nC9 '^$'`

`ugrep -nC9 ^$ corpi/enwik8`
real 0.13
user 0.11
sys 0.01

`rg -nC9 ^$ corpi/enwik8`
real 0.12
user 0.11
sys 0.02

`ag -nC9 ^$ corpi/enwik8`
real 0.59
user 0.56
sys 0.03

`ggrep -E -nC9 ^$ corpi/enwik8`
real 0.19
user 0.18
sys 0.02

### grepping `-winA999 '^$'`

`ugrep -winA999 ^$ corpi/enwik8`
real 0.13
user 0.12
sys 0.02

`rg -winA999 ^$ corpi/enwik8`
real 0.66
user 0.64
sys 0.04

`ag -winA999 ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -winA999 ^$ corpi/enwik8`
real 3.03
user 3.01
sys 0.04

### grepping `-winB999 '^$'`

`ugrep -winB999 ^$ corpi/enwik8`
real 0.15
user 0.14
sys 0.02

`rg -winB999 ^$ corpi/enwik8`
real 0.67
user 0.65
sys 0.04

`ag -winB999 ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -winB999 ^$ corpi/enwik8`
real 3.19
user 3.16
sys 0.05

### grepping `-winC999 '^$'`

`ugrep -winC999 ^$ corpi/enwik8`
real 0.13
user 0.12
sys 0.02

`rg -winC999 ^$ corpi/enwik8`
real 0.66
user 0.64
sys 0.04

`ag -winC999 ^$ corpi/enwik8`
**ERROR!**

`ggrep -E -winC999 ^$ corpi/enwik8`
real 3.15
user 3.12
sys 0.05

### grepping `-nA9 'begin|end'`

`ugrep -nA9 begin|end corpi/enwik8`
real 0.07
user 0.06
sys 0.01

`rg -nA9 begin|end corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`ag -nA9 begin|end corpi/enwik8`
real 0.99
user 0.96
sys 0.03

`ggrep -E -nA9 begin|end corpi/enwik8`
real 0.22
user 0.21
sys 0.01

### grepping `-nB9 'begin|end'`

`ugrep -nB9 begin|end corpi/enwik8`
real 0.06
user 0.05
sys 0.01

`rg -nB9 begin|end corpi/enwik8`
real 0.05
user 0.04
sys 0.01

`ag -nB9 begin|end corpi/enwik8`
real 1.08
user 1.05
sys 0.03

`ggrep -E -nB9 begin|end corpi/enwik8`
real 0.23
user 0.22
sys 0.01

### grepping `-nC9 'begin|end'`

`ugrep -nC9 begin|end corpi/enwik8`
real 0.10
user 0.09
sys 0.01

`rg -nC9 begin|end corpi/enwik8`
real 0.06
user 0.05
sys 0.02

`ag -nC9 begin|end corpi/enwik8`
real 1.10
user 1.07
sys 0.04

`ggrep -E -nC9 begin|end corpi/enwik8`
real 0.25
user 0.24
sys 0.02

### grepping `-winA999 'begin|end'`

`ugrep -winA999 begin|end corpi/enwik8`
real 0.12
user 0.11
sys 0.01

`rg -winA999 begin|end corpi/enwik8`
real 0.14
user 0.12
sys 0.02

`ag -winA999 begin|end corpi/enwik8`
real 0.72
user 0.70
sys 0.04

`ggrep -E -winA999 begin|end corpi/enwik8`
real 0.77
user 0.75
sys 0.02

### grepping `-winB999 'begin|end'`

`ugrep -winB999 begin|end corpi/enwik8`
real 0.15
user 0.13
sys 0.01

`rg -winB999 begin|end corpi/enwik8`
real 0.15
user 0.14
sys 0.02

`ag -winB999 begin|end corpi/enwik8`
real 0.83
user 0.81
sys 0.03

`ggrep -E -winB999 begin|end corpi/enwik8`
real 0.82
user 0.80
sys 0.02

### grepping `-winC999 'begin|end'`

`ugrep -winC999 begin|end corpi/enwik8`
real 0.12
user 0.11
sys 0.02

`rg -winC999 begin|end corpi/enwik8`
real 0.14
user 0.13
sys 0.02

`ag -winC999 begin|end corpi/enwik8`
real 0.82
user 0.79
sys 0.04

`ggrep -E -winC999 begin|end corpi/enwik8`
real 0.78
user 0.76
sys 0.02


## large long lines JSON file search

### grepping ` 'abc[a-z0-9]+'`

`ugrep abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.01

`rg abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.00
sys 0.01

`ag abc[a-z0-9]+ corpi/large.json`
real 1.39
user 1.36
sys 0.03

`ggrep -E abc[a-z0-9]+ corpi/large.json`
real 0.13
user 0.12
sys 0.01

### grepping `-n 'abc[a-z0-9]+'`

`ugrep -n abc[a-z0-9]+ corpi/large.json`
real 0.03
user 0.01
sys 0.01

`rg -n abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.01

`ag -n abc[a-z0-9]+ corpi/large.json`
real 1.38
user 1.35
sys 0.03

`ggrep -E -n abc[a-z0-9]+ corpi/large.json`
real 0.14
user 0.12
sys 0.01

### grepping `-no 'abc[a-z0-9]+'`

`ugrep -no abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`rg -no abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`ag -no abc[a-z0-9]+ corpi/large.json`
real 0.53
user 0.50
sys 0.02

`ggrep -E -no abc[a-z0-9]+ corpi/large.json`
real 0.24
user 0.23
sys 0.00

### grepping `-wn 'abc[a-z0-9]+'`

`ugrep -wn abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.01

`rg -wn abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`ag -wn abc[a-z0-9]+ corpi/large.json`
real 0.43
user 0.41
sys 0.02

`ggrep -E -wn abc[a-z0-9]+ corpi/large.json`
real 0.23
user 0.23
sys 0.01

### grepping `-win 'abc[a-z0-9]+'`

`ugrep -win abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.01

`rg -win abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`ag -win abc[a-z0-9]+ corpi/large.json`
real 0.43
user 0.41
sys 0.02

`ggrep -E -win abc[a-z0-9]+ corpi/large.json`
real 1.50
user 1.49
sys 0.01

### grepping `-wino 'abc[a-z0-9]+'`

`ugrep -wino abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`rg -wino abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`ag -wino abc[a-z0-9]+ corpi/large.json`
real 0.35
user 0.32
sys 0.02

`ggrep -E -wino abc[a-z0-9]+ corpi/large.json`
real 1.63
user 1.62
sys 0.01

### grepping `-c 'abc[a-z0-9]+'`

`ugrep -c abc[a-z0-9]+ corpi/large.json`
real 0.01
user 0.00
sys 0.00

`rg -c abc[a-z0-9]+ corpi/large.json`
real 0.01
user 0.00
sys 0.00

`ag -c abc[a-z0-9]+ corpi/large.json`
real 0.11
user 0.09
sys 0.02

`ggrep -E -c abc[a-z0-9]+ corpi/large.json`
real 0.13
user 0.12
sys 0.00

### grepping `-wic 'abc[a-z0-9]+'`

`ugrep -wic abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`rg -wic abc[a-z0-9]+ corpi/large.json`
real 0.02
user 0.01
sys 0.00

`ag -wic abc[a-z0-9]+ corpi/large.json`
real 0.11
user 0.09
sys 0.02

`ggrep -E -wic abc[a-z0-9]+ corpi/large.json`
real 1.48
user 1.47
sys 0.01

### grepping `-l 'abc[a-z0-9]+'`

`ugrep -l abc[a-z0-9]+ corpi/large.json`
real 0.00
user 0.00
sys 0.00

`rg -l abc[a-z0-9]+ corpi/large.json`
real 0.00
user 0.00
sys 0.00

`ag -l abc[a-z0-9]+ corpi/large.json`
real 0.11
user 0.09
sys 0.02

`ggrep -E -l abc[a-z0-9]+ corpi/large.json`
real 0.00
user 0.00
sys 0.00

### grepping `-wil 'abc[a-z0-9]+'`

`ugrep -wil abc[a-z0-9]+ corpi/large.json`
real 0.00
user 0.00
sys 0.00

`rg -wil abc[a-z0-9]+ corpi/large.json`
real 0.00
user 0.00
sys 0.00

`ag -wil abc[a-z0-9]+ corpi/large.json`
real 0.11
user 0.09
sys 0.02

`ggrep -E -wil abc[a-z0-9]+ corpi/large.json`
real 0.05
user 0.05
sys 0.00


## OpenSSL source code repo directory search

~/Projects/ugrep/benchmarks/corpi/openssl-3.1.2 ~/Projects/ugrep/benchmarks

### grepping `-n 'FIXME|TODO'`

`ugrep -I -n FIXME|TODO`
real 0.03
user 0.01
sys 0.10

`rg -n FIXME|TODO`
real 0.09
user 0.03
sys 0.74

`ag -nr FIXME|TODO`
real 0.07
user 0.07
sys 0.47

`ggrep -E -I -nr FIXME|TODO .`
real 0.11
user 0.06
sys 0.05

### grepping `-wn 'FIXME|TODO'`

`ugrep -I -wn FIXME|TODO`
real 0.02
user 0.01
sys 0.09

`rg -wn FIXME|TODO`
real 0.09
user 0.03
sys 0.81

`ag -wnr FIXME|TODO`
real 0.07
user 0.07
sys 0.49

`ggrep -E -I -wnr FIXME|TODO .`
real 0.12
user 0.07
sys 0.05

### grepping `-win 'FIXME|TODO'`

`ugrep -I -win FIXME|TODO`
real 0.03
user 0.02
sys 0.09

`rg -win FIXME|TODO`
real 0.09
user 0.03
sys 0.80

`ag -winr FIXME|TODO`
real 0.06
user 0.13
sys 0.33

`ggrep -E -I -winr FIXME|TODO .`
real 0.18
user 0.12
sys 0.05

### grepping `-wino 'FIXME|TODO'`

`ugrep -I -wino FIXME|TODO`
real 0.03
user 0.02
sys 0.09

`rg -wino FIXME|TODO`
real 0.08
user 0.03
sys 0.74

`ag -winor FIXME|TODO`
real 0.06
user 0.13
sys 0.33

`ggrep -E -I -winor FIXME|TODO .`
real 0.18
user 0.13
sys 0.05

### grepping `-wic 'FIXME|TODO'`

`ugrep -I -wic FIXME|TODO`
real 0.03
user 0.02
sys 0.12

`rg -wic FIXME|TODO`
real 0.09
user 0.02
sys 0.78

`ag -wicr FIXME|TODO`
real 0.06
user 0.13
sys 0.34

`ggrep -E -I -wicr FIXME|TODO .`
real 0.16
user 0.11
sys 0.05

### grepping `-wil 'FIXME|TODO'`

`ugrep -I -wil FIXME|TODO`
real 0.02
user 0.02
sys 0.09

`rg -wil FIXME|TODO`
real 0.09
user 0.02
sys 0.82

`ag -wilr FIXME|TODO`
real 0.06
user 0.13
sys 0.33

`ggrep -E -I -wilr FIXME|TODO .`
real 0.16
user 0.11
sys 0.05

### grepping `-n 'char|int|long|size_t|void'`

`ugrep -I -n char|int|long|size_t|void`
real 0.04
user 0.06
sys 0.10

`rg -n char|int|long|size_t|void`
real 0.08
user 0.05
sys 0.64

`ag -nr char|int|long|size_t|void`
real 0.32
user 0.61
sys 0.13

`ggrep -E -I -nr char|int|long|size_t|void .`
real 0.17
user 0.11
sys 0.05

### grepping `-wn 'char|int|long|size_t|void'`

`ugrep -I -wn char|int|long|size_t|void`
real 0.04
user 0.05
sys 0.10

`rg -wn char|int|long|size_t|void`
real 0.08
user 0.06
sys 0.67

`ag -wnr char|int|long|size_t|void`
real 0.23
user 0.40
sys 0.14

`ggrep -E -I -wnr char|int|long|size_t|void .`
real 0.22
user 0.16
sys 0.06

### grepping `-win 'char|int|long|size_t|void'`

`ugrep -I -win char|int|long|size_t|void`
real 0.04
user 0.07
sys 0.10

`rg -win char|int|long|size_t|void`
real 0.08
user 0.09
sys 0.53

`ag -winr char|int|long|size_t|void`
real 0.23
user 0.40
sys 0.15

`ggrep -E -I -winr char|int|long|size_t|void .`
real 0.32
user 0.26
sys 0.06

### grepping `-wino 'char|int|long|size_t|void'`

`ugrep -I -wino char|int|long|size_t|void`
real 0.04
user 0.07
sys 0.10

`rg -wino char|int|long|size_t|void`
real 0.08
user 0.11
sys 0.57

`ag -winor char|int|long|size_t|void`
real 0.19
user 0.35
sys 0.15

`ggrep -E -I -winor char|int|long|size_t|void .`
real 0.42
user 0.36
sys 0.05

### grepping `-wic 'char|int|long|size_t|void'`

`ugrep -I -wic char|int|long|size_t|void`
real 0.04
user 0.06
sys 0.11

`rg -wic char|int|long|size_t|void`
real 0.08
user 0.08
sys 0.64

`ag -wicr char|int|long|size_t|void`
real 0.06
user 0.24
sys 0.20

`ggrep -E -I -wicr char|int|long|size_t|void .`
real 0.29
user 0.23
sys 0.05

### grepping `-wil 'char|int|long|size_t|void'`

`ugrep -I -wil char|int|long|size_t|void`
real 0.03
user 0.03
sys 0.11

`rg -wil char|int|long|size_t|void`
real 0.08
user 0.04
sys 0.64

`ag -wilr char|int|long|size_t|void`
real 0.06
user 0.24
sys 0.21

`ggrep -E -I -wilr char|int|long|size_t|void .`
real 0.13
user 0.08
sys 0.05

### grepping `-n 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -n ssl-?3(\.[0-9]+)?`
real 0.02
user 0.01
sys 0.09

`rg -n ssl-?3(\.[0-9]+)?`
real 0.09
user 0.02
sys 0.81

`ag -nr ssl-?3(\.[0-9]+)?`
real 0.07
user 0.09
sys 0.37

`ggrep -E -I -nr ssl-?3(\.[0-9]+)? .`
real 0.10
user 0.05
sys 0.05

### grepping `-wn 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -wn ssl-?3(\.[0-9]+)?`
real 0.02
user 0.01
sys 0.09

`rg -wn ssl-?3(\.[0-9]+)?`
real 0.09
user 0.02
sys 0.76

`ag -wnr ssl-?3(\.[0-9]+)?`
real 0.07
user 0.09
sys 0.43

`ggrep -E -I -wnr ssl-?3(\.[0-9]+)? .`
real 0.10
user 0.05
sys 0.05

### grepping `-win 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -win ssl-?3(\.[0-9]+)?`
real 0.02
user 0.01
sys 0.09

`rg -win ssl-?3(\.[0-9]+)?`
real 0.08
user 0.03
sys 0.71

`ag -winr ssl-?3(\.[0-9]+)?`
real 0.07
user 0.09
sys 0.43

`ggrep -E -I -winr ssl-?3(\.[0-9]+)? .`
real 0.12
user 0.06
sys 0.05

### grepping `-wino 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -wino ssl-?3(\.[0-9]+)?`
real 0.02
user 0.01
sys 0.09

`rg -wino ssl-?3(\.[0-9]+)?`
real 0.09
user 0.03
sys 0.78

`ag -winor ssl-?3(\.[0-9]+)?`
real 0.07
user 0.09
sys 0.44

`ggrep -E -I -winor ssl-?3(\.[0-9]+)? .`
real 0.12
user 0.06
sys 0.05

### grepping `-wic 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -wic ssl-?3(\.[0-9]+)?`
real 0.03
user 0.02
sys 0.12

`rg -wic ssl-?3(\.[0-9]+)?`
real 0.09
user 0.03
sys 0.75

`ag -wicr ssl-?3(\.[0-9]+)?`
real 0.07
user 0.08
sys 0.44

`ggrep -E -I -wicr ssl-?3(\.[0-9]+)? .`
real 0.10
user 0.04
sys 0.05

### grepping `-wil 'ssl-?3(\.[0-9]+)?'`

`ugrep -I -wil ssl-?3(\.[0-9]+)?`
real 0.03
user 0.01
sys 0.10

`rg -wil ssl-?3(\.[0-9]+)?`
real 0.09
user 0.03
sys 0.84

`ag -wilr ssl-?3(\.[0-9]+)?`
real 0.07
user 0.08
sys 0.45

`ggrep -E -I -wilr ssl-?3(\.[0-9]+)? .`
real 0.10
user 0.04
sys 0.05

~/Projects/ugrep/benchmarks


## Swift source code repo directory search

~/Projects/ugrep/benchmarks/corpi/swift-swift-5.8.1-RELEASE ~/Projects/ugrep/benchmarks

### grepping `-n '_(RUN|LIB|NAM)[A-Z_]+'`

`ugrep -n _(RUN|LIB|NAM)[A-Z_]+`
real 0.20
user 0.07
sys 0.83

`rg -n _(RUN|LIB|NAM)[A-Z_]+`
real 0.77
user 0.12
sys 7.12

`ag -nr _(RUN|LIB|NAM)[A-Z_]+`
real 0.70
user 0.29
sys 5.57

`ggrep -E -nr _(RUN|LIB|NAM)[A-Z_]+ .`
real 0.48
user 0.16
sys 0.32

### grepping `-wn '_(RUN|LIB|NAM)[A-Z_]+'`

`ugrep -wn _(RUN|LIB|NAM)[A-Z_]+`
real 0.20
user 0.07
sys 0.83

`rg -wn _(RUN|LIB|NAM)[A-Z_]+`
real 0.75
user 0.12
sys 6.84

`ag -wnr _(RUN|LIB|NAM)[A-Z_]+`
real 0.71
user 0.25
sys 5.77

`ggrep -E -wnr _(RUN|LIB|NAM)[A-Z_]+ .`
real 0.57
user 0.25
sys 0.32

### grepping `-win '_(RUN|LIB|NAM)[A-Z_]+'`

`ugrep -win _(RUN|LIB|NAM)[A-Z_]+`
real 0.19
user 0.08
sys 0.79

`rg -win _(RUN|LIB|NAM)[A-Z_]+`
real 0.76
user 0.13
sys 7.00

`ag -winr _(RUN|LIB|NAM)[A-Z_]+`
real 0.71
user 0.26
sys 5.74

`ggrep -E -winr _(RUN|LIB|NAM)[A-Z_]+ .`
real 0.61
user 0.29
sys 0.32

### grepping `-wino '_(RUN|LIB|NAM)[A-Z_]+'`

`ugrep -wino _(RUN|LIB|NAM)[A-Z_]+`
real 0.19
user 0.08
sys 0.79

`rg -wino _(RUN|LIB|NAM)[A-Z_]+`
real 0.77
user 0.13
sys 7.05

`ag -winor _(RUN|LIB|NAM)[A-Z_]+`
real 0.71
user 0.26
sys 5.73

`ggrep -E -winor _(RUN|LIB|NAM)[A-Z_]+ .`
real 0.62
user 0.29
sys 0.32

### grepping `-wic '_(RUN|LIB|NAM)[A-Z_]+'`

`ugrep -wic _(RUN|LIB|NAM)[A-Z_]+`
real 0.23
user 0.11
sys 0.91

`rg -wic _(RUN|LIB|NAM)[A-Z_]+`
real 0.77
user 0.12
sys 7.07

`ag -wicr _(RUN|LIB|NAM)[A-Z_]+`
real 0.71
user 0.25
sys 5.79

`ggrep -E -wicr _(RUN|LIB|NAM)[A-Z_]+ .`
real 0.56
user 0.23
sys 0.32

### grepping `-wil '_(RUN|LIB|NAM)[A-Z_]+'`

`ugrep -wil _(RUN|LIB|NAM)[A-Z_]+`
real 0.20
user 0.08
sys 0.82

`rg -wil _(RUN|LIB|NAM)[A-Z_]+`
real 0.78
user 0.12
sys 7.18

`ag -wilr _(RUN|LIB|NAM)[A-Z_]+`
real 0.71
user 0.25
sys 5.83

`ggrep -E -wilr _(RUN|LIB|NAM)[A-Z_]+ .`
real 0.54
user 0.22
sys 0.32

### grepping `-n 'String|Int|Double|Array|Dictionary'`

`ugrep -n String|Int|Double|Array|Dictionary`
real 0.24
user 0.15
sys 0.88

`rg -n String|Int|Double|Array|Dictionary`
real 0.75
user 0.21
sys 6.98

`ag -nr String|Int|Double|Array|Dictionary`
real 1.05
user 1.17
sys 2.49

`ggrep -E -nr String|Int|Double|Array|Dictionary .`
real 0.60
user 0.27
sys 0.33

### grepping `-wn 'String|Int|Double|Array|Dictionary'`

`ugrep -wn String|Int|Double|Array|Dictionary`
real 0.23
user 0.13
sys 0.88

`rg -wn String|Int|Double|Array|Dictionary`
real 0.76
user 0.20
sys 7.10

`ag -wnr String|Int|Double|Array|Dictionary`
real 0.74
user 0.75
sys 3.05

`ggrep -E -wnr String|Int|Double|Array|Dictionary .`
real 0.73
user 0.40
sys 0.33

### grepping `-win 'String|Int|Double|Array|Dictionary'`

`ugrep -win String|Int|Double|Array|Dictionary`
real 0.26
user 0.25
sys 0.85

`rg -win String|Int|Double|Array|Dictionary`
real 0.73
user 0.37
sys 6.65

`ag -winr String|Int|Double|Array|Dictionary`
real 0.89
user 1.36
sys 2.64

`ggrep -E -winr String|Int|Double|Array|Dictionary .`
real 1.59
user 1.25
sys 0.34

### grepping `-wino 'String|Int|Double|Array|Dictionary'`

`ugrep -wino String|Int|Double|Array|Dictionary`
real 0.26
user 0.24
sys 0.86

`rg -wino String|Int|Double|Array|Dictionary`
real 0.72
user 0.41
sys 6.47

`ag -winor String|Int|Double|Array|Dictionary`
real 0.80
user 1.26
sys 2.83

`ggrep -E -winor String|Int|Double|Array|Dictionary .`
real 1.82
user 1.48
sys 0.34

### grepping `-wic 'String|Int|Double|Array|Dictionary'`

`ugrep -wic String|Int|Double|Array|Dictionary`
real 0.24
user 0.24
sys 0.84

`rg -wic String|Int|Double|Array|Dictionary`
real 0.73
user 0.35
sys 6.64

`ag -wicr String|Int|Double|Array|Dictionary`
real 0.64
user 0.90
sys 4.51

`ggrep -E -wicr String|Int|Double|Array|Dictionary .`
real 1.51
user 1.17
sys 0.33

### grepping `-wil 'String|Int|Double|Array|Dictionary'`

`ugrep -wil String|Int|Double|Array|Dictionary`
real 0.22
user 0.11
sys 0.91

`rg -wil String|Int|Double|Array|Dictionary`
real 0.75
user 0.19
sys 7.06

`ag -wilr String|Int|Double|Array|Dictionary`
real 0.64
user 0.91
sys 4.52

`ggrep -E -wilr String|Int|Double|Array|Dictionary .`
real 0.64
user 0.31
sys 0.32

### grepping `-n '(class|struct)\sS[a-z]+T'`

`ugrep -n (class|struct)\sS[a-z]+T`
real 0.19
user 0.08
sys 0.79

`rg -n (class|struct)\sS[a-z]+T`
real 0.77
user 0.13
sys 7.10

`ag -nr (class|struct)\sS[a-z]+T`
real 0.67
user 0.50
sys 5.18

`ggrep -E -nr (class|struct)\sS[a-z]+T .`
real 0.63
user 0.30
sys 0.33

### grepping `-wn '(class|struct)\sS[a-z]+T'`

`ugrep -wn (class|struct)\sS[a-z]+T`
real 0.19
user 0.08
sys 0.79

`rg -wn (class|struct)\sS[a-z]+T`
real 0.77
user 0.14
sys 7.00

`ag -wnr (class|struct)\sS[a-z]+T`
real 0.68
user 0.45
sys 5.30

`ggrep -E -wnr (class|struct)\sS[a-z]+T .`
real 0.69
user 0.36
sys 0.32

### grepping `-win '(class|struct)\sS[a-z]+T'`

`ugrep -win (class|struct)\sS[a-z]+T`
real 0.19
user 0.09
sys 0.78

`rg -win (class|struct)\sS[a-z]+T`
real 0.74
user 0.19
sys 6.62

`ag -winr (class|struct)\sS[a-z]+T`
real 0.66
user 0.57
sys 4.95

`ggrep -E -winr (class|struct)\sS[a-z]+T .`
real 0.88
user 0.55
sys 0.32

### grepping `-wino '(class|struct)\sS[a-z]+T'`

`ugrep -wino (class|struct)\sS[a-z]+T`
real 0.20
user 0.10
sys 0.79

`rg -wino (class|struct)\sS[a-z]+T`
real 0.75
user 0.18
sys 6.74

`ag -winor (class|struct)\sS[a-z]+T`
real 0.66
user 0.58
sys 5.01

`ggrep -E -winor (class|struct)\sS[a-z]+T .`
real 0.88
user 0.55
sys 0.32

### grepping `-wic '(class|struct)\sS[a-z]+T'`

`ugrep -wic (class|struct)\sS[a-z]+T`
real 0.22
user 0.12
sys 0.88

`rg -wic (class|struct)\sS[a-z]+T`
real 0.74
user 0.18
sys 6.74

`ag -wicr (class|struct)\sS[a-z]+T`
real 0.66
user 0.56
sys 5.08

`ggrep -E -wicr (class|struct)\sS[a-z]+T .`
real 0.82
user 0.49
sys 0.33

### grepping `-wil '(class|struct)\sS[a-z]+T'`

`ugrep -wil (class|struct)\sS[a-z]+T`
real 0.19
user 0.09
sys 0.79

`rg -wil (class|struct)\sS[a-z]+T`
real 0.77
user 0.17
sys 7.06

`ag -wilr (class|struct)\sS[a-z]+T`
real 0.66
user 0.56
sys 5.07

`ggrep -E -wilr (class|struct)\sS[a-z]+T .`
real 0.78
user 0.44
sys 0.33

### grepping `-n 'for\s[a-z]+\sin'`

`ugrep -n for\s[a-z]+\sin`
real 0.20
user 0.09
sys 0.80

`rg -n for\s[a-z]+\sin`
real 0.76
user 0.15
sys 7.09

`ag -nr for\s[a-z]+\sin`
real 0.66
user 0.45
sys 4.21

`ggrep -E -nr for\s[a-z]+\sin .`
real 0.59
user 0.25
sys 0.33

### grepping `-wn 'for\s[a-z]+\sin'`

`ugrep -wn for\s[a-z]+\sin`
real 0.20
user 0.07
sys 0.81

`rg -wn for\s[a-z]+\sin`
real 0.77
user 0.13
sys 7.08

`ag -wnr for\s[a-z]+\sin`
real 0.70
user 0.38
sys 5.27

`ggrep -E -wnr for\s[a-z]+\sin .`
real 0.59
user 0.26
sys 0.33

### grepping `-win 'for\s[a-z]+\sin'`

`ugrep -win for\s[a-z]+\sin`
real 0.19
user 0.08
sys 0.80

`rg -win for\s[a-z]+\sin`
real 0.77
user 0.16
sys 7.06

`ag -winr for\s[a-z]+\sin`
real 0.70
user 0.38
sys 5.28

`ggrep -E -winr for\s[a-z]+\sin .`
real 0.77
user 0.43
sys 0.33

### grepping `-wino 'for\s[a-z]+\sin'`

`ugrep -wino for\s[a-z]+\sin`
real 0.20
user 0.08
sys 0.83

`rg -wino for\s[a-z]+\sin`
real 0.77
user 0.17
sys 7.03

`ag -winor for\s[a-z]+\sin`
real 0.71
user 0.38
sys 5.34

`ggrep -E -winor for\s[a-z]+\sin .`
real 0.77
user 0.44
sys 0.33

### grepping `-wic 'for\s[a-z]+\sin'`

`ugrep -wic for\s[a-z]+\sin`
real 0.23
user 0.10
sys 0.90

`rg -wic for\s[a-z]+\sin`
real 0.77
user 0.15
sys 7.05

`ag -wicr for\s[a-z]+\sin`
real 0.70
user 0.31
sys 5.62

`ggrep -E -wicr for\s[a-z]+\sin .`
real 0.71
user 0.37
sys 0.33

### grepping `-wil 'for\s[a-z]+\sin'`

`ugrep -wil for\s[a-z]+\sin`
real 0.20
user 0.07
sys 0.83

`rg -wil for\s[a-z]+\sin`
real 0.77
user 0.14
sys 7.09

`ag -wilr for\s[a-z]+\sin`
real 0.70
user 0.31
sys 5.64

`ggrep -E -wilr for\s[a-z]+\sin .`
real 0.64
user 0.31
sys 0.33

~/Projects/ugrep/benchmarks


## bz2 compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.bz2`
real 1.97
user 1.97
sys 0.01

`rg -z landsnail corpi/enwik8.bz2`
real 1.99
user 1.99
sys 0.02

`ag -z landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.bz2`
real 1.97
user 1.97
sys 0.01

`rg -zwin landsnail corpi/enwik8.bz2`
real 1.99
user 2.01
sys 0.02

`ag -zwin landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.bz2`
real 1.97
user 1.96
sys 0.01

`rg -zc landsnail corpi/enwik8.bz2`
real 1.99
user 1.99
sys 0.02

`ag -zc landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zwic 'landsnail'`

`ugrep -zwic landsnail corpi/enwik8.bz2`
real 2.00
user 1.97
sys 0.04

`rg -zwic landsnail corpi/enwik8.bz2`
real 2.00
user 2.01
sys 0.02

`ag -zwic landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zl 'landsnail'`

`ugrep -zl landsnail corpi/enwik8.bz2`
real 0.28
user 0.28
sys 0.00

`rg -zl landsnail corpi/enwik8.bz2`
real 0.27
user 0.27
sys 0.00

`ag -zl landsnail corpi/enwik8.bz2`
**ERROR!**

### grepping `-zwil 'landsnail'`

`ugrep -zwil landsnail corpi/enwik8.bz2`
real 0.28
user 0.28
sys 0.00

`rg -zwil landsnail corpi/enwik8.bz2`
real 0.27
user 0.27
sys 0.00

`ag -zwil landsnail corpi/enwik8.bz2`
**ERROR!**


## gz compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.gz`
real 0.30
user 0.30
sys 0.01

`rg -z landsnail corpi/enwik8.gz`
real 0.29
user 0.29
sys 0.01

`ag -z landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.gz`
real 0.30
user 0.30
sys 0.01

`rg -zwin landsnail corpi/enwik8.gz`
real 0.29
user 0.31
sys 0.01

`ag -zwin landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.gz`
real 0.30
user 0.30
sys 0.01

`rg -zc landsnail corpi/enwik8.gz`
real 0.29
user 0.29
sys 0.01

`ag -zc landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zwic 'landsnail'`

`ugrep -zwic landsnail corpi/enwik8.gz`
real 0.30
user 0.30
sys 0.01

`rg -zwic landsnail corpi/enwik8.gz`
real 0.30
user 0.31
sys 0.02

`ag -zwic landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zl 'landsnail'`

`ugrep -zl landsnail corpi/enwik8.gz`
real 0.04
user 0.04
sys 0.00

`rg -zl landsnail corpi/enwik8.gz`
real 0.04
user 0.04
sys 0.00

`ag -zl landsnail corpi/enwik8.gz`
**ERROR!**

### grepping `-zwil 'landsnail'`

`ugrep -zwil landsnail corpi/enwik8.gz`
real 0.04
user 0.04
sys 0.00

`rg -zwil landsnail corpi/enwik8.gz`
real 0.04
user 0.04
sys 0.00

`ag -zwil landsnail corpi/enwik8.gz`
**ERROR!**


## lz4 compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.lz4`
real 0.05
user 0.03
sys 0.01

`rg -z landsnail corpi/enwik8.lz4`
real 0.07
user 0.05
sys 0.01

`ag -z landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.lz4`
real 0.05
user 0.04
sys 0.01

`rg -zwin landsnail corpi/enwik8.lz4`
real 0.09
user 0.07
sys 0.01

`ag -zwin landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.lz4`
real 0.05
user 0.03
sys 0.01

`rg -zc landsnail corpi/enwik8.lz4`
real 0.07
user 0.05
sys 0.01

`ag -zc landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zwic 'landsnail'`

`ugrep -zwic landsnail corpi/enwik8.lz4`
real 0.05
user 0.03
sys 0.01

`rg -zwic landsnail corpi/enwik8.lz4`
real 0.08
user 0.07
sys 0.01

`ag -zwic landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zl 'landsnail'`

`ugrep -zl landsnail corpi/enwik8.lz4`
real 0.01
user 0.00
sys 0.00

`rg -zl landsnail corpi/enwik8.lz4`
real 0.01
user 0.01
sys 0.00

`ag -zl landsnail corpi/enwik8.lz4`
**ERROR!**

### grepping `-zwil 'landsnail'`

`ugrep -zwil landsnail corpi/enwik8.lz4`
real 0.01
user 0.00
sys 0.00

`rg -zwil landsnail corpi/enwik8.lz4`
real 0.01
user 0.01
sys 0.00

`ag -zwil landsnail corpi/enwik8.lz4`
**ERROR!**


## xz compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.xz`
real 1.08
user 1.08
sys 0.01

`rg -z landsnail corpi/enwik8.xz`
real 1.11
user 1.11
sys 0.03

`ag -z landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.xz`
real 1.08
user 1.08
sys 0.01

`rg -zwin landsnail corpi/enwik8.xz`
real 1.11
user 1.13
sys 0.03

`ag -zwin landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.xz`
real 1.08
user 1.08
sys 0.01

`rg -zc landsnail corpi/enwik8.xz`
real 1.11
user 1.11
sys 0.03

`ag -zc landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zwic 'landsnail'`

`ugrep -zwic landsnail corpi/enwik8.xz`
real 1.08
user 1.08
sys 0.01

`rg -zwic landsnail corpi/enwik8.xz`
real 1.11
user 1.12
sys 0.03

`ag -zwic landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zl 'landsnail'`

`ugrep -zl landsnail corpi/enwik8.xz`
real 0.15
user 0.15
sys 0.00

`rg -zl landsnail corpi/enwik8.xz`
real 0.15
user 0.15
sys 0.00

`ag -zl landsnail corpi/enwik8.xz`
**ERROR!**

### grepping `-zwil 'landsnail'`

`ugrep -zwil landsnail corpi/enwik8.xz`
real 0.15
user 0.15
sys 0.00

`rg -zwil landsnail corpi/enwik8.xz`
real 0.15
user 0.15
sys 0.00

`ag -zwil landsnail corpi/enwik8.xz`
**ERROR!**


## zstd compressed large text file search

### grepping `-z 'landsnail'`

`ugrep -z landsnail corpi/enwik8.zst`
real 0.11
user 0.11
sys 0.01

`rg -z landsnail corpi/enwik8.zst`
real 0.10
user 0.11
sys 0.01

`ag -z landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zwin 'landsnail'`

`ugrep -zwin landsnail corpi/enwik8.zst`
real 0.12
user 0.11
sys 0.01

`rg -zwin landsnail corpi/enwik8.zst`
real 0.11
user 0.13
sys 0.01

`ag -zwin landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zc 'landsnail'`

`ugrep -zc landsnail corpi/enwik8.zst`
real 0.11
user 0.11
sys 0.01

`rg -zc landsnail corpi/enwik8.zst`
real 0.10
user 0.11
sys 0.01

`ag -zc landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zwic 'landsnail'`

`ugrep -zwic landsnail corpi/enwik8.zst`
real 0.11
user 0.11
sys 0.01

`rg -zwic landsnail corpi/enwik8.zst`
real 0.11
user 0.13
sys 0.01

`ag -zwic landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zl 'landsnail'`

`ugrep -zl landsnail corpi/enwik8.zst`
real 0.01
user 0.01
sys 0.00

`rg -zl landsnail corpi/enwik8.zst`
**ERROR!**

`ag -zl landsnail corpi/enwik8.zst`
**ERROR!**

### grepping `-zwil 'landsnail'`

`ugrep -zwil landsnail corpi/enwik8.zst`
real 0.01
user 0.01
sys 0.00

`rg -zwil landsnail corpi/enwik8.zst`
**ERROR!**

`ag -zwil landsnail corpi/enwik8.zst`
**ERROR!**


## zip archived repo search

### grepping `-z 'FIXME|TODO'`

`ugrep -z FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.20
user 0.18
sys 0.03

`rg -z FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -z FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zwin 'FIXME|TODO'`

`ugrep -zwin FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.20
user 0.18
sys 0.03

`rg -zwin FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zwin FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zc 'FIXME|TODO'`

`ugrep -zc FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.21
user 0.18
sys 0.04

`rg -zc FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zc FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zwic 'FIXME|TODO'`

`ugrep -zwic FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.21
user 0.19
sys 0.04

`rg -zwic FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zwic FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zl 'FIXME|TODO'`

`ugrep -zl FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.20
user 0.18
sys 0.03

`rg -zl FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zl FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

### grepping `-zwil 'FIXME|TODO'`

`ugrep -zwil FIXME|TODO corpi/openssl-3.1.2.zip`
real 0.20
user 0.18
sys 0.03

`rg -zwil FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**

`ag -zwil FIXME|TODO corpi/openssl-3.1.2.zip`
**ERROR!**


## tar archived repo search

### grepping `-z 'FIXME|TODO'`

`ugrep -z FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.06
user 0.03
sys 0.03

`rg -z FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -z FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zwin 'FIXME|TODO'`

`ugrep -zwin FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.07
user 0.03
sys 0.03

`rg -zwin FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zwin FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zc 'FIXME|TODO'`

`ugrep -zc FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.07
user 0.03
sys 0.04

`rg -zc FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zc FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zwic 'FIXME|TODO'`

`ugrep -zwic FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.08
user 0.03
sys 0.04

`rg -zwic FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zwic FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zl 'FIXME|TODO'`

`ugrep -zl FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.06
user 0.03
sys 0.03

`rg -zl FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zl FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

### grepping `-zwil 'FIXME|TODO'`

`ugrep -zwil FIXME|TODO corpi/openssl-3.1.2.tar`
real 0.07
user 0.03
sys 0.03

`rg -zwil FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**

`ag -zwil FIXME|TODO corpi/openssl-3.1.2.tar`
**ERROR!**


## compressed tarball search

### grepping `-z 'FIXME|TODO'`

`ugrep -z FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.19
user 0.17
sys 0.03

`rg -z FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -z FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zwin 'FIXME|TODO'`

`ugrep -zwin FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.19
user 0.17
sys 0.03

`rg -zwin FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zwin FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zc 'FIXME|TODO'`

`ugrep -zc FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.20
user 0.17
sys 0.04

`rg -zc FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zc FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zwic 'FIXME|TODO'`

`ugrep -zwic FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.20
user 0.17
sys 0.04

`rg -zwic FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zwic FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zl 'FIXME|TODO'`

`ugrep -zl FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.19
user 0.16
sys 0.03

`rg -zl FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zl FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

### grepping `-zwil 'FIXME|TODO'`

`ugrep -zwil FIXME|TODO corpi/openssl-3.1.2.tgz`
real 0.19
user 0.17
sys 0.03

`rg -zwil FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**

`ag -zwil FIXME|TODO corpi/openssl-3.1.2.tgz`
**ERROR!**


## end of report

