#!/usr/bin/env zsh

function _p4_clean_precmd_functions() {
  for (( i=1; i <= ${#precmd_functions[@]}; i++ )); do
    if [[ "${precmd_functions[i]}" == "_set_p4_client" ]]; then
        # delete this command
        precmd_functions[$i]=()
        break
    fi
  done
}

_p4_have_cleaned=0

function _set_p4_client() {
  # clear out the precmd hook
  if [[ ${_p4_have_cleaned} -eq 0 ]]; then
    _p4_clean_precmd_functions
    _p4_have_cleaned=1
  fi
  # local p=$(pwd) wont work
  # see http://www.zsh.org/mla/users/2004/msg01308.html
  local p;
  p=$(pwd)
  # search for the file
  while [[ "$p" != "" && ! -e "$p/.p4client" ]]; do
    # it wasn't found so set p to p's parent directory
    p=${p%/*}
  done
  local client_file=$p/.p4client
  # set the client if we found a .p4client file
  if [[ -e "$client_file" ]]; then
    export P4CLIENT=$(<$client_file)
  else
    unset P4CLIENT
  fi
}

# add the function to the hooks that get called when the directory changes
chpwd_functions=(${chpwd_functions[@]} "_set_p4_client")
# add this hook because chpwd isnt called on a new shell
precmd_functions=(${precmd_functions[@]} "_set_p4_client")

