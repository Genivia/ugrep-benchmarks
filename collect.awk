#!/usr/bin/awk -f

BEGIN {
  FS=" "
  title=""
  ncmd=0
  nopt=0
  nrex=0
}

END {
  printf "\n\n"
}

/^`/ {
  cmd=substr($1,2)
  # ignore options -E and -I that are sometimes added to for fair performance comparisons
  if ($2=="-E") {
    if ($3=="-I") {
      opt=$4
      rex=$5
      if (substr(opt,1,1)!="-" || substr(opt,1,2)=="-f") {
        rex=opt
        opt="(none)"
      }
    }
    else {
      opt=$3
      rex=$4
      if (substr(opt,1,1)!="-" || substr(opt,1,2)=="-f") {
        rex=opt
        opt="(none)"
      }
    }
  }
  else if ($2=="-I") {
    opt=$3
    rex=$4
    if (substr(opt,1,1)!="-" || substr(opt,1,2)=="-f") {
      rex=opt
      opt="(none)"
    }
  }
  else {
    opt=$2
    rex=$3
    if (substr(opt,1,1)!="-" || substr(opt,1,2)=="-f") {
      rex=opt
      opt="(none)"
    }
  }
  # remove trailing `
  if (substr(rex,length(rex),1) == "`")
    rex=substr(rex,1,length(rex)-1)
  # arrays to maintain the order of commands, options and regex
  if (!(cmd in cmds)) {
    cmds[cmd]=1
    icmds[ncmd++]=cmd
  }
  if (!(opt in opts)) {
    opts[opt]=1
    iopts[nopt++]=opt
  }
  if (!(rex in rexs)) {
    rexs[rex]=1
    irexs[nrex++]=rex
  }
}

/^real [0-9]+\.[0-9]+/ {
  perf[cmd,opt,rex]=$2
}

/^\*\*ERROR!\*\*/ {
  perf[cmd,opt,rex]="*fail*"
}

/^# / {
  print
  printf "\n"
}

/^## / {
  if (title!="" && ncmd>0 && nopt>0 && nrex>0) {
    printf "\n## results for %s\n",substr(title,4)
    for (i=0; i<nrex; ++i) {
      rex=irexs[i]
      printf "\ngrepping `%s` elapsed real time (s)\n\n",rex
      printf "| search |"
      for (j=0; j<nopt; ++j)
        printf " %6s |",iopts[j]
      printf "\n| -----: |"
      for (j=0; j<nopt; ++j)
        printf " -----: |"
      printf "\n"
      for (j=0; j<ncmd; ++j) {
        cmd=icmds[j]
        printf "| %6s |",cmd
        for (k=0; k<nopt; ++k) {
          opt=iopts[k]
          printf " %6s |",perf[cmd,opt,rex]
        }
        printf "\n"
      }
    }
  }
  title=$0
  delete cmds
  delete opts
  delete rexs
  delete icmds
  delete iopts
  delete irexs
  ncmd=0
  nopt=0
  nrex=0
}

function cmp_str_val(i1, v1, i2, v2)
{
  # string value comparison, ascending order
  v1 = v1 ""
  v2 = v2 ""
  if (v1 < v2)
    return -1
  return (v1 != v2)
}
