# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.dotnet/tools"
export GPG_TTY=$(tty)
source $ZSH/oh-my-zsh.sh
source ~/.zplug/init.zsh

# Install plugins using zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "agkozak/zsh-z"
zplug "plugins/git",   from:oh-my-zsh
zplug 'bossjones/boss-git-zsh-plugin'
zplug 'birdhackor/zsh-exa-ls-plugin'

if ! zplug check --verbose; then
  zplug install
fi

zplug load
# End zplug

plugins=(git zsh-z zsh-exa-ls-plugin)


ZSH_THEME="robbyrussell"

export EDITOR='nvim'
alias vim="nvim"
alias v="nvim"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

eval "$(fnm env --use-on-cd)"
eval "$(rbenv init - zsh)"

# Set typewritten ZSH as a prompt
autoload -U promptinit; promptinit
prompt typewritten

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '/Users/ejcoyle/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

