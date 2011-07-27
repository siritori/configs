# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/eric/.zshrc'
autoload -U colors; colors

# Language
export LANG=ja_JP.UTF-8

# Environment
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export PAGER=less
export EDITOR=vim

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

# Bind key
bindkey -v

# Auto load
autoload -Uz compinit
compinit
#autoload predict-on
#predict-on
setopt correct

# Change directory
setopt auto_cd
setopt auto_pushd
setopt list_packed

# Function
function mcdir() {
   mkdir $@ && builtin cd $@
}
function cd() {
  builtin cd $@ && ls
}
function cdup() {
  echo
  cd ..
  zle reset-prompt
}
zle -N cdup
bindkey '^P' cdup

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

if [ -z $STY ]; then
   screen
fi

