# basic
alias cls='clear'
alias ls="ls -Fhl --color=auto"
alias l="exa -Fgl --icons"
alias la="exa -aFgl --icons"
alias cat="bat"
alias mkdir="mkdir -p"
alias rm="rm -I"

# Navigation
alias ..="cd .."
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../"
alias .4="cd ../../.."
alias .5="cd ../../../.."
alias ~="cd ~"

# Git
alias g="git"
alias gs="git status"
alias gl="git log --graph"
alias gd="git diff"
alias gw="git worktree"
alias ga="git add"
alias gA="git add ."
alias gc="git commit"
alias gca="git commit -a"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gcl="git clone"
alias gpl="git pull"
alias gps="git push"
alias gb="git branch"
alias gbn="git branch -b"
alias gbd="git branch -d"
alias gbD="git branch -D"

alias commit='git commit -m'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# dev
alias vim='nvim'
alias zl='zellij'
alias lg="lazygit"

# disk info
alias df='df -h'     # human-readable sizes

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# system updation
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)

# system on & off
alias sd="shutdown now"
alias off='shutdown -h now'
alias sus='systemctl suspend'

alias bup="brightnessctl set +10%"
alias bdown="brightnessctl set 10%-"

# colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# timer app
alias c30='countdown 30m'
alias c5='countdown 5m'




