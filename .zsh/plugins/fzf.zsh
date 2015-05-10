#!/usr/bin/zsh
# https://github.com/junegunn/fzf/wiki/examples

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fea - search hidden files and open matching in vim
fea() {
  local file
  file=$(ag -l --hidden -g "" | fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# fstart - start systemd unit
fstart() {
  unit=$(systemctl list-unit-files | grep disabled |
    awk '{print $1}' | grep service | fzf)
  [ -n "$unit" ] && sudo systemctl start $unit &&
    journalctl -u $unit --since "10 sec ago" --no-pager
}

# fstop - stop systemd unit
fstop() {
  unit=$(systemctl list-units | grep running |
    awk '{print $1}' | grep service | fzf)
  [ -n "$unit" ] && sudo systemctl stop $unit &&
    journalctl -u $unit --since "10 sec ago" --no-pager
}

# fpaci - install new package
fpaci() {
  package=$(pacman -Ssq | fzf)
  [ -n "$package" ] && sudo pacman -S $package
}

# fpacd - completely uninstall package
fpacd() {
  package=$(pacman -Qqe | fzf)
  [ -n "$package" ] && sudo pacman -Rscn $package
}

# fpacs - get information about package
fpacs() {
  package=$(pacman -Ssq | fzf)
  [ -n "$package" ] && pacman -Ss "^$package$"
}

# v - open files in ~/.viminfo
v() {
  local file
  file=$(sed '1d' $HOME/.vim/cache/neomru/file |
          fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && vim $file
}

# vd - cd to most recent used directory by vim
vd() {
  local dir
  dir=$(sed '1d' $HOME/.vim/cache/neomru/directory |
        fzf --query="$1" --select-1 --exit-0) && cd "$dir"
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

# RVM integration
frb() {
  local rb
  rb=$((echo system; rvm list | grep ruby | cut -c 4-) |
       awk '{print $1}' |
       fzf-tmux -l 30 +m --reverse) && rvm use $rb
}

# fh - repeat history
fh() {
  eval $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fhe - repeat history with edit
fhe() {
  print -z $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
