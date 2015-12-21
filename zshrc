fpath=(/usr/local/share/zsh/site-functions ~/.zsh $fpath)
source ~/code/zsh_business/iterm_dirs.sh
md5 ~/Dropbox/Apps/MobileOrg/* > ~/Dropbox/Apps/MobileOrg/checksums.dat
maybe_brew_update
rm ~/Desktop/Screen\ Shot*

#=====================#
# VIMIFY THE TERMINAL #
#=====================#

bindkey -v
# export KEYTIMEOUT=3
bindkey -M viins 'jf' vi-cmd-mode
bindkey -M viins 'fj' vi-cmd-mode
source ~/code/zsh_business/opp.zsh/opp.zsh
source ~/code/zsh_business/opp.zsh/opp/*.zsh

function zle-line-init zle-keymap-select {
    NORMAL_MODE_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$NORMAL_MODE_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#=====================#
#       GIT LIT	      #
#=====================#

current_commit() {
    git rev-parse --short HEAD 2> /dev/null
}

# totally sweet prompt
GIT_PROMPT_EXECUTABLE="haskell"
source ~/code/zsh_business/zsh-git-prompt/zshrc.sh
export PS1='%F{cyan}%~%b%f$(git_super_status) %F{yellow}$(current_commit) %F{cyan}%#%f '

# $PATH config in .zshprofile

# alias hub as git
eval "$(hub alias -s)"

# irc settings
export IRCSERVER="irc.freenode.net"

#==============================#
# HERE THERE BE CUSTOM ALIASES #
#==============================#
alias wut="ping -c 5 -q 127.0.0.1 && echo '' && ping -c 100 -q www.google.com"
alias phone="ssh -t root@192.168.0.101 'echo \"photos live at /private/var/mobile/Media/DCIM/\"; exec zsh;'"
alias ftphone="sftp root@192.168.0.101"

# shell script to boot up Emacs.app with given arguments
alias emacs='~/code/clinteresting/emacs'
alias tetris='emacs -q --no-splash -f tetris'
alias hall="say -v cellos Doo da doo da dum dee dee doodly doo dum dum dum doo da doo da doo da doo da doo da doo da doo"
alias idk="echo -n '¯\_(ツ)_/¯' | pbcopy && echo 'Copied \"¯\_(ツ)_/¯\" to clipboard'"

alias swift=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift
alias swiftc=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc

alias subl="/Applications/Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl"

alias vi="vim"

alias prc="vim ~/.pryrc"

alias zrc="vim ~/.zshrc"
alias rc="source ~/.zshrc"

alias be="bundle exec"
alias bes="bundle exec rails server"
alias lkj="bundle exec rails console"
alias kjh="bundle exec rails console --sandbox"

alias g="git"
alias p="git add -p"
alias c="git commit"
alias a="git commit --amend"
alias s="git status -s"
alias d="git diff"
alias l="git log --oneline --decorate --graph --all"
alias co="git co"
alias stash="git stash -u"
alias shipit='echo "       _~\n    _~ )_)_~\n    )_))_))_)\n    _!__!__!_\n    \______t/\n  ~~~~~~~~~~~~~" && git push origin master'
alias SHIPIT='echo "       _~\n    _~ )_)_~\n    )_))_))_)\n    _!__!__!_\n    \______t/\n  ~~~~~~~~~~~~~" && git push -f origin master'

alias cpu="top -o cpu"

alias ls="ls -GF"
alias la="ls -A"
alias ll="ls -lrSGA"
alias cdl="cd !$"
alias ..="cdd .."
alias ...="cdd ../.."
alias ....="cdd ../../.."
alias .....="cdd ../../../.."
alias mkdir="mkdir -pv"
alias fuck="rm -rf"

mcd () {
	mkdir -p $1
	cd $1
}

cdd () {
	cd $1
	ls
}

gc () {
       repo=$1
       repo_dir_with_trailing_git=${repo##*/}
       repo_dir=${repo_dir_with_trailing_git%.git}
       git clone $repo
       cd $repo_dir
}

# syntax highlighting pager
# # use instead of less
= () {
    /usr/share/vim/vim73/macros/less.sh "$*"
}

eval "$(rbenv init - zsh --no-rehash)"
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/Users/ambirdsall/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
