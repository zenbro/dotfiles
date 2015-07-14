#! /bin/sh
if [ $# -eq 1 -a x"$1" = x--version ]; then
    rubocop "$@" 2>&1 | \
        sed '/warning: parser\/current is loading parser\/ruby[0-9]*, which recognizes/d;
             /warning: [0-9.]*-compliant syntax, but you are running [0-9.]/d'
else
    exec rubocop "$@"
fi
