# https://unix.stackexchange.com/a/9607
candy_remote=" "
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	candy_remote=" 🌩  "
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) candy_remote=" 🌩  ";;
  esac
fi

PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg[blue]%}->${candy_remote}%{$fg_bold[blue]%} %#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_SCHROOT_PROMPT_PREFIX="%{$fg_bold[blue]%}["
ZSH_THEME_SCHROOT_PROMPT_SUFFIX="]%{$reset_color%}"
