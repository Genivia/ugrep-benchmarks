#!/bin/sh

# ugrep project auto-benchmarks https://github.com/Genivia/ugrep

cat << END
# performance reports

Updated benchmarks are automatically generated and published when a new version of ugrep is released
Last updated: `date "+%Y-%m-%d"`

END

cat << 'END'
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
- all regex patterns tested are fully compliant with the common ERE standard syntax; a failure may occur if a grep tool fails to parse ERE (ripgrep failing to parse `[][a-z]` in URL pattern testing, `[\[\]a-z]` works but this is not compliant so GNU grep fails)
- ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files; we include option `-I` in recursive searches for a fair performance comparison
- ripgrep does not search tar file contents, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead
- ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected (note: ugrep option `-m1,` skips zero matches but is not used in this benchmark)
- ugrep `-z` is more powerful than just decompressing a single file to search, it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files within archives
- ugrep context options `-ABC` are a bit sub-optimal because of double buffering (input buffer and context buffer), which will be optimized soon in a future release
- ugrep line matching and option `-c` will be optimized in a future release; when matching lines, the idea is to skip to the next line when permitted instead of continuing matching on the same line, an optimization that is effectively performed by GNU grep and copied by other grep
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
