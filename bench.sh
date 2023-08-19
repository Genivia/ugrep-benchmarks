#!/bin/bash

UG=${1:-ugrep}          # ugrep or script argument (e.g. to use a specific version)
RG=rg                   # ripgrep
AG=ag                   # silver searcher
GG='egrep -E'           # GNU grep -E (egrep)

# source code repository to search and .zip, .tar, .tgz files
REPO=corpi/openssl-3.1.2

# large text file to search and .bz2, .gz, .lz4, .xz, .zst files
TEXT=corpi/enwik8

# directory with word/string files for option -f
WORD=words

echo "# performance report `arch`"
echo

if [ -x "$(which $UG)" ] && $UG --version 2>&1 | grep -qw ugrep ; then
  stat -f "found $UG %z byte executable located at %N" `which $UG`
  echo ~~~
  $UG --version
  echo ~~~
  echo
else
  echo "$UG not found"
  exit
fi

if [ -x "$(which $RG)" ] && $RG --version 2>&1 | grep -qw ripgrep ; then
  stat -L -f "found $RG %z byte executable located at %N" `which $RG`
  echo ~~~
  $RG --version
  echo ~~~
  echo
else
  RG="-"
fi

if [ -x "$(which $AG)" ] && $AG --version 2>&1 | grep -qw ag ; then
  stat -L -f "found $AG %z byte executable located at %N" `which $AG`
  echo ~~~
  $AG --version
  echo ~~~
  echo
else
  AG="-"
fi

if [ -x "$(which $GG)" ] && $GG --version 2>&1 | grep -qw 'GNU grep' ; then
  stat -L -f "found $GG %z byte executable located at %N" `which $GG`
  echo ~~~
  $GG --version
  echo ~~~
  echo
else
  if [ -x "$(which ggrep)" ] && ggrep --version 2>&1 | grep -qw 'GNU grep' ; then
    stat -L -f "found ggreo %z byte executable located at %N" `which ggrep`
    GG='ggrep -E'
    echo ~~~
    $GG --version
    echo ~~~
    echo
  else
    GG='-'
  fi
fi

# run search benchmark
function run {
  if [ "$1" != "-" ] ; then
    # normalize arguments printout
    sep='`'
    for arg in "$@" ; do
      if [ "$arg" == "" ] ; then
        echo -n "$sep''"
      else
        echo -n "$sep$arg"
      fi
      sep=' '
    done
    echo '`'
    # cold run and check if OK, then warm run to time
    "$@" 2>&1 | cat > /dev/null
    if [ "${PIPESTATUS[0]}" == 0 ] ; then
      ( time -p "$@" 2>&1 | cat > /dev/null ) 2>&1
    else
      echo '**ERROR!**'
    fi
    echo
  fi
}

echo 'important notes'
echo
echo '- timing results are collected with the standard 10ms resolution; a lower resolution is unreliable due to the natural timing variations observed in the system'
echo '- all timed runs are warm runs, cold runs are not timed'
echo '- all timed runs of ugrep are performed without a .ugrep configuration file using the ugrep batch command'
echo '- ripgrep and silver searcher skip binary files by default, whereas grep and ugrep do not and use option `-I` to skip binary files; we include option `-I` in recursive searches for a fair performance comparison'
echo '- ripgrep does not search tar file contents, instead it may report *binary file matches (found "\0" byte around offset N)* without exiting with an error, so we report an error instead'
echo '- ripgrep does not output 0 matches for option `-c`, whereas grep and ugrep output 0 matches as expected (note: ugrep option `-m1,` skips zero matches but is not used in this benchmark)'
echo '- ugrep `-z` is more powerful than just decompressing a single file to search, it searches nested archives up to nesting depth `--zmax` (1 by default) by spawning one or more decompression theads; none of the other grep tools can search compressed tar files, nested archives and compressed files within archives'
echo
echo '**WARNING** performance results are meaningless when the host machine executes other tasks that load the CPU; quit all running applications first'

echo 
echo "## large text file search"
echo

for REGEX in '' 'rol' 'cycles|semigroups' 'ab(cd?)?' '^$' ; do
  for OPTS in '' '-n' '-no' '-wn' '-win' '-wino' '-cwi' '-lwi' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT
    run "$RG" $OPTS "$REGEX" $TEXT
    run "$AG" $OPTS "$REGEX" $TEXT
    run "$GG" $OPTS "$REGEX" $TEXT
  done
done

echo 
echo "## large text file search words from files"
echo

for FILE in $WORD/* ; do
  for OPTS in '-n' '-no' '-wn' '-win' '-wino' '-cwi' '-lwi' ; do
    echo '### grepping `'"$OPTS '-f$FILE'"'`'
    echo
    run "$UG" $OPTS -f"$FILE" $TEXT
    run "$RG" $OPTS -f"$FILE" $TEXT
    run "$GG" $OPTS -f"$FILE" $TEXT
  done
done

echo 
echo "## large text file search with formatted output"
echo

for REGEX in 'Sherlock|Holmes' ; do
  for OPTS in '--json' '--csv' '--xml' '--hex' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT
    run "$RG" $OPTS "$REGEX" $TEXT
    run "$AG" $OPTS "$REGEX" $TEXT
  done
done

echo 
echo "## large text file search with replaced output"
echo

echo '### grepping `--replace=flip flop`'
echo
run "$UG" "--replace=flip" flop $TEXT
run "$RG" "--replace=flip" flop $TEXT

echo 
echo "## large text file search with context"
echo

for REGEX in '^$' 'Sherlock|Holmes' ; do
  for OPTS in '-A1' '-B1' '-C1' '-winA1' '-winB1' '-winC1' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT
    run "$RG" $OPTS "$REGEX" $TEXT
    run "$AG" $OPTS "$REGEX" $TEXT
    run "$GG" $OPTS "$REGEX" $TEXT
  done
done

echo 
echo "## source code repo directory search"
echo

pushd $REPO
echo
for REGEX in 'FIXME|TODO' 'char|int|long|size_t|void' 'ssl-?3(\.[0-9]+)?' ; do
  for OPTS in '-n' '-wn' '-win' '-wino' '-cwi' '-lwi' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG -I $OPTS "$REGEX"
    run $RG $OPTS "$REGEX"
    OPTS=$OPTS"r"
    run $AG $OPTS "$REGEX"
    run $GG -I $OPTS "$REGEX" .
  done
done
popd
echo

echo 
echo "## bz2 compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT.bz2
    run "$RG" $OPTS "$REGEX" $TEXT.bz2
    run "$AG" $OPTS "$REGEX" $TEXT.bz2
  done
done

echo 
echo "## gz compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT.gz
    run "$RG" $OPTS "$REGEX" $TEXT.gz
    run "$AG" $OPTS "$REGEX" $TEXT.gz
  done
done

echo 
echo "## lz4 compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT.lz4
    run "$RG" $OPTS "$REGEX" $TEXT.lz4
    run "$AG" $OPTS "$REGEX" $TEXT.lz4
  done
done

echo 
echo "## xz compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT.xz
    run "$RG" $OPTS "$REGEX" $TEXT.xz
    run "$AG" $OPTS "$REGEX" $TEXT.xz
  done
done

echo 
echo "## zstd compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $TEXT.zst
    run "$RG" $OPTS "$REGEX" $TEXT.zst
    run "$AG" $OPTS "$REGEX" $TEXT.zst
  done
done

echo 
echo "## zip archived repo search"
echo

for REGEX in 'FIXME|TODO' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $REPO.zip
    run "$RG" $OPTS "$REGEX" $REPO.zip
    run "$AG" $OPTS "$REGEX" $REPO.zip
  done
done

echo 
echo "## tar archived repo search"
echo

for REGEX in 'FIXME|TODO' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $REPO.tar
#   wait, what???
#   run "$RG" $OPTS "$REGEX" $REPO.tar
#   ripgrep searches tar as if it were a binary file without exiting with an error? That's not right!
    echo '`'"$RG" $OPTS "$REGEX" $REPO.tar'`'
    echo "**ERROR!**"
    echo
    run "$AG" $OPTS "$REGEX" $REPO.tar
  done
done

echo 
echo "## compressed tarball search"
echo

for REGEX in 'FIXME|TODO' ; do
  for OPTS in '-z' '-zwin' '-zc' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run "$UG" $OPTS "$REGEX" $REPO.tgz
#   wait, what???
#   run "$RG" $OPTS "$REGEX" $REPO.tgz
#   ripgrep searches tar as if it were a binary file without exiting with an error? That's not right!
    echo '`'"$RG" $OPTS "$REGEX" $REPO.tgz'`'
    echo "**ERROR!**"
    echo
    run "$AG" $OPTS "$REGEX" $REPO.tgz
  done
done

echo 
echo "## end of report"
echo
