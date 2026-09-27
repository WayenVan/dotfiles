alias ls='eza'
alias ll='eza -l --icons=auto'

page() {
  if [ "$#" -eq 0 ]; then
    printf '%s\n' 'usage: page COMMAND [ARGS...]' >&2
    return 2
  fi
  env -u NO_COLOR CLICOLOR_FORCE=1 "$@" | less -R
}
