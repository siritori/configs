# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/eric/.zshrc'

# Language
export LANG=ja_JP.UTF-8

# Path
export PATH=$PATH:/opt/local/bin:/opt/local/sbin

# Prompt
setopt prompt_subst
PROMPT="%T[${USER}@${HOST}]%%"
RPROMPT="[%~]"
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
autoload predict-on
predict-on
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
bindkey '^u' cdup

# Aliases
source '.aliases'

if [ -z $STY ]; then
   screen
fi

