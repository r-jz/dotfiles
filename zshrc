autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=2

eval `dircolors -b`
autoload -U colors
colors
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


PROMPT="%{$fg_bold[green]%}%n%{$fg_bold[cyan]%}@%{$fg_bold[green]%}%M%{$reset_color%}:%{$fg_bold[blue]%}%~
%{$fg_bold[yellow]%}%#%{$reset_color%} "

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'

setopt inc_append_history
setopt share_history
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt auto_pushd
setopt pushd_ignore_dups
# alias

# for vim
alias vim="nvim"
# for develop
alias cda="cd $HOME/github.com/ais-research"
alias cdo="cd $HOME/github.com/okamotonr"
alias cdg="cd $HOME/github.com"
# for ls
alias ls="ls -h --color=auto"
alias ll="ls -la --color=auto"
alias la="ls -a --color=auto"
alias l="ls -m --color=auto"
# for grep
alias grep="grep --color=auto"
# for nvimpager
alias npg="nvimpager"

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Path to users bin
export PATH=$PATH:$HOME/.bin:$HOME/.local/bin:$HOME/.npm-global/bin

# for nvim pager
#Nexport PAGER=nvimpager

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

### From User
zplugin ice wait'!0'; zplugin load zsh-users/zsh-completions
zplugin ice wait'!0'; zplugin load zsh-users/zsh-syntax-highlighting
zplugin ice wait'!0'; zplugin light chrissicool/zsh-256color
