alias up='cd ..'

alias l='ls -lh'
alias ll='ls -lah'
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


GIT_EDITOR=/usr/bin/emacs
export GIT_EDITOR

function cd()
{
    if [ -z "$1" ]
    then
	builtin cd ~;
    else
	builtin cd "$@";
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

#################################################################
### NOTES from virtualenvwrapper ################################
#  1. Create a directory to hold the virtual environments.
#     (mkdir $HOME/.virtualenvs).
#  2. Add a line like "export WORKON_HOME=$HOME/.virtualenvs"
#     to your .bashrc.
#  3. Add a line like "source /path/to/this/file/virtualenvwrapper.sh"
#     to your .bashrc.
#  4. Run: source ~/.bashrc
#  5. Run: workon
#  6. A list of environments, empty, is printed.
#  7. Run: mkvirtualenv temp
#  8. Run: workon
#  9. This time, the "temp" environment is included.
# 10. Run: workon temp
# 11. The virtual environment is activated.

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
################################################################


# Django ba
# . /Users/me/src/trunk/extras/django_bash_completion 
