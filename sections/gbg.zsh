#
# Gbg
# God Bless Git
#

SPACESHIP_GBG_ROOT="${SPACESHIP_ROOT}/sections/gbg/"

. "${SPACESHIP_GBG_ROOT}utils.zsh"

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GBG_SHOW=${SPACESHIP_GBG_SHOW:-true}
SPACESHIP_GBG_PREFIX="${SPACESHIP_GBG_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_GBG_SUFFIX="${SPACESHIP_GBG_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX\n"}"
SPACESHIP_GBG_SEPARATOR_SYMBOL=${SPACESHIP_GBG_SEPARATOR_SYMBOL:-"$(echo "${powerline_left_hard_divider:-▓▒░} ")"}

#SPACESHIP_GBG_ORDER="${SPACESHIP_GBG_ORDER:-"repo:local:index:remote:tag"}"
SPACESHIP_GBG_ORDER="${SPACESHIP_GBG_ORDER:-"repo:local:index"}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

for spaceship_gbg_section in $(echo ${SPACESHIP_GBG_ORDER} | tr ':' ' '); do
  . "${SPACESHIP_GBG_ROOT}${spaceship_gbg_section}.zsh"
done


# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_gbg() {
  # If SPACESHIP_GBG_SHOW is false, don't show gbg section
  [[ $SPACESHIP_GBG_SHOW == false ]] && return

  # Check if GBG command is available for execution
  spaceship::exists god_bless_git || return

  god_bless_git

  # Exit section if variable is empty
  [[ "$gbg_is_a_git_repo" != "true" ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_GBG_PREFIX" \
    "" \
    ""

  for spaceship_gbg_section in $(echo ${SPACESHIP_GBG_ORDER} | tr ':' ' '); do
    spaceship_gbg_${spaceship_gbg_section}
  done
  lf_spaceship_gbg_close_segment

  spaceship::section \
    'white' \
    "" \
    "" \
    "$SPACESHIP_GBG_SUFFIX"
  unset SPACESHIP_GBG_LAST_BG_COLOR
}
