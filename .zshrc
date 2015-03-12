# History {{{
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit
setopt extended_history       # save timestamp of command and duration
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space      # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups      # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks     # Remove extra blanks from each command line being added to history
setopt hist_verify            # don't execute, just expand history
setopt share_history          # imports new commands and appends typed commands to history
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
# }}}
# Prompt {{{
setopt prompt_subst      # enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt
autoload colors; colors

GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}*%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}+%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"

function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

function parse_git_state() {
  local GIT_STATE=''

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]] || \
    ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_STATE "
  fi
}

function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_state)%{$fg_bold[yellow]%}${git_where#(refs/heads/|tags/)}%{$reset_color%}"
}

function rvm_prompt_string() {
  local RVM_GEMSET=$(rvm-prompt g)
  [ -n "$RVM_GEMSET" ] || return 1

  local RVM_PROMPT="%{$fg_bold[blue]%}$(rvm-prompt v p g)%{$reset_color%}"
  echo "%{$fg[blue]%}[%{$reset_color%}$RVM_PROMPT%{$fg[blue]%}]%{$reset_color%}"
}

function virtualenv_prompt_string() {
  [ $VIRTUAL_ENV ] || return 1
  local VENV_PROMPT="%{$fg_bold[blue]%}$(basename $VIRTUAL_ENV)%{$reset_color%}"
  echo "%{$fg[blue]%}[%{$reset_color%}$VENV_PROMPT%{$fg[blue]%}]%{$reset_color%}"
}

if [[ $USER == 'root' ]]; then
  PROMPT_SIGN='#'
else
  PROMPT_SIGN='>'
fi

PROMPT="%{$fg[black]%}%{$bg[white]%} %~ %{$reset_color%} %{$fg_bold[red]%}${PROMPT_SIGN} %{$reset_color%}"
RPROMPT='$(git_prompt_string) $(rvm_prompt_string)$(virtualenv_prompt_string)'
# }}}
# Completion {{{
unsetopt menu_complete # do not autoselect the first completion entry
setopt always_to_end   # when completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu       # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt correct         # spelling correction for commands

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' menu select=2 # show menu when there is more that 2 entries
zstyle ':completion:*'           matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion::full:*'     matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-/]=* r:|=* l:|[._-/]=* l:|=*'
zstyle ':completion:*:cd:*'      tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# add red dots
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}

zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
# }}}
# Bindings {{{
bindkey -e   # Default to standard emacs bindings, regardless of editor string

# smart C-W
autoload -U select-word-style
select-word-style bash

bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a  
bindkey "^E"      end-of-line                          # ctrl-e
bindkey "[B"      history-search-forward               # down arrow
bindkey "[A"      history-search-backward              # up arrow
bindkey "^D"      delete-char                          # ctrl-d
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b
# }}}
# Misc {{{
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt rmstarsilent
# }}}

# must be set before compinit
fpath=(~/.zsh/plugins $fpath)

autoload -U compinit compdef; compinit
zmodload -i zsh/complist

source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh

for plugin in ~/.zsh/plugins/*.zsh; do
  source $plugin
done

stty -ixon # disable CTRL-S freeze
cd .       # gemset fix for tmux

# vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
