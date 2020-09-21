function username
    printf "%s%s" (set_color -o blue) $USER
end


function hostname
    printf "%sat%s %s" (set_color white) (set_color red) (prompt_hostname)
end

function path
    printf "%sin%s %s" (set_color white) (set_color yellow) (pwd | string replace "$HOME" '~')
end

function venv
    if set -q VIRTUAL_ENV
        printf "%svia%s %s" (set_color white) (set_color magenta) (basename "$VIRTUAL_ENV")
    else
        printf ""
    end
end

function _branch
    command git branch --show-current 2> /dev/null
end

function branch
    if test (_branch)
        printf "%son%s %s" (set_color white) (set_color green) (_branch)
    else
        echo -n ""
    end
end

function prompt
    printf "%sλ %s" (set_color -o white) (set_color normal)
end

function fish_prompt
    echo (username) (hostname) (path) (venv) (branch)
    echo (prompt)
end
