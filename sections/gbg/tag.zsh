#
# God bless git
# Tag informations
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GBG_TAG_SYMBOL="${SPACESHIP_GBG_TAG_SYMBOL:-"${fa_tag:-tag} "}"
SPACESHIP_GBG_TAG_BG_COLOR="${SPACESHIP_GBG_TAG_BG_COLOR:-blue}"
SPACESHIP_GBG_TAG_FG_COLOR="${SPACESHIP_GBG_TAG_FG_COLOR:-white}"

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

spaceship_gbg_local_init_symbols() {
    l_spaceship_gbg_tmp=""
    for l_symbol in \
        "tag:${SPACESHIP_GBG_TAG_SYMBOL}"; do
        l_spaceship_gbg_tmp="$(\
            printf '%s%s\036' \
            "${l_spaceship_gbg_tmp}" \
            "${l_symbol}")"
    done
    echo "${l_spaceship_gbg_tmp}"
    unset l_spaceship_gbg_tmp l_symbol
}
SPACESHIP_GBG_TAG_SYMBOLS="$(spaceship_gbg_local_init_symbols)\\n"

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

spaceship_gbg_tag() {
  [[ "${gbg_head_is_on_tag:-false}" = "false" ]] && return

  [[ -n "${SPACESHIP_GBG_LAST_BG_COLOR}" ]] && lf_spaceship_gbg_close_segment "${SPACESHIP_GBG_TAG_BG_COLOR}"
  [[ -n "${SPACESHIP_GBG_TAG_FG_COLOR}" ]] && fg_color="%F{${SPACESHIP_GBG_TAG_FG_COLOR}}" || fg_color="%f"
  [[ -n "${SPACESHIP_GBG_TAG_BG_COLOR}" ]] && bg_color="%K{${SPACESHIP_GBG_TAG_BG_COLOR}}" || bg_color="%k"

  l_section_out="%{${bg_color}${fg_color}%} " # Set colors

  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
      "${gbg_head_is_on_tag:-}" "$(\
        lf_spaceship_gbg_get_symbol \
          "${SPACESHIP_GBG_TAG_SYMBOLS}" \
          tag) ${gbg_head_tag:-}"\
    )"

  l_section_out="${l_section_out} %{%f%k%}"

  printf '%s' "${l_section_out}"
  unset l_section_out
  SPACESHIP_GBG_LAST_BG_COLOR="${SPACESHIP_GBG_TAG_BG_COLOR}"
}

