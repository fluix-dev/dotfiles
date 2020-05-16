# vim:ft=sh

# Modified version of Bubble Theme by hohmannr
# Inspired by bubblewritten and agnoster

# SYMBOL CONSTANTS
blub_left=''
blub_right=''

prompt_symbol='╰═⇒'

user_symbol='%n'
user_machine_symbol='╶╴'
machine_symbol='%M'

filepath_symbol='%~'

git_branch_symbol=''
git_clean_symbol=''
git_modified_symbol='•'
git_added_symbol=''
git_deleted_symbol=''
git_renamed_symbol=''
git_untracked_symbol=''
git_copied_symbol=''
git_unmerged_symbol=''
git_stashed_symbol=''

# COLOR CONSTANTS
bubble_color='235'

prompt_symbol_color='001'
prompt_symbol_error_color='006'

user_color='001'
user_machine_symbol_color='007'
machine_color='006'

filepath_color='007'

git_clean_color='001'
git_unstaged_color='006'
git_staged_color='001' 
git_stashed_color='006'
git_unmerged_color='006'
git_symbols_color='000'

# HELPER FUNCTIONS
bubblify () {
    # This is a helper function to build custom bubbles.
    # 
    # ARGS      VALUES          DESC
    # ----      ------          ----
    # 1.        {0, 1, 2, 3}        0: build left side bubble: content█
    #                               1: build right side bubble: █content                
    #                               2: build middle part: █content█
    #                               3: build custom colored whole bubble: content
    #
    # 2.        string              content to be displayed in partial bubble
    #
    # 3.        {'red', '073' ...}  foreground color (text color) as zsh-color-string or zsh-color-code
    #
    # 4.        {'red', '073' ...}  background color (bubble segment color) as zsh-color-string or zsh-color-code

    if [[ $1 -eq 0 ]]; then
        echo -n "$(foreground $4)$blub_left$(foreground $3)$(background $4)$2%{$reset_color%}"
    elif [[ $1 -eq 1 ]]; then
        echo -n "$(foreground $3)$(background $4)$2%{$reset_color%}"
    elif [[ $1 -eq 2 ]]; then
        echo -n "$(foreground $3)$(background $4)$2%{$reset_color%}$(foreground $4)$blub_right%{$reset_color%}"
    elif [[ $1 -eq 3 ]]; then
        echo -n "$(foreground $4)$blub_left$(foreground $3)$(background $4)$2%{$reset_color%}$(foreground $4)$blub_right%{$reset_color%}"
    else
        echo -n 'bblfy_fail'
    fi
}

foreground () {
    # Helper function for 256 color support beyond basic color terms such as 'black', 'red' ...
    if [[ $1 =~ '[0-9]{3}' && $1 -le 255 && $1 -ge 0 ]]; then
        echo -n "%{$FG[$1]%}"
    else
        echo -n "%{$fg[$1]%}"
    fi
}

background () {
    # Helper function for 256 color support beyond basic color terms such as 'black', 'red' ...
    if [[ $1 =~ '[0-9]{3}' && $1 -le 255 && $1 -ge 0 ]]; then
        echo "%{$BG[$1]%}"
    else
        echo "%{$bg[$1]%}"
    fi
}

# PROMPT FUNCTIONS
git_bubble () {
    # This parses 'git status -s' to retrieve all necessary information...I am new to this zsh scripting...mercy!
    local git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

    if [[ -n $git_branch ]]; then
        # branch name with symbol, initialize symbols and git status output
        local git_info="$git_branch_symbol $git_branch"
        local git_symbols=""
        local git_status=$(git status -s 2> /dev/null | awk '{print substr($0,1,2)}') 

        # used for coloring (and some for icons)
        local git_unmerged=$(grep -m1 -E -- 'U|DD|AA' <<< $git_status)
        local git_branch_stashed=$(git stash list | grep $git_branch)
        local git_unstaged=$(echo -n $git_status | awk '{print substr($0,2,1)}')

        # used for icons
        local git_not_clean=$git_status
        local git_modified=$(grep -m1 'M' <<< $git_status)
        local git_added=$(grep -m1 'A' <<< $git_status)
        local git_deleted=$(grep -m1 'D' <<< $git_status)
        local git_untracked=$(grep -m1 '??' <<< $git_status)
        local git_renamed=$(grep -m1 'R' <<< $git_status)
        local git_copied=$(grep -m1 'C' <<< $git_status)

        # coloring
        if [[ -n $git_unmerged ]]; then
            local git_color=$git_unmerged_color   
            git_symbols="$git_symbols$git_unmerged_symbol"
        elif [[ -n $git_branch_stashed ]]; then
            local git_color=$git_stashed_color
            git_symbols="$git_symbols$git_stashed_symbol"
        elif [[ -n "${git_unstaged//[$' \t\r\n']}" && -n $git_not_clean ]]; then
            local git_color=$git_unstaged_color
        elif [[ -z "${git_unstaged//[$' \t\r\n']}" && -n $git_not_clean ]]; then
            local git_color=$git_staged_color
        else
            local git_color=$git_clean_color
            git_symbols="$git_symbols$git_clean_symbol"
        fi

        # icons
        if [[ -n $git_modified ]]; then
            git_symbols="$git_symbols$git_modified_symbol"
        fi
        if [[ -n $git_added ]]; then
            git_symbols="$git_symbols$git_added_symbol"
        fi
        if [[ -n $git_deleted ]]; then
            git_symbols="$git_symbols$git_deleted_symbol"
        fi
        if [[ -n $git_untracked ]]; then
            git_symbols="$git_symbols$git_untracked_symbol"
        fi
        if [[ -n $git_renamed ]]; then
            git_symbols="$git_symbols$git_renamed_symbol"
        fi
        if [[ -n $git_copied ]]; then
            git_symbols="$git_symbols$git_copied_symbol"
        fi

        echo -n "$(bubblify 0 "$git_info " $git_color $bubble_color)$(bubblify 2 " $git_symbols" $git_symbols_color $git_color) "
    fi
}

# DEFAULT PROMPT BUILDING BLOCKS
bubble_left="$(foreground $bubble_color)$blub_left%{$reset_color%}$(background $bubble_color)"
bubble_right="%{$reset_color%}$(foreground $bubble_color)$blub_right%{$reset_color%} "

end_of_prompt_bubble="$bubble_left%(?,$(foreground $prompt_symbol_color)$prompt_symbol,$(foreground $prompt_symbol_error_color)$prompt_symbol)$bubble_right"

end_of_prompt="$(foreground $prompt_symbol_color)$prompt_symbol%{$reset_color%} "

user_machine_bubble="$(foreground $user_color)╭$user_symbol$(foreground $user_machine_symbol_color)$user_machine_symbol$(foreground $machine_color)$machine_symbol "

filepath_bubble="$bubble_left$(foreground $filepath_color)$filepath_symbol$bubble_right"

error_code_bubble="%(?,,$bubble_left$(foreground $prompt_symbol_error_color)%?$bubble_right)"

venv_prompt_info() {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "$bubble_left$(foreground $filepath_color)${VIRTUAL_ENV:t}$bubble_right"
}

_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

PROMPT='$user_machine_bubble$(venv_prompt_info)$filepath_bubble$_newline$end_of_prompt%{$reset_color%}'
RPROMPT='%{$_lineup%}$error_code_bubble$(git_bubble)%{$_linedown%}%{$reset_color%}'

