# ~/.bashrc: executed by bash(1) for non-login shells.

# If running interactively, then:
if [ -n "$PS1" ]; then
    if [ "$(uname)" = "Darwin" ]; then
        PATH=~/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:$PATH:~/local/bin
    else
        PATH=~/bin:$PATH:~/local/bin
    fi

    HISTSIZE=1000000
    HISTFILESIZE=1000000
    HISTCONTROL=ignoredups
    # include timestamps in history output
    HISTTIMEFORMAT=': %Y-%m-%d %H:%M:%S; '

    # append to history file (don't overwrite)
    shopt -s histappend
    # adapt to window resize events
    shopt -s checkwinsize
    # correct misspellings in cd commands
    shopt -s cdspell
    # disable xon/xoff flow control -- allows us to use C-s to search forward
    # in readline history
    stty -ixon

    if [ -r /etc/bash_completion ]; then
        comp_file=/etc/bash_completion
    elif [ -r /usr/local/etc/bash_completion ]; then
        comp_file=/usr/local/etc/bash_completion
    elif [ -r /usr/share/bash-completion/bash_completion ]; then
        comp_file=/usr/share/bash-completion/bash_completion
    fi
    if [ $comp_file ]; then
        if [[ $__bashrc_bench ]]; then
            TIMEFORMAT="completion $comp_file: %R"
            time source $comp_file
            unset TIMEFORMAT
        else
            source $comp_file
        fi
    fi

    export RSYNC_RSH=ssh
    export EDITOR=vim
    export LESS=-RX
    export PAGER=less
    if [ -e $HOME/.pystartup ]; then
        export PYTHONSTARTUP=$HOME/.pystartup
    fi

    # enable color support of ls
    which dircolors >/dev/null && eval `dircolors`

    # aliases
    alias grep='grep --color=auto'
    alias vi='vim'
    if [ "$(uname)" = "Darwin" ]; then
        alias ls='ls -G'
        alias readlink=greadlink
    else
        alias ls='ls --color=auto'
    fi
    alias la='ls -l'

    # sort by size, descending
    alias lss='ls -lSr'

    # sort by ctime, descending
    alias lcc='ls -lctr'

    # sort by mtime, descending
    alias ltt='ls -ltr'

    # fight back against existing aliases?
    alias du='\du -sh'
    alias dus='\du -h'

    alias d='du -sh'
    alias df='df -h'
    alias jobs='jobs -l'
    alias j='jobs'

    # after running jobs -l, `jx <pid>' will dump ps(1) output for that process:
    # $ j
    # [1]+  6428 Stopped                 vim ~/.bashrc
    #
    # $ jx 6428
    # UID        PID  PPID  C STIME TTY          TIME CMD
    # zackse    6428 13853  0 10:12 pts/30   00:00:00 vim /home/zackse/.bashrc
    alias jx='\jobs -x ps -fww --pid'

    # sudo ...
    alias shuth='sudo /sbin/shutdown -h now'
    alias shutr='sudo /sbin/shutdown -r now'
    alias sb='sudo bash'
    alias vis='sudo vim'
    alias svi=vis
    alias vic='sudo vim /etc/crontab'
    # like vis for emacs
    alias E="SUDO_EDITOR=\"emacsclient -c -a vim\" sudoedit"

    # git aliases
    alias ga='git add'
    alias gb='git branch -v'
    alias gc='git checkout'
    alias gcp='git cherry-pick'
    alias gd='git diff'
    alias gdc='git diff --cached'
    alias gf='git fetch -p'
    alias gg='git grep'
    alias gl='git log --decorate'
    alias gld='git log --decorate'
    alias glg='git log --graph --decorate --all'
    alias glp='git log -p'
    alias gls='git log --stat'
    alias gp='git pull'
    alias gpr='git pull --rebase'
    alias gr='git rebase'
    alias gro='git rebase origin/master'
    alias gs='git show'
    alias gsl='git svn log --show-commit'
    alias gsr='git svn rebase'
    alias gst='git status'
    alias gw='git whatchanged'
    alias gau='git add -u'
    alias gcm='git checkout master'
    alias gpu='git push'
    alias gpuu='git push -u origin HEAD'
    alias gsq='git squash'
    alias wip='git ci -m WIP'

    # like perl -wc
    alias pywc='python -m py_compile'

    # often keep holding down the shift key after | in a pipeline...
    alias Grep=grep

    # add timestamps to standard input
    if [ -n "$(command -v ts)" ]; then
        alias tss="ts '%Y-%m-%d %H:%M:%.S'"
    fi

    PS1='\u@\h:\w\$ '

    # alternate/additional configs for personal, work, etc.
    if [ -d $HOME/.bashrc.d/ ]; then
        for sh in $HOME/.bashrc.d/*; do
            [ -r ${sh} ] || continue
            if [[ $__bashrc_bench ]]; then
                TIMEFORMAT="$sh: %R"
                time source "$sh"
                unset TIMEFORMAT
            else
                source "$sh"
            fi
        done
    fi

    # alternate/additional bash/tab completion
    if [ -d $HOME/.bash_completion.d/ ]; then
        for sh in $HOME/.bash_completion.d/*; do
            [ -r ${sh} ] || continue
            if [[ $__bashrc_bench ]]; then
                TIMEFORMAT="completion $sh: %R"
                time source "$sh"
                unset TIMEFORMAT
            else
                source "$sh"
            fi
        done
    fi
fi
