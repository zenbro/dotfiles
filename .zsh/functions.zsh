function zsh_refresh() {
  rm -rfv ~/.zsh/cache/*
  rm -fv ~/.zcompdump
  compinit
  echo 'Done!'
}

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function path() {
  echo $PATH | tr : '\n'
}

function activate() {
  PROMPT_BACKUP=$PROMPT
  source ./bin/activate
  PROMPT=$PROMPT_BACKUP
}

function improve() {
  if [ -n "$1" ]; then
    echo "$(date +'[%F %X]') $1" >> $HOME/Dropbox/notes/improve.txt
    tail -n 1 $HOME/Dropbox/notes/improve.txt
  fi
}

function _set_title() {
  print -Pn '\e]1;%l@%m${1+*}\a'
  print -Pn '\e]2;%n@%m:%~'
  if [ -n "$1" ]; then
    print -Pnr ' (%24>..>$1%>>)'|tr '\0-\037' '?'
  fi
  print -Pn "\a"
}
precmd_functions+=(omz_termsupport_preexec)

precmd () { _set_title "$@" }
preexec() { _set_title "$@" }
