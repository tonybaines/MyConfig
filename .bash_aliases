alias a='alias'

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -Al'                              # all but . and ..
# alias l='ls -CF'                              #
alias v='vagrant'
alias vup='vagrant up'
alias vsh='vagrant ssh'
alias ..='cd ..'
alias ::='cd ../..'
alias :::='cd ../../..'

alias gs='git status'
alias gpl='git spull'
alias gps='git spush'
alias ga='git add'
alias gi='git ignore'
alias gc='git commit -m '
alias gca='git commit -a -m '
alias gua='git-update-all'
alias gsa='git-status-all'
alias gri='git rebase --interactive '
alias gris='git rebase --interactive origin/trunk'
alias grc='git rebase --continue'
alias gcm='git co master'
alias gl='git lol'
alias gcl='git cl | grep -v UTBUILD'
alias glf='git lf'

alias t='todo-txt'
alias tl='todo-txt ls'
alias t+='todo-txt add'
alias t-='todo-txt rm'
alias td='todo-txt done'
alias te='vi ~/todo.txt'

function git-set-project-user {
  if [ -n "$1" ]; then
    case $1 in
      "personal")	email="tony.baines.1@gmail.com";;
      "work")		email="tony.baines@bt.com";;
    esac
    git config user.email "$email"
    git config user.name "Tony Baines"
  else
    echo "USAGE: git-set-project-user [personal|work]"
  fi

}
complete -W "work personal" git-set-project-user

function full() {
  cmd="mvn clean install -T4"
  if [ -n "$1" ]; then
    case $1 in
      "skiptest")	cmd+=" -Dmaven.test.skip=true";;
    esac
  fi
  echo "$cmd"
  eval "$cmd"  
}
complete -W "skiptest" full

function epoch2date() {
  date -d @$1 +"%Y.%m.%d-%H:%M:%S"
}


function migrate-to-my-config {
  if [ -n "$1" ]; then
    mv "$1" ~/.my-config/ && ln -s ~/.my-config/"$1" ./"$1"
  fi
}


function migrate-to-my-config-bin {
  if [ -n "$1" ]; then
    mv "$1" ~/.my-config/bin && ln -s ~/.my-config/bin/"$1" ./"$1"
  fi
}
