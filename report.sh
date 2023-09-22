#!/bin/sh

# ugrep project auto-benchmarks https://github.com/Genivia/ugrep

cat << END
# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released.
Last update `date "+%a %b %d %T %Z %Y"`

END

cat << 'END'
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
- **ugrep option `-z` is more powerful than just decompressing a single file to search,** it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files stored within archives
- different versions and implementations of **the same compression library may have different performance characteristics**, notably zlib (gz); the performance is mostly determined by the compression library and is not attributable to the grep tool

## important notes on pending ugrep performance improvements

- ugrep context options `-ABC` are suboptimal, because of double buffering overhead (input buffer and context buffer), which will be optimized soon in a future release
- ugrep patterns with leading `+` repetitions that match "anything", such as `\w+foo` are quite slow, because of pattern search backtracking, which will be optimized in a future release
END

echo
echo "# performance report x64"
echo

tail +3 report_x64.md | sed -n '/^## /q;p'
./collect.awk < report_x64.md

echo
echo "# performance report arm64"
echo

tail +3 report_arm64.md | sed -n '/^## /q;p'
./collect.awk < report_arm64.md
