# set vim bindings
bindkey -v
setopt promptsubst

# PROMPT SECTION
function pwd_tilde {
    if [[ "${PWD#$HOME}" != "$PWD" ]] then
        echo "~${PWD#$HOME}"
    else
        echo "$PWD"
    fi
}

local dir='$(pwd_tilde)'
local day_time='$(date +%R)'

if [[ "$(uname)" == "Darwin" ]] then
    PS1="[$(whoami)@$(hostname) $dir]$ "
else
    PS1="[$(printf '\e[35m')$day_time$(printf '\e[0m')] $(printf '\e[34m')""$dir"" $(printf '\e[0m')$(printf '\e[32m')$ $(printf '\e[0m')"
fi

export MAN_POSIXLY_CORRECT=1

if [[ -f ~/.env ]]; then
    source ~/.env
fi

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi
