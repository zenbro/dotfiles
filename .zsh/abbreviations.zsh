setopt extendedglob
typeset -Ag abbreviations
abbreviations=(
  "wclup"  "bundle exec cap live deploy:upload FILES=__CURSOR__"
  "wcldep" "bundle exec cap live deploy BRANCH=__CURSOR__ && notify-send 'deploy done'"
  "strpdep" "bundle exec cap production production2 deploy BRANCH=__CURSOR__ && notify-send 'deploy done'"
  "strsdep" "bundle exec cap staging deploy BRANCH=__CURSOR__ && notify-send 'deploy done'"
  "prdep" "bundle exec cap production deploy BRANCH=__CURSOR__ && notify-send 'deploy done'"
  "ssa" "ssh-add__CURSOR__"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    command=${abbreviations[$MATCH]}
    LBUFFER+=${command:-$MATCH}

    if [[ "${command}" =~ "__CURSOR__" ]]
    then
        RBUFFER=${LBUFFER[(ws:__CURSOR__:)2]}
        LBUFFER=${LBUFFER[(ws:__CURSOR__:)1]}
    else
        zle self-insert
    fi
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert
