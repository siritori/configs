zstyle :compinstall filename '~/.zshrc'

# Auto load
autoload -U compinit; compinit
autoload -U colors; colors

# Auto correct
setopt correct

# Enable to print filename in Japanese
setopt print_eight_bit

# Bind key
bindkey -e # emacs like

# Environment
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export EDITOR=vim
export PAGER=less
export LESSCHARSET=utf-8
export LSCOLORS=ExFxCxDxBxegedaxagacad
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# Prompt
setopt prompt_subst
SPROMPT="%R -> %r? [n,y,a,e]:"
PROMPT="%F{white}%T[${USER}@${HOST%-*}]%%%f "
if type "git" > /dev/null && [ -f ~/.zsh/git.zsh ]; then
  # show git branch at rprompt if ~/.zsh/git.zsh exists
  source ~/.zsh/git.zsh
  RPROMPT='%F{white}[`rprompt-git-current-branch`%~]%f'
else
  RPROMPT='%F{white}[%~]%f'
fi

# History
setopt share_history
setopt hist_save_no_dups
setopt hist_ignore_all_dups
export HISTSIZE=1000
export SAVEHIST=10000
export HISTFILE=~/.histfile

# Change directory
function cd() {
  builtin cd $@ && ls -G
}
setopt auto_cd
setopt auto_pushd
setopt list_packed

# Original command_not_found_handler (records typo)
function command_not_found_handler() {
   echo "$1 : command not found!"
   echo $* >> ~/.zsh/statistics/typo.log
   return
}

# Aliases
if [ -f ~/.zsh/aliases.zsh ]; then
  source ~/.zsh/aliases.zsh
fi

# Syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Incremental completion on zsh
# http://mimosa-pudica.net/zsh-incremental.html
if [ -f ~/.zsh/incr.zsh ]; then
  source ~/.zsh/incr.zsh
fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
