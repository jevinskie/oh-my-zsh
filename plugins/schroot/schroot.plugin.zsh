function schroot_prompt_info() {
  if [[ ! -f /etc/debian_chroot ]]; then
    return
  fi
  name=$(tr -d '\n' < /etc/debian_chroot)
  info="schroot: $name user: $SCHROOT_USER"
  echo "$ZSH_THEME_SCHROOT_PROMPT_PREFIX$info$ZSH_THEME_SCHROOT_PROMPT_SUFFIX"
}

