username() {
   echo "%B%{$FG[006]%}%n%{$reset_color%}"
}

hostname() {
   echo "%B%{$FG[001]%}%m%{$reset_color%}"
}

function virtualenv {
    [ $VIRTUAL_ENV ] && echo "%B with %{$FG[004]%}"`basename $VIRTUAL_ENV`"%{$reset_color%}"
}

directory() {
   echo "%B%{$FG[003]%}%~%{$reset_color%}"
}

ZSH_THEME_GIT_PROMPT_PREFIX=" %Bon %{$FG[002]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""

PROMPT="$(username) %Bat $(hostname)$(virtualenv) %Bin $(directory)$(git_prompt_info)
%Bλ%b "
