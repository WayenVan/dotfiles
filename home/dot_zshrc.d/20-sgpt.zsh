if command -v sgpt >/dev/null 2>&1; then
  export OPENAI_API_KEY="$DEEPSEEK_API_KEY"
  # sgpt defaults its caches to /tmp/cache and /tmp/chat_cache, which break on
  # shared hosts once another user owns them. .sgptrc can't expand `~`, but env
  # vars take priority over it, so set per-user paths here.
  export CACHE_PATH=~/.cache/shell_gpt/cache
  export CHAT_CACHE_PATH=~/.cache/shell_gpt/chat_cache

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
