#!/bin/bash

# ugrep project auto-benchmarks https://github.com/Genivia/ugrep

UG=${1:-ugrep}          # ugrep or script argument (e.g. to use a specific version)
RG=rg                   # ripgrep
AG=ag                   # silver searcher
GG='egrep'              # GNU grep -E (egrep)

# source code repositories to search and .zip, .tar, .tgz files
REPO1=corpi/openssl-3.1.2
REPO2=corpi/swift-swift-5.8.1-RELEASE

# large text file to search and .bz2, .gz, .lz4, .xz, .zst files
TEXT=corpi/enwik8

# large JSON file with long lines to search
JSON=corpi/large.json

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
    stat -L -f "found ggrep %z byte executable located at %N" `which ggrep`
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

# search benchmark provably fails, report it
function fail {
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
    echo '**ERROR!**'
    echo
  fi
}

echo 
echo "## large text file search"
echo

for REGEX in 'rol' 'the' 'cycles|semigroups' 'ro[a-z]*ds' 'ab(cd?)?' 'x*y*z*' \
      '(19|20)[0-9]{2}/(0[1-9]|1[012])|(0[1-9]|1[012])/(19|20)[0-9]{2}' \
      '(https?://|www\.)[-a-zA-Z0-9@:%._+~#=]{1,253}\.[-a-zA-Z0-9]{2,}\.[][a-zA-Z0-9()@:%_+.~#?&/=\-]+' \
      '^={2,4}[^=].*' \
      '' '^$' ; do
  for OPTS in '' '-n' '-no' '-wn' '-win' '-wino' '-c' '-wic' '-l' '-wil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT
    run $RG $OPTS "$REGEX" $TEXT
    run $AG $OPTS "$REGEX" $TEXT
    run $GG $OPTS "$REGEX" $TEXT
  done
done

echo 
echo "## large text file search for words from files"
echo

for FILE in $WORD/* ; do
  for OPTS in '' '-n' '-no' '-wn' '-win' '-wino' '-c' '-wic' '-l' '-wil' ; do
    echo '### grepping `'"$OPTS '-f$FILE'"'`'
    echo
    run $UG $OPTS -f"$FILE" $TEXT
    run $RG $OPTS -f"$FILE" $TEXT
    # GNU grep takes an hour on this one, so we fail it:
    if [ "$FILE" != "$WORD/4.txt" ] ; then
      run $GG $OPTS -f"$FILE" $TEXT
    else
      fail $GG $OPTS -f"$FILE" $TEXT
    fi
  done
done

echo 
echo "## large text file search with formatted output"
echo

for REGEX in 'Sherlock|Holmes' ; do
  for OPTS in '--json' '--csv' '--xml' '--hex' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT
    run $RG $OPTS "$REGEX" $TEXT
    run $AG $OPTS "$REGEX" $TEXT
  done
done

echo 
echo "## large text file search with replaced output"
echo

echo '### grepping `--replace=flip flop`'
echo
run $UG "--replace=flip" flop $TEXT
run $RG "--replace=flip" flop $TEXT

echo 
echo "## large text file search with context"
echo

for REGEX in '^$' 'Sherlock|Holmes' ; do
  for OPTS in '-A1' '-B1' '-C1' '-winA1' '-winB1' '-winC1' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT
    run $RG $OPTS "$REGEX" $TEXT
    run $AG $OPTS "$REGEX" $TEXT
    run $GG $OPTS "$REGEX" $TEXT
  done
done

echo 
echo "## large long lines JSON file search"
echo

for REGEX in '99' 'abc[a-z0-9]+' ; do
  for OPTS in '' '-n' '-no' '-wn' '-win' '-wino' '-c' '-wic' '-l' '-wil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $JSON
    run $RG $OPTS "$REGEX" $JSON
    run $AG $OPTS "$REGEX" $JSON
    run $GG $OPTS "$REGEX" $JSON
  done
done

echo 
echo "## OpenSSL source code repo directory search"
echo

pushd $REPO1
echo
for REGEX in 'FIXME|TODO' 'char|int|long|size_t|void' 'ssl-?3(\.[0-9]+)?' ; do
  for OPTS in '-n' '-wn' '-win' '-wino' '-wic' '-wil' ; do
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
echo "## Swift source code repo directory search"
echo

pushd $REPO2
echo
for REGEX in '_(RUN|LIB|NAM)[A-Z_]+' 'String|Int|Double|Array|Dictionary' '(class|struct)\sS[a-z]+T' 'for\s[a-z]+\sin' ; do
  for OPTS in '-n' '-wn' '-win' '-wino' '-wic' '-wil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX"
    run $RG $OPTS "$REGEX"
    OPTS=$OPTS"r"
    run $AG $OPTS "$REGEX"
    run $GG $OPTS "$REGEX" .
  done
done
popd
echo

echo 
echo "## bz2 compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT.bz2
    run $RG $OPTS "$REGEX" $TEXT.bz2
    run $AG $OPTS "$REGEX" $TEXT.bz2
  done
done

echo 
echo "## gz compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT.gz
    run $RG $OPTS "$REGEX" $TEXT.gz
    run $AG $OPTS "$REGEX" $TEXT.gz
  done
done

echo 
echo "## lz4 compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT.lz4
    run $RG $OPTS "$REGEX" $TEXT.lz4
    run $AG $OPTS "$REGEX" $TEXT.lz4
  done
done

echo 
echo "## xz compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT.xz
    run $RG $OPTS "$REGEX" $TEXT.xz
    run $AG $OPTS "$REGEX" $TEXT.xz
  done
done

echo 
echo "## zstd compressed large text file search"
echo

for REGEX in 'landsnail' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $TEXT.zst
    run $RG $OPTS "$REGEX" $TEXT.zst
    run $AG $OPTS "$REGEX" $TEXT.zst
  done
done

echo 
echo "## zip archived repo search"
echo

for REGEX in 'FIXME|TODO' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $REPO1.zip
    run $RG $OPTS "$REGEX" $REPO1.zip
    run $AG $OPTS "$REGEX" $REPO1.zip
  done
done

echo 
echo "## tar archived repo search"
echo

for REGEX in 'FIXME|TODO' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $REPO1.tar
#   wait, what???
#   run $RG $OPTS "$REGEX" $REPO1.tar
#   ripgrep searches tar as if it were a binary file without exiting with an error? That's not right!
    fail $RG $OPTS "$REGEX" $REPO1.tar
    run $AG $OPTS "$REGEX" $REPO1.tar
  done
done

echo 
echo "## compressed tarball search"
echo

for REGEX in 'FIXME|TODO' ; do
  for OPTS in '-z' '-zwin' '-zc' '-zwic' '-zl' '-zwil' ; do
    echo '### grepping `'"$OPTS '$REGEX'"'`'
    echo
    run $UG $OPTS "$REGEX" $REPO1.tgz
#   wait, what???
#   run $RG $OPTS "$REGEX" $REPO1.tgz
#   ripgrep searches tar as if it were a binary file without exiting with an error? That's not right!
    fail $RG $OPTS "$REGEX" $REPO1.tgz
    run $AG $OPTS "$REGEX" $REPO1.tgz
  done
done

# must end with a final ## section

echo 
echo "## end of report"
echo
