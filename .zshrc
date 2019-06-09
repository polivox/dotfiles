[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred utilities:
export EDITOR=`which vim`
export VISUAL="$EDITOR"

# Local aliases stored separately for easy reloading:
. ~/.aliases

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-keymap-select

# If running interactively:
if [ "$PS1" ]; then

	# Colour stuff:
	eval `dircolors -b`
#	alias ls='ls --color=auto --classify --ignore=",,*"'
	alias ls='gls --color=auto --group-directories-first -l'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Changes terminal windows title to current dir
function chpwd {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
      ;;
  esac
}

## Use this when your repository configured
## Needed for the prompt
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats " (%b)%u%c"
zstyle ':vcs_info:git*' unstagedstr '*'
zstyle ':vcs_info:git*' stagedstr '+'
zstyle ':vcs_info:*' check-for-changes true

function precmd {
    psvar=()

    vcs_info
    if [ -n $vcs_info_msg_0_ ]
    then
        psvar[1]="$vcs_info_msg_0_ "
    else
        psvar[1]=' '
    fi
}



# Prompt Madness
# Allows prompt to update variables from the vcs_info precmd
export PROMPT="%B%F{green}%n@%m%f:%F{blue}%~%f%b%F{yellow}%1v%f%B%#%b "

# whois options:
#   Skip license crap.
#export WHOIS_HIDE=1

# Keybindings:
#   Emacs keybinding mode for bash-like behaviour.
bindkey -A emacs main
#   Keys
bindkey '[1;5D' emacs-backward-word  # Ctrl+LeftArrow
bindkey '[1;5C' emacs-forward-word   # Ctrl+RightArrow
bindkey "^[[1~" vi-beginning-of-line   # Home
bindkey "^[[4~" vi-end-of-line         # End
bindkey '^[[3~' delete-char            # Del
bindkey '^[[5~' vi-backward-blank-word # Page Up
bindkey '^[[6~' vi-forward-blank-word  # Page Down
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
# Options:
#   Don't HUP me bro
setopt nohup
#   Automatically update pushd/popd list...
setopt autopushd
#   ... and don't duplicate them.
setopt pushdignoredups
#   Show types in completion.
setopt listtypes
#   Also make equals safe to use.  Never even knew about that.
setopt noequals
#   Tell me if a command fails.
setopt printexitvalue
#   Correct when I wrong a command
setopt correct
#   Message when I wrong a command
autoload -U colors && colors
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "
#   Notify me if something takes awhile.
REPORTTIME=1

# History options:
#   Lines to keep, lines to save, where to save...
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
#   ... but append, don't overwrite, and do it incrementally.
setopt incappendhistory
#   Don't append duplicates.
setopt histignoredups
#   Ignore lines that begin with a space
setopt histignorespace

# Remove some chars from 'words' (e.g. alt-backspace) that I like.
# Essentially, add them as word delimiters.
# Currently:	.  /
WORDCHARS=${WORDCHARS:s,/,,}
WORDCHARS=${WORDCHARS:s,.,,}


# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/Rafael/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export PATH="/usr/local/opt/node@8/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
