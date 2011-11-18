# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/eric/.zshrc'
autoload -U colors; colors

# Language
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# Environment
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:~/bin:~/.gem/ruby/1.8/bin
export PAGER=less
export EDITOR=vim
export LIBRARY_PATH=$LIBRARY_PATH:~/lib
export C_INCLUDE_PATH=$C_INCLUDE_PATH:~/include

# Prompt
setopt prompt_subst
PROMPT="%F{white}%T[${USER}@${HOST}]%%%f"
RPROMPT='%F{white}[`rprompt-git-current-branch`%~]%f'
SPROMPT="%R -> %r? [n,y,a,e]:"

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt share_history
source ~/utils/comp.zsh

# Bind key
bindkey -v

# Auto load
autoload -U compinit
compinit
setopt correct

# Change directory
setopt auto_cd
setopt auto_pushd
setopt list_packed

# Function
function on_shellinfo() {
   shellinfo="on"
   echo 'on' > ~/.shellinfo/status
}
function off_shellinfo() {
   shellinfo="off"
   echo 'off' > ~/.shellinfo/status
}

function mcdir() {
   mkdir $@ && builtin cd $@
}
function cd() {
  builtin cd $@ && ls
}
function cdup() {
   echo
   cd ..
   if [ $shellinfo = "on" ]; then
      afplay ~/.shellinfo/bin/dokan.wav&
   fi
   zle reset-prompt
}
zle -N cdup
bindkey '^P' cdup

function precmd() {
   cur=`jobs|grep suspend | wc -l | perl -ne'/(\d+)/;print $1;'`
   if [ $cur -gt $old ];then
   if [ $shellinfo = "on" ]; then
      afplay ~/.shellinfo/bin/pause.wav&
   fi
   fi
   old=$cur
}
function preexec() {
   shellinfo=`cat ~/.shellinfo/status`
   if [ $shellinfo = "on" ]; then
      echo $1 | perl ~/.shellinfo/preexec.pl
   fi
   if [ $1 = "fg" ]; then
      old=`expr $cur - 1`
   fi
}
function zshexit() {
   if [ -z $STY -a $shellinfo = "on" ]; then
      stweet "えりっくがコンソールを終了しました！ばいばい！at`date +%H:%M:%S`"&
      afplay ~/.shellinfo/bin/world_clear.wav
   fi
}
function command_not_found_handler() {
   echo "command not found (´；ω；｀)ﾌﾞﾜｯ"
   echo $* >> ~/.shellinfo/typo/cmd.log
   count=`~/.shellinfo/typo.pl`
   today_count=${count%,*}
   total_count=${count#*,}
   if [ $shellinfo = "on" ]; then
      afplay ~/bin/mdai.mp3&
      stweet "えりっくさんが本日${today_count}回目のtypoをしました。ぷぎゃー。\
      (トータル${total_count}回目)"
   fi
   sleep 1
   return
}

# Show branch name in right prompt
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
function rprompt-git-current-branch {
   local name st color gitdir action
   if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
      return
   fi
   name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
   if [[ -z $name ]]; then
      return
   fi
   gitdir=`git rev-parse --git-dir 2> /dev/null`
   action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
   st=`git status 2> /dev/null`
   if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
      color=%F{white}
   elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
      color=%F{blue}
   elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
      color=%B%F{red}
   else
      color=%F{red}
   fi
   echo "${color}(${name}${action})%f%b"
}

# Aliases
. ~/.aliases

old="0"
oldCOLUMNS=$COLUMNS
source ~/perl5/perlbrew/etc/bashrc
shellinfo=`cat ~/.shellinfo/status`

if [ -z $STY ]; then
   if [ $shellinfo = "on" ]; then
      afplay ~/.shellinfo/bin/grow.wav&
   fi
#   screen
fi
