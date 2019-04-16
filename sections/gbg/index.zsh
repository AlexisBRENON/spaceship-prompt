#
# God bless git
# Index informations
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GBG_INDEX_ADDED_SYMBOL="${SPACESHIP_GBG_INDEX_UNTRACKED_SYMBOL:-"${fa_plus:-A} "}"
SPACESHIP_GBG_INDEX_MODIFIED_SYMBOL="${SPACESHIP_GBG_INDEX_MODIFIED_SYMBOL:-"${fa_pencil:-M} "}"
SPACESHIP_GBG_INDEX_MOVED_SYMBOL="${SPACESHIP_GBG_INDEX_MOVED_SYMBOL:-"${fa_mail_reply:-M} "}"
SPACESHIP_GBG_INDEX_DELETED_SYMBOL="${SPACESHIP_GBG_INDEX_DELETED_SYMBOL:-"${fa_minus:-D} "}"
SPACESHIP_GBG_INDEX_BG_COLOR="${SPACESHIP_GBG_INDEX_BG_COLOR:-yellow}"
SPACESHIP_GBG_INDEX_FG_COLOR="${SPACESHIP_GBG_INDEX_FG_COLOR:-black}"

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

spaceship_gbg_index_init_symbols() {
    l_spaceship_gbg_tmp=""
    for l_symbol in \
        "has_index_adds:${SPACESHIP_GBG_INDEX_ADDED_SYMBOL}" \
        "has_index_mods:${SPACESHIP_GBG_INDEX_MODIFIED_SYMBOL}" \
        "has_index_moves:${SPACESHIP_GBG_INDEX_MOVED_SYMBOL}" \
        "has_index_dels:${SPACESHIP_GBG_INDEX_DELETED_SYMBOL}"; do
        l_spaceship_gbg_tmp="$(\
            printf '%s%s\036' \
            "${l_spaceship_gbg_tmp}" \
            "${l_symbol}")"
    done
    echo "${l_spaceship_gbg_tmp}"
    unset l_spaceship_gbg_tmp l_symbol
}
SPACESHIP_GBG_INDEX_SYMBOLS="$(spaceship_gbg_index_init_symbols)\\n"

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

spaceship_gbg_index() {
  [[ -n "${SPACESHIP_GBG_LAST_BG_COLOR}" ]] && lf_spaceship_gbg_close_segment "${SPACESHIP_GBG_INDEX_BG_COLOR}"
  [[ -n "${SPACESHIP_GBG_INDEX_FG_COLOR}" ]] && fg_color="%F{${SPACESHIP_GBG_INDEX_FG_COLOR}}" || fg_color="%f"
  [[ -n "${SPACESHIP_GBG_INDEX_BG_COLOR}" ]] && bg_color="%K{${SPACESHIP_GBG_INDEX_BG_COLOR}}" || bg_color="%k"

  l_section_out="%{${bg_color}${fg_color}%}" # Set colors

  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_index_has_modifications:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_INDEX_SYMBOLS}" \
          has_index_mods)"\
    )"
  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_index_has_moves:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_INDEX_SYMBOLS}" \
          has_index_moves)"\
    )"
  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_index_has_additions:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_INDEX_SYMBOLS}" \
          has_index_adds)"\
    )"
  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_index_has_deletions:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_INDEX_SYMBOLS}" \
          has_index_dels)"\
    )"

  l_section_out="${l_section_out}%{%f%k%}"

  printf '%s' "${l_section_out}"
  unset l_section_out
  SPACESHIP_GBG_LAST_BG_COLOR="${SPACESHIP_GBG_INDEX_BG_COLOR}"
}

