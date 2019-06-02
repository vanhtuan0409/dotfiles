timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}
