debug() { true }

spaceship_gbg_init_git_symbols() {
  if [ -e "$HOME/.local/share/icons-in-terminal/icons_bash.sh" ]; then
    debug "Loading icons in terminal"
    #shellcheck disable=1090
    . "$HOME/.local/share/icons-in-terminal/icons_bash.sh"
  else
    warning "Sterope prompt heavily relies on icons-in-terminal"
    warning "Please see https://github.com/sebastiencs/icons-in-terminal/"
  fi
  l_sterope_tmp=""
  for l_sterope_symbol in \
    "is_a_git_repo:${oct_octoface:-git}    " \
    "separator:${powerline_left_hard_divider:-▓▒░} " \
    "has_stashes:${fa_asterisk:-stash} " \
    "has_untracked:${fa_eye_slash:-untracked} " \
    "has_conflicts:\\u1F4A5 " \
    "has_pending_action:\\u1F527 " \
    "has_workspace_mods:${fa_pencil:-M} " \
    "has_workspace_dels:${fa_minus:-D} " \
    "has_index_mods:${fa_pencil:-M} " \
    "has_index_moves:${fa_mail_reply:-V} " \
    "has_index_adds:${fa_plus:-A} " \
    "has_index_dels:${fa_minus:-D} " \
    "ready_to_commit:${oct_git_commit:-\\u1F3C1} " \
    "detached:${fa_chain_broken:-detached} " \
    "not_tracked:${md_cloud_off:-not tracked} " \
    "has_diverged:${oct_repo_forked:-Y} " \
    "can_ff:${md_fast_forward:-">>"} " \
    "should_push:${oct_cloud_upload:-"->"} " \
    "tag:${fa_tag:-tag} "; do
  l_sterope_tmp="$(\
    printf '%s%s\036' \
    "${l_sterope_tmp}" \
    "${l_sterope_symbol}")"
done
printf '%s' "${l_sterope_tmp}"
unset l_sterope_tmp l_sterope_symbol
}

lf_spaceship_gbg_enrich_append() {
  l_sterope_flag=$1
  l_sterope_text=$2
  if [ "${l_sterope_flag}" != "true" ]; then
    l_sterope_text="$(\
      echo "${l_sterope_text}" | \
      sed 's/./ /g'\
      )"
  fi

  printf '%s' "${l_sterope_text}"
}

lf_spaceship_gbg_get_symbol() {
  l_gbg_symbols="$1"
  l_gbg_field="$2"
  printf '%s' "${l_gbg_symbols}" | \
    tr '[[:cntrl:]]' $'\n' | \
    grep "^${l_gbg_field}:" | \
    sed -e 's/^'"${l_gbg_field}"':\(.*\)/\1/'
  unset l_gbg_symbols l_gbg_field
}

lf_spaceship_gbg_close_segment() {
  [[ -n "${SPACESHIP_GBG_LAST_BG_COLOR}" ]] && fg_color="%F{${SPACESHIP_GBG_LAST_BG_COLOR}}" || fg_color="%f"
  [[ -n "$1" ]] && bg_color="%K{$1}" || bg_color="%k"

  printf '%s%s%s' \
    "%{${bg_color}${fg_color}%}" \
    "${SPACESHIP_GBG_SEPARATOR_SYMBOL}" \
    "%{%b%f%}"
}


if [ -e "$HOME/.local/share/icons-in-terminal/icons_bash.sh" ]; then
  debug "Loading icons in terminal"
  #shellcheck disable=1090
  . "$HOME/.local/share/icons-in-terminal/icons_bash.sh"
else
  warning "GBG prompt heavily relies on icons-in-terminal"
  warning "Please see https://github.com/sebastiencs/icons-in-terminal/"
fi

