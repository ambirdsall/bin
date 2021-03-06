# {{{ Shell Variables (important directories)
export asdf=~/asdf
export blag=~/ambirdsall.github.io
export desk=~/Desktop
export dot=~/.dotfiles
# }}}
# {{{ Current projects
cdc() {
  if [[ $# -gt 0 ]]; then
    cdd ~/code/${@}
  else
    cdd ~/code
  fi
}
alias cdl='pushd ~/job/freelance/lawfetcher'
alias cdr='cd ~/job/rio'
alias ttr='tt r'
# }}}
# {{{ Edit/source development config files
cdot () {
  if [[ $# -gt 0 ]]; then
    pushd ~/.dotfiles/${@} && ls
  else
    pushd ~/.dotfiles && ls
  fi
}
alias prc="vim ~/.dotfiles/pryrc"
alias ea="vim ~/.dotfiles/aliases.zsh"
alias sdf="source ~/.dotfiles/aliases.zsh"
alias zrc="vim ~/.dotfiles/zshrc"
alias rc="source ~/.dotfiles/zshrc"
# }}}
# {{{ Background jobs & processes
alias j=jobs
# Typing the percent sign gets annoying fast when you run `kill` all the time with `%n`-style arguments on suspended `jobs`
k () {
  kill %"$1"
}
eval "$(ruby -e '9.times do |i| puts %Q{alias k#{i+1}=k\\ #{i+1}} end')"
alias cpu="top -o cpu"
# }}}
# {{{ Man Pages
viman_or_lynx() {
  case "$1" in
    tig) lynx http://jonas.nitro.dk/tig/manual.html;;
    *) viman $1;;
  esac
}

alias man=viman_or_lynx
# }}}
# {{{ Tmux
alias t=tmux
alias tt="tmux attach -t"
alias tk="tmux kill-session -t"
alias tn="tmux new -s"
# When the tmux session shrinks some and fills the margin with periods, it
# thinks there's another instance of the session in a smaller terminal. F that.
alias tda="tmux detach -a"
alias tls="tmux list-sessions"

# When clearing screen:
#   if in a tmux session, $TMUX is defined, so nothing else happens
#   else, list sessions atop cleared screen
alias clear='clear; [[ -z "$TMUX" ]] && tls'
# }}}
# {{{ `=`
= () {
  # iff there are 0 arguments given, assume input from stdin (i.e. a pipe)
  if [[ $# == 0 ]]; then
    /usr/local/share/vim/vim80/macros/less.sh "$*" -
  else
    /usr/local/share/vim/vim80/macros/less.sh "$*"
  fi
}
# }}}
# {{{ `cd`
alias 'cd-'="cd -"
alias ..="cdd .."
alias ...="cdd ../.."
alias ....="cdd ../../.."
alias .....="cdd ../../../.."
alias ......="cdd ../../../../.."
alias .......="cdd ../../../../../.."
alias ........="cdd ../../../../../../.."
alias .........="cdd ../../../../../../../.."

mcd () {
  mkdir $1
  cd $1
}

cdd () {
  cd $1
  ls -GF
}
# }}}
# {{{ `chmod`
alias cx='chmod +x'
# }}}
# {{{ `echo`
alias e=echo
# }}}
# {{{ `ls`
alias ls="ls -GFH"
alias la="ls -A"
# }}}
# {{{ `mkdir`
alias mkdir="mkdir -pv"
# }}}
# {{{ `rm`
alias fuck="rm -rf"
# }}}
# {{{ `tail`
tailfh () {
  tail -f $1 | ack -i 'error' --passthru
}
# }}}
# {{{ `zmv`
alias mmv='noglob zmv -W'
# }}}
# {{{ Vim and fam
vi () {
  if [[ $# -gt 0 ]]; then
    vim "$@"
  else
    vim .
  fi
}
alias ci=vi
alias vis="vi -S Session.vim"
mvim () {
  if [[ $# -gt 0 ]]; then
    mvim "$@"
  else
    mvim .
  fi
}
alias nvim="nvim -u ~/.vimrc"
bo () {
  vi $(bundle show "$1")
}
# }}}
# {{{ Git
# alias hub as git
eval "$(hub alias -s)"

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# -gt 0 ]]; then
    hub "$@"
  else
    git status
  fi
}

# Complete g like git, which is actually `hub`.
compdef g=hub

# run `git clone` and `cdd` into dir
gc () {
  repo=$1
  repo_dir_with_trailing_git=${repo##*/}
  repo_dir=${repo_dir_with_trailing_git%.git}
  git clone $repo
  cdd $repo_dir
}

alias co="git co"
alias co-="git co -"
com () {
  if [[ $(pwd) == ~/job/helloflock.github.io ]]; then
    git fetch && git co source
  else
    git fetch && git co master
  fi
}

d () {
  # git diff --word-diff "$@"
  git diff --color "$@" | diff-so-fancy | less
}
alias gdc="d --cached"
alias gdo="git diff \$(git rev-parse --abbrev-ref HEAD 2> /dev/null)..origin/\$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

alias s="git status -s"
alias ts="tig status"

alias p="git add -p"

c () {
  if [[ $# -gt 0 ]]; then
    git commit -m "$*"
  else
    git commit -v
  fi
}
alias a="git commit --amend"
alias arh="git commit --amend --reuse-message=HEAD"

alias f="git fetch"

alias gr="git rebase"
alias gri="g ri" # home-cooked git-ri, which simplifies syntax of `git rebase -i`

alias gp="git pull --ff-only"
alias gpr="git pull --rebase"

alias gb="git branch"
alias gbl="git branch -l"

l () {
  if [[ $# -eq 0 ]]; then
    git log --oneline --decorate --graph --all
  elif [[ $# -eq 1 ]] && [[ "$1" = <-> ]]; then
    git log --oneline --decorate -$1
  else
    echo "Usage: l [number of commits]" >&2
  fi
}
eval "$(ruby -e '9.times do |i| puts %Q{alias l#{i+1}=l\\ -#{i+1}} end')"
alias lg="git log --oneline --decorate --graph --all"
alias rl="git reflog"

# unique () {
#   perl -ne '$H{$_}++ or print'
# }
# lately () {
#   # lists unique git refs you have checked out, in order of how recently you checked them out
#   git reflog | ack --nocolor checkout: | awk '{print $6}' | unique | more
# }

alias gg="git grep"

alias b="git blame"

alias stash="git stash -u"

alias shipit='echo "       _~\n    _~ )_)_~\n    )_))_))_)\n    _!__!__!_\n    \______t/\n  ~~~~~~~~~~~~~" && git push origin $(git rev-parse --abbrev-ref HEAD 2> /dev/null)'
alias SHIPIT='echo "       _~\n    _~ )_)_~\n    )_))_))_)\n    _!__!__!_\n    \______t/\n  ~~~~~~~~~~~~~" && git push --force-with-lease origin $(git rev-parse --abbrev-ref HEAD 2> /dev/null)'

alias update='git pull --rebase && bundle install && bundle exec rake db:migrate'
# }}}
# {{{ tags
alias tag_js='find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed "/^$/d" | sort > tags'
# }}}
# {{{ Rails shortcuts
vm () { # open straight to the given model
  vim +":Emodel $1"
}
vc () { # open straight to the given controller
  vim +":Econtroller $1"
}
vv () { # open straight to the given view
  vim +":Eview $1"
}
alias be="bundle exec"
alias bes="bundle exec rails server"
alias lkj="bundle exec rails console"
alias kjh="bundle exec rails console --sandbox"
# }}}
# {{{ Self-expanding shell abbreviations
# cf. http://zshwiki.org/home/examples/zleiab
typeset -Ag abbreviations
abbreviations=(
"pa"    "| ack"
"pag"   "| agrep"
"pb"    "| bc"
"peg"   "| egrep"
"pgr"   "| groff -s -p -t -e -Tlatin1 -mandoc"
"ph"    "| head"
"pk"    "| keep"
"pm"    "| less" # yeah, this is misleading; but less > more and pl is taken
"pt"    "| tail -f"
"pv"    "| vim"
"pw"    "| wc"
"px"    "| xargs"
)

magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert
# }}}
# {{{ Shruggies
alias idk="echo -n '¯\_(ツ)_/¯' | pbcopy && echo 'Copied \"¯\_(ツ)_/¯\" to clipboard'"
# Backslashes and underscores must be escaped or GitHub will parse as markdown
alias ghidk="echo -n '¯\\\_(ツ)\_/¯' | pbcopy && echo 'Copied \"¯\\\_(ツ)\_/¯\" to clipboard'"
# }}}
# {{{ Entertainment
alias tetris='emacs -q --no-splash -f tetris'
alias hall="say -v cellos Doo da doo da dum dee dee doodly doo dum dum dum doo da doo da doo da doo da doo da doo da doo"
alias vlc=/Applications/VLC.app/Contents/MacOS/VLC
# }}}
# {{{ Sonic Pi
# boot up sonic pi server without GUI
alias spi='RBENV_VERSION=2.3.1 ruby /Applications/Sonic\ Pi.app/app/server/bin/sonic-pi-server.rb'
#}}}

# vim:foldmethod=marker:foldlevel=0
