# The current branch name
# Usage example: git pull origin $(current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# git push origin $(current_branch)
gpb() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push -u origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(current_branch)"
    git push -u origin "${b:=$1}"
  fi
}
compdef _git ggp=git-checkout

# git push origin :$(current_branch)
gpd() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push -u origin :"${*}"
  else
    [[ "$#" == 0 ]] && local b="$(current_branch)"
    git push -u origin :"${b:=$1}"
  fi
}
compdef _git ggd=git-checkout

# git reset --hard origin/$(current_branch)
gre!() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git reset --hard origin/"${*}"
  else
    [[ "$#" == 0 ]] && local b="$(current_branch)"
    git reset --hard origin/"${b:=$1}"
  fi
}

# list files from commit, separated by comma (for cap deploy:upload FILES=...)
gfi() {
  local commit_sha=`fcs`
  git diff-tree --no-commit-id --name-only -r "$commit_sha" | paste -sd "," -
}

# Aliases

alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gapa="git add --patch"

alias gb="git branch"
alias gba="git branch --all"
alias gbr="git branch --remote"
alias gbd="git branch -D"

alias gc="git commit -v -m"
alias gca="git commit --amend"
alias gcm="git commit"

alias gcd='cd "`git rev-parse --show-toplevel`"'

alias gco="git checkout"
alias gcoc="fcoc"
alias gcob="git checkout -b"
alias gcof="git checkout -f"

alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"

alias gd="git diff"
alias gdd="git diff HEAD~"

alias gf="git fetch"
alias gfo="git fetch --origin"

alias gl="git pull"
alias gup="git pull --rebase"
alias gupv="git pull --rebase -v"

alias gm="git merge --no-ff"
alias gma="git merge --abort"
alias gms="git merge --squash"
alias gmt='git mergetool --no-prompt'

alias gp="git push"
alias gp!="git push --force"
alias gpt="git push --tags"
alias gpu="git push upstream"
alias gpv="git push -v"

alias grb="git rebase"
alias grbi="git rebase -i"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"

alias gre="git reset HEAD"

alias grmv="git remote rename"
alias grrm="git remote remove"
alias grset="git remote set-url"

alias gs="git status"
alias gss="git status --short --branch"

alias gsi="git submodule init"
alias gsu="git submodule update"

alias gst="git stash"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"

alias gcl="git clean -f"

alias glg="tig"
alias gls="git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an>%Creset' --abbrev-commit --decorate --numstat"
alias gwho="git shortlog -n -s --no-merges"
