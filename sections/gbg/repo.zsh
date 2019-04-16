
# git repo infos
spaceship_gbg_repo() {
  l_section_out=""
  l_section_out="${l_section_out}$(\
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

  printf '%s' "${l_section_out}"
}

spaceship_gbg_init_repo_symbols() {
    if [ -e "$HOME/.local/share/icons-in-terminal/icons_bash.sh" ]; then
        debug "Loading icons in terminal"
        #shellcheck disable=1090
        . "$HOME/.local/share/icons-in-terminal/icons_bash.sh"
    else
        warning "GBG prompt heavily relies on icons-in-terminal"
        warning "Please see https://github.com/sebastiencs/icons-in-terminal/"
    fi
    l_spaceship_gbg_tmp=""
    for l_symbol in \
        "is_a_git_repo: ${oct_octoface:-git}    " \
        "has_stashes:${fa_asterisk:-stash} "; do
        l_spaceship_gbg_tmp="$(\
            printf '%s%s\036' \
            "${l_spaceship_gbg_tmp}" \
            "${l_symbol}")"
    done
    echo "${l_spaceship_gbg_tmp}"
    unset l_spaceship_gbg_tmp l_symbol
}
