# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

export MANPAGER='nvim +Man!'
export MANWIDTH=999

export PATH="$HOME/.local/bin":$PATH

export PATH=$HOME/.local/share/go/bin:$PATH
export GOPATH=$HOME/.local/share/go


eval "$(zoxide init zsh)"



