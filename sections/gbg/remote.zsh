#
# God bless git
# Remote informations
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GBG_REMOTE_DETACHED_SYMBOL="${SPACESHIP_GBG_REMOTE_DETACHED_SYMBOL:-"${fa_chain_broken:-"!"} "}"
SPACESHIP_GBG_REMOTE_UNTRACKED_SYMBOL="${SPACESHIP_GBG_REMOTE_UNTRACKED_SYMBOL:-"${md_cloud_off:-"?"} "}"
SPACESHIP_GBG_REMOTE_DIVERGED_SYMBOL="${SPACESHIP_GBG_REMOTE_DIVERGED_SYMBOL:-"${oct_repo_forked:-Y} "}"
SPACESHIP_GBG_REMOTE_FF_SYMBOL="${SPACESHIP_GBG_REMOTE_FF_SYMBOL:-"${md_fast_forward:-">>"} "}"
SPACESHIP_GBG_REMOTE_PUSH_SYMBOL="${SPACESHIP_GBG_REMOTE_PUSH_SYMBOL:-"${oct_cloud_upload:-"->"} "}"
SPACESHIP_GBG_REMOTE_TRACKING_SYMBOL_MERGE="${SPACESHIP_GBG_REMOTE_TRACKING_SYMBOL_MERGE:-"${oct_git_merge:-"|\\"} "}"
SPACESHIP_GBG_REMOTE_BG_COLOR="${SPACESHIP_GBG_REMOTE_BG_COLOR:-"166"}"
SPACESHIP_GBG_REMOTE_FG_COLOR="${SPACESHIP_GBG_REMOTE_FG_COLOR:-white}"

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

spaceship_gbg_remote_init_symbols() {
    l_spaceship_gbg_tmp=""
    for l_symbol in \
      "detached:${SPACESHIP_GBG_REMOTE_DETACHED_SYMBOL}" \
      "not_tracked:${SPACESHIP_GBG_REMOTE_UNTRACKED_SYMBOL}" \
      "has_diverged:${SPACESHIP_GBG_REMOTE_DIVERGED_SYMBOL}" \
      "can_ff:${SPACESHIP_GBG_REMOTE_FF_SYMBOL}" \
      "should_push:${SPACESHIP_GBG_REMOTE_PUSH_SYMBOL}" \
      "merge_tracking:${SPACESHIP_GBG_REMOTE_TRACKING_SYMBOL_MERGE}"; do
        l_spaceship_gbg_tmp="$(\
          spaceship_gbg_print "${l_spaceship_gbg_tmp}${l_symbol}"$'\036')"
    done
    spaceship_gbg_print "${l_spaceship_gbg_tmp}"
    unset l_spaceship_gbg_tmp l_symbol
}
SPACESHIP_GBG_REMOTE_SYMBOLS="$(spaceship_gbg_remote_init_symbols)\\n"

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

spaceship_gbg_remote() {
  [[ -n "${SPACESHIP_GBG_LAST_BG_COLOR}" ]] && lf_spaceship_gbg_close_segment "${SPACESHIP_GBG_REMOTE_BG_COLOR}"
  [[ -n "${SPACESHIP_GBG_REMOTE_FG_COLOR}" ]] && fg_color="%F{${SPACESHIP_GBG_REMOTE_FG_COLOR}}" || fg_color="%f"
  [[ -n "${SPACESHIP_GBG_REMOTE_BG_COLOR}" ]] && bg_color="%K{${SPACESHIP_GBG_REMOTE_BG_COLOR}}" || bg_color="%k"

  l_section_out="%{${bg_color}${fg_color}%}" # Set colors

  if [ "${gbg_head_is_detached:-}" = "true" ]; then
    # Detached state
    l_section_out="${l_section_out}$(\
      lf_spaceship_gbg_get_symbol \
        "${SPACESHIP_GBG_REMOTE_SYMBOLS}" \
        detached)"
    l_section_out="${l_section_out} ${gbg_head_hash:-:0:7}"
  elif [ "${gbg_upstream_has_upstream:-}" = "false" ]; then
    # No upstream set
    l_section_out="${l_section_out}-- "
    l_section_out="${l_section_out}$(\
      lf_spaceship_gbg_get_symbol \
        "${SPACESHIP_GBG_REMOTE_SYMBOLS}" \
        not_tracked)"
    l_section_out="${l_section_out} --"
    l_section_out="${l_section_out} (${gbg_head_branch:-"???"}) "
  else
    # Standard branch
    if [ "${gbg_upstream_commits_behind_num:-0}" -gt 0 ]; then
      l_section_out="$(\
        spaceship_gbg_print "${l_section_out} -${gbg_upstream_commits_behind_num}"
      )"
    else
      l_section_out="${l_section_out} -- "
    fi

    if [ "${gbg_upstream_has_diverged:-}" = "true" ]; then
      l_sterope_upstream_diff="$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_REMOTE_SYMBOLS}" \
          has_diverged)"
    elif [ "${gbg_upstream_commits_behind_num:-0}" -gt 0 ]; then
      l_sterope_upstream_diff="$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_REMOTE_SYMBOLS}" \
          can_ff)"
    elif [ "${gbg_upstream_commits_ahead_num:-0}" -gt 0 ]; then
      l_sterope_upstream_diff="$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_REMOTE_SYMBOLS}" \
          should_push)"
    elif [ "${gbg_upstream_commits_ahead_num:-0}" -eq 0 ] && \
      [ "${gbg_upstream_commits_behind_num:-0}" -eq 0 ]; then
    l_sterope_upstream_diff=" "
  fi
  l_section_out="${l_section_out}${l_sterope_upstream_diff}"
  unset l_sterope_upstream_diff

  if [ "${gbg_upstream_commits_ahead_num:-0}" -gt 0 ]; then
    l_section_out="$(\
      spaceship_gbg_print "${l_section_out} +${gbg_upstream_commits_ahead_num} "
    )"
  else
    l_section_out="${l_section_out} ++ "
  fi

  l_section_out="$(\
    printf '%s (%s %s %s) ' \
      "${l_section_out}" \
      "${gbg_head_branch}" \
      "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_REMOTE_SYMBOLS}" \
          "${gbg_upstream_merge_type:-merge}_tracking")" \
      "$(\
        echo "${gbg_upstream_name:-""}" | \
          sed "s#$gbg_head_branch#...#")" \
    )"
fi





l_section_out="${l_section_out}%{%f%k%}"

spaceship_gbg_print "${l_section_out}"
unset l_section_out
SPACESHIP_GBG_LAST_BG_COLOR="${SPACESHIP_GBG_REMOTE_BG_COLOR}"
}

