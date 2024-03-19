# basic
alias cls='clear'
alias ls="ls -Fhl --color=auto"
alias la="exa -aFgl --icons"
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
alias vi='nvim'
alias pn="pnpm"
alias t='tmux'
alias z='zellij'


# disk info
alias df='df -h'     # human-readable sizes

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# system updation
alias pacsyu='sudo pacman -Syu'        # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'      # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'    # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'    # update standard pkgs and AUR pkgs (yay)

# remove unwanted softwares
alias autoremove='yay -Yc'             # remove build packages
alias removecache='sudo paccache -rk3' # remove cache 

# application
alias btop='btop --utf-force'
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"






