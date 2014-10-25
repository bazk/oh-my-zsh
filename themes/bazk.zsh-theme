# bazk.zsh-theme
#
# Author: Eduardo L. Buratti (bazk)
# URL: http://bazk.me/

# LS colors, made with http://geoff.greer.fm/lscolors/
#export LSCOLORS="Gxfxcxdxbxegedabagacad"
#export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

function theme_precmd {
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    PR_PWDLEN=""

    local pwdsize=${#${(%):-%~}}

    if [[ "$TERMWIDTH - $pwdsize" -lt 64 ]]; then
      PR_PWDLEN=30
    fi
}

setopt extended_glob
theme_preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    setopt prompt_subst

    if [ -z "$ZSH_USER_COLOR" ]; then
        if [ $UID -eq 0 ]; then
            ZSH_USER_COLOR="$fg_bold[red]";
        fi
    fi

    ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git:("
    ZSH_THEME_GIT_PROMPT_CLEAN=""
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%} "

    PROMPT='%$PR_PWDLEN<...<%~ % $(git_prompt_info)%{$ZSH_HOST_COLOR%}%(!.#.»)%{$reset_color%} '
    PROMPT2='%{$fg[red]%}\%{$reset_color%} '
    RPROMPT='%(?..%{$fg[red]%}%? ↵ %{$reset_color%})« %{$ZSH_USER_COLOR%}%n%{$reset_color%}@%{$ZSH_HOST_COLOR%}%m%{$reset_color%} »'
}

setprompt

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
add-zsh-hook preexec theme_preexec
