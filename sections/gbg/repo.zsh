#
# God bless git
# Repository informations
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GBG_REPO_NAME_SHOW="${SPACESHIP_GBG_REPO_NAME_SHOW:-true}"
SPACESHIP_GBG_REPO_MAIN_SYMBOL="${SPACESHIP_GBG_REPO_MAIN_SYMBOL:-" ${oct_octoface:-git} "}"
SPACESHIP_GBG_REPO_STASH_SYMBOL="${SPACESHIP_GBG_REPO_STASH_SYMBOL:-"${fa_asterisk:-stash} "}"
SPACESHIP_GBG_REPO_BG_COLOR="${SPACESHIP_GBG_REPO_BG_COLOR:-white}"
SPACESHIP_GBG_REPO_FG_COLOR="${SPACESHIP_GBG_REPO_FG_COLOR:-black}"

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

spaceship_gbg_repo_init_symbols() {
    l_spaceship_gbg_tmp=""
    for l_symbol in \
        "is_a_git_repo:${SPACESHIP_GBG_REPO_MAIN_SYMBOL}" \
        "has_stashes:${SPACESHIP_GBG_REPO_STASH_SYMBOL}"; do
        l_spaceship_gbg_tmp="$(\
            printf '%s%s\036' \
            "${l_spaceship_gbg_tmp}" \
            "${l_symbol}")"
    done
    echo "${l_spaceship_gbg_tmp}"
    unset l_spaceship_gbg_tmp l_symbol
}
SPACESHIP_GBG_REPO_SYMBOLS="$(spaceship_gbg_repo_init_symbols)\\n"

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

spaceship_gbg_repo() {
  [[ -n "${SPACESHIP_GBG_LAST_BG_COLOR}" ]] && lf_spaceship_gbg_close_segment "${SPACESHIP_GBG_REPO_BG_COLOR}"
  [[ -n "${SPACESHIP_GBG_REPO_FG_COLOR}" ]] && fg_color="%F{${SPACESHIP_GBG_REPO_FG_COLOR}}" || fg_color="%f"
  [[ -n "${SPACESHIP_GBG_REPO_BG_COLOR}" ]] && bg_color="%K{${SPACESHIP_GBG_REPO_BG_COLOR}}" || bg_color="%k"

  l_section_out="%{${bg_color}${fg_color}%}" # Set colors

  l_section_out="${l_section_out} $(\
    basename "${gbg_repo_top_level:-}"\
    )"
  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_get_symbol \
      "${SPACESHIP_GBG_REPO_SYMBOLS}" \
      is_a_git_repo \
    )"

  l_section_out="${l_section_out}$(\
    lf_spaceship_gbg_enrich_append \
    "${gbg_repo_has_stashes:-}" "$(\
      lf_spaceship_gbg_get_symbol \
        "${SPACESHIP_GBG_REPO_SYMBOLS}" \
        has_stashes)"\
    )"

  l_section_out="${l_section_out}%{%f%k%}"

  printf '%s' "${l_section_out}"
  unset l_section_out
  SPACESHIP_GBG_LAST_BG_COLOR="${SPACESHIP_GBG_REPO_BG_COLOR}"
}

