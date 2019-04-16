#
# God bless git
# Working directory informations
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GBG_LOCAL_UNTRACKED_SYMBOL="${SPACESHIP_GBG_LOCAL_UNTRACKED_SYMBOL:-"${fa_eye_slash:-untracked} "}"
SPACESHIP_GBG_LOCAL_MODIFIED_SYMBOL="${SPACESHIP_GBG_LOCAL_MODIFIED_SYMBOL:-"${fa_pencil:-M} "}"
SPACESHIP_GBG_LOCAL_DELETED_SYMBOL="${SPACESHIP_GBG_LOCAL_DELETED_SYMBOL:-"${fa_minus:-D} "}"
SPACESHIP_GBG_LOCAL_BG_COLOR="${SPACESHIP_GBG_LOCAL_BG_COLOR:-white}"
SPACESHIP_GBG_LOCAL_FG_COLOR="${SPACESHIP_GBG_LOCAL_FG_COLOR:-red}"

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

spaceship_gbg_local_init_symbols() {
    l_spaceship_gbg_tmp=""
    for l_symbol in \
        "has_untracked:${SPACESHIP_GBG_LOCAL_UNTRACKED_SYMBOL}" \
        "has_workspace_mods:${SPACESHIP_GBG_LOCAL_MODIFIED_SYMBOL}" \
        "has_workspace_dels:${SPACESHIP_GBG_LOCAL_DELETED_SYMBOL}"; do
        l_spaceship_gbg_tmp="$(\
            printf '%s%s\036' \
            "${l_spaceship_gbg_tmp}" \
            "${l_symbol}")"
    done
    echo "${l_spaceship_gbg_tmp}"
    unset l_spaceship_gbg_tmp l_symbol
}
SPACESHIP_GBG_LOCAL_SYMBOLS="$(spaceship_gbg_local_init_symbols)\\n"

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

spaceship_gbg_local() {
  [[ -n "${SPACESHIP_GBG_LAST_BG_COLOR}" ]] && lf_spaceship_gbg_close_segment "${SPACESHIP_GBG_LOCAL_BG_COLOR}"
  [[ -n "${SPACESHIP_GBG_LOCAL_FG_COLOR}" ]] && fg_color="%F{${SPACESHIP_GBG_LOCAL_FG_COLOR}}" || fg_color="%f"
  [[ -n "${SPACESHIP_GBG_LOCAL_BG_COLOR}" ]] && bg_color="%K{${SPACESHIP_GBG_LOCAL_BG_COLOR}}" || bg_color="%k"

  l_section_out="%{${bg_color}${fg_color}%}" # Set colors

  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_workspace_has_untracked:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_LOCAL_SYMBOLS}" \
          has_untracked)"\
    )"
  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_workspace_has_modifications:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_LOCAL_SYMBOLS}" \
          has_workspace_mods)"\
    )"
  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
    "${gbg_workspace_has_deletions:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_LOCAL_SYMBOLS}" \
          has_workspace_dels)"\
    )"

  l_section_out="${l_section_out}%{%f%k%}"

  printf '%s' "${l_section_out}"
  unset l_section_out
  SPACESHIP_GBG_LAST_BG_COLOR="${SPACESHIP_GBG_LOCAL_BG_COLOR}"
}

