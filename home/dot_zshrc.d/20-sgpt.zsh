if command -v sgpt >/dev/null 2>&1; then
  export OPENAI_API_KEY="$DEEPSEEK_API_KEY"

  # No quoting needed: `ai 写一段关于秋天的诗` joins all words into one prompt.
  ai() {
    sgpt "$*"
  }

  _sgpt_zsh() {
    if [[ -n "$BUFFER" ]]; then
      _sgpt_prev_cmd=$BUFFER
      BUFFER+="⌛"
      zle -I && zle redisplay
      BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
      zle end-of-line
    fi
  }
  zle -N _sgpt_zsh
  # ^L is left alone (default clear-screen); using ^X^G instead.
  bindkey "^X^G" _sgpt_zsh
fi
