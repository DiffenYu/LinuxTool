# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias sb="source ~/.bashrc"
alias vb="vim ~/.bashrc"

scope()
{
    echo $PWD
    /usr/bin/find $PWD -name "*.h" -o -name "*.c" -o -name "*.cpp" > cscope.files
    /usr/bin/cscope -bkq -i cscope.files
    /usr/bin/ctags -R
}
export CSCOPE_EDITOR=vim

function find_git_branch {
local dir=. head
until [ "$dir" -ef / ]; do
    if [ -f "$dir/.git/HEAD" ]; then
        head=$(< "$dir/.git/HEAD")
        if [[ $head == ref:\ refs/heads/* ]]; then
            git_branch=" ${head#*/*/}"
        elif [[ $head != '' ]]; then
            git_branch=' (detached)'
        else
            git_branch=' (unknown)'
        fi
        return
    fi
    dir="../$dir"
done
git_branch=''
}

export PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
green=$'\e[1;32m'
magenta=$'\e[1;35m'
normal_colours=$'\e[m'

export PS1="\[$green\]\u@\h:\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "

gf()
{
    /bin/grep $1 . -rni --color=auto
}

fd()
{
    /usr/bin/find . -name $1
}
