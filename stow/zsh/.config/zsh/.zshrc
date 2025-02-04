zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
#
autoload -Uz compinit promptinit
compinit
promptinit

# History
HISTFILE=$HOME/.config/zsh/.zhistory
HISTSIZE=99999999
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Command auto-correction
setopt correct


bindkey -e

# Enable a cache for completions
zstyle ':completion::complete:*' use-cache 1

# text editor script
alias edit='sudoedit'

# Add space after 'sudo'; 'sudo' as substitute for 'doas'
alias sudo='sudo '

# better 'ls' command
alias ls='eza -a -l --group-directories-first --icons=auto'

# Always prompt for confirmation when copying files
alias cp='cp -i'

# Always prompt for confirmation when moving files
alias mv='mv -i'

# Aliases for clipboard copy and paste using 'xclip'
alias wlc='wl-copy'
alias wlp='wl-paste'

# Enable color highlighting for grep
alias grep='grep --color=auto'

# Automatically create parent directories if they don't exist
alias mkdir='mkdir -p'

alias files='nautilus .'

unz='patool extract'

startx='Hyprland'
startw='Hyprland'

export VISUAL=mg
export EDITOR=mg
export SUDO_EDITOR=mg

if [ -d $HOME/.local/bin ]; then
    PATH=$PATH:$HOME/.local/bin
else
    mkdir $HOME/.local/bin
    PATH=$PATH:$HOME/.local/bin
fi

# Non-GNU
if command -v trash > /dev/null; then
    alias rm='trash -v'
else
    echo "Install trash-cli package for extra features."
fi

### Create function that grabs a list of installed packages and instead of printing the same line with different package names, lists the packages that need to be installed.
if command -v fastfetch > /dev/null; then
    fastfetch
else
    echo "Install fastfetch package for extra features."
fi

if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
else
    echo
    precmd() {
        echo
    }
    PROMPT='%~'$'\n''> '
    echo "Install starship package for extra features."
fi

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    echo "Install zsh-autosuggestions package for extra features."
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
else
    echo "Install zsh-syntax-highlighting package for extra features."
fi







ftext() {
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}
