alias up='cd ..'

alias l='ls -l'
alias ll='ls -la'
alias la='ls -a'

alias scheme='rlwrap scheme'
alias node='rlwrap node'
alias racket='/Applications/Racket\ v5.2.1/bin/racket'
alias ...='cd ../../'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpu='git update'
alias gl='git prettylog'
alias gd='git cdiff'
alias gcp='git cherry-pick'
alias gco='git checkout'


WORKON_HOME=~/.virtualenv
export WORKON_HOME
# source /usr/local/bin/virtualenvwrapper.sh

GIT_EDITOR=/usr/bin/emacs
export GIT_EDITOR

function cd()
{
    if [ -z "$1" ]
    then
	builtin cd ~;
    else
	builtin cd $1;
    fi
    ls -l;
}


PS1="\w $ "


# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:/usr/local/git/bin:${PATH}"

PATH="${PATH}:~/bin:/Developer/usr/bin:/usr/bin"
PATH="${PATH}:/usr/local/Cellar/erlang/R15B/bin"

export PATH

#export PYTHONPATH="${PYTHONPATH}




# Django ba
# . /Users/me/src/trunk/extras/django_bash_completion 
